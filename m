Return-Path: <linux-fsdevel+bounces-46817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24BA954B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05C2161BD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4B1E9906;
	Mon, 21 Apr 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxLHPH8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328D1DF72E;
	Mon, 21 Apr 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253761; cv=none; b=NOV+LGX5UWPhSjbBT+x2w6gSoW0ej+cASnh4ZdFHBKWJpZ1nZTslqqfVQr57sTzEjeQGnsSjFnvTRlnorj0NsJbTSF7H8B5e/Jbg+jBMVUv2mfNz1l/fjj/H9xo9he88NIS1a+dTr6wdg6IpOOQqFuPZD97Jx4DD62sIm0d991U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253761; c=relaxed/simple;
	bh=VIZ21Tx5XOzrE2lg32MzKfnKBuGu+y7qMMegb1mrb68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jInzj5qa03XKi67/HslZhDWqBSjC6HyCSUjkCEthQvt1JHBaHhWHxL+9smLJ5KzIoxgx58A9GZLeDI4SupoBxErHRrucgc39M4dW+C1Ij3PDiJHajEKq0KIyFyXMvfR3/XpYizTRyZmsjRgHPESVbPC6aV0bryP9HjQCfpWPjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxLHPH8i; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5c815f8efso373942485a.2;
        Mon, 21 Apr 2025 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253758; x=1745858558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtEl5+XBMA+ykf0aS94gSaUF58JxAYctve/OxyPQc2g=;
        b=QxLHPH8iO26PUgNTQ4Q94cyZd2Od5v7c5WlrxH0uE3a4XsXpGTTCZYR7sevzb3Klb+
         PuhHQIAAA4EL6ahu416Vr4BLlh+MUT+7IVO+xQ8Dz3HKmc4gDskCZ/c9yMvRzfZb7Q+1
         Qma0iXsRP0IimEU3Yojo8p6rAq8Wt9I6QU6r2sHEMKVXnHFuC123I278qEQFYY0iEII5
         rJ2Zvfjbw6hnGm0VjG3YCIoB+hXYjWEijveMAPFRDpTvnFHK65rNH9sIjcj9MFwIHnMP
         y3JX1AHvL4hZ85OnVq9p+7m8XLCQNj4gVg69EZoRDkMx4M5EfaDQ2MszK4h1OsU5j12Y
         eBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253758; x=1745858558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtEl5+XBMA+ykf0aS94gSaUF58JxAYctve/OxyPQc2g=;
        b=h7/LiZQVn4hQzXv3/uqnSjnRpUQIKkI2SNy7ttfqSUCPjhgTdZYfqDqLLptZb5H+sX
         BcNVl0ZfwoYUk+peO2AewxOFFMekAo37TrNyJglcvHeMWb9ZSbMfgkw1oCPczH3DX0hv
         /oD5XyWG1y6PtN88rjH4C96xrNORO2Uu01eTCUnHwc7l+YpFGc8jL/BtnnVnxLQCR5FB
         0XPiysUDGN2tERUqdfXEGT7pCA/+M0NxGC0URtO8CIHkDGl4WeJb0WWn2zAzGrUpPFLb
         6/DzWJA3zOl67dg5Er4DjL4S3wm6eQ5DmAlBc3DAzDBCVapFFhhMUq6FIQNUMFkF/hKn
         brbw==
X-Forwarded-Encrypted: i=1; AJvYcCUopEB+Jl70IjLpdmUYFbK7zbi8GvoyOvqAF4AY/ariXJmSYvcYqYxEAaujMleHuh9pnO9L@vger.kernel.org, AJvYcCUvS5NH1nhbFfJkiqaJB6mh24ZWjWebPUOyZyhnC6diXEh5Itn2JX/a1no9WLQhlGF+ZvHmkOGgDnvH@vger.kernel.org, AJvYcCVXpiZe720szHQ89sDrMDbmfNBn5u/bqdH+Lk4pktJi9rxYxQl0EbEbC1xX9KCS7ZlufwcZ/PG3wdJna6tSJQ==@vger.kernel.org, AJvYcCWgpNtIs4rgA/pnFP0dDkgnDlLEw4GM8BSAMfWJHPmnPsgUx0VPevM9IyWUnCbUVzPQWWB3tZHp8ubeM4U+@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0QgMekiogc3EhyhURjGs82vx29yDUjYGH+CSSRq82ucoPLra
	3VJYXEF78M3IfCmenKHEq9Asd7LNEdSfNYMIlqcd+stNYoxUctqAXK6Zig==
X-Gm-Gg: ASbGncvcmxMwtdhKwRThAkkjvd7r0GVHD6cdXzX8OhHKWr5L8zUyg8/SRRYx9AUDXJ/
	aClPJmeBcz1xDCmCL8HeabzZkl0u33cBaNn4u7vIlBHh3Mg/v/7KOq5q5zQqqIIGs52krjVfk+Z
	Cyeu0Kel41nwCmuhZ/2Kjq1bVf2HsTmnQtQmRcfWNvf38sBx0wQQ7LkYudxND8tLxEzirfK81EU
	vOWtZEkcyUFLGnbGYd0Q06VlFmG7FeSfpexHP7QZ9CSit9uo4MizhAHzrYVqERkX9IFcQr1OnM7
	jPJzpvtKHfvs9fDwMm3heZoPFDR5MxJW8B1Q3WFP7EuolhhYclWlA1exymCUW6/wzgUPhQFrhQD
	gFC9OPrcvQ53jroa3J9S0n/sLhW/LraMCX9CjEWp1Uw==
X-Google-Smtp-Source: AGHT+IHPmoQswD9V8t4QoCScmJ6eEFw5p8ICv3y2lcEVLBc4mVVcFwA7kZOL6Y/obQjZExq55ZCO1g==
X-Received: by 2002:a05:620a:258c:b0:7c7:a555:8788 with SMTP id af79cd13be357-7c927f5908fmr1549015885a.2.1745253758165;
        Mon, 21 Apr 2025 09:42:38 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6ee74sm439778485a.1.2025.04.21.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:37 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C9F31200043;
	Mon, 21 Apr 2025 12:42:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 21 Apr 2025 12:42:37 -0400
X-ME-Sender: <xms:fXUGaOgeUTbOSeG6-rL8BR66MukOcH7dgFzfqaJ1kU-TMbPqS0NcWA>
    <xme:fXUGaPC0JPithm7ku-MTuE8SYqZO0qj8lH2ELNT894XaAtdNT7eyjqqfCFVv5tBXR
    lmB_z5GfD-O4EC2aw>
X-ME-Received: <xmr:fXUGaGEC0YaTEstUWd6Py6YmCAZ5eECDr8Pw2ywE1KT_chvNTvJoNlCHRQmb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
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
X-ME-Proxy: <xmx:fXUGaHSVcMMOKEX5eHUe_L9xUQs3c4yn8dRmXrVh-VkFKptxfXwq4Q>
    <xmx:fXUGaLyeafgXaQDiIGRrxuhN3-Cp5l-YSmv3NWSj95Arpa6fx3nWiw>
    <xmx:fXUGaF4azIdFjAaJaFdqxGKbtaXglcgfQI88uvyA7vr0fs5mB1L2aQ>
    <xmx:fXUGaIw_3XbVpMFDJydXTxDeAbviRUJk_6vS0_CldfLa2xbINaIlOQ>
    <xmx:fXUGaHijDGk-MM9CToJDmhs_nJC5r9ZIz1cr5232kAJHfh06jQhL-_bX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:36 -0400 (EDT)
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
Subject: [RFC v3 04/12] rust: sync: atomic: Add generic atomics
Date: Mon, 21 Apr 2025 09:42:13 -0700
Message-ID: <20250421164221.1121805-5-boqun.feng@gmail.com>
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

To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
added, currently `T` needs to be Send + Copy because these are the
straightforward usages and all basic types support this. The trait
`AllowAtomic` should be only implemented inside atomic mod until the
generic atomic framework is mature enough (unless the implementer is a
`#[repr(transparent)]` new type).

`AtomicImpl` types are automatically `AllowAtomic`, and so far only
basic operations load() and store() are introduced.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs         |   2 +
 rust/kernel/sync/atomic/generic.rs | 254 +++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/generic.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 9fe5d81fc2a9..a01e44eec380 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -16,7 +16,9 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-mode/
 
+pub mod generic;
 pub mod ops;
 pub mod ordering;
 
+pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
new file mode 100644
index 000000000000..5d8bbaaf108e
--- /dev/null
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic atomic primitives.
+
+use super::ops::*;
+use super::ordering::*;
+use crate::types::Opaque;
+
+/// A generic atomic variable.
+///
+/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be chosen.
+///
+/// # Invariants
+///
+/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race, this
+/// is guaranteed by the safety requirement of [`Self::from_ptr`] and the extra safety requirement
+/// of the usage on pointers returned by [`Self::as_ptr`].
+#[repr(transparent)]
+pub struct Atomic<T: AllowAtomic>(Opaque<T>);
+
+// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
+unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
+
+/// Atomics that support basic atomic operations.
+///
+/// TODO: Currently the [`AllowAtomic`] types are restricted within basic integer types (and their
+/// transparent new types). In the future, we could extend the scope to more data types when there
+/// is a clear and meaningful usage, but for now, [`AllowAtomic`] should only be implemented inside
+/// atomic mod for the restricted types mentioned above.
+///
+/// # Safety
+///
+/// [`Self`] must have the same size and alignment as [`Self::Repr`].
+pub unsafe trait AllowAtomic: Sized + Send + Copy {
+    /// The backing atomic implementation type.
+    type Repr: AtomicImpl;
+
+    /// Converts into a [`Self::Repr`].
+    fn into_repr(self) -> Self::Repr;
+
+    /// Converts from a [`Self::Repr`].
+    fn from_repr(repr: Self::Repr) -> Self;
+}
+
+// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment.
+unsafe impl<T: AtomicImpl> AllowAtomic for T {
+    type Repr = Self;
+
+    fn into_repr(self) -> Self::Repr {
+        self
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr
+    }
+}
+
+impl<T: AllowAtomic> Atomic<T> {
+    /// Creates a new atomic.
+    pub const fn new(v: T) -> Self {
+        Self(Opaque::new(v))
+    }
+
+    /// Creates a reference to [`Self`] from a pointer.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` has to be a valid pointer.
+    /// - `ptr` has to be valid for both reads and writes for the whole lifetime `'a`.
+    /// - For the whole lifetime of '`a`, other accesses to the object cannot cause data races
+    ///   (defined by [`LKMM`]) against atomic operations on the returned reference.
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    ///
+    /// # Examples
+    ///
+    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
+    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
+    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
+    ///
+    /// ```rust
+    /// # use kernel::types::Opaque;
+    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
+    ///
+    /// // Assume there is a C struct `Foo`.
+    /// mod cbindings {
+    ///     #[repr(C)]
+    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32 }
+    /// }
+    ///
+    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2});
+    ///
+    /// // struct foo *foo_ptr = ..;
+    /// let foo_ptr = tmp.get();
+    ///
+    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is inbound.
+    /// let foo_a_ptr = unsafe { core::ptr::addr_of_mut!((*foo_ptr).a) };
+    ///
+    /// // a = READ_ONCE(foo_ptr->a);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all accesses on it is atomic, so no
+    /// // data race.
+    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
+    /// # assert_eq!(a, 1);
+    ///
+    /// // smp_store_release(&foo_ptr->a, 2);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all accesses on it is atomic, so no
+    /// // data race.
+    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
+    /// ```
+    ///
+    /// However, this should be only used when communicating with C side or manipulating a C struct.
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
+    where
+        T: Sync,
+    {
+        // CAST: `T` is transparent to `Atomic<T>`.
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
+        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
+        // guarantees other accesses won't cause data races.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns a pointer to the underlying atomic variable.
+    ///
+    /// Extra safety requirement on using the return pointer: the operations done via the pointer
+    /// cannot cause data races defined by [`LKMM`].
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    pub const fn as_ptr(&self) -> *mut T {
+        self.0.get()
+    }
+
+    /// Returns a mutable reference to the underlying atomic variable.
+    ///
+    /// This is safe because the mutable reference of the atomic variable guarantees the exclusive
+    /// access.
+    pub fn get_mut(&mut self) -> &mut T {
+        // SAFETY: `self.as_ptr()` is a valid pointer to `T`, and the object has already been
+        // initialized. `&mut self` guarantees the exclusive access, so it's safe to reborrow
+        // mutably.
+        unsafe { &mut *self.as_ptr() }
+    }
+}
+
+impl<T: AllowAtomic> Atomic<T>
+where
+    T::Repr: AtomicHasBasicOps,
+{
+    /// Loads the value from the atomic variable.
+    ///
+    /// # Examples
+    ///
+    /// Simple usages:
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// let x = Atomic::new(42i64);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    /// ```
+    ///
+    /// Customized new types in [`Atomic`]:
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
+    ///
+    /// #[derive(Clone, Copy)]
+    /// #[repr(transparent)]
+    /// struct NewType(u32);
+    ///
+    /// // SAFETY: `NewType` is transparent to `u32`, which has the same size and alignment as
+    /// // `i32`.
+    /// unsafe impl AllowAtomic for NewType {
+    ///     type Repr = i32;
+    ///
+    ///     fn into_repr(self) -> Self::Repr {
+    ///         self.0 as i32
+    ///     }
+    ///
+    ///     fn from_repr(repr: Self::Repr) -> Self {
+    ///         NewType(repr as u32)
+    ///     }
+    /// }
+    ///
+    /// let n = Atomic::new(NewType(0));
+    ///
+    /// assert_eq!(0, n.load(Relaxed).0);
+    /// ```
+    #[inline(always)]
+    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_read*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        let v = unsafe {
+            if Ordering::IS_RELAXED {
+                T::Repr::atomic_read(a)
+            } else {
+                T::Repr::atomic_read_acquire(a)
+            }
+        };
+
+        T::from_repr(v)
+    }
+
+    /// Stores a value to the atomic variable.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.store(43, Relaxed);
+    ///
+    /// assert_eq!(43, x.load(Relaxed));
+    /// ```
+    ///
+    #[inline(always)]
+    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
+        let v = T::into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_set*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        unsafe {
+            if Ordering::IS_RELAXED {
+                T::Repr::atomic_set(a, v)
+            } else {
+                T::Repr::atomic_set_release(a, v)
+            }
+        };
+    }
+}
-- 
2.47.1


