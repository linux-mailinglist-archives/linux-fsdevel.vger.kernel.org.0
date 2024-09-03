Return-Path: <linux-fsdevel+bounces-28398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190596A048
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E161C22F23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD97581B;
	Tue,  3 Sep 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKQpFLSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBC626CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373366; cv=none; b=EpllObYEIhVrZmn3tbe2G0wOY4PNOJbCXsQFREKG+L3ity0214xKlU/a1DnB8/txbE3YII+zbFEiYhkvG+OuD1knIQZLZS9VW7QbHmOep2JFBOPWzpWmMNuDrQl/4MxV+kC4CXqnko8U+shjgF80bqESEAREPm0crADTM2N35Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373366; c=relaxed/simple;
	bh=FR8F1qZbTb9zJTJgS+qNyN7qWMc09eHWUOjOyojvTgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ex4ZaEMCgn/wzaAByf81BDorkuG7FvlAD0+lf/P9NASOIaQpe+R82Ea5yqCayD0G/qdznByISYL0Thpc2I3dwU4sU8B4W7VEdi+LPCo0DLoKhRIH2bJI69n9lOwX5Hy0Do3X1SPJz3k3CYa+nx6wW7XJEyAneYqFyPzZgCixOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKQpFLSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F330C4CEC9;
	Tue,  3 Sep 2024 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373365;
	bh=FR8F1qZbTb9zJTJgS+qNyN7qWMc09eHWUOjOyojvTgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tKQpFLSfOXlziqcKn5RJLf9QiXJle0j40hcp8DAm2CZ1lv7nJtGL/phOIBav3PgIC
	 lzdqEzEIhBfOm9AkvzY8eEKDiqdCLYQRCba9BYeFluRTZu9ju2EG8PJs/3cRxadAJF
	 uPt/sGkTf1PyIhsEyxIoMg93KIak/gufudOUMg6FnObWCiaPK+LhWaxxIOE8PfkZEK
	 Yu1wpiF4B94Q70AdFf0K6xv1dfOL3lwkGQmfvouRoV1y4ToXCfTiz2pajuDM/1AXke
	 o2xlUd2qOCKEUaRipptLB6XVHbDhp/nQz88H6MzqsGe25WNixmOeeB16a0EZn0mwC+
	 9YFW6udqq4n3g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:51 +0200
Subject: [PATCH v2 10/15] slab: port KMEM_CACHE() to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-10-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FR8F1qZbTb9zJTJgS+qNyN7qWMc09eHWUOjOyojvTgI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl54TcJsj42vuU52ix9cm7n+RpX7vt0mi8vPZK59N9
 mXqMBMW6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI7xlGhlPX6wSmfa2LrRe9
 f1Cu5+Prxe6Pbt0KtAqYwrF0fbL/1QOMDBdW/dzeJ5JSJeH+/mJSfZTb+vkfVf5WLjYunOaiZRj
 wkxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make KMEM_CACHE() use struct kmem_cache_args.

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


