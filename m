Return-Path: <linux-fsdevel+bounces-27550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ADF962554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165D4283012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9716C6A0;
	Wed, 28 Aug 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHXYuuar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9916C68C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842627; cv=none; b=fQYXYA7R0KDo2fvYUaIINHY2Y6yOWj8dqcYUW2HHgO9jwbKpsJkm3Aw0PBV+FBPWodzFH5dzbEhauJbG66463sy6a39EQbwlZNt1qVgAnDfOVdA+YDBU5huOTN+03gYM7atr8A9wEe5VU+3WKkBhOQZP4wz94E+y5mBfap4pxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842627; c=relaxed/simple;
	bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRclCxu/LSdfyC2Ssa8d+1WW8j2cpOkCtYYXpU3jtEcxeiOW6KscVhF4lEhlwaGG96Y5GMF0lm+7tcwlmK35UHSAyitV1hl5sYO186N9DwNU8PFdQlXp5GQ1zwa2H5CedMtr5ZAa0Lx7OFkAwangkJW6usxfvWS6hLwXgv0xaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHXYuuar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330ABC4CAC3;
	Wed, 28 Aug 2024 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842626;
	bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mHXYuuarQlAW7U9rrFr5eCA110uyKzTvABuqujGMCI8x8yGsinQLw40LlPWMiBwWT
	 twonLhTSp5AybpY0QTkiMOkMefzwRzpN5AKh6kVgB8Xp1EAgmoSEmvOroL2g7oZ5/u
	 bJvL1hi00LZ6gbkIMMgeWgvILzDyFsval9GVKssNlWZsIs/QZ1fwtQ7AZ3Fig9dNkP
	 TB4AsIFcF66lIo5I8XdrRDfDuAShQJutYznIeFzHeCxso+8LxeKYVg45gTwHiIw4/W
	 W1OtJmHigfrW1tf95ru0+eAXyowjppXP32idXQB7hF327uJfteNV/1V1tlWH+Iy7+4
	 +wTbnjGWZOrfg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 28 Aug 2024 12:56:23 +0200
Subject: [PATCH v3 1/3] mm: remove unused root_cache argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-work-kmem_cache-rcu-v3-1-5460bc1f09f6@kernel.org>
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
In-Reply-To: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdZ6q50aTDtP2ozaXkW19l83cwCshturj1es4EEVn5O
 z+yPof1dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk+ynDH564nRNXnDbjOJ3w
 odOdY9vlgrJ9Qiff8Pys+PdB+8sD0+eMDLMefWv2/srP8eDUldm3ApMDzggEMG7nqP/wZQXX80m
 pLowA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

That argument is unused so remove it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..c8dd7e08c5f6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -204,8 +204,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 static struct kmem_cache *create_cache(const char *name,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
-		unsigned int usersize, void (*ctor)(void *),
-		struct kmem_cache *root_cache)
+		unsigned int usersize, void (*ctor)(void *))
 {
 	struct kmem_cache *s;
 	int err;
@@ -334,7 +333,7 @@ kmem_cache_create_usercopy(const char *name,
 
 	s = create_cache(cache_name, size,
 			 calculate_alignment(flags, align, size),
-			 flags, useroffset, usersize, ctor, NULL);
+			 flags, useroffset, usersize, ctor);
 	if (IS_ERR(s)) {
 		err = PTR_ERR(s);
 		kfree_const(cache_name);

-- 
2.45.2


