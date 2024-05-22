Return-Path: <linux-fsdevel+bounces-19962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DC8CBA06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F0E1C21B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8B7E58D;
	Wed, 22 May 2024 03:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52A78C9C;
	Wed, 22 May 2024 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349807; cv=none; b=B5BOTAklpPFlLU39YmJ+da8nnzqCyVdHBDyUTELuXMhNyhILRLamAUP26Fra6icHPkgQBwfgwUZCbLUZXdUMO+hQx1r94EdBmQxTv1pmP17DfkVLFof/teC7ScpnCa93ygKx2hJywgW8GlZAkkiJTtw1SMl/iUQhUYJx6/xqzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349807; c=relaxed/simple;
	bh=xFIWIQs94nRiioTsqRVAvGLFuymDOqizWvscX/cU7L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mk+eAADe4TTHdHbRgVd3QYQWVSxGkL3eDkDoJroB5VzadgJMOS1+YKUKqJb3d6ohnpGJpcGx4Ub7fMeW6s18v2duL7S2RX/DFeMzC7whUXYTWGzri2H6S+BnhTnDI5zXZkDOYFB9j5dKjsfXxJ0xotLgiCvd23hDq9+CUc6VkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckr2SHwz4f3jkV;
	Wed, 22 May 2024 11:49:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 237181A0199;
	Wed, 22 May 2024 11:50:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S16;
	Wed, 22 May 2024 11:50:01 +0800 (CST)
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
Subject: [PATCH v3 12/12] cachefiles: make on-demand read killable
Date: Wed, 22 May 2024 19:43:08 +0800
Message-Id: <20240522114308.2402121-13-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S16
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUJry5tw4ruw48KFW7Arb_yoW5Ar1rpF
	Waya45KrykWF4Ikrn3Aw4UX34Sy3y8AFZrWrySqw1fAFnIqr1rZr1Ut3WYvF15A34jgrZx
	tw48uFWxK34jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRupB-UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Replacing wait_for_completion() with wait_for_completion_killable() in
cachefiles_ondemand_send_req() allows us to kill processes that might
trigger a hunk_task if the daemon is abnormal.

But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
is initiated from kworker context and the signal is prohibited in these
kworker.

Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
means that a process will complete the current request soon, so wait
again for the request to be completed.

In addition, add the cachefiles_ondemand_finish_req() helper function to
simplify the code.

Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/ondemand.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 922cab1a314b..58bd80956c5a 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -380,6 +380,20 @@ static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xa
 	return NULL;
 }
 
+static inline bool cachefiles_ondemand_finish_req(struct cachefiles_req *req,
+						  struct xa_state *xas, int err)
+{
+	if (unlikely(!xas || !req))
+		return false;
+
+	if (xa_cmpxchg(xas->xa, xas->xa_index, req, NULL, 0) != req)
+		return false;
+
+	req->error = err;
+	complete(&req->done);
+	return true;
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -443,16 +457,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
 	/* Remove error request and CLOSE request has no reply */
-	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
-		xas_reset(&xas);
-		xas_lock(&xas);
-		if (xas_load(&xas) == req) {
-			req->error = ret;
-			complete(&req->done);
-			xas_store(&xas, NULL);
-		}
-		xas_unlock(&xas);
-	}
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE)
+		cachefiles_ondemand_finish_req(req, &xas, ret);
 	cachefiles_req_put(req);
 	return ret ? ret : n;
 }
@@ -544,8 +550,18 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		goto out;
 
 	wake_up_all(&cache->daemon_pollwq);
-	wait_for_completion(&req->done);
-	ret = req->error;
+wait:
+	ret = wait_for_completion_killable(&req->done);
+	if (!ret) {
+		ret = req->error;
+	} else {
+		ret = -EINTR;
+		if (!cachefiles_ondemand_finish_req(req, &xas, ret)) {
+			/* Someone will complete it soon. */
+			cpu_relax();
+			goto wait;
+		}
+	}
 	cachefiles_req_put(req);
 	return ret;
 out:
-- 
2.39.2


