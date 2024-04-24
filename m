Return-Path: <linux-fsdevel+bounces-17601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F28B002D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5CF1F2205D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1214885F;
	Wed, 24 Apr 2024 03:48:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423F145B0F;
	Wed, 24 Apr 2024 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930521; cv=none; b=leZ7Pb8SFzQjVEVz00bg7dqlaUsk4Fng+Ftbu5AcC+SGrM5c8TdflmPgW2wK03l7QZF1NG2xbmx24Ss2BzQT7RZcurp3+hhPfl83P06lxmQSdiueCLEbWjHAebqa7caiQikaZvd3qv/vraHspymE4EndJ51V5JRRxGqVAY/oxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930521; c=relaxed/simple;
	bh=oD/uq+JheDeY/kgmym09d8Qh795Y/FHkwnjjdNNetUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGtR9+QlBX+kSZ8XTNIRI79NKynGhrId0M+TbunFDO7wtRizXYxHCOZZwWxwSOG6EfZVJkpM7N7PsSr9QAqtXrZFXF1guD47C5qV40frMZzGd4Bw3Rf91GqK+EMGzkXDhj0M28btygN6r2h2Vu8ntOFxw9XT9JJsED7gTrGYTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPQ222Cxyz4f3m76;
	Wed, 24 Apr 2024 11:48:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E1761A0175;
	Wed, 24 Apr 2024 11:48:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S15;
	Wed, 24 Apr 2024 11:48:35 +0800 (CST)
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
Subject: [PATCH 11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
Date: Wed, 24 Apr 2024 11:39:15 +0800
Message-Id: <20240424033916.2748488-12-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBELgShmKXE4Kw--.6143S15
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrXr13Zry8uw4UZw13urg_yoW5JFyrpF
	Way3WUGry09r4qgw1kArZ8J34rJ3sxJF1qgw1UX3s5Arn0vr15Xr1IyryY9F15JrWrGa13
	tr1jgFy7Z34jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUUNBMtUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

In ondemand mode, when the daemon is processing an open request, if the
kernel flags the cache as CACHEFILES_DEAD, the cachefiles_daemon_write()
will always return -EIO, so the daemon can't pass the copen to the kernel.
Then the kernel process that is waiting for the copen triggers a hung_task.

Since the DEAD state is irreversible, it can only be exited by reopening
/dev/cachefiles. Therefore, after calling cachefiles_io_error() to mark
the cache as CACHEFILES_DEAD, if in ondemand mode, flush all requests to
avoid the above hungtask. We may still be able to read some of the cached
data before releasing the fd of /dev/cachefiles.

Note that this relies on the patch that adds reference counting to the req,
otherwise it may UAF.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
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


