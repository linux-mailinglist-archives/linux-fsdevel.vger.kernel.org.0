Return-Path: <linux-fsdevel+bounces-50653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32BDACE34F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8049D189C568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7325A2A4;
	Wed,  4 Jun 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A0PJRaE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DB258CF1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057431; cv=none; b=XCDL3mXQ8Nhy2MDWPoKOlSxj67PY+4LYdwSCWj9kcngU029U/24XGGcazHzh9/bSUEvoCt28U6n0+9udjT/2RvhsFdr3461Nl53sZMBMDRW8wD1wbs+k8/9ItzwR8qzyydSGVFuhR0mXuYCPvTz06MgwrBDf5hdnxgabtNpWwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057431; c=relaxed/simple;
	bh=2H2m5simIewFsayNAW49lR1H6/0qCUpR7o1kzaULgpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxSuQVCFWlukxu6CO3J/HjNdAmGimEPMuOx0/aOhDttVVSyV+NkqeWRFhdBfN+Uluj2O9e55tpHWNyg+JYHEi3yewQbZsQ7GDB5sIg2LSvKgLAh4H116LWAa3sBYd+YesmIdo8y3e/2oc5HfkIQyzLu5pBjDbkD1Ajtg/BvlpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A0PJRaE4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so934611a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057429; x=1749662229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFMrn6lkdv1X+ZfMlc48xC4H7OLYGGf0+TbWHzoGarc=;
        b=A0PJRaE4UMdxCWOgbRbQp/oA8vHmixYNHF5+hGdAdKL0ZAOWYXDER5yhBtyNAyBHHl
         1NuHo0cJ/bDnMtHZrQcQDxSTCIMAj6AQ2JtyR4vgOdWA1ICZ8R8Nv+vIZ/5HVFXzwt3y
         873TfACm8C4zv0sqjw4Ua6+LItGu1HM+7nDdWCMiw8uzTpuTn3eqPwFILHn59tuarJp2
         XDZnjIBhXqgzRL4f84H3v+iEsFNACR2/XOg7VTVYnIpRnw9PiN9izyIefSyURtUeDMex
         dLVgI3BlYyKmg9pxZObfjdQyJUHYkH9g9Pn3hC9pljDWbeKJvz6uWiW5oUJG8gFo0LOI
         YehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057429; x=1749662229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFMrn6lkdv1X+ZfMlc48xC4H7OLYGGf0+TbWHzoGarc=;
        b=CdROksjfxx52ZI4nfziggnwT5A/+kLp5vK0krDUzy/mvFZvEELb+Y+e3XQPFPEv+S1
         pDE16bSAAvzpu7xsHZGdkSGlm2YHdvuqLPjpfQQTkRuxAumVLftOcynvpjf20sGjJh4W
         dM1YpGDqkRzSmF8575FWBxbZTiF2+G4rL1i8ycM3XJsVSeprgZHso3XwbB2+1Z2GDs+q
         pfhYmNecfaUyGcZS4ggzT5ziKxQtKvCslif4O8b2Y591Zc3utTK9dmRfjoL3q3P/uLYW
         fMeAnFKScTG61KK1aiP95gCTRLBUMgOA5Ckrt/KAhD6Bm6/CAVFgZ9FkHR2CwwlMQJ48
         QQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCVss6qgrKP7pJj+pSWsEbGAK1mtcKrYt/6G7oS3hh5gL176dHXc4AXnmGUW4edb5Rzvv5Cpwme/9sR5uE4g@vger.kernel.org
X-Gm-Message-State: AOJu0YwaY1y+D82HNc9Izr6/CxMai9qVuxDfQ6+ZnFnuFkhUWAFf6HFs
	tLZ8oA6jTo8SbutMHHFzd/av5zbzXu68tuhJvKqRQSrYgZJUFKEKPsXkyHH7+r+OmkI=
X-Gm-Gg: ASbGncvacU+OWnQCpPWdiSsQQ2J7SoqPzm0AFCdsioU5fj8sSC4I8oP/PeIXMhfdZOe
	bCOfNGIEArzja+mKSZVSKuctuyjhuWiDs6ozt6O3B35/ajkTSLg7kTpNCsd7Pqq0/qNtErVlkkl
	hMO3R+p46vafBompVX8TANtW5YOZ6gaD9r2oaM827Wc4U+yEJKNEhZyRbOySzZnYGmePZmt7eLx
	hxn1SVDAR6MsXNN6SzcHOC7+xHgM4D1/iO2z2gAweZyAOo3+uoOfPFw6fdpB1h20N8vzdv+OaSJ
	FE1sYBIIzme+8BHjoqXVtqlJNdgT3JuqYMDaowd1ZaMbiTfSee2VcCVPxC6ZFw==
X-Google-Smtp-Source: AGHT+IFlP8U7HwtoOSXd944WBBufrK/n2f/2k4GAFM1M0xT22Zrh/4VuKUI/K1nQAjXVjiuSif/1Og==
X-Received: by 2002:a17:90b:2885:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31328fa1825mr342034a91.10.1749057429139;
        Wed, 04 Jun 2025 10:17:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:17:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:42 -0700
Subject: [PATCH v17 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-18-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
index 2caddcd62848..b801217bd4b8 100644
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


