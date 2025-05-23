Return-Path: <linux-fsdevel+bounces-49728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E23AC1C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8439E02C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CE2882D2;
	Fri, 23 May 2025 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ULQ6F2bJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FF283FF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978334; cv=none; b=JCuh2Fu82lH+mhecxoB8TVgsxbMJ7hpqJ+BfG95vmq8vFTGuN2j4LdVz0LDMSS4UXPEIaUFK9c69gcok6a/2ywgH0c8baaL4moEoQuqrxXKGzdwYVrCLsHGYWgEw1N40WbsGa5Te4XbuC7qG2an93mfbVZ6DPW1QLYCoZcLp5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978334; c=relaxed/simple;
	bh=HSj61/DKHbscjrSxiKNrJbrvkTbOzS+iDBZfj2iqRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/ERpl1QWcPJsz2AJSMcbvy89HoBEo98wjw4gaNvHMSm+8oqoXrlghows64IQu7BP7SqUiWKLf9LEMUpe1f+UFeiUkQ16tEE5I0F8DBiLIwTf2iMEh+18jBphwMEwjlGmnBYupq6h1vw3vsmVruEMkWAMUczwTriD9vz0wpx0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ULQ6F2bJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso8015422b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978332; x=1748583132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=ULQ6F2bJvfCXlcwydP437F6pyvq9Ke3SJwB6OfNEPnlFejpqstWr99hf4fcRAVaJk9
         PStB4ajAYoTpaUigsTioJXaklL3UGn/VO/YMtc7+YAheMxQrM4shN9K4ut6EG4RIhpn3
         1OYfqelTC3vaRU1urbblLeaCZI4K3zfeS4eEZPPgo0wBIQmEq0Yma4gazsfWfjqOrrq9
         3RxmLENDQgTLt1C6XOXZBd3C7LqhWnxwwQfgC+qwOvxZWm5+vxjFAz4HGJ6d0Iz9YOy/
         tk84kW85mnoCdt75zNkpsWtTO8N65yyEIAv3X7ATEQuHVGdoh0QYXHEZGiP0JZnyvS4a
         0pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978332; x=1748583132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=SxudYETgdWUk3u7cBwS/7vKLq0s6/HfxbSqquAyl9zcg7r2egvmY4n9KN1gsKoYfcr
         tDQxr3dy2UKuJZLl+gFg4AgmOW4uqVbuQyMw/EawD/93D7jmLnRkdcVJ17I00vQqdSOL
         FTOZjBZnJLIzb/PFUpEGmGBp2Im8X70z7YtBWxwYc1jgU4rUYgiXxwga2ayE14BpuWqO
         cQh8ZfFHzIEDpCefIxX2f9SpEpCzyL72c5Q6/7hJoL7EF5lMI/2Dd6ker5HMbo9qHqEg
         TlnfjFT86I6qrD243xAmitHkP3yIYPucAALkISAknuyHmaF9WLgzldn6LELcLqyZFkNk
         9Xaw==
X-Forwarded-Encrypted: i=1; AJvYcCU5r4KIS9a52WOKdqYcmERSibKy4mad+dNuL4bHm/Vymxg7rT3uQ1ENj8h3L5ufhhDGNLYf5iTU+lLnYpmF@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEqXpmmDAYCs3VT05G3BDX8IGXWesTJiNvfRmahbMxQDhpqhm
	98LcNJ+IFq+Ge6qsRNnBBshZE0qTuN3uZourKNYhYDlWgWedQaEo0gqBJLl6G7fl65E=
X-Gm-Gg: ASbGnctTcuM92uU0wazsFSxNwI39I9eVVNAnUjHE+nYP6v99RurOjg/fXUFkZ35K/YT
	ee5iuy3ur4cBxkRSRh+DPx6g9eSnPLPmeQohlZ1C5o4oQKvYcpkjO2RVrS5vYGa097Devsddf4o
	9OjtmKIkBusFIvqN82VkWLMN4tGNPlbReuDOX+he8/qaLcKw2DsM12Ud5BbpPvC3P9niuAid9ff
	u63XtZwXKH/ykiHl8QZFTLUBgsbqQPtSzrjnAFFUdIdMMHTUQCh/tirxmW8+jX1j30BFWfmNRs4
	dRJGeQixEvn41ESF2P5O4VEMVpDCiZjxqxokUQA6f5nyTO/W9E6h4/R+/+S+4Q==
X-Google-Smtp-Source: AGHT+IFN55/S0MavLUpf3quM1MMMkDLsdFfjkZf4p3h1dkJqctJAGjee587t4XJRgbN3gdxjRXpqKw==
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-2170cb051b7mr42162455637.2.1747978332230;
        Thu, 22 May 2025 22:32:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:32:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:21 -0700
Subject: [PATCH v16 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-18-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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


