Return-Path: <linux-fsdevel+bounces-19961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0988CBA04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99DE280DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453A7E0E9;
	Wed, 22 May 2024 03:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBF78C83;
	Wed, 22 May 2024 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349806; cv=none; b=G7tHAK2fYG6faZbaqlq3MtguMJVuKWnHgUed5cxdrdG8p3FqHDHYjasNyz1AG+nZfODyjdGAl0YdyH3KUPVeMJ0MiCrEfSi3BVnIumpXcweTxiooULXbk8mBMJu0Eb0FTBqkjiHroP/xicTkA7s9V4TLwEc7kB572Yw7R0pPDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349806; c=relaxed/simple;
	bh=kWxVJ/dGHXmL6Pb3y1v6dGD5eivC2kR2xmKgb20co9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6AHkx4ZvxUwmT66xbUAteGhfbN/3Oi2YnD0YuN2MYJzAcCRkJAwkBJXOo8RNvZ6cNI/LYm7pDyEB3J1diqycnL95CEI/AIjVuQTHLdMQT2j1k8h6gKZ+ZFxspshv3juoJlyl1YVDOIjrC4JAr/mr2eNKVm83F6iorLRmse2ZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckl0Sj3z4f3m7R;
	Wed, 22 May 2024 11:49:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 84BDE1A016E;
	Wed, 22 May 2024 11:50:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S15;
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
Subject: [PATCH v3 11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
Date: Wed, 22 May 2024 19:43:07 +0800
Message-Id: <20240522114308.2402121-12-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S15
X-Coremail-Antispam: 1UD129KBjvJXoWxurykGw4fJw1rAw4UArW5Jrb_yoW5Jw4DpF
	Way3WUGry09r4qgw1kArZ8A34rt3sxJF4DWw1UX3s5Arn0vr15Xr1IyryY9r15JrWrGa13
	tr1jgFy7Z34jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

In ondemand mode, when the daemon is processing an open request, if the
kernel flags the cache as CACHEFILES_DEAD, the cachefiles_daemon_write()
will always return -EIO, so the daemon can't pass the copen to the kernel.
Then the kernel process that is waiting for the copen triggers a hung_task.

Since the DEAD state is irreversible, it can only be exited by closing
/dev/cachefiles. Therefore, after calling cachefiles_io_error() to mark
the cache as CACHEFILES_DEAD, if in ondemand mode, flush all requests to
avoid the above hungtask. We may still be able to read some of the cached
data before closing the fd of /dev/cachefiles.

Note that this relies on the patch that adds reference counting to the req,
otherwise it may UAF.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/daemon.c   | 2 +-
 fs/cachefiles/internal.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index ccb7b707ea4b..06cdf1a8a16f 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -133,7 +133,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
+void cachefiles_flush_reqs(struct cachefiles_cache *cache)
 {
 	struct xarray *xa = &cache->reqs;
 	struct cachefiles_req *req;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 45c8bed60538..6845a90cdfcc 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -188,6 +188,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern void cachefiles_flush_reqs(struct cachefiles_cache *cache);
 extern void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache);
 extern void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache);
 
@@ -426,6 +427,8 @@ do {							\
 	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
 	fscache_io_error((___cache)->cache);		\
 	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
+	if (cachefiles_in_ondemand_mode(___cache))	\
+		cachefiles_flush_reqs(___cache);	\
 } while (0)
 
 #define cachefiles_io_error_obj(object, FMT, ...)			\
-- 
2.39.2


