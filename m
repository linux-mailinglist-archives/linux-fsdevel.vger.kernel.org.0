Return-Path: <linux-fsdevel+bounces-72292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBDCEBF88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 13:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D2623013845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C85322C60;
	Wed, 31 Dec 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXg+fj/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C104324B06
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183766; cv=none; b=VdhQk+DKqEmYVx1KiaOyQ4BwgoZxSjC1WH2DVsSpZsnpbSazK+UT6zREFuKA9+/03l386WTwiX71R3bwihfG4NrWvVCPlFU4u2onLRLwhz1Ad4p2RyeVXFQ6QDYM8PQuNpJ5kbwSNPvQJiSnUGdZcMfK6Bmdt50iHUkck04dXuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183766; c=relaxed/simple;
	bh=x48g//vEaovaCGc/+3V+kdS96OVZQrdlR7cVmTcJM3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+DMuqrZBPMIdutCjASF7BTqK3EHpzsLAjT9NXvoq5itkFT96ektazwBzVsPMDSXLRU/8a6ip94tj5vXjKqEcv32tfaLYLyi4XYDrrOllx/UsjBsH8wqcpftVRWC0wXs1+kJ3KQBonvuOLFSfXpBWiRcbmyqeCeN3T11q9FKDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXg+fj/D; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43102ac1da8so7722219f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 04:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767183763; x=1767788563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnX+YiWBwSFj03NZe+M6b1I0lykasXzPK5veF6o26Xk=;
        b=rXg+fj/DzoTvLQUq1C+NqmI1l/Dv9/E+2MpEhMt9Bn2phj0jP+SEVHcy6DFdj25ZWT
         cUZnz/qO1Qjs6y8pbxud7nGfmNScImOxjXZtq0ysNMkYcUmVxJTMi9HqajRH89WZDJPp
         D4n08kz2zhlNVxK5fLBL2MbnBu36uVh8B50QgJUpIjy2Ln2ixFUb9wkTubZUR2z5s0tU
         l6+mFPAmw4nGWooXRhLE3pmb7yHtaNG5Ilo6WykD0NpSojQ5s/1wggb/ZB/NfVTawK/x
         5DG/FXxuiw4SnZ0HBZkOh4NSj4bScSQfDWK4NLUnyqqdHvOXZ0FrIU8hGYtakERRt/Gv
         0l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183763; x=1767788563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnX+YiWBwSFj03NZe+M6b1I0lykasXzPK5veF6o26Xk=;
        b=pdfqly98A2swplLwYv5Dq1Aacd1WJwBb5rNepuUUEddyIn797Fap2vX6CFr3BYtl2G
         UamsnaZHTbH0kek8+UGfs7awzVJpvxQziRidQ6ASWcJ6nnvFnrmenGrz+UYoIrRYtG41
         ghJY5lV6/rd+8ez6tklxCHHkZkEAzm5GpwhlGBg8olAXB4xQVrRG3U+3hHiQhQq1O5po
         GA+cW3yyoen7nG8RXiK4qNe+fnkBpz4W44iE5Q0bSnUbz7kmEV/s9B6OtxPHIFgfQW8x
         ipJdzh+TrXC97HNheagB77/erz8djzjTzY29uWkLrUFdjvkmQg1r8GoHRzplZu6yHx25
         mPFA==
X-Forwarded-Encrypted: i=1; AJvYcCWHQxD00/dOJr8pxHR9Y6/gy7hGQ9miB4C7BQiyBg+s+Mw6ppzQsHm1+a0KpP2HwXZ8t9x6RKlWgoNeTyfG@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzw8QffV5cMob8HEBkdQWg9NbayuhuJh5LhUXUE0/GJvl9AAE
	0w3KQEX/nbHoGQg6iBP5ARG3xWfowZb5EYWtReo3PUfzqeSHAiZUZyOImXdTyzECUQjW/0Zx2pv
	uBWecZQjAfPofL+UJGw==
X-Google-Smtp-Source: AGHT+IEVvKcXr6CgV/sO/SopdsqbSp5OU9ou7XeJWfmPxsy3aUaKE2cdpBZhPeJYGAC28ivLbvgGuv+puag4k9w=
X-Received: from wro8.prod.google.com ([2002:a05:6000:41c8:b0:432:5cc6:c7ec])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40db:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-4324e70b2c0mr47793415f8f.57.1767183762838;
 Wed, 31 Dec 2025 04:22:42 -0800 (PST)
Date: Wed, 31 Dec 2025 12:22:29 +0000
In-Reply-To: <20251231-rwonce-v1-0-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=x48g//vEaovaCGc/+3V+kdS96OVZQrdlR7cVmTcJM3Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpVRWLpYz+qsgfDBCA957maLrU5abZ/AV0KNPf2
 x2dVJo4CRyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVUViwAKCRAEWL7uWMY5
 RpbRD/0SaSpBYAhj01HuT6p1Sh0F3HjDBRU4CbZou0WZNZ4WriLhGAdf+MIIjlEt+5DLcmae+YX
 27BXKetHb+p7wJar0/d6qrTf/TQHUwmCyaL950x8UvyGKZjIVa/TCNx64b/oJobA7VmOtuNtFHr
 krbCJy/HsPCYdyTfYX7LhHPaeMGMOZDlhS5MWUgWYmbEo0Jx4LgSaNXEzhQpnmDg88F1vPMjjhW
 no8A0idLJ5umHWtXn0h1OKB0XvRpQTVwo+JZsNk8M/8cFdcvbJQxHrbwuTEGFaIkb01dRY1Ntdf
 01rcHfSx1yu4iyuNDwnwXWxKy6Gk0DisKWSz0r+uqQjJIH5yLwLiZ+oKtGUU50CoT+p7D3XX7ee
 NQYmTAfFErPyMycWpb0rdPLebSye3a2RtXxOO0cCLsGAzKsadQYt9Qyiz/SRaSuGAxprP+2SaA1
 tYW2y41LKbfKByd3v4AXtcjuXykAoAaaZnFcRcSSFxaaLuuAzS1kB42Gdu92hVpMPWBZ16h/RLM
 lf/wjXI1jEitSsib4IBK188r4m5IDfIk6q5hlJM5cvNgfzDpsOBNpz0qvCLfTiIP01+JvimWH6n
 S+0cvXpMJQIc85ahkyeZd7IPV6qu+FHl1qL2ZnTHNJ0ktF6I2ONB+Fvhbz5Z7ky5OYO5MmZfBJO 4eEFKw4YUaLnpqg==
X-Mailer: b4 0.14.2
Message-ID: <20251231-rwonce-v1-5-702a10b85278@google.com>
Subject: [PATCH 5/5] rust: fs: use READ_ONCE instead of read_volatile
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Using `READ_ONCE` is the correct way to read the `f_flags` field.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs/file.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd2400565223181645157d832a836589f..6b07f08e7012f512e53743266096ce0076d29e1c 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -335,12 +335,8 @@ pub fn cred(&self) -> &Credential {
     /// The flags are a combination of the constants in [`flags`].
     #[inline]
     pub fn flags(&self) -> u32 {
-        // This `read_volatile` is intended to correspond to a READ_ONCE call.
-        //
-        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
-        //
-        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+        // SAFETY: The `f_flags` field of `struct file` is readable with `READ_ONCE`.
+        unsafe { kernel::sync::READ_ONCE(&raw const (*self.as_ptr()).f_flags) }
     }
 }
 

-- 
2.52.0.351.gbe84eed79e-goog


