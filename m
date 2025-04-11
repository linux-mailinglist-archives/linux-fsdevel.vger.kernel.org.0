Return-Path: <linux-fsdevel+bounces-46286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF33A86130
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A1819E890D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882D1F7098;
	Fri, 11 Apr 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kELotiF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABA1F1507;
	Fri, 11 Apr 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383841; cv=none; b=u5npBYTjKyCSJ/dsOmrxOp/Y4NIhv5Ge0v3lDGQGVgV/0lTxw4HEKWnyOpXu5ZtZnQ0SkqTZJWmwsS5awMS2XCzTpt99hjikkDQ3RgG3VF8mqmPoVuXvc86Cv0xTeQxNXnoU1jQUxfK6tBVMXK3uVg25S9k4wsi+hPmcHiLwADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383841; c=relaxed/simple;
	bh=LleWHE+UkE8AejTQSkExVOKbJ+wnhljc9iRh6QWixAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPm16bCIDZubwxGdbdSq2ig1SlsqDQY2KZTWZS/Xcx85cqwdA7HB5DwO2E+q59ds7utttlJ38duE7v8jdxdViFhAkPi2/kBCK07iVYxZZ3I5tUKGxien3wUxZlzA2r0twJ6oVQwJGSYkgo43BZmxLBCCxxVxcsnp/tnVn1ZVcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kELotiF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB6C4CEE2;
	Fri, 11 Apr 2025 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383841;
	bh=LleWHE+UkE8AejTQSkExVOKbJ+wnhljc9iRh6QWixAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kELotiF7CR9LWrWgJlGa8eDw+J1YkACO6ywG0rlCU/hGgoGhLWPudHf8rQaahjdw5
	 sjkAmQbyqSQbHeGrRTatrUTUE4/75n5Y3B5t8rUnyBFVQBEjplj/7fIhJ3rnm4vIUi
	 32C6tjjrYedgJQMFKjI6ES8KnML46FhjSiQ/h/CaF316/68tSRi7ofT8mcl9KCVG4o
	 xVdJmuP2DldZhi2u9Zx2y7BJ6MGIqXtzUbl6l8Wa/tYmmcq+cc1+V9IlxVNpnTihzO
	 FNxAjP//loeTTfa+4NYIyxnxL/cuNAxNw6EhptmsLOpR9u+54/Z5L7GQjHD5NwvLzB
	 fFl8aXQTaHfvA==
Date: Fri, 11 Apr 2025 17:03:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <20250411-feigling-mutlos-2a6603ccebb3@brauner>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
 <7a1a7076-ff6b-4cb0-94e7-7218a0a44028@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a1a7076-ff6b-4cb0-94e7-7218a0a44028@sirena.org.uk>

On Fri, Apr 11, 2025 at 11:31:24AM +0100, Mark Brown wrote:
> On Mon, Apr 07, 2025 at 11:54:15AM +0200, Christian Brauner wrote:
> > This allows the VFS to not trip over anonymous inodes and we can add
> > asserts based on the mode into the vfs. When we report it to userspace
> > we can simply hide the mode to avoid regressions. I've audited all
> > direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> > and i_op inode operations but it already uses a regular file.
> 
> We've been seeing failures in LTP's readadead01 in -next on arm64
> platforms:

This fscking readhead garbage is driving me insane.
Ok, readahead skipped anonymous inodes because it's checking whether it
is a regular file or not. We now make them regular files internally.
Should be fixed in -next tomorrow.

> 
>  4601 07:43:36.192033  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>  4602 07:43:36.201811  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1-next-20250410 #1 SMP PREEMPT Thu Apr 10 06:18:38 UTC 2025 aarch64
>  4603 07:43:36.208400  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>  4604 07:43:36.218393  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>  4605 07:43:36.223886  readahead01.c:36: TPASS: readahead() with fd = -1 : EBADF (9)
>  4606 07:43:36.229370  readahead01.c:43: TPASS: readahead() with invalid fd : EBADF (9)
>  4607 07:43:36.234998  readahead01.c:64: TPASS: readahead() on O_PATH file : EBADF (9)
>  4608 07:43:36.240527  readahead01.c:64: TPASS: readahead() on directory : EINVAL (22)
>  4609 07:43:36.246118  readahead01.c:64: TPASS: readahead() on /dev/zero : EINVAL (22)
>  4610 07:43:36.251530  readahead01.c:64: TPASS: readahead() on pipe read end : EINVAL (22)
>  4611 07:43:36.260007  readahead01.c:64: TPASS: readahead() on pipe write end : EBADF (9)
>  4612 07:43:36.265581  readahead01.c:64: TPASS: readahead() on unix socket : EINVAL (22)
>  4613 07:43:36.270928  readahead01.c:64: TPASS: readahead() on inet socket : EINVAL (22)
>  4614 07:43:36.276754  readahead01.c:64: TFAIL: readahead() on epoll succeeded
>  4615 07:43:36.279460  readahead01.c:64: TFAIL: readahead() on eventfd succeeded
>  4616 07:43:36.285053  readahead01.c:64: TFAIL: readahead() on signalfd succeeded
>  4617 07:43:36.290504  readahead01.c:64: TFAIL: readahead() on timerfd succeeded
>  4618 07:43:36.296220  readahead01.c:64: TFAIL: readahead() on fanotify succeeded
>  4619 07:43:36.301605  readahead01.c:64: TFAIL: readahead() on inotify succeeded
>  4620 07:43:36.307327  tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
>  4621 07:43:36.312806  readahead01.c:64: TFAIL: readahead() on perf event succeeded
>  4622 07:43:36.318534  readahead01.c:64: TFAIL: readahead() on io uring succeeded
>  4623 07:43:36.321511  readahead01.c:64: TFAIL: readahead() on bpf map succeeded
>  4624 07:43:36.325711  readahead01.c:64: TFAIL: readahead() on fsopen succeeded
>  4625 07:43:36.331073  readahead01.c:64: TFAIL: readahead() on fspick succeeded
>  4626 07:43:36.336608  readahead01.c:64: TPASS: readahead() on open_tree : EBADF (9)
>  4627 07:43:36.336903  
>  4628 07:43:36.339354  Summary:
>  4629 07:43:36.339641  passed   10
>  4630 07:43:36.342132  failed   11
>  4631 07:43:36.342420  broken   0
>  4632 07:43:36.342648  skipped  1
>  4633 07:43:36.344768  warnings 0
> 
> which bisected down to this patch, which is cfd86ef7e8e7b9e01 in -next:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18] Add linux-next specific files for 20250410
> git bisect bad 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18
> # status: waiting for good commit(s), bad commit known
> # good: [1785a3a7b96a52fae13880a5ba880a5f473eacb1] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect good 1785a3a7b96a52fae13880a5ba880a5f473eacb1
> # bad: [793874436825ebf3dfeeac34b75682c234cf61ef] Merge branch 'for-linux-next' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect bad 793874436825ebf3dfeeac34b75682c234cf61ef
> # bad: [f8b5c1664191e453611f77d36ba21b09bc468a2d] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> git bisect bad f8b5c1664191e453611f77d36ba21b09bc468a2d
> # good: [100ac6e209fce471f3ff4d4e92f9d192fcfa7637] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> git bisect good 100ac6e209fce471f3ff4d4e92f9d192fcfa7637
> # bad: [143ced925e31fe24e820866403276492f05efaa5] Merge branch 'vfs.all' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> git bisect bad 143ced925e31fe24e820866403276492f05efaa5
> # good: [b087fb728fdda75e1d3e83aa542d3aa025ac6c4a] Merge branch 'nfsd-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> git bisect good b087fb728fdda75e1d3e83aa542d3aa025ac6c4a
> # good: [7ee85aeee98e85f72a663672267180218d1510db] Merge branch 'vfs-6.16.super' into vfs.all
> git bisect good 7ee85aeee98e85f72a663672267180218d1510db
> # bad: [d57e6ea6671b1ef0fcb09ccc52952c8a6bfb83c8] Merge branch 'vfs-6.16.misc' into vfs.all
> git bisect bad d57e6ea6671b1ef0fcb09ccc52952c8a6bfb83c8
> # bad: [25a6cc9a630b4b1b783903b23a3a97c5bf16bf41] selftests/filesystems: add open() test for anonymous inodes
> git bisect bad 25a6cc9a630b4b1b783903b23a3a97c5bf16bf41
> # bad: [c83b9024966090fe0df92aab16975b8d00089e1f] pidfs: use anon_inode_setattr()
> git bisect bad c83b9024966090fe0df92aab16975b8d00089e1f
> # bad: [cfd86ef7e8e7b9e015707e46479a6b1de141eed0] anon_inode: use a proper mode internally
> git bisect bad cfd86ef7e8e7b9e015707e46479a6b1de141eed0
> # good: [418556fa576ebbd644c7258a97b33203956ea232] docs: initramfs: update compression and mtime descriptions
> git bisect good 418556fa576ebbd644c7258a97b33203956ea232
> # first bad commit: [cfd86ef7e8e7b9e015707e46479a6b1de141eed0] anon_inode: use a proper mode internally



