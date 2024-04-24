Return-Path: <linux-fsdevel+bounces-17586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31DC8AFFF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC12877A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91505144303;
	Wed, 24 Apr 2024 03:43:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5213A269;
	Wed, 24 Apr 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930210; cv=none; b=Y5pB8o1TcIsyLK5BM/FhdKsBHXWHNDkmpfBiTUZY6qm6MKj780c+OxtIMBMboYCciZmpqPGgQAYGdlt+cx8NdxFdUaEy/7KSEcelW2VpoIT/Lt2PfIpco9MnZPCXCUtUVE6eVrld1jIuxesvxLfnb0vkOq0yJTPhevTUQR4uPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930210; c=relaxed/simple;
	bh=FWPnk36V1OK9PX17AcxLnoB+X4xnXfKi61b03aCPTDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ku0BxgbUhAZJaUTclMp6ALAxhDsWtM67KNartdGLQmUR8z+2A5dYxuPYyiml9I9ke66HQ59Hm8FcQWCciTbpFH1vQlf2XtkMMvdtX34ZlLVLzJFP+/IR/hwD5SjRtcWMnMoNQyYbOpi4RbNpCyoKzH7mwGzrzlNVqWinf6la8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPPw51R9Nz4f3kjD;
	Wed, 24 Apr 2024 11:43:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B748E1A08D9;
	Wed, 24 Apr 2024 11:43:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHafyhmuSA4Kw--.57541S6;
	Wed, 24 Apr 2024 11:43:24 +0800 (CST)
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
Subject: [PATCH 2/5] cachefiles: flush all requests for the object that is being dropped
Date: Wed, 24 Apr 2024 11:34:06 +0800
Message-Id: <20240424033409.2735257-3-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHafyhmuSA4Kw--.57541S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ur18JF1DXF1rZF17Jr4kXrb_yoW8Xr1rpF
	WayFy3Kry8WF47CrZ3AF9YqrySy3ykuFnrX3WaqayrArn8XrWrZr15twn8ZFyUA3yfXr4f
	tw4FkasxK34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj3ku7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Because after an object is dropped, requests for that object are useless,
flush them to avoid causing other problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 73da4d4eaa9b..d24bff43499b 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
+	unsigned long index;
+	struct cachefiles_req *req;
+	struct cachefiles_cache *cache;
+
 	if (!object->ondemand)
 		return;
 
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
+
+	if (!object->ondemand->ondemand_id)
+		return;
+
+	/* Flush all requests for the object that is being dropped. */
+	cache = object->volume->cache;
+	xa_lock(&cache->reqs);
 	cachefiles_ondemand_set_object_dropping(object);
+	xa_for_each(&cache->reqs, index, req) {
+		if (req->object == object) {
+			req->error = -EIO;
+			complete(&req->done);
+			__xa_erase(&cache->reqs, index);
+		}
+	}
+	xa_unlock(&cache->reqs);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.39.2


