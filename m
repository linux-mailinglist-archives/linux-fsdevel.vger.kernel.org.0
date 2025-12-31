Return-Path: <linux-fsdevel+bounces-72290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32268CEBF94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 13:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F27FE305AE43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF9324B1E;
	Wed, 31 Dec 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BU9WJOai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA03233EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183764; cv=none; b=HYIqfkQwz5lZh8o0O7QT7XshAbXzp7Mc6F6iK0dQc/FHHjc7+H3Gk8a1Evas3f84jevmMBi52xhJuiSAik1LZwbXMVf462Ru005+DVODoE9NokRTgi6o8QI+cJGLhPeBiVHXYmbE8l9LYf+vWn8H1Jz9tZnSbFaspOa+QvfWB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183764; c=relaxed/simple;
	bh=f+ElsItk3DSISt1bsxPjTx60qDfLwGd+MdLyPyzjyQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUhYlY1V5cZzpY/BgawbdC3Xc9xlOntbtfLu1iYUzAkDq+u9ZR2RRzylOWcHD/kaljYD48IEbUP8bW2Jo9V8enQ79OqNb/gtYterflO8a5qJK111q8IHxxiIE5pPuih5nkwL/hS3xFPAhpMKfCQ918fA/ziGYowq2SHpwgT8eJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BU9WJOai; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8395cae8c8so119265366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767183760; x=1767788560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0aSDGMKyT+fMQNL6kGw597IXO3k2kPPSUGq+qvudkw=;
        b=BU9WJOaitrVt6PfvkjkWkxeV1Lf+qreGMVZh3tOZ2Nd+mvgYwxGYyJIf+TLnmMn6n2
         XtzQFi26YaG5INjCjj5ODjFcSHzIbYfoPFFiHJqXqV1S2vtvENmKEioHO9R9AtJAnzBt
         yeid0ul802VnCPE+G/JB/9ufpPI0tl3gEhV2KAU4nh6YEXKbf+0kXXAm74vyIZdBgvn7
         0CYWDQCdh4DM1zEAQbQKY/mbrBWr7HGnwOpN4nLWMggkll1pPl4rVYV4FADDqzkK32ru
         wOTicV7IPGTmZyJt8pNOY+z53eeN6LbwGB0WjXzH3DklXBDQC2xgnmLNRpVJX+lxlWRb
         9tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183760; x=1767788560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0aSDGMKyT+fMQNL6kGw597IXO3k2kPPSUGq+qvudkw=;
        b=Ohr1a4/PoTMdeGOkIx/u/kMxVz5vyljTjjJw06gY9DGINHLs+bB7S0DWMxJxG/LoFc
         OKssIlpe1VqSHNg1rNin2KdgZ1l1VPVhJJW79vHDrF5uPDgudYkYjubGysFgbkq9NSgf
         +w7jdbQhkmh0Ho1SZgDM/4jP4vDukg0nnIT5ymdiAUJu8ECp/DLdGGcnGV8MqDsaPLLC
         ftPtlz6COjqSYqyFQTwVfWx6jfwOKhY1256pNXV5MNVrh+w58Jd8HZwh2eJpKNDqPG1v
         p2YIsHw/FNazbq3O1K3YU+acmWSak19c7gCxAsxZrQ2Q+h1bQZgv/YtdUpXgnWG/TnUn
         6DzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSpDeHRenVwn+P6CZlOufaH9TC//4AXarS8YPKTsDdHiXXqcQcGtYG/3CnOOPbIjHBpbOFTg0cbm/31QZO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5Nda2dOaYag6CMyYkxcJ7MD8RE5f65e4gqerqZ+J9e7qHeUJ
	0+7EpqB8zjj8TY7oQvSldmysbRhcar3Fp3If7rSr4IK4GS4Zt8OuCDxT8ERZ9fs638Hh3PHsTD9
	l+pgqgbHy7XDYCavaDg==
X-Google-Smtp-Source: AGHT+IF6QCK61/Taq0LVCEy6u2Lh/f9qkwECTfyeXwyFZObuLicNLjWSsvwiJ+SkeSLRWE4V1R+yhLQS/6l+gLk=
X-Received: from ejbva10.prod.google.com ([2002:a17:907:11ca:b0:b73:7b14:6671])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c10a:b0:b83:972c:7862 with SMTP id a640c23a62f3a-b83972c7a78mr466276466b.45.1767183760503;
 Wed, 31 Dec 2025 04:22:40 -0800 (PST)
Date: Wed, 31 Dec 2025 12:22:27 +0000
In-Reply-To: <20251231-rwonce-v1-0-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=f+ElsItk3DSISt1bsxPjTx60qDfLwGd+MdLyPyzjyQI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpVRWL4oDnxIVIQOubpJwcZRLcyzDfMlz7wIFAM
 FONlx/oCYKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVUViwAKCRAEWL7uWMY5
 RmH6D/46KKFKWvICb3h6YXEsXSSffucVzMDtCNxV/nON8HqUTVC9QRwy+QA5BR0hrfvViIl1dKx
 QFW5mE6zsjqHKs9m3qdyng4MUI8hLxBMk3ZddZ5++5KMoowDj7M9YW79F70Q5JL8cPNiGTxEn8T
 VOpmnKD0W0uqGzPVPn23nyrMXrCuGOSOlv1Gd7VlP14rVqitTFZNDbO/h3Jxy6lNTukLQ+koVaY
 IfTia3CyF5IhIS2g511uFdNOICKH6TDOYX8thm7ndly6HHx+6ARDy7WILR47BIDGvXOQdbt1kLi
 V6/5WiEP3hVfSFSXEsvYYHcIWFmsvvPJOUUlHKqLTHmMiG5YzhOcIMdWR2xCLaCeAb147Thitc8
 +Ze9StLM0Z7stUstGbYjIUZFQ+V4Rndjy2ocRJH5Ed52rnZN9G1Iy0NTMogqlQ8hkUiNoISzYer
 7JORef2rWkONYm1I2EyDd+XsVaBfYDD7SBf7gj1LjEzjn/cJZqNNetKASeZnYDGe8oD8X/hfN41
 /K11v2L2aZsQ/aZx/TvPkBaD5UlBxpRXYfQLDLE0Xgz2TNev4vNJ6gzjLvwaHsk+5wi29msQ69Q
 ZqqGYocGcZHMGcf7aalYz96ESMDQx6plGafNctmZtxnbAR6RDeb4Gt0M3Bf/FonllPV4dkLOmiO +fYoPkvnNt3oL+w==
X-Mailer: b4 0.14.2
Message-ID: <20251231-rwonce-v1-3-702a10b85278@google.com>
Subject: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
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

Normally it is undefined behavior for a bool to take any value other
than 0 or 1. However, in the case of READ_ONCE(some_bool) is used, this
UB seems dangerous and unnecessary. I can easily imagine some Rust code
that looks like this:

	if READ_ONCE(&raw const (*my_c_struct).my_bool_field) {
	    ...
	}

And by making an analogy to what the equivalent C code is, anyone
writing this probably just meant to treat any non-zero value as true.

For WRITE_ONCE no special logic is required.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/rwonce.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
index a1660e43c9ef94011812d1816713cf031a73de1d..73477f53131926996614df573b2d50fff98e624f 100644
--- a/rust/kernel/sync/rwonce.rs
+++ b/rust/kernel/sync/rwonce.rs
@@ -163,6 +163,7 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
 // sizes, so picking the wrong helper should lead to a build error.
 
 impl_rw_once_type! {
+    bool, read_once_bool, write_once_1;
     u8,   read_once_1, write_once_1;
     i8,   read_once_1, write_once_1;
     u16,  read_once_2, write_once_2;
@@ -186,3 +187,21 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
     usize, read_once_8, write_once_8;
     isize, read_once_8, write_once_8;
 }
+
+/// Read an integer as a boolean once.
+///
+/// Returns `true` if the value behind the pointer is non-zero. Otherwise returns `false`.
+///
+/// # Safety
+///
+/// It must be safe to `READ_ONCE` the `ptr` with type `u8`.
+#[inline(always)]
+#[track_caller]
+unsafe fn read_once_bool(ptr: *const bool) -> bool {
+    // Implement `read_once_bool` in terms of `read_once_1`. The arch-specific logic is inside
+    // of `read_once_1`.
+    //
+    // SAFETY: It is safe to `READ_ONCE` the `ptr` with type `u8`.
+    let byte = unsafe { read_once_1(ptr.cast::<u8>()) };
+    byte != 0u8
+}

-- 
2.52.0.351.gbe84eed79e-goog


