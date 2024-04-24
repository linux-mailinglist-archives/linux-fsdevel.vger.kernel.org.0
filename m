Return-Path: <linux-fsdevel+bounces-17594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B38B001F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A057CB248B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AD14533C;
	Wed, 24 Apr 2024 03:48:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46413E040;
	Wed, 24 Apr 2024 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930517; cv=none; b=Asn0/7icMolwL6k1CUx3H+9a1qTb/hpLLIhImj2D+RgxaO1rx2SakiqMzN7BnbgWrT6YsDIh9Ra7/UIvDmYuqJn9rDItKsSeI5FRw2iCjhSCaYHx4P4Pds3YOsIs1KDQXC1cjsywKaA0MGIX08JdLoybhIo1s28TH7Ug28Clu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930517; c=relaxed/simple;
	bh=85vbRXtj8Cc2mJmT5yxNEh8Moy5b/ZQpJ6HZMx09LyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOptcovM1XOWIDFdB35Ldl/AcggPlLna/FI9SNX0+QBofgf/YCN9k5cXEo+2C2KCFyLo9N+aQkvO2fTPnR7v7CCqO1SV08qYXmYOHG3DynukmB/aAiS/cHTF4wV+TXxgyuRutGgQYUoIAu9OQ3WxRFumroQQ0IkHywJsy3sE41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPQ202tNpz4f3knn;
	Wed, 24 Apr 2024 11:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E80CA1A0A96;
	Wed, 24 Apr 2024 11:48:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S8;
	Wed, 24 Apr 2024 11:48:31 +0800 (CST)
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
Subject: [PATCH 04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
Date: Wed, 24 Apr 2024 11:39:08 +0800
Message-Id: <20240424033916.2748488-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBELgShmKXE4Kw--.6143S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UWF15tF4UWrW3XrWDJwb_yoWruF4rpF
	ZIyFyxtry8Way8Cr4kArn8Jr1rJ3yDuFnrX340qr1xAwn0vr1rZr17tF10yFy5Cry2yrsr
	tw1UCF9xJryjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

We got the following issue in a fuzz test of randomly issuing the restore
command:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963

CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
Call Trace:
 kasan_report+0x93/0xc0
 cachefiles_ondemand_daemon_read+0xb41/0xb60
 vfs_read+0x169/0xb50
 ksys_read+0xf5/0x1e0

Allocated by task 116:
 kmem_cache_alloc+0x140/0x3a0
 cachefiles_lookup_cookie+0x140/0xcd0
 fscache_cookie_state_machine+0x43c/0x1230
 [...]

Freed by task 792:
 kmem_cache_free+0xfe/0x390
 cachefiles_put_object+0x241/0x480
 fscache_cookie_state_machine+0x5c8/0x1230
 [...]
==================================================================

Following is the process that triggers the issue:

     mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
cachefiles_withdraw_cookie
 cachefiles_ondemand_clean_object(object)
  cachefiles_ondemand_send_req
   REQ_A = kzalloc(sizeof(*req) + data_len)
   wait_for_completion(&REQ_A->done)

            cachefiles_daemon_read
             cachefiles_ondemand_daemon_read
              REQ_A = cachefiles_ondemand_select_req
              msg->object_id = req->object->ondemand->ondemand_id
                                  ------ restore ------
                                  cachefiles_ondemand_restore
                                  xas_for_each(&xas, req, ULONG_MAX)
                                   xas_set_mark(&xas, CACHEFILES_REQ_NEW)

                                  cachefiles_daemon_read
                                   cachefiles_ondemand_daemon_read
                                    REQ_A = cachefiles_ondemand_select_req
              copy_to_user(_buffer, msg, n)
               xa_erase(&cache->reqs, id)
               complete(&REQ_A->done)
              ------ close(fd) ------
              cachefiles_ondemand_fd_release
               cachefiles_put_object
 cachefiles_put_object
  kmem_cache_free(cachefiles_object_jar, object)
                                    REQ_A->object->ondemand->ondemand_id
                                     // object UAF !!!

When we see the request within xa_lock, req->object must not have been
freed yet, so grab the reference count of object before xa_unlock to
avoid the above issue.

Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c          | 2 ++
 include/trace/events/cachefiles.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 56d12fe4bf73..bb94ef6a6f61 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
 	refcount_inc(&req->ref);
+	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
@@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 			close_fd(((struct cachefiles_open *)msg->data)->fd);
 	}
 out:
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* Remove error request and CLOSE request has no reply */
 	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
 		xas_reset(&xas);
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index cf4b98b9a9ed..119a823fb5a0 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_see_withdrawal,
 	cachefiles_obj_get_ondemand_fd,
 	cachefiles_obj_put_ondemand_fd,
+	cachefiles_obj_get_read_req,
+	cachefiles_obj_put_read_req,
 };
 
 enum fscache_why_object_killed {
@@ -127,7 +129,9 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
 	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
-	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
+	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
+	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
+	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
-- 
2.39.2


