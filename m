Return-Path: <linux-fsdevel+bounces-41452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015CA2FA08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DAD3A2CF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373262505AC;
	Mon, 10 Feb 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iC7pYDk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126E2505A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219207; cv=none; b=K/PXc3NAM9T6PFGurP9X5tZN8cyQu2XkyZuK48OJzCzFHUK5Qms6fOR1irxBQshGVaObLy2vUugoR+R+WHCan1InOOm/oY/f67ZCSnd4uG4aL6elps/nUVzSY1BYdsGGk2kpmrLHjzwBifpYLDVEh1qC6KiGWQr7Zeb0E+f7QIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219207; c=relaxed/simple;
	bh=fvZEXse498MAei+juRUqd4/R9FeoMw38NPBzNnBXz58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b30DAeeyAwgqol1YykXWgYuJ/4NQiGJ7WskywVh75mbLrsNVcL80IiKcnuR1fYnvb+LMD+QEh+kZW3MFZjtgVkqWWGWBQPxWGv6P6QMo6Z5u1TNOY/E+qT0sYHOPDeaS71EmNTXDDj+rl42gor1QMr++0uFyBAO3SLKuPNIBueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iC7pYDk8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f40deb941so100108695ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219204; x=1739824004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=iC7pYDk8OzVxQx34StINsJPUvclETZ51O3nqxZcnMRSSI0pS8YDMF0tl8RACTkwQG1
         EIIJa2hvUhAVSC+NK6x6cB/zpc5BIggq+ffK/Ym2uhs4ypf0q2MlPhm5MFXn7yA/Gf6F
         VdOjpYaR05YpLdXjNcCB2S9lj2E7PfIhoCe1iV2Y5NiD8xM3gPoCtzDvZUuQNKTqaDam
         5jUhVk6vThDz40Xv0p6Y+HrPqiqmlrwqbV+py7GwueSfLxT16kT77zCvYQ3bOcgXpGbL
         QvNH7BGhaCPklt4xoP9kS/jPJ3JIlgqTeRw9uXFt1GvOJXmOqXtXeDycjD8c4kPaNlhL
         HhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219204; x=1739824004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=NOrpuh6patK3N8ojj8sYU87JlJ2PEcLLgr/G57g5N2DuMxUdM/qSw5uUsF2jgto3rr
         u8pypkOYKiPqbZsfSm+zUJgxdPkE29UfdpEftcgtPmhmJDl2HTUPebo3bdrnUFz864ax
         qbdyFjJZ7yPXaqEqcRdwbekgcByVQM2520M8MGVhJ9PNxrk7H10KC6c4hWhDClfNl2sE
         2Vs9tFwpNGESt5IIu69yMfmtB+wNQG8GBiDTSg38mZCKIMkQrd8Pbukd22l0Xaazqztr
         9XYM2PkXolDMxKd/97Qu2Nk5mjV47vH8Dx50IZwLz7d7QX90p/k0VBr7byRt9KYAP1WY
         DfJw==
X-Forwarded-Encrypted: i=1; AJvYcCViJQDd5xwSNCBkDXJL5fZNoRSaN9+cSVK3PSYd7M7E6mG8MGWB7dqUAnnIa9cL8++7IoQGnSGqUCYiRDik@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuXDeSr1G8XU3pidHBpvUNi9zNwtJApJaXy88XcnShfDid6hs
	8XusnaNV+CRAa6q1vlhYetBjA8dg0wpI0PRIVsJ4yAQn8lHDEUGEoig4pz22kHbsZoqeU8V9185
	9
X-Gm-Gg: ASbGncv9XOKJD7rxS/gzkgd2WB8DDL/cfrW2Qb/eARQQ95w82zHc8ZLSdKSqmYVbVvs
	R41+8eiqhZF+HlnuMTlcoT/FgPT7wc5XjYmDA9iC4+4eAMlf2N7nw3em9awWoqCbeDL9rhgCJGY
	MG2B0Yl0GID7AbACos+EL8zKGKpI9LVfyMJU1O42qgcN+tc3GCC95755dWW6VD/AenUq5qf5Le8
	v9N1EDvoW41x5sE55F27NS3aPWQo8sVub2tkZPk7OZsIuSBerjKx8HxiX7VTqMW7IsgUu5f1x3I
	V1/sMOD+Kd5pTtahiGHLkwRddQ==
X-Google-Smtp-Source: AGHT+IFznxG4IUsH1vtGUm0FvXVBvTHvmf0eQhdxQZjLsHpvXLSfCmOiU5USFlGIslppLz4th5AW+A==
X-Received: by 2002:a17:902:f114:b0:21f:75c:f7d3 with SMTP id d9443c01a7336-21f4e798104mr179051845ad.38.1739219204274;
        Mon, 10 Feb 2025 12:26:44 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:43 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:34 -0800
Subject: [PATCH v10 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-1-163dcfa31c60@rivosinc.com>
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

VM_HIGH_ARCH_5 is used for riscv

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.34.1


