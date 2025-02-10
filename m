Return-Path: <linux-fsdevel+bounces-41475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC8A2FA9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0029A1688F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2793262D15;
	Mon, 10 Feb 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ox1qEj9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA02512D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219264; cv=none; b=A0jda6H6Bwn4wu0QMDz2H3/JYOnpAjVs0MRnMuwX7ZPS+7Ak/pbzznDqHnlUuig2yUlEKzpaBdTslTPOspId1LPCvO3Ipra10zG3VHXMih3NqJ/Q39UxQZXyrp37C0+QdcpA+avncW6byakdBnVPtHLbN4bRK+wkvIieYItxZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219264; c=relaxed/simple;
	bh=Eua84f2QnuJ0+u1eEfH6+3KRo1p7kHINzNbKNk8bPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXxiTHbJpZnCBIzn3GARNqAcQWZmo0S9fDOdURH0zsHfcNudAK29YwT4GDb1mbwZQtQfyp9n63cajLJku5oQj+jSE0mbOjXltqngmuVLUFIsYh4KyAXqh5l0vx+n+LTtH0S/J0/o2Ye3S6WuF0qm+o5UZZoSM0yP4F8mBnB0lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ox1qEj9/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f40deb941so100127645ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219262; x=1739824062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=Ox1qEj9/ta39TC7S3n4ObyzPvseFq1fDw9iDUqF6RnLr3aqFd8V/97GYnNvKojGVUy
         hJAevFaQJt6+FhtPv+BnEX8rt/OnKHtBOjxUH3XMY8zxC+TAGcBJzqOSAKausEB9+dAC
         lB4xRjZUk5xi4YiIQ40whB+YUGvlyPRviQ3W3wBcBQxWttDR3Jv7vKJqvcNM4+fOiORy
         NoJ5x5qAWIsDJ3GtPTRm01x9H8tsPUuCQ/j6RWuWxqT7008SUWmwSGAwOyae4vwwwy7W
         7terdv657O4kSWVOkfBh8Cq/jZmAbQsPgX4KswzmpA7jAP1lxfnzkHCYCzBHNPDIQnTw
         UaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219262; x=1739824062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=Buvzrd0Q6aGCm7DzJOs3j+rKRJ1OxWIaNUePSoXYOuJg00LKmsj7NbZGqrSasWQuMs
         +eHIyMWcm4SXvcn6g0ZCUrYMnT1Pc+vSqWovDhtPddju6JFAx1BGEzKZS+fT3bFVbP3b
         RaBqL+ep7gLaPcH6tVjv5LMHoUG/Ygh+6ZT6ws3+UdPpdJNvKykTFohFJ5qR0SNw3q7O
         6UzwL476969qHXsnhAcU5I1ZQ3kay71h9t0TD4tJsyEpPfFzDOff/dpoCS8ehTXlxJLY
         q8eFNwe2VXHs1WsQxlbs3iQdg+5OVeP0EpOUBQU+24jYy7xOxIdpL6poC68ZhEQ96fhs
         +a1g==
X-Forwarded-Encrypted: i=1; AJvYcCWUnvzTyxXpveJrAGTW4p83Ob8oPOviYPhhSyAkdrJviimlZs3Ib9LEpdBd+QPWXy/VMP2TKwyXBczSoUoc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UoP6srNBHQ0uWBzaBftRrHXQaw6JnMp2YqEbqMcZHB5Rfi1V
	phF8ORbi+L6x5AByJpx3eI0iFl0eD9x13AMDdV5kdPAgfCPH9PiPSMdjozhuDstNQNoVi71L4vR
	/
X-Gm-Gg: ASbGnctrCJAMwK7/EZNR6seuB19V8oLGu+/+i6juXDEzdAJFYocTKE/ebrN4O0fc5I7
	bxHj54UJ0rMKCtG3S1LB4dB1LQaBRa1PeOKrxx4BZy8/UTzhJQ4x1LN3vUsMFz8V31Q02gUS01w
	AKar65GqMkkhIQ9AC0q+hdIk3h9eO22F3uJZh12mhHNZvJrxs7W/hYgLBWAr4VDmsTG+3PTYxhx
	78PnUKWnjXtgv4BXF8wyX8LzzLxr8ySvqAK0xiQQA3QUxbc1iBwihsc7v7gl+DAugmpr0VwANnC
	4uJjg/7jPHFHpp6jgCEX5bIzeA==
X-Google-Smtp-Source: AGHT+IGvJHthtMMIotmYr/CK0oOoURKWcK3k+qdOAPpSTfBW1H5FZ/zO8d2C9jHOqU/wdcn1U6s6JQ==
X-Received: by 2002:a17:903:2311:b0:21f:3e2d:7d36 with SMTP id d9443c01a7336-21f4e6ceb59mr270827895ad.1.1739219261893;
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:57 -0800
Subject: [PATCH v10 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-24-163dcfa31c60@rivosinc.com>
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


