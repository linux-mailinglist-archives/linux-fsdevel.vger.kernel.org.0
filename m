Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2156203A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiF3QYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiF3QYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E0E31907;
        Thu, 30 Jun 2022 09:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B796201C;
        Thu, 30 Jun 2022 16:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD74C34115;
        Thu, 30 Jun 2022 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656606259;
        bh=Kyao6ux2Oi0CPubvRIyv034ggKSZ0VAhBLxea5f0PrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeaGOmnO48BqYna0op41w17dtYjRdzYVWNsmVE6RYGcn6VShmcr0NvScCL5iIgmn/
         Wdpy1QqTitoI5SnpcasINYERq9fdXtRxBF7hvePGkVMuxVuLP+bhLJzgvfff4nKyVp
         hFo2v4cxptJt5zr3F12OkanQP6vgPGuPD9bIO+1e46Ol5mUHRtfMH5ZS6LqWoGziMQ
         LjIZD087NiD8ShiN44aWCXEdtXctDYBfa7hYyH7XuY2isQW4OEW2RH8ryenKG2vB4U
         FepVqO2g8i9vrucY8Jznu9Ou6pI8XMaLV3TgZ/YQvj0oYqEcKbPEvUfgMxCY2JbVtr
         27mUqo4fntUCg==
Date:   Thu, 30 Jun 2022 10:24:14 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, agk@redhat.com, song@kernel.org,
        djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 2/6] nvme: add support for the Verify command
Message-ID: <Yr3OLiEd+/6wryCx@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-3-kch@nvidia.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:14:02AM -0700, Chaitanya Kulkarni wrote:
> Allow verify operations (REQ_OP_VERIFY) on the block device, if the
> device supports optional command bit set for verify. Add support
> to setup verify command. Set maximum possible verify sectors in one
> verify command according to maximum hardware sectors supported by the
> controller.

Shouldn't the limit be determined by Identify Controller NVM CSS's 'VSL' field
instead of its max data transfer?
