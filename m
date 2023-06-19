Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0AB735578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjFSLGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjFSLGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:06:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A81994
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 04:05:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C88E21882;
        Mon, 19 Jun 2023 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687172726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c483tDdmEK5CSFcDVqvx7q20L8NDRWnSvLOzUmp1YJo=;
        b=CSUA8Erdyas+uwl9z0HzYYCymLndqwmVB/9PCk/WeHRTcXsHYBfXetujw1tdGw+Cqj7ytr
        FDlZBOqiFEv6F3udgaZtu9aBNEBmCLUMkg2TVC7YWVqzrm7Y8fB91/eIlh73Xh2uMhblVe
        iHJH5YoAOKLHX1IKy9sj4Mnp1IUD448=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687172726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c483tDdmEK5CSFcDVqvx7q20L8NDRWnSvLOzUmp1YJo=;
        b=Uzj5+w1Oz3LmNwgLV/QfMpxM3tNZ1gkvsEYjKpq8EgA1XuSnO54Tniwpgw7hk3ohy6M8vA
        zc7exbn1ntq6bvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F503139C2;
        Mon, 19 Jun 2023 11:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qesdG3Y2kGRKUQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Jun 2023 11:05:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 097C2A0755; Mon, 19 Jun 2023 13:05:26 +0200 (CEST)
Date:   Mon, 19 Jun 2023 13:05:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <20230619110526.3tothvlcww6cgfup@quack3>
References: <20230616163827.19377-1-jack@suse.cz>
 <ZIzxVvLgukjBOBBW@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIzxVvLgukjBOBBW@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 17-06-23 09:33:42, Dave Chinner wrote:
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

AFAICS, the barriers are correct but my documentation was not ;)
Christian's reply has all the details but maybe let me attempt a bit more
targetted reply here.

> IIUC, we want mnt_is_readonly() to return true when ever
> s_readonly_remount is set. Is that the behaviour we are trying to
> acheive for both ro->rw and rw->ro transactions?

Yes. But what matters is the ordering of s_readonly_remount checking wrt
other flags. See below.

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

You are correct. I've reread the code and the ordering that matters is
__mnt_want_write() on the read side and reconfigure_super() on the write
side. In particular for RW->RO transition we must make sure that: If
__mnt_want_write() does not see MNT_WRITE_HOLD set, it will see
s_readonly_remount set. There is another set of barriers in those functions
that makes sure sb_prepare_remount_readonly() sees incremented mnt_writers
if __mnt_want_write() did not see MNT_WRITE_HOLD set, but that's a
different story.

Hence the barrier in sb_start_ro_state_change() pairs with smp_rmb()
barrier in __mnt_want_write() before the mnt_is_readonly() check at the end
of the function. I'll fix my patch, thanks for correction.

> Hence if this is a ro->rw transistion, then I can see that racing on
> s_readonly_remount being isn't an issue, because the mount/sb
> flags will have SB_RDONLY/MNT_READONLY set and the correct thing
> will be done (i.e. consider code between sb_start_ro_state_change()
> and sb_end_ro_state_change() is RO).

Yes, for the RO->RW the barrier in sb_prepare_remount_readonly() indeed
pairs with the barrier in mnt_is_readonly(). It makes sure that if
mnt_is_readonly() observes s_readonly_remount == 0, it will observe
SB_RDONLY / MNT_READONLY still set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
