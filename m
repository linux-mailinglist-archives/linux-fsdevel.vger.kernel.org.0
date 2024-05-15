Return-Path: <linux-fsdevel+bounces-19523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C353A8C66BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA1283B52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5485C4E;
	Wed, 15 May 2024 13:02:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BF84D3F;
	Wed, 15 May 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778135; cv=none; b=cJq9AzcYrjgJzPIJXfOMwtIEB+p/7MzbopvApO1njFclbGycXILunTXTzHYooiLy/r02Te0GnRUf5yyWc2rteaVE+3MBKwB0QS10aYnBVHXCnA1T3bB3gl8HWDi011H7tfacMpjTiB5NTsaXRtKZiwsQbuuHBbt4tpV2QVTFAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778135; c=relaxed/simple;
	bh=yuE0dUkKg6SEvEFuaXMjjSTzSms1xrmRs0cuseyJTws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1+TDfko9FBM+DWBJGsCIHhaDOZUZdfWPZF4GYT78E9hGa/tcnuwHPie22xfqfKgxohP+IbUQJEMPzqH7dp0ob7okMjmSqpC7zfHurR9/wiTMZZ7on5GORMWRaAaloYkR8O09LOcKxY+fmKNXvlM2Q0ZvlWAEgtiRQaKmuddx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfYK571Mzz4f3jdX;
	Wed, 15 May 2024 21:02:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A2BE21A016E;
	Wed, 15 May 2024 21:02:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLskRmALLwMg--.18738S9;
	Wed, 15 May 2024 21:02:10 +0800 (CST)
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
Subject: [PATCH v2 5/5] cachefiles: add missing lock protection when polling
Date: Wed, 15 May 2024 20:51:36 +0800
Message-Id: <20240515125136.3714580-6-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFLskRmALLwMg--.18738S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rWr4Dtr4furW3uw4rZrb_yoW8Xw4DpF
	WSya4Utry8ur48uF1jva4kJ34SyaykWa4DWaykXwsIvwnrXr1FqFnak3yYgrn5Jr1kJF47
	tw1UKF9xA3yUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUB89_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Add missing lock protection in poll routine when iterating xarray,
otherwise:

Even with RCU read lock held, only the slot of the radix tree is
ensured to be pinned there, while the data structure (e.g. struct
cachefiles_req) stored in the slot has no such guarantee.  The poll
routine will iterate the radix tree and dereference cachefiles_req
accordingly.  Thus RCU read lock is not adequate in this case and
spinlock is needed here.

Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6465e2574230..73ed2323282a 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 
 	if (cachefiles_in_ondemand_mode(cache)) {
 		if (!xa_empty(&cache->reqs)) {
-			rcu_read_lock();
+			xas_lock(&xas);
 			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 				if (!cachefiles_ondemand_is_reopening_read(req)) {
 					mask |= EPOLLIN;
 					break;
 				}
 			}
-			rcu_read_unlock();
+			xas_unlock(&xas);
 		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-- 
2.39.2


