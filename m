Return-Path: <linux-fsdevel+bounces-11929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0138593AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 01:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF71F2175F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB37EB;
	Sun, 18 Feb 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kbh/cWTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1807360;
	Sun, 18 Feb 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708216043; cv=none; b=nXysO1GsTc3Nl5sh52nrT3XNO3FfIaLyi7CpoUfG6dmxgTpj1KLC7JPG6ItzYkexvxwMJyPtw4fJRON2kyxW5Kv6P67nv0oN5I2wKT7j4cDEa14zJXh1vhDERK+APRrKC5U+c5c1vW70atieMfgcQjLQwnpOIFRyKJxfyIeW6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708216043; c=relaxed/simple;
	bh=h79Z3lIxbgbvpeJtKMFZwIkXBVN34m+I9WFzuU0RpPg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fdj9bMUrHLlNPHiz/lEhRmI/5TwpMbmJgUuYG9aJpsM3JVbcXO63E3cuOL84dInNl2PCV2wHI2saCnvt3ocd/8CwA/OR4/j7wJBurw+Og3GnL6KhoLFWiqYQtkyqMrr+nVvhNzEe+a4YjJM1c8EpkqyetjAMaUQWKiq4Z9ktAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=Kbh/cWTs reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41I0PcJe2642444
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Feb 2024 16:25:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41I0PcJe2642444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1708215944;
	bh=Wz3l09giQfTSL1YwWsrN6DHEZxbftRXxZ+FPELlf150=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Kbh/cWTs4TZxrYFDQ9PGa9IsSYuA1vHWzgIsTR0kvi4sW/bys585nuFqikL0TP5gm
	 HKIVOVqbT7JBgMSPQTIwCyqhkiwtXimEAmjOXHjR+2553XQJaMLSzYstWWUWnS4bKN
	 dQOpwm5HzNuMPAIWbCXZ1VCkmdcz6uzIgYOMlj5+Cn11b+VeVfNQY6lnCMeyDdLuuS
	 Ye2WBh6HLbJT67nCtUY3geuu7PCBMFHE/c0FI1Bv7dC7naHq0HkUbcVGJabT880svv
	 Wr8a2dA16Nlv2/Q86qDi2U+JKHTIgZbdXPgEurZBZy98nZMptUmWwHxqFcf1ctQEKg
	 2lKStlO9LtM6A==
Date: Sat, 17 Feb 2024 16:25:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kees Cook <keescook@chromium.org>, Jiri Kosina <jikos@kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Brian Gerst <brgerst@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Tony Battersby <tonyb@cybernetics.com>, linux-kernel@vger.kernel.org,
        y0un9n132@gmail.com, x86@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Adjust brk randomness
User-Agent: K-9 Mail for Android
In-Reply-To: <20240217062035.work.493-kees@kernel.org>
References: <20240217062035.work.493-kees@kernel.org>
Message-ID: <05E12A71-D8A4-4E6D-9C9D-024251C1BDC7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 16, 2024 10:25:42 PM PST, Kees Cook <keescook@chromium=2Eorg> w=
rote:
>Hi,
>
>It was recently pointed out[1] that x86_64 brk entropy was not great,
>and that on all architectures the brk can (when the random offset is 0)
>be immediately adjacent to =2Ebss, leaving no gap that could stop linear
>overflows from the =2Ebss=2E Address both issues=2E
>
>-Kees
>
>Link: https://lore=2Ekernel=2Eorg/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmu=
s=3DdzOUG5E4gV7ayCbu0MPJTZzWkw@mail=2Egmail=2Ecom [1]
>
>Kees Cook (2):
>  x86: Increase brk randomness entropy on x86_64
>  binfmt_elf: Leave a gap between =2Ebss and brk
>
> arch/x86/kernel/process=2Ec | 5 ++++-
> fs/binfmt_elf=2Ec           | 3 +++
> 2 files changed, 7 insertions(+), 1 deletion(-)
>

Why do we even have the brk, or perhaps more importantly, why do we use it=
? Is there any reason whatsoever why glibc uses brk instead of mmap to her =
heap memory?

I thought the base of the brk wasn't even known to userspace other than in=
 the form of the image end=2E=2E=2E

