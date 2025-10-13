Return-Path: <linux-fsdevel+bounces-64040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1FBD686B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AE274FE50D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253A30F921;
	Mon, 13 Oct 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="W2feH3NO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5F930EF95
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392602; cv=none; b=ixDMw6vKGRlpz59iGOoVlSL/KJYGpCJYD7BrtCLmSxMo0klG4GwZnZPMK8bk0B2xDUo0Ua8LrlfalqZ2SDuCoQuQHnLBEJNkOIIDo9GLi6sIMSQDZCoqWSQ4hNrI4sU8Xxicb3sBoDXl3PC5Gym+CbRXgPHCR+GDnO3OvhYPQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392602; c=relaxed/simple;
	bh=wP5UX7zWs0Sv1DUPgXKgMTygpamqW2/FxBkyaeLpPmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uhvk2vhARmfJBri7Ej9rzLW9EX7gzUdwYhCAiH5bwyHSz97R7zMai8r75qbF4RhSNYmE/Z0VUooWvvsDWsVChGXN1Q0VcVGzUP7TRrx4Bh8EDlQcYbT3nkkeYZEFs3QevWS4mD0W51XT1YI2jWr+SnUvGU4FU2boExF56rouZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=W2feH3NO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306d93e562so4720477a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392599; x=1760997399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tg1KhEMZfMefo+THEb4ueoLXzfJu3WY6LEuxXprwk8=;
        b=W2feH3NOTxJd9Gq93cSXj54Fipa69gglO54mHY3GDp+uS+7IpOoHY5l9sHTsWCVlFx
         BWQYeE/ita8UoIG9jkqGgxQNSHzyyNSFv9qof5lWRC9uU+MesFjTvYWOb05LIy0m4R4F
         THMC9oC3ENZQf4hPN0oezhnaZMTPm1rV8tEENhVuFg5bCb/thBmxvEci/wsS4fWhtktU
         GrrI5pSiImr8ysSYMdEcT10qWLbPr6dBTWwgy09P8ZOGX1pGR9+lQstngaOFXHRpfna1
         xqIBD7GcX75OCQ/t98qvhwnzg/jqGLKJiz3mcZwPzytk3D6RHj9076n5mODhXU0+iiy5
         iFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392599; x=1760997399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tg1KhEMZfMefo+THEb4ueoLXzfJu3WY6LEuxXprwk8=;
        b=msAX43cbH06SpvaK6KTPVwDhpIRqg0Ui4tDyK+BUmyL3NH5Ya3pi9gOPtawfO669Xk
         sGpm0eXuE86DjElbfc3a/qr1O2jQs6M+CueY/nAVwdJ2tlk6nSfiSP15I3IzL/Hrol6Y
         +gd94t3c8VZeeGmL4LmD19MU5/kafGhuEpzGEz7v3qkleUQQj6gzbkfLbEURNYf+w/Eh
         KoopG8+hiyC48ivRhEC3LpnjCMqrQokB1dlEAYPehhah2wuYi/79Nmj6WFu0UbqvDp1z
         EhBQrK3e3P+pgwza0Auh0hyK2OngJ/AGPNHkjA23Z5R7C/bk1LimAqNk3T6K/Msp+ngQ
         LSRg==
X-Forwarded-Encrypted: i=1; AJvYcCXL3YbWPBK48Eb1zaHFGyA8oHX33YCZAewm1ccAIrC1BHc0hSu5XkzjXscKZ1ZpWQ/Ath9qyQ8gTrUWu++P@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSLU3Y1Gu0qSXxmnbMFT4+Yl5hr2hqw8Qf2WA5v0xhZLltumE
	hqQllOSjEydEo3s7Q+ScnTh/Fnvn/8Eqpp/71NrUheuQN8BQDYRUmdj1FNjpN93eBQY=
X-Gm-Gg: ASbGncsghMkxVyZ0NgPlPVh3u2H9RENCScmr8xy9gnN1IhRIM0sN+RVgtEAXB5kMnHv
	/Lrsx9InVcxTNhWi7S5S+gqIWeJ0iGZGsdlWdeXE/k/2759BdiLUmqmAZYVHNfKVxQ2we/BMIck
	P16mh/V1Iyt7nVCuEKmsC2cVAZh8BLn6EMHLO595ttmATX2z6f4fwUul647tUPeYDe0qoeWW64m
	SgdE+igWdYOBtPmx/krHSzQTZMIi83Z6xpB/lZI3sT/ViiCMzB6mrabCTPnfefQJEwp9gLocUTu
	KkgmoYLfl4QRQxnubZ12bDmUaZr634kq9WoAHKiDdK1GDqhdlkoki7RFB9OZMn4FYgiU71cF0he
	BSuKJ6BYK2Jkj1rRFovzdAFUQgiwxAhmyXrqJNgYFtFxEc+lchLo=
X-Google-Smtp-Source: AGHT+IErpeCxY0vA8s7bj04XUohmgz5bxQxVpPcpqkeTx6y9x7HsqMPhnwXuNc3lGWZJbSGptpTQ1g==
X-Received: by 2002:a17:90b:1b41:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-33b513d08e3mr27952859a91.28.1760392598996;
        Mon, 13 Oct 2025 14:56:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:10 -0700
Subject: [PATCH v20 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-18-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 49f527e3acfd..aacb23978f93 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -93,8 +93,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.43.0


