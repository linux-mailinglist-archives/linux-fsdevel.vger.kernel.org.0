Return-Path: <linux-fsdevel+bounces-44061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7BA61EA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE04B885059
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC322080E3;
	Fri, 14 Mar 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v/bziKK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE5207A01
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988388; cv=none; b=T02ZSBAdIs7FmrNkU/khhdd8SmLOKzTsmdLTB/IVtu1E+GizM8aE5+GOgXEPDJz37FgfXOmuGWzW1TR9QYDRp0jZ8A624B68DflSlQnEbR6TF4CnUlm0OYgU/IP+jzqqdSniLF7E1RNV6acnNHOqLwN1IrkqpuWTvO3VCP7ynyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988388; c=relaxed/simple;
	bh=2B/GE9it92ewDokZFJjK3sqtDE6HU7RyqbRv4C+of+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRuHbZMM6bFk4quwzL9R7dUe2dxbhZfXXVX2dInt/WG7gUmu3lFq44cRAP6oCh01jEK581XrGdyZtnkoMV5v+psKyKV5kJaOfwaH/QRZE4jCdBBPEwFYC76xqrEcPX6nRcdIGSn96uEjzmHOGSDJ/bAhosrS7/ZKay8R+TxCn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v/bziKK6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22548a28d0cso74311195ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988385; x=1742593185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0cdClzbcf4jwWk6NNoAER7Uol3lcFHrvU6ecxcolCg=;
        b=v/bziKK6mGTKj7QYREhZJCynnp3FqXtr+GsmaBAy/W66GKQgh+ZS+Bxr5ddk6ZbwYN
         BKSZ2WcX3FkpKbHXw483549BrYTGhzhkHdEQjFRxCLPrC3qBtqIYKqrZdEbrDaB/ChPI
         kjfS3FQybU+Gwywbb4vCGsY80P+8USZWPkIWqy+xAOXGnKXBtFo6DaJlqvd75j6o4JDA
         CUCudVxTZd9nMDhhprn25Oarga2EHXnGRjnutjZgZo6MPf+zb2Fi6cN0JiFajodBdgGQ
         UxrFt9uDfOyTxlJ/t+aScmnUtzAx0VhQohHVyKlO4p1paunf3LNFkHYs4jK/wqgBTroD
         bdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988385; x=1742593185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0cdClzbcf4jwWk6NNoAER7Uol3lcFHrvU6ecxcolCg=;
        b=g4AhjPsEFpulZdRyphiaMZlao1iWHQf/ogL5j1fxdod5TcQHwwIqsVcP4hWNRdPKQb
         5KK2isYfPvO5XEf+/YzHwZ+gGPs26Su2f3c51YIpxQ1hMQBy8fc0qQTy53nE3h7v6qmI
         MbBFbmZvAIWXsN2H5gqiQyVD0Dy28KUpvhzA8e/JYLFtlpbwEAeTcf7clIVJe7p8hXMu
         fmea63zOKagYSv9oqks9lpNObyX5fSCExi1d0egvOwvZrvrgXXvWUWvmzHSsvTA0yK9n
         i4eo2GVkYD6WTQO46CmH+HhXY+HJAdC+lt8I6Gj/77em0Lm8OYbebYxk+0dU7aImisBO
         ZPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFVjeVBeJOxujG64/bV/zsqlBGIhAmulqFblOiaq6rjUft5Byn1kA0Fo/XyWNTwZBdh7AqZKiUT/P8+XAF@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1gFW2NY4tuTS8ST++cOmKZSJyCVqT3GHJEqcfVHiIlj4Wuuk
	FOwiXgK1L0gi/Ah0pbXBHxFr9NnV2ipg3E97q2NMryWnDwX1pMF/l/lM/HNc6Co=
X-Gm-Gg: ASbGncuVtXdgHHkEgv1U7rxrJzXZ/cuWY+j8sWWJ+d2Kq3xEWcwF1lTt6pzVlZavkNo
	g1iyNQcZql2iEgImGCsJ9iLM+WF84Z06WVcHv84AB1GDFDp+xw3D0yEvO9TyD6DZ9sAT41IHjrs
	mcVjYobooj1FKEur0ZdBBixca0j0mqx4ciNn3jnwAUoYhD9dC3iQDRzHHRkk3THrt7G6ubKtFBS
	V2LH+kpYAZQSEkpEVhIMXW30hdLdbJPiAB8sFzGL51IBcJJX2e0fGTdqCXiPLEndVtjJysGgs6k
	Akga1nvRrGz2k9DubVGa1xZVlrhe766clkwpS5/ktSQdl1K/kUdD1X4jGSAjHTYmCw==
X-Google-Smtp-Source: AGHT+IFZaFTcFkxKWE6fnM6U3z3NBo+SecOR6nfScdkNYaVzLCXCW0qb6at3qhL4+W3vIc9ENh5Ndg==
X-Received: by 2002:a17:902:dad1:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-225e0aee9ffmr52390865ad.37.1741988385430;
        Fri, 14 Mar 2025 14:39:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:26 -0700
Subject: [PATCH v12 07/28] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-7-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8c528cd7347a..ede43185ffdf 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,6 +421,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -749,6 +754,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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
2.34.1


