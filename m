Return-Path: <linux-fsdevel+bounces-12662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1480E86254B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16E9282778
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68515481B3;
	Sat, 24 Feb 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qyAZg+fA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62F43AC6
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782556; cv=none; b=lEzh5rB5cIymMrBvDIIEBBlGjRDrBDf5tnxE5yIdCksx+MArF4Ylst/OWlKumz7uSf4DK4KNwGrmKhPpVs3KzhvkKiOaHoTJcOdxHO1d/aIaHxnfeSwAhCRduXncTosaJK9XsxpVrVWnoIe8lLRcdLr+1rEu3lftDGZ7jjDFFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782556; c=relaxed/simple;
	bh=fPm8z6Vlgh2x4u6W8NT6ATvsB1HvmadAvSYFjjUjFtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvZ/auPPVcVwkVElyRsKMaZGLfVPderGJ700wk4fZEyJwTIHwGYDw4g6qsentNsPOfK3JMVA/CrtijdUnnHTiEmYs7U1bwFX5NXKZVIgcMWCQpkKIRPSxPViV2ubeSyKzz3IJ9NoeHj7MsvQeinmNEbiIHj2MClf6PC+XVLNcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qyAZg+fA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGy50kGciDjXed7i0CTgLTCv6G1RgEfykLkGxo6Hn9c=;
	b=qyAZg+fAG2npLmhJaRcfTYiHcbzw8usH4biZvxJPJBSfza8dmYkhp5TWjUFcX3bl12yAU4
	kEO+Fw117PJepxTO+JbBBIL1XDCkHTMG6AdiFaLLkzfeb8dniH6W8TKu2INT8S7f9EQSSx
	Ot8zncik7psFCaHjiuYhAvwYfHPoTTc=
From: chengming.zhou@linux.dev
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] isofs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:01 +0000
Message-Id: <20240224134901.829591-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/isofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 379c9edc907c..2a616a9f289d 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -93,7 +93,7 @@ static int __init init_inodecache(void)
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					sizeof(struct iso_inode_info),
 					0, (SLAB_RECLAIM_ACCOUNT|
-					SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					SLAB_ACCOUNT),
 					init_once);
 	if (!isofs_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


