Return-Path: <linux-fsdevel+bounces-51448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5DAD6FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2743817AE6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9FE111A8;
	Thu, 12 Jun 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifDp2UwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7472F4315
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730618; cv=none; b=eaULBQqMjNm2w1f50f0ajhiTeZjg1CtyMKOT8KSbSoARK2Un50xuNgPrApCKbQbYE55QLCdgalyLvNcV9SxRQA1VMyE2lh33grlxxNqLNhZn3iZ7qIOi+BJ2/9gF12yWU2NXS0LCzh6ebFmXTigCufEnMsUdKtikpFQ6zwyaaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730618; c=relaxed/simple;
	bh=tpD/YqH0W18YZ6DosEUJ93gCdhkieMf5AzKZdaTSUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHaGwWYNiIacbEDNmUl1GKlsFdF31zkkTLT+ZXEhfNH3x6O2bifgDZxm2TmQY7419R7jzuNJr5vTJZRkijDRpIQEFwbfaGMpbM9yBM5yHTFByb56ZYoeSxDN8k2X/Ib/E5QcDohm3DgpI/4pYXnec95mQsxxVb8/URdiD/4Ms9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifDp2UwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D1CC4CEEA;
	Thu, 12 Jun 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730618;
	bh=tpD/YqH0W18YZ6DosEUJ93gCdhkieMf5AzKZdaTSUT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifDp2UwMuAKfPECIH16cxqZsSAqn9KBtr+msyKb+3N/6sW+i0BIgiRFB0Shg0solb
	 hNFdHI1VHMcnqk1+2XLWNi3MJQAMptLMZ7HN/iWmYzM04M9YxsMBmN1t17FPU+lq75
	 ZFMCQB+Le8W5l48jcWYfrj2jUiSMTqWenALG9NfF5KZvbWvycqUNtHZXLmYqERhn9W
	 IN0MkSPONVhzDI8Cna4FLlpWyZjH+mJSSjZFifq3sK41alOVh2wFX7jAKIIKRVtN+P
	 JnYv0THGqpydqAVUUtD+jXEqrBq0TQ1n4qMnrMnLmRZPl2S89CGuGqLfvhx7ifXxzc
	 75jntv+9uZA5w==
Date: Thu, 12 Jun 2025 14:16:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250612-video-losziehen-2bc9bbf4c13e@brauner>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
 <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
 <20250606174502.GY299672@ZenIV>
 <20250607052048.GZ299672@ZenIV>
 <20250611-denkpause-wegrand-6eb6647dab77@brauner>
 <20250611172945.GK299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611172945.GK299672@ZenIV>

On Wed, Jun 11, 2025 at 06:29:45PM +0100, Al Viro wrote:
> On Wed, Jun 11, 2025 at 11:36:43AM +0200, Christian Brauner wrote:
> 
> > Sigh. There's no need to get all high and mighty about this. For once I
> > actually do write extensive selftests and they do actually catch a lot
> > of bugs. It's a joke how little selftests we have given the importance
> > of our apis. Nobody ever gives a flying fsck to review selftests when
> > they're posted because nobody seems to actually care.
> 
> Not quite - for me the problem is more on the logistics side; xfstests
> is a lot more convenient in that respect.  To be serious, the main
> problems are
> 	1) many selftests have non-trivial dependencies on config
> and spew a lot of noise when run on different configs.
> 	2) very much oriented to case when kernel tree (with build already
> done) sitting on the box where they are going to be run.  Sure, I can
> tar c .|ssh kvm.virt "mkdir /tmp/linux; cd /tmp/linux; tar x ." and
> then make kselftest there, but it's still a headache.
> 	3) unlike e.g. xfstests and ltp, you don't get a convenient
> summary of the entire run.
> 
> None of that is fatal, obviously, just bloody annoying to deal with at 4am...

Al, please don't work until you drop from exhaustion. :D

> Yes, I know how to use TARGETS, etc., but IME a test in xfstests is less
> of a headache on my setup.

A long time ago I had the plan of moving nearly all testing including
the VFS bits into xfstests proper. After all I added the following years
ago:

brauner@so61|~/src/git/linux/fstests/xfstests-dev
> ls -al src/vfs/
total 500
drwxrwxr-x 2 brauner brauner   4096 Aug 14  2024 .
drwxrwxr-x 6 brauner brauner   8192 Nov 11  2024 ..
-rw-rw-r-- 1 brauner brauner  96274 May 27  2022 btrfs-idmapped-mounts.c
-rw-rw-r-- 1 brauner brauner    274 May 27  2022 btrfs-idmapped-mounts.h
-rw-rw-r-- 1 brauner brauner 240071 Aug 14  2024 idmapped-mounts.c
-rw-r--r-- 1 brauner brauner   3211 Feb 22  2024 idmapped-mounts.h
-rw-rw-r-- 1 brauner brauner   1070 Aug 14  2024 Makefile
-rw-rw-r-- 1 brauner brauner   3677 May 27  2022 missing.h
-rw-rw-r-- 1 brauner brauner   5163 May 27  2022 mount-idmapped.c
-rw-r--r-- 1 brauner brauner  13890 Feb 22  2024 tmpfs-idmapped-mounts.c
-rw-r--r-- 1 brauner brauner    273 Feb 22  2024 tmpfs-idmapped-mounts.h
-rw-r--r-- 1 brauner brauner  22310 Feb 22  2024 utils.c
-rw-r--r-- 1 brauner brauner  10243 Feb 22  2024 utils.h
-rw-r--r-- 1 brauner brauner  66253 Feb 22  2024 vfstest.c
-rw-r--r-- 1 brauner brauner    198 Feb 22  2024 vfstest.h

That tests the s**t out of idmapped mounts and setgid stripping for all
filesystems and a bunch of other stuff. And I had always thought that it
might be worth it to add other tests in there. But in reality adding
selftests for stuff like the mount infra is often a lot easier in the
selftests thanks to the FIXTURE_*() infrastructure that we have there.

IOW, if I have a long series and I'm at the part of "Ok, I now need to
do the boring testing part." I want it to be simple and imho that's
currently where the selftests shine.

The other part is that it all goes into the same place whereas the
selftests for xfstests would need to go into a separate project.

