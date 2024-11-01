Return-Path: <linux-fsdevel+bounces-33421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C39B8AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211362820F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01F18BC1A;
	Fri,  1 Nov 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5g+J/ye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899515ADB4;
	Fri,  1 Nov 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441052; cv=none; b=bdhBWNSF8mOb5UDK9fiWHO5mY0qSFvMAg3E3GF63ET2d0cGfyx/pcYMLO7L3XgOycsEAVxbQib/SRZRcZH4BDgcbyKQUqPFcAqN7W+J7+3C//dPjsdC8LKO9oiTdZEfscpz1W54gsc6LwuVUQi5iDv9QUJZvWM2/YXyvuuv4ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441052; c=relaxed/simple;
	bh=MqvhIZAaNo5iiQDL9gtZVIFQYPreKtujEAZe4htAogM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFwmwM/paOZF4agz8mGVL8cPXY3G6q9YibjV9HNALQeQQuT3b1XfIGFUIhjrfWM9QGIYS8UN8yG8RNsH6l/I6hvz6eLLYz6mKnTs3TNGTFxNOH5Uio7R68wJvaaEyDL1uHmb68nK4P/mvYhAzusSX2DC7VtlUpLhA1d0TabddF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5g+J/ye; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e41bd08bso17929697b3.2;
        Thu, 31 Oct 2024 23:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441049; x=1731045849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONyAMI/uecNup1a5yaiABvXQUHETtGYA3BLm9LR8ufQ=;
        b=E5g+J/ye0j0vI1zmuZsC3kOLK0lHkzF62oT1v4b9luNpeVuVK1g3MsI5IhSyuLfdQj
         Xp8yccetak7Ni1+fJbjFk3JAW514qFRWGVmGGZrUkIJw03YZY8v7+nGGN99PcKg8Ic8O
         MKFh5o15esyXBhp15cWTVp9fjMElrDg5OudIgfteGt3C7BH/S6c+eqdlpc5bGD21ZCOy
         m3kRoke89QgtyH7+N0EW36wprdVFP1nn3uTn1RAkFoV0UDBMg3GIptVcMD5a5VOKwX8m
         eJnAlCxVviZPrtlA3N8aAfdA6XbGru5LrzqTe5VEtC47wqTCUeZT3iwi4196RgFUbh0O
         CRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441049; x=1731045849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONyAMI/uecNup1a5yaiABvXQUHETtGYA3BLm9LR8ufQ=;
        b=e9CAn47KiXc+XgOqsfmIPoFsn5TrsFXwYlsLSoCuJVVGIOiwIa9Qyw/REHDx0KmnF+
         Riywgc6CdiUvrrGYaqphVTcYTSI4gB+WyKPaxuIpq5Y5acxVnAk0mGMcasIcuJndliMY
         Pa9UlfXKYbDm4aQaX5md6P0hATlVIxmhCjiEmRGeuVotRvsbtcq3/uXTxBf2N2FDnfZr
         831c6pTDhhBQTZVsvpo7/1Zot7mDqbICx4WJqH5RbnYri3mdl+NrC554MXIoSNnDD8/f
         bNHxBwNsX+0rWxO5YTu83VmUx6AFywzEymVDrPSbv54apcwKXIpZ8G7eT2xXs0rWYMZE
         Gexw==
X-Forwarded-Encrypted: i=1; AJvYcCVUW7BBkCJaUnmryPHHuJbbQVeXacoSCKdC9s96oDOvy/WjyI036DqxRejyIPStB1A4POIV+XtflihXjdsM@vger.kernel.org, AJvYcCVenNdQWIZYPR7UTYZpQNPMJKpOUqZd/kqC3s6vxZWI9V3xE3UCM06EOn6QpEH+zLPmXFDidBJs3UhD@vger.kernel.org, AJvYcCWwubDhssNRN3rbzxnYqqLsuWET4uxKGfwJh/pA7SyzX46r4m1mZ43NU+GZnrfZlP21kc53@vger.kernel.org, AJvYcCXWqLZpBVyJgfddJ65Pkl2/H6DDbGijPpv/aCjDytecD8jd0vV8tknN1nOcqB3HX2SpvmzKhsvzu80pe+RKuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4A728E9RQeGQtqRCHc+rGLbJZo7GdMXVse73uZB5UjEOciGtB
	fSLYEKfIjmicKvnHVp8kLPtjyBRkT0PL9qhgHoIYtcJOPX45sl9kB8yTCkAm
X-Google-Smtp-Source: AGHT+IHcjrPb/FeOVIxBsa63o86Oc25uPbYhfErjJDN9OPn/lNuk6vqY7WalnP/btuXcfUC55+oe4Q==
X-Received: by 2002:a0d:e903:0:b0:6ea:6871:f6a8 with SMTP id 00721157ae682-6ea6871f6f0mr8754657b3.36.1730441048713;
        Thu, 31 Oct 2024 23:04:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b2c8sm15694736d6.84.2024.10.31.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:04:08 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0560C1200043;
	Fri,  1 Nov 2024 02:04:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 01 Nov 2024 02:04:08 -0400
X-ME-Sender: <xms:V28kZx03w7FfDJyTAjGQCB5cimhO5UgH0CnNwSs_u-GifCQ16axUWA>
    <xme:V28kZ4GhVFDNFLEHsSGZkkMXCIV2KJJvFc28ZfVCIWYeufdv1J5PR505hNrXGB3Sp
    FrcVTzWvpuxLabXyw>
X-ME-Received: <xmr:V28kZx4Cb_Wrz7cjKMnfwYBQqCuRrKRcMsPZw-vVp8yqGLh-XJP80piQp0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:V28kZ-1GtnjM0UwZWeC5HFPwOCKR7afvqrMVVUIDiZahHaVdOxld_g>
    <xmx:V28kZ0HlFE62k8XBBgkORjw2p0YjQKNtcmqvBayh4lnK8vqL53OqOA>
    <xmx:V28kZ_-esDtzxvfelyBaQ6OuO6wWlVyxFiZNbZ30sR_94AX6z1Rrzw>
    <xmx:V28kZxlevkAoV5hCW_qetZFjU6n99_7nziQtg7YxjuwvqKJqv82J0g>
    <xmx:WG8kZ4FTVQ8XmQSFlrEVqJSVjj1T6gX32dq41ydmG5yAHVje1tVHu4I2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:04:07 -0400 (EDT)
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
Subject: [RFC v2 11/13] rust: sync: Add memory barriers
Date: Thu, 31 Oct 2024 23:02:34 -0700
Message-ID: <20241101060237.1185533-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101060237.1185533-1-boqun.feng@gmail.com>
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
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
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 67 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 rust/kernel/sync/barrier.rs

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


