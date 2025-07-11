Return-Path: <linux-fsdevel+bounces-54700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141CFB024D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7222B3A4E22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7F1E521E;
	Fri, 11 Jul 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hpFOQvHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDD1EB5E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263180; cv=none; b=BRp5JQptOdgoLsgGnrvq824cmjQqUvZPrYfyw+Ddo9UOZmiw3RCa9sAKBixJTJi/8rt8EfNIIN+vIzsmYyvJNdr0rMvl4efS2hd/W76UsgQerMHIuXJfI79jAIjKUUBVDvcLhtqSvl2ufqV3gpE/0VlpvtK9D0fJnVO0w2OZVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263180; c=relaxed/simple;
	bh=3XZTvPjvB4R6wnDsFDBTbHp2HDNWsnF4EUoOhsYeC0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJ4Sci/Pi5eiU74iWrx89bmsdMnv5qFHzfE+ZcAyXa+0BeKP7QmUIIss3Ui3/B30KLnajxA0u9OuHP/wfiKsrkP7SRcT1fCHIimSiZ362MPR3adJSNDz2FfYXbS88XUJ/IboqsyfM1AJVmHyBUBER/It5qxIrIQOhHgMACM2vfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hpFOQvHS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so2267430b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263177; x=1752867977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5+3IuIbTGtFY2nGYSuEXP86kkX+tfkAPCryfH6oHp8=;
        b=hpFOQvHS7nEZ/9CPQUcAh7S1z8bs5bgGroDENNp6WkEP6SXgtk87fMAxMjkA+sdaJD
         39jAobdtfBsJ+LbkqTLl4tZQX6YWGVKlH2Aa054QQl83rcZJdmseds3frwDf9CHmSLyA
         PjToh4UcP++tptSsOPO+IwLglngfXpCMo/zlVrY7JtkJN+i09GLkn+ggTw32bLJvuiye
         BcJl8E76kewr7oKq8n4jgVT/FczEqotLs2pymU2j/StzKzfFtyMP1iZFXsIhkV71oZTQ
         0F1XwFRqnO3UOhD9NRcFABplww+2IEk0S7Vkgbs3cXJsl94RHPOH7ValJCncAiObzDnO
         5A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263177; x=1752867977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+3IuIbTGtFY2nGYSuEXP86kkX+tfkAPCryfH6oHp8=;
        b=oS6mil4kRD4QqjvOlouGPb2SY5WskBTFYL9hZoPa9AO57a7k/72n6oxXfp/dIKkhHA
         FHWbI1OLhaP2nguC8O+Kl2tenWPHpvn24FnjyW1lW7aJSf88b+9dMP5nHmb0VDOzgWZm
         X9Z1Qkg8mB+WSRYC/3Qm+lnHaTVnoJA3AKqt9H1OVMy0Bi9U9wQuM3SCoP/TWeCfKXk9
         jYfOzxqh9HxCteFjsgI3K1u8tH0+OWU9zqPo2EB1c9e/lL8EjGCu/FFi2lRK9gYJW0k4
         FzsHM65CPe8iCksF3V81jtEAw2/6e0xgCE6NnCqvuTZgf1aZvGsqFOt9/j0ORCBo6DiZ
         YkGg==
X-Forwarded-Encrypted: i=1; AJvYcCVKtaiD0YXn7GnDyS9fB7imF+j31EE1plmsGXZVpPoqSZJNCAT1L6PNjepFlAbT7cbvZ8sszJqBvtrRFgSh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0r3HZAy/yD/uCNoKbuheMivtPZvaHc1KNZjmoX7EShq/WQmm0
	WRGhEKDdO+dsoYH4wtUQ8kNIDuw2hscAznwB6D2DulLdskVmAV/a+yN67V+oT/KuOrE=
X-Gm-Gg: ASbGncvZ7Dz/Ksx0IM62ITK+RppgHmWmHjiMuYCGqdQpIcr6sXz7JqDCBXJe5tLNPjv
	NIh3KKlLxcdyLEnDfLhu4S8Esaqoq6aDgSRXNIIbCtq08idaZynb1HHIAgtRS5G8ybP9D9ix9Tt
	motCdfhZUv5ylJqAd4ee7V/OwPytKkZitxHjXWbmvy6BbboScxz8Npyc6Fa+UEfNsB0ujcc0XdC
	wFJ59zskoZ76/Zpi/3s2VkaLsx86xZ6iRFGS49nuni6DOywxcW7DbJdyEPy4g+r/yyt68hjCbEy
	yUGiIYkChvvqeQXMVvN53jNFJJ6COE+b1wDWwKWLQw9iO9sSSDB0Kx3gmNceY5DY6pToJG5J9O3
	61s6WkOn5jh+h6KXrJRYdRCbgJdYUp2rfIGApGIyUuLM=
X-Google-Smtp-Source: AGHT+IHiT9dG2vPXDdmDzQOmWqgagw8g0E9RV6u9tAfh1pEL4PA1GTNnT+r9tqhN9VGCtBB45cyRbQ==
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr6267738b3a.11.1752263176893;
        Fri, 11 Jul 2025 12:46:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:06 -0700
Subject: [PATCH v18 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-1-a8ee62f9f38e@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..eb48924105c4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -353,6 +353,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.43.0


