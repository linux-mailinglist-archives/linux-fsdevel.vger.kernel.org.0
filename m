Return-Path: <linux-fsdevel+bounces-19968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A637F8CBA2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2382824A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8477112;
	Wed, 22 May 2024 04:06:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D357CA2;
	Wed, 22 May 2024 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716350762; cv=none; b=iCsTtOFWLFLi/SGEp1ORDtQlGoqruU0psubBwdF1QoBHsO3xYhIgsWFez+ou0IsDc0qB/Gga4PX211pA2CM6FWQuolFlz0QFJNAda3Uy99enXBYY2jwdeEmSN6jORQMRFdDQBdBPzqiCicYxkOOmIVsBSUy9QhFmx3I42E+nG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716350762; c=relaxed/simple;
	bh=edvS4bKxJUWjQ7MulQe/BYfvUB8ndigIWei52J2WxqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWQadpZfdD6/ttJSf6LjYETntXzuy9XeY9PUoIhsXSNe+0MzJxEmTSxJyhIptUWz/EuoZtqAflb949r+bA78g6MOisBXLxhY1AjZgpFh3Ydvrl+CaX4bqIqHecc+dg99eMHNMRG/w8AH/BJbdtYl8DzaNOYDK/k94tjfT2r4Jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vkd5861dvz4f3jd1;
	Wed, 22 May 2024 12:05:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C1BAE1A1537;
	Wed, 22 May 2024 12:05:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4ib01ms1VYNQ--.24441S6;
	Wed, 22 May 2024 12:05:57 +0800 (CST)
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
Subject: [PATCH RESEND 2/5] cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
Date: Wed, 22 May 2024 19:59:08 +0800
Message-Id: <20240522115911.2403021-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522115911.2403021-1-libaokun@huaweicloud.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4ib01ms1VYNQ--.24441S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1UXrW3Aw1DZr13ZF4Utwb_yoW7tFyxpa
	9IvryxtrW8u3yUGw45Xw47Xr93X3s8Ja1kWw18Gr18Cw4rZr1YqF1jkw1rZFy3C3ykArZ2
	k3WUKryUWw1jyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiUDGUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

We got the following issue in our fault injection stress test:

==================================================================
BUG: KASAN: slab-use-after-free in fscache_withdraw_volume+0x2e1/0x370
Read of size 4 at addr ffff88810680be08 by task ondemand-04-dae/5798

CPU: 0 PID: 5798 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #565
Call Trace:
 kasan_check_range+0xf6/0x1b0
 fscache_withdraw_volume+0x2e1/0x370
 cachefiles_withdraw_volume+0x31/0x50
 cachefiles_withdraw_cache+0x3ad/0x900
 cachefiles_put_unbind_pincount+0x1f6/0x250
 cachefiles_daemon_release+0x13b/0x290
 __fput+0x204/0xa00
 task_work_run+0x139/0x230

Allocated by task 5820:
 __kmalloc+0x1df/0x4b0
 fscache_alloc_volume+0x70/0x600
 __fscache_acquire_volume+0x1c/0x610
 erofs_fscache_register_volume+0x96/0x1a0
 erofs_fscache_register_fs+0x49a/0x690
 erofs_fc_fill_super+0x6c0/0xcc0
 vfs_get_super+0xa9/0x140
 vfs_get_tree+0x8e/0x300
 do_new_mount+0x28c/0x580
 [...]

Freed by task 5820:
 kfree+0xf1/0x2c0
 fscache_put_volume.part.0+0x5cb/0x9e0
 erofs_fscache_unregister_fs+0x157/0x1b0
 erofs_kill_sb+0xd9/0x1c0
 deactivate_locked_super+0xa3/0x100
 vfs_get_super+0x105/0x140
 vfs_get_tree+0x8e/0x300
 do_new_mount+0x28c/0x580
 [...]
==================================================================

Following is the process that triggers the issue:

        mount failed         |         daemon exit
------------------------------------------------------------
 deactivate_locked_super        cachefiles_daemon_release
  erofs_kill_sb
   erofs_fscache_unregister_fs
    fscache_relinquish_volume
     __fscache_relinquish_volume
      fscache_put_volume(fscache_volume, fscache_volume_put_relinquish)
       zero = __refcount_dec_and_test(&fscache_volume->ref, &ref);
                                 cachefiles_put_unbind_pincount
                                  cachefiles_daemon_unbind
                                   cachefiles_withdraw_cache
                                    cachefiles_withdraw_volumes
                                     list_del_init(&volume->cache_link)
       fscache_free_volume(fscache_volume)
        cache->ops->free_volume
         cachefiles_free_volume
          list_del_init(&cachefiles_volume->cache_link);
        kfree(fscache_volume)
                                     cachefiles_withdraw_volume
                                      fscache_withdraw_volume
                                       fscache_volume->n_accesses
                                       // fscache_volume UAF !!!

The fscache_volume in cache->volumes must not have been freed yet, but its
reference count may be 0. So use the new fscache_try_get_volume() helper
function try to get its reference count.

If the reference count of fscache_volume is 0, fscache_put_volume() is
freeing it, so wait for it to be removed from cache->volumes.

If its reference count is not 0, call cachefiles_withdraw_volume() with
reference count protection to avoid the above issue.

Fixes: fe2140e2f57f ("cachefiles: Implement volume support")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/cache.c          | 10 ++++++++++
 include/trace/events/fscache.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index f449f7340aad..56ef519a36a0 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/namei.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
 /*
@@ -319,12 +320,20 @@ static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 	_enter("");
 
 	for (;;) {
+		struct fscache_volume *vcookie = NULL;
 		struct cachefiles_volume *volume = NULL;
 
 		spin_lock(&cache->object_list_lock);
 		if (!list_empty(&cache->volumes)) {
 			volume = list_first_entry(&cache->volumes,
 						  struct cachefiles_volume, cache_link);
+			vcookie = fscache_try_get_volume(volume->vcookie,
+							 fscache_volume_get_withdraw);
+			if (!vcookie) {
+				spin_unlock(&cache->object_list_lock);
+				cpu_relax();
+				continue;
+			}
 			list_del_init(&volume->cache_link);
 		}
 		spin_unlock(&cache->object_list_lock);
@@ -332,6 +341,7 @@ static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 			break;
 
 		cachefiles_withdraw_volume(volume);
+		fscache_put_volume(vcookie, fscache_volume_put_withdraw);
 	}
 
 	_leave("");
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index a6190aa1b406..f1a73aa83fbb 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -35,12 +35,14 @@ enum fscache_volume_trace {
 	fscache_volume_get_cookie,
 	fscache_volume_get_create_work,
 	fscache_volume_get_hash_collision,
+	fscache_volume_get_withdraw,
 	fscache_volume_free,
 	fscache_volume_new_acquire,
 	fscache_volume_put_cookie,
 	fscache_volume_put_create_work,
 	fscache_volume_put_hash_collision,
 	fscache_volume_put_relinquish,
+	fscache_volume_put_withdraw,
 	fscache_volume_see_create_work,
 	fscache_volume_see_hash_wake,
 	fscache_volume_wait_create_work,
@@ -120,12 +122,14 @@ enum fscache_access_trace {
 	EM(fscache_volume_get_cookie,		"GET cook ")		\
 	EM(fscache_volume_get_create_work,	"GET creat")		\
 	EM(fscache_volume_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_volume_get_withdraw,		"GET withd")            \
 	EM(fscache_volume_free,			"FREE     ")		\
 	EM(fscache_volume_new_acquire,		"NEW acq  ")		\
 	EM(fscache_volume_put_cookie,		"PUT cook ")		\
 	EM(fscache_volume_put_create_work,	"PUT creat")		\
 	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
+	EM(fscache_volume_put_withdraw,		"PUT withd")            \
 	EM(fscache_volume_see_create_work,	"SEE creat")		\
 	EM(fscache_volume_see_hash_wake,	"SEE hwake")		\
 	E_(fscache_volume_wait_create_work,	"WAIT crea")
-- 
2.39.2


