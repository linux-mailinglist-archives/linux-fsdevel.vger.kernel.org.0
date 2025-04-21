Return-Path: <linux-fsdevel+bounces-46820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFEA954C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5C18956EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F41E51EE;
	Mon, 21 Apr 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL1At61v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBB1EB1B6;
	Mon, 21 Apr 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253765; cv=none; b=bYQe/QVQDDorqxkuklLJcTaRWcP6ibLLufnoobHxV+pjpXU46DtdqiEfSCStfEXdbSrOwVnz0PZXAUYho7yyeSr2T18OxKIuHYn2SUCqGzoGD73hZ4udCfAu1DcY5f3XLSvFmo8nLhoFtwFEg1X+g/BKBjyYP3Y4PkmBvrLcq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253765; c=relaxed/simple;
	bh=UGNCuXxFioUqqIrmBuMgTay3Y8/FsLszX3rIkRfGS/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2yEiBMyV6YnNGaSL0xNDPm1We7INZRmuSNw4TUKusOR4wGRsFajF4iC8+Hiw0bfPoUJ1tB3MVx1mQs/ZHibUK/9I77ZTR1A6LdsEcmO/xdBPOmmfee9onJ/FlBYm7BOKjBrC0bL0n5tTD2CQMtjlP9z7ieEChuKEUh6hmxz/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL1At61v; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f05acc13so55460876d6.2;
        Mon, 21 Apr 2025 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253762; x=1745858562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nnh9FhtmfBr7vF/QXBT4Oa0ku2sBn0D0ph9GeI/BdhY=;
        b=WL1At61vnB+HH3Oe9Mry02no7jcO8+79pA+b5hh5YRbCsF39qHBMotMfBumUoxMB9W
         HzkU/B7HKAS/K11CJjFQ7iJbyTIweINFZOcGUH+OJtYrLARteflRtSjOrjZdzQVw8mgV
         JS9U3xAYtz/2yWLFHZHFcyMJTKirD/2a4T/4c5LId2Dnlqnyu9hl9KTp2YiFA7BYGTav
         9IqZ9aZZ3dP0bfS15xYR4/6W9JgETOY9kJsRrZld8XaPUV7jh0uDBKdBvyKtOzaloZxs
         pmABrw7FrpcbdpYEdBK4S9GKCoq3G4eXg52AQKNYU2g7uqLNT4EfsLZHi3Kh9fHLHSUd
         wD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253762; x=1745858562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nnh9FhtmfBr7vF/QXBT4Oa0ku2sBn0D0ph9GeI/BdhY=;
        b=YTypPKf1ctp/Y+eACaX0t147CpFwSr/WB1jIUBLQmzV103hkkOVpyVQ1W1akD4PtQT
         yR+8y6KS6Vp2k/2a6+1fQLcCO6yQLrKi8hcan1Wfo/1gzDpby7DiFZo8UIkp3q7JaZ5d
         t0doy1yK8DkzHqA8H5EdhybjCE/2wDKlgXp5Ti0BNIsRzp076Hd+c2WmL9AzTDPLZDJx
         VMHEpdiwzhWJ/rNTXnyy1TFKD6DH1CWicMiLPVlD2hYoBrr3Su3VX2EFwpP6DH77Y97V
         KNHuBHFHAnzqgFBJDdiYtFnfCOmh2R6N9gjHMAYiHxVZwV65cmWUyemGsnH9ZHXYBCVl
         LywQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNnJe1K8x/hCQcb3RIV7OmsNSF2B/17MOTs28D0M6wphXD3S2pkbFUludJLUnKpR8XUVrru1yhUKLk@vger.kernel.org, AJvYcCVEZuSKIhUXZt7PLULkjePA3L6PUQgjRKqPJ+FA4sopyTKOa52zWEgTsCR2fgMOGp9TV6+1Q4UfnLpY5cjPWw==@vger.kernel.org, AJvYcCVVPRDZHZcA6ZIQ2/nEZfSVv8ESBS29QLQ18AkcUQVoHJi6vCKbplclGYrQTHWfNkwnU+6HT7nzo2bb9YJ3@vger.kernel.org, AJvYcCWGYKOL/Gn3vpSOnyXToadP8epvG8TUZ2EN7C2ySltkx5nyTLQO0tU/+6eNYBc+FB4Y2rkM@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvBYFI5xdGSMhfVXbPs2Q2AkL3+ZKCpRoNm5cIJWVvhd2TMfG
	1PCVxBCmPQqmZxdCZDA2xX9ZHZ28qlC+xtdh9mGbX/vqQd58J8LgwrDqtA==
X-Gm-Gg: ASbGnct74fp/MPkUxSGDSEFRs56Yb6bGEstPoA5jMBjVuMcNXCO6ehanH1M6UK35iqK
	ldbApaL4bD6MaGg/Xp5TfZGdDkPI4Gwh2H6s0txmttTlybVrb2HAyrUJzUXWTC/m1sdn6npb0T+
	YpRTSd4crs7S+OsT3X2DI0xCU1fQaCWerNP2xW++aTbCToei9vnr43t8R9hjGQFROUl6IKKz8eS
	SIlPz0kw9g8Js8nQGO+J7DBlg6lFSrTmvr7VZb1E8mUP+Zi65xUVHskvCkjVyUFurtMXqyz/MBo
	2Ti8tGzEiqQ9UaXuZMvIgocUG0oF34RrZGhVONl2k4CTN8iCkP9KDuyEvcW+MWht/G89bB09qBW
	Opq4ZH+p7DLd25C3F5961HKpR54SSdoE=
X-Google-Smtp-Source: AGHT+IEGQid9yBRcR2A0o8laWRVzb9RUOp/oLa6XOM8ouA/1CJegibrL3x6J6Kt8/WyFOsT33rR8Yg==
X-Received: by 2002:a0c:ec48:0:b0:6f2:d45c:4a1d with SMTP id 6a1803df08f44-6f2d45c4c07mr132479856d6.38.1745253761526;
        Mon, 21 Apr 2025 09:42:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4ddb2sm435608985a.88.2025.04.21.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:41 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3FC11200043;
	Mon, 21 Apr 2025 12:42:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:40 -0400
X-ME-Sender: <xms:gHUGaIw4ht8I9BG7jyLTBlmvr-MLe-t9TJTlZi_VV6u-gXt5dOk8OA>
    <xme:gHUGaMT3-ZOELGT0bnZ6oxTWtJdkqQGs3X_q39W3jtpt5Tuq6yTEUf3RUIK-y9FNA
    dwQEju3TH-J7zR1dA>
X-ME-Received: <xmr:gHUGaKXuGO5wyZWbNV57LvFuEc8hUKL53NN7KW3a0_5_lnyaSZr0UyTyCPdv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
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
X-ME-Proxy: <xmx:gHUGaGhGBSI7uZwKsbvOikB-hWBjMilvKK-0c8g_Jju_KWk5mFMmuQ>
    <xmx:gHUGaKAupI0L0u_yDuo_TOaX22zCZBsUY2OIZ_OQ3VQV8myykuUTpQ>
    <xmx:gHUGaHI2Mg3Q_2Hbg0J2RvbwoydBS7nRu5JM5CIs956Ef7aD495wjA>
    <xmx:gHUGaBAsATswnzCE-eMo62aGs_S82NbiQ5bx_EZT4xF9e0-HoxaDTQ>
    <xmx:gHUGaKzvhrTbtf5Rqnzg9wO9YFe8WRGwmk7jQQ0r0nnKJQD_8je7OUw0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:39 -0400 (EDT)
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
Subject: [RFC v3 06/12] rust: sync: atomic: Add the framework of arithmetic operations
Date: Mon, 21 Apr 2025 09:42:15 -0700
Message-ID: <20250421164221.1121805-7-boqun.feng@gmail.com>
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

One important set of atomic operations is the arithmetic operations,
i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
make senses for all the types that `AllowAtomic` to have arithmetic
operations, for example a `Foo(u32)` may not have a reasonable add() or
sub(), plus subword types (`u8` and `u16`) currently don't have
atomic arithmetic operations even on C side and might not have them in
the future in Rust (because they are usually suboptimal on a few
architecures). Therefore add a subtrait of `AllowAtomic` describing
which types have and can do atomic arithemtic operations.

A few things about this `AllowAtomicArithmetic` trait:

* It has an associate type `Delta` instead of using
  `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is `i32`)
  may not wants an `add(&self, i32)`, but an `add(&self, u32)`.

* `AtomicImpl` types already implement an `AtomicHasArithmeticOps`
  trait, so add blanket implementation for them. In the future, `i8` and
  `i16` may impl `AtomicImpl` but not `AtomicHasArithmeticOps` if
  arithemtic operations are not available.

Only add() and fetch_add() are added. The rest will be added in the
future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 102 +++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 73aacfac381b..2de4cdbce58e 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -3,6 +3,7 @@
 //! Generic atomic primitives.
 
 use super::ops::*;
+use super::ordering;
 use super::ordering::*;
 use crate::types::Opaque;
 
@@ -55,6 +56,23 @@ fn from_repr(repr: Self::Repr) -> Self {
     }
 }
 
+/// Atomics that allows arithmetic operations with an integer type.
+pub trait AllowAtomicArithmetic: AllowAtomic {
+    /// The delta types for arithmetic operations.
+    type Delta;
+
+    /// Converts [`Self::Delta`] into the representation of the atomic type.
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr;
+}
+
+impl<T: AtomicImpl + AtomicHasArithmeticOps> AllowAtomicArithmetic for T {
+    type Delta = Self;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d
+    }
+}
+
 impl<T: AllowAtomic> Atomic<T> {
     /// Creates a new atomic.
     pub const fn new(v: T) -> Self {
@@ -374,3 +392,87 @@ fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
         }
     }
 }
+
+impl<T: AllowAtomicArithmetic> Atomic<T>
+where
+    T::Repr: AtomicHasArithmeticOps,
+{
+    /// Atomic add.
+    ///
+    /// The addition is a wrapping addition.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.add(12, Relaxed);
+    ///
+    /// assert_eq!(54, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn add<Ordering: RelaxedOnly>(&self, v: T::Delta, _: Ordering) {
+        let v = T::delta_into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_add() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        unsafe {
+            T::Repr::atomic_add(a, v);
+        }
+    }
+
+    /// Atomic fetch and add.
+    ///
+    /// The addition is a wrapping addition.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
+    /// ```
+    #[inline(always)]
+    pub fn fetch_add<Ordering: All>(&self, v: T::Delta, _: Ordering) -> T {
+        let v = T::delta_into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_fetch_add*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        let ret = unsafe {
+            match Ordering::ORDER {
+                ordering::OrderingDesc::Full => T::Repr::atomic_fetch_add(a, v),
+                ordering::OrderingDesc::Acquire => T::Repr::atomic_fetch_add_acquire(a, v),
+                ordering::OrderingDesc::Release => T::Repr::atomic_fetch_add_release(a, v),
+                ordering::OrderingDesc::Relaxed => T::Repr::atomic_fetch_add_relaxed(a, v),
+            }
+        };
+
+        T::from_repr(ret)
+    }
+}
-- 
2.47.1


