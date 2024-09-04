Return-Path: <linux-fsdevel+bounces-28526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A149796B83D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4984E1F2187E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B61CCB24;
	Wed,  4 Sep 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5mD2qJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E47433C8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445362; cv=none; b=eZx23esnmb18uzcUbsSZ3666s4A92Ok232x3zTcFuHmAXhSwOlmpRB8+4qjwJTbm1IqHRZwjOUvblMlH3XHd3q8D83LidGd9EfEWsSMRe2DcjnE7ObupUgP+T1vbYeX8/VNi2uyTAa132dBUTM63lLNYTgTrOHy9Fc0muxNn+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445362; c=relaxed/simple;
	bh=MhdNhrflcCHIlYw4WJW1aVuEAIulx0BazYlkdUtItAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNeDBEDKCWsDq93eGrsTeUIxmgmFZalUngW62hvmZfVc6JLvcv9X1J1PP+ZHtayrK07dcEyFYtnMb/0Oh04ym1ywiLOUpcsGRa2jtdIRSWNf4/ljS8WnNkdyFc3wSUeksVRUdoQB4aRsyLaYQLHlOmhchFFAtU32H0R/SZROFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5mD2qJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AE3C4CEC6;
	Wed,  4 Sep 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445362;
	bh=MhdNhrflcCHIlYw4WJW1aVuEAIulx0BazYlkdUtItAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y5mD2qJIqza8xUSaKCniqGT6GyvL5XOqqUqSen1zwDmgse53XxgDkB/IaZ6OsdYYY
	 HYib9vb7fhSa0D2q4dqzyj/8xC1BxXzCl4IA1dLaiKDhsnZ+025pBjcaYYIt56ewzj
	 ImyELYiUYXyDW0VEvr/BVWQpJGlLykJqI7wS3YOuAMzGJDRvoCGiHtUw2UzduwguzR
	 940m3KaGmUe9hQRpBz8qObWAKghEKOZLvzpTjFxNZAyCcxk3DlWHiHrlgM1BkhzusM
	 Ae1/8K1zvEazD1LkNYQfJJ85PlwjmAy3UoiuSb8kDBKXmGvelED+4HYUZVLErZA8O1
	 nniIQcrF4IcHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:18 +0200
Subject: [PATCH v3 13/17] file: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-13-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MhdNhrflcCHIlYw4WJW1aVuEAIulx0BazYlkdUtItAE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNn1OddWmEttJccRu4daT9PNdz/3OvbG1UZGZaKCS
 9Ckp24WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpcWD4n7e4eGv9V5XWu/md
 cffOJzq8mfAveRnXW84XuW2nErR+iDD8FV3y7dXBLL7PUvqJBmJsp52Yuva55RXdt1xyuPSwDXM
 hNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port filp_cache to struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 3ef558f27a1c..861c03608e83 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -511,9 +511,14 @@ EXPORT_SYMBOL(__fput_sync);
 
 void __init files_init(void)
 {
-	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
-				offsetof(struct file, f_freeptr),
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct file, f_freeptr),
+	};
+
+	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 

-- 
2.45.2


