Return-Path: <linux-fsdevel+bounces-70871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D1CA8FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 076DB3001C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82E35505E;
	Fri,  5 Dec 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NVKiUuMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE350A34
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959856; cv=none; b=RuUT00GfQbnEjq/RLgK0jgAkFuCJA+1BwobIBUmEmu5F3aF9XXV++JdfVlqalRdp9Ns7HQHWK4tZ7dqikDb207GqdsW3S5IhaZZbszN26QEMhHwjyBDgRBlEJJGHzQkdyOoKpVaacVRX2PjgjGHOJ90dZL5sS+80gIlG4T/SSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959856; c=relaxed/simple;
	bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrTgFD/ZN+wk2J8kIyz9reSqeiywB3Vy79EXKatwTqbcf+SL0BRjxn5dEb4tU1Al+W/CdNq9bE3uS4pS4T5K+pkJJT1ddhmzuoLzfhSme1pQFFtaUrFwwDPrR7ygRI8AYHUtyR629lAMUCMxseigCZLQwtuk2CVNN6p8ad8fUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NVKiUuMy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso1555640a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959849; x=1765564649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=NVKiUuMyNgGw92yCMyCjdpDG0JgmSWC5u00V/HAQ4oOJ8QjBMNret5j7IauIVYWZW6
         aRRDiFFljsTjIIYII+VJGAw6ypjI6nQQBEclHP9U3uIHLCK972QoOG8p2m3EDvYcOAHm
         p+I26dqZZRLqpclZ2L15NSdblTSfrGfFPSRI5KMi/H6iVbFKpuGxmB/Cno3sbi+g6gce
         lIexN85jnDVbBXtUVrGWY/MUMmdSGOzYQQR/iJZJTuXoUPd2XfMQXNAPQzZYKzss12Pz
         E5jTD/AJ+45Ti3Hv56/hXt5IfnM02zh1RwgSbTC6rWS1glp+QvDrDU7H+m4pCI3A55Zy
         swww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959849; x=1765564649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=sLuixJR/8vGrbcT9z7JCre6dswYqn522f1L1j13apLsd2NlJviqzaxpil95uN49j0P
         fy9aKaoBU8sowHvLiA9wqE9Dw7v3N88dOZ83+iB+bc4sa6c22Acor2oKzJw+cdpw8vzW
         eDobHUKu6NREaTqZXe12E40RMycsx8m5K2pogSH5BlFWsJ6vYQRuyKTluOv9N3aYZUdT
         u2tglLAIiDbdTuSpQN54vz0w4tvZjgUuMCYPUClLo8v5zCVe5sfhiFigJ0N7g33jHpTZ
         Z1SuseEUTxmQtEUytwmZORZFJj8mbOKvzx5wqN1St6XpGR8KAznvje9ihWX1gvdNVMuc
         82QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDlkaTyNNX2GI33Eri+RIyU1FLHypR5vU+Ll0tu+2AGGonhzBxQPx3TrzDxb7NQXkmoZEHYqtSeRknJwhC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6a68UT6k2TBQrBaE6M5YiNQ00aoYSpqCKsaANUzt4y6lcH/fE
	QkEo79D4Cg8a7lSE0mVca1ar+h02TxzACbjk534DvuEd/f4DPUy+R+CNYPoDPUEEW2o=
X-Gm-Gg: ASbGncudeSlefDPJA+m+4wstoyQrPaFO38KBkdb4Enxasx4iSZFLWOp7bWIOK8zHaSp
	hZ5rbN4cph8DdljzgV8rUC2fwJr5uFf6X+GUxx1uid9DEgb41L/uABuchN+QSLewUtJ4dXrzoB1
	Bkg+FaTRz0T/4DOqw6bvIGID4IXGRe0eI5t4CvwBenb5ZTov3Y3MnwlW4mUAlFvuNGN4Qwe9ZGp
	tTKn5qk/+3oNO8SCfE8DiTgumIFE7Da+1RgJ5vOK+DNmVyN//ENyXDP+LFSLvBxyh6N3CLL3jro
	LRW0MWBijWX5LabuwviYstrn+X0NsPUrwY8rqyD7+o4ieTPkOilDYFZBbqzsq4zJ+pqmOuyOChy
	y67QIROgx5mo35QFzFywp1kY3uNx2/K/Zfcypyae1KHOiIn4HqeVKH7qRZEoPym4f1NNtpxwDhO
	dyXN7Y3+thwir6Hj6rvDXy
X-Google-Smtp-Source: AGHT+IE2xGqf6PsGRkrxaqECp1R5gZSEA6uoyMXhatYShxnn+tFhMQT5orx1xHyQl0N4uRXeo3OQqg==
X-Received: by 2002:a05:7301:f07:b0:2a4:3592:c60c with SMTP id 5a478bee46e88-2abc71e17e9mr78847eec.29.1764959848864;
        Fri, 05 Dec 2025 10:37:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:28 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:37:06 -0800
Subject: [PATCH v25 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-20-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1494;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
 b=h5kVDkaUUUs99aJk0qS23WgDcswkl3+9vDfiJ5qfqx4Kce4+ENPu1q1DoLCHOQG7/oTl1GxgM
 WtrUtrWksYgCk00mzDTDyGq09yoemSOOYeLn27NuQe2huLJS2GIT4Gi
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
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
2.45.0


