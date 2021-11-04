Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4D445C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhKDWrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 18:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhKDWrm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:47:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34F0561220;
        Thu,  4 Nov 2021 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636065903;
        bh=ULRO/b21e2jF5Il9UheXH6nsdKwZYueNSl7SVt5O9zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUlP9UzxX3fkNEDMeQgJtLu4w9c+qEK9huvXYqqHBTEkI3uCuqX0tLz5RVvdLWyh/
         hZ8PhEBO4htT2iwl68hfYDFMT0oyEA9gelhnZ4O4FxB+iv3cAPiOIZr8G3sshzoooj
         Df8MZwd+A2ohPEGqD8UoQcly2xD1WL9Wyp4vXPhDmviwFLLDhqb68g1n9gqXVHMizl
         dpwXmmfrHcKHvT3m3c8DH0lW0s4UTfcbIw75uZFJSLVW6Y3erFMaBpiAyjTvKeuWhs
         rHGgvZikJbnsNW9oovgkNlETNpgHvyVU3jrmTV6/dRMoC2wTI6ORrvKvxCBKcr888g
         8tVcvq2G9A3rQ==
Date:   Thu, 4 Nov 2021 15:44:59 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, song@kernel.org,
        djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC PATCH 3/8] nvme: add support for the Verify command
Message-ID: <20211104224459.GB2655721@dhcp-10-100-145-180.wdc.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-4-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064634.4481-4-chaitanyak@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:46:29PM -0700, Chaitanya Kulkarni wrote:
> +static inline blk_status_t nvme_setup_verify(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
> +{

Due to recent driver changes, you need a "memset(cmnd, 0, sizeof(*cmnd))"
prior to setting up the rest of the command, or you need to set each
command dword individually.

> +	cmnd->verify.opcode = nvme_cmd_verify;
> +	cmnd->verify.nsid = cpu_to_le32(ns->head->ns_id);
> +	cmnd->verify.slba =
> +		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
> +	cmnd->verify.length =
> +		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> +	cmnd->verify.control = 0;
> +	return BLK_STS_OK;
> +}

> +static void nvme_config_verify(struct gendisk *disk, struct nvme_ns *ns)
> +{
> +	u64 max_blocks;
> +
> +	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_VERIFY))
> +		return;
> +
> +	if (ns->ctrl->max_hw_sectors == UINT_MAX)
> +		max_blocks = (u64)USHRT_MAX + 1;
> +	else
> +		max_blocks = ns->ctrl->max_hw_sectors + 1;

If supported by the controller, this maximum is defined in the non-mdts
command limits in NVM command set specific Identify Controller VSL field.

> +
> +	/* keep same as discard */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_VERIFY, disk->queue))
> +		return;
> +
> +	blk_queue_max_verify_sectors(disk->queue,
> +				     nvme_lba_to_sect(ns, max_blocks));
> +
> +}
