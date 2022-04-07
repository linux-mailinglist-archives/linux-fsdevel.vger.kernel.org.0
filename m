Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00DC4F838A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiDGPdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbiDGPdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:33:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E413B43;
        Thu,  7 Apr 2022 08:31:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34AC9215FE;
        Thu,  7 Apr 2022 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649345459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK52HHYwZ5mydc6ONgZ3weVRrNtBzOOpSIr7pOvXQbs=;
        b=WySqupirn7YZPnIWLV0GfVAqxihpYRle8XEAkyNVF3WBqDMBwi92kUG3G7Geq80fpEpqDG
        ac7ABA9wFAVhQVApAGDNJmbt/DMKsm4fE53BT+WEDXzbauuxegcpY8cjYEPD+30zCAK/0V
        /KcfIrKcEqFeLeaqKdylieoJrRuFiL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649345459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK52HHYwZ5mydc6ONgZ3weVRrNtBzOOpSIr7pOvXQbs=;
        b=dPYi+hdX0iWuGGA7k7dxuydFXSe1+2WyOjXtxXeAslnPVSFPemFb/xuBKsBNhRAOcY4W1X
        dBEDeLvzeSqw+rCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 19364A3B83;
        Thu,  7 Apr 2022 15:30:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6C86DA80E; Thu,  7 Apr 2022 17:26:56 +0200 (CEST)
Date:   Thu, 7 Apr 2022 17:26:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH 26/27] block: uncouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Message-ID: <20220407152656.GM15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406060516.409838-27-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:05:15AM +0200, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c                    |  2 +-
>  block/blk-lib.c                     | 64 ++++++++++++++++++++---------
>  block/blk-mq-debugfs.c              |  1 -
>  block/blk-settings.c                | 16 +++++++-
>  block/fops.c                        |  2 +-
>  block/ioctl.c                       | 43 +++++++++++++++----
>  drivers/block/drbd/drbd_receiver.c  |  5 ++-
>  drivers/block/rnbd/rnbd-clt.c       |  4 +-
>  drivers/block/rnbd/rnbd-srv-dev.h   |  2 +-
>  drivers/block/xen-blkback/blkback.c | 15 +++----
>  drivers/block/xen-blkback/xenbus.c  |  5 +--
>  drivers/block/xen-blkfront.c        |  5 ++-
>  drivers/md/bcache/alloc.c           |  2 +-
>  drivers/md/dm-table.c               |  8 ++--
>  drivers/md/dm-thin.c                |  4 +-
>  drivers/md/md.c                     |  2 +-
>  drivers/md/raid5-cache.c            |  6 +--
>  drivers/mmc/core/queue.c            |  2 +-
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/target/target_core_file.c   |  2 +-
>  drivers/target/target_core_iblock.c |  2 +-

For

>  fs/btrfs/extent-tree.c              |  4 +-

Acked-by: David Sterba <dsterba@suse.com>
