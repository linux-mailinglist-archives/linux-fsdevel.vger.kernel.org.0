Return-Path: <linux-fsdevel+bounces-64042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C6BD67F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9400B344E7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B030EF9D;
	Mon, 13 Oct 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="T5KWLza+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC430EF95
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392606; cv=none; b=e8MPC/SS5Yzx9567wCZzgg4GqfjlVcRaPU/tp0snnz9gaRozHq7UO0Xll3eCN9CJorPGOIeqBX8XGNdxd17q2zjG2Kk8QiLXRYbLD8nouUlyYujXCUmin+OzJORggHhGG3TwB2dNzfrOjrA3NaV/j/D+r6x9h1mijlEgoceZALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392606; c=relaxed/simple;
	bh=I1jqcPRPd1hxfvYCXrKsXB3tX7WWaFK9J8/4Z0z3BE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2mHXqJbref/z2pZC/yZ/rI7Ba2BH9hXJNZUipssuEyqqExCwabJAV4dENEEQq5cbt9V3YUwbins8n9PQhxVcMjOleG0Qebzha//YjnzlNsRwf4SF3XksjgChXrvJ/HJy9u3ZKuT1NDI7N+ajOTojA5aR96lh7bstyBWJJ59XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=T5KWLza+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso4012587a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392603; x=1760997403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=T5KWLza+iGXUyHRBycXhmvm/1Y7ZB6CsAV1DSsyEsACpd87IVU3ClrVHyZe7Z0JTUx
         JehjJ/PJPu3sI5K20XvyuH22Hf4p0hP/8s6sTJ2a2QU3y6ft7Q4e4cUfCXjPyj8iPCQ1
         sVPGc0i4NXsRpvdYPNJILKjyfisaucuDojGlSjF4D5uNlXw2Wa1YuL99hmh19aL6lTO9
         jC+UAWfhmfC1pz+pOKVFca8TJu7FDt8eVew7Fw726hPI9DTSzkeo/RxE8xv8AHeKg0c6
         ogNeo0YVYZqlR7f8hhqBLCsq+NQj6R1Rc5GpZe3DCJvGYR+5nbfiEvYFL43UAj/m+ERH
         /L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392603; x=1760997403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=TCuNRlxEt5++LFVWWTRt9g3th6ls6Nnqmboez7AwBbPXm3GxmXCAgCkO73WuNBKCnM
         SN0RnQqsZ7kZ7aK5t3KQu+Htq4j5HIPysPI8tvD133vOd0k8aOtbUkvTcaGanC/7KBL2
         wU89+26wKTCkhKFI/X82HSd05HV6Rjeia1DPm7+hjoM6tn/Hl/07jmIEafqsL4n+/GEt
         JOBENxf41QBAy4WQMm/BJ6Q9sbQuKM1kiFIYb2kZ0PcNjDPTXl4UPp1iVUbJgpWLjEO0
         DlNx547Gesc4R3FkhyeAfcEuU8faoXbo8HNxeRNxMI0EcigHXryty3nR9akMli9xnnR/
         fTaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6sayRNYnt8vtmUQFj+/gbP5g3qdEHsHiUqzR0tHeNHhWbCYTtJOpdHiqSh598VTRm06C4s0LNsEQM5ijD@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUgake/6s9UKUIpr7KQM+p4wluhyoQc8TPlyb/soPJbvW0wvA
	Oa3jz9q4PxpS6Y6zLx4pmPJb6D7ubpS69tJ6Md2d3ZJtDkVMvaHyXoOHFsNRlJW44cM=
X-Gm-Gg: ASbGncsT034jUMFjDNVZvkfVNgMWTqK2AGuGnIj52d9DooQMaNoBvgJuL28l09t5hAD
	yv7GkWnaFyxZIZ9J3hAmY0crIomPnUZN7RfhGsWQ89BNZ2kQIpH5Gkx7VYcqc+FlF09BMVTRcAI
	FTsaj2FJwhOjPYxOKRE+Ug7fLW6f3DNCvbgZFf9kk0Cb5iWQ3OF1XqVrmfKpXBkgbpQewIgT8Kg
	e74Okz8PHNPfZSYrvgzOtk1LKDacnYsiVWhINrcnIeg+R6EEIOaU623yimgqwx7X/sSX2qIxprC
	bbcHDZ+5TCaO9VTkdxxRSYQVspU7A79+pzP6vbgq2cwNAYNMxPwzd/4tIVeqOl9d8DX5tE0nEEU
	viCmFMDcW1kzfENWnBolNzh2QzUV3zKxZ71xcc73dZJs8zjGPM+M=
X-Google-Smtp-Source: AGHT+IE3NXVbgrP/RYPydbW9+drnd1N+r2sI087097hN50jn9gE4DDohow4FO1i/KcQ8Qec2oH8NZA==
X-Received: by 2002:a17:90b:3908:b0:335:21bf:3b99 with SMTP id 98e67ed59e1d1-33b5139a3c6mr28585062a91.32.1760392603453;
        Mon, 13 Oct 2025 14:56:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:12 -0700
Subject: [PATCH v20 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-20-b9de4be9912e@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.43.0


