Return-Path: <linux-fsdevel+bounces-8230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8229683127F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 06:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F72870CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716628F63;
	Thu, 18 Jan 2024 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIJRhpwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9A749D;
	Thu, 18 Jan 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705556981; cv=none; b=KW0w4d3DxA0zgRNElXvkrYybHslYCPA8vzWfhF6z2GuPc5lNrDbyF54kqy4tr8I9e8fBJxBcDLT8mMI5W20c3NtQDgbzlP9HPbQGuHHh6ct8LvdLh4HJQpJt2hNzxvGaG+iWVsa+HWWWVVJ76r1TSmj3BaUt40yGc8WS7PYMV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705556981; c=relaxed/simple;
	bh=smVTYrpz7w+5HQWdbWbOy8VUmzkn+94GUCqw+7Dga5Y=;
	h=Received:DKIM-Signature:References:User-agent:From:To:Cc:Subject:
	 Date:In-reply-to:Message-ID:MIME-Version:Content-Type; b=IbYnEuVQpe1ESD4PZIk26tyF4AjPCAXYAi6rKyEHxH01HgukbbWN7uUpF9VBI8B26KsFPLutz9LYbVfua8HOvCqLRKanXjJQSLG4xpixVN1V9YXnOsH3ypOEXsdtQdR/XQ0buxZW8rYQpS7G332RViM8bKyvicxQ4L8bKtN1Rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIJRhpwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A92C433F1;
	Thu, 18 Jan 2024 05:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705556981;
	bh=smVTYrpz7w+5HQWdbWbOy8VUmzkn+94GUCqw+7Dga5Y=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=NIJRhpwVlSMzyIQv7cZAOp19MFxIxAdvwDkyMnVeDFcq1hMbF/8FJ5YDgAqsiqlxw
	 bHGNqSSZ7bXp2R5ft2ZXBp0BuawNPhw/IhnkP4UThy9lzAoysszNVghNdPi6UUXfZR
	 VZWpv+3o/rh625krmXjWcHS0GnDz6ImTYTAkYOTi0LmznODRwilN8jS3tjEneec/nc
	 CLr0CTk7hkgn73zK0ucYLBjIKNn0QsNBFNfZuwQ0AGAWUXOzz5WUy9xh4eEwsnsG0i
	 lXA4bUAIZdmBFUam24xb+AaE1TGIOQOwS1lo8mN95WHEzV2LapL0+OgNwTdF8zlV93
	 MFZuHeia+CGTg==
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-xfs@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Date: Thu, 18 Jan 2024 10:59:06 +0530
In-reply-to: <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 04, 2024 at 06:40:43 PM +0530, Chandan Babu R wrote:
> On Wed, Jan 03, 2024 at 08:34:20 PM -0800, Darrick J. Wong wrote:
>> On Wed, Jan 03, 2024 at 12:12:12PM +0530, Chandan Babu R wrote:
>>> Hi,
>>> 
>>> Executing fstests' recoveryloop test group on XFS on a next-20240102 kernel
>>> sometimes causes the following hung task report to be printed on the console,
>>> 

Meanwhile, I have executed some more experiments.

The bug can be recreated on a next-20240102 kernel by executing either
generic/388 or generic/475 for a maximum of 10 iterations. I tried to do a git
bisect based on this observation i.e. I would mark a commit as 'good' if the
bug does not get recreated within 10 iterations. This led to the following git
bisect log,

# git bisect log
# bad: [ab0b3e6ef50d305278b1971891cf1d82ab050b35] Add linux-next specific files for 20240102
# good: [33cc938e65a98f1d29d0a18403dbbee050dcad9a] Linux 6.7-rc4
git bisect start 'HEAD' 'v6.7-rc4' 'fs/'
# bad: [ca20194665a58bb541cc9e4dc7abcf96a7c96bd9] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad ca20194665a58bb541cc9e4dc7abcf96a7c96bd9
# good: [bb986dac9a56f88552418288c87e2223f8f448e3] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect good bb986dac9a56f88552418288c87e2223f8f448e3
# bad: [964c80149d24b33bbddd222edbcc782be6eab841] Merge branch 'linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git bisect bad 964c80149d24b33bbddd222edbcc782be6eab841
# good: [da9e5cca7e753dd96e07ae9212f4aeec1b9c68a6] Merge branch 'vfs.all' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
git bisect good da9e5cca7e753dd96e07ae9212f4aeec1b9c68a6
# bad: [9e02829aa9d2e5f2e080ba0191c36a50a384acf1] Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
git bisect bad 9e02829aa9d2e5f2e080ba0191c36a50a384acf1
# bad: [3ac3331ea2c1826e3d30276e0a7e7e62fff519a8] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
git bisect bad 3ac3331ea2c1826e3d30276e0a7e7e62fff519a8
# bad: [e01e3fb272cf7380dd5d70f52e955ac1122e2184] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect bad e01e3fb272cf7380dd5d70f52e955ac1122e2184
# bad: [6d06b73bcd6eee6ca43f429a28e812ef2ad7a4ea] Merge branch 'work.simple_recursive_removal' into for-next
git bisect bad 6d06b73bcd6eee6ca43f429a28e812ef2ad7a4ea
# bad: [119dcc73a9c2df0da002054cdb2296cb32b7cb93] Merge branches 'work.dcache-misc' and 'work.dcache2' into work.dcache
git bisect bad 119dcc73a9c2df0da002054cdb2296cb32b7cb93
# good: [6367b491c17a34b28aece294bddfda1a36ec0377] retain_dentry(): introduce a trimmed-down lockless variant
git bisect good 6367b491c17a34b28aece294bddfda1a36ec0377
# good: [b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4] Merge branch 'no-rebase-overlayfs' into work.dcache-misc
git bisect good b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4
# good: [f9453a1ad1fadae29fd7db5ad8ea16f35e737276] Merge branch 'merged-selinux' into work.dcache-misc
git bisect good f9453a1ad1fadae29fd7db5ad8ea16f35e737276
# good: [57851607326a2beef21e67f83f4f53a90df8445a] get rid of DCACHE_GENOCIDE
git bisect good 57851607326a2beef21e67f83f4f53a90df8445a
# good: [ef69f0506d8f3a250ac5baa96746e17ae22c67b5] __d_unalias() doesn't use inode argument
git bisect good ef69f0506d8f3a250ac5baa96746e17ae22c67b5
# first bad commit: [119dcc73a9c2df0da002054cdb2296cb32b7cb93] Merge branches 'work.dcache-misc' and 'work.dcache2' into work.dcache

Looks like the bug is caused by changes that were made in two separate
branches.

I have also confirmed that the bug was not present in the v6.7-rc4 kernel by
executing generic/388 in a loop for 44 times.

I can also confirm that the issue can be recreated on a next-20240118 kernel.

-- 
Chandan

