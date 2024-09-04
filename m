Return-Path: <linux-fsdevel+bounces-28518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE196B835
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B085E1F215FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF61CF5D7;
	Wed,  4 Sep 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/f4yXXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DD1CC89A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445331; cv=none; b=FusCQaA5rdM3qcW3myLPMiiEdjGGn4z1Fccv5gkP0VgNTxRs7mRxe+Xppmie8q7DeFk4KDwa2HRQGhT3p0X1eM9slYyVhZaPRWdPQcII6ohAgO8AyRtLuel8RiKK01AGDWr9hW8VoGnfoG6zPbhZZ2U7JPzXmBOytrhzGW+T+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445331; c=relaxed/simple;
	bh=t6CjazxfkyG3rY4OORK6/WvzeiMUzf2dJjeC2mkHY5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHE+SpEbyFxKrlhekgV1UNWM0D3yh65mp8uzOae++4Xc5uz/NGwSFtXse3x8C3CQx8qBWTabXGuveqOtX6u0ioyl/c9AtPAu0YFPAboR6OeWEeEkbO7zmSVwZn1yjLM3ZvzXP2RtLaJI/Wn0O27/7EuzxyzB/rLhoInFEvsdeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/f4yXXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5044C4CEC2;
	Wed,  4 Sep 2024 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445331;
	bh=t6CjazxfkyG3rY4OORK6/WvzeiMUzf2dJjeC2mkHY5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/f4yXXqFQ5vSEkfdHwtQuqANWB/P0R8vg2RYv1QfjxFiwI6B4jTz9W2XYox8RnVm
	 Z6ewd99jp6fgqA4fe65Io6FD7qgiSiDkoiTXmBf6KQAdODA+gNEda0V4kozGjVNG7j
	 XrcNweG+qb00+grRhqri5Ak6yVTy0XlpAlwXoabLBVfBSMQHAppX4uZyDY5mTfdNFn
	 aOQmTTDICjs94eG6xNLw+AOQMGtqXvxNW+oE2qg9v1HRbwngViSuLWVKB+Zr0I6gR4
	 nO0V1WPSENxkaRMm12hnLq0+uJCw9w2ian4gZdTotnfz2H2FKSVqYzFbGgp8mo2iAf
	 0mxWu5/Dzs2eg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:10 +0200
Subject: [PATCH v3 05/17] slab: port kmem_cache_create_usercopy() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-5-05db2179a8c2@kernel.org>
References: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
In-Reply-To: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t6CjazxfkyG3rY4OORK6/WvzeiMUzf2dJjeC2mkHY5Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNmV7rWmntNfIcDgadi0xuMKx5YKclqElxXs2/fBb
 sYCi6UHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC8oOR4a3j0sVZ1x/0LDOz
 P6LpWNzw3OpOs+thuVsvmm91hH3ffZGRYYHB01rVNsnGvdNNOYtfLrpoyTK/SMLTavONcpd8T/8
 X7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port kmem_cache_create_usercopy() to struct kmem_cache_args and remove
the now unused do_kmem_cache_create_usercopy() helper.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index da62ed30f95d..16c36a946135 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -351,26 +351,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 }
 EXPORT_SYMBOL(__kmem_cache_create_args);
 
-static struct kmem_cache *
-do_kmem_cache_create_usercopy(const char *name,
-                 unsigned int size, unsigned int freeptr_offset,
-                 unsigned int align, slab_flags_t flags,
-                 unsigned int useroffset, unsigned int usersize,
-                 void (*ctor)(void *))
-{
-	struct kmem_cache_args kmem_args = {
-		.align			= align,
-		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
-		.freeptr_offset		= freeptr_offset,
-		.useroffset		= useroffset,
-		.usersize		= usersize,
-		.ctor			= ctor,
-	};
-
-	return __kmem_cache_create_args(name, size, &kmem_args, flags);
-}
-
-
 /**
  * kmem_cache_create_usercopy - Create a cache with a region suitable
  * for copying to userspace
@@ -405,8 +385,14 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
 			   unsigned int useroffset, unsigned int usersize,
 			   void (*ctor)(void *))
 {
-	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
-					     useroffset, usersize, ctor);
+	struct kmem_cache_args kmem_args = {
+		.align		= align,
+		.ctor		= ctor,
+		.useroffset	= useroffset,
+		.usersize	= usersize,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
 }
 EXPORT_SYMBOL(kmem_cache_create_usercopy);
 

-- 
2.45.2


