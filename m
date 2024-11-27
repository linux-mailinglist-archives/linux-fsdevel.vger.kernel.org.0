Return-Path: <linux-fsdevel+bounces-35979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C89DA79C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE52B2BF34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003021FBC93;
	Wed, 27 Nov 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7iGE4Bp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7A1FAC33;
	Wed, 27 Nov 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709489; cv=none; b=E3AmP+srXjPhiUOv6rl3KCN9HGOhGS8HEaMpMSKWFxCSPH2HJLuunVxvM146NahuMf84m3jN0sFLO+ayXmr+SqrqgSHkB0Ka+vn2CpEz6B9an2bRIGeLJaV3HeeF+SZSlNqLszRiUBTVgopdtYsXVsHBaVeJ45FGLIMwL/wAkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709489; c=relaxed/simple;
	bh=dqWgDeXEGSRxykq4pDLI8kHlq98XWyHJixML/bBW9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzhohFRjnk8pBJQU2sxFRWpJnson68vn7afbdWFBX4q8S1sPfbfjkjntcY4iR8lfBdmEM5VFMlTATYp+txKOso5umkthyGS5nIaF/r6inI6rocxDfS5QAQw977HJmBzhnej1FUxLBhgIfRpqnA9U6eGCRdxJngcSR6qIroPAXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7iGE4Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF6C4CECC;
	Wed, 27 Nov 2024 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709488;
	bh=dqWgDeXEGSRxykq4pDLI8kHlq98XWyHJixML/bBW9a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7iGE4BpYB+iIEUPgptl983fxACfuA9gJgPj8pBHlXtKbxhREiwmi4DjeIPYbaXF0
	 EPCFXJ/AaqlooFbYtzYZflSKOviGNU1IVQir63r/iOgN8s9sp6UfZvh6RzCcmPGOh5
	 ZfvwuiGkwDRZHIwOmh8h2Ik5jpRnXNKZEHnwF+9M9Zlk+jeTOturk6LpkqTB66rUNn
	 wJYSdG3cMLljO+xRjooflTGnk4MV70YZZPbaBo4Sjaq3bFGRKQZWxFnpzy0Xb1ZXwd
	 Max0GHx3mC9gUiRm4iKaJc6BI67wf7udPoi6cr7ZW6tizaEPP/w7TBkgi4RCYxFe7R
	 uomR120OYghzw==
Date: Wed, 27 Nov 2024 13:11:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Rui Ueyama <rui314@gmail.com>
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
Message-ID: <20241127-frisst-anekdote-3e6d724cb311@brauner>
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
 <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info>
 <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>

On Wed, Nov 27, 2024 at 07:33:53AM +0900, Rui Ueyama wrote:
> On Mon, Nov 11, 2024 at 9:02 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > [adding a few CCs, dropping stable]
> >
> > On 28.10.24 12:15, Rui Ueyama wrote:
> > > I'm the creator and the maintainer of the mold linker
> > > (https://github.com/rui314/mold). Recently, we discovered that mold
> > > started causing process crashes in certain situations due to a change
> > > in the Linux kernel. Here are the details:
> > >
> > > - In general, overwriting an existing file is much faster than
> > > creating an empty file and writing to it on Linux, so mold attempts to
> > > reuse an existing executable file if it exists.
> > >
> > > - If a program is running, opening the executable file for writing
> > > previously failed with ETXTBSY. If that happens, mold falls back to
> > > creating a new file.
> > >
> > > - However, the Linux kernel recently changed the behavior so that
> > > writing to an executable file is now always permitted
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a010c412853).
> >
> > FWIW, that is 2a010c41285345 ("fs: don't block i_writecount during
> > exec") [v6.11-rc1] from Christian Brauner.
> >
> > > That caused mold to write to an executable file even if there's a
> > > process running that file. Since changes to mmap'ed files are
> > > immediately visible to other processes, any processes running that
> > > file would almost certainly crash in a very mysterious way.
> > > Identifying the cause of these random crashes took us a few days.
> > >
> > > Rejecting writes to an executable file that is currently running is a
> > > well-known behavior, and Linux had operated that way for a very long
> > > time. So, I don’t believe relying on this behavior was our mistake;
> > > rather, I see this as a regression in the Linux kernel.
> > >
> > > Here is a bug report to the mold linker:
> > > https://github.com/rui314/mold/issues/1361
> >
> > Thx for the report. I might be missing something, but from here it looks
> > like nothing happened. So please allow me to ask:
> >
> > What's the status? Did anyone look into this? Is this sill happening?

Linus, it seems that the mold linker relies on the deny_write_access()
mechanism for executables. The mold linker tries to open a file for
writing and if ETXTBSY is returned mold falls back to creating a new
file.

There is now a fix in mold upstream in
https://github.com/rui314/mold/commit/8e4f7b53832d8af4f48a633a8385cbc932d1944e

However, mold upstream still insists on a revert (no judgement on my
part in case that sentence is misinterpreted).

Note, that the revert will cause issues for the fanotify pre-content
hook patch series in [1] which was the cause for the removal of the
deny_write_access() protection for executables so that on page faults
the contents of executables could be filled-in by userspace. This is
useful when dealing with very large executables and is apparently used
by Meta.

[1]: https://lore.kernel.org/r/20241121112218.8249-1-jack@suse.cz

While Amir tells me that they may have a way around this I expect this
to be hacky.

This will also trigger a revert/rework of the LTP testsuite which has
adapted various tests to the deny_write_access() removal for
executables.

There's been some delay in responding to this after my initial comment
on Github because I entered into a month of sickness. So I just got
reminded of this issue now. In any case, here's a tag that you can pull
if you agree with the revert. 

The following changes since commit 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5:

  Merge tag 'for-6.13/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2024-11-25 18:54:00 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.exec.deny_write_access.revert

for you to fetch changes up to 3b832035387ff508fdcf0fba66701afc78f79e3d:

  Revert "fs: don't block i_writecount during exec" (2024-11-27 12:51:30 +0100)

----------------------------------------------------------------
vfs-6.13.exec.deny_write_access.revert

----------------------------------------------------------------
Christian Brauner (1):
      Revert "fs: don't block i_writecount during exec"

 fs/binfmt_elf.c       |  2 ++
 fs/binfmt_elf_fdpic.c |  5 ++++-
 fs/binfmt_misc.c      |  7 +++++--
 fs/exec.c             | 23 +++++++++++++++--------
 kernel/fork.c         | 26 +++++++++++++++++++++++---
 5 files changed, 49 insertions(+), 14 deletions(-)

