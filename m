Return-Path: <linux-fsdevel+bounces-28524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26A96B83B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BC91C21F2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAB1CC89A;
	Wed,  4 Sep 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VftW6h/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4B14658C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445354; cv=none; b=mR5N9UyoLMnoO/nhKbUiLgRBdJen+I94tz/aRxdA2G0x1SZSqmZkWY5PuccIKJIzo5BR2hIAgT0Ra2dJ2IOkhEU0QlF1U1zbTlYJO+n8LCugFqQj6/YHf8RGeqrFczfKF7rDNdIOpdMb5DBmqhOG95SReXe3Kksi4yhXmmVqBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445354; c=relaxed/simple;
	bh=82J8Bf3LCC365/T9k9A+CuN1jBmnIwSLQl/UyUW6uSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyGgR3PRXPPclvfvh0ieiLqPaYe3A5Sug3SRHdl8xAZzRO3j8PE+e7rac0f7RV1l7WEAqsLu5y5seu08JgAXznhl7mEq3sgy1BvnS1wmy9BfPlN8GDiSi2JE99DhiKSTF9jcqDHdTl+q6pECh//eLjaSawv7CbM9GAScPks6VcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VftW6h/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A98C4CEC8;
	Wed,  4 Sep 2024 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445354;
	bh=82J8Bf3LCC365/T9k9A+CuN1jBmnIwSLQl/UyUW6uSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VftW6h/4nP22SErP4ZUBode4BsdoX/rn/Oe2nrMJfHyJqoUNq9k9mqtieylVbFrTu
	 /Rb5LHSBVEgxWAM9gIifQg79JG+qOOzP/g8cwhWLXPwoc2WzvHbr5OZHPRpVixzW2l
	 AKWOunLfQ9TRuoKUIG3mnHOxjlmDxnng0QCl05BKY5qCy8L+XRktHVZKA3DXb3867Y
	 HA8zx3rGwx39UgKzj3y6Fg+yIsXcKDa9dbmI2AxaEY1xfFE/EvGXLNN+qYq/I6Hf11
	 PRy9tXEt6NHf3W0hoe9oDsg4S12TYYAPavNlvJK0s6nenxgW6T+/4NtAYHxdE4LVYl
	 9ZURfLw0qrAuQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:16 +0200
Subject: [PATCH v3 11/17] slab: port KMEM_CACHE_USERCOPY() to struct
 kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-11-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=brauner@kernel.org;
 h=from:subject:message-id; bh=82J8Bf3LCC365/T9k9A+CuN1jBmnIwSLQl/UyUW6uSk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNllvcm9/S2D0dtHnVb2ptY3cvLiTpxk4XvUvaP8Z
 0LVsbwTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5e5uRYUHpdQ8euaUhvDaS
 vbvYfR1nHDyetjnWZVWPwKNH2bXGwgz/w2R25VxKdOL6q/okJ5z7zd4zAb46QseLvVh5ah5X/Jn
 JCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE_USERCOPY() use struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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


