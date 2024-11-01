Return-Path: <linux-fsdevel+bounces-33412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094A9B8AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D081F22D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522D152787;
	Fri,  1 Nov 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSx7ut7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D014AD22;
	Fri,  1 Nov 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441039; cv=none; b=iLzWeBa4AG9QgciXrVQGKFTAIQMlxO7OTePsKmPCr9i5RuNxnfdjLRnqHWZKDlcE94TOD/dM3y/WfmMuPdBfTN64A796Urle09rYbSywZqHCToD+UfPYtoT5ScOpBo4Hb3n9Axnn9dJfAMF67aEjDZvs4VpcvGFFiFegSO5pqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441039; c=relaxed/simple;
	bh=ZzwhPTHyy8Qo15kfDWH3ADGWwRyJOZbedcMjmuM59hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRM1s8XhqovyFVzuONilMvMxFwH1ll93LfEPC/8gO0QnrhWMdMVHHAjgr1J/xd41LtnsW0wsm1UTm71F1TDgtSsUl6NR4HbEFikZFVXjxCjujSUlDkruFSqPWExqt49cnUrkQRWCDhQ3CJNoY4fCmVa7IZvO6ECt1mf4JeyaltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSx7ut7a; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe9914487so9892396d6.1;
        Thu, 31 Oct 2024 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441036; x=1731045836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ezq0QJ490o/WT6pSZwOZSMkEGdb7Q6G1iLv2f7aPhOU=;
        b=KSx7ut7aTnCOsDXjeSi+d7K1G0SmoYY5dXLWqw57VHCNkXhaNB/S0H3GlfyEZsEpUV
         jduWEBhIX3sQZ3iJt/fkmdyye+ojMtEmN1iGpyOmIKdTSnIr5K53ap4GvzuWkRMXVu81
         zZk56g68HuoVdNZv5X+3zzdi1r/IyDZ6T/YfEMOZr1NUuOKNiHXDRF0aH/YyGd6nmKgm
         fp/cfm1rCmHHzeLlUxHhcFZgA0QRdymVMgTogt20D6uz9CcNNMtI+2S+pn1y+JbhN3GB
         DMPeIS4YYtsER7C+LUm12irFfKNJP995sSnwn4kpuwj0p4v4r5PyVDd1q1TgPGt/2mL6
         fzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441036; x=1731045836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezq0QJ490o/WT6pSZwOZSMkEGdb7Q6G1iLv2f7aPhOU=;
        b=vmUmmaI3aa2sAdiPXyDS+kP+hzRYV64g88J1ksz4qu5ATBl1Hh+2AEYrar21g4SKAR
         5qn83a8wNg7Z5kdHvf8zrAXwPiruhv0dTVVeu5c+OaIRAjpNXUsYpOK7G8g5IE1a19iJ
         zbx585pauttbSZIyTi+/5Pbma60Hr1k2sGmER4tppMW5Xoeh01vGwzezYqj5ETWMPzqb
         LIt+fnrtrS/2VoNz6wWH7URnCZFNVWHOy2hbcFDvo6Q06V6WzdqA+SIE0i0xtQssPKGM
         ux/8M4tnZZh1Amocp5xTQ7MOgsJ3ccaGTjETvqcVJ6OEiaCGiKW2FBc+y6NqbewzaUbx
         jk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNg/SQsyF2CZ0hXhLzdIsGKZJZJj5J4pPlY8Mp2fRiJjinWlEpAVvXD4naYuniMjP/mqJQXYwTPzL+RiAqeg==@vger.kernel.org, AJvYcCVQrxrJPrcjw6rj24Hs4qUCzKTZxC74VS2qgB4IOYXbhuvCBGfuMSErk4Q05nBpMB+qAUtYgwCpxvj9@vger.kernel.org, AJvYcCWSawWgG8PM7SHo0jnEKKQn23MRgo109aqcQbU5FO6z89wOB3KaqbHje5oBHa/89TYIXgMZ@vger.kernel.org, AJvYcCWiPW+ZFBvOO2ENWzTXSxZs5VI6Nr0Pyh1Bk6vBAgAv+yn9cdXQP6dx8zgMzLus7SSWKby6A0r9LaDB37by@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OwJZlAbWapJa3GNKnjsaE5mTaLhZD7SYf00E27Z0BtLMCMjo
	T2T14/u3nMaQ5KbpEaErVcEIbkq3BzxisIdO+KxZ3QtRYbhrp0W8sH3FmGnV
X-Google-Smtp-Source: AGHT+IFzvD+xJDZFS+i4nEvqrLv+UyhL5sCjCQxklWAwGhucOte2TgUYZwOz7TrAUfxsSvfIz0YQug==
X-Received: by 2002:a05:6214:3281:b0:6cb:c8ef:3353 with SMTP id 6a1803df08f44-6d351a93188mr86932206d6.2.1730441035616;
        Thu, 31 Oct 2024 23:03:55 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b214sm15753266d6.99.2024.10.31.23.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:03:55 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC1DA1200043;
	Fri,  1 Nov 2024 02:03:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 02:03:54 -0400
X-ME-Sender: <xms:Sm8kZ27LRKlGFKB_nZiVLZ1yCee3Dl99fKLa_9eRO277mT-mdK52cg>
    <xme:Sm8kZ_6NbRajNxHwPgB0zI_x8Y-7emYr-nqA9wBpJ33_WWXIDXBXzxaVrZc1AXVsS
    BP_kbRoXFOChZZyIA>
X-ME-Received: <xmr:Sm8kZ1cBwBtL9O1klySJ29JVLsG6jDKcRJd3Cyi_BlCKy3GSKPhl0sTCTS4>
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
X-ME-Proxy: <xmx:Sm8kZzIoDEXSQ0idEQ5D4JF1w8Oh9xAF1ubzPivQ0sPUHNdZu42Pgg>
    <xmx:Sm8kZ6LNpfgARY0oX-MiviAOX_0DPX-iZn6DSh0TTP7umD-re8-yJg>
    <xmx:Sm8kZ0y2lmNspl3U5f39ZMFa0KQ2ZFYFgqSD7dmoH6pUuC6yksMJOg>
    <xmx:Sm8kZ-J3oTdA5Ll0ggVss2ZPxLemUXTmjLu0u9wu6brcbpCz-XZfwA>
    <xmx:Sm8kZxbkfUr1PLZz7n2TFeW2l2AJkBjZFh7OO92SBwCkMf6dhudwY-EE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:03:54 -0400 (EDT)
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
Subject: [RFC v2 02/13] rust: sync: Add basic atomic operation mapping framework
Date: Thu, 31 Oct 2024 23:02:25 -0700
Message-ID: <20241101060237.1185533-3-boqun.feng@gmail.com>
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

Preparation for generic atomic implementation. To unify the
ipmlementation of a generic method over `i32` and `i64`, the C side
atomic methods need to be grouped so that in a generic method, they can
be referred as <type>::<method>, otherwise their parameters and return
value are different between `i32` and `i64`, which would require using
`transmute()` to unify the type into a `T`.

Introduce `AtomicIpml` to represent a basic type in Rust that has the
direct mapping to an atomic implementation from C. This trait is sealed,
and currently only `i32` and `i64` ipml this.

Further, different methods are put into different `*Ops` trait groups,
and this is for the future when smaller types like `i8`/`i16` are
supported but only with a limited set of API (e.g. only set(), load(),
xchg() and cmpxchg(), no add() or sub() etc).

While the atomic mod is introduced, documentation is also added for
memory models and data races.

Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
my responsiblity on the Rust atomic mod.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS                    |   4 +-
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/atomic.rs     |  19 ++++
 rust/kernel/sync/atomic/ops.rs | 199 +++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/ops.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index b77f4495dcf4..e09471027a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3635,7 +3635,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -3644,6 +3644,8 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/kernel/sync/atomic.rs
+F:	rust/kernel/sync/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..66ac3752ca71 100644
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
index 000000000000..21b87563667e
--- /dev/null
+++ b/rust/kernel/sync/atomic.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic primitives.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions of
+//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
+//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
+//!
+//! # Data races
+//!
+//! [`LKMM`] atomics have different rules regarding data races:
+//!
+//! - A normal read doesn't data-race with an atomic read.
+//! - A normal write from C side is treated as an atomic write if
+//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
+//!
+//! [`LKMM`]: srctree/tools/memory-mode/
+
+pub mod ops;
diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops.rs
new file mode 100644
index 000000000000..59101a0d0273
--- /dev/null
+++ b/rust/kernel/sync/atomic/ops.rs
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic implementations.
+//!
+//! Provides 1:1 mapping of atomic implementations.
+
+use crate::bindings::*;
+use crate::macros::paste;
+
+mod private {
+    /// Sealed trait marker to disable customized impls on atomic implementation traits.
+    pub trait Sealed {}
+}
+
+// `i32` and `i64` are only supported atomic implementations.
+impl private::Sealed for i32 {}
+impl private::Sealed for i64 {}
+
+/// A marker trait for types that ipmlement atomic operations with C side primitives.
+///
+/// This trait is sealed, and only types that have directly mapping to the C side atomics should
+/// impl this:
+///
+/// - `i32` maps to `atomic_t`.
+/// - `i64` maps to `atomic64_t`.
+pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {}
+
+// `atomic_t` impl atomic operations on `i32`.
+impl AtomicImpl for i32 {}
+
+// `atomic64_t` impl atomic operations on `i64`.
+impl AtomicImpl for i64 {}
+
+// This macro generates the function signature with given argument list and return type.
+macro_rules! declare_atomic_method {
+    (
+        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            #[doc = concat!("Atomic ", stringify!($func))]
+            #[doc = "# Safety"]
+            #[doc = "- any pointer passed to the function has to be a valid pointer"]
+            #[doc = "- Accesses must not cause data races per LKMM:"]
+            #[doc = "  - atomic read racing with normal read, normal write or atomic write is not data race."]
+            #[doc = "  - atomic write racing with normal read or normal write is data-race, unless the"]
+            #[doc = "    normal accesses are done at C side and considered as immune to data"]
+            #[doc = "    races, e.g. CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC."]
+            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
+        );
+    };
+    (
+        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            declare_atomic_method!(
+                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
+            );
+        );
+
+        declare_atomic_method!(
+            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
+        );
+    };
+    (
+        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        declare_atomic_method!(
+            $func($($arg_sig)*) $(-> $ret)?
+        );
+    }
+}
+
+// This macro generates the function implementation with given argument list and return type, and it
+// will replace "call(...)" expression with "$ctype _ $func" to call the real C function.
+macro_rules! impl_atomic_method {
+    (
+        ($ctype:ident) $func:ident($($arg:ident: $arg_type:ty),*) $(-> $ret:ty)? {
+            call($($c_arg:expr),*)
+        }
+    ) => {
+        paste!(
+            #[inline(always)]
+            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
+                // SAFETY: Per function safety requirement, all pointers are valid, and accesses
+                // won't cause data race per LKMM.
+                unsafe { [< $ctype _ $func >]($($c_arg,)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)? {
+            call($($arg:tt)*)
+        }
+    ) => {
+        paste!(
+            impl_atomic_method!(
+                ($ctype) [< $func _ $variant >]($($arg_sig)*) $( -> $ret)? {
+                    call($($arg)*)
+            }
+            );
+        );
+        impl_atomic_method!(
+            ($ctype) $func [$($rest)*]($($arg_sig)*) $( -> $ret)? {
+                call($($arg)*)
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[]($($arg_sig:tt)*) $( -> $ret:ty)? {
+            call($($arg:tt)*)
+        }
+    ) => {
+        impl_atomic_method!(
+            ($ctype) $func($($arg_sig)*) $(-> $ret)? {
+                call($($arg)*)
+            }
+        );
+    }
+}
+
+// Delcares $ops trait with methods and implements the trait for `i32` and `i64`.
+macro_rules! declare_and_impl_atomic_methods {
+    ($ops:ident ($doc:literal) {
+        $(
+            $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                call($($arg:tt)*)
+            }
+        )*
+    }) => {
+        #[doc = $doc]
+        pub trait $ops: AtomicImpl {
+            $(
+                declare_atomic_method!(
+                    $func[$($variant)*]($($arg_sig)*) $(-> $ret)?
+                );
+            )*
+        }
+
+        impl $ops for i32 {
+            $(
+                impl_atomic_method!(
+                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        call($($arg)*)
+                    }
+                );
+            )*
+        }
+
+        impl $ops for i64 {
+            $(
+                impl_atomic_method!(
+                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        call($($arg)*)
+                    }
+                );
+            )*
+        }
+    }
+}
+
+declare_and_impl_atomic_methods!(
+    AtomicHasBasicOps ("Basic atomic operations") {
+        read[acquire](ptr: *mut Self) -> Self {
+            call(ptr as *mut _)
+        }
+
+        set[release](ptr: *mut Self, v: Self) {
+            call(ptr as *mut _, v)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasXchgOps ("Exchange and compare-and-exchange atomic operations") {
+        xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(ptr as *mut _, v)
+        }
+
+        cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: Self, new: Self) -> Self {
+            call(ptr as *mut _, old, new)
+        }
+
+        try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut Self, new: Self) -> bool {
+            call(ptr as *mut _, old, new)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasArithmeticOps ("Atomic arithmetic operations") {
+        add[](ptr: *mut Self, v: Self) {
+            call(v, ptr as *mut _)
+        }
+
+        fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(v, ptr as *mut _)
+        }
+    }
+);
-- 
2.45.2


