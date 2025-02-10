Return-Path: <linux-fsdevel+bounces-41458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0499A2FA2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BACE16643E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D0257420;
	Mon, 10 Feb 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jjso/jkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97686254AFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219222; cv=none; b=fC8hZ1vjJBLGK1bAu+QVcZEck6C3vw2zdNZnoHMw6BNtzCnnER9SQQ+5nI1ktbJ9wN+ZwksOtLkLmHQUQN5lcqEvQlbxgT75ZSdktq4yZlygbwbuRdhfEZwl+Q04oxUgqyYYzmxg6Oij8sUzQ1g0tbbl7W2tdwSRptUMGCORQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219222; c=relaxed/simple;
	bh=VGYxjWQw4QYGSfT3AnAkedt5HRuw2tlx5dJCnKUawWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVw+Hxnl26H5lPAtOlmuCqIQZkvLBVzgif9sHZDrdu5mmFUJKgN8gOxWcLsyM0EGxQql1iHsErdOnnQNvEckiAq5/kvvKSaAdbA7gEVcvHtbbybuWcJLavwUL59nzq2qGwsX4/eRkYEkhgVP1/tMjvTokkA2V9VaCRMqGPxHPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jjso/jkr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f3c119fe6so107239995ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219219; x=1739824019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=Jjso/jkrqo17czBv99NVyVdLAR/jj7kRxKYwNCZYJ4riMxKQt6iRLNkZIe5CmzByln
         NLBWDAwOGpyj8HeHDcJCRSud6/ls6ohnjTdPKqWpprcp5iQO+0z8O3MppljcpnQP80hH
         +r7pX/PWhRPFTob8enkbzWtUt9G9tD9+GtDScXE8PBDDU/8Sihc8SJGcqWHcGWzGJTzG
         hOgcy2xS/OSRmpSgcp5YLE5NcMlaeSocxm/nlS8Rfcrfuc4/ghfRjZNImhTf4XJotQwX
         sUicyo3QQGFZkI8JXhTyPrqM6ajqZBc4Zq4Ysm0RLUGelscF4EbYj68AB9pQ7hgunkFm
         rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219219; x=1739824019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=llady0RVQgWGbudvZLgkJMxosGOX10vLXZz8aw0ZNF93Vb/rnZyILMegKpPCL3e8mk
         yFCZlPetKrSaQxbyvLFWf3u2aMTVtdKHut2jwBzu+NmuMgs+pVmkw0chNt8k2p3d1suH
         Egiy0ZmcKvNeib+1fbuPFC0zSFFD2Qga4ifD9KDAuFuPouS7VzI5u2LrfCTcLAKUkTxB
         anddduEbufAPC+C4IYb2AcFTerc/QJqU5K/wIwbs0khPomtOCUBI3X956DCmYaz6qpRP
         tCMTJwaiyETDYrWljstXxoMOMhcIiJbfAnFrvDc7g0EetnEGWIdYt+v59CwyzKte/o8T
         7vLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWPGGdeQycJR4iDMbYUZccmE8ixqFS9r1n259meuA90cz1OBxBp2fSK2GV1EC4+YqMTZdWAnzQgIjU208@vger.kernel.org
X-Gm-Message-State: AOJu0YxgudY9NhdFqoFI6R7DRdAMAmXvPaejk4VL4rhDksNHtw3AUGsk
	1Vs9XkKxDgPni5+Hz7EPYSQGcy2I/ZHJBsbbuaphbAEQndiaojtlrcr3ZWQODpH2ubMZV7JCOV8
	t
X-Gm-Gg: ASbGncsjfoBaJ/SohRYvXKeLBJzVdnBhynz8kz/6uj3lNDdId4ccOcQnFjS8lze6pa6
	J5299jpJ1kIxfe/1XI/roIfjcGYPYtvBTZn0zHGyGciIK7r6D9RI7dVxGDkzMH5RszkxtMxZIII
	kBXn41EvFUC8Ai9xXruHPI+X8ZqNubX+Qa0iyaR+ma37U6sPbSxMcUunqUDcNMpkZ0k5Aiqbxfd
	QycycxTkieGrLQoyYKqyNF5OedRG98z54vqPFkmi3F6aEMbWiH1goTP4n8FuqOetJ4s2uh4BpfC
	ZHt55BEL8EcEeFgHLNFd/3RI7Q==
X-Google-Smtp-Source: AGHT+IED7zcqCk6xnlgZyjRhcEK3K99n9HG3VnjktIjXL97/vl92I1hppw2VD80KTsXjIvmfBlGjpA==
X-Received: by 2002:a17:903:284:b0:216:7ee9:21ff with SMTP id d9443c01a7336-21f4e763a67mr241716765ad.49.1739219219434;
        Mon, 10 Feb 2025 12:26:59 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:59 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:40 -0800
Subject: [PATCH v10 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-7-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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


