Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727FF72CD8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjFLSKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjFLSJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9AE63;
        Mon, 12 Jun 2023 11:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA75624DE;
        Mon, 12 Jun 2023 18:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50F8C433EF;
        Mon, 12 Jun 2023 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686593385;
        bh=/qiCGHFDPxPyeSHCMQOEHj9LTJLEmBdBe+GUCPD2vSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgjVgSr7YvHSgnfD9cnBi9cR6NswE2hhSUMP5ELnMAxbA0Ip0obQ8gEhyqRwBUKk+
         5WX1lZp8Gc0BldcLZ3Xlbr7UZzHd4NeNsKE9+Uqnk6TbTV7fUgOAbN75jodfnzWdJC
         0RXa0IH+EVp00wwkDdzS+nRwzU6vhv/5YTeLaE6jmXUlYTm0xCo0D30EWWZCzS8B0z
         +5k7BhNVWdN7LMgBLtoLKALkRieUWWTPAmj0q1i9jS+eOa++zk1GHHxxoXeUuNFo7M
         nOjfvQ7t1/zcGCvC9ljdUr1eSLwey1ZFroqYvdv+7JrWV89sFQoYQpRAzzWVPOlffe
         F2Jjty2efUASw==
Date:   Mon, 12 Jun 2023 11:09:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mcgrof@kernel.org, jack@suse.cz, ruansy.fnst@fujitsu.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230612180945.GF11441@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972267.755178.18328538743442432037.stgit@frogsfrogsfrogs>
 <ZIaX8Lz2cnyD+s5R@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIaX8Lz2cnyD+s5R@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:58:40PM -0700, Christoph Hellwig wrote:
> On Sun, Jun 11, 2023 at 08:15:22PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> > suspending the block device; this state persists until userspace thaws
> > the filesystem with the FITHAW ioctl or resuming the block device.
> > Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> > the fsfreeze ioctl") we only allow the first freeze command to succeed.
> > 
> > The kernel may decide that it is necessary to freeze a filesystem for
> > its own internal purposes, such as suspends in progress, filesystem fsck
> > activities, or quiescing a device prior to removal.  Userspace thaw
> > commands must never break a kernel freeze, and kernel thaw commands
> > shouldn't undo userspace's freeze command.
> > 
> > Introduce a couple of freeze holder flags and wire it into the
> > sb_writers state.  One kernel and one userspace freeze are allowed to
> > coexist at the same time; the filesystem will not thaw until both are
> > lifted.
> > 
> > I wonder if the f2fs/gfs2 code should be using a kernel freeze here, but
> > for now we'll use FREEZE_HOLDER_USERSPACE to preserve existing
> > behaviors.
> > 
> > Cc: mcgrof@kernel.org
> > Cc: jack@suse.cz
> > Cc: hch@infradead.org
> > Cc: ruansy.fnst@fujitsu.com
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  Documentation/filesystems/vfs.rst |    4 +-
> >  block/bdev.c                      |    8 ++--
> >  fs/f2fs/gc.c                      |    4 +-
> >  fs/gfs2/glops.c                   |    2 -
> >  fs/gfs2/super.c                   |    6 +--
> >  fs/gfs2/sys.c                     |    4 +-
> >  fs/gfs2/util.c                    |    2 -
> >  fs/ioctl.c                        |    8 ++--
> >  fs/super.c                        |   79 +++++++++++++++++++++++++++++++++----
> >  include/linux/fs.h                |   15 +++++--
> >  10 files changed, 100 insertions(+), 32 deletions(-)
> > 
> > 
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > index 769be5230210..41cf2a56cbca 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -260,9 +260,9 @@ filesystem.  The following members are defined:
> >  		void (*evict_inode) (struct inode *);
> >  		void (*put_super) (struct super_block *);
> >  		int (*sync_fs)(struct super_block *sb, int wait);
> > -		int (*freeze_super) (struct super_block *);
> > +		int (*freeze_super) (struct super_block *, enum freeze_holder who);
> >  		int (*freeze_fs) (struct super_block *);
> > -		int (*thaw_super) (struct super_block *);
> > +		int (*thaw_super) (struct super_block *, enum freeze_wholder who);
> 
> Nit: Can you spell out the sb paramter as well and avoid the overly long
> lines here?

Done.

> > +static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
> > +{
> > +	/* Someone else already holds this type of freeze */
> > +	if (sb->s_writers.freeze_holders & who)
> > +		return -EBUSY;
> > +
> > +	WARN_ON(sb->s_writers.freeze_holders == 0);
> > +
> > +	sb->s_writers.freeze_holders |= who;
> > +	return 0;
> > +}
> 
> So with the simplification I'm not even sure we need this helper
> anymore.  But I could live with it either way.

Ok, gone.  It makes the code flow rather easier to understand,
especially given Jan's reply asking for a shared freeze to leave
s_active elevated by 2.

> >  /**
> >   * freeze_super - lock the filesystem and force it into a consistent state
> >   * @sb: the super to lock
> > + * @who: FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
> > + * FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
> 
> I think the cnonstants should use a % prefix for kerneldoc to notice
> them.  Also I suspect something like:
> 
>  * @who: context that wants to free
> 
>  and then in the body:
> 
>  * @who should be:
>  *  * %FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs
>  *  * %FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
> 
> for better rendering of the comments.  Same applies for the thaw side.

Done.  Thanks for the kerneldoc, I can never keep rst and kerneldoc
straight anymore.

> > +static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
> >  {
> >  	int error;
> >  
> > +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> > +		error = try_thaw_shared_super(sb, who);
> > +		if (error != 1) {
> > +			up_write(&sb->s_umount);
> > +			return error;
> > +		}
> > +	}
> > +
> >  	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> 
> Make this and
> 
> 	} else {
> 
> instead of checking the same condition twice?

Ok.

> > +extern int freeze_super(struct super_block *super, enum freeze_holder who);
> > +extern int thaw_super(struct super_block *super, enum freeze_holder who);
> 
> .. and drop the pointless externs here.

Ok done.

> Except for these various nitpicks this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

--D

