Return-Path: <linux-fsdevel+bounces-24995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588EC9478B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FBEB21525
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65B14A636;
	Mon,  5 Aug 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtDFptdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14010953
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851293; cv=none; b=gvBPyBv195nv2Ws7/utvYbjEG6Eu3h311+TTBCYbZGJET+PdkthoyKHJjtDLvc57iSAPt4C0VxJ0grk49DXdpsrBWejmUWkQCDX+1WQAbv9YvxmsMQHOkyCueH6zyzSH7gc8AqUZRJR7Z49PrvhJz19bOgYK+ZAgmrVyf5P51e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851293; c=relaxed/simple;
	bh=eSY1saqIxmiwUYWx6iVcg9UWvR1CZ0fcR5dkqqOuTOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRN6Wa1uYk3/JXNs4cmT+sXj+sp1d9YHPgiqQBbS+gWMRQcB2/QvcLC680vsaSn5HCmyZOLxTEeD/r6Ri8i8PKew1E3t1+5vkFpKDpVuNeAn/rsjrgOsBnkb0P6gxY9Voltkwsu+gCv9Ese2lu79qXAWF5c80VSFLonbTXYuExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtDFptdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B966C32782;
	Mon,  5 Aug 2024 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722851293;
	bh=eSY1saqIxmiwUYWx6iVcg9UWvR1CZ0fcR5dkqqOuTOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtDFptdZcz3s2KN/mYgE3bQpZRFC5547kfJNVJXCtLNGhqS9ttYJJDL3LUW9MvJBT
	 3BN9qw4m6/2XmCu5dybQ554KNqmPyG+VfCLxI83A/WGwy0z0G9K/scjAPTLY34lW5+
	 l4Xi95m2kafQr+57csQggU3rgFdmhNhI3dMsXC8hW2yGPXO2Vpxz0etMqAUBSFZAas
	 0yAMYXVNtnC1tTELbEwObUl8rAOkyVnC5JTVrGPCdbvqWdd8+vcHYI+/JZ4vx99T7H
	 vkp/MOp0T8kM+wHOFaUVy/YhcJOVjZ27rKW+mj1tTZaso0vr/Efyi7MVyZ8a/pLBrY
	 2JC3h+zmvI+1A==
Date: Mon, 5 Aug 2024 11:48:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240805-feigheit-drehkreuz-ce432eeaae79@brauner>
References: <20240803225054.GY5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240803225054.GY5334@ZenIV>

On Sat, Aug 03, 2024 at 11:50:54PM GMT, Al Viro wrote:
> [in vfs.git#fixes]
> 
> copy_fd_bitmaps(new, old, count) is expected to copy the first
> count/BITS_PER_LONG bits from old->full_fds_bits[] and fill
> the rest with zeroes.  What it does is copying enough words
> (BITS_TO_LONGS(count/BITS_PER_LONG)), then memsets the rest.
> That works fine, *if* all bits past the cutoff point are
> clear.  Otherwise we are risking garbage from the last word
> we'd copied.
> 
> For most of the callers that is true - expand_fdtable() has
> count equal to old->max_fds, so there's no open descriptors
> past count, let alone fully occupied words in ->open_fds[],
> which is what bits in ->full_fds_bits[] correspond to.
> 
> The other caller (dup_fd()) passes sane_fdtable_size(old_fdt, max_fds),
> which is the smallest multiple of BITS_PER_LONG that covers all
> opened descriptors below max_fds.  In the common case (copying on
> fork()) max_fds is ~0U, so all opened descriptors will be below
> it and we are fine, by the same reasons why the call in expand_fdtable()
> is safe.
> 
> Unfortunately, there is a case where max_fds is less than that
> and where we might, indeed, end up with junk in ->full_fds_bits[] -
> close_range(from, to, CLOSE_RANGE_UNSHARE) with
> 	* descriptor table being currently shared
> 	* 'to' being above the current capacity of descriptor table
> 	* 'from' being just under some chunk of opened descriptors.
> In that case we end up with observably wrong behaviour - e.g. spawn
> a child with CLONE_FILES, get all descriptors in range 0..127 open,
> then close_range(64, ~0U, CLOSE_RANGE_UNSHARE) and watch dup(0) ending
> up with descriptor #128, despite #64 being observably not open.
> 
> The best way to fix that is in dup_fd() - there we both can easily check
> whether we might need to fix anything up and see which word needs the
> upper bits cleared.
>     
> Reproducer follows:
> 
> #define __GNU_SOURCE
> #include <linux/close_range.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdbool.h>
> #include <sys/mman.h>
>     
> void is_open(int fd)
> {
> 	printf("#%d is %s\n", fd,
> 		fcntl(fd, F_GETFD) >= 0 ? "opened" : "not opened");
> }
>     
> int child(void *unused)
> {
> 	while(1) {
> 	}
> 	return 0;
> }
>     
> int main(void)
> {
> 	char *stack;
> 	pid_t pid;
> 
> 	stack = mmap(NULL, 1024*1024, PROT_READ | PROT_WRITE,
> 		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> 	if (stack == MAP_FAILED) {
> 		perror("mmap");
> 		return -1;
> 	}
> 
> 	pid = clone(child, stack + 1024*1024, CLONE_FILES | SIGCHLD, NULL);
> 	if (pid == -1) {
> 		perror("clone");
> 		return -1;
> 	}
> 	for (int i = 2; i < 128; i++)
> 	    dup2(0, i);
> 	close_range(64, ~0U, CLOSE_RANGE_UNSHARE);
> 
> 	is_open(64);
> 	printf("dup(0) => %d, expected 64\n", dup(0));
> 
> 	kill(pid, 9);
> 	return 0;
> }
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Hm, this should probably also get a fixes tag for
4b3b3b3b3b3b ("vfs: clear remainder of 'full_fds_bits' in dup_fd()")
(and possibly for the CLOSE_RANGE_UNSHARE addition).

