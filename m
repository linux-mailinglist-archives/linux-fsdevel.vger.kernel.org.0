Return-Path: <linux-fsdevel+bounces-12666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA26862575
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A4BB212BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266F4CDE5;
	Sat, 24 Feb 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PzBVaEnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF80487B5
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782818; cv=none; b=Bs2sgE6LQMtyrpXUSSVSxlytEjg/PNGhbp8St0g+sW6wHh5EKdFHyTu7HUIy81W07lZMKuiW7AT295RcXT94hmssn6nJwXmuU2PsAAA0sLDBhEn5m2WaZ6zf+0IEuylgq0ZlbLbPrX5uZfzPjKJmBynd/eY8imeCD3+RsThDxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782818; c=relaxed/simple;
	bh=U66kr6J4Xq7Aw3fsGVEcaok7KkVh3ioU+5ONvHiibDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qp+IYfydEaGhnQ+stl0Zai7EV0Ch0l7E14XkLLbL4RrV1QRItee4FelFBzmi4QStuT5gqOnyIe0CGLG4Y9LKtAoO11TjtD2PW5qk7RcaEYFEsSa9MKD107M1yEXZrP7caRZ8AmjU+xaEq3dcL/KFahl0g65oAw1QbciODB73bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PzBVaEnI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPQpelQkRwVwQd7AppThQpLrhs0U/sTtYtQXs0u9nsM=;
	b=PzBVaEnI9n6QdqNHZMs6nFD9E4j+sDjXp0ZDKGxn8rCv5UMzNExSQNkoD6PmiTUpfkx1O5
	Zk3Gw+dYaKx0fk6ljZpRznDYsVrvdByGWazuytqBnjahpgNTmc3R9BxL247tZeH1IpuIJp
	mpTENvMCPAQWqNHPP5gqGNWuYO/Y4Zk=
From: chengming.zhou@linux.dev
To: dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] zonefs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:53:29 +0000
Message-Id: <20240224135329.830543-1-chengming.zhou@linux.dev>
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
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 236a6d88306f..c6a124e8d565 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1422,7 +1422,7 @@ static int __init zonefs_init_inodecache(void)
 {
 	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
 			sizeof(struct zonefs_inode_info), 0,
-			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			NULL);
 	if (zonefs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


