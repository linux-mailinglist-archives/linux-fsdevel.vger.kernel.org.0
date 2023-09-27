Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735D7B07F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjI0PSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CEF139
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:18:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6320C433C7;
        Wed, 27 Sep 2023 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827900;
        bh=9V+ZjbHlpDvSIfSMqnUzkb4nC5R5w7KJ6ZjH25fSQ/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gc757YWN39jX45Crs8s1b0kDG13H19FpoTjehnCIjZLuLaEhLT3ITe1FIxt6iSjZw
         RUn61F2CUpYfT3nJWnQAn0Ttlbqe9zc8tvovh0LyluUtnhirr2Yi1o49DdUJleYmjz
         sUcxETEI3yHfiZUEwBkaGKu22T5jFfBSihcpf8AIcAcNm8qYAUVyPgND8jVBxt6X5l
         zW/xm+gP1oMHldTGOKWcy6xhrUons4G/1flkbKcJaF5m76luXCavmQkYdS4ALjIXZb
         MdsOLHdZo+ZOA6VLdFuvQe92++diOigMIEURgGmS0Qc9iPdSqBGkYKo4wErPZTnQwq
         cErXgk+cYA3qg==
Date:   Wed, 27 Sep 2023 17:18:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] super: remove bd_fsfreeze_{mutex,sb}
Message-ID: <20230927-erklangen-geldmangel-499b1d63f9a9@brauner>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
 <20230927151111.GE11414@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927151111.GE11414@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:11:11AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 27, 2023 at 03:21:18PM +0200, Christian Brauner wrote:
> > Both bd_fsfreeze_mutex and bd_fsfreeze_sb are now unused and can be
> > removed. Also move bd_fsfreeze_count down to not have it weirdly placed
> > in the middle of the holder fields.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  block/bdev.c              | 1 -
> >  include/linux/blk_types.h | 7 ++-----
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 3deccd0ffcf2..084855b669f7 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -392,7 +392,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
> >  	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
> >  
> >  	bdev = I_BDEV(inode);
> > -	mutex_init(&bdev->bd_fsfreeze_mutex);
> >  	spin_lock_init(&bdev->bd_size_lock);
> >  	mutex_init(&bdev->bd_holder_lock);
> >  	bdev->bd_partno = partno;
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 88e1848b0869..0238236852b7 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -56,14 +56,11 @@ struct block_device {
> >  	void *			bd_holder;
> 
> Hmmm.  get_bdev_super from patch 3 now requires that bd_holder is a
> pointer to a struct super_block.  AFAICT it's only called in conjunction

Yeah, it's documented in Documentations/filesystems/porting.rst as of
060e6c7d179e ("porting: document superblock as block device holder")
which tries to explain differences between the old and new world in
detail.
