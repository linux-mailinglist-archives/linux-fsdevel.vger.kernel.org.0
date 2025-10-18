Return-Path: <linux-fsdevel+bounces-64585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2445BED755
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF719A64C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F02741C6;
	Sat, 18 Oct 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCdE0Ojt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4837273D75
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810604; cv=none; b=fsxol3IMKe6aVxTayHVPXCf34yhQ0g4JYjRAE7pBA25dP0w6wc970E4SAlaMNx5eEMCPtjNpG66+KxfmaFB4TrKo3ob1fDfmZHq7/R6Uk9cdS9C3ks0N/IAU/cXuk3vEm7TsdK+YN2U25zDnqV5KKyH5/IZDHNla8Rd9z0bpL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810604; c=relaxed/simple;
	bh=JRHxs/B/lllx/mRYTbX4X0zoBVdGGTRzzB4qSksz3BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZ2N6akmULNF22cmfoRsbNiy4tuqQry7RcvAGijQrGyPPfHMc4JUvBndjN3dY06PW7k/KWTHh3nJ+j3Cj8GaRBHLLqGpzhfKup+vmYbcjhbXXFmTcjqNpDZJrkMg6vpMOfJBzKbuJPURNYX+5Ln21x59eHiSUhOqK+Pg1q+ot78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCdE0Ojt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4710c04a403so29586345e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810601; x=1761415401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRx+IA31rk7VSUz5v3RyOo4nJpXSH+QxySZDi0dx43E=;
        b=dCdE0Ojtp97T5z8E+h35C6VvFcW7GEmDKFlzGtzHHeTO4CpUTYvuzFBRMZngydoQEM
         kkRRH+z1BMRh2i+GVu3xud/cewc0qPlupQACtcV5zolUTgvQgAxIdYFcnCHB9Q4TrDv8
         Ba25lHINRwsGOxjhqlkJ16VRXvWQaNfHlR0xwWVeG3K6p7tB/29fEpY1qCHNaYJPMV1a
         U2xlB3ZR9fBfDpFmM7pUAQLAlmoe/oeqv0q5U0fl736quAWUCsFZipG4cHeMCI6m0uIg
         6iKiF63M8KtoPW2sejkpXljPDgIr6FNv+jOSi3hBzCjNnftEWCqa8x0c6t55zMPznTsF
         Cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810601; x=1761415401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRx+IA31rk7VSUz5v3RyOo4nJpXSH+QxySZDi0dx43E=;
        b=nclAzWz0RJaJ+KpmoDxOYOyc7aLOJjedvG98gg5qQTULae6G1Fu1JEdQO5cKJ+O0ac
         8egsQqbp41dk6+dbIj/xoh9/b5dq43euLtwFaooPEcJDTF8vfJ+bX4PTg/ZI8E9+9WWq
         QnljzksCEonPf+gae6m+aNo768fdiqpi1FluFpgBllW+G8I1aELAph8Qi8qwKWrFkJaj
         OmbvAaGjKe6hw3YXMp/3CGruwV0mCmb5y/XWqs1Vt40mHKH8FIpohEZu4E8K7dDBqIwN
         b9Bvi6XDKuylsW8x0jC6QLh4CqQJ4BI70QNeGIUx9w/CtuXZevWzEdz0ZSVNfsL9B/Oj
         e5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUItpr4qeqVVhwwdJ60djZr3bsFTGBIQg3OqjIfyNOG6sqYLlitTbC9c7xO+crj1TNltgbQAWsVZPh4LjDz@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhLPxgGnz7HxHGP8TGgJY4AMWoB2iObqdz3VjHHTYX7yJab6o
	+lyxm+vdsvTteCG7wn5H/2ovTL2WylqmBmIs9fSu45dyUnkSdihp3qrIPpZWH0EHNi4FuX7Awu4
	faxAUVZATeEs6LJmLMQ==
X-Google-Smtp-Source: AGHT+IF6AVT5n9fyZmX8HKRXXzv3logzsSjOnhKpBAjpd1CKVhXkGu1U0u6LIuqBRDGiqbuatyc4kakbkHTbQVE=
X-Received: from wmna7.prod.google.com ([2002:a05:600c:687:b0:46f:b153:bfb7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5029:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-471178784efmr48534695e9.1.1760810601266;
 Sat, 18 Oct 2025 11:03:21 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:19 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180319.3615829-1-aliceryhl@google.com>
Subject: [PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/clk.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a..c1cfaeaa36a2 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -136,7 +136,7 @@ impl Clk {
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
             //
@@ -304,7 +304,7 @@ impl OptionalClk {
         /// [`clk_get_optional`]:
         /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
             //
-- 
2.51.0.915.g61a8936c21-goog


