Return-Path: <linux-fsdevel+bounces-22728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C82091B716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BCE285B45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BC757FD;
	Fri, 28 Jun 2024 06:31:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868959147;
	Fri, 28 Jun 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556266; cv=none; b=q0NDNriwI8ISzfal3nEVVIAcnWH7oFbDxwTPZvu/xmLPogaGoyV5dXN9TrcWmIikCdKCvSBCt7hzhCZFPo9dwiTc4npFuQ2a1jN3N04ltSH2QOtPK1gLnJcYpdhmmr8zVPGMlLm3afKKevuc1NoKN0UL64ko2UpMBvXDxGeJiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556266; c=relaxed/simple;
	bh=EeUTOXX+ikXI0gUddRBFhNlS1L6H+hG/JmTeVZ9ra6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/z+SVrGLRL6ABQJ+q7/s9OwTUw4Bo6EWfftYjtEU6CHTE2qbg4z4tfR2D13BA8Avy6hmyqKUYtYL/zoSQGa+yTzCI3HjdiOfAgsTVZYeqZBeSmkc7fX8wGC0w+xzg0m1tW5AwUUDuI8PTkTlg5o0n9X0XN0w318nYjTbEUwvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9QYP465lz4f3l19;
	Fri, 28 Jun 2024 14:30:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CA1BB1A0572;
	Fri, 28 Jun 2024 14:31:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S7;
	Fri, 28 Jun 2024 14:31:01 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 3/9] cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
Date: Fri, 28 Jun 2024 14:29:24 +0800
Message-Id: <20240628062930.2467993-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXwIWfWH5mZZVAAg--.52859S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DXw1fuFWfXw13Zr45Awb_yoW7Ary3pF
	ZIvrWxtrW8W3y7Grs8Jw1UJrn3J3s8JanrXw18Xr1rAws5Zr1YqF1jyr1YvFy5CrWkArs2
	y3WUKFy7WryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbgdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAIBV1jkHrzbwAAsH

From: Baokun Li <libaokun1@huawei.com>

We got the following issue in our fault injection stress test:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_withdraw_cookie+0x4d9/0x600
Read of size 8 at addr ffff888118efc000 by task kworker/u78:0/109

CPU: 13 PID: 109 Comm: kworker/u78:0 Not tainted 6.8.0-dirty #566
Call Trace:
 <TASK>
 kasan_report+0x93/0xc0
 cachefiles_withdraw_cookie+0x4d9/0x600
 fscache_cookie_state_machine+0x5c8/0x1230
 fscache_cookie_worker+0x91/0x1c0
 process_one_work+0x7fa/0x1800
 [...]

Allocated by task 117:
 kmalloc_trace+0x1b3/0x3c0
 cachefiles_acquire_volume+0xf3/0x9c0
 fscache_create_volume_work+0x97/0x150
 process_one_work+0x7fa/0x1800
 [...]

Freed by task 120301:
 kfree+0xf1/0x2c0
 cachefiles_withdraw_cache+0x3fa/0x920
 cachefiles_put_unbind_pincount+0x1f6/0x250
 cachefiles_daemon_release+0x13b/0x290
 __fput+0x204/0xa00
 task_work_run+0x139/0x230
 do_exit+0x87a/0x29b0
 [...]
==================================================================

Following is the process that triggers the issue:

           p1                |             p2
------------------------------------------------------------
                              fscache_begin_lookup
                               fscache_begin_volume_access
                                fscache_cache_is_live(fscache_cache)
cachefiles_daemon_release
 cachefiles_put_unbind_pincount
  cachefiles_daemon_unbind
   cachefiles_withdraw_cache
    fscache_withdraw_cache
     fscache_set_cache_state(cache, FSCACHE_CACHE_IS_WITHDRAWN);
    cachefiles_withdraw_objects(cache)
    fscache_wait_for_objects(fscache)
      atomic_read(&fscache_cache->object_count) == 0
                              fscache_perform_lookup
                               cachefiles_lookup_cookie
                                cachefiles_alloc_object
                                 refcount_set(&object->ref, 1);
                                 object->volume = volume
                                 fscache_count_object(vcookie->cache);
                                  atomic_inc(&fscache_cache->object_count)
    cachefiles_withdraw_volumes
     cachefiles_withdraw_volume
      fscache_withdraw_volume
      __cachefiles_free_volume
       kfree(cachefiles_volume)
                              fscache_cookie_state_machine
                               cachefiles_withdraw_cookie
                                cache = object->volume->cache;
                                // cachefiles_volume UAF !!!

After setting FSCACHE_CACHE_IS_WITHDRAWN, wait for all the cookie lookups
to complete first, and then wait for fscache_cache->object_count == 0 to
avoid the cookie exiting after the volume has been freed and triggering
the above issue. Therefore call fscache_withdraw_volume() before calling
cachefiles_withdraw_objects().

This way, after setting FSCACHE_CACHE_IS_WITHDRAWN, only the following two
cases will occur:
1) fscache_begin_lookup fails in fscache_begin_volume_access().
2) fscache_withdraw_volume() will ensure that fscache_count_object() has
   been executed before calling fscache_wait_for_objects().

Fixes: fe2140e2f57f ("cachefiles: Implement volume support")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/cache.c  | 35 ++++++++++++++++++++++++++++++++++-
 fs/cachefiles/volume.c |  1 -
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 56ef519a36a0..9fb06dc16520 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -313,7 +313,39 @@ static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
 }
 
 /*
- * Withdraw volumes.
+ * Withdraw fscache volumes.
+ */
+static void cachefiles_withdraw_fscache_volumes(struct cachefiles_cache *cache)
+{
+	struct list_head *cur;
+	struct cachefiles_volume *volume;
+	struct fscache_volume *vcookie;
+
+	_enter("");
+retry:
+	spin_lock(&cache->object_list_lock);
+	list_for_each(cur, &cache->volumes) {
+		volume = list_entry(cur, struct cachefiles_volume, cache_link);
+
+		if (atomic_read(&volume->vcookie->n_accesses) == 0)
+			continue;
+
+		vcookie = fscache_try_get_volume(volume->vcookie,
+						 fscache_volume_get_withdraw);
+		if (vcookie) {
+			spin_unlock(&cache->object_list_lock);
+			fscache_withdraw_volume(vcookie);
+			fscache_put_volume(vcookie, fscache_volume_put_withdraw);
+			goto retry;
+		}
+	}
+	spin_unlock(&cache->object_list_lock);
+
+	_leave("");
+}
+
+/*
+ * Withdraw cachefiles volumes.
  */
 static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 {
@@ -381,6 +413,7 @@ void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	pr_info("File cache on %s unregistering\n", fscache->name);
 
 	fscache_withdraw_cache(fscache);
+	cachefiles_withdraw_fscache_volumes(cache);
 
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 89df0ba8ba5e..781aac4ef274 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -133,7 +133,6 @@ void cachefiles_free_volume(struct fscache_volume *vcookie)
 
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
 {
-	fscache_withdraw_volume(volume->vcookie);
 	cachefiles_set_volume_xattr(volume);
 	__cachefiles_free_volume(volume);
 }
-- 
2.39.2


