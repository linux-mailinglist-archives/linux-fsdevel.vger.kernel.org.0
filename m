Return-Path: <linux-fsdevel+bounces-19503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EAE8C6329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6B1284430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A55D8F0;
	Wed, 15 May 2024 08:56:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DE55C0A;
	Wed, 15 May 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763398; cv=none; b=dhR/eat4BxJJHNd6VIZVn2mS6zJzreq17JoJIrVJz1E7dWSb562H0ecSFx+5TAaLjBRfLi2FqUJmuJZoB1Y3kuNWSCbadHIM+lgRQlgQkf9QJJsaCjz50WMVXtasNeV6qXeTxi8Ypi8fKYhhIt9jnaK4NKj5FNIQqhxvfAtsRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763398; c=relaxed/simple;
	bh=MW58J8tzIIh/c4WNAblc1qU+1+yQAiNK/BNOu2yvhIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSgA+YzHCWVgGmR4RVWk0bfPRHBpZ/64UWwM5IqgW1bk16zOlBW4tpdQPNxfg1YZDsebMoW6fxBBhEgeUYk4l4ZoD9269XgZAc2vXJ1xcgCyBO5HX0jZynDZD/4kCSLjoAqpDjZLvyyJpSHC/UOG8wRc64ZsCtp/xSdgIYPeXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfRsm0s61z4f3kJr;
	Wed, 15 May 2024 16:56:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A786C1A12E8;
	Wed, 15 May 2024 16:56:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S10;
	Wed, 15 May 2024 16:56:33 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 06/12] cachefiles: add consistency check for copen/cread
Date: Wed, 15 May 2024 16:45:55 +0800
Message-Id: <20240515084601.3240503-7-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515084601.3240503-1-libaokun@huaweicloud.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1kXrWfCr4xWw4xJFy8uFg_yoW5XrWrpF
	WayFW3KryxuFs29r97JFyrGa4Fy3s2va9rWr9aqa4rAFnxWryFvr1UtryUZF15Z395JFsr
	J34rKF9rG34jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

This prevents malicious processes from completing random copen/cread
requests and crashing the system. Added checks are listed below:

  * Generic, copen can only complete open requests, and cread can only
    complete read requests.
  * For copen, ondemand_id must not be 0, because this indicates that the
    request has not been read by the daemon.
  * For cread, the object corresponding to fd and req should be the same.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index bb94ef6a6f61..898fab68332b 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 }
 
 static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
-					 unsigned long arg)
+					 unsigned long id)
 {
 	struct cachefiles_object *object = filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_req *req;
-	unsigned long id;
+	XA_STATE(xas, &cache->reqs, id);
 
 	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
 		return -EINVAL;
@@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
 
-	id = arg;
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
+	    req->object != object) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
 	trace_cachefiles_ondemand_cread(object, id);
 	complete(&req->done);
@@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	unsigned long id;
 	long size;
 	int ret;
+	XA_STATE(xas, &cache->reqs, 0);
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return -EOPNOTSUPP;
@@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	if (ret)
 		return ret;
 
-	req = xa_erase(&cache->reqs, id);
-	if (!req)
+	xa_lock(&cache->reqs);
+	xas.xa_index = id;
+	req = xas_load(&xas);
+	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
+	    !req->object->ondemand->ondemand_id) {
+		xa_unlock(&cache->reqs);
 		return -EINVAL;
+	}
+	xas_store(&xas, NULL);
+	xa_unlock(&cache->reqs);
 
 	/* fail OPEN request if copen format is invalid */
 	ret = kstrtol(psize, 0, &size);
-- 
2.39.2


