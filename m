Return-Path: <linux-fsdevel+bounces-53668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BBAF5B95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917FE1BC75B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4730AAA9;
	Wed,  2 Jul 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFKV7/3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C83093A8;
	Wed,  2 Jul 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467745; cv=none; b=TTqhBM6+WOpGGrcahCuO+WHfVO0806oBnmjzx1iiN7/Qlxeg00hNt7Gvtyc4iaQBLsUDzoRUcAG1ovPZTDsXpQn6UVdfAA0iEiK91A1zyZUIA/lRc25l0hkzZTwOj9oboOmAqi/CGzSlFnjow07Lev3+D4jSG/F+0aknks7tPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467745; c=relaxed/simple;
	bh=iOL/lPMGnLarpjBGtPcV25NxmgTYdI4Ux5+UDRDF4qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9yrgIXbv9nM7Uqv9c2snzWofchPcj0eq0NoiYdVaQpk2D43a8gfbx85TzIQPqv+odPhd/KQAwoR/Vjw91QYRjeIB/bQnXKM28P+NCOvGDxEWWOPELP6OGXNpDc8UNV6twTlH1KlxI6YvQNLhBOH6yifboc7t+TieGzhmhNh9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFKV7/3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E7C4CEED;
	Wed,  2 Jul 2025 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751467744;
	bh=iOL/lPMGnLarpjBGtPcV25NxmgTYdI4Ux5+UDRDF4qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFKV7/3SMbyjv6dhZs2bxA/Fp1gF5SdUQReShAacjrdrHZJSkK05fvnxTOiYhVUTq
	 TABg+qAw8f4x9zuMVaVUR6vi2T2RhdeCB2xlAWfFAmo0ZDQ4dX7CEYsyhVy5YlC+DL
	 /nu3WU91jrVUmRlo7D1K3K1THhW7BRo2bsN/2miUeCfqL/3yQS0uJa3lG9oTkamyUj
	 XbVQHI5PP2dEVxKzoyF0V4W7mAzN77Wk2UVs4Yl7BVq4yt8vyPFvOoLlRn1QzHCdnf
	 SaLwHKAg9/PCDdzUEEsG1W1586gInTMJaI2NxNB+LQzhdS3D4wqSbjvA1oBkIpe53n
	 b0KJkienC0mHw==
Date: Wed, 2 Jul 2025 07:49:04 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Shardul Bankar <shardulsb08@gmail.com>, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-out-of-bounds in vsnprintf triggered by large
 stack frame
Message-ID: <202507020716.1B1E38593@keescook>
References: <9052e70eb1cf8571c1b37bb0cee19aaada7dfe3d.camel@gmail.com>
 <aGUfd7mxQOOpkHz8@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGUfd7mxQOOpkHz8@pathway.suse.cz>

On Wed, Jul 02, 2025 at 02:00:55PM +0200, Petr Mladek wrote:
> Adding Kees and linux-hardening mailing list into CC just to be sure.
> 
> But I think that this is a bogus report, see below.
> 
> On Tue 2025-07-01 22:11:55, Shardul Bankar wrote:
> > Hello,
> > 
> > I would like to report a slab-out-of-bounds bug that can be reliably
> > reproduced with a purpose-built kernel module. This report was
> > initially sent to security@kernel.org, and I was advised to move it to
> > the public lists.
> > 
> > I have confirmed this issue still exists on the latest mainline kernel
> > (v6.16.0-rc4).
> > 
> > Bug Summary:
> > 
> > The bug is a KASAN-reported slab-out-of-bounds write within vsnprintf.
> > It appears to be caused by a latent memory corruption issue, likely
> > related to the names_cache slab.
> > 
> > The vulnerability can be triggered by loading a kernel module that
> > allocates an unusually large stack frame. When compiling the PoC
> > module, GCC explicitly warns about this: warning: the frame size of
> > 29760 bytes is larger than 2048 bytes. This "stack grooming" positions
> > the task's stack to overlap with a stale pointer from a freed
> > names_cache object. A subsequent call to pr_info() then uses this
> > corrupted value, leading to the out-of-bounds write.
> 
> Honestly, I think that everything works as expected.
> I do not see any bug with the existing kernel code.
> IMHO, the bug is in the test module, see below.
> 
> > Reproducer:
> > 
> > The following minimal kernel module reliably reproduces the crash on my
> > x86-64 test system.
> > 
> > #include <linux/init.h>
> > #include <linux/module.h>
> > #include <linux/printk.h>
> > 
> > #define STACK_FOOTPRINT (3677 * sizeof(void *))
> > 
> > static int __init final_poc_init(void)
> > {
> >     volatile char stack_eater[STACK_FOOTPRINT];
> >     stack_eater[0] = 'A'; // Prevent optimization
> 
> This takes the whole stack.

Way more than the whole stack. :) That's 29416 bytes and the default
stack is 8192 on x86_64. (Well, here it's actually 16K due to KASAN,
I think.) So this is well past the bottom of the stack. And since the
kernel builds with -fno-stack-clash-protection, we don't see a stack
probing crash as the stack usage crosses into the guard page. This is
the same as just doing:

static int __init final_poc_init(void)
{
	volatile char stack_eater;
	*(&stack_eater + STACK_FOOTPRINT) = 'A';
	...

Try this and see how the crash changes:

static int __init final_poc_init(void)
{
	volatile char stack_eater[STACK_FOOTPRINT];
	for (int i = STACK_FOOTPRINT - 1; i >= 0; i++)
		stack_eater[i] = 'A';
	...

:)

> >     pr_info("Final PoC: Triggering bug with controlled stack
> > layout.\n");
> 
> And any function called here, which would need to store return
> address on the stack would fail.
> 
> The compiler warned about it.
> KASAN caught and reported the problem.
> 
> The solution is to listen to the compiler warnings and
> do not create broken modules.

I would agree.

> > [  214.242355] Call Trace:
> > [  214.242356]  <TASK>
> > [  214.242359]  ? console_emit_next_record+0x12b/0x450
> [...]
> > [  214.242573]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  214.242575]  </TASK>

I would also note that the _entire_ trace is bogus too -- all the
leading "?" lines means it's just guessing based on what was left over
in memory rather than a sane dump.

> > This is my first time reporting a bug on the mailing list, so please
> > let me know if any additional information or formatting is required.

I'd repeat what Petr said, which is: if the compiler is emitting
warnings, then it's likely the bug is not with the core kernel. :)

-Kees

-- 
Kees Cook

