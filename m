Return-Path: <linux-fsdevel+bounces-28403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862296A050
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9251AB2085C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217313D531;
	Tue,  3 Sep 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIA6dpiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C201420DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373377; cv=none; b=HLRSxQYSbk6KqRVw5+YLB7pL/QsPICV/4v2HiuJJeu8iK4ceKrZGiekFnMlcIM6nNmMtm3xbgRF4zX4843wNjto5WtYUPK7zQ1jydfzA+2PfMwK1Xbj54ywQjxbI5PMrEBXY+ktcmdwbd8I1/InBuIWPHjmv/te8FCIRTa9xhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373377; c=relaxed/simple;
	bh=3NCbIt7AK7tmjnKZtBo4rWvQELZGRKFxzNKzdNzEh+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVHjSZmym88+yz9H3wnVWWqAUitdl40N4hDL1dfay9k/BZ+LVQ8yv7UcAcpzKl+/XoDwFW+NqHqNdQwc3RFiIhFJ4RG7ZdybwTWvHRSg5/0LN3draNAolHJbM7rYHzESQRrTIc6Jntzr3/PLjB3Z1zj4ZhcvKyfXPq4u33cv6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIA6dpiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4DEC4CEC7;
	Tue,  3 Sep 2024 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373377;
	bh=3NCbIt7AK7tmjnKZtBo4rWvQELZGRKFxzNKzdNzEh+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NIA6dpiBbsE1OC9ubpMKp8jNcztrTDTatRxf5KWQbTjlNRL0XSoikHaYH8dpBad/t
	 iQBWjOPBYr7F2hJIqWh1KHWyMLwTc0gaC0RunIT+Q0oQpZeoyPB8GGLUdhOw8irtF1
	 qbFVjlRZyEH7VMZ5Hv9JDpnK4Juc44MJqJh+uEOCaA5uPgtMgFvRdNmL+tmDM2VBuY
	 Qxs7Y18c2eph5xk6SFRgiA6bR5BNORsx5hVl9nMzKNJSEjVWLvwjFklxT+weT11XLP
	 YK1t4W5byhRnzilQiwcL7dGKwUnB0ES3FHG7KVbxBVKZQeyzZdkJf/fnMPTDWCmOuf
	 lPTPbpjdMIbig==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:56 +0200
Subject: [PATCH v2 15/15] io_uring: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-15-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3NCbIt7AK7tmjnKZtBo4rWvQELZGRKFxzNKzdNzEh+o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl56jXCmdfbbN7sLDswvvtcefsxDlmOklJvBbS3OD1
 g+uz2oVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPp4Wb4X7suxbHyXNDclqBt
 H/cV3d8rIrLblltMhat0pdlFZwOnSYwMZx3/pP+Yc9oxtfXD0wXrz8w0cVhxRmBV4tHgZbnpa58
 wcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port req_cachep to struct kmem_cache_args.

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


