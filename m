Return-Path: <linux-fsdevel+bounces-64029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3DFBD674C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F44F827B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304830BF4B;
	Mon, 13 Oct 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="QBUEKLQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60730B52B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392577; cv=none; b=H0MQWPLBDhE9G7hypvoVToXR+yWhAC9h2MmoeZurd/BIiRGga4vGR+SDDUbeL0FA2XlZWUpW+9drHhLQFqv12mxSW/dMRNHPcAtP5pHYzhEissRB5zN80JHVnoUo2WjNn5A58mC45j2ru7APQy/ARaUrR2hY9tem+bRLIp4yLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392577; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbeBcFX6M/n0Uw9DRXElPCRkqb5ow5FKI64h9OK6UCggdazUh7maE/RiHkhntS/elHtxGqjp3BGuHVuKfsVDG+hPbe5Xnb4Zpz46O+2zvLJFMDtcePsrWooCF/gn8iS5ds3IkLTZw61NIUBPwoihvLAx2wnv+9TLd408ee4h57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=QBUEKLQp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so5992349a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392574; x=1760997374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=QBUEKLQp1iPNpdR1b7MEUWSC0iuUvWmpOPfy+VUuc4aXanzuH1NwJBy58S8uHFi0O9
         jKmVAj4zze4J9Wz5k/q808mKT8ro65+A6Q3p+Z01bVlqRWSBnTj7YJ3mLhpYrQ+xKziQ
         CfgybQFHbFRQE5aLRD9ayodStv2sd0DckipCJJw4WwDdZdd8R4Sbc0Fhg91LC+hbUIyx
         QKz1xXAuHaJOdtnmByvYadKq5sAhMnFzRSMniyNlsxYrqhq+616fjXY862CB9vawC19o
         QcdH7k1Y44h70Kz9hdjmz1izdZRtiqqKgD3L4gFrRFqV3CXnQj+DV9lMMbxYf9wvQ6aL
         TOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392574; x=1760997374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=LfLEcnQR6gQN/qdpTbrqpwtSS9wKe7ZvGZ0OlW/6aWfBaM7DBhYbnpirIGJJInGa5h
         FqFl/SkOL5Wd3DKlIo1qxapupM/DLJCNc9sEzT8hh9NFA/G74U3XoQzG2EZe40cKOWs7
         nX+VodTKNb2jtuHH1u41SEmW8BweZhpyzmuEX3rSxIMnemwG2tvqvb7tlTCJTKQFqTdZ
         8KaDV2oSRUiDVlATqiG32ArPXk0AlFKVU8Fbxh7KHROcpjn82BpvUUH8SKKWrf4+zH8Q
         v5szCXPmP5owgmQjPdTm3or9D6RqliiHKllqGplyOPfM60/AObZuB2sd3+ZEPy8FeghA
         0f1g==
X-Forwarded-Encrypted: i=1; AJvYcCXVBQBrrwBeNZzhZccV8JFWHAQ+a57HCLl6R3cZAVO1/PCdqM4kG9M+QpRMcim431yWVNup9PR0YOenC2ou@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6blevPNcn4b11r4zEUmR9DclJpBKDe4BUmu5lzIhO6S/nlzP
	ZSrar7yi6vJKCWFQX8xNCzaNdfj5S7f04UwxHyAa/sRqqydKJPWVOcquc0dqCd/DfKA=
X-Gm-Gg: ASbGncuTQHcdrG86K0F518FoXR4OFSUBqyd71gz1QWJJCJ3cJ+xzfLjftRlyG+R8n+r
	1D1L+KI0RtFPIn/FdnhwgnyvkG5Yuu2Dr4Nbhl+4WvE7bXn1uybNj5LMv+niBUi5z7lFIX/Kjc5
	3NgYu7pzG+44pY1oFRT91pcO/eZGXBQmRtZYeXB+UgOZ9qwEs1hVfjZW2D92AGMA7HL4A8hyhwn
	pdioFiz8BCrbWF9zf4pS0g/9sMS+5XdkqNPexn9LOyvwolMj/Da3vm5/BEP4p18FlL5tmMVyepK
	D2Ic6VjVeuCgh5X2oqkBRipa6AqnrkPPXwuamQNWy2FvqFOkcXunAIoGRvV34J6kF1bAjgof8w1
	Hr8EOBwMsg5uCQ/VyCsaWcyH+DM8gvFjhduus2qpw6JRDONAbXfJMhq3TYXIZ5w==
X-Google-Smtp-Source: AGHT+IEUAWjhmzUKMOgHv62clTaql2Vz2Fmw36KBCgN93ODbgLaTEoxZmk2agT6d2TO/fNRpseH/5Q==
X-Received: by 2002:a17:90b:3d87:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-33b51112272mr33908736a91.15.1760392574224;
        Mon, 13 Oct 2025 14:56:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:59 -0700
Subject: [PATCH v20 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-7-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


