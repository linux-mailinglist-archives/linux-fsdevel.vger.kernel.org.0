Return-Path: <linux-fsdevel+bounces-19966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADB58CBA0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D27283EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBE80C0B;
	Wed, 22 May 2024 03:50:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B97F490;
	Wed, 22 May 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349810; cv=none; b=DpU4OLK46gVtaMKK/3fl8AP8V0nsyseA5IdZLQ1Iwtw5+AJe1NyhP5u/wi13W/RUWgNfT9cy14pWM/MqdKH9dUt7dH6v+XC0hxHJIQFBtt+nJPlp32jDBbpvv4cWuX7Rj8xAPvSmb4TkDlkyUEH8ZQCPw5jh/vkHQPK8li3ZyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349810; c=relaxed/simple;
	bh=C3dcc3/dQ/ZZ35tL5MVsxVaIIQIaghLTl/2rFOKtXI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sC4LqzaU1IPPoK4CwO6Oa8VEFmm3us2cjwI1BrdfZuPq7aQV6eRnEHzld3ZUrvr07I/RvRNJD7tOagSdBkKlwwh3crQ73WpgQWj7oEyHpcfrnnsKitjE3/FeKY/4/3ZTgquTzls4tbf+XMAAxPsUrSZIcyb+9q7N/ukhitwnR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkckp0t5qz4f3jqB;
	Wed, 22 May 2024 11:49:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E257F1A0199;
	Wed, 22 May 2024 11:49:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFea01mxlBXNQ--.57627S13;
	Wed, 22 May 2024 11:49:59 +0800 (CST)
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
Subject: [PATCH v3 09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
Date: Wed, 22 May 2024 19:43:05 +0800
Message-Id: <20240522114308.2402121-10-libaokun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFea01mxlBXNQ--.57627S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfGw1fCF17XFyDCFy7Awb_yoW7JF1UpF
	WakFy7Kry8WF48ur97Ars8ZryfC34kA3ZrW3s0g34rArnIgr1Fvr1jyr9xuF15Ar97Grsx
	tr4UuasxKr1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRupB-UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

After installing the anonymous fd, we can now see it in userland and close
it. However, at this point we may not have gotten the reference count of
the cache, but we will put it during colse fd, so this may cause a cache
UAF.

So grab the cache reference count before fd_install(). In addition, by
kernel convention, fd is taken over by the user land after fd_install(),
and the kernel should not call close_fd() after that, i.e., it should call
fd_install() after everything is ready, thus fd_install() is called after
copy_to_user() succeeds.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d2d4e27fca6f..6f815e7c5086 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -4,6 +4,11 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+struct ondemand_anon_file {
+	struct file *file;
+	int fd;
+};
+
 static inline void cachefiles_req_put(struct cachefiles_req *req)
 {
 	if (refcount_dec_and_test(&req->ref))
@@ -263,14 +268,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
 	return 0;
 }
 
-static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
+				      struct ondemand_anon_file *anon_file)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_open *load;
-	struct file *file;
 	u32 object_id;
-	int ret, fd;
+	int ret;
 
 	object = cachefiles_grab_object(req->object,
 			cachefiles_obj_get_ondemand_fd);
@@ -282,16 +287,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	if (ret < 0)
 		goto err;
 
-	fd = get_unused_fd_flags(O_WRONLY);
-	if (fd < 0) {
-		ret = fd;
+	anon_file->fd = get_unused_fd_flags(O_WRONLY);
+	if (anon_file->fd < 0) {
+		ret = anon_file->fd;
 		goto err_free_id;
 	}
 
-	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
-				  object, O_WRONLY);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
+	anon_file->file = anon_inode_getfile("[cachefiles]",
+				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
+	if (IS_ERR(anon_file->file)) {
+		ret = PTR_ERR(anon_file->file);
 		goto err_put_fd;
 	}
 
@@ -299,16 +304,15 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	if (object->ondemand->ondemand_id > 0) {
 		spin_unlock(&object->ondemand->lock);
 		/* Pair with check in cachefiles_ondemand_fd_release(). */
-		file->private_data = NULL;
+		anon_file->file->private_data = NULL;
 		ret = -EEXIST;
 		goto err_put_file;
 	}
 
-	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
-	fd_install(fd, file);
+	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 
 	load = (void *)req->msg.data;
-	load->fd = fd;
+	load->fd = anon_file->fd;
 	object->ondemand->ondemand_id = object_id;
 	spin_unlock(&object->ondemand->lock);
 
@@ -317,9 +321,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	return 0;
 
 err_put_file:
-	fput(file);
+	fput(anon_file->file);
+	anon_file->file = NULL;
 err_put_fd:
-	put_unused_fd(fd);
+	put_unused_fd(anon_file->fd);
+	anon_file->fd = ret;
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
@@ -376,6 +382,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	struct cachefiles_msg *msg;
 	size_t n;
 	int ret = 0;
+	struct ondemand_anon_file anon_file;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
 	xa_lock(&cache->reqs);
@@ -409,7 +416,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xa_unlock(&cache->reqs);
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
-		ret = cachefiles_ondemand_get_fd(req);
+		ret = cachefiles_ondemand_get_fd(req, &anon_file);
 		if (ret)
 			goto out;
 	}
@@ -417,10 +424,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	msg->msg_id = xas.xa_index;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
-	if (copy_to_user(_buffer, msg, n) != 0) {
+	if (copy_to_user(_buffer, msg, n) != 0)
 		ret = -EFAULT;
-		if (msg->opcode == CACHEFILES_OP_OPEN)
-			close_fd(((struct cachefiles_open *)msg->data)->fd);
+
+	if (msg->opcode == CACHEFILES_OP_OPEN) {
+		if (ret < 0) {
+			fput(anon_file.file);
+			put_unused_fd(anon_file.fd);
+			goto out;
+		}
+		fd_install(anon_file.fd, anon_file.file);
 	}
 out:
 	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
-- 
2.39.2


