Return-Path: <linux-fsdevel+bounces-19524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24B8C66C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F6B1C22735
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298028615E;
	Wed, 15 May 2024 13:02:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0884D0B;
	Wed, 15 May 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778135; cv=none; b=Q7FVbrD7GNVkt5giCerioFnITjbGwzH6/Lv8blul2PhqiCZCwWoFRLBV3b/9q2w7moLVvizoVS4Lbe1txgxuXu4HdDQWqBbbHa6Y8SHRH0CkTAQr/OnYwRlW2OCLWPufh2yYgSiAmA8w6rC+mXBKG1B9ZJuofh7ouokB3kJ9NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778135; c=relaxed/simple;
	bh=UpN+BaQ3OvbOo2SaXh3JCPHjbg+dX+VM8etjjFvQVXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGBWwaeTsJEjSNbZtLKEqBOC4zMfbjySicIn0lOQBy15Ln176OG+vZQy6ZeHNV0s4AImyXoDNzNOarQnGv/Yv+7loU/OjqoVEv4HNYceX7NNIxp26FYvBMTPMkbXl95AM/nifMd+j44TGDKETOEtlegLWoU5r9hUPmEbF4zMZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfYK52w28z4f3jdS;
	Wed, 15 May 2024 21:02:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1465C1A0CD2;
	Wed, 15 May 2024 21:02:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLskRmALLwMg--.18738S8;
	Wed, 15 May 2024 21:02:09 +0800 (CST)
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
Subject: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid reuse
Date: Wed, 15 May 2024 20:51:35 +0800
Message-Id: <20240515125136.3714580-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515125136.3714580-1-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFLskRmALLwMg--.18738S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWUurW3Ary8Cr17KrykXwb_yoWrJF4rpF
	WakFy7Kry8WF42krZ7Zan5JrWrG34DZFsrWrWYq34vyrn0vr1rZr1Utr1SqFyUA3ySgr42
	qw48uasrt342y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUB89_UUUUU=
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
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index f6440b3e7368..b10952f77472 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -433,20 +433,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
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


