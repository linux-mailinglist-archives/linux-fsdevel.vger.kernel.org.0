Return-Path: <linux-fsdevel+bounces-17587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0568AFFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E89D1F243BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C9144307;
	Wed, 24 Apr 2024 03:43:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6A13C8F3;
	Wed, 24 Apr 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930210; cv=none; b=MZgVdkF9u9+xdhfm+xO8Kj+V8CR6SZQ+PEmtz3S4nofbQm1fCNIxCNPizkEaEvc97zhBvWiNvln8/XMJgboTGx6NlIl0t77D2MrTHgDKSYg8r32Fhi6zwxxvrvZc/sGpiPMoIbDZbwTuKBNU5fpsbWWC4s3nRUMhpZnqa4B13JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930210; c=relaxed/simple;
	bh=D27V7j9H6zmJjtvGLBwi9QEzYwV3vIfj7n5EnJTujdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohHtqbwilfV3lEXTQBBvIBa6oAoaEhMv39z3TzoQ3yMjMfB8DHFkelVVofFqkZl87Z0vvg3Ft+mHKiNyzDiE2DkE1QRSsmxObqTNOeyrJSE0cg7ODXD5wWRD4Srmb/Q6IMimbU9NeFf4TND3oUGdwhlUYpsYy/gmUGLZo+nH1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPPw6267Gz4f3knl;
	Wed, 24 Apr 2024 11:43:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC23B1A0179;
	Wed, 24 Apr 2024 11:43:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHafyhmuSA4Kw--.57541S8;
	Wed, 24 Apr 2024 11:43:25 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	zhujia.zj@bytedance.com,
	jefflexu@linux.alibaba.com,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 4/5] cachefiles: cyclic allocation of msg_id to avoid reuse
Date: Wed, 24 Apr 2024 11:34:08 +0800
Message-Id: <20240424033409.2735257-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033409.2735257-1-libaokun@huaweicloud.com>
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHafyhmuSA4Kw--.57541S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1fAF1xurWkur4xuryfWFg_yoW7Xr4rpF
	WakFy2kry8WF1v9rykZFZ5Jr4fK34kZFsrWrySqry0ywn0vr45Zr1jyr1FqFyUArZ3WF47
	tr48WF9rKa42v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjs2-5UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

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
                // reopen fails, want daemon to close fd,
                // then set object to close, retrigger reopen
                                cachefiles_ondemand_init_object(B)
                                 cachefiles_ondemand_send_req(OPEN)
                                 // new open req_B reuse msg_id 6
// daemon successfully copen msg_id 6, so it won't close the fd.
// object is always reopening, so read requests are not processed
// resulting in a hung

Therefore allocate the msg_id cyclically to avoid reusing the msg_id for
a very short duration of time causing the above problem.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 92 +++++++++++++++++++++++-----------------
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 8ecd296cc1c4..9200c00f3e98 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -128,6 +128,7 @@ struct cachefiles_cache {
 	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
+	u32				msg_id_next;
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index f6440b3e7368..6171e1a8cfa1 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -404,51 +404,65 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	if (ret)
 		goto out;
 
-	do {
-		/*
-		 * Stop enqueuing the request when daemon is dying. The
-		 * following two operations need to be atomic as a whole.
-		 *   1) check cache state, and
-		 *   2) enqueue request if cache is alive.
-		 * Otherwise the request may be enqueued after xarray has been
-		 * flushed, leaving the orphan request never being completed.
-		 *
-		 * CPU 1			CPU 2
-		 * =====			=====
-		 *				test CACHEFILES_DEAD bit
-		 * set CACHEFILES_DEAD bit
-		 * flush requests in the xarray
-		 *				enqueue the request
-		 */
-		xas_lock(&xas);
-
-		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
-		    cachefiles_ondemand_object_is_dropping(object)) {
-			xas_unlock(&xas);
-			ret = -EIO;
-			goto out;
-		}
+retry:
+	/*
+	 * Stop enqueuing the request when daemon is dying. The
+	 * following two operations need to be atomic as a whole.
+	 *   1) check cache state, and
+	 *   2) enqueue request if cache is alive.
+	 * Otherwise the request may be enqueued after xarray has been
+	 * flushed, leaving the orphan request never being completed.
+	 *
+	 * CPU 1			CPU 2
+	 * =====			=====
+	 *				test CACHEFILES_DEAD bit
+	 * set CACHEFILES_DEAD bit
+	 * flush requests in the xarray
+	 *				enqueue the request
+	 */
+	xas_lock(&xas);
 
-		/* coupled with the barrier in cachefiles_flush_reqs() */
-		smp_mb();
+	if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
+	    cachefiles_ondemand_object_is_dropping(object)) {
+		xas_unlock(&xas);
+		ret = -EIO;
+		goto out;
+	}
 
-		if (opcode == CACHEFILES_OP_CLOSE &&
-			!cachefiles_ondemand_object_is_open(object)) {
-			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
-			xas_unlock(&xas);
-			ret = -EIO;
-			goto out;
-		}
+	/* coupled with the barrier in cachefiles_flush_reqs() */
+	smp_mb();
+
+	if (opcode == CACHEFILES_OP_CLOSE &&
+		!cachefiles_ondemand_object_is_open(object)) {
+		WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
+		xas_unlock(&xas);
+		ret = -EIO;
+		goto out;
+	}
 
+	/*
+	 * Cyclically find a free xas to avoid msg_id reuse that would
+	 * cause the daemon to successfully copen a stale msg_id.
+	 */
+	xas.xa_index = cache->msg_id_next;
+	xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+	if (xas.xa_node == XAS_RESTART) {
 		xas.xa_index = 0;
-		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
-		if (xas.xa_node == XAS_RESTART)
-			xas_set_err(&xas, -EBUSY);
-		xas_store(&xas, req);
+		xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
+	}
+	if (xas.xa_node == XAS_RESTART)
+		xas_set_err(&xas, -EBUSY);
+
+	xas_store(&xas, req);
+	if (xas_valid(&xas)) {
+		cache->msg_id_next = xas.xa_index + 1;
 		xas_clear_mark(&xas, XA_FREE_MARK);
 		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
-		xas_unlock(&xas);
-	} while (xas_nomem(&xas, GFP_KERNEL));
+	}
+
+	xas_unlock(&xas);
+	if (xas_nomem(&xas, GFP_KERNEL))
+		goto retry;
 
 	ret = xas_error(&xas);
 	if (ret)
-- 
2.39.2


