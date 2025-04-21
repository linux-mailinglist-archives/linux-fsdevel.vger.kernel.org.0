Return-Path: <linux-fsdevel+bounces-46826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA096A954D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783E6174379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA71F2C45;
	Mon, 21 Apr 2025 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgAW+BjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E521F1313;
	Mon, 21 Apr 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253775; cv=none; b=WlhWRAMs/Imr+rQcisZfA+RRS5Dx8+J+L8WgflvnjlOZHBqgG3ETfWwmlDrcFWp4HOTIcdSSd6j81vcPnfm5bJz9WM5SNqV4TNJ2x+0A9iqxQuZxIUFsbRWeVCQ/YDp5wa58VRV6pNvuUM9aa0+2n2lp91j+6N6DLZnTAeB1ZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253775; c=relaxed/simple;
	bh=ycXL8q2+YDl6YBofOqf86s4FeBh11bM0f53ATgDpB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTQ0M4JNBfnlVCXIlt1H0FenIoKK50rMjlR+zapvQwCCUu8R5BQ9odJULB0CwfBCsax14rYXmvg+BvDIjENYExCyOMo69QSxVRJZLATNPDxZzx+h1Q8utvI8Ei9BjJHsWBJlXgWkUYAWKpcHeNDV28iJ2UiXdcrIEOZVw9y5QRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgAW+BjV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08fc20194so28419285a.2;
        Mon, 21 Apr 2025 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253771; x=1745858571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y7J/QCauCF+ekh62R8O3hTayTSjtfwBqCWuSp+W3eCE=;
        b=fgAW+BjVV0IuGUtdDIbKHOWYRL6/GAYzCDoyo9akdtk/rG06BjxmgWf8QFxnkmudvg
         QGYWt7oiDiH1lhwqO3O905iT8tF4jliU0uBdJGwhQflvjG07bcBICvxThPLBPfyDOvh7
         1K9Uxzh9XbKENdCCQNaXgI3tmIPhzQzdRRTNVXJl7nkXOqH7heMcHni9xZ6xTrZQ9XXF
         ItTS9PXNW/bNM8f3cD8Z+T+6Dj34YCNHwa6MdM12YiMk+oFnF4UBJGb7wcl+Z4f6bVzw
         s8zuJpRh3h4lrqBa3p6JplzqeJ/nTvLpbJwnBG1sEr1bywF91Yds3et1iFOv7j0AlFbR
         rcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253771; x=1745858571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7J/QCauCF+ekh62R8O3hTayTSjtfwBqCWuSp+W3eCE=;
        b=L2yZkY0BFxTyHPPcr/4T+Lqkc+ksrXGmLGG5SdpLp7OSQamUBzpdwo3eoHvnkcad/N
         Xo3F1+rWzIULP9xrYoF88sedsOSfQEi2wy5JNFUW06MA/pIInh7HXwtjsbud99LkD6ox
         K3uP8S7f2fzHnAkDbh5D+4HqEbI3A/8Bz7JqjtfR7wmj5HlDpnYsI0h1RV/GeZffD34p
         BOH9snbg0/tzvTZzVXMDH5MUjcRHEKwP7y9NH407AneYmGJ8njKi/VgwufmFb1wz6IFC
         RgQzb8vUA3Qk5K3AEcYwW3YEuj1Z5Ywl2SnLlvQ/FvcBwJMlha7LnZDvFmie69FzCyC8
         s9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUWLCUKPL1mLf/HdpkVblOj119moFne2P5VNPddqnla5RMJusaTxemBgMJd2TLV3p/r1uUP6XCnRP4r@vger.kernel.org, AJvYcCVsszkFE0H047778FlKqSDQz8VDkDUPnU70Rnw1FJ4ftLtN9qX0lTtaMZP2RgZY1JJ77gum@vger.kernel.org, AJvYcCXEfBzp9Ghpor2lv80j/TF8WrakFfo5OHZ1I4ALw/Id6aNLFwl4NW3a2iNHH7bnLc7gM0dTDxwucqLDDcwN@vger.kernel.org, AJvYcCXh/gSiG5FHLzi7KMlfuMItF/9GH8dKaKkupB0Fs36R7ZeMbzpjcBnx5RAHCOfiWSc8Pm6iJ7AyrjOr7E71iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAsZ5ldzviReyNzxnTSsYQ22hFAxCMLII1ejZArJZ6hRwhwUp
	vVBjSiaQ3RNEmyA0X0dWO4SU162Ep7MAcpFUxq97Mg7CiARl7m+q49EDqA==
X-Gm-Gg: ASbGncvZZFyOVbMhM50hB9xgXnGcp1Cjd6LrtQ9DBXWu7AS6xf7dy9XMD7+XomGalpM
	jogJ9hB1dWSLwr6y9kXkq38hYroVHeyT1jyq/DdlbNARLEbTNo4fcnxFktCpGTzmmSivjHrHHat
	IxVm72/WQGb+J6LRVVtariApo0sTSvidQGkyhLs5HnN1nL/hi/Why7Qc1bzymPy/oy24LvTi2i1
	YDuyHkvczVzSb1UDss4RNGVfqj9aQJF4vkegykuLwFW5mtSgXG3GYS4JB9EmdtKT1aMioDJGwOr
	XrTWRiQlfMV+gwoe5JpEFD2K7zigVQBsfo3+yMX19+J5BslZNVf2BTVL48ermotRHBJRRN35kgW
	Lue3Kv53Jgq+TykgiJgIbztZiQGWHCuI=
X-Google-Smtp-Source: AGHT+IHHrK+fEbc0Vyx8MJUhUYDa6aVvWqz1XnaJe7cGhk0HPZCzn/T19iJEAOhPsfRFssLRPvAlPA==
X-Received: by 2002:a05:620a:4146:b0:7c5:57cd:f1cb with SMTP id af79cd13be357-7c9280196f8mr2018895585a.37.1745253771295;
        Mon, 21 Apr 2025 09:42:51 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9d9sm437087185a.27.2025.04.21.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:50 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 611A91200043;
	Mon, 21 Apr 2025 12:42:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Apr 2025 12:42:50 -0400
X-ME-Sender: <xms:inUGaORcpaPcEuzQr1IyQAVcjj9Go0x4hu8y1bco-clVjpSwZ2UhlA>
    <xme:inUGaDyBA-HhS_aqTivL3Kl85ciy7cq4WqQY8ASCTwR_E6RgDXNFdYbK3K3QTagTH
    bX-hSBThTORB_tX4Q>
X-ME-Received: <xmr:inUGaL1GSheIkJNyy3EdecfpYJeUI-hREdZ1759cC6EZ3Rj6s-7VsSxKsFHK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhf
    gvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgv
    rhhnpedutedvgfetleeiffeihfetgfeiheetueefhedukedvveejuddvheeujeehuefgte
    enucffohhmrghinheptghrrghtvghsrdhiohdpiihulhhiphgthhgrthdrtghomhdpghhi
    thhhuhgsrdgtohhmpdhkrghnghhrvghjohhsrdgtohhmpdhgihhthhhusgdrihhonecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeehiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhmmheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:inUGaKBYTQeenGxlzbt2ma5_91wNhJDIt_UbwBWxJm8S4ROY16FMkA>
    <xmx:inUGaHhAUkmxbrsRTMNt54EVKhJW5yO31O3ZeEBkf2M54aGJW_ElHw>
    <xmx:inUGaGrfdx0hap9-PpevYoMDkyfdeX4VaTG98iOLgtdrhB90FZ7zNQ>
    <xmx:inUGaKjtGJOo8CvZ1JukKvtiSG4GhHC6B1HTWEjncKK6zDbsDaTrEQ>
    <xmx:inUGaGTtstbys_X4xJOZJD0urvnv9_OCUFxinNyzUBKQshtJyw40Fixu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:49 -0400 (EDT)
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
Subject: [RFC v3 12/12] rust: sync: rcu: Add RCU protected pointer
Date: Mon, 21 Apr 2025 09:42:21 -0700
Message-ID: <20250421164221.1121805-13-boqun.feng@gmail.com>
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

RCU protected pointers are an atomic pointer that can be loaded and
dereferenced by mulitple RCU readers, but only one updater/writer can
change the value (following a read-copy-update pattern usually).

This is useful in the case where data is read-mostly. The rationale of
this patch is to provide a proof of concept on how RCU should be exposed
to the Rust world, and it also serves as an example for atomic usage.

Similar mechanisms like ArcSwap [1] are already widely used.

Provide a `Rcu<P>` type with an atomic pointer implementation. `P` has
to be a `ForeignOwnable`, which means the ownership of a object can be
represented by a pointer-size value.

`Rcu::dereference()` requires a RCU Guard, which means dereferencing is
only valid under RCU read lock protection.

`Rcu::read_copy_update()` is the operation for updaters, it requries a
`Pin<&mut Self>` for exclusive accesses, since RCU updaters are normally
exclusive with each other.

A lot of RCU functionalities including asynchronously free (call_rcu()
and kfree_rcu()) are still missing, and will be the future work.

Also, we still need language changes like field projection [2] to
provide better ergonomic.

Acknowledgment: this work is based on a lot of productive discussions
and hard work from others, these are the ones I can remember (sorry if I
forgot your contribution):

* Wedson started the work on RCU field projection and Benno followed it
  up and had been working on it as a more general language feature.
  Also, Gary's field-projection repo [3] has been used as an example for
  related discussions.

* During Kangrejos 2023 [4], Gary, Benno and Alice provided a lot of
  feedbacks on the talk from Paul and me: "If you want to use RCU in
  Rust for Linux kernel..."

* During a recent discussion among Benno, Paul and me, Benno suggested
  using `Pin<&mut>` to guarantee the exclusive access on updater
  operations.

Link: https://crates.io/crates/arc-swap [1]
Link: https://rust-lang.zulipchat.com/#narrow/channel/213817-t-lang/topic/Field.20Projections/near/474648059 [2]
Link: https://github.com/nbdd0121/field-projection [3]
Link: https://kangrejos.com/2023 [4]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/rcu.rs | 275 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index b51d9150ffe2..201c09cb60db 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,12 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::bindings;
+use crate::{
+    sync::atomic::{Atomic, Relaxed, Release},
+    types::{ForeignOwnable, NotThreadSafe},
+};
+use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -45,3 +50,271 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// An RCU protected pointer, the pointed object is protected by RCU.
+///
+/// # Invariants
+///
+/// Either the pointer is null, or it points to a return value of [`P::into_foreign`] and the atomic
+/// variable exclusively owns the pointer.
+pub struct Rcu<P: ForeignOwnable>(Atomic<*mut crate::ffi::c_void>, PhantomData<P>);
+
+/// A pointer that has been unpublished, but hasn't waited for a grace period yet.
+///
+/// The pointed object may still have an existing RCU reader. Therefore a grace period is needed to
+/// free the object.
+///
+/// # Invariants
+///
+/// The pointer has to be a return value of [`P::into_foreign`] and [`Self`] exclusively owns the
+/// pointer.
+pub struct RcuOld<P: ForeignOwnable>(NonNull<crate::ffi::c_void>, PhantomData<P>);
+
+impl<P: ForeignOwnable> Drop for RcuOld<P> {
+    fn drop(&mut self) {
+        // SAFETY: As long as called in a sleepable context, which should be checked by klint,
+        // `synchronize_rcu()` is safe to call.
+        unsafe {
+            bindings::synchronize_rcu();
+        }
+
+        // SAFETY: `self.0` is a return value of `P::into_foreign()`, so it's safe to call
+        // `from_foreign()` on it. Plus, the above `synchronize_rcu()` guarantees no existing
+        // `ForeignOwnable::borrow()` anymore.
+        let p: P = unsafe { P::from_foreign(self.0.as_ptr()) };
+        drop(p);
+    }
+}
+
+impl<P: ForeignOwnable> Rcu<P> {
+    /// Creates a new RCU pointer.
+    pub fn new(p: P) -> Self {
+        // INVARIANTS: The return value of `p.into_foreign()` is directly stored in the atomic
+        // variable.
+        Self(Atomic::new(p.into_foreign()), PhantomData)
+    }
+
+    /// Creates a null RCU pointer.
+    pub const fn null() -> Self {
+        Self(Atomic::new(core::ptr::null_mut()), PhantomData)
+    }
+
+    /// Dereferences the protected object.
+    ///
+    /// Returns `Some(b)`, where `b` is a reference-like borrowed type, if the pointer is not null,
+    /// otherwise returns `None`.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # use kernel::alloc::{flags, KBox};
+    /// use kernel::sync::rcu::{self, Rcu};
+    ///
+    /// let x = Rcu::new(KBox::new(100i32, flags::GFP_KERNEL)?);
+    ///
+    /// let g = rcu::read_lock();
+    /// // Read in under RCU read lock protection.
+    /// let v = x.dereference(&g);
+    ///
+    /// assert_eq!(v, Some(&100i32));
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// Note the borrowed access can outlive the reference of the [`Rcu<P>`], this is because as
+    /// long as the RCU read lock is held, the pointed object should remain valid.
+    ///
+    /// In the following case, the main thread is responsible for the ownership of `shared`, i.e. it
+    /// will drop it eventually, and a work item can temporarily access the `shared` via `cloned`,
+    /// but the use of the dereferenced object doesn't depend on `cloned`'s existence.
+    ///
+    /// ```rust
+    /// # use kernel::alloc::{flags, KBox};
+    /// # use kernel::workqueue::system;
+    /// # use kernel::sync::{Arc, atomic::{Atomic, Acquire, Release}};
+    /// use kernel::sync::rcu::{self, Rcu};
+    ///
+    /// struct Config {
+    ///     a: i32,
+    ///     b: i32,
+    ///     c: i32,
+    /// }
+    ///
+    /// let config = KBox::new(Config { a: 1, b: 2, c: 3 }, flags::GFP_KERNEL)?;
+    ///
+    /// let shared = Arc::new(Rcu::new(config), flags::GFP_KERNEL)?;
+    /// let cloned = shared.clone();
+    ///
+    /// // Use atomic to simulate a special refcounting.
+    /// static FLAG: Atomic<i32> = Atomic::new(0);
+    ///
+    /// system().try_spawn(flags::GFP_KERNEL, move || {
+    ///     let g = rcu::read_lock();
+    ///     let v = cloned.dereference(&g).unwrap();
+    ///     drop(cloned); // release reference to `shared`.
+    ///     FLAG.store(1, Release);
+    ///
+    ///     // but still need to access `v`.
+    ///     assert_eq!(v.a, 1);
+    ///     drop(g);
+    /// });
+    ///
+    /// // Wait until `cloned` dropped.
+    /// while FLAG.load(Acquire) == 0 {
+    ///     // SAFETY: Sleep should be safe.
+    ///     unsafe { kernel::bindings::schedule(); }
+    /// }
+    ///
+    /// drop(shared);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn dereference<'rcu>(&self, _rcu_guard: &'rcu Guard) -> Option<P::Borrowed<'rcu>> {
+        // Ordering: Address dependency pairs with the `store(Release)` in read_copy_update().
+        let ptr = self.0.load(Relaxed);
+
+        if !ptr.is_null() {
+            // SAFETY:
+            // - Since `ptr` is not null, so it has to be a return value of `P::into_foreign()`.
+            // - The returned `Borrowed<'rcu>` cannot outlive the RCU Guar, this guarantees the
+            //   return value will only be used under RCU read lock, and the RCU read lock prevents
+            //   the pass of a grace period that the drop of `RcuOld` or `Rcu` is waiting for,
+            //   therefore no `from_foreign()` will be called for `ptr` as long as `Borrowed` exists.
+            //
+            //      CPU 0                                       CPU 1
+            //      =====                                       =====
+            //      { `x` is a reference to Rcu<Box<i32>> }
+            //      let g = rcu::read_lock();
+            //
+            //      if let Some(b) = x.dereference(&g) {
+            //      // drop(g); cannot be done, since `b` is still alive.
+            //
+            //                                              if let Some(old) = x.replace(...) {
+            //                                                  // `x` is null now.
+            //          println!("{}", b);
+            //      }
+            //                                                  drop(old):
+            //                                                    synchronize_rcu();
+            //      drop(g);
+            //                                                    // a grace period passed.
+            //                                                    // No `Borrowed` exists now.
+            //                                                    from_foreign(...);
+            //                                              }
+            Some(unsafe { P::borrow(ptr) })
+        } else {
+            None
+        }
+    }
+
+    /// Read, copy and update the pointer with new value.
+    ///
+    /// Returns `None` if the pointer's old value is null, otherwise returns `Some(old)`, where old
+    /// is a [`RcuOld`] which can be used to free the old object eventually.
+    ///
+    /// The `Pin<&mut Self>` is needed because this function needs the exclusive access to
+    /// [`Rcu<P>`], otherwise two `read_copy_update()`s may get the same old object and double free.
+    /// Using `Pin<&mut Self>` provides the exclusive access that C side requires with the type
+    /// system checking.
+    ///
+    /// Also this has to be `Pin` because a `&mut Self` may allow users to `swap()` safely, that
+    /// will break the atomicity. A [`Rcu<P>`] should be structurally pinned in the struct that
+    /// contains it.
+    ///
+    /// Note that `Pin<&mut Self>` cannot assume noalias here because [`Atomic<T>`] is a
+    /// [`Opaque<T>`] which has the same effect on aliasing rules as [`UnsafePinned`].
+    ///
+    /// [`UnsafePinned`]: https://rust-lang.github.io/rfcs/3467-unsafe-pinned.html
+    pub fn read_copy_update<F>(self: Pin<&mut Self>, f: F) -> Option<RcuOld<P>>
+    where
+        F: FnOnce(Option<P::Borrowed<'_>>) -> Option<P>,
+    {
+        // step 1: READ.
+        // Ordering: Address dependency pairs with the `store(Release)` in read_copy_update().
+        let old_ptr = NonNull::new(self.0.load(Relaxed));
+
+        let old = old_ptr.map(|nonnull| {
+            // SAFETY: Per type invariants `old_ptr` has to be a value return by a previous
+            // `into_foreign()`, and the exclusive reference `self` guarantees that `from_foreign()`
+            // has not been called.
+            unsafe { P::borrow(nonnull.as_ptr()) }
+        });
+
+        // step 2: COPY, or more generally, initializing `new` based on `old`.
+        let new = f(old);
+
+        // step 3: UPDATE.
+        if let Some(new) = new {
+            let new_ptr = new.into_foreign();
+            // Ordering: Pairs with the address dependency in `dereference()` and
+            // `read_copy_update()`.
+            // INVARIANTS: `new.into_foreign()` is directly store into the atomic variable.
+            self.0.store(new_ptr, Release);
+        } else {
+            // Ordering: Setting to a null pointer doesn't need to be Release.
+            // INVARIANTS: The atomic variable is set to be null.
+            self.0.store(core::ptr::null_mut(), Relaxed);
+        }
+
+        // INVARIANTS: The exclusive reference guarantess that the ownership of a previous
+        // `into_foreign()` transferred to the `RcuOld`.
+        Some(RcuOld(old_ptr?, PhantomData))
+    }
+
+    /// Replaces the pointer with new value.
+    ///
+    /// Returns `None` if the pointer's old value is null, otherwise returns `Some(old)`, where old
+    /// is a [`RcuOld`] which can be used to free the old object eventually.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use core::pin::pin;
+    /// # use kernel::alloc::{flags, KBox};
+    /// use kernel::sync::rcu::{self, Rcu};
+    ///
+    /// let mut x = pin!(Rcu::new(KBox::new(100i32, flags::GFP_KERNEL)?));
+    /// let q = KBox::new(101i32, flags::GFP_KERNEL)?;
+    ///
+    /// // Read in under RCU read lock protection.
+    /// let g = rcu::read_lock();
+    /// let v = x.dereference(&g);
+    ///
+    /// // Replace with a new object.
+    /// let old = x.as_mut().replace(q);
+    ///
+    /// assert!(old.is_some());
+    ///
+    /// // `v` should still read the old value.
+    /// assert_eq!(v, Some(&100i32));
+    ///
+    /// // New readers should get the new value.
+    /// assert_eq!(x.dereference(&g), Some(&101i32));
+    ///
+    /// drop(g);
+    ///
+    /// // Can free the object outside the read-side critical section.
+    /// drop(old);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn replace(self: Pin<&mut Self>, new: P) -> Option<RcuOld<P>> {
+        self.read_copy_update(|_| Some(new))
+    }
+}
+
+impl<P: ForeignOwnable> Drop for Rcu<P> {
+    fn drop(&mut self) {
+        let ptr = *self.0.get_mut();
+        if !ptr.is_null() {
+            // SAFETY: As long as called in a sleepable context, which should be checked by klint,
+            // `synchronize_rcu()` is safe to call.
+            unsafe {
+                bindings::synchronize_rcu();
+            }
+
+            // SAFETY: `self.0` is a return value of `P::into_foreign()`, so it's safe to call
+            // `from_foreign()` on it. Plus, the above `synchronize_rcu()` guarantees no existing
+            // `ForeignOwnable::borrow()` anymore.
+            drop(unsafe { P::from_foreign(ptr) });
+        }
+    }
+}
-- 
2.47.1


