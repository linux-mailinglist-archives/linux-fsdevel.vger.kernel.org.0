Return-Path: <linux-fsdevel+bounces-31393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A93995AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C990F1F2308A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189F222A76;
	Tue,  8 Oct 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kvfoAPKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A856222A4B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427137; cv=none; b=q5ETGQpw88yOup0keEyZWlYMl8lut0ToOzKhdXeJUhhe+IrFfgc/SBj3H2LLP2rGhjeXnePZ2aKHHhfdnS0CVAYrkuO1iLV26/vnEDrahlI+ablUXpbLqrB/Luj+WaPqwEb1nwGEchDptv4Ir0KZoivIcO08+rvpy1XVldo7Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427137; c=relaxed/simple;
	bh=vUZ7rOUMw9RDAZdbqhr8Hsm+T/749V5V2ULrkIJqqRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAbyyMw5p+coHirVGX5/n+lGkB+0bGxxxgsO7RHIPtSsP6iJLb8DwQgPQc2KTWYOkjrvWQReuUEFQCxsmD/i4ByIrVcCDDT8eU1BdGi5B6JZj7b8PbJT7RxsRRJCgU56hx0/8wT/nDEVcIUeqUVDfsutUnhPt0ONlguxSWUC+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kvfoAPKu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ae67df5so2167136a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427135; x=1729031935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDZ6InrT+eerMmZ4qSLMUgeWEoIog/HDXgAiPQQVAR8=;
        b=kvfoAPKuA39mLwADZwRyg1HAnSGV9RdUhOIknuSWnTmL5ef1ggdR7ZOfRjG2wIIOjk
         j4qRH6c3j3hiClet+cEG4Ux2tZVZXarYXVH2m+k/QtrpQLUTIRGbJOZ4oVRX5SIgpt+C
         kxUWxH8wOl5VcOTH7clhKyddpVNBvW5lNXCQNDw15JFFAMczrS88LVuv3fkflRRtWXDd
         0fd9E2YqfjBFwqZwrZs5FjUm84sIjUf7ebH2pKtj6jjtWkCccDclv6lAQECPuD4/ClcV
         cIlh0LAg2C16NhkE5y9mfebL5ASJ/h9r6OGx9ncMIVrJyy3tI17sRDmYeVuIbBeuDMHO
         mMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427135; x=1729031935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDZ6InrT+eerMmZ4qSLMUgeWEoIog/HDXgAiPQQVAR8=;
        b=kWDs6CLTiJxakLpv4TWbhcBjb59uOuRQ9eWcBbCmN3Ir4DWXQ4iEhnhsmxvssMcSw0
         vyisJsLsa8Fk/xApyWendecOqveRu0aPh/ATMPhZCLN1BzrBiLUT/PxkXvltFgyMrFL0
         /gVJcCUBs3Im2GyvuVcfIXIN/qcIPGRZ/d7KSDoE9uymKqW3vxxXe1F8wjZ6rWWsKq9B
         H8Z02deDxe3bnnWGTnkDqc4ykAfw0hI/fjEWwkhAyU0dgJczxpSI5sSuQQLhlc93Hymb
         qnPMCDJI7y4wxVvgoNMeVZ80VglJzLlwNW4pL4r2vyZvUKc4qXTALcvzzHMNzBvoUl34
         +m3A==
X-Forwarded-Encrypted: i=1; AJvYcCUR42e2NBRrljncAxAKDsNfESmiaKjmE7yWg3ZVztGjPAmhpefNN4U8VJRC/ZJboTVNvyWrrMMvgDNbn6VQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNX0fB7mWKOt6k7aoG1/yuM6aaSGqyffbH11LrEmZcIDrzwjZ
	cNzo9M+QY1r2o4MtPiatlc6Qr/6eTlI3j8t9KZhM720EUuoWaULMSOGptDKiZn8=
X-Google-Smtp-Source: AGHT+IFzhCfWL4XbvpqcLHDV0XpzTcXk+O5rvrW6YFnboaoUbbqBOGRh/OM2xOQqx+du7y1kOQQxZA==
X-Received: by 2002:a05:6a21:78d:b0:1d2:eb9d:997d with SMTP id adf61e73a8af0-1d8a3bc3334mr715893637.7.1728427134747;
        Tue, 08 Oct 2024 15:38:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:38:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:37:06 -0700
Subject: [PATCH v6 24/33] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-24-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 5207f018415c..6db0fde3701e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -89,8 +89,8 @@ void __show_regs(struct pt_regs *regs)
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
2.45.0


