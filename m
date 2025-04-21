Return-Path: <linux-fsdevel+bounces-46825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E415A954DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322593A8240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE61F1520;
	Mon, 21 Apr 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBncKYOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E391F09B6;
	Mon, 21 Apr 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253773; cv=none; b=YOpw/Ep8I40kOx1kjVgTMPgcUzpxbTbdZxQ9C1zPC360833EiEBVtmpLr3j/pirmhbNPOBpjzPNVGdniDbK6babycK3Zdj1tUyPomVmE1GoEuwjD3Y+v+BusErEuJxhT2CbZjC/CX1qsbqggR4IcVXKoXcH4iGTpQ6G33IyPn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253773; c=relaxed/simple;
	bh=dJnEYU/O8FUpD9s6i4Ut4f40W3FVdVgcvnoQ+BKOIFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1XFTn2oJIjkgfYSbGddCzeIEIE2hiCuMLugSVcJynqLSfGEQ/GFJ0+Bum7g4YAY4cKqpRn9g82nnVOnZwoin+9VGqjixK+fgIzAw2dk/Vm1drK6HOv2JBjOirL0zHnql/FlhISP9d+5F+k1Csx83VdcvlRiyPw5JdCdgoDO9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBncKYOa; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f8657f29so40335386d6.3;
        Mon, 21 Apr 2025 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253769; x=1745858569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VlZJudXEGF9wwtFZHglR/nFrBqPJ1rxXkCL1SoJv3Q=;
        b=iBncKYOadYXQqt4OI6/gaPynEJEgjYbsodq435Nf4WA902/AdVA4G1pixrMNmpuqDa
         wMVNAoiE2zO4PzZKwfPb6mkj1N39zeBtfQPWxu9+ow1P5rwbfTJKowpNr/FwTggOK61i
         MfwBPw3YxVSgnCdJlN9x0A6lfSd0oeOrbbXYVxNIHsWBlDQEaOObBmYGO+WgFUCd0DhQ
         QiwGqmTgao6AAyWlwCo5GgnngyeKqLha4a4HK0/CvkGXjATxhoJiIsJIq9aS5Ml/dz+E
         2b0y/KFllwS8+/lI1ome0Qd3CfWd6ysipUu2fjCoaLrlP2N18hbyP/9/FNazbRdVachn
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253769; x=1745858569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VlZJudXEGF9wwtFZHglR/nFrBqPJ1rxXkCL1SoJv3Q=;
        b=jUC4RrxwsDnKUq9G5yGWOdvp9DWZztw357JPY2rvlkNmdOtaIiiL3aIaxFZ5XegMYM
         rUWjVKgT94obDMD8NZEg9d06OI65izxDVpllwnsiReFJHdMxuKBCGA9HxbBEw4nJ93Zb
         ceQn3r/U/3QpMHYUAlKsrbFFVhVre3o4bZo/m4QWJUrj3MYq69V+z0O6FgfAYq/q+aAv
         jqglgB5hwv9UXCBF7GywgMYXCzoatblT7bjkpbCInHCwz5HxgqPYEAGdjovrHUcZUe8w
         3xpP92q1Gfq1H2EJBXmd4xszmQKI368DeDdow1iP2MoRKjau7lGFF0BOSW1l1+XVHBoi
         pgSg==
X-Forwarded-Encrypted: i=1; AJvYcCUC2wPFzbhLHAvwXexKjpEAiy1h9SrCNGIN9HciCMQ5Ik9Sc+hqFGdek8nDRVsMXmYMpT+k5hbXGyjq@vger.kernel.org, AJvYcCUILxj+Ty8SietQTCs5Qok3PXaT4bB9uz3RlQ9od0ks8jtf2SrQkNtAzgRaX4+XP2hJfPgnTgxWkB5fecaokg==@vger.kernel.org, AJvYcCV+w3HzL4T4fQLoOABFFDDoChcBE5xQed1GmS4Q0QHv5WR1/qHkca45A10+lpGZFDg4J8N7@vger.kernel.org, AJvYcCXJCCNrGelwhy9EaL9pnCP+y6kyWNX6BbKZ7lVER1GUpLtIu9tg8NwkwMzewycbev8y4ceOINRGL1YF51cp@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkmkbVT2ldllbRi1VvST2eGPIzrdnINa37X/0nZ81Z8+C9xu4
	4Os5LaYysMXpudaxipOyGqHuVSwN9BQ/FCJ/tW6nlEcibkzo1HdBgT8e2Q==
X-Gm-Gg: ASbGncuKh1/Rt20xychZcRmJSEweSDwWeNebAofoeB92eAUlOVNxsr4FeNf+Dzjhiqn
	rKW3zefsgAYr6JuWm2zp5JK+RQVPQLnFnJZ/WNHsp23OiXtLaxhuGgEQjnvyI1v2RQqZEmHcb2M
	xUYGOlMYO/gYselIBk4jwjTjCrshaHvgjWOKS+DENiaMjha4trM2FTUVi+yrvFpT42EBftFBoxg
	b4Ti9BcLUo2unnd1ceWy6U9AR7v89v7OuXai+6wbwkM+oDLfAAYgzG27b3uPDpu3huZ2fxxjUsw
	zGFhTCYGphQ6P/bHC/PjRNewiXg1N1bgwIsWKZE0BDg1uJjFYrn2Y5vIFgK7tqLbOUxu1fMoJHn
	11v/I03s2g1TBFo3cx+zIPIJGEGGXAYk=
X-Google-Smtp-Source: AGHT+IH9gcSNCA0FMXfkjNvwI0DUIj86Rsf19/zTIQ5BrJ5mdE4I+7VHPbfpm5fPPk0PcuFMV1633g==
X-Received: by 2002:ad4:5d43:0:b0:6d8:8fbf:d1b7 with SMTP id 6a1803df08f44-6f2c468839amr222039316d6.43.1745253769407;
        Mon, 21 Apr 2025 09:42:49 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c4fa0bbesm43182626d6.90.2025.04.21.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:48 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id AEE4D1200043;
	Mon, 21 Apr 2025 12:42:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Apr 2025 12:42:48 -0400
X-ME-Sender: <xms:iHUGaBQnaONjosg5BDTHdCb0t-ZWZ9nb0UA8PHXnLKz9UTD_z5LjuA>
    <xme:iHUGaKy32gwgj8hME1pMpz2wTPtsxmEQbC_nRAiSKsaxQaZW_VvrwBT7CVSyCT2wK
    QsvFTiGK-l439PSwQ>
X-ME-Received: <xmr:iHUGaG0UFWxSEmP1-S2dqwFZd5zojqz3UvQpA0IzaaxuRAXkvV-7ClsYpNq7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:iHUGaJAMs5SEPj35XBlo70J-L1Of3KmNt9i3ZvHXyL9LoiqCbHxjBA>
    <xmx:iHUGaKh9id5rZfAP_HKxKnUE5WxA_3DauTyTBRjWKO9ry0NeMaLIEA>
    <xmx:iHUGaNoMNk_KnkBIvxrSmFuI13NXyukOVKesqLapWL_CD-TCJvoTTg>
    <xmx:iHUGaFjmJKGFPyCxn--MUnUHvEECVYYlKMiyG_SSEFMhsCmzom-8Ww>
    <xmx:iHUGaFTweXWFn1pbi8JDL6KVeJ5CQ1FQgfsm5Adm1_VW3TLWgk85kHNG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:47 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	lkmm@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,	elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [RFC v3 11/12] rust: sync: Add memory barriers
Date: Mon, 21 Apr 2025 09:42:20 -0700
Message-ID: <20250421164221.1121805-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250421164221.1121805-1-boqun.feng@gmail.com>
References: <20250421164221.1121805-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory barriers are building blocks for concurrent code, hence provide
a minimal set of them.

The compiler barrier, barrier(), is implemented in inline asm instead of
using core::sync::atomic::compiler_fence() because memory models are
different: kernel's atomics are implemented in inline asm therefore the
compiler barrier should be implemented in inline asm as well.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/barrier.c      | 18 ++++++++++
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 67 +++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/barrier.rs

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
new file mode 100644
index 000000000000..cdf28ce8e511
--- /dev/null
+++ b/rust/helpers/barrier.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rust_helper_smp_mb(void)
+{
+	smp_mb();
+}
+
+void rust_helper_smp_wmb(void)
+{
+	smp_wmb();
+}
+
+void rust_helper_smp_rmb(void)
+{
+	smp_rmb();
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index b20ee7cef74d..1183150ebdc6 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
 
 #include "atomic.c"
+#include "barrier.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index b620027e0641..c7c0e552bafe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 
 mod arc;
 pub mod atomic;
+pub mod barrier;
 mod condvar;
 pub mod lock;
 mod locked_by;
diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
new file mode 100644
index 000000000000..277aa09747bf
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory barriers.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions of
+//! semantics can be found at [`LKMM`].
+//!
+//! [`LKMM`]: srctree/tools/memory-mode/
+
+/// A compiler barrier.
+///
+/// An explicic compiler barrier function that prevents the compiler from moving the memory
+/// accesses either side of it to the other side.
+pub fn barrier() {
+    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
+    // it suffices as a compiler barrier.
+    //
+    // SAFETY: An empty asm block should be safe.
+    unsafe {
+        core::arch::asm!("");
+    }
+}
+
+/// A full memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory accesses
+/// either side of it to the other side.
+pub fn smp_mb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_mb()` is safe to call.
+        unsafe {
+            bindings::smp_mb();
+        }
+    } else {
+        barrier();
+    }
+}
+
+/// A write-write memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory write
+/// accesses either side of it to the other side.
+pub fn smp_wmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_wmb()` is safe to call.
+        unsafe {
+            bindings::smp_wmb();
+        }
+    } else {
+        barrier();
+    }
+}
+
+/// A read-read memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory read
+/// accesses either side of it to the other side.
+pub fn smp_rmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_rmb()` is safe to call.
+        unsafe {
+            bindings::smp_rmb();
+        }
+    } else {
+        barrier();
+    }
+}
-- 
2.47.1


