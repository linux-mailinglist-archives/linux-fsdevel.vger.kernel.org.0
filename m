Return-Path: <linux-fsdevel+bounces-47664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF3CAA3EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B93F171F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316925524C;
	Wed, 30 Apr 2025 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DE9+7HPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528123C518
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972210; cv=none; b=jvCUskPcqzN4MKT30y+K7MKj3xyCXej3vJ9U+mvECNIskbycpr0/+JLmjH90OH9bMH6zZ37HCRRkGL/K56bideTtSMFC76BuBAr1AaUGxuKI/bXeAeQzcj7R8PmHIoFT0TofASlR/zRpBP0qBNNVy3hbm9xwGt8H/0SHlQqdylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972210; c=relaxed/simple;
	bh=5l4eYXK/UGIl+TXQnZwANU66ClnBTNssKdiHYV/yMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANvwaswbBdlGjxzSuDxsa0K53xWcUv84fRIgwgrwEn6XbocU7pz0cV3ZVJo/y0DjSqR4640PVSJ2piYF4DgcvD0D4b4DY8EXsX1OtLlX0uMWAw87iTkhfPNTNfy8cqHhmAT9R4BaAYXFoFfrkMTjxo6jHBASCXKcGdSQci84RDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DE9+7HPz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33e5013aso79520125ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972208; x=1746577008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=DE9+7HPzxPOEaibFgUkjhUnhAkT0ySzDmikR/k1rm2Y6ZTisTHjfTdTfZZjcXdRtOx
         O/TU7Vc28+25rPUdh2JT2ntq4cnVyXd5PL3TugXpxlqxVhK737/bV4P5Lwwq0bNCgac8
         DUu+5LsVEhzk3fSSRRqwR68lHFSonSOTa4wnIPOTrI8JxTS1NU5aGKOPgluBUMUimWlX
         +zGLtXRbzjVEhK2ONU1obN6s5r8NeN7Pig/PUgztyGCxjLlSAo+MF3PkayfZ5fpSWOWP
         MM/fftKggRC86X5Ueb11qnIdXXefbQL+GxzJUw77ECo9+1KEyyPsX2LWX8ynnAsE9hG/
         Kkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972208; x=1746577008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=mAZpQ4zSJiCRwhxpSR3nVxiVwEla/My0FR7NZfR5g6SEmyfweOmrIzffy3TZvvagTj
         ow7YiHMdES77mQkhR3hQc/Lxsd5Gr2H5VAtLNp9jMWbe7hxfIkvCT3gAElRkiWMh5iDH
         BnrEsrchvpqk4C8lp4HnYW6XC+4TAswtUQQw+Nq4QXBYdSyKjldO9ucmb9+TvLelxfv+
         b3QJI+gb0lKZHVMSZPJCFwQlXDZ3KGG0XFYbZz8jk+xdIoLNP3vVZf9HKghPGQM0Yqzi
         Z/stNc5hr5Jpq6Ev0qlZ9RZZXI9pDc1ayvvpD0cOOxk3udGvCb/FNNSCdEA+aHzZHmkL
         DIUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8d+en46AbRQdOEMYfMVlp9W5NggWBi60UaEaVYN/3wOe7mu4vtPtlPJvP3VsgV/MWwlj7gE47AI/cvBl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmKP6V0dqscw4onWq3zLTF7mTKDqzYRr7EWJsii6MyuVoKY2z
	8oMc7NcMKGUgoecj7esUPKAg9nx69QJ+xP9yDtRHf0FNkjLjHRuA+jiAWu3BjEY=
X-Gm-Gg: ASbGncvTVMtpWMAn213XgXDd3dvl+fds9Rdj8VR3BjvIvO54MUmb4mT5QxzvMPAahWt
	1NmyufN+Zg5bIkWAUqQquQfhmGMAMjHcIIy8/+hcDu1IxB72iaab8bad7WEZsn5I3kaNVO5nx8c
	hyZBe09T1fLoNMn4A8T2oCPC35fwIl8esfgQviYxInJzBrTmINrL0B6dd8Luhon41AB2GOHxAyB
	coupJFX1noTD97i2df2qVi4MTniDQQguEn5fzBDPosr2AyXNEvwR+W3vqMuJTjDqBFsgVJ3pol0
	M+has88q7yQZ8PbfoC3K/K6nJskd0tNPQ0aonzY7al+kbVl1DGI=
X-Google-Smtp-Source: AGHT+IHF0KduTnYGQrePlJEI6tXkimvw7nrR1QkHLBA+cw8lQBj1dgbc3Ah+yAI0hO6Ky9wQoxTVRg==
X-Received: by 2002:a17:902:d4d1:b0:223:67ac:8929 with SMTP id d9443c01a7336-22df56bf231mr8352805ad.0.1745972208061;
        Tue, 29 Apr 2025 17:16:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:24 -0700
Subject: [PATCH v14 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-7-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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


