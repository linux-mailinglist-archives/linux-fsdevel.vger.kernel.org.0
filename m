Return-Path: <linux-fsdevel+bounces-12664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C086256E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 14:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5AFB218CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A64D595;
	Sat, 24 Feb 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="srsVKoD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD64D110
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782797; cv=none; b=OwYCwSX7NfCPuXNyQi5k8LWdF71JGtB/r03hbvEqdE+Dmp5dKSPlHcpI0tfIoGN/HIxLrAgbe1duPakQT4I+fzd0rK9vQ06SAMqZaabOSqf6Httod1gPrmoarFFfCP4q/8pRwUrCh17ChBHRYUqSHSA34am1FGnQfxdd4h4oDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782797; c=relaxed/simple;
	bh=sivTcfzLhFZkwZlOTsC3lHbm768qCUZIbY8z3vlZwTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJ51n23Z41PmmB+VB7xiYBB7/bLpsNPrAUhRDU+9+vEGBWD1EG+xPcDjwmdgP3QNFeY+aZ9sxEZWzSbKi62dWnSQjWJv2DB79ynoBcfipYQ9fDQVngbE+Qegydh+HPv625agaV3VQQ1ILqX4MLA5kwJDrMLwIooPl6rVUECyM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=srsVKoD/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KRb/IWjZidBlXI4vEoItSPrkCj2iPSdaThL3vIkkvgQ=;
	b=srsVKoD/VKyiQQH3Td8783bsDahf1AVkUeGQqTLg9Lj1A8YCJbkIGVUqsln40nIrPwUrua
	d1WUliLTJnYNyboPFIS14vCzOQKYsZwDz7cAUw5pWv3hIENVRibqAXLG/x+q0+S1y5OK26
	Nm/Hdri9poOTF7HWSc4Q3rkpBCfXa3Q=
From: chengming.zhou@linux.dev
To: hdegoede@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] vboxsf: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:53:05 +0000
Message-Id: <20240224135305.830443-1-chengming.zhou@linux.dev>
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
 fs/vboxsf/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 1fb8f4df60cb..cabe8ac4fefc 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -339,8 +339,7 @@ static int vboxsf_setup(void)
 	vboxsf_inode_cachep =
 		kmem_cache_create("vboxsf_inode_cache",
 				  sizeof(struct vboxsf_inode), 0,
-				  (SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD |
-				   SLAB_ACCOUNT),
+				  SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 				  vboxsf_inode_init_once);
 	if (!vboxsf_inode_cachep) {
 		err = -ENOMEM;
-- 
2.40.1


