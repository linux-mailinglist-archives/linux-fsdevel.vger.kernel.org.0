Return-Path: <linux-fsdevel+bounces-28689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9996D10B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B971C22EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862B195809;
	Thu,  5 Sep 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYkXOr7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CD1946C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523075; cv=none; b=qCgSgS8TK14F5K30YzcBnnBMSSaLzr2UiqQk4s+XF6HlZsoBj76bdLD0ZbMoiWakvD75gxXsVZkjwQm1xyjwBAJ89uUeMYZhlWhLFb+aZiGdTX2xItBNShRdJ4Wcw+az3tcRZuKEPGt5a9xrNBl63Q7VtgZOaHTjMjItQs7ILdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523075; c=relaxed/simple;
	bh=i+qfsAgWogADWXKIX6Ox+SamBJe0NAxzXt2tozWQS4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/n+EY552TcYuluq7oTE6G/TJXz+kHxBvIsuQ8YEngwNRQ2MaTX6ukzt5zI9Ka7Y1+2Kuxz26NIz3LS4HqNhP8fMS/GyaH6J22nxYUDlU8YQfxXZG8z/dKl7CG7SD7x+pcJSsTCSrE+izTRPsz8PddkXd/+iHSh7E5srfSYpmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYkXOr7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1F7C4AF09;
	Thu,  5 Sep 2024 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523075;
	bh=i+qfsAgWogADWXKIX6Ox+SamBJe0NAxzXt2tozWQS4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mYkXOr7xS4Z4mkCbI0v9BXGFcdBL//failIOy4yeoCV0iFHDbwEGNpZ5lUT96/2rM
	 FzuwjOabbXeq4zn+r6w1OuIBW8p/DnVBT7j6rukPS3OyCyC6AN3aWf49VSYSpI0VML
	 2UJwPFaz4/GJtXg4EXkPaof4zAh7spKsPz8nMcqahR/WVWwLm8l8FFx+JZP5Lh/HoQ
	 24x+U2rzZbmqfLeIKcCBfI3DZenROsICqGWZKO5nWoZIuP2vAt3nRO1ffbjo2ZXPYA
	 MR/QICqC6xGnAAmxZyKiOcMTZ+C0BBDqJXU9I69e63Eh/30cpfHZvxcjNz43rgheQ3
	 CgE25VlJ6vPAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:56 +0200
Subject: [PATCH v4 13/17] file: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-13-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i+qfsAgWogADWXKIX6Ox+SamBJe0NAxzXt2tozWQS4Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPFeMkFxdeKVKz5uTZv//oozC6j/eSV1QtD8yNSbF
 3dazFPS6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIawrDPzX+vdEdqptkD+78
 32r3fWVw3YzH7oZLj54zjVh1yzvumwnDP+UO2TWtxg38Rrvuz43yCxZ9w/I3XOsE35Oppb7yIhl
 /+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port filp_cache to struct kmem_cache_args.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


