Return-Path: <linux-fsdevel+bounces-21573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC2905E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 00:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22C31F23E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7412C47D;
	Wed, 12 Jun 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl7ZBO3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88D2CCB4;
	Wed, 12 Jun 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231464; cv=none; b=Oc0p1+wGoy0MRpsudwfRUBH+KNvaZdtnCYvurnP4Xw2V2ArDCSnwLaw2a/BsHF69sACimRRgySFE5OvjMopgvE60LHbf0U7EXbGmRPYuTfPeI0L8QoeK5e0Zrb1lBW2LuJ9CBFnLlk08a0YRikuHEgPmezbmOHKpwNr5C29kgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231464; c=relaxed/simple;
	bh=jnIZy7v6gRkoBg8xknS0zEjcBUhw4V/Kkf/pzr9ZLKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9mxJj8xywFa63PbgzZIpzMe91aMe0A74eAmkO55M8agceNmz5zZPQcJ67IlCLHTgyHXgd4PNlf/fmhiny6taJ7A6Ah+HRM6UIpXjDLraBm+fRBSF56Z3KJtsZFnp4LW4idRXIbRW7/GlFSkUVY4ie8n3j2a9mk4Rrj+VaxWnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl7ZBO3F; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b0745efaeeso1762376d6.1;
        Wed, 12 Jun 2024 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718231461; x=1718836261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HaKXS0ZZbil+kikiY7Uq0U6QIK8rKqbj9kgNRJOfwg0=;
        b=Yl7ZBO3FsoaBbzlSK/kCw40FIVRb6hIvjlbeUtQ6+NcXwSh+7dEFSIKg19YVebG3lE
         dgoLvT7aMVdr21IKp2gnvvLtBzO0lD7UqoBMfzXLfF8v8QnWG79SuN+K8bBC5OnLZpD7
         AAwmpxOGw+8rCgTwBgrz4AAEYv6evZeEH58Uf72fAch7nq8mTuYlLamgRkA02SFZsZuY
         aojcODXalMqXBUq/bEJoenyPweMCoYDynwejo8qnJ97qS6XmQiKIu8OJaL72nqjUadlE
         NJZF7hB/nvn9g3ClIVW++YI+ZClyFtiBWCAm+nWI6G0/zIG9/qn/5sKhP8VpY2TyV3/4
         htlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231461; x=1718836261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaKXS0ZZbil+kikiY7Uq0U6QIK8rKqbj9kgNRJOfwg0=;
        b=wy4jVgNQcEuSFa0QwLJrtf/NAQq3mXUUm/0XOhbXO6AcKFMAsR9a1+NNxmLl7Q9aUc
         UftpwYp4CbjZacuBLMpB17TzikjhwaAmI4sWGbOsEwLSTbaljYuFUNu1q02+XO5IdWQu
         hHz/VmBR+MpUdp1eaKn/WJBeaFMi/48NV6dE1KNGji+tK++xc15022B3VIvoz6BiumF7
         jtk1LKpcMQ+anNWZnIo9baXUoWv4e7PLba9FvWrP8n+lnGn69o5QOjlyk+sGr4g1Jpc6
         YSWV1IhfS//jxCSiOoevy2O0V7fp0k7jSQVnqJ7nb/hp8vmAMVvfL/bQNilMni3To67J
         Zasg==
X-Forwarded-Encrypted: i=1; AJvYcCUhYWVmtd4vW1ezGvtK7Y7ctoCSzkxQKG66eFjUIahFINIQA0t1y98hRQmOS6c9Bj9VvRcINz69x8UH7po9Mek6ADUDmiApsNfCLBfQjqLrJ6Mfn6SieL1UbbhGJDxJmqR+VIyFY6BlfnvJlBlVqzE1TMhDskdyyf8ToKWYRGmYWXoGXqygBY0=
X-Gm-Message-State: AOJu0YzirqeRUZX2i7Xo5ufmDzXtUJVBuBL/1c/xCg2hSWT315+ec9v1
	l0sgmW3w48Dl9gXrVcbh8NVN43iZlGrG+H7/Wx9edw+QescToTLa
X-Google-Smtp-Source: AGHT+IE24GnzXvXHctahz7LCplx76fc3qiNipMvkxpU+kgWUnnS/78AStzuLW5X4k22oyxY3TY7sSg==
X-Received: by 2002:a05:6214:3a81:b0:6b0:7a61:c69a with SMTP id 6a1803df08f44-6b1b5c07c5dmr41069396d6.53.1718231461421;
        Wed, 12 Jun 2024 15:31:01 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf2321sm482416d6.6.2024.06.12.15.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:31:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C53A11200068;
	Wed, 12 Jun 2024 18:30:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Jun 2024 18:30:59 -0400
X-ME-Sender: <xms:oyFqZiQ-WvmBIvD0sqlLQ-lCnX5rKwuTMCezlDN_9AZRb37MfaWDAg>
    <xme:oyFqZnzpZgjrA7KE1MyLYUmJ1Jasf838cGNRKYBR9cmN-h06r_Mm-7wCTJuUGNvQc
    IMvl745UYclYNnkKw>
X-ME-Received: <xmr:oyFqZv0pR8czYrFZBfwaMrhVaEqTrYZVrO9_z--9aWvZMiUzf4Wz98__H1Fr9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejtdffueetfeetgfelvdetueeltefgieeiuedttdehuddtleeiheekfeeghfdv
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:oyFqZuCaJSmS98VfGA9zj4mLRpiD3i2pZpHBIt5wTZ-V36xK3e8jlA>
    <xmx:oyFqZrj165BCm8jCn54D3GXblgeQirQz_th-secKNAdOJxOikWdt1Q>
    <xmx:oyFqZqqLwUmFLJ8aBEPTTYMt-szbs8GMM4Ijnul9ZAv6NhPqd4_7jg>
    <xmx:oyFqZujEOOoAmrN3ioIqfRL96eY3-oRwa5UK4xUgOcgTFNQhaF-aUQ>
    <xmx:oyFqZqQTpXnFfijf9j2bwNis1Cv9YzF90IF3jt93gVKYbNv_DRLnXnDD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 18:30:58 -0400 (EDT)
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
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: [RFC 0/2] Initial LKMM atomics support in Rust
Date: Wed, 12 Jun 2024 15:30:23 -0700
Message-ID: <20240612223025.1158537-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a follow-up of [1]. Thanks for all the inputs from that thread.
I use Mark's outline atomic scripts, but make them specific for atomics
in Rust. The reason is that I want to use Gary's work [2], and inline
atomics if possible in Rust code. My local test can confirm it works:

With RUST_LTO_HELPERS=n

  224edc:       52800180        mov     w0, #0xc                        // #12
  224ee0:       94000000        bl      219640 <rust_helper_atomic_fetch_add_relaxed>

With RUST_LTO_HELPERS=y

  222fd4:       52800189        mov     w9, #0xc                        // #12
  222fd8:       b8290108        ldadd   w9, w8, [x8]


Only AtomicI32 (atomic_t) and AtomicI64 (atomic64_t) are added, and for
AtomicPtr (atomic pointers) I plan to implement with compile-time
selection on either of these two.

You can find a branch contains this series and Gray's patchset at:

	https://github.com/fbq/linux.git dev/rust/atomic-rfc


For testing, I randomly picked up some function and inspected the
generated code, plus Rust code can use the function document as tests,
so I added two tests there. Ideally we should have something similar to
lib/atomic64_test.c, but I want to get some feedback on the
implementation part first, plus it's just using C functions, so as long
as C code passes the tests, it should be fine (famous last words).

ARM64 maintainers, I use the following to simulate cases where LSE is
configured but not available from hardware:

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 48e7029f1054..99e6e2b2867f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1601,6 +1601,8 @@ static bool
 has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 {
        u64 val = read_scoped_sysreg(entry, scope);
+       if (entry->capability == ARM64_HAS_LSE_ATOMICS)
+               return false;
        return feature_matches(val, entry);
 }

and my tests in a qemu emulated VM passed for both RUST_LTO_HELPERS=n
and =y cases. Let me know what I can also do to test this.


Notes for people who are working on Rust code and need atomics, my
target of this set of APIs is 6.11 or 6.12 (will work hard on it, but no
guarantee ;-)). If you are currently using Rust own atomics, it's OK, we
can always clean up quickly after this merged.

Regards,
Boqun

[1]: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/
[2]: https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/

Boqun Feng (2):
  rust: Introduce atomic API helpers
  rust: sync: Add atomic support

 MAINTAINERS                               |    4 +-
 arch/arm64/kernel/cpufeature.c            |    2 +
 rust/atomic_helpers.h                     | 1035 ++++++++++++++++
 rust/helpers.c                            |    2 +
 rust/kernel/sync.rs                       |    1 +
 rust/kernel/sync/atomic.rs                |   63 +
 rust/kernel/sync/atomic/impl.rs           | 1375 +++++++++++++++++++++
 scripts/atomic/gen-atomics.sh             |    2 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   64 +
 scripts/atomic/gen-rust-atomic.sh         |  136 ++
 10 files changed, 2683 insertions(+), 1 deletion(-)
 create mode 100644 rust/atomic_helpers.h
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/impl.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
 create mode 100755 scripts/atomic/gen-rust-atomic.sh

-- 
2.45.2


