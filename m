Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F52736AFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjFTLbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjFTLbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:31:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C231728
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 04:30:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16F70218B1;
        Tue, 20 Jun 2023 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687260656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPBBupq3aAR0LnJaCdT3ypfb4SDeMIZaDRaCzZVgww8=;
        b=bJpic291JqoA3aMECeKtaU5l/7iNNTZX9nrKPttUSQDuGwRkLDGYqOiKwNWXzv+ui3taIp
        RrN8jDw6UqBWKaEkNUGFuPlhwtiFsklgAP36gFaDOKhypR/wMs6nFsJiCEaB/ltRVIp/md
        TSdgnCcc2aw9F4+E+ehHw44Qis2nKJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687260656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPBBupq3aAR0LnJaCdT3ypfb4SDeMIZaDRaCzZVgww8=;
        b=I4hdUkwKvDuGgb/oeR8xskhJrcQxa/4FAn5+mejHBcMKMYda/hv0j6o3QL5HYPfOkWB/f5
        iizJNfFTzZ5VYtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09DC2133A9;
        Tue, 20 Jun 2023 11:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCFiAvCNkWQSewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 20 Jun 2023 11:30:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9A184A075D; Tue, 20 Jun 2023 13:30:55 +0200 (CEST)
Date:   Tue, 20 Jun 2023 13:30:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <20230620113055.wle3paef4xslnhue@quack3>
References: <20230619111832.3886-1-jack@suse.cz>
 <ZJDj0XjkeVK7AHIx@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJDj0XjkeVK7AHIx@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-06-23 09:25:05, Dave Chinner wrote:
> On Mon, Jun 19, 2023 at 01:18:32PM +0200, Jan Kara wrote:
> > Provide helpers to set and clear sb->s_readonly_remount including
> > appropriate memory barriers. Also use this opportunity to document what
> > the barriers pair with and why they are needed.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/internal.h      | 34 ++++++++++++++++++++++++++++++++++
> >  fs/namespace.c     | 10 ++++------
> >  fs/super.c         | 17 ++++++-----------
> >  include/linux/fs.h |  2 +-
> >  4 files changed, 45 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/internal.h b/fs/internal.h
> > index bd3b2810a36b..e206eb58bd3e 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -120,6 +120,40 @@ void put_super(struct super_block *sb);
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
> > +	/*
> > +	 * For RO->RW transition, the barrier pairs with the barrier in
> > +	 * mnt_is_readonly() making sure if mnt_is_readonly() sees SB_RDONLY
> > +	 * cleared, it will see s_readonly_remount set.
> > +	 * For RW->RO transition, the barrier pairs with the barrier in
> > +	 * __mnt_want_write() before the mnt_is_readonly() check. The barrier
> > +	 * makes sure if __mnt_want_write() sees MNT_WRITE_HOLD already
> > +	 * cleared, it will see s_readonly_remount set.
> > +	 */
> > +	smp_wmb();
> > +}
> 
> Can you please also update mnt_is_readonly/__mnt_want_write to
> indicate that there is a pairing with this helper from those
> functions?

Ok, I've expanded / updated the comments there.

> > +
> > +/*
> > + * Ends section changing read-only state of the superblock. After this function
> > + * returns if mnt_is_readonly() returns false, the caller will be able to
> > + * observe all the changes remount did to the superblock.
> > + */
> > +static inline void sb_end_ro_state_change(struct super_block *sb)
> > +{
> > +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> > +	smp_wmb();
> > +	WRITE_ONCE(sb->s_readonly_remount, 0);
> > +}
> 
> 	/*
> 	 * This barrier provides release semantics that pair with
> 	 * the smp_rmb() acquire semantics in mnt_is_readonly().
> 	 * This barrier pair ensure that when mnt_is_readonly() sees
> 	 * 0 for sb->s_readonly_remount, it will also see all the
> 	 * preceding flag changes that were made during the RO state
> 	 * change.
> 	 */
> 
> And a comment in mnt_is_readonly() to indicate that it also pairs
> with sb_end_ro_state_change() in a different way to the barriers in
> sb_start_ro_state_change(), __mnt_want_write(), MNT_WRITE_HOLD, etc.

Thanks! I've added your comment and expanded more on pairing with
sb_end_ro_state_change().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
