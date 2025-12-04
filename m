Return-Path: <linux-fsdevel+bounces-70731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D782CA5459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0FA31C6E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE73D357710;
	Thu,  4 Dec 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Mort7gkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EB34BA4C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878694; cv=none; b=jkPM1kztjsIhHbf8527EG0qXoe9xhLX3qx4NQySwuqiGJV3JyKYZwOWPSsNs+2uNb32V7kL5IFmwLOP0MzH9EAug2N6vucX2QPfyXL1tfnnMZnt2/xCN+tJtLKDcU6bv/ztTsmYB5Q83jMcBs9sST4++hA/YjCyTGlm6SQ301XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878694; c=relaxed/simple;
	bh=qc5jb0VBTvMD5i/U1+IxkjxGEykvbO4mg8nEvnUxuns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFiHQm42xvLbx1VYPgv1Q+qhEy7x1sHvlYyiWcR+3gqAzd5i7pYUw1CGQUyfGvfoC8zaWswO8TJQSWw2U1d2kyffMogEQwfXoh/mmcR738Ht/dZVSpyrZ7/sk0qj1W1nvNWMn5hA+FKX3u5WzJ1dubq4NmqMmzqMPEXyGWhHZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Mort7gkU; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2959649c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878691; x=1765483491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUqoxQ5CjiuDs0GKdFRZ0jt11JFnCh2SjtTuYqVD0Ko=;
        b=Mort7gkUCfcMAHFPkXefrSf6eAU4sSTorQL7HrtIcCLIKJzY3LM8SjHwXDtPMeqUl7
         b3RG3e+I3pxDmwX+YVpHP4UXEzDyUL2zvbfJUzXQnv1jVnUBJwJ4WSkujQBrFLT0RGG/
         zkFtTMv+d4p0gmIIaF95e23eBj6bgoogYhJ26E08QFaZRbPsjVDtgHsbuVny4vcVVpSH
         8Y3sjmk3nZLFAZv7TFcjiTYeRE8A6KnwF6GLSoopNvU/2YTVIETdvf3AFrXi3Zorb0/w
         IkHDm9P6WeL33vPS0gE0KEPGHKQfrg7UMApygsLpeLLLE+PLrzgOPLfqZplQR1/kgPfN
         vu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878691; x=1765483491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUqoxQ5CjiuDs0GKdFRZ0jt11JFnCh2SjtTuYqVD0Ko=;
        b=mwWYjK5DQ73aA6YuY6cV0AJlD/3vnd738GgPCi/v1TnL2KrSt9yha/2OBuN9hYVjDx
         Z3BflMZ0o/hQup/fZHX6HqLXg85p09nJh+oL84m3+OyfiXKHha6nrjBaJtMektQDIYMW
         9ON1N3ZItRf25jmGjAalzfG6GmhhFX7zULt4cI6LoqdJo2tGSuPdE8OEkYSfjeElFKWs
         u3syf1evNxAy9j9E4GzbLMJaD2mfF49cThXFEQ+8EhsSJLqKsBceVTURUEEWi8HU9HQU
         ggDlGN2hZCrBVXkEVqFao7PlPnyAs3HRwwNAtseBMb39qQzl5/DL5vh5oFE2tskZd3MF
         U5mA==
X-Forwarded-Encrypted: i=1; AJvYcCWKvBWxv4Q0zJ6jyUu675XTk8Ws/Dm9O8ZgVO5OpV86AFWvT7uPuwkMWwGLc2bRbM6+fy4tKvqpQCV/D0fk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mbROYDkxos6sB5+QYrXDGmB59TPi5/I3v0SHBxkJaIUtAQmA
	ssZaDZsvy7pA9jxVehS18MrywFlac/Tvc1Y7QfqeN6awU6czj8jSB3Whe3cDIpt0KBw=
X-Gm-Gg: ASbGnctCQLFjWfGfxYs8/Qs/SYRveGg5qJwPSvUhdxbPaRSGkZsdX/iG65Gbqikbtmn
	D9LfIFVJZ46ZYDP6NZvrPYImcw1TSfbLnZpZJwo13PFAfuEJw+8ebnxfe5sZOkydEiXMNDenK6C
	BoCG4tEb++oL/QW/T7YCk5qfQMk9lbH670WLlVzxT9MmdXcnh7luo8IkHxsCwe1siSYquZzV0ey
	0pp2tzRIdmbiehePxvwv1OfJkPP2WRdAQra6spM7HOpxMIu/0WBD+Tn+L/CZ8s6YBlnVE9dnpGL
	ZXCK6hZHAyHr7cy34UpO85USq5GEbIbSmnX1/PS4JeO9tVoAR6kzPm4OEIwHSY6elvd1GTDu7jo
	2Cxf+ILM0gFo3pGaidHi8I5C+VwAD3Ge48pPnerPa24NBk1MVFCCM0JfJiQ80xyBsrPPJC6uqpA
	Urbcg736yh6rLHh4Hr5XFI
X-Google-Smtp-Source: AGHT+IGiwuOlh2qwyHr6IpDY10nGTQeyW0GZJ4L79tinCNU61MCohBC19s0o+eYrmeMWD1XB+prpdA==
X-Received: by 2002:a05:7022:6999:b0:11b:9386:a382 with SMTP id a92af1059eb24-11df6016757mr3427632c88.21.1764878690899;
        Thu, 04 Dec 2025 12:04:50 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:50 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:15 -0800
Subject: [PATCH v24 26/28] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-26-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=6128;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=qc5jb0VBTvMD5i/U1+IxkjxGEykvbO4mg8nEvnUxuns=;
 b=i+38omcnFs7+RGFeIcjnYoj3H2uZTRCXIbBxmni/2r4/2TvXGZrsP+gBajN7oQMWiqR9kQqBN
 Desh7xgprmeB1xUQ23jD6r0KLCh6C8YEl6ZRcl42648SR3NgskXRQzH
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/index.rst   |   1 +
 Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index eecf347ce849..be7237b69682 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -14,6 +14,7 @@ RISC-V architecture
     uabi
     vector
     cmodx
+    zicfilp
 
     features
 
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..3575c7db2cef
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISC-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result into crashes, however when in hands of
+an adversary and if used creatively can result into a variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control
+transfers:
+
+- indirect control transfers must land on a landing pad instruction ``lpad``.
+  There are two exception to this rule:
+
+  - rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+    protected using shadow stack (see zicfiss.rst)
+
+  - rs1 = x7. On RISC-V compiler usually does below to reach function
+    which is beyond the offset possible J-type instruction::
+
+      auipc x7, <imm>
+      jalr (x7)
+
+    Such form of indirect control transfer are still immutable and don't rely
+    on memory and thus rs1=x7 is exempted from tracking and considered software
+    guarded jumps.
+
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate with x7. If ``imm_20bit`` == 0, CPU doesn't perform
+any comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must
+match ``x7`` else CPU will raise ``software check exception`` (``cause=18``)
+with ``*tval = 2``.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function prologues can have ``lpad`` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STATUS` /
+:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect
+branch tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfilp``
+then kernel will enable indirect branch tracking for the task. Dynamic loader
+can issue this :c:macro:`prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there
+is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
+
+* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long * arg)
+
+Returns current status of indirect branch tracking. If enabled it'll return
+:c:macro:`PR_INDIR_BR_LP_ENABLE`
+
+* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Locks current status of indirect branch tracking on the task. User space may
+want to run with strict security posture and wouldn't want loading of objects
+without ``zicfilp`` support in it and thus would want to disallow disabling of
+indirect branch tracking. In that case user space can use this prctl to lock
+current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions:
+
+- missing ``lpad`` after indirect call / jmp
+- ``lpad`` not on 4 byte boundary
+- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7``
+
+In all 3 cases, ``*tval = 2`` is captured and software check exception is
+raised (``cause=18``)
+
+Linux kernel will treat this as :c:macro:`SIGSEGV` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.

-- 
2.45.0


