Return-Path: <linux-fsdevel+bounces-28523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A927F96B83A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD301C21FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4421CF5D6;
	Wed,  4 Sep 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng4+fX0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181C14658C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445350; cv=none; b=BWwrcFSrJfRzV+dzpSNdNIIkuuO05MumdI193I80ViSnioJWC2Uf32B9RzCLPibm4S3PqNsmBzIjgkC59/9EQDm/c4ch3lP6cDH5BlBIrl0SPYOrMDCATmRB4SpmQ0VyT26xPpB79LCVUST5nYWEorC4IXjt7GZEZk2X/rUg1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445350; c=relaxed/simple;
	bh=/U/EdH2xjh8wlswrDAib0TyvkUltBmXomIATwtZQzXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/cNEvYReKjKkThVUNrSa8gneAowhYXWRHe/6RcfhMePWimyMMJF3S5pX3I15Z3IF+vabRmUbGGhqu1TQAp+q1aeMuD2m+LUs9Oon72d9AdQFMfErME+QwVfmV9j6fzIpxR0KBgfZ4Q6cHTX3BRSnsG8W/gDQkRMqkhS1w1IiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng4+fX0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8C5C4CECA;
	Wed,  4 Sep 2024 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445350;
	bh=/U/EdH2xjh8wlswrDAib0TyvkUltBmXomIATwtZQzXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ng4+fX0s+8DqSHCR5z9UFG82jzXO8WDWHFkEdHUi9jQ+e6ydvcsUhDcnPzOss7yio
	 dLO4oWouJTmhgVH/3C4C6a9ju/RIGsmQiuDTcIqUwxTrzQqI/+RQ/777jJQpjGiLSB
	 A+/xoiff9qLDxM/465PUiXMat7Lr3YyFKz8b0fmKKk4fs39EMdvIj7ewjAbOl3w/x5
	 0Z0kfj9Ohvs2pLp/lty6ljCM24y3jD1VnWrq7IjWzVavn53N15ekpNeJIst9gJ62Jo
	 xR03wiqIsnNZsFzHH10rsWoMeZs7UJCsvQJ6xyckYgxCOKnTlfYjYFUa0f3lOK+gnM
	 17/RgHPMb0kEQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:15 +0200
Subject: [PATCH v3 10/17] slab: port KMEM_CACHE() to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-10-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/U/EdH2xjh8wlswrDAib0TyvkUltBmXomIATwtZQzXM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNl1oG5JPOf83ttis7ZNrFp7sPrsoz65lH2ntZ427
 Zh+zOjevI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJeBUxMvx76K26/FDZJaco
 2x96nI93rMk6O7OU9/2r7Sv46r59qw9nZNi5vaQsb84tv0tfMpQaD03zbGLs1VmtW9a8+9ut8H1
 MUxgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE() use struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 79d8c8bca4a4..d9c2ed5bc02f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -283,9 +283,12 @@ int kmem_cache_shrink(struct kmem_cache *s);
  * f.e. add ____cacheline_aligned_in_smp to the struct declaration
  * then the objects will be properly aligned in SMP configurations.
  */
-#define KMEM_CACHE(__struct, __flags)					\
-		kmem_cache_create(#__struct, sizeof(struct __struct),	\
-			__alignof__(struct __struct), (__flags), NULL)
+#define KMEM_CACHE(__struct, __flags)                                   \
+	__kmem_cache_create_args(#__struct, sizeof(struct __struct),    \
+			&(struct kmem_cache_args) {			\
+				.align	= __alignof__(struct __struct), \
+				.ctor	= NULL,                         \
+			}, (__flags))
 
 /*
  * To whitelist a single field for copying to/from usercopy, use this

-- 
2.45.2


