Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768D735FFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFSXLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFSXLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668FE74
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:11:26 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39cf00a2ad2so2758904b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687216285; x=1689808285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=He0M5tbiylj/ivJ4kZYm4Ck9xXM1l0Kgsm3CTyxuh9E=;
        b=ZZGkNxeH9Jik6ff7ovuT6NZEkom3DVE5oF8Y4ageSkOT2t5Ik1gXpxmm3VhlE1p3+s
         skpYRxgghPDjI0Euv6YZXnxG+z+R4NlSNbYnyRipR2vQh/e1tGFyVOq/HBZSTjfJhYiB
         +Q09qTNHwnNsFYIbO1HYzUVVOXhll1r+J95NrylOtw6xv85/LIV9VYo5Jhr5uRPWyWqG
         7FinGVMuS4me302ijjJ32cokt4SOjaIoGujk1lW4fCQe/hd2FlZKDqG2AHTvfHQpUqCO
         1n99aLRE87J6HT6Ed2GJQt1V/3ftHlgfvyA6deIUshQx12kfVKUC2d6qPn0G9HDw0FY2
         3Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216285; x=1689808285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He0M5tbiylj/ivJ4kZYm4Ck9xXM1l0Kgsm3CTyxuh9E=;
        b=YbsaHe8BBjmEQRR8Ktph7/uP1jI362MtIsVwm7cbMYzV83gVhSHOiwgWUPiI1OhRiK
         GcDgqh+tKRJrt+WeAIZ3WKm5scdmWYXwxZSyzdeba/czdXDLjqd6WmnQt/VRkU7m0knS
         xfvQ2TV/cYRmuQauIVYdYt7NT6e1+Ewi+XJbv8DHnbFWzgkb4Ozt4D0ele8BOsGF/vcs
         hR5VNmWAtrPLs3ol69GhEvscds9rOQKRAtwGd906UKoaTtgYFpP9gdUKuTCE1HGv9SY9
         1KqWptiEyGvNudMH9GnUuNHznzH04ri+7tO9zCjbk3+o2vI2Tqe8aUppa1gc9F3y6W3s
         E2Rw==
X-Gm-Message-State: AC+VfDyWbp7LOUaRXdtJix6WD1JpvOxdL1xLqgJS2R9zRQkGR38SYSHw
        +2K/vqPWSKIx6140QxhYB/rpDQ==
X-Google-Smtp-Source: ACHHUZ6MxtRxI1prRaOYuCcg+Rj71y/z44kykNUuDfuMUFwBG8VjQGb+AC26xcjfENqmG2tqUw9Y6Q==
X-Received: by 2002:aca:171a:0:b0:39f:a821:df95 with SMTP id j26-20020aca171a000000b0039fa821df95mr2381691oii.55.1687216285250;
        Mon, 19 Jun 2023 16:11:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b0024749e7321bsm303854pjw.6.2023.06.19.16.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:11:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBO1o-00DpYd-2b;
        Tue, 20 Jun 2023 09:11:20 +1000
Date:   Tue, 20 Jun 2023 09:11:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <ZJDgmDuoeSwinR27@dread.disaster.area>
References: <20230616163827.19377-1-jack@suse.cz>
 <ZIzxVvLgukjBOBBW@dread.disaster.area>
 <20230617-hitze-weingut-17034408ebc2@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617-hitze-weingut-17034408ebc2@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 05:05:25PM +0200, Christian Brauner wrote:
> On Sat, Jun 17, 2023 at 09:33:42AM +1000, Dave Chinner wrote:
> > On Fri, Jun 16, 2023 at 06:38:27PM +0200, Jan Kara wrote:
> > > Provide helpers to set and clear sb->s_readonly_remount including
> > > appropriate memory barriers. Also use this opportunity to document what
> > > the barriers pair with and why they are needed.
> > > 
> > > Suggested-by: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > The helper conversion looks fine so from that perspective the patch
> > looks good.
> > 
> > However, I'm not sure the use of memory barriers is correct, though.
> > 
> > IIUC, we want mnt_is_readonly() to return true when ever
> > s_readonly_remount is set. Is that the behaviour we are trying to
> > acheive for both ro->rw and rw->ro transactions?
> > 
> > > ---
> > >  fs/internal.h      | 26 ++++++++++++++++++++++++++
> > >  fs/namespace.c     | 10 ++++------
> > >  fs/super.c         | 17 ++++++-----------
> > >  include/linux/fs.h |  2 +-
> > >  4 files changed, 37 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/internal.h b/fs/internal.h
> > > index bd3b2810a36b..01bff3f6db79 100644
> > > --- a/fs/internal.h
> > > +++ b/fs/internal.h
> > > @@ -120,6 +120,32 @@ void put_super(struct super_block *sb);
> > >  extern bool mount_capable(struct fs_context *);
> > >  int sb_init_dio_done_wq(struct super_block *sb);
> > >  
> > > +/*
> > > + * Prepare superblock for changing its read-only state (i.e., either remount
> > > + * read-write superblock read-only or vice versa). After this function returns
> > > + * mnt_is_readonly() will return true for any mount of the superblock if its
> > > + * caller is able to observe any changes done by the remount. This holds until
> > > + * sb_end_ro_state_change() is called.
> > > + */
> > > +static inline void sb_start_ro_state_change(struct super_block *sb)
> > > +{
> > > +	WRITE_ONCE(sb->s_readonly_remount, 1);
> > > +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> > > +	smp_wmb();
> > > +}
> > 
> > I'm not sure how this wmb pairs with the memory barrier in
> > mnt_is_readonly() to provide the correct behavior. The barrier in
> > mnt_is_readonly() happens after it checks s_readonly_remount, so
> > the s_readonly_remount in mnt_is_readonly is not ordered in any way
> > against this barrier.
> > 
> > The barrier in mnt_is_readonly() ensures that the loads of SB_RDONLY
> > and MNT_READONLY are ordered after s_readonly_remount(), but we
> > don't change those flags until a long way after s_readonly_remount
> > is set.
> > 
> > Hence if this is a ro->rw transistion, then I can see that racing on
> > s_readonly_remount being isn't an issue, because the mount/sb
> > flags will have SB_RDONLY/MNT_READONLY set and the correct thing
> > will be done (i.e. consider code between sb_start_ro_state_change()
> > and sb_end_ro_state_change() is RO).
> > 
> > However, it's not obvious (to me, anyway) how this works at all for
> > a rw->ro transition - if we race on s_readonly_remount being set
> > then we'll consider the fs to still be read-write regardless of the
> > smp_rmb() in mnt_is_readonly() because neither SB_RDONLY or
> > MNT_READONLY are set at this point.
> 
> Let me try and remember it all. I've documented a good portion of this
> in the relevant functions but I should probably upstream some more
> longer documentation blurb as well.
> 
> A rw->ro transition happen in two ways.
> 
> (1) A mount or mount tree is made read-only via
>     mount_setattr(MNT_ATTR_READONLY) or
>     mount(MS_BIND|MS_RDONLY|MS_REMOUNT).
> (2) The filesystems/superblock is made read-only via fspick()+fsconfig()
>     or mount(MS_REMOUNT|MS_RDONLY).
> 
> For both (1) and (2) we grab lock_mount_hash() in relevant codepaths
> (because that's required for any vfsmount->mnt_flags changes) and then
> call mnt_hold_writers().
> 
> mnt_hold_writers() will first raise MNT_WRITE_HOLD in @mnt->mnt_flags
> before checking the write counter of that mount to see whether there are
> any active writers on that mount. If there are any active writers we'll
> fail mnt_hold_writers() and the whole rw->ro transition.
> 
> A memory barrier is used to order raising MNT_WRITE_HOLD against the
> increment of the write counter of that mount in __mnt_want_write().
> If __mnt_want_write() detects that MNT_WRITE_HOLD has been set after
> it incremented the write counter it will spin until MNT_WRITE_HOLD is
> cleared via mnt_unhold_writers(). This uses another memory barrier to
> ensure ordering with the mnt_is_readonly() check in __mnt_want_write().
> 
> __mnt_want_write() doesn't know about the ro/rw state of the mount at
> all until MNT_WRITE_HOLD has cleared. Then it calls mnt_is_readonly().
> 
> If the mount did indeed transition from rw->ro after MNT_WRITE_HOLD was
> cleared __mnt_want_write() will back off. If not write access to the
> mount is granted.
> 
> A superblock rw->ro transition is done the same way. It also requires
> mnt_hold_writers() to be done. This is done in
> sb_prepare_remount_readonly() which is called in reconfigure_super().
> 
> Only after mnt_hold_writers() has been raised successfully on every
> mount of that filesystem (i.e., all bind mounts) will
> sb->s_readonly_remount be set. After MNT_WRITE_HOLD is cleared and
> mnt_is_readonly() is called sb->s_readonly_remount is guaranteed to be
> visible or MNT_READONLY or SB_RDONLY are visible. The memory barrier in
> sb->s_readonly_remount orders it against reading sb->s_flags. It doesn't
> protect/order the rw->ro transition itself.
> 
> (The only exception is an emergency read-only remount where we don't
> know what state the fs is in and don't care for any active writers on
> that superblock so omit wading through all the mounts of that
> filesystem. But that's only doable from withing the kernel via
> SB_FORCE.)
> 
> Provided I understand your question/concern correctly.

Thank's for the info, Christian.  Yes, you did understand my
concern: that the memory barriers are poorly and/or incorrectly
documented. :/

Nothing I read in the code around the s_readonly_remount variable or
mnt_is_readonly() indicated that there was any serialisation around
__mnt_want_write() and MNT_WRITE_HOLD. I was completely unable to
make that jump from the code as it was written, or from the patch
that Jan proposed.

Now that I see mnt_hold_writers() and mnt_unhold_writers(), I see
more memory barriers, but I don't see any reference to
sb->s_readonly_remount in that code or the comments. Given that it
appears that these memory barriers are deeply intertwined, I think
that the mnt_[un]hold_writers() helpers also need to have their
documentation updated to indicate how they interact with
s_readonly_remount..

And for sb->s_readonly_remount helpers, some form of the above
explanation also needs to be added, or maybe just a pointer to the
documentation on the mnt_[un]hold_writers() helpers that also
explains how sb->s_readonly_remount factors into the memory barriers
in those helpers...

Cheers,

Dave.


-- 
Dave Chinner
david@fromorbit.com
