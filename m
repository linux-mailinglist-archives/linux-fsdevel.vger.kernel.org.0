Return-Path: <linux-fsdevel+bounces-33413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0809B8AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092BF1C2139E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6B153BED;
	Fri,  1 Nov 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ZnV5Bm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E414C5BD;
	Fri,  1 Nov 2024 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441040; cv=none; b=gv3hS7uGXZbzIoU/sVCli1HO9/DfsEke5aWd+O4WcHUj1lU4WLQ9IgETqmHGBEWvlSTEDFDUx1tvr0MU8/foz/CFRfURHxozqkpQtZBAzRoYKpAijh+AwE0S6m8pKcdvzQP69vCSPKj7ji2mApS7DEy95oMhWDe68MT/yO2mwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441040; c=relaxed/simple;
	bh=kYBrr4vz56GoKSXeexgf9jNKkLgOPVYmear0fnBchqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utt+OGKZA+EgYzrXZGkPW/aVUrL7kz/MtiBcLwu6CxjRWtV3LAQwRDpP4wA3o7SB/Fk4yDsfb9EcT/gRXEZGp14/eKgXXufKQYHRo3sZKz+CqU7KowWVFX4MAVzaYh7+sizrzmkVm+ZWEIVC4KTwNWF+bxrz1c+I0gnhhnEsYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0ZnV5Bm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b13fe8f4d0so112492285a.0;
        Thu, 31 Oct 2024 23:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441037; x=1731045837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O88Ws5ttINxBzT//7+/cLza6DlDBrpbiV/WWX/jyzJU=;
        b=d0ZnV5BmFGw2XdSJ+uA9IbGUbosK1rs+E/lm+vmfjNRmO6jUXHnJqR7wNUIZJhqlY9
         3fxWIHxWkiQOh3Wx8eGF5KrkVvl6xbEex5C9y70XdM61R7F3syAb2HkCFjRT7mOVzazN
         n6NAJNsX84CXRMZCZLZ4Z3neLwSLH6NWRReXd2QNhKq2f6rko/ORW65exZXZTLGgmExQ
         LrZWxGsF2TEyvtB0fDKTTRZZtjk4X/O1QeG+Zlb/67w4/+LidLGYSa+C6zOJ3NI9jLg0
         DMK11i62+tqw+Vp9IQ/5wRZ5YgPRW1NoE/E8V/Xa324m07qicUxDK9pjIuZmFkK89npF
         Z20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441037; x=1731045837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O88Ws5ttINxBzT//7+/cLza6DlDBrpbiV/WWX/jyzJU=;
        b=DkCcZCLTER9BH8v79J55L56M0PDAlWlHB4HN7rkO7eO7S3seP+6L4ioNqcIP/Bhg4b
         B6vPbLsOWN6l3Jbv6o/QTh85KCuRYeu9iLcsVEc/5fc7PgrJN8YMe8NM2TW/Rl3j2Lx5
         GR3gHRnBIyW9oHENH+I0Cm8QV5DEuDh0qbr0tbbUKB25V/W0qHgLeaaY3b2NMLc8iEJf
         16b2KOsiXr0y10XrMZhpxoJGLj5Yeqh9gK7OQmOg9dq14xveTBNcxKQ018xPGfSjL+X3
         zDxlDtWH8U6xX1seEqukZz7cv1dtCHvUBdE/gzjoiJlI6dlPdnXk3QNNWmi+AbUPVRw6
         EcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAPeVhFtull3SA9F+eK9JWjZgEsTl9VoxunAysANL/cro5C+flEvidgbpKm3aCTbMA9ExEJp+RSAYwn9A@vger.kernel.org, AJvYcCVKp/53xoEWy/dXeSWT1NCIojiz0/+wbHMB/bAOdNXUQ5kJy6aLeGfPObDhM95qLlX82RBI76MkB5IWJ1A2SA==@vger.kernel.org, AJvYcCVYljzLuy6CEr5HHaB4LkcNrcUxBMBwqM3x5DOpKxUKZwq5wcLyNKjeLEt7H6a5QUiVIF6A@vger.kernel.org, AJvYcCXklY5EMZSszvaqydbSZnxu3OwePf83Fa+aq0HpwgkkL57n2p7xbSt+GWF8g9enWV/w8Afg3yiH2FFK@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrbCofmPqAyHabH/iPpiKHeQJQMW7F1n8ztJb5T+ryN6xOAuz
	/n5cCQWU4bVzf5ZR+IuJaL5UuiKSIzQlP24w8dsDU9jMm9SE6Mx7FR2WFznr
X-Google-Smtp-Source: AGHT+IGAgrre0PPpyD6rFQZzu/0lRRQgc08ryAvjceyByTWydXwK6lmc5RYWx3Hkf3yaNoN8SfXJSA==
X-Received: by 2002:a05:620a:1a89:b0:7b1:55df:4a83 with SMTP id af79cd13be357-7b2f24c51f4mr703061385a.2.1730441037014;
        Thu, 31 Oct 2024 23:03:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a6fef2sm141324085a.79.2024.10.31.23.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:03:56 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 455E01200043;
	Fri,  1 Nov 2024 02:03:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 01 Nov 2024 02:03:56 -0400
X-ME-Sender: <xms:TG8kZ7DV99VfAXnZpe0O2TnrnnFYrn82NOCEsSY-JUywLOKb-U0ViA>
    <xme:TG8kZxg4uKoiQ_yxD1hPOmQlesBNGi51aGtenaOnMLZIo_foqc-69JbxHrVB2r1Zy
    Mb0vwb1YDHhCGdRSA>
X-ME-Received: <xmr:TG8kZ2nKVbCqkBMT4z8FqgayOwQk8AS9oN4HLNFM5AyU5CmvhMbq7awdaCkDtg>
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
X-ME-Proxy: <xmx:TG8kZ9zwEBTEN2HUsxNgP3jSW3ziL1ON6HHZZ-UjysBSElsWKmy4Xw>
    <xmx:TG8kZwT6r9LcD8B4gdrV6dGfff6KWV-_j1IIsgIx10XzlvwG-sISFA>
    <xmx:TG8kZwaoI0QBHpKyfTkDWSNPjoMvRgXkfFf-_mcqFwTgA2PXUwLkbw>
    <xmx:TG8kZxSASZg5cH1HOJ-5ITjl6xxjRvn5L1KZw-QeoqVqAgIDZMUtUw>
    <xmx:TG8kZ2BNflOUXyAwQ6IBN6U345WcUllIZiOGWOSQtZ3ZwHR2l8MZOfLa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:03:55 -0400 (EDT)
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
Subject: [RFC v2 03/13] rust: sync: atomic: Add ordering annotation types
Date: Thu, 31 Oct 2024 23:02:26 -0700
Message-ID: <20241101060237.1185533-4-boqun.feng@gmail.com>
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
index 21b87563667e..be2e8583595f 100644
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
2.45.2


