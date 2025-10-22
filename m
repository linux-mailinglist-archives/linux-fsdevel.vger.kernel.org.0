Return-Path: <linux-fsdevel+bounces-65231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC5BFE86E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6C5F353228
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DA25D540;
	Wed, 22 Oct 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cxZUDH98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC4277C98
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175782; cv=none; b=KwLCe6N8IEU3S2UQKiBm8fIctm9yj9dVH/HUQ1cn6xC0AU9SEb+GmTu9Fb3uHMqmIXmjKRHePT39yl6lPixkuJrGz+JYcVt+t7z3dLQKl78u/rn8//My70jT5hOy/76DBwedjF3nVSPhEC4P7NDCh5MPpB0/SE2EXm9b7bFiucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175782; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtFOu/B7qd8J5p173m13Jj0cBtxp1lWmxRM7GdO+LjFqzPr9g8sruGBlWh/g4O8hwq8u4f/AVbdoax5lHUczTJqZXzOaEbFvQuCnoJEMJ7nY4mZSgpB3U5O+7UQlVaQFRg8vAqX4YCFZP1m2BtDktFZRbEZdYpreQdhsC4Mn/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cxZUDH98; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so178312b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175779; x=1761780579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=cxZUDH98xhZgcbg4HDNMwf7kcF8jvtFMZ+/PvtAdRHR2LaKQG0APf9ff+rWqysaMea
         lMazQ9R3jjZqwj5I5/lHlM+n4AvRkELLVWZhxdb8ZpU2iijXk9i+N7CuNmkz2wP9cT4a
         oxOb0PHt+0fvRPo4cIroKp9xsmQ0f1Vnvh4gU8ePXNHquHhD8lhVY5DNZON/ljof7wqk
         t9xLAoE2KpkZXNM4mEZiVR8g3uYGznkUDKHupIKq512dzBPbzlxSeYmPQ5fPGSb6PzM4
         5Qg6pEmkWWfxYwN77E2vGLlXBOhJ1wR9U+j53/096Wi28OK9LZNNXaqXKNe6S8rwJ7BJ
         uiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175779; x=1761780579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=rtAHpmpwC+z34tJWt3uk+DhfKnA6qKUlFELIHQkswy1iWvUhSlLodLyR1npFGvo3bH
         cuOQubIAvfParerP0hXzKM4DHHbL6fgpkCptQ5FaJhOcjQ8hLafbFr4g8hHDw5hIwUbm
         HUDR4/By1pDJNWwV8DaspoKB16Exxjeu4/8xE7tOgIGiTvNy6+P5VPKjs0zQIXZzaaRu
         mYNhMEJSbtxJ35v85Yb7tJzcW6IV3XzpASiybrxZTXgMrUB0xqX3EZHG3VFaxW9zlPCw
         BlOiKcrlE3QhFlW9t720eL/+ViX31LqbfFA2ZsQ/taOeIHsHEY9JD9YjDxK7/3FmjHjN
         LpSA==
X-Forwarded-Encrypted: i=1; AJvYcCUbSJrMVmRHvKCelGHMDuHE8aFjd9q8UfB2IX4K7dnZZHXeHk+JzFe53VSqnP6sUrjDHqaRSAC/r3QsKiuC@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwk6oSURJV9Hc0J3NhS1QHjYFE+k7PKUW+cKy0yzUDpa4v7yi
	84wL2LdGB41Weju4BNTSa2z4h8ilEH0hp9XaqOR1nIBEGuRy8Vrn9TndshPw+qRjql4=
X-Gm-Gg: ASbGncvRYR/szckCderI4qkPAPE5PWm2bnjnAmpgqjuynyneCzzxDbgd22TgiLiSYup
	1F0leCpbyd5pq7LvDZgNZXgS0SAISZrnH3axfOBd+3KpcguE2SlOVuNPJd+pqw/Wj1xyqm5ynkP
	/7NGk57hxZoXepsxfdM4ZllqUIb5mKovNlVPRDJgCvfumAGCVY7JzdAELEaHgRhQagbNIyK1LpW
	SRb/MWgGFVOq3XOi8AMGHqeYUNRmKh5nC2a9L36LlJmHbjUcg+BkhGIPblxClgMJLcxM+bdF9Mw
	zj3qr1pOmKCSDsD2roFvmSgr1NOnRIjs2H8MBnEOrP7GJmcIvQbr8DTelgfTReWn1HcoTMXw8gU
	1m9PDkcPbDXJLYSWcPGTmQ/A3kTj+/c4N7CgeNugwUr78kAxx4aWhS/keHFSfO7VoDw4KtV0tO4
	qMfTzHC65pNMmsE3n0JN9e
X-Google-Smtp-Source: AGHT+IH4ZZjXE6CRjcaUUDddOYCxWrMkikF4wXTDboM+YAeQwS+9+Z5nilbrQH9D7uqvoUJQSq+yZw==
X-Received: by 2002:a05:6a00:3e07:b0:7a2:766f:518e with SMTP id d2e1a72fcca58-7a2766f52c5mr169475b3a.23.1761175779371;
        Wed, 22 Oct 2025 16:29:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:27 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-1-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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


