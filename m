Return-Path: <linux-fsdevel+bounces-72389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 304EACF3C05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166A030900C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5ED33DEFB;
	Mon,  5 Jan 2026 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O67FtXIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8933D6E2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616999; cv=none; b=Wsd9MndOweoNsxHD3uH2uk/5WCqmhVEGr4O8aUwPmkAsMtU4Ep1rkpHo1X1W6op1U+iuMDTQ92F9oOThOlnoykDHrH3gjsuL4SqVFfc66VYyRyIj9Xa6c1RVlH578Ua/Rb7Cv7PSypddLt6zilfHqxo8CJSRUxC8Xp6/0YQlw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616999; c=relaxed/simple;
	bh=NxiYW0CbqWZmci++RKJimpvk5ApS8tJULtdHUF0b2gE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuuAqDSn7tahthn45jnyvZY1jIpNdhj6yfu8yK1ug8UmDCPJX5+ZYvL7nIaA1VOOSTtP8blcqfyJ4Zc2PtNg+onQKG7T8OgVdpek7OwFo19uXiDbT6Sk5satBV2dpR8NSeVEDS5EWToDrW/xL9VOi1sersoPAwk66lMG1KRiP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O67FtXIz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477771366cbso112458115e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616996; x=1768221796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z46BFumMsZupou+yyaDDz+IWIkSi27BbE4HeuL18C6o=;
        b=O67FtXIz/OTHYT9INQlKRoSoZBsvhjpm7cRieCg+bEhJfhNuipV0ogzqOE8Djp6z4k
         R7Lp+RHvKRHtNnIzhQMxAvLmN8z4Nt8+ttwjV8jIN8eAGOqCcyXGwGXMf1MbtTpNG8fN
         LX+NKTVtB6ayIYTBaN7F/Mj6LtQUdPgg6phuT2vanUI+eGiihoE4DKJG1V2NG+Eiaczs
         HPlALBOeI6d1hthGNqKbprlt68L4iTFO2iZwbjlCpTPagIGGpDj7W7IZtBuhOhKcqsDJ
         a3Uysqv1ApNDAcRxrdqv0aJSzTOYxam/kM9J/Ul6OtZtqebUYIMUuDl6iPEvjNgwyKaS
         7BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616996; x=1768221796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z46BFumMsZupou+yyaDDz+IWIkSi27BbE4HeuL18C6o=;
        b=r0vlZZcQ5orqGmdxLdmI2rRlad1J6tlV8A8c0n/VqKXpdZzKOQOjIi8KiHKztDMxB3
         4qqp94s3+kfJln3k69rtVRmaZJDN0HPWhSqB7NprjByb7x34S+pSYJWf8GRYXm7Ad9ZR
         UFG1F+sgIixlip2UNjnh+DogZnydMFfeuYPvSXr6ukd/aAW6gs2yTrYmRxKqgTOKuSm4
         QHULZs1f6O6fmiszY3GR/l4cBaM8Lz3H0lr8n7Oi4skMKtStt5KpbiSEIHrFvRPbsLXo
         eiCwO3t26DmHEkM6Ysv/0HNfdhrq129SCARQx/3fZuORX8U+SMMvlFMqPNn1n2a0AYTC
         jR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXuVrkiysfnelEKp7aHDbsudWeXpEub0YyloAspeksGpiLl2S576WYba5MZUo67StJNTpbrvo+Tj6NNJWV9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cvwxuMiSgzoHw5XYJL6IZRwhFGK++I1Wo+0Jrw+C7w6FVBEt
	2x50hqNv56tYkOcb4aD6hJ5g0a/XodKjwnInEF8gVhk/GqGBDQNh7en0ZVhDQcUjC0jItgjo+3U
	LDW4MDHcnv897AqZiiQ==
X-Google-Smtp-Source: AGHT+IHb4FXR8+6IReKURWCDo1GDROcS9nS8ZK0U/BuzFCFRx4UyIi4H/RGJplSPzQ8aQkM5GOyc9gt0PQUHWiI=
X-Received: from wmdd17.prod.google.com ([2002:a05:600c:a211:b0:477:a0e9:dc85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470e:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47d1954778dmr560627315e9.14.1767616995744;
 Mon, 05 Jan 2026 04:43:15 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:40 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NxiYW0CbqWZmci++RKJimpvk5ApS8tJULtdHUF0b2gE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G9HcM8jXB7EhJZmxhOVXBkfAqJJ6TRQSLuj
 qqOtSRahV2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxvQAKCRAEWL7uWMY5
 RmBiD/wM+sYNoJCxxvFtNBv5ZQEVMGut4EMMHuoEp+cxz9iETUHnUKV2WdfWAv6Di6pElayIQDs
 Xmhu8IWGphqcOrROZon8pQ/ru5idMHqBNRM2+dM8RBKllHE7h894KMd18tczyyVkW3pOf27fQ6q
 xWpaxOVrUUU1Hs5PLZLA/g5rHishlixFGSXGcgZuD1gaBpy5wPSuKXj7PZpruci2BADDp/AdRpn
 2veLunxvPaX7qJ3993M5PhhCJbKLKVe8dmRygNk3XLQWcR6aWc9FYpPOLQUJktuYKeO/nRdJRgp
 xxZcsm8Y/O5i1wAVyJkziZGoV2PMvt+I9/GHmNcv2qtRCKW+YZ8SwmfaUaEcAC89U/77imhlsIa
 7/NzPNXI2eYehM13QdD9pZ+HSTMPFvr5mxzaK8Az2J9/kOUfcNL1u06cVBDlg/SiA5U5oBhsHHc
 tx1BOy6XuvTw/0nWHO4bvywYt/tr9BCfP4D8hWUk5EWzTw0sILLeY6IFRNFmkE7kzLos7IXwWQu
 6APiigknaMWoc7VxpFylvh+5HkBDbmtRUpCPdNN4tcmyE+qE4CVNmRE2Hfu6N550AqSo7hW4A/R
 x7YiCjYiJxt9Lg6gri95NC+QF2aN9O0vXpASyjJJ6OCIssdU85AHDq+TzO3r/7Hu0BWtrm56Y9F rIrBJAV/P58bS3g==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-27-51da5f454a67@google.com>
Subject: [PATCH v2 27/27] rust: xarray: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 rust/helpers/xarray.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
index 60b299f11451d2c4a75e50e25dec4dac13f143f4..08979b3043410ff89d2adc0b2597825115c5100f 100644
--- a/rust/helpers/xarray.c
+++ b/rust/helpers/xarray.c
@@ -2,27 +2,27 @@
 
 #include <linux/xarray.h>
 
-int rust_helper_xa_err(void *entry)
+__rust_helper int rust_helper_xa_err(void *entry)
 {
 	return xa_err(entry);
 }
 
-void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
+__rust_helper void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
 {
 	return xa_init_flags(xa, flags);
 }
 
-int rust_helper_xa_trylock(struct xarray *xa)
+__rust_helper int rust_helper_xa_trylock(struct xarray *xa)
 {
 	return xa_trylock(xa);
 }
 
-void rust_helper_xa_lock(struct xarray *xa)
+__rust_helper void rust_helper_xa_lock(struct xarray *xa)
 {
 	return xa_lock(xa);
 }
 
-void rust_helper_xa_unlock(struct xarray *xa)
+__rust_helper void rust_helper_xa_unlock(struct xarray *xa)
 {
 	return xa_unlock(xa);
 }

-- 
2.52.0.351.gbe84eed79e-goog


