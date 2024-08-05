Return-Path: <linux-fsdevel+bounces-24972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C69475EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF517B21508
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829A1487EA;
	Mon,  5 Aug 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwcK9gAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170454D8B6
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842533; cv=none; b=KNMGHRSkJSPIcF4LIMl3Pm5ynHAHvLE6IXUjHQMixNM+hNOxhswBjVH0M1guk5s/FpuKKHoYlRR3axMu3UIphfvNiCoh/25RQUR+n3ixDkdThX1JkTEj9fbnkoqZ84LRMlHLdAVp3dfGAkvcJn5j6ZmabX7JEkYrM9FiaGnwqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842533; c=relaxed/simple;
	bh=n01cD8+B6R5dvZJRTFf9OkytXdAzXsfOka0z8Q7A6ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se9kl9KOtXEvy4fpAoFHtnNMFoDrpfC1yPrpDXFvgPF7ExaZ3rM4vXOlT57jTjgmKtydYi+0+5hdOJfYGRMHNKUS2ZWjAaV9hyBseI4nTkHd12IpzD5IPQMsHRStknRLAhSy31X8ee5loTzKpfP8FlLi7ebtdEk2qMIZ1UPYztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwcK9gAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305CC32782;
	Mon,  5 Aug 2024 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722842532;
	bh=n01cD8+B6R5dvZJRTFf9OkytXdAzXsfOka0z8Q7A6ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwcK9gAhXNBgEI25W1RoOcylPv5qOmOVNF4jsseNKpnx1bES6QI6c0QFiYd9VjYS6
	 O+LrQbxU67WqBD5OLT5eWJAVi7FE9O9a1iXHczfgv3UvWn+Nb9RnSPwJzPsmKv3ict
	 Fgolmob6u4p1EZmf4TN9CyU/RBAo5jsB4KVStMsROjhJa3xb1+lVf0mVC0wpJ43BXD
	 R7H0fTr7dRzznTrBZxUmMxYq6YPl2MQsqiPBSAtEIIX1l0RtrwQT5L7DZSDmTTLNqg
	 LBOm4S0SlYKpatPVv5UR/ArR4HCdDToG+LcgnCf0P5B+247NklAT/tqM3acqE5si4u
	 fxQECg4sQdVFQ==
Date: Mon, 5 Aug 2024 09:22:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240805-modisch-anstreben-dc6f70ad6d3e@brauner>
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

Could you please add that reproducer to
tools/testing/selftests/core/close_range_test.c

TEST(close_range_bitmap_corruption)
{
}

Really, it doesn't have to be pretty but these repros in there really
have been helpful finding such corruptions when run with a proper k*san
config.

