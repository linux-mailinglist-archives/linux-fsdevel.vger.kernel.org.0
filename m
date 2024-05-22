Return-Path: <linux-fsdevel+bounces-19963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4078CBA08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB27B2261D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD57F486;
	Wed, 22 May 2024 03:50:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70460770E7;
	Wed, 22 May 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349807; cv=none; b=WtXriVgHrl2JTgY90fpx6vaIe54JFomNh06WBp2O7kLup7MX1Krg7JQYyVlkDR2t2ifQz1OXvVYcUNPKPnO+hblsyJAlekhl00OiYKZnGEEXk+zBPQ49G99fN6BgydEnjkxivpbJbn5KcU2Vk3ORVd6hI/2A9ShYsb3rGMv/CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349807; c=relaxed/simple;
	bh=M/LwwR0kQm2jd69AWZp5LpyxqZe5REgaea1YceOQsx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISvaBJcqTttccJ+zGdFQse3H1NAsUD39MAFnbniBRlnLzWnm//PWS1N/i/Bt9MKvD7JO7h8bVsIFNHr1tgm7/y8S7OacebHgBezSG4BDJeED6/jViOhC+JaKnpX0qvN2Oo9eTMknXsUJhVqryhfhXe+i7sZWPf1WpqIa2keLp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckf4P6rz4f3m7N;
	Wed, 22 May 2024 11:49:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1AD471A01B9;
	Wed, 22 May 2024 11:49:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S8;
	Wed, 22 May 2024 11:49:56 +0800 (CST)
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
Subject: [PATCH v3 04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
Date: Wed, 22 May 2024 19:43:00 +0800
Message-Id: <20240522114308.2402121-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UWF15tF4UWrW3XrWDJwb_yoW7Jw4fpF
	ZIyFyxtry8WFW8Cr4kAr15Jr1rJ3yDCFnrX340qr1xAwnIvr1rZr1UtF1rJFy5Cry2yrsr
	tw18CF9xtryjy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREMKZDUUUUU==
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
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/ondemand.c          | 3 +++
 include/trace/events/cachefiles.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index c011fb24d238..3dd002108a87 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -337,6 +337,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
 	refcount_inc(&req->ref);
+	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
@@ -357,6 +358,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 		goto err_put_fd;
 	}
 
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* CLOSE request has no reply */
 	if (msg->opcode == CACHEFILES_OP_CLOSE) {
 		xa_erase(&cache->reqs, id);
@@ -370,6 +372,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	if (msg->opcode == CACHEFILES_OP_OPEN)
 		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	xas_reset(&xas);
 	xas_lock(&xas);
 	if (xas_load(&xas) == req) {
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index e3213af847cd..7d931db02b93 100644
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
@@ -129,7 +131,9 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
 	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
 	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")	\
-	E_(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")
+	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")	\
+	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
+	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
-- 
2.39.2


