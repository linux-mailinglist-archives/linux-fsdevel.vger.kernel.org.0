Return-Path: <linux-fsdevel+bounces-40889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82DA2813A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1813A494F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723E23098F;
	Wed,  5 Feb 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yh9HGE2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6622FDE5
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718562; cv=none; b=hb4kMBJWXUz5/J9qBMtIVIw5EkUXoJ8wSv7zXICEp7JRuNmFSvrVSpTYAzDFCPhnMn9aLoKMrA3ql3QGWp7uRCX2sHg1A4vbVbu3vutS/vOpCeHxH6IyHkaRp+FgiP/XdeldBqdvTa0Ai6MMLX6bHZMmseHPGCndoooHveKUKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718562; c=relaxed/simple;
	bh=Eua84f2QnuJ0+u1eEfH6+3KRo1p7kHINzNbKNk8bPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZQ8vIjKdNsYI3mG02yVXLLbEXaDx5lINw0memshQnVYF6elo+NatLNi81qcfz9qsXpro1qIs8sOst7QIzJa2XEJbA9CjSKG3t9efRI+guVWHqgx/k1rka5weFTv4InGaz4edslVJXb1Z/K8N8YeojjT/JFWntjEatsc4RJRmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yh9HGE2P; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f1b2480a2so397105ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718558; x=1739323358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=yh9HGE2PmGhs3vPFLuK0ah3bVl3T0btdW7r6q6h6uZGjsfPB+9lNxREJD16fn/C4ti
         /lfSsDK/C6BXRmjQbXhUH/HEFEs3zqm0Q8eH2Du+sptKO8K7I5t/aD+LCEOW2ak8KNkf
         kce/6VmvX7J7xml0QySq8yqEJUcwUUkKTR1mnyfpuwiT6Hm3sJ/rx7WHjIEIVO0dksNQ
         DytfPyFsljpIcc4KGM2jJlFazeYrFM7/e+N4/CcceSM7YyfkwDGr+P1C7AWRHVX8Ro/O
         wOJeUe/QJSe5oYGjcvC8O+WV6qCcc6p8HcqaYVUWppRArAuDb2LHXeULtExCRRsMJr9Z
         r1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718558; x=1739323358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=DcV6azWMHvYRxF5Pe+nSsZ2FRoeWi2njLWPYfr20iEOJNoEHOp57XSmYUw1llqoJMp
         kp/iGYrl+PfxvLYCMma6ge97lc3Ek5Hy3Xpv1bV3242Dy5EgTy0MwurlMT3G9Zq+4yuq
         qwFgSEz8pOE63DAq9UMGly+wiTNcz/J7gaVlUlftgaTQmgpkakYfMhGEEfFL2AoN1qBl
         m5HFqejsqdcYyToE9F4A903fKVUlBiwCZBwxO8Fs6x4Hiu1FXJb5vNp+hbLUZrJYhIew
         wJykTKqNWWc588diAiXP9ZryqpEruht02+oMT23zwo2DGkPlJxxLN2kLgPvzoeMWfcE2
         qrsA==
X-Forwarded-Encrypted: i=1; AJvYcCWoXlrQFtpMU5D4a0u8vMeWjzBK5c61U9Iq1SsW2HBiFIo+ojXvBskt3Yl4XFPKWL/taED1qxRAIl2geALo@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzkxdsKMQJKIUtAamKIs2Udh41G/MCna+wS1iGrYZitGNT2wK
	vW8BglGUKF4kA7Og360iP/n9WhyyRvKXC9+BnUredM5Fz7FDoy7siUWI5tRP+3I=
X-Gm-Gg: ASbGncu7+hC2HK5QlMXJa5P5xlFt3SRh81FnAnH8RZrF9JVZIX8YN1VzlToJ9r5Tcvi
	MLSodSbGd3s5rLg95LaXcwnUACMOpD8MXfDqo7Bm0eNM1lTnJ6VLNNspF2dEYWcnR+fvxZOFiVE
	/AZoRqFC8F0k3ukpVBqZDXT97pOtWqzagHqhk6Ew25ijk+OJQC/HEmqr7ctlWBCQOz3gtwBu094
	Z5FxbwXcm32/mQUpubEToQlUq1Xf9eIuAkA6XDhKDZbAANb9r1POG7snTZmqHmxkKKDZgAQ6b8F
	H+RAZd8jGQESsKNTQzpJRzBKmg==
X-Google-Smtp-Source: AGHT+IEz0qHgqun1HMRAWwYPxj4lEXbUX4lq/KHX/YPS8k5v/b/oBuAj+3XdSaG2F4SQ1olAiHNptg==
X-Received: by 2002:a05:6a20:6f09:b0:1e1:ca25:8da3 with SMTP id adf61e73a8af0-1ede8845f6amr1551216637.20.1738718557822;
        Tue, 04 Feb 2025 17:22:37 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:37 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:10 -0800
Subject: [PATCH v9 23/26] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-23-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..0a2e50f056e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.34.1


