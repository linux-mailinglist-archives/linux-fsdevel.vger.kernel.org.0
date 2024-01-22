Return-Path: <linux-fsdevel+bounces-8476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B4837475
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3ACAB26474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55A47A61;
	Mon, 22 Jan 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TS8zk41k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB973F8F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956490; cv=none; b=tLUdxknht7x1n5Qo4tmt9AYIPB3UCN64Cs+ViPn1qHzeSDlUypNKYlx4fZKiD6e0srCfh41yozX+TvtL0uoT3Yy8VYtQuQCYN3HyDhCoUKDE6FGu5YimEmlP708CvRMbfiVLQ/L/LL68sg01Qq8PDW/GTsISyK0DJzGLbhp2SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956490; c=relaxed/simple;
	bh=RYQC2KkWpj9RT7UI3rcfTlQnhAUqT2n8BoXl2E7DtbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvFVr7kIa95doSoY6sPzEuVeYILJ92SPqEu6ovqVwWj28OEOfhDGm/sRS/8K3OTP0+/AKYFMAbF5IQAA/qk4DrHOQ3TRZmZhZ0qAyAYK8x1X/0p/dZZ2hQhowQ4zAf6KIXp07nF0Pw7Jv1qptQ0jGi2p3Z9Cc0h/PIZeDmf1h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TS8zk41k; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1688914a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705956488; x=1706561288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXbpsEnHClGHGXt9fUpUqdjWwEkQ1678gxMm5C6Enb4=;
        b=TS8zk41ko1gX7uuMYeezE8T11gdoSm+GFf/mBxOVnaV8QfnlcDBzWNEtReXADA5Lj4
         zJPbad4UyJM3OOkc9J8Fl6upRnlqnejMKEMcK/6bGfj6KS/0cToI5FvNbG9Ey752XQcl
         gpm0ntmYa8Iplfq9jTbr4QVqUiq1H/rcCHs0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956488; x=1706561288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXbpsEnHClGHGXt9fUpUqdjWwEkQ1678gxMm5C6Enb4=;
        b=TTdsybSDHkXdp6dIxlPrPYcsEhay/ilcGboylELt+vZ3/EZb0lON4hHLoRmW50kWKx
         TObK7JvTFsWk4GIVemmRRXeGJKMMStbC6HCZJlXr4CQy5UxPhwwn/qKBNbq7IafCXM8x
         CS7eUwV7f5HfjR17LzigF63KW3yTfQtfNWsqJrPXg/LxFVnv/1lHKbCOftGajZ9D71bp
         8ou8zg8iXvPdcF7qHLHXppJwOo+JVaybK8LqMud6usayycLmLXdGaZAbdwpB9rFjYMky
         03uPxLqPb4MFAqb4X78QxVwL/zhj+574v78wCxvhWd0WA6Dyt4mEVn+vxI2knOHNhtdR
         FHKQ==
X-Gm-Message-State: AOJu0Ywb+R2XZKVPlJ4FM8KMZCw9vv+MT/BNihnDAUHLpycd5TIZSHru
	5KVvqXS+GqeV+uLglQz5nSAgov7Ulul1oZvnQK4kNv3FXkCk1YQXLmcVQ+uE7Q==
X-Google-Smtp-Source: AGHT+IFINZ8RYKV8rUEcCkP82iAD5yOfN/QLX5ecmImdhqK8CPCz1Jgle0iGvVw8/+T7qOUD2TEqMg==
X-Received: by 2002:a17:90b:4007:b0:290:c6bb:4c59 with SMTP id ie7-20020a17090b400700b00290c6bb4c59mr436412pjb.40.1705956487910;
        Mon, 22 Jan 2024 12:48:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sb12-20020a17090b50cc00b0028cef2025ddsm10257875pjb.15.2024.01.22.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:48:07 -0800 (PST)
Date: Mon, 22 Jan 2024 12:48:06 -0800
From: Kees Cook <keescook@chromium.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Bujak <j@exia.io>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202401221226.DAFA58B78@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jf5co8g.fsf@email.froward.int.ebiederm.org>

On Mon, Jan 22, 2024 at 10:43:59AM -0600, Eric W. Biederman wrote:
> Jan Bujak <j@exia.io> writes:
> 
> > Hi.
> >
> > I recently updated my kernel and one of my programs started segfaulting.
> >
> > The issue seems to be related to how the kernel interprets PT_LOAD headers;
> > consider the following program headers (from 'readelf' of my reproduction):
> >
> > Program Headers:
> >   Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
> >   LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
> >   LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
> >   LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
> >   LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
> >   LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000
> >
> > Old kernels load this ELF file in the following way ('/proc/self/maps'):
> >
> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> > 00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >
> > And new kernels do it like this:
> >
> > 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> > 00011000-00012000 rw-p 00000000 00:00 0
> > 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> > 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
> >
> > That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
> > sections to which it tries to write to, and since the kernel doesn't map
> > them anymore it crashes.
> >
> > I bisected the issue to the following commit:
> >
> > commit 585a018627b4d7ed37387211f667916840b5c5ea
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Thu Sep 28 20:24:29 2023 -0700
> >
> >     binfmt_elf: Support segments with 0 filesz and misaligned starts
> >
> > I can confirm that with this commit the issue reproduces, and with it
> > reverted it doesn't.
> >
> > I have prepared a minimal reproduction of the problem available here,
> > along with all of the scripts I used for bisecting:
> >
> > https://github.com/koute/linux-elf-loading-bug
> >
> > You can either compile it from source (requires Rust and LLD), or there's
> > a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
> > so you can easily check with 'objdump -d' that it isn't malicious).
> >
> > On old kernels this will run fine, and on new kernels it will
> > segfault.
> 
> Frankly your ELF binary is buggy, and probably the best fix would be to
> fix the linker script that is used to generate your binary.
> 
> The problem is the SYSV ABI defines everything in terms of pages and so
> placing two ELF segments on the same page results in undefined behavior.
> 
> The code was fixed to honor your .bss segment and now your .data segment
> is being stomped, because you defined them to overlap.
> 
> Ideally your linker script would place both your .data and .bss in
> the same segment.  That would both fix the issue and give you a more
> compact elf binary, while not changing the generated code at all.
> 
> 
> That said regressions suck and it would be good if we could update the
> code to do something reasonable in this case.
> 
> We can perhaps we can update the .bss segment to just memset an existing
> page if one has already been mapped.  Which would cleanly handle a case
> like yours.  I need to think about that for a moment to see what the
> code would look like to do that.

It's the "if one has already been mapped" part which might
become expensive...

-- 
Kees Cook

