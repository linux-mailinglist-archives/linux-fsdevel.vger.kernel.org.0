Return-Path: <linux-fsdevel+bounces-916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B67D362F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FAD28146F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A818E0C;
	Mon, 23 Oct 2023 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RmvGYUb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A4unGTXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42C18E01
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:15:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7AEE;
	Mon, 23 Oct 2023 05:15:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 176351FE10;
	Mon, 23 Oct 2023 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698063302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCVjdIorGL328eSvpeDsjkbIAiI2WLV9/fKgg09waUI=;
	b=1RmvGYUburDpT4P3Va5WOx/gyJUOx2uc3MYvVsjPVIhAPKYAxMg6ru3xVEa0W57RPz2VYJ
	oEMpBKReud5ieRvph+3QjgKDQXx9zxPHP0y09ZxxxXdYHDNCTUAV1SJLX0Fzn0a+wW/sIJ
	gOv4IvCk5UAy/8PtA0TbnGByuH3QMHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698063302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCVjdIorGL328eSvpeDsjkbIAiI2WLV9/fKgg09waUI=;
	b=A4unGTXseIO8r0J+WMJbXCyQxORvABtLyWVbs0KcoipdTxjUs7THIiAONmPzI2H5mz3Uan
	cez+GBSQfojmJUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02B69139C2;
	Mon, 23 Oct 2023 12:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WheUAMZjNmWSIgAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 23 Oct 2023 12:15:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 809F0A06B2; Mon, 23 Oct 2023 14:15:01 +0200 (CEST)
Date: Mon, 23 Oct 2023 14:15:01 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231023121501.ae3ig3hzxqycglyt@quack3>
References: <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
 <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
 <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
 <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
 <ZTZcwU+nCB0RUI+y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTZcwU+nCB0RUI+y@smile.fi.intel.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon 23-10-23 14:45:05, Andy Shevchenko wrote:
> On Sat, Oct 21, 2023 at 04:36:19PM -0700, Kees Cook wrote:
> > On October 20, 2023 1:36:36 PM PDT, andy.shevchenko@gmail.com wrote:
> > >That said, if you or anyone has ideas how to debug futher, I'm all ears!
> > 
> > I don't think this has been tried yet:
> > 
> > When I've had these kind of hard-to-find glitches I've used manual
> > built-binary bisection. Assuming you have a source tree that works when built
> > with Clang and not with GCC:
> > - build the tree with Clang with, say, O=build-clang
> > - build the tree with GCC, O=build-gcc
> > - make a new tree for testing: cp -a build-clang build-test
> > - pick a suspect .o file (or files) to copy from build-gcc into build-test
> > - perform a relink: "make O=build-test" should DTRT since the copied-in .o
> > files should be newer than the .a and other targets
> > - test for failure, repeat
> > 
> > Once you've isolated it to (hopefully) a single .o file, then comes the
> > byte-by-byte analysis or something similar...
> > 
> > I hope that helps! These kinds of bugs are super frustrating.
> 
> I'm sorry, but I can't see how this is not an error prone approach.
> If it's a timing issue then the arbitrary object change may help and it doesn't
> prove anything. As earlier I tried to comment out the error message, and it
> worked with GCC as well. The difference is so little (according to Linus) that
> it may not be suspectible. Maybe I am missing the point...

Given how reliably you can hit the problem with some kernels while you
cannot hit them with others (only slightly different in a code that doesn't
even get executed on your system) I suspect this is really more a code
placement issue than a timing issue. Like if during the linking phase of
vmlinux some code ends up at some position, the kernel fails, otherwise it
boots fine. Not sure how to debug such thing though. Maybe some playing
with the linker and the order of object files linked could reveal something
but I'm just guessing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

