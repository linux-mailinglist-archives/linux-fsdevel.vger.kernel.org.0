Return-Path: <linux-fsdevel+bounces-49716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA0AC1C06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3B8A45001
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE8271458;
	Fri, 23 May 2025 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z/0uMVmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143E270EAB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978299; cv=none; b=qiEf69wCnI49dMSF1++0sjMt+8HnVXjw71NKf2pfrOk5sSfoAGblS1paJL0jENK7tOxAO8aQCMyLwgLl3cwvRl7SFxc0mt53c4zH73nIzpfVQafE62kMKAZ5+WcPwBQFJvyRx0uvScReLWzMTgUNlJUslUPWIdI/Y6odJDrkznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978299; c=relaxed/simple;
	bh=5l4eYXK/UGIl+TXQnZwANU66ClnBTNssKdiHYV/yMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAvK6JhUq+/NZQJoWMqssDXRA7ig/1CUJwl864qmK86WD3QqT7njdOSl9kcxfP8OAN9NZFBIYvA82lhRPD2ZUCVeMRPt820fdWXP545WuHESUvwakC41cfh4kfsN37LarbjNthj4I33QL5iujAAvJKN0/2zUPwOxijfKdlL/Xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z/0uMVmZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c9563fafso4924089b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978296; x=1748583096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=z/0uMVmZpDv5zwxFek8js9xVH9cXB2le2L02EF7uN2rHvzZOei48EiFrsYZZE0fsFL
         DL2lEpPdNBacS+2aX8C54dVtBZgkNwtFfW/tn2owTtGFmTz06BCze0n0kBSrx3lS0eLD
         q9r7/Rco07W4WQt4KtjYeFY0IlEKxreW8ijt1r/taj23YmSz2eQT9aHIvWglsQx6KKhE
         eoHPAROibPTrQT4NUpN5fOa7aV3M607IblxJI2j+CVoX8rRl9H6SFtAO3MJ7eEFJYtCs
         HJm2e0GjZ6jTzGqhn1PoIspLR50ag8FySpjOBHFDasFFcplgBAW0sybergzwLcomAEtJ
         gBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978296; x=1748583096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=GkiqgiL3u1VnDcXzd1amipiW5kN4eNJ7hqvNY4bXQtwNDV6Z/s/+Wod2QUIC5AADRL
         zDxm3dQq1U4/nA+e1wr4+47THdrT4wMB4AQ0E4leYGTn059H2mnUtZxRkU+Y7G8IvyTm
         YsBN5bT9Qss5jzgzBifLTGRb/F7q65apXWKadeDClmIlmeTkkrXL08ah33uqXmM3CM6/
         pG5X0SiHgbo9mvf3HHDxGXnd/ng4WNu8M/SBUbinCxHmDndSztDUvEULzT1Nw6fuP6wP
         /+fNRbr7QC82X8zaZXT85aj4wFLnwL44UHZO2KnxvLA04ea2x7yAQYMtU2p3AkpCZKPV
         nOfg==
X-Forwarded-Encrypted: i=1; AJvYcCUY8AoB+8lBuChNFjLP6GFBVCBYxmJX3Ww2AC8qQzwxNj7fEpR0hy2CAdC9vY47byiw9+6GnBo3igd2lWM8@vger.kernel.org
X-Gm-Message-State: AOJu0YxSk8mIMBXvwZlkfUlf/P9A1X/LSeiLRBsigJYDIMyl7jcmF88h
	+fmzPBuyynsuSaKkKCg8WgYz6FRlB9u9V1NKOOqZYx+iQ+KC1yW48wLxJtw5XAG1NLw=
X-Gm-Gg: ASbGncs+y8O5z79SDqd7OPpCqVZOr6tBf53irjADzCJ1vESHbXFkcH4Gsi1/3lJuRFy
	1OI88wdgTd7Rpf+y86q42oJRknC3vgr4cN8WL6oMHrRY/xnCBwwyYbxPLCWzC7VlIjMxsD2bKfs
	XpchqAFeA/Xnb/6b27AYJ8btptuweHNzjORWSFjW18azIabDF78OEZ6aeqtrSNSyJ1sIGsYfUC2
	yvImrkvffyXxQqiCjgU1EV+YsW+/ZyulObtmzTXthsuIbeTmqOsVv4HWCLT5iJgMBEKhxzCPvGB
	SqPe43Dm2sE+thuLITcBnTzkY9YL9eUhOt/N/wBhpUg3rz2Ob6yVd7gGlanCkg==
X-Google-Smtp-Source: AGHT+IE8rK05QdJ1ITD+5XvR94KKlymVkOHWAITS/NaW03DRq0vlii2hXT8T9gkaCsqN/qPnStmT9w==
X-Received: by 2002:a05:6a00:9186:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-742a98a323bmr38743995b3a.18.1747978296025;
        Thu, 22 May 2025 22:31:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:10 -0700
Subject: [PATCH v16 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-7-64f61a35eee7@rivosinc.com>
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
index dba257cc4e2d..f21c888f59eb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -433,6 +433,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -778,6 +783,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


