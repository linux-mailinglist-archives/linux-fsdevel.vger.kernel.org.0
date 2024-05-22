Return-Path: <linux-fsdevel+bounces-19956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D58CB9FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5884028340F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5921EB2C;
	Wed, 22 May 2024 03:50:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8941C69;
	Wed, 22 May 2024 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349804; cv=none; b=G7rp/+wMMwe84wuP6uTVp7OgVIkQT/6FOyxSkhHwQVc/Oos5bkddzuxe2ya3KDe+PmX6drlabXe0PWBfRWvSnULc1cp2vpyu+gFluRAsR7vqeGcd6J3jNWhyZQMkkXBcB/g9AcOOER+yuhdU38Q+uSHVkI/jfkQaTsmEjpKG6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349804; c=relaxed/simple;
	bh=RqJTTyAPVsD0+plwfSa66uzpIimqz0eWP2LUaX2zOKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sg10Kha7KF+yLNGLdIAi5YlhT67tSUovS5OKSimJVRVAJeSggVqijjPp2L8abnr7hmN625iCkfxt6xYp/kHuVhZSYEw7eJdY/2RMygHQ7T84FGX9On6ySaHh51t882W7ZaMNzzya5eLt9OSRGdyGs11U/h9AP6I7m6kokswVB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vkckj663qz4f3jdH;
	Wed, 22 May 2024 11:49:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C40421A0181;
	Wed, 22 May 2024 11:49:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S11;
	Wed, 22 May 2024 11:49:58 +0800 (CST)
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
Subject: [PATCH v3 07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
Date: Wed, 22 May 2024 19:43:03 +0800
Message-Id: <20240522114308.2402121-8-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy5Zr18tFyxWr48WFyUJrb_yoWruFy7pF
	WakFy3KryxWF1IgrZ7JFs5JryrA348ZFnFgw1aq34rAr98ZryrZr1UtryxZFy5A34agrsx
	tw18Casrt34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRupB-UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

The following concurrency may cause a read request to fail to be completed
and result in a hung:

           t1             |             t2
---------------------------------------------------------
                            cachefiles_ondemand_copen
                              req = xa_erase(&cache->reqs, id)
// Anon fd is maliciously closed.
cachefiles_ondemand_fd_release
  xa_lock(&cache->reqs)
  cachefiles_ondemand_set_object_close(object)
  xa_unlock(&cache->reqs)
                              cachefiles_ondemand_set_object_open
                              // No one will ever close it again.
cachefiles_ondemand_daemon_read
  cachefiles_ondemand_select_req
  // Get a read req but its fd is already closed.
  // The daemon can't issue a cread ioctl with an closed fd, then hung.

So add spin_lock for cachefiles_ondemand_info to protect ondemand_id and
state, thus we can avoid the above problem in cachefiles_ondemand_copen()
by using ondemand_id to determine if fd has been closed.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7745b8abc3aa..45c8bed60538 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -55,6 +55,7 @@ struct cachefiles_ondemand_info {
 	int				ondemand_id;
 	enum cachefiles_object_state	state;
 	struct cachefiles_object	*object;
+	spinlock_t			lock;
 };
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 898fab68332b..d04ddc6576e3 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -16,13 +16,16 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct cachefiles_ondemand_info *info = object->ondemand;
-	int object_id = info->ondemand_id;
+	int object_id;
 	struct cachefiles_req *req;
 	XA_STATE(xas, &cache->reqs, 0);
 
 	xa_lock(&cache->reqs);
+	spin_lock(&info->lock);
+	object_id = info->ondemand_id;
 	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&info->lock);
 
 	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
 	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
@@ -127,6 +130,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 {
 	struct cachefiles_req *req;
 	struct fscache_cookie *cookie;
+	struct cachefiles_ondemand_info *info;
 	char *pid, *psize;
 	unsigned long id;
 	long size;
@@ -185,6 +189,33 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		goto out;
 	}
 
+	info = req->object->ondemand;
+	spin_lock(&info->lock);
+	/*
+	 * The anonymous fd was closed before copen ? Fail the request.
+	 *
+	 *             t1             |             t2
+	 * ---------------------------------------------------------
+	 *                             cachefiles_ondemand_copen
+	 *                             req = xa_erase(&cache->reqs, id)
+	 * // Anon fd is maliciously closed.
+	 * cachefiles_ondemand_fd_release
+	 * xa_lock(&cache->reqs)
+	 * cachefiles_ondemand_set_object_close(object)
+	 * xa_unlock(&cache->reqs)
+	 *                             cachefiles_ondemand_set_object_open
+	 *                             // No one will ever close it again.
+	 * cachefiles_ondemand_daemon_read
+	 * cachefiles_ondemand_select_req
+	 *
+	 * Get a read req but its fd is already closed. The daemon can't
+	 * issue a cread ioctl with an closed fd, then hung.
+	 */
+	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
+		spin_unlock(&info->lock);
+		req->error = -EBADFD;
+		goto out;
+	}
 	cookie = req->object->cookie;
 	cookie->object_size = size;
 	if (size)
@@ -194,6 +225,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
 	cachefiles_ondemand_set_object_open(req->object);
+	spin_unlock(&info->lock);
 	wake_up_all(&cache->daemon_pollwq);
 
 out:
@@ -596,6 +628,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
 		return -ENOMEM;
 
 	object->ondemand->object = object;
+	spin_lock_init(&object->ondemand->lock);
 	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
 	return 0;
 }
-- 
2.39.2


