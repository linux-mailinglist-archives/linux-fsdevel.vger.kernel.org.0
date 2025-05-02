Return-Path: <linux-fsdevel+bounces-47974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963CAA7D1E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 01:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6215D16C0E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42226B945;
	Fri,  2 May 2025 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2DDPjxow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADB26AABE
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228697; cv=none; b=rTVCeKJt7AEmc24NpfN7BftvwgPKxBMGI7fz8uNRHOcM6AVBeCPtsE+00ama8+SSei53nahXmv5CWgGP2L31Os7/uClz29g5WP03/zh8PQQrNZGIMmRgOdlo7QrM7GXx7Z1r4XwpZAFRE/Ed6vrS/KDvOwYqLWZjdH6XFBwN8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228697; c=relaxed/simple;
	bh=HSj61/DKHbscjrSxiKNrJbrvkTbOzS+iDBZfj2iqRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bggOdZKXXzllhHH62hZ33ZPpUBlBc9YjnpgqrYzsO3dKfFSajiDPGP0BWY9JQ/jrL5k5Xub9WHhogA1zp8eGT8X7iTCv/tIFOmCCN3zLqwKDVS7fUJwZV9UN0gLUg8s7A5q8qohIHPwsjbKcMFvtasmEk4+o72nm7v2CdTOv4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2DDPjxow; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso31992975ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228695; x=1746833495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=2DDPjxow5piPbTVF+gk9wguBRloJvmcANyvrb1Q2O8u7eCe9hQhs+bAXn35WrF81k8
         9zHOr0BrYSxt6BYTMiTZYWGouloSrOgESBzxIPm4NBf/x72pBgGtBsu3vGEvIeyqvUvz
         tN/KKss0YxehT2fBU+yfRHTx0LmN9XiYMMTWHxMqsgSalsrbGithoeY6fOlcd3hbRd6S
         JFxmtW+DFr133r0mAqy/fmVOU3dXTqvq0xQsVXlC9O5xkyd5139iDCNo9Rx0QRwzYs1X
         GgePWvFk2jDLPEei/7GlyyrDUQx/MGO80TgS8MLOySU/ZuzlwUHW1NtDPB8ywOwDgm6v
         d70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228695; x=1746833495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=eAlGgPVGoFw+e1V+ocA1sMPLEyTv2IlNbTC1/Aj+sJAoZs2HtLfubnUz0VXEb4IOrZ
         iMPZoI3k3zNPzvPvjj8DrUwYclo6sdCYtVguKsjAbcHnPMzkZE4VBskMTNM3nDFgyLaa
         Plnn5ZsnaMZyx6xL5PWDLIE2HfmUgFxAWK6qCmhV424iz8Ilsreu3IIhd9A8mv9439iW
         7o7TVeHxKWfm+lAG3AziSaaaMwpCtKIewmut1b1vCQSt2ZG4TUMpSSk4jczQl0cZTmnG
         fa3UfnQ+aeB8jnS5xkR8gtw0q/sGG9NsiawuBra4Gaxs0gPktLWZM8rxhVAmwER7dvBZ
         qe7g==
X-Forwarded-Encrypted: i=1; AJvYcCXdpWdSV01KROEIocPDcNlRCk+QzeTiUznJ1A/7zEWY3uISoESLkvTpJ4YlabzuY1LYlDqBllFE1wWrBZOe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MbHUZD5RsUSjbDQtw5SMfUZrTUyUXpsfmBnnJai0mIdGu0Lx
	KeByMYO2xKI95rtho5qwyZKpK+ESjfiae4gOfjCNTdSRTebh8yHUn29eYw6FUAY=
X-Gm-Gg: ASbGnctH/Oir5/k/PQze3iwa7u2JbVh3rTo8F1td2IVHcsoIDeWjm/QNXVwt8F/DNWz
	lwge8+y+YLCyl8HU4od1hvFcR/ZTeUpuBHkBo08BxH7wf7xUCtns0TOlkKO0a38qqnyJUrIGrRl
	6auRfLZN4D6vGtDs4e/e5Zex9iUmeTfUjcs0453wjwuRfvfX7uzeR4w0gfgJLlUYoCvGQPPsano
	X1lJxam6qBswkyHBELjCTQEC7a9kX29mNDc0HOl+XqAmd5E/NnFN+xs4bZZyWrZK2/6PCB62EfK
	EyC5IsXWB/PfI0K17QY04U0XuDaj8aH+m9+e0MGR1WHB+9ymVcI=
X-Google-Smtp-Source: AGHT+IE6knTtCpmfMFAkDI+1hk5/+yYRWT9dIF9l0EXSAK50/Siyf3hCw+eIQ4Toh0T2wsbvHAl/6A==
X-Received: by 2002:a17:902:fc84:b0:223:35cb:e421 with SMTP id d9443c01a7336-22e18c58f62mr11862295ad.49.1746228695046;
        Fri, 02 May 2025 16:31:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:49 -0700
Subject: [PATCH v15 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-18-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
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


