Return-Path: <linux-fsdevel+bounces-39205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A5A11593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C81188AE3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BD21ADD1;
	Tue, 14 Jan 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtLWGYac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60921423A;
	Tue, 14 Jan 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898127; cv=none; b=OxcH3ClBRz0VPCAYOl528ygyb/wWiFpwfWdnxvp0obEYClrHAxqZy39RpZLO4BGXWtjERobHXAO9xiNUsUQtHkH4ftVa1xpGXeEU/6ns2IYiV3aF5SOyk0T+Mls88CIHkRU2jFHjZhYpaMc/PXy2xq0JPeUjYt5zQemCFeZcK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898127; c=relaxed/simple;
	bh=3VQN+rVY5l/jVo7a/1PQvpOAy9GDidt+UUiHtyuciRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPosqYAsTVWSlffDNbsI5vD40RnhnKyuNlwX0pg6LeonaWRqonH7GFqr3x/pUkYZe5+sn7ljXwve0QTxEPIrYU2n2++5gSjwmhSD73NnrakcbF0IdLk9EibydcKdbVBSprYR6VqGAHJ44nAgwsiSkl+CsOAU5ERlTLlkdslrQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtLWGYac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F90C4CEDD;
	Tue, 14 Jan 2025 23:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736898126;
	bh=3VQN+rVY5l/jVo7a/1PQvpOAy9GDidt+UUiHtyuciRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtLWGYacIEX7HkKK83Y2BJbcASsKkmiV5iZ5luqEjjoX6js/koGLNdeeCaKBbbM3s
	 bxzDS+tEt3FS27RQL+1JWtGo/5JgzN8ZCfROQhC+w1AxF3EwDEPueGZhjI8i1Px8rL
	 sXyY1wE7rTkPHz6bkf//6pc/c0XRRTR00s7vDlfQIsPDt9GikdOqA/lLDpVTrJ39JF
	 qUc3Xab2ZtH7StICwAwPA3TAoJgmAXxAiB21COA0EIzfiof0FvrRC7fYFHytsz7NDd
	 q+ADCjgk+mtVi4Rrw+FQOTkHlqleWIwpcwSuqYy8mC9Qzc+7A0PnOdldSnjDotLTHs
	 nE+RJ9wjTE8cg==
Date: Tue, 14 Jan 2025 15:42:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Andrey Konovalov <andreyknvl@gmail.com>, jack@suse.cz,
	jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk,
	christian.brauner@ubuntu.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250114234205.GA3557553@frogsfrogsfrogs>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <20250113-herzhaft-desolat-e4d191b82bdf@brauner>
 <Z4U89Wfyaz2fLbCt@casper.infradead.org>
 <20250113180830.GM6156@frogsfrogsfrogs>
 <CACT4Y+ZJawZEAxsygR8tH=CcOBiVRaVt+RdzwhHYfZYHQdcHdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZJawZEAxsygR8tH=CcOBiVRaVt+RdzwhHYfZYHQdcHdg@mail.gmail.com>

On Tue, Jan 14, 2025 at 09:59:08AM +0100, Dmitry Vyukov wrote:
> On Mon, 13 Jan 2025 at 19:08, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jan 13, 2025 at 04:19:01PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 13, 2025 at 03:38:57PM +0100, Christian Brauner wrote:
> > > > On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> > > > > Hello,
> > > > >
> > > > > When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> > > > > was triggered.
> > > >
> > > > I think we need to come to an agreement at LSFMM or somewhere else that
> > > > we will by default ingore but reports from non-syzbot fuzzers. Because
> > > > we're all wasting time on them.
> >
> > No need to wait until LSFMM, I already agree with the premise of
> > deprioritizing/ignoring piles of reports that come in all at once with
> > very little analysis, an IOCCC-esque reproducer, and no effort on the
> > part of the reporter to do *anything* about the bug.
> 
> +1
> 
> It would be good to publish it somewhere on kernel.org (Documentation/
> or people.kernel.org).
> We could include the link to our guidelines for external reporters
> (where we ask to not test old kernels, reporting dups, not including
> essential info, and other silly things):
> https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.mdThere

/me reads, wonders if "Do NOT mimic syzbot reports" is behind why
everyone claims they have a "custom fuzzer" and proceed to leak the
letters s, y, and z in the report. :P

> is unfortunately no way to make people read all docs on the internet
> beforehand, but at least it's handy to have a link to an existing doc
> to give to people.

<nod> Good idea, we probably ought to have a kernel document setting out
our general policies about automated bug finders and linking to the
known good ones.

BTW, if one got handed a syzbot report, is there an easy way to ask your
dashboard if it already knows about that report?

--D

> > While the Google syzbot dashboard has improved remarkably since 2018,
> > particularly in the past couple of years, thanks to the people who did
> > that!  It's nice that I can fire off patches at the bot and it'll test
> > them.  That said, I don't perceive Google management to be funding much
> > of anyone to solve the problems that their fuzzer uncovers.
> >
> > This is to say nothing of the people who are coyly running their own
> > instances of syzbot sans dashboard and expecting me to download random
> > crap from Google Drive.  Hell no, I don't do that kind of thing in 2025.
> >
> > > I think it needs to be broader than that to also include "AI generated
> > > bug reports" (while not excluding AI-translated bug reports); see
> > >
> > > https://daniel.haxx.se/blog/2024/01/02/the-i-in-llm-stands-for-intelligence/
> > >
> > > so really, any "automated bug report" system is out of bounds unless
> > > previously arranged with the developers who it's supposed to be helping.
> >
> > Agree.  That's been my stance since syzbot first emerged in 2017-18.
> >
> > > We need to write that down somewhere in Documentation/process/ so we
> > > can point misguided people at it.
> > >
> > > We should also talk about how some parts of the kernel are basically
> > > unmaintained and unused, and that automated testing should be focused
> > > on parts of the kernel that are actually used.  A report about being
> > > able to crash a stock configuration of ext4 is more useful than being
> > > able to crash an unusual configuration of ufs.
> >
> > Or maybe we should try to make fuse + iouring fast enough that we can
> > kick all these old legacy drivers out to userspace. ;)
> >
> > > Distinguishing between warnings, BUG()s and actual crashes would also
> > > be a useful thing to put in this document.
> >
> > Yes.  And also state that panic_on_warn=1 is a signal that you wanted
> > fail(over) fast mode.
> >
> > --D

