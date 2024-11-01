Return-Path: <linux-fsdevel+bounces-33418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE4B9B8AE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134FC1F20632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B22158A04;
	Fri,  1 Nov 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k95ZqVoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E80156654;
	Fri,  1 Nov 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441048; cv=none; b=Po2ncNIEsxdKvbhH9gNh0u3sp/c8oe6lAV7f6tLCrfRZCD7m1i55vtIxg867NjgeLq15+hbrbbEm/BBYAHCQNGJXD9wP+x9sgpf6DhIPNgxf/J8oMuUIGtkY7t/G5aAhoRyWPYjtpnC3P3B7RiM8qyUB64zw3hTbpr6m68T55cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441048; c=relaxed/simple;
	bh=p9btVVa2+xSWu4bOPpbx4eV63bulX64vxQ6AaKLpk8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gjn4hrvVN73HpVn1c3pwPOG1/Ka/B3FFGBEPmRR2Xe3tI1ZKUWurSCnbYMfRZlCuEw/C9qfd9/lsb7cYDBleos8lsgMxqP/oWHjGXoS43lZYBk1tdk/+W5VYMVSn1634fgEu51LniYm2pCKCjQqF5LEIkeHJlmnUjlQisxgs7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k95ZqVoi; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso9937296d6.1;
        Thu, 31 Oct 2024 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441044; x=1731045844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6tG39HqwvxlfRrBPWElR6isULD+PRgdHmRoN4FVkag=;
        b=k95ZqVoicKzRP5E2V6uvQViTJnl3FjAUmoPn7TfSs8CRc475lARdAyxRY//KznktM/
         yEYDUg4DygW54K1xSrUsfE/odwgNxqYSs1rA07BMwfQS7tkfKtpOlM0O9HKk7/DkEcJx
         zH8GyMx9Xha+ZUcGut6lnuSNQMXDPbYUbq0SUQJMm7vBjvkhDs6PG8pPjPuQ4UIAGa1Q
         Umd7svNwNX0TToIdyj9J3bz/5KpIEjbvRXNigYfH/aAk466/ktqcybPq8jqod0rkRpBG
         bVy9PsEIqZy5xBM24dRY7jr38j33K3m2WVIGQ0/qzqI5F4RvhKhogj9lHnW28VUi52cz
         pdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441044; x=1731045844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6tG39HqwvxlfRrBPWElR6isULD+PRgdHmRoN4FVkag=;
        b=MSsulEAKHKdBRgokWZD1bhWRXvGTeWQG8JE5MIyPurbiwW4pFNRcBeDlxC8kvDQn/2
         4qxRtSCJ8la7X+Tldmc9gmOrPsxK6Ni4w083oNnb/UGwZIFbMKyvp99jAj+Tmb0rf/o4
         SwET7QmmXgCUcSUs+fNMjwO1ZMGPwAoCdwh7/xHRQnGF/fjyOq+99cmvTOyCpPIjblMp
         QfARR+1dOdfFpJka6axkxY/y9VHI7ewDfzlcRIeEx6htsQ9gUoNG7htdukNpiDcrzEGL
         eJyrD2uyRy29X3E8B+beFMbOejxULoCcvDMCF8EVchm4jZAIsFh7aNA5a6UmPIhwHn2+
         Ci+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfJBbjLznwdjSz6rsFF6dJ3Z5DYVoQ/3qgyhQYNcwdTPHGJdmDIP2cARkf0fWZQWSZbGyiFwU7eoPC@vger.kernel.org, AJvYcCW9fwXpIE/s7iZpATfQxQxq6O2KtvOO8djqeLH7WZykuHWUxeopUeW0FtFOfSC99KIGeIW/d8NV1P4fQZGc@vger.kernel.org, AJvYcCWu3P0+MDhNYSvkCgVH4bw+xK3BS40j1OGfDGckZtPKh4EJjpiQyfDahBRT6teQDDMV+B9x@vger.kernel.org, AJvYcCWve4F6exOuWYcXTegdZcw7TdmTLSIFGX3+qilCxHqyFqgowutvBUdzaCj7AZBcK9Jio0GL1VvsC2cHY39DZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsBAI5wPl1dpmyesrEATc5OjWM/P7H1RDplUKsyFI2owBJuSz
	YkWzI42lIwP9VL521v/L46rz2w+MPe3dRaquI5zaKqUtb5Iur93hSzIncg+7
X-Google-Smtp-Source: AGHT+IHxlQ73l+UhRt/AvbKKPa42h8SqSMj0Mq3h3j32da4pj9FbcxaRnUDspUF1ESyOUj61ypPKLQ==
X-Received: by 2002:a05:6214:2f81:b0:6cb:c9bc:1a23 with SMTP id 6a1803df08f44-6d1856ea81dmr253747796d6.24.1730441044400;
        Thu, 31 Oct 2024 23:04:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc49fbsm15821596d6.31.2024.10.31.23.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:04:04 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id A2B0D1200043;
	Fri,  1 Nov 2024 02:04:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 01 Nov 2024 02:04:03 -0400
X-ME-Sender: <xms:U28kZ4ja5LWAoU3yfdto9YffBnntil7uUTgczdBRrUYZKEv2btRd8g>
    <xme:U28kZxBYHbxlZdQi9ryR9nVcf3Dt1GVAl3wOeehcX1LNRUuyoQ09TQMXk_ZjoSHfg
    mEmu5J42uBN4wHzQg>
X-ME-Received: <xmr:U28kZwE3vXuFtU6mK7fc1-Lvj8OilcmMDSlV9ABGW3CfHcTMX1TEKiPgpt-UzQ>
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
X-ME-Proxy: <xmx:U28kZ5S9yoZIs7IW9AC7EnrOMNOqs8HEN3ixerhOZkN5FxVuQwmcLA>
    <xmx:U28kZ1x0WeOFpLKtfjJf3QxURbgBdAQD-QZzqlYqUc4c9UxD8aDGIA>
    <xmx:U28kZ37PV7nEHBhCjP5is95pa1QT1aCTegkWgEoSyzwvIT4fJKVsqg>
    <xmx:U28kZywelM1bn0bGZrshBPINCbhspnqfODCvXGwpbjTGAK-ZyI1TYA>
    <xmx:U28kZ5gtbZyUKsexuxYAueAlEkJOtr4eKxBDt8MK-SSvoYd1I4pADr7w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:04:03 -0400 (EDT)
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
Subject: [RFC v2 08/13] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Thu, 31 Oct 2024 23:02:31 -0700
Message-ID: <20241101060237.1185533-9-boqun.feng@gmail.com>
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

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessarity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index b2e81e22c105..4166ad48604f 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -102,3 +102,74 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
         d as _
     }
 }
+
+// SAFETY: `usize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for usize {
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
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+///
+/// let x = Atomic::new(42usize);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for usize {
+    type Delta = usize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+// SAFETY: `isize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for isize {
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
+/// let x = Atomic::new(42isize);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for isize {
+    type Delta = isize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
-- 
2.45.2


