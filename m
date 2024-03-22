Return-Path: <linux-fsdevel+bounces-15137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7118875D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B068B214D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06D83CA3;
	Fri, 22 Mar 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfeeYC1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621082D87;
	Fri, 22 Mar 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150754; cv=none; b=utdqi50FSCY7+zWwLQjpshNnJQgnS/t8DqYz0zSuAHP+Lrd8QYbEG4QElSMtWIa58/go6IqOVD08nrrRS9+oDn2W66y38IBkFmFlYs8Ef7GMkAbIAtCtrXKZOapePeNR8jg1zTHacSEw4V6IUdQGJVpLuNSz0MjMHZ7S38jML6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150754; c=relaxed/simple;
	bh=/NBZoIhK1CtetohxAcHUpmJsAGut/+ZBo1KxCgXiFn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRH2mBmkL/SD6/q9w4zT4zTatNm7gc8SVrxuWv2k9uCGBo45QgZVtG4w8cBTyNXjuYLjlQbM2Az+uUd40tYMu1hXJOSFMpwNtxiAD8thoioJBN/4NwB+Kw1q1vPBTBzvve3xRogUEZquF5rj4VJKChpdLHST2C3WfaFZZMxDSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfeeYC1l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789e2bf854dso165694885a.3;
        Fri, 22 Mar 2024 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711150751; x=1711755551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/F96a8YELf+Ur72xFbmW7ZJSVd3YYBPROndGsfciYiA=;
        b=CfeeYC1ldfisFBhiiBFKBGYcJQ0/SaYb52QkB5VrW3FFBNoe5ZQKWpb+cgVuN9SMpq
         cbqBCAjNBoI3FwtE6l6YPqS5kn8J8ZoZvIFw5/GyH9Y1H11FmYRrFn1+6buzBOk4/pQO
         Cn87gJU4kQo3hszZ50B7kkZLp808EJNTXXCCzSbc28WAW7Oz+vq6YodsbAHOifrKftR/
         7OteAVDnIvwrK2iQqflVbZD8y91HU07d0zXX6VkEgTQ9lOl3KVJ87bCt7+kqkIRpu7zg
         +3bkdFf2ioFf05ycKsn18QLeV4FJJxVEsm/gSFa3JTKeHZxSMcqH+pAVb9kEd7468y/K
         M41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150751; x=1711755551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/F96a8YELf+Ur72xFbmW7ZJSVd3YYBPROndGsfciYiA=;
        b=xQIXwRH73q9uOKtNjh5MU5TzOwaqQiMmeez4E81KeQoVger+sZqxPhiv0ONKC5IiIV
         wEPzntEalC0Q5vcs6+v5UgUVKPZgEt667h1Kvo8XO2aJRCQMtdSK1eF1WC233GGVOVCI
         XSHVHA6w1RCVsXE7sfmPX+UvzMf2sccP10aCOs58jxuZBcE0wUiYnRikRsDfV1fGx1nq
         wf0m4lGXCbI9MQ/sMgDtAMpYZFoiUo0ZsPBEyby+A90j9ox5ZR3eLeZvJgL5LMo2XO2M
         Bijcbm2a01rcErPgRVPjSwDzd/0DEOOZLLF+lW+GJHn/mdlN/e321nqZfFzavSrFEbCy
         vs/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXnS+JIkTfNrC1askxqs+HFDSs2CKGjQlwhIH51ZGce+/H2syh248ZQFb/MAX+ZSfqnT92RrV955bMuREgIeEVOtDIcHUnOZOPszezCDeYozYYzTZ/23UZEVU+BB48AqaexZzLweJZLKpLFbTQjKKLmDC8KOwbDEOKlpSnVqN5tB9xvF1vvIE=
X-Gm-Message-State: AOJu0YwIKj9aRGPO0bHrUjb3dU2TlOcLNYDSOCoxL4VL59knndzBqO5k
	2eOPyPucOUx3FadPEHKlJwYY0c9jl1OaIn9BtZpwJWAABNw4UwHl
X-Google-Smtp-Source: AGHT+IFnhi7P+k/MkZCWrllad1of00qh69/aWCRn2Ch4hXaX74mXDXtJDyquVhXLLDKOeEFx3KqBoA==
X-Received: by 2002:a05:620a:40d3:b0:78a:3fb1:bade with SMTP id g19-20020a05620a40d300b0078a3fb1bademr1295433qko.1.1711150751298;
        Fri, 22 Mar 2024 16:39:11 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id cz52-20020a05620a36f400b0078a43996ab7sm267608qkb.1.2024.03.22.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:39:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id E694E27C005B;
	Fri, 22 Mar 2024 19:39:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 19:39:09 -0400
X-ME-Sender: <xms:nRb-ZYRx2_-58_-z6-x6S4sKXkjHp-GCdlJ3teS6u0_eGxEhEFihvA>
    <xme:nRb-ZVwJEn5X_3CSF2VBVtDTWyJWMQOj41t5nU4Y3tVws8i5M3p0M0znwaIFaCWeJ
    RuL49VwOqImuy1r3Q>
X-ME-Received: <xmr:nRb-ZV38RkJQ6TRlO3PiWGx7flW84bXCLPP2yLPAhZeGxyNf_GQM_kKb9P0jLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nRb-ZcBtlI8Nx1uTVZ20QbfmnwHmh_PUZHvw3mBA8IwuxKJSFpfnIQ>
    <xmx:nRb-ZRj_EGYVPZNkd1RT736QMkUg-qVTRaNTocfxpK8xNaNZvrYkVg>
    <xmx:nRb-ZYrJcjVRZwzY0KBDqLp6P-pKhcf5ywqbm4nI0O16gmgmwapI6Q>
    <xmx:nRb-ZUhdx8xp4T0whLRk9kcTd4nFRTE3UQe3vJyjzA_kfVUbwdWnRA>
    <xmx:nRb-ZSBpBm8jvDtFtL4qCfbPT8guZsv0eGkZwMfREFkeARBMIPrlq2SrgRg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 19:39:08 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
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
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org
Subject: [WIP 2/3] rust: atomic: Add ARM64 fetch_add_relaxed()
Date: Fri, 22 Mar 2024 16:38:37 -0700
Message-ID: <20240322233838.868874-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322233838.868874-1-boqun.feng@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/arch.rs       |  6 ++++++
 rust/kernel/sync/atomic/arch/arm64.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/arch/arm64.rs

diff --git a/rust/kernel/sync/atomic/arch.rs b/rust/kernel/sync/atomic/arch.rs
index 3eb5a103a69a..fc280f229237 100644
--- a/rust/kernel/sync/atomic/arch.rs
+++ b/rust/kernel/sync/atomic/arch.rs
@@ -5,5 +5,11 @@
 #[cfg(CONFIG_X86)]
 pub(crate) use x86::*;
 
+#[cfg(CONFIG_ARM64)]
+pub(crate) use arm64::*;
+
 #[cfg(CONFIG_X86)]
 pub(crate) mod x86;
+
+#[cfg(CONFIG_ARM64)]
+pub(crate) mod arm64;
diff --git a/rust/kernel/sync/atomic/arch/arm64.rs b/rust/kernel/sync/atomic/arch/arm64.rs
new file mode 100644
index 000000000000..438f37cf7df6
--- /dev/null
+++ b/rust/kernel/sync/atomic/arch/arm64.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! ARM64 implementation for atomic and barrier primitives.
+
+use core::arch::asm;
+use core::cell::UnsafeCell;
+
+pub(crate) fn i32_fetch_add_relaxed(v: &UnsafeCell<i32>, i: i32) -> i32 {
+    let mut result;
+    unsafe {
+        asm!(
+            "prfm    pstl1strm, [{v}]",
+            "1: ldxr {result:w}, [{v}]",
+            "add {val:w}, {result:w}, {i:w}",
+            "stxr {tmp:w}, {val:w}, [{v}]",
+            "cbnz {tmp:w}, 1b",
+            result = out(reg) result,
+            tmp = out(reg) _,
+            val = out(reg) _,
+            v = in(reg) v.get(),
+            i = in(reg) i,
+        )
+    }
+
+    result
+}
-- 
2.44.0


