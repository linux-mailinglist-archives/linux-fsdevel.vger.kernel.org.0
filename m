Return-Path: <linux-fsdevel+bounces-33417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F179B8AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CAA1F20FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FCC157E6B;
	Fri,  1 Nov 2024 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClDLzm5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4815539F;
	Fri,  1 Nov 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441046; cv=none; b=Mg9OqNfSbxtJeipviTzzZhbPLLZknsqQB2amIUsiZDS2phNpq0IEFFkxhiAN96kpWdyobZBWZ0IjyAEjI1yNiFgNocJvWguoqWOdaLy8G3Pf4OCSntnKKVmvYLXisV/lATR5V5C3sTXqm22AZKyktlSB5R5WwWsVTv/++y0uxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441046; c=relaxed/simple;
	bh=b6SXwnbsu/RlNkPBThbz53fj6R3sDIHRgIrxZgJqXoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6ihZ3lKig0psINHfxfyFwTFdKAdmm9ZRkv4QuFko0INoeTDASuU6Y1fhOguNo7MHHtW9sAS/98XqrxZggNkFS64dKdtjR6ojw6RwdRvOkYXRCXL7/ZtunRULJNgxRA6HOTWTbDoeJp8Aqt4xOymRWJE9u1645uKAUEmZ3T6SgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClDLzm5m; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460ad0440ddso9935681cf.3;
        Thu, 31 Oct 2024 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441043; x=1731045843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6aL27TUodcAdd+uJ8RiXbRTkzdjD0lB6w2v/luzePnk=;
        b=ClDLzm5mTy6VsZ3rmXQFl5MMJBCpn/oNQuzm57XyvjrYH11pd+7cqfP034u6/dquFM
         0RQXWrI5HJXkNGuF6Fz37v/4T9Pt+lmqC4THf0nFxuZqTOfGOEmSXELwaqzwcCl9kW6C
         gVnURhJ8ZxjABzyCMkQ0u4UnvWHp1hwodvrh/Wd8jJ2jhd7IP0I02wUUG92I96bpSYo8
         3Pg4rVbwQq2oqhqx+x8nellX9rIhHrAyIRLIghxHNxO5Iu0qjECe12lxyCiqmhKNtT+j
         uxqv+M7vtZp45aXCiZ4M7nj7vcxVlGSNMVeJM0bsjPHoIUVwlTTO2RILo1wwYqivxB9s
         IKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441043; x=1731045843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aL27TUodcAdd+uJ8RiXbRTkzdjD0lB6w2v/luzePnk=;
        b=MY5vHGr89ufWMFDhEWaS3ne0Bm52NyLMoBLTZPFcRafYvtwQ0SMtKPUtDZuAmj/Jvg
         M3ztaazJ4fjTq/wk3erAHs0zKF+caaeSzthqYGrGSRktmr/T+LICysaAUnqDXC5XSGwK
         XgyySb8PosgFPNj713yFtjXYMsApnyFCchatSQIwj2hnBXo6+wtGRlSF3Pb03Q8ESTfw
         S+m+Fli1Ws+6lxj0gaQtDYMjreIvqCfuG0PTWvLIy7tC0k31oeBN+ii7ZxLfejsPrhIk
         snCGZ/cJpGAPiolWnEtLG8OQkImXQQgemN7QrMa8xdeRo4yjTjcc3jZqgTGWAPy3omra
         aA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4Kh9uNBOLjHx/HvPe/P0s6zVMa+cuAS3/KNizzwya8C3we1vh4bOBTi2QdFSNpaI+P3yy@vger.kernel.org, AJvYcCVRSXp/20fU+0RIhHB7W2gk+hA9Rd1dtvZgfFAA8uogHebfOUpHF4DRNyMVCobXHDdV5XS8BVy4GmQXvGR2@vger.kernel.org, AJvYcCVcv18t+oY9jAdfx8bO/cnbS3MItgy9Q5fL2QVIY4JiyxzQC3tiv5xSI0n7qvlH13L9ME9AtWAlM0JTwtn6TA==@vger.kernel.org, AJvYcCWc0eKXnDvHliFXA0CL/v3zT8USRQ6PwDm6Pl13tWQ/b0llSUfjxFR/YKXqDhGgz6zwKLyxzy9VYrVD@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsEA2ACGz0+acUKBNCeHGdI526j+yjXZCdwZcxwzkal8ooa6x
	t+4SsNhUpcCe17SuTM46Bj0QinepAI94+Cba7W2Rt7XwpomU/9h389Ql7X5l
X-Google-Smtp-Source: AGHT+IFtVHBa0He2xDXOosemd6sDgqTkWeG7CkK1uL078zUpl1V2KL2W2OmR5COAD+rPl9/4/CysTQ==
X-Received: by 2002:ac8:5fcc:0:b0:461:57f9:6294 with SMTP id d75a77b69052e-46157f9680dmr214420921cf.38.1730441043012;
        Thu, 31 Oct 2024 23:04:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cc16esm15259101cf.51.2024.10.31.23.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:04:02 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 36BE21200043;
	Fri,  1 Nov 2024 02:04:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 02:04:02 -0400
X-ME-Sender: <xms:Um8kZ78rYvgtGQNRIz9FXaznnWxEMTH4ZNoK7rFf0t4SGfyaRBeZsg>
    <xme:Um8kZ3tWJDPoAFZEDjR38L_nnGPIGx0ZONWcJ9i7iL4mZTjbVgScBgLyzeveDj-bk
    GCl_07T8Q1A6RRugQ>
X-ME-Received: <xmr:Um8kZ5Cs78brre0AKFYvtLROzAI8e9BLMy-EAU4fXeFV6SSqvD6ReRNmSVKg3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
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
X-ME-Proxy: <xmx:Um8kZ3dFuUJ_LsZ43tDz_a34qYVrx_8alQQ1-aKyCdVHRdUCWbnRPw>
    <xmx:Um8kZwNCQ1W14NHd5xyHAkMP0uthoHYmNCC9vaIyRNBp5V8kCq7xcA>
    <xmx:Um8kZ5lpnLCjUS9S7xcMG-Y_jMn6ecNBqoFExHiOLbIE6_wPRVtK2g>
    <xmx:Um8kZ6v9ITMPGv2iDAegTY1OREf7shkA9Pg02bs0kYkFBx_PHCCv0g>
    <xmx:Um8kZ6twtXsgjI5mkQE7RNkDKDO1HpSi4RmwBl5t23RkZxBAkq7iBTsk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:04:01 -0400 (EDT)
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
Subject: [RFC v2 07/13] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Thu, 31 Oct 2024 23:02:30 -0700
Message-ID: <20241101060237.1185533-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicIpml` with the same size and alignment.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index b791abc59b61..b2e81e22c105 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,3 +22,83 @@
 
 pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let x = Atomic::new(42u64);
+///
+/// assert_eq!(42, x.load(Relaxed));
+/// ```
+// SAFETY: `u64` and `i64` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+///
+/// let x = Atomic::new(42u64);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for u64 {
+    type Delta = u64;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let x = Atomic::new(42u32);
+///
+/// assert_eq!(42, x.load(Relaxed));
+/// ```
+// SAFETY: `u32` and `i32` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u32 {
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
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+///
+/// let x = Atomic::new(42u32);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for u32 {
+    type Delta = u32;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
-- 
2.45.2


