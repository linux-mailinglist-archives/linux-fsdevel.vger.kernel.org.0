Return-Path: <linux-fsdevel+bounces-33437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEFF9B8BB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBC1B20E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165191531D5;
	Fri,  1 Nov 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpNkYJzo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02112BF24;
	Fri,  1 Nov 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444594; cv=none; b=HERxIE1i17UglTTSFpiHKfuulWK6M6chXXEJ+pE/226uTA1xTJsqePG2m1hiIIdU8oc9vl06CwfPHqdB4a7GtxFQu+fU6BCdM8F1vtu64k1FDTMCDBguLUd+PW+9EWx/5Imz/IZIIVgVVHiBqdEf8uWTMdp4RLd6zUyMxGrg2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444594; c=relaxed/simple;
	bh=auU4EjvmRwFargKLSwSbmmfDeOA5kt7T0T9oFZ8YRpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeDUIqpBE95B5IZOhkFcjd/A2wJTTIhaZzxewN8cZhcwThMx5KZrJoKm+kewfgSyqDt1WEz3K1Kdu2tB88v95AVKo48r7F4EHDhQRRIfV1Y82IZoEJfOufdVaJvM8FVlbc72yWLFpVVRBWLvNS9CwaD8HOO3TYna96jUAlhb9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpNkYJzo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b15467f383so120480385a.3;
        Fri, 01 Nov 2024 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730444590; x=1731049390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ez4P5E9q8FP8C4exX7QDGHDy4d36xIscVD7DfibVtng=;
        b=NpNkYJzoXlJfOeNc+p/44sYnMyik1sO7hWfFpjO6ak9yhpUFrKJF0iEvE5+MMdmdYq
         d2CNr3+LImFDsPtsSS+6x7ed+CUMOK5A2Dy0exdAUeDsQCYPt05SAGAAoCi8N6JD2OZ6
         l2Hw0PaYtEaevM6z9yb7u6wjvrsOmqda1pUg2XG0kg5d5YwTPgbkFbUDDWCdhxdvp2KM
         jJt0Qr3W64NYpCEuBJwFhHY2vqtkYyiC6zhlnmQMXSEKqSmnHhD43zr1VD90x8vGpqwk
         nyxKsfkphDW0skfGt95/UKAfW1YPkw1pjYNldB0++s6VmiBPDq/2iJSaQth7B5lHRfEJ
         lIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730444590; x=1731049390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ez4P5E9q8FP8C4exX7QDGHDy4d36xIscVD7DfibVtng=;
        b=fZP+rqmXIHSw7IH+cBPjrjOG9JxbOihJ09NzbuPwgW08SngRg9Pb3XYwpOixWLRQC9
         Dg6JHlGqcWz1gkM3aytVcQ6m8AXXHtFXLWLgXX0BkQy9IO3URPoGpGqmV56TsUvdm8RS
         NLamifJePIcaVX63i5tkEzUaa3e/UrnhMweIC+3MZSKZ2KOxx+yyk5aFF47rRzrMDZ4t
         sae3sYare14VIqKHGbZyj2PIna/eWOCOhtZblhkcJV/E/ekRqVEdaXbqBofda/wd+Lk9
         VaTdC5BJgBOMMuWHifH6Pay9/rPFbH4fQXLIja87XgriAmwzMpdjjvj0fYkAyj4tq7K2
         cWWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3AyR7O9fnp+QGak9y7ucBgI3XHPFA9wG3Kgj0g09yDqWxTQF8evfmbmfBA/6BNOsCuEFu22OzR1OTmmK1@vger.kernel.org, AJvYcCWZ3Puu//ZkWGkYien8L7xE6njwJ/YFMIj0VfAsemjzN6CLujyDdMMzapeKY1Mnt6jBKuvLUDRuQpKV0QVPEA==@vger.kernel.org, AJvYcCWmvvgMnqF1/ILB5Thi+8kXcp+DtZdsUyKb8rnHJGBeUXXZ+/yCnqAJX79+Ah5IQF9CSLqj@vger.kernel.org, AJvYcCXTnHDmgdGR8GbjVqIthQ1nezVs05mip3z3myvdxId/JxQ/A/k5a3JifiqBPc8pf3tMGXk62jSiyLJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzYoysEeB3BIyWsl0x9L9jJtKG72oUP8Zc8jORx+tMDIPE6Hz
	scwrsJYAWqGoy+mNaECipq1mudT0oTGWOTbFCCvtDVYBMT05PJvF4sdnpJoM
X-Google-Smtp-Source: AGHT+IEsUj+DQmkG+4AXqdbaVDTuLeohQo4MuzzYPago6pxWDTvqErQo8zVb6b/K08SnDYzoPnJsvg==
X-Received: by 2002:a05:620a:4043:b0:7a2:1db:e286 with SMTP id af79cd13be357-7b2f2534d12mr750064885a.52.1730444588633;
        Fri, 01 Nov 2024 00:03:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0c677sm144481985a.60.2024.11.01.00.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:03:08 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 982A11200043;
	Fri,  1 Nov 2024 03:03:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 03:03:07 -0400
X-ME-Sender: <xms:K30kZ8kl9dguh9P5md2cPJLSLRyZHZ28vGAdvnbOHwqyXzyDlq76nw>
    <xme:K30kZ73IlQtRIfUghCYp7Hqe0Z-yqSs5YkyIhEOYjjbayElmEdVJ78bQS_oD0L5GR
    n9YgkxXc7NuZUfjig>
X-ME-Received: <xmr:K30kZ6qevGzVMIehn3SuFU9G-5BAFNHZYkl7pdObQ0k8sA0Xrszt6c8RTd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeehiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K30kZ4m2d7id-MHy0VCqfFEk73hWD-rzbmzVaOphLOYwvL0OUgy4Jw>
    <xmx:K30kZ62Sh2l7NMYMzrR5nF_FIjg8WspDd6pn4BFPAxmpRuEEWMTX5g>
    <xmx:K30kZ_t943pAvxL8JHqflDINexBQG6UobtoGy5HYThSmt-2zU5QCsA>
    <xmx:K30kZ2W3DfYr-jAWfVPwpX_isI1H9PH0s9JfvzStSS7Otd3Naa2_Rw>
    <xmx:K30kZ92gaMbO2j1L-x5tRAd-9S7mxKeJMajb157zybAXM67gmyc0m_Gt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 03:03:07 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	lkmm@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
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
	linux-fsdevel@vger.kernel.org,	Trevor Gross <tmgross@umich.edu>,
	dakr@redhat.com,	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: [RFC v2.1 11/13] rust: sync: Add memory barriers
Date: Fri,  1 Nov 2024 00:01:53 -0700
Message-ID: <20241101070153.1197484-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101060237.1185533-12-boqun.feng@gmail.com>
References: <20241101060237.1185533-12-boqun.feng@gmail.com>
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
v2 -> v2.1: Add the missing barrier.c

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
index ab5a3f1be241..f4a94833b29d 100644
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
index 66ac3752ca71..0d0b19441ae8 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -9,6 +9,7 @@
 
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
2.45.2


