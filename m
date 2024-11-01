Return-Path: <linux-fsdevel+bounces-33419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E09B8AEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF41C21610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75215CD41;
	Fri,  1 Nov 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONiENVIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112C15747D;
	Fri,  1 Nov 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441049; cv=none; b=HfCJaRJc4jsuIeQfFH7uHp8QI+DZ6ruL75l98H8ppQ7u3mTg0ePxb7ucL8Uc5bEcwnDMMoGP029Mb+tqzZ2L1dt1ymQYproWQDv9S/HUFgwnzkxwx/NYZFDiHA9fkgu++YrIZtRlhxvEn96EbWRi+xeeqG0lmt1A6Yd37N9Tcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441049; c=relaxed/simple;
	bh=dbFh5tZ5JSCZ2km4t7r3WkaZizr4S5DDdwDqMMZTjO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUXBJiHZo9B6ps3nBF6caYOIjAB0lcQOVN5J3k1yLsP1ijTkXd8IgmcVk5NCL8hP0xGlJ9Efwn0TnQSuBI0r3GycrXBj7ocmwJfsw2XO8bSdhcSvgc24ldkDizK8WUAVLu7JiYuHbhcyPGRPX8GqrIp1zidOiCIV+GGFy6VV1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONiENVIL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460dce6fff9so11624721cf.1;
        Thu, 31 Oct 2024 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441046; x=1731045846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JH7KGrs5tWNaElymjoHhwHajdPBdI1O/huzZLgMbScw=;
        b=ONiENVIL2LWdgx2RCBwcRc87pmsUyS8swFD5U6mxEXUbdU4D1IOQcVSYWxTTsfkP/T
         B9p0sfIT/+8rCUPtpv77v7GM+46xfPHZZTppWuc2TDMF0Du7gpvkrFbN/z1TGKImTlDq
         x0aHf4cYpp5LKLYZvfClykvAnxUhNNDucI4nERkNJs5u58/Haja+/dvK+1hQzAiKbOpm
         a2ZIDvfgNwtLRT2QKykTC38sdVxUWwmF+jaAp9wLUJsvmms9KJyPqvAmnodr4sgCiIg+
         QLbbXorfflaMwG8KBbx9vqMVjHKCwfM2MwIER0O9fP485xtJG0+OgfSKOJ+GWVENIY8Y
         ARrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441046; x=1731045846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JH7KGrs5tWNaElymjoHhwHajdPBdI1O/huzZLgMbScw=;
        b=XuvHoGNMKUD12MQVCRgcP9Av9jPedC+vJhrq1GRKn/DENrpAkic4qGu/P1pLqmKbKT
         toV+x8s4rQCJF/O9QrDGghjRwJK/LS0CYFB5Y6RiUOYjLS8cwPOx4fMnzU7y4XGk6GiI
         /McS7BC4d8qdFE8KYU6eWQv74sxV8LMZiS+PCHQTecgKeIHDlfwQaFOzAJ/MAJfifkdl
         QUOKQmJi0TfGwcHc9G28ekZOXvFVvcrtxAXxM47o6KZQRY/5j2p9j5DHTcgR647kV1NR
         SnAnC+08Gg5yLWFHfYjBlYzc8CAkWNylZ3yAX0I/mv+zcY2EroYfyK+lwkOsT1839APd
         wbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOFD056xKHKOgKQbzSHxJeN+JoCau8JzMZMpBsGUgT+XFkwKFZ4hzIa1I05yH3aj2fHeLKLK+3GJW@vger.kernel.org, AJvYcCVF6GlqDKXiDnMd9joRJC6tH1q11tnaWNwm75BJmDPaduC/8m4Yq2icfu1ZmbGBdGYaBgPihcE2LQTSMREj6Q==@vger.kernel.org, AJvYcCVqQ3rM9EN5ypXBj40tMpU/8kGQS1KbfHE3Zbqri3AQoM45RJwtg6EV96Mw5Tk8wRucNYm1@vger.kernel.org, AJvYcCWlZZgMFjI/woN4w4mxCO4TZig6sOJRSgPmqvXy5MvKNmD0C9HS8jvbmeDAfOxcrCs75rBDHXCKIGy15Ksl@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiXuO4kUJfXXBDG0r4N5fbRCn2nQcSY6YrZdAqCChg1hakG86
	gDRPNTEBZMf5ayl5+TGIF3yIPfvl4aXAqQt0Jl2E0sWPtlfLAgZO
X-Google-Smtp-Source: AGHT+IETHN8t913Neds+Flo2tBJr2gQ2uOlumxv7dWk8jfF6Hj1+Hl306SbJkBvaA4RYy6WrLaswjw==
X-Received: by 2002:ac8:7dc8:0:b0:460:a9ec:b4fd with SMTP id d75a77b69052e-462b8759878mr19769901cf.42.1730441045924;
        Thu, 31 Oct 2024 23:04:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad1a0f59sm15188921cf.81.2024.10.31.23.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:04:05 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1BDFE1200043;
	Fri,  1 Nov 2024 02:04:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 01 Nov 2024 02:04:05 -0400
X-ME-Sender: <xms:VW8kZ4JO8nZn8stwnoGLwG7M1deKc8KbNIHPJ-t-u0o9MEuElGk9jQ>
    <xme:VW8kZ4JVgruJRqq1JKUsGKKcIwDvgkwxSpA-akNuWFtMm4jW9uTKZ8rav0kiN9UPC
    7cXu9Qs1PQO02IfIg>
X-ME-Received: <xmr:VW8kZ4uMiXYrNGIcNbNc7nz_UYWeVhG-ffdi7S0duLCMYPzIXJrg_wvC2iFiMg>
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
X-ME-Proxy: <xmx:VW8kZ1Yl3Wtqdbc4vWLINrvHRGgucu-InHW94wXbmn9oEj03eHgHJg>
    <xmx:VW8kZ_btP9iX2_eY7ZX7gCWN6kM-RYm5jXbwrNMNYSeuVRQYIOx1Ug>
    <xmx:VW8kZxDysbZIvVyh-7cBn73gn0lFbn9MhoxMA4RNYVDuSKqzsAiovA>
    <xmx:VW8kZ1YCnCIpgGsFdioIU29W8VySsvsgQwzUolobAmTvOMc3la-9Mg>
    <xmx:VW8kZ3oPf6rNLC6r1eYjWJOPYh-yZTsFyV93VsXrp1RC2qbxHe9z0SOP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:04:04 -0400 (EDT)
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
Subject: [RFC v2 09/13] rust: sync: atomic: Add Atomic<*mut T>
Date: Thu, 31 Oct 2024 23:02:32 -0700
Message-ID: <20241101060237.1185533-10-boqun.feng@gmail.com>
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

Add atomic support for raw pointer values, similar to `isize` and
`usize`, the representation type is selected based on CONFIG_64BIT.

`*mut T` is not `Send`, however `Atomic<*mut T>` definitely needs to be
a `Sync`, and that's the whole point of atomics: being able to have
multiple shared references in different threads so that they can sync
with each other. As a result, a pointer value will be transferred from
one thread to another via `Atomic<*mut T>`:

	<thread 1>		<thread 2>
	x.store(p1, Relaxed);
				let p = x.load(p1, Relaxed);

This means a raw pointer value (`*mut T`) needs to be able to transfer
across thread boundaries, which is essentially `Send`.

To reflect this in the type system, and based on the fact that pointer
values can be transferred safely (only using them to dereference is
unsafe), as suggested by Alice, extend the `AllowAtomic` trait to
include a customized `Send` semantics, that is: `impl AllowAtomic` has
to be safe to be transferred across thread boundaries.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs         | 24 ++++++++++++++++++++++++
 rust/kernel/sync/atomic/generic.rs | 16 +++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4166ad48604f..e62c3cd1d3ca 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -173,3 +173,27 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
         d as _
     }
 }
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let x = Atomic::new(core::ptr::null_mut::<i32>());
+///
+/// assert!(x.load(Relaxed).is_null());
+/// ```
+// SAFETY: A `*mut T` has the same size and the alignment as `i64` for 64bit and the same as `i32`
+// for 32bit. And it's safe to transfer the ownership of a pointer value to another thread.
+unsafe impl<T> generic::AllowAtomic for *mut T {
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+    #[cfg(not(CONFIG_64BIT))]
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index a75c3e9f4c89..cff98469ed35 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -19,6 +19,10 @@
 #[repr(transparent)]
 pub struct Atomic<T: AllowAtomic>(Opaque<T>);
 
+// SAFETY: `Atomic<T>` is safe to send between execution contexts, because `T` is `AllowAtomic` and
+// `AllowAtomic`'s safety requirement guarantees that.
+unsafe impl<T: AllowAtomic> Send for Atomic<T> {}
+
 // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
 unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
 
@@ -30,8 +34,13 @@ unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
 ///
 /// # Safety
 ///
-/// [`Self`] must have the same size and alignment as [`Self::Repr`].
-pub unsafe trait AllowAtomic: Sized + Send + Copy {
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - The implementer must guarantee it's safe to transfer ownership from one execution context to
+///   another, this means it has to be a [`Send`], but because `*mut T` is not [`Send`] and that's
+///   the basic type needs to support atomic operations, so this safety requirement is added to
+///   [`AllowAtomic`] trait. This safety requirement is automatically satisfied if the type is a
+///   [`Send`].
+pub unsafe trait AllowAtomic: Sized + Copy {
     /// The backing atomic implementation type.
     type Repr: AtomicImpl;
 
@@ -42,7 +51,8 @@ pub unsafe trait AllowAtomic: Sized + Send + Copy {
     fn from_repr(repr: Self::Repr) -> Self;
 }
 
-// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment.
+// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment. And all
+// `AtomicImpl` types are `Send`.
 unsafe impl<T: AtomicImpl> AllowAtomic for T {
     type Repr = Self;
 
-- 
2.45.2


