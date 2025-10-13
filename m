Return-Path: <linux-fsdevel+bounces-64023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A74BD66C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93A7734E8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA02FAC05;
	Mon, 13 Oct 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FHIl2z6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455A2FAC0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392562; cv=none; b=dR68Mr9UwXX8CVg1+S1NmzPklAT9ZDCWbKfE+kHcAWz3O+mw0t+uGUuFWTdBLugdRGzvGqoLYXyJTKwEfjyntThwtVSuelTaxL6JyfmpkSjaIcDaivOnOpeLZPKQ06A2pZj0cQQPcgxo1T+CTWkjv6t5qTyqzOVyHjXJ/nYAQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392562; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lz/dqHqaP7F8yAr8RIpj0/xY/HEqh8QfSpq++9yhGNvgq2jvu8YL2WdiP22krr0HFxufCREUs29HrhDUrUbAb73zCnL/oHd+Wdzwnqp+L1c0zl9HA6bGx9MuYtuH/X3WLtV59jWi/Ow6JpPGWeMY7QG4PmopV+L8Fiq4W/V3esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FHIl2z6w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so3732611a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392560; x=1760997360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=FHIl2z6w3GRUpXJbpNIgjen4+RSRY3+nE/wWuRtp31VjDsg/HR7UR/8ERyalZhU6bh
         e0zb1Sd6MVuAQLa5lOyKv1VkWYkvu0rqsBGt+xmlkpkMADvYWVipVCgmP2frOuSE/P49
         HHxG+Wr/I9WBcp+XAnlENfU4dxIBySQIKj4j6bxBj3aI6es+lhJNm80j7tNPfoUxTaYU
         0bBzaxqiPxhHER+bK2rdG8i7kkm2nSYYUgnVnp4KZGzOMptqpJAw69cL6aGdhwvgFDGb
         U3HOPVb9sLSiB5fsGlB20ACyFPKLLKHoeh2KRexH1+RLJ0vFcNvPJ9gnzgJZ0ua4ng74
         8rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392560; x=1760997360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=c7hCj1s2o8oa8q0Yz2AqBzj0ipAjga2ULiFRU8VT3QfCKEpwv1Xq2NGLEs7sI2KNJC
         +9d6fkPfMmyKJJNFV3t1GF8lnerinL531Q9xIeyHhsMMGzXjugPNQWQcl9rVTYa1Vf9E
         7Km04u9xCzRVJpAYlw+fqFKn/zmJvjwU1MDzQBF3UbabybCO3X7NoqnIBMeHIVFSORIp
         PAIDL/NKE+53CExM5g/f85j/otclQmV8N4pJgtooqjrjrssOJYZCgQFAwuCjUHIZcf3p
         6ma/GpINXFtg9nf03lA7MmalAH4+4hCIeDjqZzbQmclPkyKfMkRGlXpqBc8oX361o7vB
         MQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTmrqzbqwvT2NRqPwvqJF5dlPLk4i0d9t+e+sEieBCXC0M16vw6xEp9Cul3SDj8xvbh4WQ3UuhN+m8wV7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEGHNVH1W53BAKQTQ6rCMP5DoEnXK/t1PbcmVUdlRZgP+Ctju
	Y4bGqH7US2i49xvFXphmiiNc1zSQMbEDwjtDX1s9v+9rXHt95UVq4LiAioV3opYn6NA=
X-Gm-Gg: ASbGncu91RKWvhJbkg4BPe7Bd/zW3uP90UrIsyzo40ohtNN5sdTJiuwz5lCxLEPRGTO
	LyKZs9PfbhpFO+qR3awUTIZpNjYDr/dkpgygRLzNmnzsvqg6cfTAZRuMgf6Dg1E9fSwXpmJGYe/
	XbanqDcTiMJB0BKknLqIw4aLd1VH0D/x1CiPAx47kUGl95DSxBj70/OvyXu222iuHdDQjKzQgge
	UQfEcMHNBYkBEwPgINBgWMv6EK67x8WvNYc0P+YU8xWh1LFU1HVBTm9t9AJBb7vTp36OO9iYUJC
	kg1DafvKKKYdKRjzSJa3VbjK8HHAFNz4p2i7lZSRAsXQS4O3Wj7ilPkGYrorncMdwStz0fYB8ZL
	edEyfhxlW1y/N+WUoqMEUhqCKKEkElw/UOV4ZMEwtjlUGYItAtaK/D9hLJ3o2PQ==
X-Google-Smtp-Source: AGHT+IFqzpISbqmNZOG0bEFOm6WKZWXC8Tmhcil3Siykq0hDNGwZJ8D8UA33BLPp/sr08wWkDb8lvg==
X-Received: by 2002:a17:90b:2691:b0:330:55de:8c20 with SMTP id 98e67ed59e1d1-339eda4935emr36148338a91.2.1760392560121;
        Mon, 13 Oct 2025 14:56:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:55:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:53 -0700
Subject: [PATCH v20 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-1-b9de4be9912e@rivosinc.com>
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
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
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


