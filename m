Return-Path: <linux-fsdevel+bounces-22734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84091B726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830B41F237F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923537F7C3;
	Fri, 28 Jun 2024 06:31:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B82770F5;
	Fri, 28 Jun 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556270; cv=none; b=L/SoEPpzHwrYkZRJ3bDYYCxewUNjMVYGaDbXm3qVfauF1cl8yEybkrUbB8C2kW/EjKIrI5/WQdD/b7kuMNUfPKDCPj+d2l6SYPpZMaXUariBpmNHXZBbFw9PX8UDu07ppcEnEY5qsV0u56nsF/W+xq2bTiapTCwHOTFh90gSjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556270; c=relaxed/simple;
	bh=2oK8p6D9E7vE9uXM0b7++79I+OHhoWnjg6/l/u616OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ub8qq8i9Y3ElN3D+lHdMaFnc0XKqWGMylAvMt1nZC/wP3YKjpBrLjs9eYN8FGcJeZMB0ywlfzjO3sJKK7Jz8xZv2J9kNgHergQ0TalR7JKb0Fd6lKIexdP49J+HTiGaUJheF0DhnBE8YyJIf2panTzsLir0i58feI43XkOmTHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9QYY5Z9kz4f3jYr;
	Fri, 28 Jun 2024 14:30:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E8E211A0572;
	Fri, 28 Jun 2024 14:31:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S12;
	Fri, 28 Jun 2024 14:31:04 +0800 (CST)
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
Subject: [PATCH v3 8/9] cachefiles: cyclic allocation of msg_id to avoid reuse
Date: Fri, 28 Jun 2024 14:29:29 +0800
Message-Id: <20240628062930.2467993-9-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBXwIWfWH5mZZVAAg--.52859S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWUurW3Ary8Cr17KrykXwb_yoWrGF18pF
	WakFy7Kry8WF42krZ7ZF4kJrWrG34kZFsrWrWFqryvyrn0vr1rZr1Utr1rXFyUA3ySgF42
	qw48uasrt342y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUB89_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-xKAABsF

From: Baokun Li <libaokun1@huawei.com>

Reusing the msg_id after a maliciously completed reopen request may cause
a read request to remain unprocessed and result in a hung, as shown below:

       t1       |      t2       |      t3
-------------------------------------------------
cachefiles_ondemand_select_req
 cachefiles_ondemand_object_is_close(A)
 cachefiles_ondemand_set_object_reopening(A)
 queue_work(fscache_object_wq, &info->work)
                ondemand_object_worker
                 cachefiles_ondemand_init_object(A)
                  cachefiles_ondemand_send_req(OPEN)
                    // get msg_id 6
                    wait_for_completion(&req_A->done)
cachefiles_ondemand_daemon_read
 // read msg_id 6 req_A
 cachefiles_ondemand_get_fd
 copy_to_user
                                // Malicious completion msg_id 6
                                copen 6,-1
                                cachefiles_ondemand_copen
                                 complete(&req_A->done)
                                 // will not set the object to close
                                 // because ondemand_id && fd is valid.

                // ondemand_object_worker() is done
                // but the object is still reopening.

                                // new open req_B
                                cachefiles_ondemand_init_object(B)
                                 cachefiles_ondemand_send_req(OPEN)
                                 // reuse msg_id 6
process_open_req
 copen 6,A.size
 // The expected failed copen was executed successfully

Expect copen to fail, and when it does, it closes fd, which sets the
object to close, and then close triggers reopen again. However, due to
msg_id reuse resulting in a successful copen, the anonymous fd is not
closed until the daemon exits. Therefore read requests waiting for reopen
to complete may trigger hung task.

To avoid this issue, allocate the msg_id cyclically to avoid reusing the
msg_id for a very short duration of time.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index a1a1d25e9514..7b99bd98de75 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -129,6 +129,7 @@ struct cachefiles_cache {
 	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
+	u32				msg_id_next;
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1d5b970206d0..470c96658385 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -528,20 +528,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		smp_mb();
 
 		if (opcode == CACHEFILES_OP_CLOSE &&
-			!cachefiles_ondemand_object_is_open(object)) {
+		    !cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
 		}
 
-		xas.xa_index = 0;
+		/*
+		 * Cyclically find a free xas to avoid msg_id reuse that would
+		 * cause the daemon to successfully copen a stale msg_id.
+		 */
+		xas.xa_index = cache->msg_id_next;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART) {
+			xas.xa_index = 0;
+			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
+		}
 		if (xas.xa_node == XAS_RESTART)
 			xas_set_err(&xas, -EBUSY);
+
 		xas_store(&xas, req);
-		xas_clear_mark(&xas, XA_FREE_MARK);
-		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		if (xas_valid(&xas)) {
+			cache->msg_id_next = xas.xa_index + 1;
+			xas_clear_mark(&xas, XA_FREE_MARK);
+			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		}
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-- 
2.39.2


