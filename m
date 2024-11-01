Return-Path: <linux-fsdevel+bounces-33415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F59B8ADF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBC31C218B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E3155CBD;
	Fri,  1 Nov 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3bka8nE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C8153BC1;
	Fri,  1 Nov 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441044; cv=none; b=qd5LRgIbgSdkImcb9tER7Pk90RA/YPgcEx2nS3x/2/ILGtdTwoOZ203SOd9NdIKwwFnyTa7Ueh1XDF96mDNvoIeFb9Bry9jmGDqQuiAJwUCmSypXZTVjOidqRdoyhHuybjSctzfamRSXrh5Zg6AyEB+Dl343jmeqoOC7/7a7feM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441044; c=relaxed/simple;
	bh=AULQsJAX54VanQqjNTQit54J/T5nh/au0w7mRidEmgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap9UvG7ipkagX1MKuaysGl99bgsaQ+2pSZsBy9Unv3W1BzT1wCgWGimjgWVzbbbxvdGZEofACFZiVP0eEYEEwCbXdWCMBh0T9/fuxoSO6uWr+8djq9rqOh6PYUL74rQlugoQAML3Gns0kLqldFtAL2sSTSW1Qr4Sb7OFT21I+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3bka8nE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b14443a71eso130453085a.1;
        Thu, 31 Oct 2024 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441040; x=1731045840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ur8oT6TSfzITnezWCsfVdDRwD9KFpZB0nobhPnadT3A=;
        b=b3bka8nE1nj+6qzXZ0ko2P6rcoIHWJJuwJHtWjlZakC+ndWtoeRdFSsW4C6BqUwINc
         WXeqnY1rSCKlTD1NyMgzi9pEsog6h5lISjkEKuV4xc6+EueNp6A60H9imCzHTFbFYMxT
         7LiGdRYdcKGLpMKEGgekylWQBp3sFq/gw1ASXm8EnZiJOhrMRKJ08jPkpTOTwQhwPtOu
         VdlBoDBkcRwT6peiaU3ElPrceSs7i94oPPNLQnH3bA2Y8wmP4XR39PqEatx4E+hcfiy2
         vwBva4kpBKfrySC1y6iYpFTjGDCW9ZpS6tioB0a1kuLarEARuNlcLVboHIrU3vDpD7my
         z5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441040; x=1731045840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur8oT6TSfzITnezWCsfVdDRwD9KFpZB0nobhPnadT3A=;
        b=aqM9BqS6eXHC7yP4fr6urid05KwIOR8fNWcyvZnRrUb9d9uGDUiZNJqpgRvOBb+0+1
         6kmlbzSGqpm0vBL5QthMT22LbncqsopDezh3C2YiikUL98CuWJZcj2PpLGq8ngaDLfdd
         gqjsGiE9wiDg268dhb2n5LTFLBPT7AcHsckGaXKW2uPsgGOq49pua8rfHQ9NtgHU1l+G
         C6Og9JnSvvyaHEGc1Y5d63NCeEJiJthUX8y+TH+Tq7QOI3vodtBLwKMI00PJUY1EhlVW
         cE5g0dkFmdCjGG0PCliJKjFpar6nFypGpM7CwbO+Lwzzu+0Du699inKhaagH6g0zC4k6
         xvZg==
X-Forwarded-Encrypted: i=1; AJvYcCUQoM9pIE7Bd5D6rrx2wCF8Wpf4jgYqLoxgDW6+RL5QNKyXYGdD63UrfSSUTYOiY2wrRGgfuRP6pb9toopodg==@vger.kernel.org, AJvYcCUdwCxTknogsIAuk7bVBRXvKOi118+6Aoeh1QMFY29rJ4l9QOx6vN2N1sFUDdgiBxjdYOiiXSYUA4MYSGPP@vger.kernel.org, AJvYcCV53Urzc7rXqSPz7sSWip4r4cqdfLg7pAZgJXFvE+nSTdLqkVvacqWf++GxIcrNGeDycdn8@vger.kernel.org, AJvYcCV9YCf8TrvFqa0jua2MZEWRKo4p1MoTXLDsS3NVdXCM4PlazhqCnLJf34gpgB24xHEKhDIPG+WX093f@vger.kernel.org
X-Gm-Message-State: AOJu0YzmU0VbjF5z7DQUQM8lAWik3JkaKB6m5vGjPAdM7/ThgboS2cAl
	90q6Sy3K6VLRiMg8O01iPvMELUV1JApw7fM4wHWYmSDciqDkKIKdeqenya2l
X-Google-Smtp-Source: AGHT+IGn7Fnf4JT4SwGlNPdIbNgp1gAaBz5TefgXj4tVD56scmLw0kxKdLNV3Y09a04dPX67p+HI/Q==
X-Received: by 2002:a05:6214:2d41:b0:6cb:fac2:82d with SMTP id 6a1803df08f44-6d35c165436mr24296566d6.30.1730441040151;
        Thu, 31 Oct 2024 23:04:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1d6sm15724766d6.76.2024.10.31.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:03:59 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 27C0D1200043;
	Fri,  1 Nov 2024 02:03:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 01 Nov 2024 02:03:59 -0400
X-ME-Sender: <xms:T28kZxUrv7sWy1Iy0Y_-A98MxDQopFJUyepQ6_jEtFuUO0VlQpRCAg>
    <xme:T28kZxlSbOZXry3q5AIpbFrxpi1pvn9EpRKz3XwDZzZwLq2AT5Ll-E6ahoMm4CEJN
    wuCVFJahoiGb9qucA>
X-ME-Received: <xmr:T28kZ9bCTcIRcOab_gwEVKz_ff1dAmFkGJk255WgaqbZgIORD7KnMrTpFqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
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
X-ME-Proxy: <xmx:T28kZ0WlUw590Gddo92AqC0vBYevx1g7hjhaVbrxIMVpD8vd_qEfHA>
    <xmx:T28kZ7kg-a1yDGNDMrtNzNRb7BDZylw9NeAtc_YBsnNfNiFL1hVFFA>
    <xmx:T28kZxfB6_9Aeir16tYOpMaviis25YyiqPeCrFK2vjQDNhO0eYxXxg>
    <xmx:T28kZ1FyrSw-QoGfmf5oClz5J2wyqQRNgVvLFoGOz60UQ_TDb-UQyA>
    <xmx:T28kZ1k_64ODe8frssnJg4tv1MW27bQbWJH7GtBp44HeMT9XwpVlDAzF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:03:58 -0400 (EDT)
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
Subject: [RFC v2 05/13] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Thu, 31 Oct 2024 23:02:28 -0700
Message-ID: <20241101060237.1185533-6-boqun.feng@gmail.com>
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

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails. With
the compiler optimization and inline helpers, it should provides the
same efficient code generation as using atomic_try_cmpxchg() or
atomic_cmpxchg() correctly.

Except it's not! Because of commit 44fe84459faf ("locking/atomic: Fix
atomic_try_cmpxchg() semantics"), the atomic_try_cmpxchg() on x86 has a
branch even if the caller doesn't care about the success of cmpxchg and
only wants to use the old value. For example, for code like:

    // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
    let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);

It will still generate code:

    movl    $0x40, %ecx
    movl    $0x34, %eax
    lock
    cmpxchgl        %ecx, 0x4(%rsp)
    jne     1f
2:
...
1:  movl    %eax, %ecx
    jmp 2b

Attempting to write an x86 try_cmpxchg_exclusive() for Rust use only,
because the Rust function takes a `&mut` for old pointer, which must be
exclusive to the function, therefore it's unsafe to use some shared
pointer. But maybe I'm missing something?

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 151 +++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 204da38e2691..bfccc4336c75 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -251,3 +251,154 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
         };
     }
 }
+
+impl<T: AllowAtomic> Atomic<T>
+where
+    T::Repr: AtomicHasXchgOps,
+{
+    /// Atomic exchange.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.xchg(52, Acquire));
+    /// assert_eq!(52, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
+        let v = T::into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_xchg*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        let ret = unsafe {
+            match Ordering::ORDER {
+                OrderingDesc::Full => T::Repr::atomic_xchg(a, v),
+                OrderingDesc::Acquire => T::Repr::atomic_xchg_acquire(a, v),
+                OrderingDesc::Release => T::Repr::atomic_xchg_release(a, v),
+                OrderingDesc::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
+            }
+        };
+
+        T::from_repr(ret)
+    }
+
+    /// Atomic compare and exchange.
+    ///
+    /// Compare: The comparison is done via the byte level comparison between the atomic variables
+    /// with the `old` value.
+    ///
+    /// Ordering: A failed compare and exchange does provide anything, the read part of a failed
+    /// cmpxchg should be treated as a relaxed read.
+    ///
+    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
+    /// otherwise returns `Err(value)`, and `value` is the value of the atomic variable when cmpxchg
+    /// was happening.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// // Checks whether cmpxchg succeeded.
+    /// let success = x.cmpxchg(52, 64, Relaxed).is_ok();
+    /// # assert!(!success);
+    ///
+    /// // Checks whether cmpxchg failed.
+    /// let failure = x.cmpxchg(52, 64, Relaxed).is_err();
+    /// # assert!(failure);
+    ///
+    /// // Uses the old value if failed, probably re-try cmpxchg.
+    /// match x.cmpxchg(52, 64, Relaxed) {
+    ///     Ok(_) => { },
+    ///     Err(old) => {
+    ///         // do something with `old`.
+    ///         # assert_eq!(old, 42);
+    ///     }
+    /// }
+    ///
+    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
+    /// let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
+    /// # assert_eq!(42, latest);
+    /// assert_eq!(64, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: All>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
+        if self.try_cmpxchg(&mut old, new, o) {
+            Ok(old)
+        } else {
+            Err(old)
+        }
+    }
+
+    /// Atomic compare and exchange and returns whether the operation succeeds.
+    ///
+    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg`].
+    ///
+    /// Returns `true` means the cmpxchg succeeds otherwise returns `false` with `old` updated to
+    /// the value of the atomic variable when cmpxchg was happening.
+    #[inline(always)]
+    fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
+        let old = (old as *mut T).cast::<T::Repr>();
+        let new = T::into_repr(new);
+        let a = self.0.get().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_try_cmpchg*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        //   - `old` is a valid pointer to write because it comes from a mutable reference.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        unsafe {
+            match Ordering::ORDER {
+                OrderingDesc::Full => T::Repr::atomic_try_cmpxchg(a, old, new),
+                OrderingDesc::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, old, new),
+                OrderingDesc::Release => T::Repr::atomic_try_cmpxchg_release(a, old, new),
+                OrderingDesc::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, old, new),
+            }
+        }
+    }
+
+    /// Atomic compare and exchange and return the [`Result`].
+    ///
+    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg`].
+    ///
+    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
+    /// otherwise returns `Err(value)`, and `value` is the value of the atomic variable when cmpxchg
+    /// was happening.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert!(x.compare_exchange(52, 64, Acquire).is_err());
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert!(x.compare_exchange(42, 64, Acquire).is_ok());
+    /// assert_eq!(64, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn compare_exchange<Ordering: All>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
+        if self.try_cmpxchg(&mut old, new, o) {
+            Ok(old)
+        } else {
+            Err(old)
+        }
+    }
+}
-- 
2.45.2


