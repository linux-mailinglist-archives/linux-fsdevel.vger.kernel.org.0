Return-Path: <linux-fsdevel+bounces-19501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B98C631C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637EE1C203B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4859148;
	Wed, 15 May 2024 08:56:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0653365;
	Wed, 15 May 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763396; cv=none; b=GtcrpJmlj8rB2rd0KNS/y0N2mu3+ama/k/aVbjkIBgGuyf4fS9rJvQ2gALSCtTBtHM3kk26LvL9YYTDkkNFaRhWX/FZTt05A4M2yHqlr5UGizCpvCMZX5CzkiurQzO/6MNcIb/H72lwiinRwHaWUcRZO1uomCDhtSun4FnWVEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763396; c=relaxed/simple;
	bh=tZb3FePn1EyPhGEIiYUgyp5m6cJ7OV9F8EFJabQz/6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF8KfOpHIQg3wdJafjQKOJcpHf4LaxghTio+YyEoD8GQQEcfb7+bqnd8wcOTh4TbsxFPSJ6ZWX/vcVBUs7PypMm3KF0MX0mYmi0+bs0Fua91IHsgPo8eRms2o4B/7kiWSr4ypLDBAkcs40hC0vfXf00Mwk2R4mYYDQKHSTV2abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfRsd5J5Dz4f3mHh;
	Wed, 15 May 2024 16:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1E291A017F;
	Wed, 15 May 2024 16:56:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S7;
	Wed, 15 May 2024 16:56:31 +0800 (CST)
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
Subject: [PATCH v2 03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
Date: Wed, 15 May 2024 16:45:52 +0800
Message-Id: <20240515084601.3240503-4-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S7
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrur1kZw45Gr1DurWrAFb_yoWxAr4fpF
	ZIyFyxtry8WrW8CrZ7AF15Jr1rJ3ykAFnrWr10q3s3Arn0vr1rZr1UtF18ZFy5CryvkrsF
	qw48uF9rJ34qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbgdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

We got the following issue in a fuzz test of randomly issuing the restore
command:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962

CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
Call Trace:
 kasan_report+0x94/0xc0
 cachefiles_ondemand_daemon_read+0x609/0xab0
 vfs_read+0x169/0xb50
 ksys_read+0xf5/0x1e0

Allocated by task 626:
 __kmalloc+0x1df/0x4b0
 cachefiles_ondemand_send_req+0x24d/0x690
 cachefiles_create_tmpfile+0x249/0xb30
 cachefiles_create_file+0x6f/0x140
 cachefiles_look_up_object+0x29c/0xa60
 cachefiles_lookup_cookie+0x37d/0xca0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]

Freed by task 626:
 kfree+0xf1/0x2c0
 cachefiles_ondemand_send_req+0x568/0x690
 cachefiles_create_tmpfile+0x249/0xb30
 cachefiles_create_file+0x6f/0x140
 cachefiles_look_up_object+0x29c/0xa60
 cachefiles_lookup_cookie+0x37d/0xca0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]
==================================================================

Following is the process that triggers the issue:

     mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
 cachefiles_ondemand_init_object
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)

            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              cachefiles_ondemand_get_fd
              copy_to_user(_buffer, msg, n)
            process_open_req(REQ_A)
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                  xas_for_each(&xas, req, ULONG_MAX)
                                   xas_set_mark(&xas, CACHEFILES_REQ_NEW);

                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req

             write(devfd, ("copen %u,%llu", msg->msg_id, size));
             cachefiles_ondemand_copen
              xa_erase(&cache->reqs, id)
              complete(&REQ_A->done)
   kfree(REQ_A)
                                    cachefiles_ondemand_get_fd(REQ_A)
                                     fd = get_unused_fd_flags
                                     file = anon_inode_getfile
                                     fd_install(fd, file)
                                     load = (void *)REQ_A->msg.data;
                                     load->fd = fd;
                                     // load UAF !!!

This issue is caused by issuing a restore command when the daemon is still
alive, which results in a request being processed multiple times thus
triggering a UAF. So to avoid this problem, add an additional reference
count to cachefiles_req, which is held while waiting and reading, and then
released when the waiting and reading is over.

Note that since there is only one reference count for waiting, we need to
avoid the same request being completed multiple times, so we can only
complete the request if it is successfully removed from the xarray.

Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d33169f0018b..7745b8abc3aa 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
 struct cachefiles_req {
 	struct cachefiles_object *object;
 	struct completion done;
+	refcount_t ref;
 	int error;
 	struct cachefiles_msg msg;
 };
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index fd49728d8bae..56d12fe4bf73 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -4,6 +4,12 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+static inline void cachefiles_req_put(struct cachefiles_req *req)
+{
+	if (refcount_dec_and_test(&req->ref))
+		kfree(req);
+}
+
 static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
@@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
-	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
@@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
+	refcount_inc(&req->ref);
 	xa_unlock(&cache->reqs);
 
-	id = xas.xa_index;
-
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
 		if (ret) {
 			cachefiles_ondemand_set_object_close(req->object);
-			goto error;
+			goto out;
 		}
 	}
 
-	msg->msg_id = id;
+	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
 		if (msg->opcode == CACHEFILES_OP_OPEN)
 			close_fd(((struct cachefiles_open *)msg->data)->fd);
-		goto error;
 	}
-
-	/* CLOSE request has no reply */
-	if (msg->opcode == CACHEFILES_OP_CLOSE) {
-		xa_erase(&cache->reqs, id);
-		complete(&req->done);
+out:
+	/* Remove error request and CLOSE request has no reply */
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			req->error = ret;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+		xas_unlock(&xas);
 	}
-
-	return n;
-
-error:
-	xa_erase(&cache->reqs, id);
-	req->error = ret;
-	complete(&req->done);
-	return ret;
+	cachefiles_req_put(req);
+	return ret ? ret : n;
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
@@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 	}
 
+	refcount_set(&req->ref, 1);
 	req->object = object;
 	init_completion(&req->done);
 	req->msg.opcode = opcode;
@@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	wake_up_all(&cache->daemon_pollwq);
 	wait_for_completion(&req->done);
 	ret = req->error;
-	kfree(req);
+	cachefiles_req_put(req);
 	return ret;
 out:
 	/* Reset the object to close state in error handling path.
-- 
2.39.2


