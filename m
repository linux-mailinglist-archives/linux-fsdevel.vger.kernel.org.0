Return-Path: <linux-fsdevel+bounces-15136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC48875D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6047B2237F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A6839E6;
	Fri, 22 Mar 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdlOkbtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80382C67;
	Fri, 22 Mar 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150752; cv=none; b=kqQZsrwkT4PELYPf0GbbHNcu9lvd7OaHAlTXUjOk2Aw7HUGyrAJM5eV1iaF5Lw7LW9CgLdmTmeDrzAKWkXLQEumKP6xQthJV28M50cKh8JTAho031ABSd9rwS9pOMyYdvkP0tzXQbmLSarMesiYvHOUkhAPJbwjhA5jiGP+X3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150752; c=relaxed/simple;
	bh=e6OXAQgc0jxh60UP+AT0xAtl7n5YPlqj9xRF3ydf1Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI9z1mp27vYc9MDfTrjEBkbXCor2ks/jeqDIlpiLVMeD7175F1xNocTBM0f964hXVZ3nhHUqeXcnhvrPMaSJI1xVGmxuBozdlOlN07c+4ht0FI6D4UVgJ/hC4qsk3FhWnJ7QrqeFpuZhB+eVpRNR4U5xdgiQEb7OuWebn9VciQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdlOkbtS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6928a5e2479so17058406d6.0;
        Fri, 22 Mar 2024 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711150749; x=1711755549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMsNwHviwi/fcgZpZ6hEf/r33sW+GCsEsvaN1TfyKyc=;
        b=AdlOkbtS9FlzFTs+QhsReJzLVn4+/Vb1xWKnOmnQkzYQjKUlggmFFfXzjD8SCSaPSp
         sF7wGOFtwrirgftUWJguIj+y4szt5Qgp5IGGZIGkG8RokGxGVn8mOvez7Ae9zsd9u8tJ
         14LIGDiH7JVpMrnge/4wPmTyKwefn50tuTlWeS94GYokENJwrkXda6CPLAG5vSo6HQ4q
         oIxmuE4UWln7ij9ZeVTZNPyLoAkmln2ywqQMsVCvE4dRM3nUQot8KrGZIOd8pbHsx31k
         tqpjzyWMiC1aAVvbj5+DZN1IIUt5I7iHxNr93A5asY/0aIEsZivx4zewi8xhaUlgyTU5
         KdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150749; x=1711755549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMsNwHviwi/fcgZpZ6hEf/r33sW+GCsEsvaN1TfyKyc=;
        b=ENtbfylMSZBVSbpdM841TmvmwGjiWjQ4SuQOf87TY2Pk8VmiHVg1XL6XPU7TZLOXqU
         luoHJGOV+RlXKd9fZCaLhCets7J9G0OwlU1Qxbmqo3dJtejO/Zb520DFB2DGQmGE9RHR
         OjAe2CLtfLRsFa/3qxi6wTyHnAx8QYl/V2Gs0A9Buapo3KT9/Yl6PkW/szrdmOV1kkBa
         QydxcS/+088avNoDTUdgVPZtcfRa/kSo18xves0ggqoSb23+PZLU5To8RZ1aC0eTz8BF
         RF5EhqPKl0sO2sBuVpDab8Rbkjl0own729SYAEqhk/R4J3RRvNBoflnvHUwVR7+SR3vk
         /mPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf65NoB0W3pF+jfMXDT3EtNlWXukYixo6BNOwKVZp2Msj09T4x12HX8gxV2ojqdbl9YgG7Zlrzikj7MVjqaPCG8pNST93irDGsIl6aAmcV19SaROBnlxC/09sv8biVPRWbTohBizECi5yH7YIlE9PCLopHUxSy7bGMxmIvrBkz2dbDNLtTHSc=
X-Gm-Message-State: AOJu0Yzi6vQwbXwsxfR45YqrVa+b9NCXe2LxsMb6FXOh4KoBVCx4BFRJ
	hKLwKR2sk01u738orOWG1oI44eVWavZZuPdEx+CwGslhrykuXhAg
X-Google-Smtp-Source: AGHT+IHZ+NuIYKcs3sHrLWDGnicqM7RhyyK/vWc/KL6bEIvyatErGn/eE74OoTUwRrPjNflkhje49A==
X-Received: by 2002:ad4:5ba9:0:b0:696:1ffd:a32c with SMTP id 9-20020ad45ba9000000b006961ffda32cmr714687qvq.31.1711150749485;
        Fri, 22 Mar 2024 16:39:09 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id mx17-20020a0562142e1100b0069679a663e6sm105329qvb.21.2024.03.22.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:39:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2EC3C1200032;
	Fri, 22 Mar 2024 19:39:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 19:39:08 -0400
X-ME-Sender: <xms:mxb-ZXTbYVqlom28rQt9TnMLbujWEI8AGMPI5M2G22WRIJ5GDiGN3w>
    <xme:mxb-ZYzEupW_TSonIS8-cka8D4hKKfqIchGklOxjHyBQKab_c3uSpvvwCVKOIYB-o
    0rEF9RKlVrFEdFW3Q>
X-ME-Received: <xmr:mxb-Zc3Pix3SYs8RDObCLVOZlFqBSe5IvT0aypgBpFNIzOwbOWqnfFT1tgH9Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mxb-ZXAUGc00uvVSj6JP0u6CxcdlKt75QhCkZVZ26jmeWQ9mz1tuyQ>
    <xmx:mxb-ZQgYjg8xkF4RHCcfqgDedHzoHJo2KpTqJsUK3J0FTSlP52-Evw>
    <xmx:mxb-ZboHXuECLo9v63UMdwqhJcBb_sy4xm-LJZ1wI1CvwxZQ7BumKw>
    <xmx:mxb-Zbj3D06k_UrcI3Y5poH5iaZbMQwdIEpWqXHaPX3B5VwLSHFhWA>
    <xmx:nBb-ZdAzgXOgVGyLecu6swYaPqY3_ELlnR8gNtETKrEgam36BUKbCZIaA-GS-jFH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 19:39:06 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
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
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org
Subject: [WIP 1/3] rust: Introduce atomic module
Date: Fri, 22 Mar 2024 16:38:36 -0700
Message-ID: <20240322233838.868874-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322233838.868874-1-boqun.feng@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although Rust has its own memory ordering model (in the standard C++
memory model), having two models is not wise to start with: it increases
the difficulty for correctness reasoning. Since we use Linux Kernel
Memory Model for C code in kernel, it makes sense that Rust code also
uses LKMM, therefore introduce a module to provide LKMM atomic
primitives.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync.rs                 |  1 +
 rust/kernel/sync/atomic.rs          | 42 ++++++++++++++++++++++++++++
 rust/kernel/sync/atomic/arch.rs     |  9 ++++++
 rust/kernel/sync/atomic/arch/x86.rs | 43 +++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/arch.rs
 create mode 100644 rust/kernel/sync/atomic/arch/x86.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index c983f63fd56e..dc2d26712f26 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -8,6 +8,7 @@
 use crate::types::Opaque;
 
 mod arc;
+pub mod atomic;
 mod condvar;
 pub mod lock;
 mod locked_by;
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
new file mode 100644
index 000000000000..280040705fb0
--- /dev/null
+++ b/rust/kernel/sync/atomic.rs
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic and barrier primitives.
+//!
+//! These primitives should have the same semantics as their C counterparts, for precise definitions
+//! of the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory
+//! (Consistency) Model is the only model for Rust development in kernel right now, please avoid to
+//! use Rust's own atomics.
+
+use core::cell::UnsafeCell;
+
+mod arch;
+
+/// An atomic `i32`.
+pub struct AtomicI32(pub(crate) UnsafeCell<i32>);
+
+impl AtomicI32 {
+    /// Creates a new atomic value.
+    pub fn new(v: i32) -> Self {
+        Self(UnsafeCell::new(v))
+    }
+
+    /// Adds `i` to the atomic variable with RELAXED ordering.
+    ///
+    /// Returns the old value before the add.
+    ///
+    /// # Example
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::AtomicI32;
+    ///
+    /// let a = AtomicI32::new(0);
+    /// let b = a.fetch_add_relaxed(1);
+    /// let c = a.fetch_add_relaxed(2);
+    ///
+    /// assert_eq!(b, 0);
+    /// assert_eq!(c, 1);
+    /// ```
+    pub fn fetch_add_relaxed(&self, i: i32) -> i32 {
+        arch::i32_fetch_add_relaxed(&self.0, i)
+    }
+}
diff --git a/rust/kernel/sync/atomic/arch.rs b/rust/kernel/sync/atomic/arch.rs
new file mode 100644
index 000000000000..3eb5a103a69a
--- /dev/null
+++ b/rust/kernel/sync/atomic/arch.rs
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Architectural atomic and barrier primitives.
+
+#[cfg(CONFIG_X86)]
+pub(crate) use x86::*;
+
+#[cfg(CONFIG_X86)]
+pub(crate) mod x86;
diff --git a/rust/kernel/sync/atomic/arch/x86.rs b/rust/kernel/sync/atomic/arch/x86.rs
new file mode 100644
index 000000000000..2d715f740b22
--- /dev/null
+++ b/rust/kernel/sync/atomic/arch/x86.rs
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! x86 implementation for atomic and barrier primitives.
+
+use core::arch::asm;
+use core::cell::UnsafeCell;
+
+/// Generates an instruction with "lock" prefix.
+#[cfg(CONFIG_SMP)]
+macro_rules! lock_instr {
+    ($i:literal) => { concat!("lock; ", $i) }
+}
+
+#[cfg(not(CONFIG_SMP))]
+macro_rules! lock_instr {
+    ($i:literal) => { $i }
+}
+
+/// Atomically exchanges and adds `i` to `*v` in a wrapping way.
+///
+/// Return the old value before the addition.
+///
+/// # Safety
+///
+/// The caller need to make sure `v` points to a valid `i32`.
+unsafe fn i32_xadd(v: *mut i32, mut i: i32) -> i32 {
+    // SAFETY: Per function safety requirement, the address of `v` is valid for "xadd".
+    unsafe {
+        asm!(
+            lock_instr!("xaddl {i:e}, ({v})"),
+            i = inout(reg) i,
+            v = in(reg) v,
+            options(att_syntax, preserves_flags),
+        );
+    }
+
+    i
+}
+
+pub(crate) fn i32_fetch_add_relaxed(v: &UnsafeCell<i32>, i: i32) -> i32 {
+    // SAFETY: `v.get()` points to a valid `i32`.
+    unsafe { i32_xadd(v.get(), i) }
+}
-- 
2.44.0


