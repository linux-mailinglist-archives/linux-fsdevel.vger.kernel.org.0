Return-Path: <linux-fsdevel+bounces-8484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A058375E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 23:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96A91C24D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0B48CC5;
	Mon, 22 Jan 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBW8M5Re"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818303EA88
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961542; cv=none; b=OdObU0LOUbRbkbPq86NsGzowuntl4I1uwJMlewOe6vGGFH8Zil3Iq8zmPIrOQ86h1WyiUvnxczVflwk6uwL5OUNxGWTPhEJJl6i0xoYRaxRo+3LczpSRWP5By3fAF7wz6oa+ySf0eapnn54eWoX5aZYCyHgrqRp8LAqCUA6NGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961542; c=relaxed/simple;
	bh=H0TX+YGFmUV2vdt6gKAxQ2gEdh/9M0IgctqZIGtMd/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJTruBllcOLIgglgLkRY0OdnU3EeQigVBcNlHV2rQBAaGKV3MylaZi5tWOJyULyKDGIQSKHoQvmp9F5B56tvay4D72bOJUcHNfgvFLtzs00tqErQFTNLK2PCsX6CHK6Lxt8awinH4shJjyhktqvQDic6mHpCvR+adaU+PTZZeXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oBW8M5Re; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20503dc09adso2368041fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705961538; x=1706566338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgKcLWWKTY3O1sDjk0J47fn3O87zVjpZotecCA+zO1Y=;
        b=oBW8M5ReQ3HJRaxQZRme9mm4epXsidcY8yA1Ikjq2HrKGcpqjtixTaNGSjmIRGVe9h
         XIZnKJwtuvH/6DdDJeRSR4FgZVQlXDRrc6OZSfSbOsoN/5DsURvEj05qGMxvIllJG5Cj
         ng46b+5uci1OF8PO7sFj1z60CBe3fUcvAbJMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705961538; x=1706566338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgKcLWWKTY3O1sDjk0J47fn3O87zVjpZotecCA+zO1Y=;
        b=XxTk1F2m6lNqZszci1+/uKeeR6CBQVXvmiTslUWj/S+n/JQdEhs5sfotAkzPZa6tjs
         9NPOVF4qtXUGvmaXgVt4lela6A2CdjMD9xKNlCF1mWYQ+ORo9YXzn/UlQ4OFAKQYeMM8
         WiIlA4lbUD18lI/dmnH2h9KeUIkcf8qd6pUI9WLdprU1c7dcgwab3zx4/mtErCgKpNk/
         cR9cZpMiESHKV+lNjj64nNPX2B5d94SDQ1kanMhLZLgntEO9hR4oSUUX5d3iLV3UujIb
         FanY2W+V63VHkfgEOwwm6f6FnqVo0aGf1wuEuvsJaaS6BmBHsCCxyizjuVWPk13VLY/8
         R3sA==
X-Gm-Message-State: AOJu0YzHDFLyIT9un1IipCIJUqb3Gs/p6SW1VFKtnvFH22Vnq6tAf8TX
	gYWNeLvvHI69MWmrFqGmIW+HantEuWr1O8Syf/0jkb5k+Npbz0fNIxjr+rTTag==
X-Google-Smtp-Source: AGHT+IEWjlQw+cSPVMJjT7U5wLtADDdKcUw+JASJ25omFvYBlW8fm+b/W7oPlH2U07JZhfioUWKK1w==
X-Received: by 2002:a05:6870:5704:b0:210:b61d:7b81 with SMTP id k4-20020a056870570400b00210b61d7b81mr621218oap.38.1705961538623;
        Mon, 22 Jan 2024 14:12:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i191-20020a6387c8000000b005ced88aa031sm8852613pge.48.2024.01.22.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:12:18 -0800 (PST)
Date: Mon, 22 Jan 2024 14:12:17 -0800
From: Kees Cook <keescook@chromium.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Bujak <j@exia.io>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202401221339.85DBD3931@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v87laxrh.fsf@email.froward.int.ebiederm.org>

On Mon, Jan 22, 2024 at 03:01:06PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, Jan 22, 2024 at 10:43:59AM -0600, Eric W. Biederman wrote:
> >> Jan Bujak <j@exia.io> writes:
> >> 
> >> > Hi.
> >> >
> >> > I recently updated my kernel and one of my programs started segfaulting.
> >> >
> >> > The issue seems to be related to how the kernel interprets PT_LOAD headers;
> >> > consider the following program headers (from 'readelf' of my reproduction):
> >> >
> >> > Program Headers:
> >> >   Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
> >> >   LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
> >> >   LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
> >> >   LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
> >> >   LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
> >> >   LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000
> >> >
> >> > Old kernels load this ELF file in the following way ('/proc/self/maps'):
> >> >
> >> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> >> > 00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
> >> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> >> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >> >
> >> > And new kernels do it like this:
> >> >
> >> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> >> > 00011000-00012000 rw-p 00000000 00:00 0
> >> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> >> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >> >
> >> > That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
> >> > sections to which it tries to write to, and since the kernel doesn't map
> >> > them anymore it crashes.
> >> >
> >> > I bisected the issue to the following commit:
> >> >
> >> > commit 585a018627b4d7ed37387211f667916840b5c5ea
> >> > Author: Eric W. Biederman <ebiederm@xmission.com>
> >> > Date:   Thu Sep 28 20:24:29 2023 -0700
> >> >
> >> >     binfmt_elf: Support segments with 0 filesz and misaligned starts
> >> >
> >> > I can confirm that with this commit the issue reproduces, and with it
> >> > reverted it doesn't.
> >> >
> >> > I have prepared a minimal reproduction of the problem available here,
> >> > along with all of the scripts I used for bisecting:
> >> >
> >> > https://github.com/koute/linux-elf-loading-bug
> >> >
> >> > You can either compile it from source (requires Rust and LLD), or there's
> >> > a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
> >> > so you can easily check with 'objdump -d' that it isn't malicious).
> >> >
> >> > On old kernels this will run fine, and on new kernels it will
> >> > segfault.
> >> 
> >> Frankly your ELF binary is buggy, and probably the best fix would be to
> >> fix the linker script that is used to generate your binary.
> >> 
> >> The problem is the SYSV ABI defines everything in terms of pages and so
> >> placing two ELF segments on the same page results in undefined behavior.
> >> 
> >> The code was fixed to honor your .bss segment and now your .data segment
> >> is being stomped, because you defined them to overlap.
> >> 
> >> Ideally your linker script would place both your .data and .bss in
> >> the same segment.  That would both fix the issue and give you a more
> >> compact elf binary, while not changing the generated code at all.
> >> 
> >> 
> >> That said regressions suck and it would be good if we could update the
> >> code to do something reasonable in this case.
> >> 
> >> We can perhaps we can update the .bss segment to just memset an existing
> >> page if one has already been mapped.  Which would cleanly handle a case
> >> like yours.  I need to think about that for a moment to see what the
> >> code would look like to do that.
> >
> > It's the "if one has already been mapped" part which might
> > become expensive...
> 
> I am wondering if perhaps we can add MAP_FIXED_NOREPLACE and take
> some appropriate action if there is already a mapping there.

Yeah, in the general case we had to back out MAP_FIXED_NOREPLACE usage
for individual LOADs because there were so many cases of overlapping
LOADs. :( Currently it's only used during the initial mapping (when
"total_size" is set), to avoid colliding with the stack.

But, as you suggest, if we only use it for filesz==0, it could work.

> Such as printing a warning and skipping the action entirely for
> a pure bss segment.  That would essentially replicate the previous
> behavior.

Instead of failing, perhaps we just fallback to not using
MAP_FIXED_NOREPLACE and do the memset? (And maybe pr_warn_once?)

> At a minimum adding MAP_FIXED_NOREPLACE should allow us to
> deterministically detect and warn about problems, making it easier
> for people to understand why their binary won't run.

Yeah, it seems like it's the vm_brk_flags() that is clobber the mapping,
so we have to skip that for the MAP_FIXED_NOREPLACE fails on a filesz==0
case?

-- 
Kees Cook

