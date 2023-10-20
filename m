Return-Path: <linux-fsdevel+bounces-848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EF7D1569
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349DF1C20F1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E020B37;
	Fri, 20 Oct 2023 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QcpjL6D1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACaw4kwd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0506208AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 18:05:52 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05528D51;
	Fri, 20 Oct 2023 11:05:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 440DB21921;
	Fri, 20 Oct 2023 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697825148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aowhsEu2l584lFcY1TW9THGxlynzZUr74z2MacAQwjM=;
	b=QcpjL6D1riTeqXlsFHcdC60bLjZhe9gK+MVRIE4AWIQ5PdAMEXoL5ISqHQafMO2m6RbdQn
	FVUSBCUrCnoWWApjdUAL6/FGXasDX0sXlauiUApPoTLM+QCijlEnmRYxlE+b+io9xR1WVV
	0P1kzvUgq0JbfslYL5KPPBZJklPOMg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697825148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aowhsEu2l584lFcY1TW9THGxlynzZUr74z2MacAQwjM=;
	b=ACaw4kwdxoaqPPI4QMMIXt4yqiBE0OubIfH6azzFQpZXOB1HtA5cxw5i8Qe6zq9oX2gxUO
	V0Gv4B4v1tMwqHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30D2B13584;
	Fri, 20 Oct 2023 18:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9MrbC3zBMmUGMgAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 20 Oct 2023 18:05:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E345A06E3; Fri, 20 Oct 2023 20:05:47 +0200 (CEST)
Date: Fri, 20 Oct 2023 20:05:47 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231020180547.6r4qwlefs77uvdsv@quack3>
References: <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
Authentication-Results: smtp-out1.suse.de;
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri 20-10-23 17:51:59, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 11:43:47AM -0700, Linus Torvalds wrote:
> > On Thu, 19 Oct 2023 at 11:16, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
> > > makes that merge affect another (not related to the main contents of the merge)
> > > files? Like upstream has one base, the merge has another which is older/newer
> > > in the history?
> > 
> > I already looked at any obvious case of that.
> > 
> > The only quota-related issue on the other side is an obvious
> > one-liner: commit 86be6b8bd834 ("quota: Check presence of quota
> > operation structures instead of ->quota_read and ->quota_write
> > callbacks").
> > 
> > It didn't affect the merge, because it was not related to  any of the
> > changes that came in from the quota branch (it was physically close to
> > the change that used lockdep_assert_held_write() instead of a
> > WARN_ON_ONCE(down_read_trylock()) sequence, but it is unrelated to
> > it).
> > 
> > I guess you could try reverting that one-liner after the merge, but I
> > _really_ don't think it is at all relevant.
> > 
> > What *would* probably be interesting is to start at the pre-merge
> > state, and rebase the code that got merged in. And then bisect *that*
> > series.
> > 
> > IOW, with the merge that triggers your bisection being commit
> > 1500e7e0726e, do perhaps something like this:
> > 
> >   # Name the states before the merge
> >   git branch pre-merge 1500e7e0726e^
> >   git branch jan-state 1500e7e0726e^2
> > 
> >   # Now double-check that this works for you, of course.
> >   # Just to be safe...
> >   git checkout pre-merge
> >   .. test-build and test-boot this with the bad config ..
> 
> That's I have checked already [4], but okay, let me double check.
> [5] is the same as [4] according to `git diff`.
> 
> It boots.
> 
> >   # Then, let's create a new branch that is
> >   # the rebased version of Jan's state:
> >   git checkout -b jan-rebased jan-state
> >   git rebase pre-merge
> 
> [6] is created.
> 
> >   # Verify that the tree is the same as the merge
> >   git diff 1500e7e0726e
> 
> Yes, nothing in output.
> 
> And it does not boot.
> 
> >   # Ok, that was empty, so do a bisect on this
> >   # rebased history
> >   git bisect start
> >   git bisect bad
> >   git bisect good pre-merge
> > 
> > .. and see what commit it *now* claims is the bad commit.
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
> # status: waiting for bad commit, 1 good commit known
> # bad: [2447ff4196091e41d385635f9b6d003119f24199] ext2: Fix kernel-doc warnings
> git bisect bad 2447ff4196091e41d385635f9b6d003119f24199
> # bad: [a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6] MAINTAINERS: change reiserfs status to obsolete
> git bisect bad a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6
> # bad: [74fdc82e4a4302bf8a519101a40691b78d9beb6c] quota: add new helper dquot_active()
> git bisect bad 74fdc82e4a4302bf8a519101a40691b78d9beb6c
> # bad: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()
> git bisect bad e64db1c50eb5d3be2187b56d32ec39e56b739845
> # good: [eea7e964642984753768ddbb710e2eefd32c7a89] ext2: remove redundant assignment to variable desc and variable best_desc
> git bisect good eea7e964642984753768ddbb710e2eefd32c7a89
> # first bad commit: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()

Interesting, but it's a data point :)

> > Would you be willing to do this? It should be only a few bisects,
> > since Jan's branch only brought in 17 commits that the above rebases
> > into this test branch. So four or five bisections should pinpoint the
> > exact point where it goes bad.
> 
> See above.
> 
> I even rebuilt again with just rebased on top of e64db1c50eb5 and it doesn't
> boot, so we found the culprit that triggers this issue.
> 
> > Of course, since this is apparently about some "random code generation
> > issue", that exact point still may not be very interesting.
> 
> On top of the above I have tried the following:
> 1) dropping inline, replacing it to __always_inline -- no help;
> 2) commenting out the error message -- helps!
> 
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
>  {
>         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
>         if (ret < 0) {
> +#if 0
>                 quota_error(dquot->dq_sb, "Can't write quota structure "
>                             "(error %d). Quota may get out of sync!", ret);
> +#endif
>                 /* Clear dirty bit anyway to avoid infinite loop. */
>                 clear_dquot_dirty(dquot);
>         }
> 
> If it's a timing issue it's related to that error message, as the new helper is
> run outside of the spinlock.
> 
> What's is fishy there besides the error message being available only in one
> case, is the pointer that is used for dp_op. I'm not at all familiar with the
> code, but can it be that these superblocks are different for those two cases?

dquot->dq_sb could be different from the sb we have only if the dirty list
would get corrupted in some way. Not impossible but does not seem too
likely. Let's first check whether there are any quotas in the first place.

I've asked this already but I don't think I've got an answer: What
filesystem type is the root filesystem? Does it have any quotas (either
there would be files like aquota.user, quota.user, aquota.group,
quota.group in / or there would be quota feature enabled - how to find that
out depends on the filesystem so once I know the fs type I can give you
instructions).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

