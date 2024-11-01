Return-Path: <linux-fsdevel+bounces-33422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEF9B8AF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D47F2820D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA21990C0;
	Fri,  1 Nov 2024 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bylxYCx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9B166F16;
	Fri,  1 Nov 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441053; cv=none; b=ULJ7l4IsNvFnywJsRGwSG1fbJBRcem2rgT/TQGtaZ+KawwGc5W+P50fJjbXuxqGXI/01/mk9vZRUFz/j6VXuNQtrPhy6I3JlzTY0Ds2FMunGSwkL/vh+UJjQaWkkKn2wC8dllcxlP/SH0LJ0PT4s6GrM2zPCK9noxYjsKCkY9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441053; c=relaxed/simple;
	bh=7KJrgyvO8isbBIeGWfPNx8sxKs/K9PK96xszrTZ36RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+a0uM4PqSM6cHzRBmv0wkaGBeKGDzFPqPFNFKOYXYRykuVhEPLcrMRUtqDGTEFyUx975zghKZXVlno7OIfFnVRtRsQwEx+wg5sPaFqknXHo8EWoqF9lmaaK7GB5SHGQC3pwJb7D5q/cMkQ2ewbOZLE4cCX9pUE+asI4G3NIXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bylxYCx4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15467f383so117949185a.3;
        Thu, 31 Oct 2024 23:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441050; x=1731045850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qb/auzzRSYdGnLFU8kbv5LWllGUHO0oSi9IMia1ivTQ=;
        b=bylxYCx4Xt8Syj+UAFefis0hcbm1j5vy8qmg/S7ZzYhr2YAlSeDEgbDecZsPm9Rh5v
         H1F/0AIrCiR/+5vNeSBYYz4pkyGBK+sLFW86P4P8/py9HjVy5D/IzpI3zDjUn0Dl1if/
         ZyPrTYr4lH+1ThPPdkMnqDNZcgs9P8p0/hDC6T4NHZ1mlXeXLfF8ob1TkLhLYRIk1je9
         aKQtXfLvA+w7eNKhT6rR4u8JIjT3QdfFly56MsYohQLLTM79v513THWAHmT/5QlFnC5c
         o9vY064qcuAkn/X2mk5foqYxfH8cIQ1Nz08QVp4/qsjvq5QklvQeWmGxlMhQbM92O7+Z
         i8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441050; x=1731045850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qb/auzzRSYdGnLFU8kbv5LWllGUHO0oSi9IMia1ivTQ=;
        b=kp7DEERISCydIhvcLoBFpEd/JK6/7RBQDReHStReg0ZXQhwVwGDokkqqgFOFqt85YL
         oeSKkFKgXg+tFDRNOMPcl3Etei8xqfA2Irj0AKDrQj8g00kPcziDHSamXquhRPYRHhmp
         2sftbOqSUA1UJdRfYF+TM01RTDMPqeSKkBEThZz65tpU/2CNg+qqJzml+HeOCaF5DrhT
         nOcUIYtnmiMVqxy+GI2T1CXokzuj+s8/DDL8N65ConcY74t8g8HdfNitNf8ArntnqgnG
         /2b0E/CFiU86tglcHWNPdpMFA1RFXGBK4GbsekZ8/shpVxXHnE+rMqdU7V8dWOg2FHfq
         fV3w==
X-Forwarded-Encrypted: i=1; AJvYcCUKPG7rRlPiD6TXPxPhtvAf1u1PDXy5Di5h5pWpkqWg8rxfnhCa7NfE6Gc8h/XEK4/T+7lCJe149GQwffYSyA==@vger.kernel.org, AJvYcCUMtJfrY50gm/TMy+DfhpWdj7ou+S9dakxmMYDOpXeJR8fgHbif78rdlTrrBsNccNmtoLE4M+q1CcdV@vger.kernel.org, AJvYcCXgQS6PzFjcawY/fBHPP5wA8BnICHvPF0f8qPRjXGb0WOWicSJAZG8wQHQT+4Aq3H9rc1i5@vger.kernel.org, AJvYcCXzwIYF8mxncXq9Aq4Pam+bsfu8vsynT55zw+J29VV9SXuSCDncK9RqtKaQOtTnACzmUBfadrJsP59ER7R/@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBWTybEBdFKD5x14Q2T0EnK8I/akYvWNT2yeSs576L+w5USHB
	Qrg2fKkMGYL759wd8QGLVhnAEI3prEa0M4+B0MfC9dP76ITsx6MLqrvk6Dok
X-Google-Smtp-Source: AGHT+IECF9ewTXbsjt9dCxiiHfzqG4m7YRQCPcsoUNeXK7Ldgj9dZvu2Opg1L7q15mIwb9Ncoqb1jw==
X-Received: by 2002:a05:6214:419f:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6d351a8f363mr68837316d6.10.1730441050203;
        Thu, 31 Oct 2024 23:04:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a640sm15713376d6.89.2024.10.31.23.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:04:09 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7765D1200043;
	Fri,  1 Nov 2024 02:04:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 01 Nov 2024 02:04:09 -0400
X-ME-Sender: <xms:WW8kZx0yl-DRTkHXgY5jQzLrSNLLDkudwnu3ix9eYqdnkqUvZ2vaFQ>
    <xme:WW8kZ4GAGBgNAFrGfSe_PmlOpNQS083UDL__1doSYVQt8I7x_mlbfkwoSAgmiOm7U
    f7mPUFIaSg6LD7WVA>
X-ME-Received: <xmr:WW8kZx71LpKc2GUqMRy7CHTRuN8FLMJnTGleLLenuwxnBiBXKus9KcGDA5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WW8kZ-29wq7-RXn3oPRa3Y1O9DboG82y8qrZ4Nu_564zR-VGr9Je9w>
    <xmx:WW8kZ0GQTTjyggH4cJg4Kav483-SKdWycoefukMQLMkjdNu8_8xqLA>
    <xmx:WW8kZ_9tc4N_PFWXmN3eG7Mgh6RDJkpm5HMIl7ULoIc2rMMwFm2T9g>
    <xmx:WW8kZxmBqqgJhcI1oZvJD2FHr29b8lEUC-0xrNxQI8LK_ZcZbCb1mg>
    <xmx:WW8kZ4E6Urq48alTAcEzXU4Kswskc70SKXQV7Gr_3kb4bg0jhLSpFv4_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:04:08 -0400 (EDT)
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
	linux-riscv@lists.infradead.org,	Danilo Krummrich <dakr@kernel.org>
Subject: [RFC v2 12/13] rust: add rcu abstraction
Date: Thu, 31 Oct 2024 23:02:35 -0700
Message-ID: <20241101060237.1185533-13-boqun.feng@gmail.com>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a simple abstraction to guard critical code sections with an rcu
read lock.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c  |  1 +
 rust/helpers/rcu.c      | 13 +++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/sync/rcu.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index f4a94833b29d..65951245879f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -18,6 +18,7 @@
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
+#include "rcu.c"
 #include "refcount.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
new file mode 100644
index 000000000000..f1cec6583513
--- /dev/null
+++ b/rust/helpers/rcu.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/rcupdate.h>
+
+void rust_helper_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+
+void rust_helper_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0d0b19441ae8..f5a413e1ce30 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -13,6 +13,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod rcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
new file mode 100644
index 000000000000..5a35495f69a4
--- /dev/null
+++ b/rust/kernel/sync/rcu.rs
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RCU support.
+//!
+//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
+
+use crate::bindings;
+use core::marker::PhantomData;
+
+/// Evidence that the RCU read side lock is held on the current thread/CPU.
+///
+/// The type is explicitly not `Send` because this property is per-thread/CPU.
+///
+/// # Invariants
+///
+/// The RCU read side lock is actually held while instances of this guard exist.
+pub struct Guard {
+    _not_send: PhantomData<*mut ()>,
+}
+
+impl Guard {
+    /// Acquires the RCU read side lock and returns a guard.
+    pub fn new() -> Self {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe { bindings::rcu_read_lock() };
+        // INVARIANT: The RCU read side lock was just acquired above.
+        Self {
+            _not_send: PhantomData,
+        }
+    }
+
+    /// Explicitly releases the RCU read side lock.
+    pub fn unlock(self) {}
+}
+
+impl Default for Guard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for Guard {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, the rcu read side is locked, so it is ok to unlock it.
+        unsafe { bindings::rcu_read_unlock() };
+    }
+}
+
+/// Acquires the RCU read side lock.
+pub fn read_lock() -> Guard {
+    Guard::new()
+}
-- 
2.45.2


