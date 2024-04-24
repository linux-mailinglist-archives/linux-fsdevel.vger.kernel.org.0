Return-Path: <linux-fsdevel+bounces-17597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB618B0024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DEE28A8FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5C1465A5;
	Wed, 24 Apr 2024 03:48:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757F1448C7;
	Wed, 24 Apr 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930518; cv=none; b=bc9kloz+JoWED3kxP/F1e2Yri/bBofIhTkwjkzWAZaimH14T7wp8IzU/63CNylDy1Jh1XklkiF/2qm0T/UxPnEmEQ4MXk13Gqy5bp8nr8tvTp1VAxIw5LaaSYcDBCB8FWFtMoz0eVewk8IIhukRJmvozBqoM4RYuZgLifwiY0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930518; c=relaxed/simple;
	bh=RFZzPZeAQQRAwgBMGJ9qDgdkRj8av+xVjFOH01UuRXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWsnuRJ2R1D2BcLxAQNbXJNNKs9C73KWBLkOtpiugYGlbInaTDt4w+ED2Q7iSlo0C1VRavnZVBDmMBOlU8dUeuja6Di9DIJ5EDXZeD7nRX7R+T09Mv+X7LGwsEMknbgb0pM5RNyW1OVGCYqDsHUR8TEK4U7bIUGNpe1Fr0WVG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPQ201mBTz4f3lDW;
	Wed, 24 Apr 2024 11:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6EE621A0B30;
	Wed, 24 Apr 2024 11:48:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S11;
	Wed, 24 Apr 2024 11:48:33 +0800 (CST)
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
Subject: [PATCH 07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
Date: Wed, 24 Apr 2024 11:39:11 +0800
Message-Id: <20240424033916.2748488-8-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBELgShmKXE4Kw--.6143S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy5Zr18tFWUZw1UJFykGrg_yoWrGr4UpF
	WayFy7KryxuF1IgrZ7Aan5JrWFy34UuFnFgw1Yq34rAF90vryrZr1UtryfZFy5A343Krsx
	tw48Casrtw1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUUNBMtUUUUU==
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
by using ondemand_id to determine if fd has been released.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 898fab68332b..b5e6a851ef04 100644
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
@@ -185,6 +189,14 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		goto out;
 	}
 
+	info = req->object->ondemand;
+	spin_lock(&info->lock);
+	/* The anonymous fd was closed before copen ? */
+	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
+		spin_unlock(&info->lock);
+		req->error = -EBADFD;
+		goto out;
+	}
 	cookie = req->object->cookie;
 	cookie->object_size = size;
 	if (size)
@@ -194,6 +206,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
 	cachefiles_ondemand_set_object_open(req->object);
+	spin_unlock(&info->lock);
 	wake_up_all(&cache->daemon_pollwq);
 
 out:
@@ -596,6 +609,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
 		return -ENOMEM;
 
 	object->ondemand->object = object;
+	spin_lock_init(&object->ondemand->lock);
 	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
 	return 0;
 }
-- 
2.39.2


