Return-Path: <linux-fsdevel+bounces-46815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1BA954B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A477A35D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3901E8338;
	Mon, 21 Apr 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb27M4nZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0301E521E;
	Mon, 21 Apr 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253758; cv=none; b=XEeJa/FopnmW4in42Kmz+hpdTIWw76JDVv1Zos+lNFP8BKGY7Fy1SQH+5WzdZ1xgzbGi1E9AwMYdZqcuPnDSbBrzukmQ8+fKGz5vcvJWGboDEGaf6uv4Stf+qouTWbDxJNVDj2ortbFuQgEPByNvS7RutTkpw0NNTDvb0YHV7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253758; c=relaxed/simple;
	bh=8O7IHWDO13FcsrMRoZ/lfLpC575TCWxjQko+Kjc3utg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5lTCRF4QP6AJ+mI4c9m2H6l+TtLr3Dd+jbV34XvNA5w3ZgIIfBD4lKhBQFTyKDOe1V4MPe9TwRWIvVvbLktsRkZW4EFJ2EAWGVacNCwW4UssP026L7gvibDPEF/bzg65xWOndQPDPBdtNO0/PJXnchH2E03mDvAM4XvFV+jcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb27M4nZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54a9d3fcaso402714185a.2;
        Mon, 21 Apr 2025 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253755; x=1745858555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6xgrvqt9fif1wPregC0VT8DLHF+c6qrQbiCaoSqoas=;
        b=jb27M4nZPuKI+TyFKeb37OpsIbnJUt+EaYohPqNIdvl6GVVizd0oByrm8zimg788vd
         n/mTZgbq4/yorKG9MpPehy1pP2Aa5XIGehJyN4kI/akCz7o4dmYmbMhgIGCHyhTONnqo
         WOViM3oHxbcmR73BWKuI3SMpp4FGPkABVG/lI5QXGIJZw7YlMWKhg0rLCS40qoeZ4KQd
         wDRGmZ/t0fRLmTu43rJ3aRRB5NU0CHRMCVyXF05RGt5Vv4UTGSIKnPlPNnFln/RWU6P+
         DLIkuCXpbBT6BJvBKXgyQyexGeCshN8DKRhdZS6SIpKXSx7myJWLgCGOqVk4TJunwbp2
         uMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253755; x=1745858555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6xgrvqt9fif1wPregC0VT8DLHF+c6qrQbiCaoSqoas=;
        b=tqqb+4utpi1HiLrXF14JPfjmK9aZc+FzMT2Ni5zaKVkPw4OYpNhycMGQBQMvmz+6lC
         SEQ5tdtm2iTrTxP8xYIFvUODM0XmUgZn0B8yjsc8woO3P+4smbUtPpStzD/eFeS81uxN
         eDvulLszOElyPEZ1FwWUXEaMR8OU1a1Brun34OGzsvo366FNDJ0wOUasWdcmmXXGS4jj
         Qmnb/mhV37xXJx2gHCab15ycj6ppEWg2YYQfgCDlEGTjprr29m2I10Z+vKFii65mYsN+
         +ZdpwWX/rXhSZ7aTsjqOnlaWnddqqoUkIz9TIq7i55N2XxoB7xybFvCUurg+gStGSO90
         50uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG8A/dBhSQcbyojmAQSDGprhPoZPd2dTGiBPZTuwyPXTc4KkgJEzkzMLggv5VwUlCj9TtrkksIO+ISvcxg@vger.kernel.org, AJvYcCVhol0CC068SZfrP99K21MfNi6TW39jFc71qW9SKO9y1uCzPLnemLEQse9EkZTNQTWgKBkaAxrzZxff@vger.kernel.org, AJvYcCWY/Jh+u/OEd8TlzoK3VY2wmD3C+wlSJf50IebOA2pN71z/EPto1XIchGrATU9pX4nRlRfY@vger.kernel.org, AJvYcCWs0kLz83JHrhEtUO5vS02RU8dNzNtuS/rhrOgeX3zDc5ytXf9iNsi1oxm1lQYmgdaUBZwtfkq+tNtDYzk2EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+kENRb60BG3e8ECCkjlvvXNKhSc1ujikpWpbwGgB9Ghzl1c4
	CwI0t84btGs/QDs9bk2gjMpCWhWVvSWNYOG15EpzIvGPaKQakH66fhqlQkSR
X-Gm-Gg: ASbGncvqgissD7ioGw8zfkkWk65IgoTrbiTRT9dsT75jbXCmh14aiP/U9SuCQIWGBVv
	Ch49sA008LQC8vrsUSkJyLZHs3lEsIlZQxmsfz7+cKCywcLNEAxLOenLKfRBAcFKiwrDLY2/I91
	R7nX011M3z9nUKgtfA4CmHazmUH2tbaCN08xLUdRTVrvrePVuljUdsMMTqOpaCfTqTF/ul82n2P
	luqDnOHw9jXmTVcC7JzQ2zXWLUf/JQYKmlS7ukeFCJg6IinUGqLOjGCh7hJYeHwB0urkLNBwibi
	Ns9ARCQVhV0c0P0IhsCezoKB+vvliVFvxLTukjmcYB3rcNE3BSgL3vJ7WdJ0e7qLXLpKRIiJcDD
	kA5T4nuSNqvEH1DwS4zOOCDk/ZEqk0tQ=
X-Google-Smtp-Source: AGHT+IEaOwBkmTAyzKb6U8dcDydKgKjlT1V9016wdKtOBatJssEqFlook182EuimVJetem8Bfa4uow==
X-Received: by 2002:a05:620a:bce:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c927f6f52dmr1828277485a.2.1745253754716;
        Mon, 21 Apr 2025 09:42:34 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c22434sm45487476d6.116.2025.04.21.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:34 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06A0B1200043;
	Mon, 21 Apr 2025 12:42:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:34 -0400
X-ME-Sender: <xms:eXUGaGDn_ZRsq4PxSeFytceORY0gRKRqT5yp2gh8wyJNRzu1qAlLMQ>
    <xme:eXUGaAjgcWKoyJcku0U4lPS-aNFO1PzaiGW7XLNSFkcAx2vTLgbGZ44wt0xC4OqDm
    Jb0ewfAF1n0pwMEfw>
X-ME-Received: <xmr:eXUGaJnrg6gaCMkOdV9aj7iWkhAo8ZWhzSSOEpPZzFycYuJn_Il9y8HS7oeX>
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
X-ME-Proxy: <xmx:eXUGaEwyxmk3zJMwQTWWDEa_t1xW1cDygwv4iiaNPEqKbi1StGPuVQ>
    <xmx:eXUGaLR255yAQM6McULee6-hNobeWfcQwrTvYWbk_Qq530ZHBgjH_Q>
    <xmx:eXUGaPbeCcpg63QG4D-p7Pwikz8WmB5NVtzp6JudOK-6PplQ7y4RXg>
    <xmx:eXUGaESE6jUK_0BfMKNS-iP6z7j731_TPKuaq3w7B_N_RFkbRoT4RQ>
    <xmx:enUGaNA1EJdatRSSezkUF6bok1nPg9bo1IVBMwRPnJBabzzKybwz4Ife>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:33 -0400 (EDT)
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
Subject: [RFC v3 02/12] rust: sync: Add basic atomic operation mapping framework
Date: Mon, 21 Apr 2025 09:42:11 -0700
Message-ID: <20250421164221.1121805-3-boqun.feng@gmail.com>
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

Preparation for generic atomic implementation. To unify the
implementation of a generic method over `i32` and `i64`, the C side
atomic methods need to be grouped so that in a generic method, they can
be referred as <type>::<method>, otherwise their parameters and return
value are different between `i32` and `i64`, which would require using
`transmute()` to unify the type into a `T`.

Introduce `AtomicImpl` to represent a basic type in Rust that has the
direct mapping to an atomic implementation from C. This trait is sealed,
and currently only `i32` and `i64` impl this.

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
index fa1e04e87d1d..134017f36aec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3813,7 +3813,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -3822,6 +3822,8 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/kernel/sync/atomic.rs
+F:	rust/kernel/sync/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 36a719015583..b620027e0641 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -10,6 +10,7 @@
 use pin_init;
 
 mod arc;
+pub mod atomic;
 mod condvar;
 pub mod lock;
 mod locked_by;
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
new file mode 100644
index 000000000000..65e41dba97b7
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
+//! - A normal write from C side is treated as an atomic write if
+//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
+//! - Mixed-size atomic accesses don't cause data races.
+//!
+//! [`LKMM`]: srctree/tools/memory-mode/
+
+pub mod ops;
diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops.rs
new file mode 100644
index 000000000000..1c0a87d31bf0
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
+/// A marker trait for types that implement atomic operations with C side primitives.
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
2.47.1


