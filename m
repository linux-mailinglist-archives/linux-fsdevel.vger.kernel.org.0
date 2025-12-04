Return-Path: <linux-fsdevel+bounces-70732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08964CA542C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C5D63083C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36CA3570A9;
	Thu,  4 Dec 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YkBD6sFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097B3563EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878697; cv=none; b=WhI3c+ONJ2JwgCWrEeNW0G49zTG/fX/gP5wJjvyCCXAbBrA3k0r2OAPxhy30b3EIukKV6Z6OnYv4xiXJhW+xff7HqrTeRwDFKPjfR9YraeMulwuma+q0ZrNNTJIHFIHJOIXKCi8AEbPALcYlRuIXArHVaYHO4eIrtazt0/ByYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878697; c=relaxed/simple;
	bh=GiCnSZfNClKK2CdWmrXEmd0bYUvJAFoWYsKe5kSxOSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1pbfJqdv4ccFGMV63KEQaQiotMRpvCreEkZjgED/GSRXg5h/N7ROpC9odVSX2WeimdwVXOfKk5Hj4YLmu7S20cGJpk7BXcKtccLEOXm8csVsd/HBB8IPefRu98x/j7Nt2tCAe79/zTXP3d+pBt+G2XhEzCiJgjvHRh0BZSv2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YkBD6sFr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso1098098a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878693; x=1765483493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNLwG4v2L1DyoJKfQ+mNc2uWAgHqP8MU2WLVeU0Gun0=;
        b=YkBD6sFrNUlFsCQOKrs09kNtR0pokvssJ/DM44WJicrAah3yQPy71qdSbz86i1DD0g
         6qLwyIxmrUqVVTFVgJR9YHKTyN94IHkI1ltOf/xE7Gl9cZwLqAfFlc4mGdpKArf4nO+9
         Ifj7LkZuO48fkm9xxO68NxVQWTG6jEJWdlnlf2QzsenH+qIAuVZzkoxj6qnlLgDd2Exv
         H94d4M8O0j/ua4MCtnP/w0g08qvQ8OQimQ58dPMOBDho51evFJuTyM7RUZyQXHAcztQd
         4GhrM85+a3iNDQMMIFR2RcRfDrtd6apAGK+ZJZ6kpr84PTo5yTK/EXhS7ULnIapmAwcU
         qSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878693; x=1765483493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNLwG4v2L1DyoJKfQ+mNc2uWAgHqP8MU2WLVeU0Gun0=;
        b=E3qRNNUVH4vsDyOACkRwsKmwxPO6m5CTrSZ+xTQUiSqQ2/Rjt3mEXlJHppnwJnzbVM
         m8YjO00xtCwv7FE0J/dT7ePGZC/5tNQsumysmkE5QbreLubruncEmIPwptl6mXkkGH5+
         iSBgeH5FEqCjT5xSUPwfPk/r0WHJTksH3XH+pjRQgTtcs9/tvmHESUBnd1X3hiSoewnZ
         MFKJ3UDwaqoLTFeZf+x0WqjFoMBI/LQeuXnyteARjzRsj1GuRQ2E3NROnb7FTCk+rqpB
         ZJhBi/uqp0emmq1iql/lqMIOCBZk+23k+cQsy7EBDgevsJuGdFtCfAX72cJ7dd7DvFdh
         1UAg==
X-Forwarded-Encrypted: i=1; AJvYcCWNXtROi8bY+mgT1xv7CvAjVnaKF2Lhpr2i0lNTyvs3N9tUWclglLOdSCT4vYhYg7aMvf4qnYqfWSG68qSL@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZbvfSkDjCXVyCKObagECYRSUiJHWSG+71lyEZpZ8PeivJ4pw
	3ccOXaq4WwlB7rDOG1dXxs4F9SZ2cG8rWkUyjM5//bORB2MLPpTXJbZ1JgRb2qbyZ4Y=
X-Gm-Gg: ASbGncvTZgNl4//o9G+JPM0VAohOFZep5YytP+fDOdrb+++ZoCHR7L07vbG8EY0gdqZ
	AJNepeBlFa042WcTouE6AFCdb5NCWs+lec4O3cLnPapcN9LT7gSBsmH5w3o0Ul6UkotrfJPEoJO
	g4SwYih/MsFt3XuVs4wxQDFEae5HjhVmHde+cHz8EeB8OhiUm2nNDVuPIJnzzJHu1YoQu2950Cz
	TuFhhjijo69dkWqCE1WFGbhpIaEcNshgkmHTKhazzAxbXmUhZ03EldgoTlFKHMXNrhWT/L8QmMe
	av+um2tbCSS55CGSN0z29EovXc5g4PBTpVHt1TisSIzKFS2syQn9z6JwewpvzZeKDB6u2eL2AdG
	U8vJ4Hn68UlOhBV5Z+VsSpQF6W9CP8CDtnSR/x5/uquiZHGIHVueOua9ZK7dxkH7PhBs08RygA/
	fUYuHCnbs9/FRR/k5Ttfk/
X-Google-Smtp-Source: AGHT+IG/Agb/f0tm4aAMPWFlo/ySSJaxYhCPhkZCo4KR1UhgAl3BeS6rOUHygUmT5B4w8bw/2ZdMpQ==
X-Received: by 2002:a05:7301:1c1a:b0:2a4:3594:d552 with SMTP id 5a478bee46e88-2ab92e85aa0mr4082091eec.31.1764878692885;
        Thu, 04 Dec 2025 12:04:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:52 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:16 -0800
Subject: [PATCH v24 27/28] riscv: Documentation for shadow stack on riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-27-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=9746;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=GiCnSZfNClKK2CdWmrXEmd0bYUvJAFoWYsKe5kSxOSY=;
 b=eQDyw+CJmQ8c/U9pzRERkDMvAnQzWr8Y70SsEWX+L7dmLV9NxaGvj9hlh1s2HlXbuuN10HFdY
 PvN8l91sndwB8TsR3iIsnmIJbjgTjYJMe3khiAqZkbNYGG5c5ebCU9S
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Adding documentation on shadow stack for user mode on riscv and kernel
interfaces exposed so that user tasks can enable it.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/index.rst   |   1 +
 Documentation/arch/riscv/zicfiss.rst | 179 +++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index be7237b69682..e240eb0ceb70 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -15,6 +15,7 @@ RISC-V architecture
     vector
     cmodx
     zicfilp
+    zicfiss
 
     features
 
diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/riscv/zicfiss.rst
new file mode 100644
index 000000000000..7fb86d5ba120
--- /dev/null
+++ b/Documentation/arch/riscv/zicfiss.rst
@@ -0,0 +1,179 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+=========================================================
+Shadow stack to protect function returns on RISC-V Linux
+=========================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable shadow stack for user mode applications on RISC-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result into crashes, however when in hands of
+an adversary and if used creatively can result into a variety security issues.
+
+One of those security issues can be code re-use attacks on program where
+adversary can use corrupt return addresses present on stack and chain them
+together to perform return oriented programming (ROP) and thus compromising
+control flow integrity (CFI) of the program.
+
+Return addresses live on stack and thus in read-write memory and thus are
+susceptible to corruption and which allows an adversary to reach any program
+counter (PC) in address space. On RISC-V ``zicfiss`` extension provides an
+alternate stack termed as shadow stack on which return addresses can be safely
+placed in prolog of the function and retrieved in epilog. ``zicfiss`` extension
+makes following changes:
+
+- PTE encodings for shadow stack virtual memory
+  An earlier reserved encoding in first stage translation i.e.
+  PTE.R=0, PTE.W=1, PTE.X=0  becomes PTE encoding for shadow stack pages.
+
+- ``sspush x1/x5`` instruction pushes (stores) ``x1/x5`` to shadow stack.
+
+- ``sspopchk x1/x5`` instruction pops (loads) from shadow stack and compares
+  with ``x1/x5`` and if un-equal, CPU raises ``software check exception`` with
+  ``*tval = 3``
+
+Compiler toolchain makes sure that function prologue have ``sspush x1/x5`` to
+save return address on shadow stack in addition to regular stack. Similarly
+function epilogs have ``ld x5, offset(x2)`` followed by ``sspopchk x5`` to
+ensure that popped value from regular stack matches with popped value from
+shadow stack.
+
+2. Shadow stack protections and linux memory manager
+-----------------------------------------------------
+
+As mentioned earlier, shadow stacks get new page table encodings and thus have
+some special properties assigned to them and instructions that operate on them
+as below:
+
+- Regular stores to shadow stack memory raises access store faults. This way
+  shadow stack memory is protected from stray inadvertent writes.
+
+- Regular loads to shadow stack memory are allowed. This allows stack trace
+  utilities or backtrace functions to read true callstack (not tampered).
+
+- Only shadow stack instructions can generate shadow stack load or shadow stack
+  store.
+
+- Shadow stack load / shadow stack store on read-only memory raises AMO/store
+  page fault. Thus both ``sspush x1/x5`` and ``sspopchk x1/x5`` will raise AMO/
+  store page fault. This simplies COW handling in kernel during fork, kernel
+  can convert shadow stack pages into read-only memory (as it does for regular
+  read-write memory) and as soon as subsequent ``sspush`` or ``sspopchk`` in
+  userspace is encountered, then kernel can perform COW.
+
+- Shadow stack load / shadow stack store on read-write, read-write-execute
+  memory raises an access fault. This is a fatal condition because shadow stack
+  should never be operating on read-write, read-write-execute memory.
+
+3. ELF and psABI
+-----------------
+
+Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_BCFI` for property
+:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+4. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of shadow stack. Thus it's left to dynamic loader to enable
+shadow stack for the program.
+
+5. prctl() enabling
+--------------------
+
+:c:macro:`PR_SET_SHADOW_STACK_STATUS` / :c:macro:`PR_GET_SHADOW_STACK_STATUS` /
+:c:macro:`PR_LOCK_SHADOW_STACK_STATUS` are three prctls added to manage shadow
+stack enabling for tasks. prctls are arch agnostic and returns -EINVAL on other
+arches.
+
+* prctl(PR_SET_SHADOW_STACK_STATUS, unsigned long arg)
+
+If arg1 :c:macro:`PR_SHADOW_STACK_ENABLE` and if CPU supports ``zicfiss`` then
+kernel will enable shadow stack for the task. Dynamic loader can issue this
+:c:macro:`prctl` once it has determined that all the objects loaded in address
+space have support for shadow stack. Additionally if there is a
+:c:macro:`dlopen` to an object which wasn't compiled with ``zicfiss``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_SHADOW_STACK_ENABLE` being clear)
+
+* prctl(PR_GET_SHADOW_STACK_STATUS, unsigned long * arg)
+
+Returns current status of indirect branch tracking. If enabled it'll return
+:c:macro:`PR_SHADOW_STACK_ENABLE`.
+
+* prctl(PR_LOCK_SHADOW_STACK_STATUS, unsigned long arg)
+
+Locks current status of shadow stack enabling on the task. User space may want
+to run with strict security posture and wouldn't want loading of objects
+without ``zicfiss`` support in it and thus would want to disallow disabling of
+shadow stack on current task. In that case user space can use this prctl to
+lock current settings.
+
+5. violations related to returns with shadow stack enabled
+-----------------------------------------------------------
+
+Pertaining to shadow stack, CPU raises software check exception in following
+condition:
+
+- On execution of ``sspopchk x1/x5``, ``x1/x5`` didn't match top of shadow
+  stack. If mismatch happens then cpu does ``*tval = 3`` and raise software
+  check exception.
+
+Linux kernel will treat this as :c:macro:`SIGSEGV` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.
+
+6. Shadow stack tokens
+-----------------------
+Regular stores on shadow stacks are not allowed and thus can't be tampered
+with via arbitrary stray writes due to bugs. However method of pivoting /
+switching to shadow stack is simply writing to csr ``CSR_SSP`` and that will
+change active shadow stack for the program. Instances of writes to ``CSR_SSP``
+in the address space of the program should be mostly limited to context
+switching, stack unwind, longjmp or similar mechanisms (like context switching
+of green threads) in languages like go, rust. This can be problematic because
+an attacker can use memory corruption bugs and eventually use such context
+switching routines to pivot to any shadow stack. Shadow stack tokens can help
+mitigate this problem by making sure that:
+
+- When software is switching away from a shadow stack, shadow stack pointer
+  should be saved on shadow stack itself and call it ``shadow stack token``
+
+- When software is switching to a shadow stack, it should read the
+  ``shadow stack token`` from shadow stack pointer and verify that
+  ``shadow stack token`` itself is pointer to shadow stack itself.
+
+- Once the token verification is done, software can perform the write to
+  ``CSR_SSP`` to switch shadow stack.
+
+Here software can be user mode task runtime itself which is managing various
+contexts as part of single thread. Software can be kernel as well when kernel
+has to deliver a signal to user task and must save shadow stack pointer. Kernel
+can perform similar procedure by saving a token on user shadow stack itself.
+This way whenever :c:macro:`sigreturn` happens, kernel can read the token and
+verify the token and then switch to shadow stack. Using this mechanism, kernel
+helps user task so that any corruption issue in user task is not exploited by
+adversary by arbitrarily using :c:macro:`sigreturn`. Adversary will have to
+make sure that there is a ``shadow stack token`` in addition to invoking
+:c:macro:`sigreturn`
+
+7. Signal shadow stack
+-----------------------
+Following structure has been added to sigcontext for RISC-V::
+
+    struct __sc_riscv_cfi_state {
+        unsigned long ss_ptr;
+    };
+
+As part of signal delivery, shadow stack token is saved on current shadow stack
+itself and updated pointer is saved away in :c:macro:`ss_ptr` field in
+:c:macro:`__sc_riscv_cfi_state` under :c:macro:`sigcontext`. Existing shadow
+stack allocation is used for signal delivery. During :c:macro:`sigreturn`,
+kernel will obtain :c:macro:`ss_ptr` from :c:macro:`sigcontext` and verify the
+saved token on shadow stack itself and switch shadow stack.

-- 
2.45.0


