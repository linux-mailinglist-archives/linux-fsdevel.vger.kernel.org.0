Return-Path: <linux-fsdevel+bounces-27393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFB961372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AD91C229AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020E1C9DC2;
	Tue, 27 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7XpTDGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D401C68A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774400; cv=none; b=CnBywr1jWDWofjTjQoiGJ3yHo5opoU6L2mTCLUEDfKkfdoC5yq55YbZAenTZUxV9Q+F1RvGPky2bBDP1zka7aTZRpXtjR/Pl0DD/My6JlxFJO5bl3TSNRyhB4X34pe10+nEG4lcGVDAMes+8PZgUBl69VruBBbxk/NLF/baoehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774400; c=relaxed/simple;
	bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxEtNQi5Nj9zn+i7+s9rfjwffHYX4R88kjVvB5oY58PDmWB+PwGS6xZKgsT944fPtHQwsN1k/ULv95ebB3l9ooc+4y3iip8Fy225o3mf18muLxYsEXNi/l/IByPOOQeyl5Gptvs9zcFPkiPijkKbAYJBuC/M7X2keZKolkm8OZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7XpTDGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2129C4FDE2;
	Tue, 27 Aug 2024 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774399;
	bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L7XpTDGgBL8T6Ryq+Mm+zh/RFrNd6ISBnEgZbezEGDKfSw0Hu0waaQEyNmPmbL7JH
	 gesM8omul5uT5JPNUKogfwtZGlmAl/+u6sBThJPJjUCah2dP0LcyyFJNf4GSq78WLU
	 1VF/vGp3nrPrtiNEMl3/BxBwZs6eEa9xr1FQhGu+2SkT4C0EfIJ+Aw1yF0B1s0/4lK
	 hBTeqjjqdwkjMlIZtD3yJ50RvUlWCturr7xam3hrxpuwp4HEzrPQ85vzzAOBeae4Ik
	 pBKX6OIis2zpR/qk7/ncNircBh+YUkl6AlrzeMyUWHY7fOyWpRdGXR8SPnkQSoUw8I
	 qu8N+Q7kwER2A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 27 Aug 2024 17:59:42 +0200
Subject: [PATCH v2 1/3] mm: remove unused root_cache argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-work-kmem_cache-rcu-v2-1-7bc9c90d5eef@kernel.org>
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
In-Reply-To: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=inSYKr8Tp4YUwStuHZTh2AxEw7grjX6tn9NgCfW/hs4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd/f674rHcioZtp3PKJ+07Nvv38q9nVynHlR6+WNmzy
 DN4k8r6OR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATOd3D8D/zk+MfqUt9y/L4
 /hRvOv3XWj7nOesJHY7aiE25+3gu/kphZDj/+IJAzK9lEbvnb+38OkUgZ+6aU1LKvVvc1rx4vWm
 f3XluAA==
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


