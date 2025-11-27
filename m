Return-Path: <linux-fsdevel+bounces-69994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00261C8DC19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3B350901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973C329E55;
	Thu, 27 Nov 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMDXxtUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BA307AC6;
	Thu, 27 Nov 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239262; cv=none; b=fGLBRU3gTv2HjWCAD0K76WpunlOJ/YUxS+h19Xg4LbwTfs0K6Hya/rSDWF5nMxpVlcCkqKcLFZnnMcC7Psf3O6Dofhz2+M2fjTAYRPP/RwqfA0rbbKfO5Zt5XQKi7RUIzIKWtfjxk3lz4X6OspmZArF0u6Y0vSp3yh/YcCMPv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239262; c=relaxed/simple;
	bh=l8MEnU38WJNtf21NpEjwBL/C3hT0xHnCDwlp6PtWU+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1EySga26lWUVRqxtD2qTrsFIgCz/Ils4hGnGH7DXwz+Z/Hb1N5UisTDr2xtRAEJtuD1SyGDSo4lxChu/T6Fwqjgo1014Vu3xkSEc6Qdsn4V2UZpUFXqimT44RQEanq2rO/HEONRugHdkCjr6bADZhwBRG4UZNzGeTE4LWiy7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMDXxtUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A5C4CEF8;
	Thu, 27 Nov 2025 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764239261;
	bh=l8MEnU38WJNtf21NpEjwBL/C3hT0xHnCDwlp6PtWU+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMDXxtUZ8/H79/ftA1Ipmizsq/K2CMzQSUfqW4dB9GN9S2NleHqRTFJSC8JoWzJNo
	 XIsGgUZtni1MjlQdl0AiMCIxHLNgV2YwjtfT/j/VxFsJof0lR/DOLFeMoauZCZfFNo
	 oO3GIOwsQ7iPwUXMEKp8QxCQ0pGIxrQlDxqu6hebAQtuY+rdlOWDJruNmH4+9M+7yk
	 WQcKvpgWKzUKcTmqlsrcfHlkDFI2cSsTBeNhcsienM+iaNPcZ07oVcK7jJ2AS2Nlsg
	 9IXHtOt+e1S23JWeIWiAdywkb6peRVNp6O9GoNCTO4iaCPFpBbm/4RcIYjaHesPUMg
	 9noFk2DVFrT1A==
Date: Thu, 27 Nov 2025 10:27:34 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, jack@suse.com,
	brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aSgnlmQi_UPsugNU@willie-the-truck>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>

On Wed, Nov 26, 2025 at 01:12:38PM -0800, Linus Torvalds wrote:
> On Wed, 26 Nov 2025 at 02:27, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
> >
> > 在 2025/11/26 17:05, Zizhi Wo 写道:
> > > We're running into the following issue on an ARM32 platform with the linux
> > > 5.10 kernel:
> > >
> > > During the execution of hash_name()->load_unaligned_zeropad(), a potential
> > > memory access beyond the PAGE boundary may occur.
> 
> That is correct.
> 
> However:
> 
> > >                This triggers a page fault,
> > > which leads to a call to do_page_fault()->mmap_read_trylock().
> 
> That should *not* happen.  For kernel addresses, mmap_read_trylock()
> should never trigger, much less the full mmap_read_lock().
> 
> See for example the x86 fault handling in  handle_page_fault():
> 
>         if (unlikely(fault_in_kernel_space(address))) {
>                 do_kern_addr_fault(regs, error_code, address);
> 
> and the kernel address case never triggers the mmap lock, because
> while faults on kernel addresses can happen for various reasons, they
> are never memory mappings.
> 
> I'm seeing similar logic in the arm tree, although the check is
> different. do_translation_fault() checks for TASK_SIZE.
> 
>         if (addr < TASK_SIZE)
>                 return do_page_fault(addr, fsr, regs);
> 
> but it appears that there are paths to do_page_fault() that do not
> have this check, ie that do_DataAbort() function does
> 
>         if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>                 return;
> 
> 
> and It's not immediately obvious, but that can call do_page_fault()
> too though the fsr_info[] and ifsr_info[] arrays in
> arch/arm/mm/fsr-2level.c.
> 
> The arm64 case looks like it might have similar issues, but while I'm
> more familiar with arm than I _used_ to be, I do not know the
> low-level exception handling code at all, so I'm just adding Russell,
> Catalin and Will to the participants.
> 
> Catalin, Will - the arm64 case uses
> 
>         if (is_ttbr0_addr(addr))
>                 return do_page_fault(far, esr, regs);
> 
> instead, but like the 32-bit code that is only triggered for
> do_translation_fault().  That may all be ok, because the other cases
> seem to be "there is a TLB entry, but we lack privileges", so maybe
> will never trigger for a kernel access to a kernel area because they
> either do not exist, or we have permissions?

Right, I think the access flag / permission fault case will end up
trying to resolve the VMA for a kernel address but I can't think why
we'd ever run into one of those faults for load_unaligned_zeropad().

Valid kernel mappings are always young (AF set) and, although we can
muck around with permissions, valid mappings are always readable.

Will

