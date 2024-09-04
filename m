Return-Path: <linux-fsdevel+bounces-28531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F300D96B846
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1898287247
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E01CF7BD;
	Wed,  4 Sep 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrPSuG+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58611CF7B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445378; cv=none; b=mnOC3e892PKO8hRBJeokNZpq/Jyi43w3oWJ75KxWY5tFRMyJQV5WugNXcg3IXQgYjEoxV6PEMlF55yG4e7JP4cYiBN9ToO5oJ7rwWCrGr/NOMGthir+oDITW1IJ2ir/HjM8ucGXfuaFcORafyzxRCa4rpZHYPLKJgZsW+QByelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445378; c=relaxed/simple;
	bh=fyePhUeJgoPiuTJClIk+6OpwiFIuMNlpyvRSeOBVO/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpHQHLs0A6D1Ls5FF5NbSBQGysK3Uk51uG/1cUq28T5KjEHClYOn1BRWaZSrwx+8f9Bmy4MxbYQtNO/N4NdI4BxE4g4EVDdkfBWfi1/gUQnP594H1o+E7IXmiZDkuvR0kUnB1lF1S1bURqBgetHkj3YAjDAxpaCLeArUvrezSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrPSuG+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1E4C4CEC2;
	Wed,  4 Sep 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445378;
	bh=fyePhUeJgoPiuTJClIk+6OpwiFIuMNlpyvRSeOBVO/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lrPSuG+iQHm9RvIy0WSzIC2PaCeqRuJifT/frNLorTp/Y+si8I22TATwm54EoN0D/
	 wF2P4/AMPbEdKK8eAUsdGJnFov14GBDKvKX233goB9TE5E+/nTOFTrtxZydchwpjK1
	 +0ROLJQWn2g/nElnAFEGmPaXKWER5LFg02TTLWE8FQYKvkqBiIj0JdJHaHPRCsfNeW
	 z/GvHBdEK/9S6wPDwW2H85vXa1ChSZCNWtDyoMoRQhfHefYlRAxgclb4rvVPxQlxEL
	 HaG1ACOdWYQDoDWn9c4EU632lFH62HODflmben8lJ2I1zQb7trHaHaGJlfVK93r/hW
	 5MIvW4MbSGP9w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:22 +0200
Subject: [PATCH v3 17/17] io_uring: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-17-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fyePhUeJgoPiuTJClIk+6OpwiFIuMNlpyvRSeOBVO/I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm954/H99mFK48VyBu05f33uZhWXFSRZ9Oa3Nj54
 xK3WOHZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInU8jH8jxfh7RF5IrdmtcJi
 O4uEiafyNqqu2X9kyg62j7sr95lqdjH8D1pQYvVGdIZVkvf/uVXinWfkBDd91tHiPr1kRtkmwQZ
 rLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port req_cachep to struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/io_uring.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3942db160f18..d9d721d1424e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3638,6 +3638,11 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 
 static int __init io_uring_init(void)
 {
+	struct kmem_cache_args kmem_args = {
+		.useroffset = offsetof(struct io_kiocb, cmd.data),
+		.usersize = sizeof_field(struct io_kiocb, cmd.data),
+	};
+
 #define __BUILD_BUG_VERIFY_OFFSET_SIZE(stype, eoffset, esize, ename) do { \
 	BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
 	BUILD_BUG_ON(sizeof_field(stype, ename) != esize); \
@@ -3722,12 +3727,9 @@ static int __init io_uring_init(void)
 	 * range, and HARDENED_USERCOPY will complain if we haven't
 	 * correctly annotated this range.
 	 */
-	req_cachep = kmem_cache_create_usercopy("io_kiocb",
-				sizeof(struct io_kiocb), 0,
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
-				offsetof(struct io_kiocb, cmd.data),
-				sizeof_field(struct io_kiocb, cmd.data), NULL);
+	req_cachep = kmem_cache_create("io_kiocb", sizeof(struct io_kiocb), &kmem_args,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT |
+				SLAB_TYPESAFE_BY_RCU);
 	io_buf_cachep = KMEM_CACHE(io_buffer,
 					  SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 

-- 
2.45.2


