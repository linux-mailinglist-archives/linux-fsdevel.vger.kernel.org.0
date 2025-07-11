Return-Path: <linux-fsdevel+bounces-54706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42568B024EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A34A49EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DB2F530A;
	Fri, 11 Jul 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ziAic82o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB02F50AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263197; cv=none; b=k96zxXtsCdFvGlY0OXOL186ZXwZc6aNYoM7O+/Atb2UiJN47octPsH6CPvaMzyhujVyrsza+RIopXaRZAZCYghLTkcTR+h1+ih5q97BJX2T2JDvDEhIpTe6ZKQOCJkfYjff4yboH1YWGtMNdB5qLEjzENeJDu3w76o1Vfm/0N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263197; c=relaxed/simple;
	bh=1FCtprg+5iy5TwUAdOVeniUOl54kIVW1HbeIvQ2AWDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbPsKMCe97EeESoICdNOTOTVPQXm9r8w2rkfywE3tie7g3NgZ4PDa8RZ+rcL+h6vms5QuLV+kV9+ukeyRzbTILzfrlYUeI2gU03GxPheXse4qwBjh0WWGkqe3Rf5z/ObqIIInHw958QfXIEh+K8njunGaKOhGR0p+/VkR0Rqc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ziAic82o; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c44e014so2488527b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263195; x=1752867995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=ziAic82o5Xsycxq9GPJbs2zj0PZcpHXxXwZYfqjULp8kTY5MvB77x1E34I58+6CHU4
         TCyzbBRmLCrrKuw7ER3+QVIxS6jSF09veMFQ7BvykoF7sLXGxBLpju/Z7gzrSnZfza1J
         A++a5YXk/SnCxs0kFjwpHrSZNZcdFL+ToUEoSRVRdUz61wX/DacZKY7dYEKu5rDK24KE
         QfNkQfpK1v3VwSCvqUYY3tVgR5+7Ul/CNnxp+ySvFU3vjYSVTO26PlIvECBK3x68/166
         cvRESI1X0SodTBhRxrauufud0za+BiA6E4r3/0fbaE7TpE20awCb03z6vWcQmBzL4HgW
         2fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263195; x=1752867995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=DoU9IbKox684AWKMGOyLFzWsNt1qvibPR2LEihB8wcVNFg3l37UjqqkSgkVzheZiOs
         eE7io/FAFUywez3Bq/RZ8tWJeubcIyjhCiTDxwilRwTSQVx3asUtN56auGEtJaSpLyCA
         m/wi7JavqNF9ELcuBsKmkwDGlo5RxDzOsGh3UsSVDBQbKLfRHZ6DtYbQnZllX+YbeXrV
         STadDE+Cim4lgmU/oMBplLWFwJRI2OErWBs62QeOUhawQgspw3FgpnMx1QnSUlpmYDnC
         eULTWOVgr7QctiBbGTNA6dXIoOCmoParEMD94nFaxbQDLHk2cUF/fzZfqqBczrY/a8v9
         uZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBU50byMlgY2slpWz4nF16S+kEP9hQXHNbVABjcgBHmsulsJS2g+agqcufr6ycw1C2HJ9hBQXC46Xl/Bt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7dXtA1tCeyLGaJ0sv8FYf0+sjknS4VaXDNVii4Rzj1YgkHEL
	jCli06b1JE3i+b9ASbmYOVRp8cqbe7Mq8xACHbKEI2PIG/DLa0K6wpUWNaho/4iGarg=
X-Gm-Gg: ASbGnct0Ux2fnXXJqoluKP5gNdlBBF2ETZFrONpgONfIRKWWPDh+ltfSLmnNpH97e7d
	UmEgl4FVyDhqSTq6f7xFFOR0BoLJiIj7K5iUlIc9Ff/TrlZ/+m7JPjF9XCAyQMT5oui/WOJTHRj
	6tlpyyINiLdt7NR5bOvlolC+Sf8l4OLNHeeYUxM567Y6WKS7oaWL9MKNj/RCP8sr0pcgBPgalYL
	triX6C8pTsGZrTlORtbn4fXx1lm5hSfVikQ0f1+x+FeQg4NAOoOlXmmiU/T0kDHHyouUk9Cr2L5
	RdWSXN2E0eiBd+ucfc20oeu0qXnBy8FDV0fNlrZcOv1Ishv/SAbbXNZZhkHpFdSOqiXGr09+4oQ
	qBWnjNoqcnvvSxNiy2DZoJvbVbZqbL1G+
X-Google-Smtp-Source: AGHT+IFf6GpiYkRjqjXqvbw1T026yoy+3X+Jfl0FY1n8dZaAAOqTxp1j8L8i96QaW/8od2oz8aWuiA==
X-Received: by 2002:a05:6a00:c95:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74f1efc0e27mr4847413b3a.23.1752263195403;
        Fri, 11 Jul 2025 12:46:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:12 -0700
Subject: [PATCH v18 07/27] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-7-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index c0d7e67c67ff..792cb9792e8f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -431,6 +431,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -776,6 +781,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


