Return-Path: <linux-fsdevel+bounces-34531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E99C616B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565DF1F22B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40921A4DA;
	Tue, 12 Nov 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niWPaqEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5BD21949E;
	Tue, 12 Nov 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439550; cv=none; b=PFAZN80VIeokFyyDy9jdiZoAknro9rSg7QEh8azcQ4+b/amB28EkiHpamXqClnz6ghCARnPJfq3yjkSUGnvde7BsRXEVGqXTMmtjNrznMGM3JF6kTP2Q3NJMgA71TIDSgR9k2MUQDUxlXjzxV1VoA5ese5hKVqxw+fEhVz/ri+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439550; c=relaxed/simple;
	bh=AjDxtUOOjIpTEE1nyWRWUP+h0r4wzvf5tBIrwgKyeUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hT1i/bZiO1o3+fHhAy/yUKj+ye5xLTVhraKvxAnSZ3cvft0S11aFe8c1zby1VzHJbDSshCfgoEB/z3zh7fj3Vr6I+aUEUhB0SgTQGgbzOShv4FSh42GXM/fhJ8RM9+NlfjSFWQsXVV3hU3it4YUBM0Q6J4XR0vmdjZr6ozGPXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niWPaqEi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460ace055d8so44138061cf.1;
        Tue, 12 Nov 2024 11:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731439548; x=1732044348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hlkpyjr9+m8ziY3XcgbtHwZj36eM6mV2l4GU+t4LNeI=;
        b=niWPaqEil2xjOi8gxdD9wc2w2F0QPcRzQ3q3MZELpyhIWZeIqrsVFSBI2iiyJr2pq1
         3MYsPK72/dLpm6/1pvYn/gfpqHSUwl9plqeeFKiKJlUlzkIlbTSg+U3Ofmw/D8UIhvQp
         kCAyBPd/0npLKu6Ah7BnXKF34vo9nFZ6kMWEDsI3x4H3vhXPKrW0HETNY9EGW+ga+z1w
         ZZa368T9K1tgHJ1N9oYn70Cj3DWDSsFl1+kE1VkVZAWK8Scaku5TR0ail+4A/BxmSv+I
         v6PcGYG4AFSCZDZb6e1hdnQ76GAAvJNPw2Gr81ajOUJbRoaHsg7cGxCoafYvLeJ/rD5Y
         cAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439548; x=1732044348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlkpyjr9+m8ziY3XcgbtHwZj36eM6mV2l4GU+t4LNeI=;
        b=hGIn+yK7+5DGVkxWnJP4Oi++vfcmVjg50b1ndK+UVJJwzJ8posF28Jtwju8gKYbfZz
         SkFuoIIDKLD+7LFTgE1rNgMiU8T9cB1B02lj1Zu4sgvzmP0Sor4kXTJTAQZOZbJfjYv6
         nnL5KNd0a/i1lL2AfgoEH8fB1I0/hoR556/nqeA/GIK+wttZrbg+N55yOZ5EtegBX3Fg
         zW8H2TIfuICxFyV/jJQWvuzqaEBDbMPuqxjxowsomIlPKEdIWxNTIfCvv6XTepXl/keP
         qJDkfguuJKTpQ/8rKceV+7bZjjfiCQplrFvBH5C86L12RPCsfLv1ZIRuYSvVMcg7kGxy
         H8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUTpbdkSuvWXCBXiyew+eGe+RBLcIZi4tG1IdFrdDrtRDvMoJqHKj30+dTkYD7RhwO8Yoe0KTM0BqiyjiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PsdOJQVj65UrIi6GupO8sviPa+dH8FRQJqzvb9Mltyrpok/L
	ik5aNCefFmE7xBS5B7OPwLY3y+9Bp9wtabXOxeP9LdVdd1n0o9gW
X-Google-Smtp-Source: AGHT+IFPTrZJJODGh0jMxoOVDYXovFI4pMfCUXnEjxCK0Y2/4OhWbOTYwcnXfi+scuf9nv+VV+adFQ==
X-Received: by 2002:ac8:5a47:0:b0:462:a686:a42e with SMTP id d75a77b69052e-4634b4aea60mr3792921cf.3.1731439547763;
        Tue, 12 Nov 2024 11:25:47 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:2ba5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm78395581cf.86.2024.11.12.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 11:25:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 12 Nov 2024 14:25:37 -0500
Subject: [PATCH 2/2] xarray: extract helper from __xa_{insert,cmpxchg}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-xarray-insert-cmpxchg-v1-2-dc2bdd8c4136@gmail.com>
References: <20241112-xarray-insert-cmpxchg-v1-0-dc2bdd8c4136@gmail.com>
In-Reply-To: <20241112-xarray-insert-cmpxchg-v1-0-dc2bdd8c4136@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Reduce code duplication by extracting a static inline function. This
function is identical to __xa_cmpxchg with the exception that it does
not coerce zero entries to null on the return path.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/xarray.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 1b8305bffbff07adb80334fc83b5dc8e40ba2f50..2af86bede3c119060650ee8b891751531c6732e7 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1491,7 +1491,7 @@ static void *xas_result(struct xa_state *xas, void *curr)
 {
 	if (xas_error(xas))
 		curr = xas->xa_node;
-	return xa_zero_to_null(curr);
+	return curr;
 }
 
 /**
@@ -1568,7 +1568,7 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 			xas_clear_mark(&xas, XA_FREE_MARK);
 	} while (__xas_nomem(&xas, gfp));
 
-	return xas_result(&xas, curr);
+	return xas_result(&xas, xa_zero_to_null(curr));
 }
 EXPORT_SYMBOL(__xa_store);
 
@@ -1601,6 +1601,9 @@ void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL(xa_store);
 
+static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp);
+
 /**
  * __xa_cmpxchg() - Store this entry in the XArray.
  * @xa: XArray.
@@ -1619,6 +1622,13 @@ EXPORT_SYMBOL(xa_store);
  */
 void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 			void *old, void *entry, gfp_t gfp)
+{
+	return xa_zero_to_null(__xa_cmpxchg_raw(xa, index, old, entry, gfp));
+}
+EXPORT_SYMBOL(__xa_cmpxchg);
+
+static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp)
 {
 	XA_STATE(xas, xa, index);
 	void *curr;
@@ -1637,7 +1647,6 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 
 	return xas_result(&xas, curr);
 }
-EXPORT_SYMBOL(__xa_cmpxchg);
 
 /**
  * __xa_insert() - Store this entry in the XArray if no entry is present.
@@ -1657,26 +1666,16 @@ EXPORT_SYMBOL(__xa_cmpxchg);
  */
 int __xa_insert(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 {
-	XA_STATE(xas, xa, index);
 	void *curr;
+	int errno;
 
-	if (WARN_ON_ONCE(xa_is_advanced(entry)))
-		return -EINVAL;
 	if (!entry)
 		entry = XA_ZERO_ENTRY;
-
-	do {
-		curr = xas_load(&xas);
-		if (!curr) {
-			xas_store(&xas, entry);
-			if (xa_track_free(xa))
-				xas_clear_mark(&xas, XA_FREE_MARK);
-		} else {
-			xas_set_err(&xas, -EBUSY);
-		}
-	} while (__xas_nomem(&xas, gfp));
-
-	return xas_error(&xas);
+	curr = __xa_cmpxchg_raw(xa, index, NULL, entry, gfp);
+	errno = xa_err(curr);
+	if (errno)
+		return errno;
+	return (curr != NULL) ? -EBUSY : 0;
 }
 EXPORT_SYMBOL(__xa_insert);
 

-- 
2.47.0


