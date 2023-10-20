Return-Path: <linux-fsdevel+bounces-849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99907D1580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111001C20F8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893721363;
	Fri, 20 Oct 2023 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0ijHr2z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpT9ISZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC12032B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 18:09:58 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2CD55;
	Fri, 20 Oct 2023 11:09:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E1791F750;
	Fri, 20 Oct 2023 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697825394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+LlUGJ4p6LVU8CW47o50OSle0+FDDDz35cj2TTIaSE=;
	b=U0ijHr2z9cSLocKOFEH5XNS6/kySV7/UaovynnJ6kQQmQXP7DMfHDrfow6YNGyOfZ0cDaG
	60v7iqO5DKKo4ZEAYNQwCb016R+I9jyaiWFnp14AJx1qDY4cTqeXCPZSaB9zDQkP4eIviB
	a7qPdLwe2lkAaxj9WAfZWUhdGs8NFIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697825394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+LlUGJ4p6LVU8CW47o50OSle0+FDDDz35cj2TTIaSE=;
	b=VpT9ISZzWgpvqNomkfiYyEyQm75WRYtR06NEG7JqbE4te7Fcnq6Zg+M8lB+ot9gPRGojJx
	c6nyQQS4RPf2BCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EF0713584;
	Fri, 20 Oct 2023 18:09:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mlUDG3LCMmUuNAAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 20 Oct 2023 18:09:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDD85A06E3; Fri, 20 Oct 2023 20:09:53 +0200 (CEST)
Date: Fri, 20 Oct 2023 20:09:53 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Baokun Li <libaokun1@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231020180953.wdehmwqoqndk5shq@quack3>
References: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
 <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
 <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri 20-10-23 10:26:26, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 08:12, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > > > --- a/fs/quota/dquot.c
> > > > +++ b/fs/quota/dquot.c
> > > > @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
> > > >  {
> > > >         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
> > > >         if (ret < 0) {
> > > > +#if 0
> > > >                 quota_error(dquot->dq_sb, "Can't write quota structure "
> > > >                             "(error %d). Quota may get out of sync!", ret);
> > > > +#endif
> > > >                 /* Clear dirty bit anyway to avoid infinite loop. */
> > > >                 clear_dquot_dirty(dquot);
> > > >         }
> >
> > Doing the same on the my branch based on top of v6.6-rc6 does not help.
> > So looks like a race condition somewhere happening related to that dirty bit
> > (as comment states it needs to be cleaned to avoid infinite loop, that's
> >  probably what happens).
> 
> Hmm. Normally, dirty bits should always be cleared *before* the
> write-back, not after it. Otherwise you might lose a dirty event that
> happened *during* writeback.

Yes, and normally we clear the dirty bit in dquot_commit() before writing
the dquot. However if there is an error in fs-private ->write_dquot()
helper before calling back into dquot_commit() (e.g. ext4 fails to start a
transaction), ->write_dquot() can return without clearing the dirty bit.
For dqput() to not loop indefinitely trying to clean the dquot, we clear
the dirty bit here just to be sure in case of error.

> But I don't know the quota code.
> 
> ... the fact that the #if 0 doesn't help in another case does say that
> it's not the quota_error() call itself. Which it really couldn't have
> been (apart from timing and compiler bugs), but it's still a data
> point, I guess.

Yeah, that's a bit weird. I'm really curious what the problem is.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

