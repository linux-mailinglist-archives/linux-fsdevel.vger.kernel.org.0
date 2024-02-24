Return-Path: <linux-fsdevel+bounces-12660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CCD862531
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 14:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7321282510
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BF42045;
	Sat, 24 Feb 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="utuU1c6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C153F9CB
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782409; cv=none; b=MHBbCMOQnJArJXXTbVRZy+ZojsvBWmSkBraHe5XV9EnXgQR7EDqtCdgiLBKG1xkB7oUxKD6xMv8Sxrl8tC+cNT0jnrCgqKlAPXWV5dZoA3X91gBsJ6wnX8n1OXXrNeH7tolSJXa7YHUWZThfEGuaXdsoLsbh/oM59SZPtLITkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782409; c=relaxed/simple;
	bh=wEI1keSTB58YCINVPgE87VQG//CNbqMp71bUnCErGDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZmERiApX8MUgf8cBt7Sn8WUf1Nl+477EAtrvr1kDqO8r/8p5jl1KoyMSRQEc7xeCH9ZHonf41z4e7QQ6R3bIbRbcSvSPql4onsM/Za5kVBR12LUILpfMTCSRsuFmoXp7/QxNCNxChgIcS7BtqRrC9/FG7wvOCBURYbsRmHVrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=utuU1c6U; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Br6iFuW0kTxVPcmpVKZZ0iaZD81OWqB/41eQJhlmiDw=;
	b=utuU1c6UzitcvGktspBVtM0IFt+lRIUMiicdJnCZ91ZNnUCSPQKbJVb2PJf8nW3juennEH
	Qoo2pH9sZXpe6IsAdd8I/1QwIShHVy9R5nCstdbKJBqDiTInwnoP6j3cyFV48h3LzbE3vv
	E6me+2xmcZKshvu+0T13vNzAodmBUao=
From: chengming.zhou@linux.dev
To: dsterba@suse.com,
	zhouchengming@bytedance.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] affs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:37 +0000
Message-Id: <20240224134637.829075-1-chengming.zhou@linux.dev>
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
 fs/affs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index 58b391446ae1..dcccad2a2b32 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -131,7 +131,7 @@ static int __init init_inodecache(void)
 	affs_inode_cachep = kmem_cache_create("affs_inode_cache",
 					     sizeof(struct affs_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (affs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


