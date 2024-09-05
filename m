Return-Path: <linux-fsdevel+bounces-28680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B796D0FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4231F264DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1C194AD1;
	Thu,  5 Sep 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZmgX8C5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4751940A1
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523040; cv=none; b=I2Hg7ko7D2ZttYjQ/YebKdNLhCIEYUZ+/XX+OtnV8AUkzElgSFO47Rpe/MMYvtdIfRVZmWiTWcZYchCXbHCOpFiWgRv5Maxa6Hdqf0sm21T+G1A6ks5YS2+GfwMr/31VUL6gl/e7ZG2dKPlNlIlJVpjxjE9XqGF41nKBlOpq62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523040; c=relaxed/simple;
	bh=yFwPV9RImMNE3Jd/xX3WyJKu7K+3lEbT+HKSODA016Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrQ7hI8h8wgKywWx6R4YLllNw8FUQ0as0kFf+O9gnxKd50J/gDFGx9S02/dy97xSoyTyA7iUiIsyiE7JWwtbwRNf1eqCjPc3Q3fLXWUYQRPglQ2SeYXI98cW83Z9MO2V6N/N261bup321235M55D8uQx8p/i+bdNKvjltpLzRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZmgX8C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F658C4CEC4;
	Thu,  5 Sep 2024 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523039;
	bh=yFwPV9RImMNE3Jd/xX3WyJKu7K+3lEbT+HKSODA016Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pZmgX8C5yhojHGzSpwIYVN1O8utd8eTeLfdJ+KCv8Vq2ZO5b52/05Pm9H3KqyU9Sq
	 KvxnTBeWV9EhLSJMPdcmuc8CcLt8l1dDGMfDb7IKtrjwwFUfYWiPmPCaC3zwNGQLVv
	 1UychvUaOYnSlbFnpF0RBzzuiI6FDN4e2JsiHn4W6UvPYT1xRC7ZYyltk5yrG9OmPl
	 XskKQWIaXsjwZ4rxWuBORBXonKDQC7cmwAb2l7a61JT1WYOE0KwjZKZh7N7HpgXgWb
	 4nTvRSeFZgNbpVuX7XD3mTpt4gLCfZGcoTm1paEOrUvgjg0Ve5wFXFHy0idr+l5LP4
	 5uSsgI5j5WxUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:47 +0200
Subject: [PATCH v4 04/17] slab: port kmem_cache_create_rcu() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-4-ed45d5380679@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
In-Reply-To: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yFwPV9RImMNE3Jd/xX3WyJKu7K+3lEbT+HKSODA016Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPEqyfVkZ/Lj+7FDdPbsN+wabw4veVAVw1Dp/L6yh
 1tta6p2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETebWZkWJdyJGSWRv2/JNut
 Rf8X2y3aqBSctErO9RKXB7feo4PxlxgZrp64x/5lh85xJQ5hG0E+iSWFzVsOqEx4/f12rLuN5oX
 5XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create_rcu() to struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ac0832dac01e..da62ed30f95d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -481,9 +481,13 @@ struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
 					 unsigned int freeptr_offset,
 					 slab_flags_t flags)
 {
-	return do_kmem_cache_create_usercopy(name, size, freeptr_offset, 0,
-					     flags | SLAB_TYPESAFE_BY_RCU, 0, 0,
-					     NULL);
+	struct kmem_cache_args kmem_args = {
+		.freeptr_offset		= freeptr_offset,
+		.use_freeptr_offset	= true,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args,
+					flags | SLAB_TYPESAFE_BY_RCU);
 }
 EXPORT_SYMBOL(kmem_cache_create_rcu);
 

-- 
2.45.2


