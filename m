Return-Path: <linux-fsdevel+bounces-17591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B48B001A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BDA1F24CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402014430A;
	Wed, 24 Apr 2024 03:48:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F613B78F;
	Wed, 24 Apr 2024 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930516; cv=none; b=smp98S6+4WSFLJRHPAN69WmZv20KElJAKbPZGYmFVIeinUfbDYLcI6wyaXUgc2Q2AhU2pTd6f2MUYM2NTFCTVg3XVfwYAx5Vlc4vwdoKNNdvL6wAPApTbWNuPBBCgj47sdB/FsucQHjZW0U5VxLrokkbcMUdbTEehpi4oPzLoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930516; c=relaxed/simple;
	bh=CJAsjwsABHJzCJkMGGnMV8RgnGwDDt/vfJyinn94n7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhg6Emxw2GHSgFGBMry9+q5pbgg5/GVheLT2Lrwe4Q0mw+N1jO5ShL5qhGuFzeg2nv965jGYEHABfjwzRwDLRnEDFWlWJ4NhJHgBEuN6z4uv7ZZulrF4BaRv0vp3Y6/FEBzZ6SpQq/tWNKhAvCGxgwDT1cW4dEUhI1cJ1vTGqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPQ1z32jFz4f3jcy;
	Wed, 24 Apr 2024 11:48:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EBDBF1A0175;
	Wed, 24 Apr 2024 11:48:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S6;
	Wed, 24 Apr 2024 11:48:30 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	zhujia.zj@bytedance.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 02/12] cachefiles: remove err_put_fd tag in cachefiles_ondemand_daemon_read()
Date: Wed, 24 Apr 2024 11:39:06 +0800
Message-Id: <20240424033916.2748488-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033916.2748488-1-libaokun@huaweicloud.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBELgShmKXE4Kw--.6143S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rury5GF17Zry5KFWDCFg_yoWDKFX_uF
	92vr1kXr4fCF1fXw42vr9YqFWqg3y8A3WFgws8GFy2ya95JrW3Jr4Dtry3Ary3Way8GF1q
	yrs5Z3WjqrnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbPkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7M4kE6xkIj40Ew7xC0wCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU1WlkUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

The err_put_fd tag is only used once, so remove it to make the code more
readable.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..fd49728d8bae 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
-		goto err_put_fd;
+		if (msg->opcode == CACHEFILES_OP_OPEN)
+			close_fd(((struct cachefiles_open *)msg->data)->fd);
+		goto error;
 	}
 
 	/* CLOSE request has no reply */
@@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	return n;
 
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
 	xa_erase(&cache->reqs, id);
 	req->error = ret;
-- 
2.39.2


