Return-Path: <linux-fsdevel+bounces-28399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A796A049
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D13B2411E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F013D281;
	Tue,  3 Sep 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elIp/6pQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D51E502
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373368; cv=none; b=IYfHc0sUBg7c0JZFK1snfICZl6Gav7A78shVTHkm6Spt83bte7kYThSnTiqVCL2CIbBB+clgyoc1nCDUXM9MLWFDK7Zz84tHOBn36yqeq8gs+0AFR7lP2qWK6ojrPP+GKvSxcxvtI2L/QW58S672XMF89DzcIwlGgfzExcUIJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373368; c=relaxed/simple;
	bh=PVJGD880SWN2QXXzV8G7Km5Za31W7UeV1k1iq+DB/nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKbyj7bYTgniX7AHh61N7RnLbyO1RGZn1XHjPcjoYsxJD5KRvL3javJnluvlaZaaXu3x/1X7BzDB35Mq55s/McEPIpue3SdusYGg4adFRTDCmtjbhtApgwr10nfh0PUbfyvzMRhWrSRuJ7q4OEwro2ohjBgesPe5ei3/FR17jmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elIp/6pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA01C4CEC8;
	Tue,  3 Sep 2024 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373368;
	bh=PVJGD880SWN2QXXzV8G7Km5Za31W7UeV1k1iq+DB/nU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=elIp/6pQ1ITB14KbYVhhnY4NhT7QtlcVxjp9pClky3Odf1lSc8k/GlrrMjwudI3ax
	 yZwcsK22IVTe+MaIv2LhcWKwuVfpxK1mrAd2BVCIrbu18yRcqDhU7IjFWBVk8AT4hG
	 jYl22Y4aKeWbX368tp3tfoGRyKmfgpMXin1THiKLPKrzMgUj3BfM7eaCQRVfaOOIPC
	 nITQ/g5+8+rj/moMX0B22xFmMvIGax8lLdryc6+GYcw+Bp2TAAL6OjI5THqFTzk93u
	 D5aRUGE0ebxI68nZRNOO0yy94hDdzj+N9/pAeYFNqt9Gul75ONyfUQaNPfPZyF4DNg
	 HPbjixYQEaTxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:52 +0200
Subject: [PATCH v2 11/15] slab: port KMEM_CACHE_USERCOPY() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-11-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PVJGD880SWN2QXXzV8G7Km5Za31W7UeV1k1iq+DB/nU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl55jWn9i6mW97Oe7fSc2ZE0PfnPFdUX6r3ju02dmP
 ovy4Eks7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIfzaGvyJSqTpK1dVflng/
 qYvIlF9x9mrjg4hrO3mTTmZE1UYddGD4w9NxXOtzZHCaj+Lnvbu38c7Iebb4xaWMg4pdJwxuROh
 q8AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE_USERCOPY() use struct kmem_cache_args.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d9c2ed5bc02f..aced16a08700 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -294,12 +294,14 @@ int kmem_cache_shrink(struct kmem_cache *s);
  * To whitelist a single field for copying to/from usercopy, use this
  * macro instead for KMEM_CACHE() above.
  */
-#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)			\
-		kmem_cache_create_usercopy(#__struct,			\
-			sizeof(struct __struct),			\
-			__alignof__(struct __struct), (__flags),	\
-			offsetof(struct __struct, __field),		\
-			sizeof_field(struct __struct, __field), NULL)
+#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)						\
+	__kmem_cache_create_args(#__struct, sizeof(struct __struct),				\
+			&(struct kmem_cache_args) {						\
+				.align		= __alignof__(struct __struct),			\
+				.useroffset	= offsetof(struct __struct, __field),		\
+				.usersize	= sizeof_field(struct __struct, __field),	\
+				.ctor		= NULL,						\
+			}, (__flags))
 
 /*
  * Common kmalloc functions provided by all allocators

-- 
2.45.2


