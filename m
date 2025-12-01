Return-Path: <linux-fsdevel+bounces-70340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3FC979BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 14:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B4D4E3090
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2B31328D;
	Mon,  1 Dec 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB4PdAEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8182D5930;
	Mon,  1 Dec 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595700; cv=none; b=Tf59LyoD4T95O5lP7A+NvCSzqcu4XyzPaSoekY/QAS8xynEsdGNe7hlzvSUukzs/JXRvSTBbH319SA+Ud6OZP+3V9I54JCvyz4Fwg8jik8qu+d2bOtbuRZ2r6mehRx4MzPRes1IWeBMwvjQU3PJ3U2VaaBaK/opIir95MJnYsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595700; c=relaxed/simple;
	bh=FevHi0kLliUV5SQ+/ZO84hut8iMmC7m6mevvQPXJiHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXoEm55OzTkeZm1Eobj/iZAYwZD+i/YORQH6+4aR7XuptjL7+Tn8mwkH58m+z3OOBYbl44Gb9jt2vC8Kn+fkK/bNpogO2aD5imdwYwek9iuv61/xKDVMzmhC2evVCFcrSFXA4DTsz1yJh+ppol02WE/uZ1vIlBfm2YtPe5ieu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB4PdAEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A75C4CEF1;
	Mon,  1 Dec 2025 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764595699;
	bh=FevHi0kLliUV5SQ+/ZO84hut8iMmC7m6mevvQPXJiHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GB4PdAEQpQKQuhcpxGteKkjdVYH9TyuUXh91JdQuQ/4eOSaS2YGYg8q65zNG0ksj3
	 4iUEy0Sx1XA6EcrsvEEFUEatwObl/Xb4VOs+L86Ygm1h9jfbIZJCen+EqrXkmpQq5t
	 vzD4d1lwJZVkBXeR8YPgRBOEnuKEzhMHebtHoUi8rgbvy6z9HzRJWNsxrHMf0OOPoB
	 QRJMGlCp7nwSLq51InSz1Ynj4rVUI69oirRNzlrghJAXSQ/uBjN8HHZrs29TWgZ9vU
	 f74tqNqWKXSMr8kOIGEZPP3OtZP0dyeYroa1jhuGK1jujZYk05YvwT+2gsPZXN9D+G
	 afF+kzb1yTDQw==
Date: Mon, 1 Dec 2025 13:28:13 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Zizhi Wo <wozizhi@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>, jack@suse.com,
	brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aS2X7cIiRnR26hyg@willie-the-truck>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
 <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>

On Fri, Nov 28, 2025 at 09:06:50AM -0800, Linus Torvalds wrote:
> On Thu, 27 Nov 2025 at 02:58, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Ha!
> >
> > As said elsewhere, it looks like 32-bit ARM has been missing updates to
> > the fault handler since pre-git history - this was modelled in the dim
> > and distant i386 handling, and it just hasn't kept up.
> 
> I actually have this dim memory of having seen something along these
> lines before, and I just had never realized how it could happen,
> because that call to do_page_fault() in do_translation_fault()
> visually *looks* like the only call-site, and so that
> 
>         if (addr < TASK_SIZE)
>                 return do_page_fault(addr, fsr, regs);
> 
> looks like it does everything correctly. That "do_page_fault()"
> function is static to the arch/arm/mm/fault.c file, and that's the
> only place that appears to call it.
> 
> The operative word being "appears".
> 
> Becuse I had never before realized that that fault.c then also does that
> 
>   #include "fsr-2level.c"
> 
> and then that do_page_fault() function is exposed through those
> fsr_info[] operation arrays.
> 
> Anyway, I don't think that the ARM fault handling is all *that* bad.
> Sure, it might be worth double-checking, but it *has* been converted
> to the generic accounting helpers a few years ago and to the stack
> growing fixes.
> 
> I think the fix here may be as simple as this trivial patch:
> 
>   diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>   index 2bc828a1940c..27024ec2d46d 100644
>   --- a/arch/arm/mm/fault.c
>   +++ b/arch/arm/mm/fault.c
>   @@ -277,6 +277,10 @@ do_page_fault(unsigned long addr, ...
>         if (interrupts_enabled(regs))
>                 local_irq_enable();
> 
>   +     /* non-user address faults never have context */
>   +     if (addr >= TASK_SIZE)
>   +             goto no_context;
>   +
>         /*
>          * If we're in an interrupt or have no user
>          * context, we must not take the fault..
> 
> but I really haven't thought much about it.

In the hack I posted [1], I deliberately avoided modifying
do_page_fault() as it's used on the permission fault path. With your
change above, I'm worried that userspace could simply try to access a
kernel address and that would lead to a panic.

Will

[1] https://lore.kernel.org/all/aShLKpTBr9akSuUG@willie-the-truck/

