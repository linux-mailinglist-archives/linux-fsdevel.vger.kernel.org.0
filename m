Return-Path: <linux-fsdevel+bounces-46816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3804A954B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744A11895560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA61E3DEF;
	Mon, 21 Apr 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnhIPfVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4741E5B64;
	Mon, 21 Apr 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253759; cv=none; b=VDHGnnP+QzbJoN7bpiRserFhSKYdcxadkWE52TcJi+sSgrEN6XhTl0dnp7lBGdHqZ4kcydtEeeBv8c2Zxgpsk/4JBY3OoMVLoZA/CcdzdBGLnsZhnNh39y9eLTS6PHokUKkgR7Xo37U0b3ZERg6/Wx9SgmDs0g5Fbdv17eAdoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253759; c=relaxed/simple;
	bh=BabJT8shFeooLOlaKbp3PTDt9xeyZZVe051+I5Kt8A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7LZjiLVmm+BjZOAub9GXt8reASHZaO73MwGJf8GfkFRY33tRRVBk/n9wFeOvq39b0103YaxtuHTCkPFespdPr2ncCPCQTbCsLUohloMsBYrwUXWquA36mKEE3/WBKGJssWJGt0HQadGC23J4w3qMXufie1ihDYZzSCpD+pZBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnhIPfVL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4769b16d4fbso22167901cf.2;
        Mon, 21 Apr 2025 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253756; x=1745858556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8saFQNyFDcMMxSMO/2MuZCuMNf/4lANNbiDkrHm2aLE=;
        b=jnhIPfVL53Vq65yx8DgBu3MbGoFAT/eXWzdUfSr06y2wcoutLdlnLTgJCQONV+Tud0
         4g73Kl3YsBeB2sTqlWeN52wvy2AMSabmdslivJb30nPdQ8nqZ8TO6YsYlYMp2pXKkiRW
         uw1sxybfa9gunoGXrDfwxbN7/rH4YyxDAmfT1CIiU+63MGK1Al7ZQM91qhWoNzGN+w0a
         ouxYpqxRn0vn+Fs+hq1urBQQUQnKHHMQUtdUg+TgO5En6CeAANxjyzj/rrAZwP7pC/vU
         nAr+TdZtb7YtZ9+RydK02hOSK17dQqtisIzKOdSnZc/WcUIqlrCz3gsZrSSE2iTCNUNU
         imIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253756; x=1745858556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8saFQNyFDcMMxSMO/2MuZCuMNf/4lANNbiDkrHm2aLE=;
        b=sSp+UqX1AXtrMSYL113cXq68+TSIqaFhJ9roCYGSFIchZBKPRh0E0xnXo3sxz6II5X
         oB8O8tAzORfw0O5HJ8TeHqtUbbgCaqVzqQvji3JYj07Apf2v4N+PJa+MhTR6MYpnm1Cu
         Ztrq3Wy72ovh+mCHDEDT0PSo4h5Wc5PH70Hr/6nqOOBzZQZDboO60uvlrp7+kzqvk0pf
         uGKM8rxnJ8J//iEoROOgWYRSK+IRAkp83nhLvaeZ/e12yvwODzN5yJ+bjQTRz7jyQutu
         /wZvbnuy7/r+2PxtAIIoMfVp1/JfTZU26trcil0OmeaMn6RLlc3xalZsAciYEJ2zi3kl
         7H5w==
X-Forwarded-Encrypted: i=1; AJvYcCUceZ1mQ8fEn26ubOseT2JS87oZcIXqMAWkdTL1l2D0+3vnBj3ifw8v7lTN3xK7TNjYEACiqU3KgotFiTMygA==@vger.kernel.org, AJvYcCVpADDj+kL6SmDzVEzmShChBHI6QKGOMl8+hG3C7eH2OyNC3xTjIrwgXci+kpXlztCcxRQkWsP2phd7TtXW@vger.kernel.org, AJvYcCWP7CedXQ5ikzj1E6Uvt/dL68po5MjS2sLqjqRPaVDfZlJZJGElZSKFSZgTKhnhw3YKke6LUaO94bZ2@vger.kernel.org, AJvYcCXZxP4mWk5kiuWAxbP8WcpUO2XfNAxeXPoVblGhgULn5eyEZ7Kavmxc8i36XXApkHkRSvfg@vger.kernel.org
X-Gm-Message-State: AOJu0YyuN0fr71wHsAxX8DXqqH6Kw3DtdUMfvD0QIDx7w6qwSeZ04xrW
	uhwtkyY+JPWELW63zhpvgIchLpqE4QKa/GJIi+jWi/wv0ZEB4zDj/SQrKw==
X-Gm-Gg: ASbGncte6o/AYZPntbwzhw56ECTvugWcrpcksX6GyNe8QEFRv7dn+PnFBmQ/tcdblgJ
	bWrX3SEo3vrxLV5DoYdTHZw6YXdRuOLibe9vNPE3vJtYL17ThofZxp+MYNpXTweo+aC/Cd7ZL/a
	AI0FUr4kyTkxjVinAmLWFX/c491OfmouapAi1eT/EmPNfEVCM6bYck0ENrguDJOrmjniMVfw+nN
	yx9bwaRFWdbmexoLg/iQqY/NC+Kx0gybJN7xkOy1Psa7Tsbu6Lcvz12VPDzVSz4SCbg0MlAc7B0
	IOeffgkbWaIErH3QIFYfH2rg72096SQ1TwCE2wuCQpXzMh4hjJkukbu7QogPX5RcF38Gs/Au1DV
	GAf6XK210H59fXObuHpXMCGiBJG4efrI=
X-Google-Smtp-Source: AGHT+IG9hxjtMqFn1bbKak24JtECxpwyBj4OMatGmTvxpRmezdZrvAyzLih6f/8OgHcFAKZl1xOKJg==
X-Received: by 2002:a05:622a:3c7:b0:476:8ee8:d8a0 with SMTP id d75a77b69052e-47aec39232bmr231364961cf.2.1745253756248;
        Mon, 21 Apr 2025 09:42:36 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm43825731cf.74.2025.04.21.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:35 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8A0CE1200043;
	Mon, 21 Apr 2025 12:42:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:35 -0400
X-ME-Sender: <xms:e3UGaOJuPUX353U4Na-PAzbZ9_eIacaEv3koh8zvIRjobm3xRPCrmA>
    <xme:e3UGaGJeFSnMgyj6zNUtSMbtIJXHeuvdtwp9TAj6T_MeENHbWqAruAqQ93VDJNYWE
    vu-qbVleOnSgy5Gfw>
X-ME-Received: <xmr:e3UGaOuTnaY5XLzrDRiQ0QT2mC3CTYlTkGnq8PVRrF-eVVQVuQvC2a9yKskx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:e3UGaDaJhO8GD_lQnoToaYj26JjNilDFxNwDLQ6bNgN-qVgELxslGw>
    <xmx:e3UGaFa0wJzZsYsRDhRcsjONGl8dHJ1Y_vAU3JShAmFWyr_6wsDuQg>
    <xmx:e3UGaPCoQDQXWJ_o80upbL9_LjOk8FMLA9XPixSIf_MqBhWcY-ByXA>
    <xmx:e3UGaLYfLadt2fK-wQhq3YeZKE6J5l3QOXG4bLnDg1-jQ5REUv1FZw>
    <xmx:e3UGaFrRLNGByuGgBUjbtTf5RdPVaRb4p2ucHW6NVTdCBbgVMV8FqkiL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:34 -0400 (EDT)
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
Subject: [RFC v3 03/12] rust: sync: atomic: Add ordering annotation types
Date: Mon, 21 Apr 2025 09:42:12 -0700
Message-ID: <20250421164221.1121805-4-boqun.feng@gmail.com>
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

Preparation for atomic primitives. Instead of a suffix like _acquire, a
method parameter along with the corresponding generic parameter will be
used to specify the ordering of an atomic operations. For example,
atomic load() can be defined as:

	impl<T: ...> Atomic<T> {
	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
	}

and acquire users would do:

	let r = x.load(Acquire);

relaxed users:

	let r = x.load(Relaxed);

doing the following:

	let r = x.load(Release);

will cause a compiler error.

Compared to suffixes, it's easier to tell what ordering variants an
operation has, and it also make it easier to unify the implementation of
all ordering variants in one method via generic. The `IS_RELAXED` and
`ORDER` associate consts are for generic function to pick up the
particular implementation specified by an ordering annotation.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs          |  3 +
 rust/kernel/sync/atomic/ordering.rs | 94 +++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/ordering.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 65e41dba97b7..9fe5d81fc2a9 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -17,3 +17,6 @@
 //! [`LKMM`]: srctree/tools/memory-mode/
 
 pub mod ops;
+pub mod ordering;
+
+pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
new file mode 100644
index 000000000000..6cf01cd276c6
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory orderings.
+//!
+//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
+//!
+//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
+//! - [`Full`] means "fully-ordered", that is:
+//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
+//!   - It provides ordering between the annotated operation and all the following memory accesses.
+//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
+//!     accesses.
+//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
+//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
+//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
+//!   RELATIONS" in [`LKMM`]'s [`explanation`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
+
+/// The annotation type for relaxed memory ordering.
+pub struct Relaxed;
+
+/// The annotation type for acquire memory ordering.
+pub struct Acquire;
+
+/// The annotation type for release memory ordering.
+pub struct Release;
+
+/// The annotation type for fully-order memory ordering.
+pub struct Full;
+
+/// The trait bound for operations that only support relaxed ordering.
+pub trait RelaxedOnly {}
+
+impl RelaxedOnly for Relaxed {}
+
+/// The trait bound for operations that only support acquire or relaxed ordering.
+pub trait AcquireOrRelaxed {
+    /// Describes whether an ordering is relaxed or not.
+    const IS_RELAXED: bool = false;
+}
+
+impl AcquireOrRelaxed for Acquire {}
+
+impl AcquireOrRelaxed for Relaxed {
+    const IS_RELAXED: bool = true;
+}
+
+/// The trait bound for operations that only support release or relaxed ordering.
+pub trait ReleaseOrRelaxed {
+    /// Describes whether an ordering is relaxed or not.
+    const IS_RELAXED: bool = false;
+}
+
+impl ReleaseOrRelaxed for Release {}
+
+impl ReleaseOrRelaxed for Relaxed {
+    const IS_RELAXED: bool = true;
+}
+
+/// Describes the exact memory ordering of an `impl` [`All`].
+pub enum OrderingDesc {
+    /// Relaxed ordering.
+    Relaxed,
+    /// Acquire ordering.
+    Acquire,
+    /// Release ordering.
+    Release,
+    /// Fully-ordered.
+    Full,
+}
+
+/// The trait bound for annotating operations that should support all orderings.
+pub trait All {
+    /// Describes the exact memory ordering.
+    const ORDER: OrderingDesc;
+}
+
+impl All for Relaxed {
+    const ORDER: OrderingDesc = OrderingDesc::Relaxed;
+}
+
+impl All for Acquire {
+    const ORDER: OrderingDesc = OrderingDesc::Acquire;
+}
+
+impl All for Release {
+    const ORDER: OrderingDesc = OrderingDesc::Release;
+}
+
+impl All for Full {
+    const ORDER: OrderingDesc = OrderingDesc::Full;
+}
-- 
2.47.1


