Return-Path: <linux-fsdevel+bounces-54773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F8B030F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0200F1898D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20982797BF;
	Sun, 13 Jul 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niYQQg1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5D278771;
	Sun, 13 Jul 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752408374; cv=none; b=rPvfw1l9XHDVkjj4t/9MfAS6DHh/O5XzPqZ332Uar3JyjiS48E8DN42ZvyyyX66UzhTgAMaZSgFgItmE9SvObCR1t10/lug0tCMag9gdNrtwUlxdQ94NnVbvbm/waabwUdheB9EIQ7axtwCZDLF6+Hq8QUEq7cVnYGh1Un7JHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752408374; c=relaxed/simple;
	bh=fAwU3Dw0VVbSL1K2WrkFK2QZ6aEFlQeFvzwHQOJ+Rl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJDeqPgCt72V71iauEVbTvoCdLfDTBWrTW4gbHPwFiC8yYKuTqbghuMjdkSIDlkx4dG76Sw6z7V3LFFD3lJJPYDprPEvyKFVhmlEpJtOb5rwzKlZbfAbmKyyLxKho4Rup7ppJRzgDp2RwBP+4lObn83FdIHWrIzvAGgSZDqpD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niYQQg1a; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso29515911cf.1;
        Sun, 13 Jul 2025 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752408372; x=1753013172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRRn3adUSWnF7XA+VTOK1OilRemXMwUQ2ub2U51ygXQ=;
        b=niYQQg1acbbJsYxWJfrVKeFBfRjAAGSHv3R8lU/2kFe10rF7hZROyalgk72Yt42Rgj
         qhbqsVaURMy3t867VK1p3O8TX8ifgWsHO4n0nf0pGQCjmGQTPVmNraHHxNvQO4HBw/M2
         aPSolxSwr5L3TswXsViScH0uPpsH9cWi3JVFX6LaCr0z/4vgKx6ulqQJJ21q0mm5y+Ur
         PatNB9b9YXKgy0uxR1O0/ikyYZ4tJEt3Ep6p24oSVP8YOEcXnO+tnkVlVVGGGK6v/3i8
         HSr8picZX/Rs674ePJVslCuUPGB1RQ/kF8afpSgwmR7EhKgupSt/rsYU1NMpQ204GjnA
         rCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752408372; x=1753013172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRRn3adUSWnF7XA+VTOK1OilRemXMwUQ2ub2U51ygXQ=;
        b=uISEq26BT50e9bWGbvRJmJ/hw6N51IIZlcRaJNXMK7Tl2LajprLwfZa9qH8lh6Grbe
         3ZGdfF8ONqR2aQ4h9dGIQ4MG1xBiH3jGTCPB6wXXdcVXVGWbZgJKFHxWRgKnMYIx+WFR
         u974ETVt76JD6OmAQ9B7Rz6mwQzfvQoTysHu2bpZ+jcxEiyfhVsf39GEFi3zaxc/c40i
         yDWjQMdxBIYuzf18JUjKzYBV3iDkGBe9oATWbCXMf9Cv6oCbZ2MF8Z/uxPR+mNlL9O+X
         54dJT0jR4rbaT00yO6hVdPiP1MSiKAdRrLn5Ow8OWnvQfvbdsaw8+KM20goBUPVE6U1L
         2KPA==
X-Forwarded-Encrypted: i=1; AJvYcCW5okHOcu54X0DylpdqZ/zJPs3ZnCvhK+553TG2gbm9KRIuyjLTjCbZUijJLCFcTpSmElA8xjIO/M6dRpBe@vger.kernel.org, AJvYcCWF8Agg8fKzy643tke2ym+7cyyXQ+bPf7AQoczhLpDC2JsL7lR3ct0ddmuv+mPIVkHdda8qKjAoRnzjRZ/k@vger.kernel.org
X-Gm-Message-State: AOJu0YysEastpxaYXKle91V5ls0wzfS9m5FIj3Quc80H0JJ4Eni5g98/
	9mQ7uQYQf2QHJMrCBEdxOIxKD5DVvoz1Ac/QSkt6G6Z5oPLzaTSkgfcE
X-Gm-Gg: ASbGnctJscXcuyaKZS7pkNtLxseVIBTQaZUqm1wCyX6ghwcDaZgqxESdWypHFGv89BU
	KAQ4UEMI4dFPL+13KojDQKS5ynlfVQNZ0aHHtkGa1DIVdj+wtsBQFPTIOhfsIG/dFQ6Qcy7fnl1
	3QF+jOiThihu3mra7JODMu+acVPdjU0gRTur4X4JP2iQ/Rw2XhSS3Rg9b35yVHpB9yBfQz0GP+b
	IBqw5GNQ8LbzKuhLcuvS4r4ihTNMetQxfan5/g5wo29cERg3lw6lWMJOQCji+7oRZKXbhWWNxFY
	wTlqZASrCIb772O1Utf1YQoPPPIZ/yz+BuohjVRZVIJ+IRPC4VgRiYuNAZ/4vcr94Uwu46XJ/6v
	PKelR/VINCycqhD4kNHd5EbugsTK3q9sM8Q==
X-Google-Smtp-Source: AGHT+IE0DZZjfFFJUrNFNAwuzKRA6qZsGfrbEyOa7h6vbqvRZJTduHM4KL6cQVL32LawZs5toViNsA==
X-Received: by 2002:a05:622a:408f:b0:4a6:fa39:63a4 with SMTP id d75a77b69052e-4a9e9bb2ca6mr219635541cf.2.1752408371626;
        Sun, 13 Jul 2025 05:06:11 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2desm39706261cf.72.2025.07.13.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:06:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 13 Jul 2025 08:05:48 -0400
Subject: [PATCH v2 2/3] rust: xarray: implement Default for AllocKind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-xarray-insert-reserve-v2-2-b939645808a2@gmail.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
In-Reply-To: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752408367; l=1344;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=fAwU3Dw0VVbSL1K2WrkFK2QZ6aEFlQeFvzwHQOJ+Rl8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPrvZhZmLe1OJjceZwKlixqae3vh+AGx7SSW5kUilLJT3bWfzQcIJYvgqCmtvSZfPnxwQK2EmrD
 TAw/GmCOh/Qk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Most users are likely to want 0-indexed arrays. Clean up the
documentation test accordingly.

Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/xarray.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index b9f4f2cd8d6a..101f61c0362d 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -24,10 +24,11 @@
 /// # Examples
 ///
 /// ```rust
-/// use kernel::alloc::KBox;
-/// use kernel::xarray::{AllocKind, XArray};
+/// # use kernel::alloc::KBox;
+/// # use kernel::xarray::XArray;
+/// # use pin_init::stack_pin_init;
 ///
-/// let xa = KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL)?;
+/// stack_pin_init!(let xa = XArray::new(Default::default()));
 ///
 /// let dead = KBox::new(0xdead, GFP_KERNEL)?;
 /// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
@@ -75,8 +76,10 @@ fn drop(self: Pin<&mut Self>) {
 }
 
 /// Flags passed to [`XArray::new`] to configure the array's allocation tracking behavior.
+#[derive(Default)]
 pub enum AllocKind {
     /// Consider the first element to be at index 0.
+    #[default]
     Alloc,
     /// Consider the first element to be at index 1.
     Alloc1,

-- 
2.50.1


