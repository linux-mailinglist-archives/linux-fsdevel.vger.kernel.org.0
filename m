Return-Path: <linux-fsdevel+bounces-46814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98777A954AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5EB7A24F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABF1E5B89;
	Mon, 21 Apr 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX9tXTRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3A1E0DF5;
	Mon, 21 Apr 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253757; cv=none; b=Jp8F68em2hs68N0YuPrc/FcFFJxWwngoWwvQ2jKS+UdRYhupgw1iul+U1oX6Daxij4LpLRZUxTRY0f+t0/070gF2RhebAUQOMmOec9cmsir1BzMXDu+A7wkI9TKvOjnBC1Rfm92LYG835lsJCBqFdsc0FDLZU3KqRRLJBJdlPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253757; c=relaxed/simple;
	bh=M8n7p4I5bBRKLYp+zmw7whgmO6Opvw0T6CdsEIFeivs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7tN/C5UgNN+jONF3vfb92+rtW1XZn+E7ajgpMXV3w/gVtpVDdJQIiXUA5dJxs3e2BVGGCkOlK6Sl6CTC/YXltX8sZiI9CmkY+DmqXhXi5vcdmxw9xuIsSuazL8Td25bvVacC3Z8d3t/loqQCSOJeTL8Wj6i2kplAzU2HkAccBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX9tXTRX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476b89782c3so49721541cf.1;
        Mon, 21 Apr 2025 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253753; x=1745858553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OVn4vdsyma2YNnYBs3oMc4dBxX75ZCJW+A5HwosHSls=;
        b=aX9tXTRX7+WPK1/WEJ2aj22rs9VGizwecHyMUgEu2amnBpB6RzZ4kk5xMkkLUgWLb2
         BF2rWw5A+FXo4bJoN7sr0uj8eOI1xk9gw0VPyKG52E/bqeMLFSf7KGKPvrRf9EDQu4hn
         H0bgdycmy+rbk5IJzPVXT254UlqUy0AyOpP9tUMVU/1Pi0k4UCyJ997FCwjR3G5kUC31
         eDuT2ntP1uzefGDnsdl3+CLgGvLLoijsLD8frRigkE4ENuviSXlwiZ8afHZ5XCdbCXAu
         ptUsBTwOozd6lM8EnNSYbWvWvLf0jUFHmNS+Ez87kcLWRe2ZxN2FaGr63Sz5xe5xiXeJ
         /5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253753; x=1745858553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVn4vdsyma2YNnYBs3oMc4dBxX75ZCJW+A5HwosHSls=;
        b=d9+8HSoSsZ3p/kwUcDArwFGvIckAIQWNllYLlnMrFhsiXl1tZYHPee1pLy1W9q153W
         Y4NC4bfE1VyK0jD3iCBwtKp1l6Xy4v4yxoOoUxgDJjN+qwOiamdXiyvdjioV/aE/DwBD
         gtzR1Q+WI4Pf8Sc6yOOYJ9gPXE7sIg9baZP45/JxDhPIuPKGQpmQXPbGlkzVpYuuJHin
         95943fdqjC7IAiBD1WxfyBAVbyBG4p/FhXsflVSZIKXLkNlHRr8sLO+B4T+hUrOopKAE
         oBwa8aX29VJqoIj3rpaenim6HS/CEbX9I33U/S/8nfQ3y9cMG2fGvael6SXZDRjFXi/0
         USpA==
X-Forwarded-Encrypted: i=1; AJvYcCUP8r6dDVg5Flc1jFOkR7/e8Ow+AUACeRn33RF8B/iqJ2wM8wVk687vEpQbTBG8AgevBiRTcI18h0I5eBMA@vger.kernel.org, AJvYcCUWmGm444XFbrHvS+3mfeVz11fLYrMUwl0uBcEI8aAUn2CrX67W9P0wFLRK8M34RgXfT6ChDULd2qlV@vger.kernel.org, AJvYcCV1GWpY+IWvvPiv2sWUWQj+B0Ssk5TTCcyV+XWTcFonQkAyuuKWdPcEMqVrg5AB9am7/ujI+B05WzWkM0zkIg==@vger.kernel.org, AJvYcCWdND9YHDpBa41QoH5m+NjDxRnO55TdIKb7U7yCiBIInEIsgwq4YEss4T2PsIQsnHJfs/rK@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTy3YxUYfl4wVoQ9kPeFOMLkFKLW+q8t7bFjbBgux47rL+W6F
	Lr/x5IeHkC1Lxk9GqyjBJvhbuJl39SA4UdEt5dAagyDAzQISyqt2TAlmM5gO
X-Gm-Gg: ASbGnct5AEasE70uKmjOzNrrqOseRtmsJglgrhjU+HOUXEFqQWJDIZWYIa/ziRKnU1G
	UHK0syeA7EOeKfWrzKfy0TGPNgi8pY9er/3yUZAmNe3uyQn5vX3QqN1co8U3FEPyHV4RZvVpZj9
	WCvknkchQgFiHFtAn9eb3/kXEBJ84YH+jnechDDGsjUq7KKGMwFX01goNkf/1A+E2x9m0YeNMW5
	76QU02zs8MKANQgvnGKkVSSV6zkp7Jm0sDJcIN1ggpyJr+sEw+QK/aJqCJKuy9SzCUqjq0L9G4+
	iliwCgWkHbvk/e1W1NtM3QvohSMl2W/syKhnqz7rwI3K9UYuMRPwV0xp6+2q/yAbNNx5dqfvAVC
	9Z5MKnfn6uPJKrkcMLmcFgFKAQBT5Lkg=
X-Google-Smtp-Source: AGHT+IGClIxJlqq7/tMwyARGja8bJVuau4lrQesmkLgUtXp7I2IDN5QiJogeuutarMPnoMa+stbg5w==
X-Received: by 2002:a05:622a:1a12:b0:475:16db:b911 with SMTP id d75a77b69052e-47aec4d072cmr206459291cf.52.1745253753160;
        Mon, 21 Apr 2025 09:42:33 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c786sm45287171cf.44.2025.04.21.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:32 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C87A1200043;
	Mon, 21 Apr 2025 12:42:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:32 -0400
X-ME-Sender: <xms:eHUGaB2bHyYbtEVIgk4Yn_WBzGozHOr6KiApvkg8O_QCXhUGFXpv9Q>
    <xme:eHUGaIE1gw2qjXu3dnwWeEu1OTlDzAmfmN8-i3HRiFPWqJjm--vY6cCb7_vM7Ev5W
    NPtR6LP-nJsIE2fRw>
X-ME-Received: <xmr:eHUGaB4GPMvt_KGOJE7oRTfaL74HXRvqN_nq3-fHfXfAxCZWsIHJfhAKPVnH>
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
X-ME-Proxy: <xmx:eHUGaO36mGLNk2x_jYRVUH4kcpqK3Xz2CbOMJbqET7plvVOKZzAp9g>
    <xmx:eHUGaEGJU4FnDaeOEwlbZGgFCgEyxYHTjE4QNhHYChCSbtQgi8nt4A>
    <xmx:eHUGaP9ytISmxTy91Wa_izm5s5UnRLIVxlq0tnZFwFMdr81nSnoVLg>
    <xmx:eHUGaBmi1zeRmQidT3yBPtCjHooUBxh_0UDjXdt9wRcO0ZUTud_5uQ>
    <xmx:eHUGaIFHL6hjBauxAij_yAU9bt3Sj0dFjm5SNXHavgaeAh3S_Cgcx5Zp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:31 -0400 (EDT)
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
Subject: [RFC v3 01/12] rust: Introduce atomic API helpers
Date: Mon, 21 Apr 2025 09:42:10 -0700
Message-ID: <20250421164221.1121805-2-boqun.feng@gmail.com>
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

In order to support LKMM atomics in Rust, add rust_helper_* for atomic
APIs. These helpers ensure the implementation of LKMM atomics in Rust is
the same as in C. This could save the maintenance burden of having two
similar atomic implementations in asm.

Originally-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
 rust/helpers/helpers.c                    |    1 +
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
 4 files changed, 1105 insertions(+)
 create mode 100644 rust/helpers/atomic.c
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
new file mode 100644
index 000000000000..00bf10887928
--- /dev/null
+++ b/rust/helpers/atomic.c
@@ -0,0 +1,1038 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after LTO helper support is added.
+#define __rust_helper
+
+__rust_helper int
+rust_helper_atomic_read(const atomic_t *v)
+{
+	return atomic_read(v);
+}
+
+__rust_helper int
+rust_helper_atomic_read_acquire(const atomic_t *v)
+{
+	return atomic_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic_set(atomic_t *v, int i)
+{
+	atomic_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_set_release(atomic_t *v, int i)
+{
+	atomic_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_add(int i, atomic_t *v)
+{
+	atomic_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return(int i, atomic_t *v)
+{
+	return atomic_add_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	return atomic_add_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_release(int i, atomic_t *v)
+{
+	return atomic_add_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add(int i, atomic_t *v)
+{
+	return atomic_fetch_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_add_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	return atomic_fetch_add_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_sub(int i, atomic_t *v)
+{
+	atomic_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_sub_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	return atomic_sub_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_release(int i, atomic_t *v)
+{
+	return atomic_sub_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_sub_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub(int i, atomic_t *v)
+{
+	return atomic_fetch_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_inc(atomic_t *v)
+{
+	atomic_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return(atomic_t *v)
+{
+	return atomic_inc_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_acquire(atomic_t *v)
+{
+	return atomic_inc_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_release(atomic_t *v)
+{
+	return atomic_inc_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return atomic_inc_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc(atomic_t *v)
+{
+	return atomic_fetch_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return atomic_fetch_inc_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_release(atomic_t *v)
+{
+	return atomic_fetch_inc_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return atomic_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_dec(atomic_t *v)
+{
+	atomic_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return(atomic_t *v)
+{
+	return atomic_dec_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_acquire(atomic_t *v)
+{
+	return atomic_dec_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_release(atomic_t *v)
+{
+	return atomic_dec_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return atomic_dec_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec(atomic_t *v)
+{
+	return atomic_fetch_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return atomic_fetch_dec_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_release(atomic_t *v)
+{
+	return atomic_fetch_dec_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return atomic_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_and(int i, atomic_t *v)
+{
+	atomic_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and(int i, atomic_t *v)
+{
+	return atomic_fetch_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_and_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	return atomic_fetch_and_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_andnot(int i, atomic_t *v)
+{
+	atomic_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_or(int i, atomic_t *v)
+{
+	atomic_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or(int i, atomic_t *v)
+{
+	return atomic_fetch_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_or_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	return atomic_fetch_or_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_xor(int i, atomic_t *v)
+{
+	atomic_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor(int i, atomic_t *v)
+{
+	return atomic_fetch_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg(atomic_t *v, int new)
+{
+	return atomic_xchg(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_acquire(atomic_t *v, int new)
+{
+	return atomic_xchg_acquire(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_release(atomic_t *v, int new)
+{
+	return atomic_xchg_release(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_relaxed(atomic_t *v, int new)
+{
+	return atomic_xchg_relaxed(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_release(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return atomic_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_and_test(atomic_t *v)
+{
+	return atomic_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_and_test(atomic_t *v)
+{
+	return atomic_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative(int i, atomic_t *v)
+{
+	return atomic_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_acquire(int i, atomic_t *v)
+{
+	return atomic_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_release(int i, atomic_t *v)
+{
+	return atomic_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_negative_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_not_zero(atomic_t *v)
+{
+	return atomic_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_unless_negative(atomic_t *v)
+{
+	return atomic_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_unless_positive(atomic_t *v)
+{
+	return atomic_dec_unless_positive(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_if_positive(atomic_t *v)
+{
+	return atomic_dec_if_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read(const atomic64_t *v)
+{
+	return atomic64_read(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read_acquire(const atomic64_t *v)
+{
+	return atomic64_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_set(atomic64_t *v, s64 i)
+{
+	atomic64_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	atomic64_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_add(s64 i, atomic64_t *v)
+{
+	atomic64_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_sub(s64 i, atomic64_t *v)
+{
+	atomic64_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_inc(atomic64_t *v)
+{
+	atomic64_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return(atomic64_t *v)
+{
+	return atomic64_inc_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return atomic64_inc_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_release(atomic64_t *v)
+{
+	return atomic64_inc_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return atomic64_inc_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc(atomic64_t *v)
+{
+	return atomic64_fetch_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_inc_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return atomic64_fetch_inc_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_dec(atomic64_t *v)
+{
+	atomic64_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return(atomic64_t *v)
+{
+	return atomic64_dec_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return atomic64_dec_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_release(atomic64_t *v)
+{
+	return atomic64_dec_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return atomic64_dec_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec(atomic64_t *v)
+{
+	return atomic64_fetch_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_dec_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return atomic64_fetch_dec_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_and(s64 i, atomic64_t *v)
+{
+	atomic64_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	atomic64_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_or(s64 i, atomic64_t *v)
+{
+	atomic64_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_xor(s64 i, atomic64_t *v)
+{
+	atomic64_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_acquire(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_acquire(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_release(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_release(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_relaxed(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_release(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_and_test(atomic64_t *v)
+{
+	return atomic64_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_and_test(atomic64_t *v)
+{
+	return atomic64_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return atomic64_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	return atomic64_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	return atomic64_dec_unless_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_if_positive(atomic64_t *v)
+{
+	return atomic64_dec_if_positive(v);
+}
+
+#endif /* _RUST_ATOMIC_API_H */
+// b032d261814b3e119b72dbf7d21447f6731325ee
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1e7c84df7252..b20ee7cef74d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "atomic.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 5b98a8307693..02508d0d6fe4 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,6 +11,7 @@ cat <<EOF |
 gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
 gen-atomic-long.sh              linux/atomic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
+gen-rust-atomic-helpers.sh      ../rust/helpers/atomic.c
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
diff --git a/scripts/atomic/gen-rust-atomic-helpers.sh b/scripts/atomic/gen-rust-atomic-helpers.sh
new file mode 100755
index 000000000000..72f2e5bde0c6
--- /dev/null
+++ b/scripts/atomic/gen-rust-atomic-helpers.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+cat <<EOF
+__rust_helper ${ret}
+rust_helper_${atomicname}(${params})
+{
+	${retstmt}${atomicname}(${args});
+}
+
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after LTO helper support is added.
+#define __rust_helper
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+cat <<EOF
+#endif /* _RUST_ATOMIC_API_H */
+EOF
-- 
2.47.1


