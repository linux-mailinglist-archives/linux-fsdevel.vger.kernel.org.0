Return-Path: <linux-fsdevel+bounces-28389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FD96A03F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1F1C22F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C914AEE5;
	Tue,  3 Sep 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7WjnjG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E736F315
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373345; cv=none; b=XgGJdaay4bwvWj27kWV8mgfMdFvmEJ2qwocLRS9tSkpHSpmvF6ZrCdEPq0c2Bk751dXSAHQ/HRLik6Pb29wy5XfWVAYUmtER50ciPltGmfpF3TxN8j2gzRRo1XBbFwOMchhJ8K2mE65NtpMV8HymHxvh2p3GIGzXUAmkUinZGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373345; c=relaxed/simple;
	bh=aQiIKK7aypFaSSN7lgRJDvRI7/Ip5hPvhqIbIRsPc90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMtsxvdnndDLfZff0ypP9IzQsj1VuEjfb6sGMB1QNyWUROF//UXV8uLrr2ATtcLHCrA/r4bATvIhlQeMKOGP/Wb21Bf778sHHw4MzJdSIhM0IEi7t90hqujLnUT7Wrsd57WUKOYyKTc7d4QIXbmI1VVVS/JEAMwR0SFQH3XZoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7WjnjG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA9EC4CEC8;
	Tue,  3 Sep 2024 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373345;
	bh=aQiIKK7aypFaSSN7lgRJDvRI7/Ip5hPvhqIbIRsPc90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j7WjnjG6DU4tzE1BuBWHzDqxuj8IxdxSm8g0U15AEnbMBM8wttB1Y3G09ev5GLai5
	 W2xu715Lw9oCHM2xxc3zKsxgwCJlvcnbklI8orrNlXFMpmDE+/+EIkXe2HdsgB2AUw
	 7w5NIffNI05CLpefEIII4pV9TAVZt8+LH7bvSgW2lsoZFWpV/vjxSr8pH3VqHi15qD
	 cQeUJebohkTHwEIHi5xUjNX8zFobHPdwFYu42KnOQBePw5MBtvUmDOOV8oi62Mo/Vk
	 oziANUL3cw4Sh1Czk/9uSWtD9W51cHqOWLNO+FLe98JB/bZZtu4tHx/HPWN5Wnm3XP
	 LAQw2zTFSQMBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:42 +0200
Subject: [PATCH v2 01/15] sl*b:
 s/__kmem_cache_create/do_kmem_cache_create/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-1-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aQiIKK7aypFaSSN7lgRJDvRI7/Ip5hPvhqIbIRsPc90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl55994PxvuwGq4XPVzybc53nc+GFXI8vs3/9VhDNM
 exdODGMt6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidu8Z/mn7pr9d4vP/0D4O
 ibK9/vqX9kjKvtg1wTfqWyoXZ/XLma6MDPcTjRjfBf0+qqr9bb7gudfOv1ayefxlvdyk9OXzX5W
 HSWwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Free up reusing the double-underscore variant for follow-up patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab.h        | 2 +-
 mm/slab_common.c | 4 ++--
 mm/slub.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index a6051385186e..684bb48c4f39 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -424,7 +424,7 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
-int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
+int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
 void __init kmem_cache_init(void);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 95db3702f8d6..91e0e36e4379 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -234,7 +234,7 @@ static struct kmem_cache *create_cache(const char *name,
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 #endif
-	err = __kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
 
@@ -778,7 +778,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	s->usersize = usersize;
 #endif
 
-	err = __kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, flags);
 
 	if (err)
 		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
diff --git a/mm/slub.c b/mm/slub.c
index 9aa5da1e8e27..23d9d783ff26 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5902,7 +5902,7 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 	return s;
 }
 
-int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
+int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 {
 	int err;
 

-- 
2.45.2


