Return-Path: <linux-fsdevel+bounces-7614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A08287F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1090EB23BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2939AC3;
	Tue,  9 Jan 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIL4c66Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A539848;
	Tue,  9 Jan 2024 14:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ACFC433C7;
	Tue,  9 Jan 2024 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704810243;
	bh=jtlAf7GbJEb8KC+GO5s0+NRGfPU8y1/U2gB+ZyxG2Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIL4c66YEFKrl/oUi0AvJbJow6+eqXBvJQu3E+B7mkXl2QWTeN5MVNYOnU/r5AH8G
	 PR185TTOjTqifbB+AOt5KCoz/7HBQH0JKdsxBooULuNEs8w5O5E/GtTxYDKJwwq0K6
	 erIklOjQErOoFhuIEX+rfwb1Pq1IRox1d+1evUCsrsKYDCNpZD9ZUw9f/P0V9fd3RC
	 Cqnz1GQURYtRAaVfVCo5y7o4wAVjuYn79Smv1qda4AUrXGNvpbUyVHZpXRHC3ZR4YO
	 ICZYHFSXUwrpIdP/tkzkEZXI2jC1o73UboGqTkDvqp23QT2JK4hUbVi353lxqzfOy/
	 02DzZBYrOOQaQ==
Date: Tue, 9 Jan 2024 15:23:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount api updates
Message-ID: <20240109-bitten-anzetteln-af76df71c9b3@brauner>
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
 <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>

On Mon, Jan 08, 2024 at 05:02:48PM -0800, Linus Torvalds wrote:
> On Fri, 5 Jan 2024 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This contains the work to retrieve detailed information about mounts via two
> > new system calls.
> 
> Gaah. While I have an arm64 laptop now, I don't do arm64 builds in
> between each pull like I do x86 ones.
> 
> I *did* just start one, because I got the arm64 pull request.
> 
> And this fails the arm64 build, because __NR_statmount and
> __NR_listmount (457 and 458 respectively) exceed the compat system
> call array size, which is
> 
> arch/arm64/include/asm/unistd.h:
>   #define __NR_compat_syscalls            457
> 
> I don't think this is a merge error, I think the error is there in the
> original, but I'm about to go off and have dinner, so I'm just sending
> this out for now.
> 
> How was this not noted in linux-next? Am I missing something?
> 
> Now, admittedly this looks like an easy mistake to make due to that
> whole odd situation where the compat system calls are listed in
> unistd32.h, but then the max number is in unistd.h, but I would still
> have expected this to have raised flags before it hit my tree..

Bah.

I think Will already provided a good explantion for how this came to be.
But for full transparency: I've ran into this exact issue before with
other system calls we added and I've been notified/saved by Arnd who
pointed out that this file needs to be updated.

32 bit arm has this annoying extra file where you need to bump that
single line. But it'd be nice if we finally had some:

./add-new-syscall

script that could automate adding a new system call number into all
relevant architectures.

Sorry for the breakage. I see that it's already fixed. I'll make a note
to reactivate my cross-compilation toolsuite.

