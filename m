Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8197341CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjFQPFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFQPFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5610C0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 08:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4F26093C
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 15:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0A8C433C8;
        Sat, 17 Jun 2023 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687014330;
        bh=zndg0NjmkIHkhnnfvUPhrOEhL3aJ2luavtWBpDGvUmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZn3+He1HwlEzBNwLcjbYTr+ry1ofZpScVeo0Dir2yRClp6nCJ8UBaemWhscw9PuL
         8+TuJ+qd5g0oDyeLf7j9clsSqpDaR2chAQCpULbZksp5GknUs3no3nixPgmdcKP+4F
         hDRapaOusKNOyGJvXq9XogEmRzmLtI2pCUGr7XwbnWZDYtwiRtm+wu1jSds7FYOjxo
         dhy5Vec12hRzXkoVKyX4P9vbOAlnWeQooIPh1OXNAJIXyF4yn2WXAu14N4az9R/PWk
         eNdsm/hoJsGJI2+1fXsjLlGv1kMIt37vtjm49Yjo08p9FvnEOU/3i2A8rX0pXm+5/3
         pmBRuLpWIVV+w==
Date:   Sat, 17 Jun 2023 17:05:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <20230617-hitze-weingut-17034408ebc2@brauner>
References: <20230616163827.19377-1-jack@suse.cz>
 <ZIzxVvLgukjBOBBW@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIzxVvLgukjBOBBW@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:33:42AM +1000, Dave Chinner wrote:
> On Fri, Jun 16, 2023 at 06:38:27PM +0200, Jan Kara wrote:
> > Provide helpers to set and clear sb->s_readonly_remount including
> > appropriate memory barriers. Also use this opportunity to document what
> > the barriers pair with and why they are needed.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> The helper conversion looks fine so from that perspective the patch
> looks good.
> 
> However, I'm not sure the use of memory barriers is correct, though.
> 
> IIUC, we want mnt_is_readonly() to return true when ever
> s_readonly_remount is set. Is that the behaviour we are trying to
> acheive for both ro->rw and rw->ro transactions?
> 
> > ---
> >  fs/internal.h      | 26 ++++++++++++++++++++++++++
> >  fs/namespace.c     | 10 ++++------
> >  fs/super.c         | 17 ++++++-----------
> >  include/linux/fs.h |  2 +-
> >  4 files changed, 37 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/internal.h b/fs/internal.h
> > index bd3b2810a36b..01bff3f6db79 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -120,6 +120,32 @@ void put_super(struct super_block *sb);
> >  extern bool mount_capable(struct fs_context *);
> >  int sb_init_dio_done_wq(struct super_block *sb);
> >  
> > +/*
> > + * Prepare superblock for changing its read-only state (i.e., either remount
> > + * read-write superblock read-only or vice versa). After this function returns
> > + * mnt_is_readonly() will return true for any mount of the superblock if its
> > + * caller is able to observe any changes done by the remount. This holds until
> > + * sb_end_ro_state_change() is called.
> > + */
> > +static inline void sb_start_ro_state_change(struct super_block *sb)
> > +{
> > +	WRITE_ONCE(sb->s_readonly_remount, 1);
> > +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> > +	smp_wmb();
> > +}
> 
> I'm not sure how this wmb pairs with the memory barrier in
> mnt_is_readonly() to provide the correct behavior. The barrier in
> mnt_is_readonly() happens after it checks s_readonly_remount, so
> the s_readonly_remount in mnt_is_readonly is not ordered in any way
> against this barrier.
> 
> The barrier in mnt_is_readonly() ensures that the loads of SB_RDONLY
> and MNT_READONLY are ordered after s_readonly_remount(), but we
> don't change those flags until a long way after s_readonly_remount
> is set.
> 
> Hence if this is a ro->rw transistion, then I can see that racing on
> s_readonly_remount being isn't an issue, because the mount/sb
> flags will have SB_RDONLY/MNT_READONLY set and the correct thing
> will be done (i.e. consider code between sb_start_ro_state_change()
> and sb_end_ro_state_change() is RO).
> 
> However, it's not obvious (to me, anyway) how this works at all for
> a rw->ro transition - if we race on s_readonly_remount being set
> then we'll consider the fs to still be read-write regardless of the
> smp_rmb() in mnt_is_readonly() because neither SB_RDONLY or
> MNT_READONLY are set at this point.

Let me try and remember it all. I've documented a good portion of this
in the relevant functions but I should probably upstream some more
longer documentation blurb as well.

A rw->ro transition happen in two ways.

(1) A mount or mount tree is made read-only via
    mount_setattr(MNT_ATTR_READONLY) or
    mount(MS_BIND|MS_RDONLY|MS_REMOUNT).
(2) The filesystems/superblock is made read-only via fspick()+fsconfig()
    or mount(MS_REMOUNT|MS_RDONLY).

For both (1) and (2) we grab lock_mount_hash() in relevant codepaths
(because that's required for any vfsmount->mnt_flags changes) and then
call mnt_hold_writers().

mnt_hold_writers() will first raise MNT_WRITE_HOLD in @mnt->mnt_flags
before checking the write counter of that mount to see whether there are
any active writers on that mount. If there are any active writers we'll
fail mnt_hold_writers() and the whole rw->ro transition.

A memory barrier is used to order raising MNT_WRITE_HOLD against the
increment of the write counter of that mount in __mnt_want_write().
If __mnt_want_write() detects that MNT_WRITE_HOLD has been set after
it incremented the write counter it will spin until MNT_WRITE_HOLD is
cleared via mnt_unhold_writers(). This uses another memory barrier to
ensure ordering with the mnt_is_readonly() check in __mnt_want_write().

__mnt_want_write() doesn't know about the ro/rw state of the mount at
all until MNT_WRITE_HOLD has cleared. Then it calls mnt_is_readonly().

If the mount did indeed transition from rw->ro after MNT_WRITE_HOLD was
cleared __mnt_want_write() will back off. If not write access to the
mount is granted.

A superblock rw->ro transition is done the same way. It also requires
mnt_hold_writers() to be done. This is done in
sb_prepare_remount_readonly() which is called in reconfigure_super().

Only after mnt_hold_writers() has been raised successfully on every
mount of that filesystem (i.e., all bind mounts) will
sb->s_readonly_remount be set. After MNT_WRITE_HOLD is cleared and
mnt_is_readonly() is called sb->s_readonly_remount is guaranteed to be
visible or MNT_READONLY or SB_RDONLY are visible. The memory barrier in
sb->s_readonly_remount orders it against reading sb->s_flags. It doesn't
protect/order the rw->ro transition itself.

(The only exception is an emergency read-only remount where we don't
know what state the fs is in and don't care for any active writers on
that superblock so omit wading through all the mounts of that
filesystem. But that's only doable from withing the kernel via
SB_FORCE.)

Provided I understand your question/concern correctly.
