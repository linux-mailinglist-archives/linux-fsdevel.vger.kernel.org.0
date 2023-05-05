Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F36F8C41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEEWKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEEWKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48D2723;
        Fri,  5 May 2023 15:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987DB6411F;
        Fri,  5 May 2023 22:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B7C433EF;
        Fri,  5 May 2023 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683324649;
        bh=k6oMc0o9wbKE3MMyK5Z0jVFz6s5S3LZAMgBD25Npdew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1xy3ZEqtX7AjkfWmtzEaUO3L0PrSeHA63SSFHopVTw+bkamc3KH6AFOtMTEQrQIi
         Ch4gCMX3UMDxIatxR+5AOk7ZdANA+CRiByOZq+lUlNShjej/To9Z/zWISpEahN8mFc
         fvRSeEUaD07OwqvKAvqWoWY84Qg51kCXh+DOaC5ufw6MtznuKcjn4dkG3VQW9nLj8e
         e/m5qrU/NsqSZTnTPzGPWkd60jaXoIrueA5R11g/RM8fMFvnBpLoHDoldoQrVRleRL
         B8QXGobhn8rAMthGTTyY9MwtiPoBjiRB5OgGxkg3/LLt96m+s4hSK3eI7W2qFkvC9F
         6j4lCfSx5W3wQ==
Date:   Fri, 5 May 2023 15:10:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 03/16] xfs: Support atomic write for statx
Message-ID: <20230505221048.GL15394@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-4-john.g.garry@oracle.com>
 <20230503221749.GF3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503221749.GF3223426@dread.disaster.area>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 08:17:49AM +1000, Dave Chinner wrote:
> On Wed, May 03, 2023 at 06:38:08PM +0000, John Garry wrote:
> > Support providing info on atomic write unit min and max.
> > 
> > Darrick Wong originally authored this change.
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/xfs_iops.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 24718adb3c16..e542077704aa 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -614,6 +614,16 @@ xfs_vn_getattr(
> >  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> >  			stat->dio_offset_align = bdev_logical_block_size(bdev);
> >  		}
> > +		if (request_mask & STATX_WRITE_ATOMIC) {
> > +			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > +			struct block_device	*bdev = target->bt_bdev;
> > +
> > +			stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
> > +			stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);
> 
> I'm not sure this is right.
> 
> Given that we may have a 4kB physical sector device, XFS will not
> allow IOs smaller than physical sector size. The initial values of
> queue_atomic_write_unit_min/max() will be (1 << SECTOR_SIZE) which
> is 512 bytes. IOs done with 4kB sector size devices will fail in
> this case.
> 
> Further, XFS has a software sector size - it can define the sector
> size for the filesystem to be 4KB on a 512 byte sector device. And
> in that case, the filesystem will reject 512 byte sized/aligned IOs
> as they are smaller than the filesystem sector size (i.e. a config
> that prevents sub-physical sector IO for 512 logical/4kB physical
> devices).

Yep.  I'd forgotten about those.

> There may other filesystem constraints - realtime devices have fixed
> minimum allocation sizes which may be larger than atomic write
> limits, which means that IO completion needs to split extents into
> multiple unwritten/written extents, extent size hints might be in
> use meaning we have different allocation alignment constraints to
> atomic write constraints, stripe alignment of extent allocation may
> through out atomic write alignment, etc.
> 
> These are all solvable, but we need to make sure here that the
> filesystem constraints are taken into account here, not just the
> block device limits.
> 
> As such, it is probably better to query these limits at filesystem
> mount time and add them to the xfs buftarg (same as we do for
> logical and physical sector sizes) and then use the xfs buftarg

I'm not sure that's right either.  device mapper can switch the
underlying storage out from under us, yes?  That would be a dirty thing
to do in my book, but I've long wondered if we need to be more resilient
to that kind of evilness.

> values rather than having to go all the way to the device queue
> here. That way we can ensure at mount time that atomic write limits
> don't conflict with logical/physical IO limits, and we can further
> constrain atomic limits during mount without always having to
> recalculate those limits from first principles on every stat()
> call...

With Christoph's recent patchset to allow block devices to call back
into filesystems, we could add one for "device queue limits changed"
that would cause recomputation of those elements, solving what I was
just mumbling about above.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
