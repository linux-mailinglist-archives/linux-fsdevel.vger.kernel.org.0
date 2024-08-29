Return-Path: <linux-fsdevel+bounces-27780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0066963EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBFE1C243A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDF18C344;
	Thu, 29 Aug 2024 08:35:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF50189F36;
	Thu, 29 Aug 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920535; cv=none; b=YmE5nw44NRUKkRitQ3KLXAELZqRFDYHtLrOHim54GAjkloGFKE8T8TeLifRHWAs/mtOO7HUMXFGVMaIDop/DSEiIzYKJj3zyf6eMlrlqN8NzYTD6b2maNh4wcY5mLLOX3Lx6zkRRZmKRwiQGPAaE9/vH0M7FOqfE9qVS0zgI6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920535; c=relaxed/simple;
	bh=08PKGA+fUzd0s7QRwGYtG0cpzGpgl+u8V4qYLR6fTnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHgNcREPq3ejXs8U9HPi0JWHpUoocgvY3/yb+IrQeTK8WIP0qtPFrMG0To6kO2jJ0Q7HGtdLbICjZ7rDsqSIOCR2C9piD0Z6zv+ZfA8A0EdvwHmWHHBzrZTiIceLTnwAsJ/IovKLBXm/7Trg40harrLC2iU3RP5RJzjXj2o8ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WvZNM1FFNz4f3kFL;
	Thu, 29 Aug 2024 16:35:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9E841A0FA3;
	Thu, 29 Aug 2024 16:35:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4XNMtBmyzYkDA--.10163S4;
	Thu, 29 Aug 2024 16:35:27 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Thu, 29 Aug 2024 16:34:09 +0800
Message-Id: <20240829083409.3788142-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4XNMtBmyzYkDA--.10163S4
X-Coremail-Antispam: 1UD129KBjvJXoWxury8ZF45AFW8Zw1DCw4kJFb_yoW5ZF15pF
	ZayFyxJryrWrWkGr48AFnYqr1rA3yjqF1DX3Z5Wr1kAr1qvr1aqr17tr1Fqry5GrZ7Ar42
	qF1UCa43JryjkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbTGQDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWbO339ALgABsp

From: Baokun Li <libaokun1@huawei.com>

A dentry leak may be caused when a lookup cookie and a cull are concurrent:

            P1             |             P2
-----------------------------------------------------------
cachefiles_lookup_cookie
  cachefiles_look_up_object
    lookup_one_positive_unlocked
     // get dentry
                            cachefiles_cull
                              inode->i_flags |= S_KERNEL_FILE;
    cachefiles_open_file
      cachefiles_mark_inode_in_use
        __cachefiles_mark_inode_in_use
          can_use = false
          if (!(inode->i_flags & S_KERNEL_FILE))
            can_use = true
	  return false
        return false
        // Returns an error but doesn't put dentry

After that the following WARNING will be triggered when the backend folder
is umounted:

==================================================================
BUG: Dentry 000000008ad87947{i=7a,n=Dx_1_1.img}  still in use (1) [unmount of ext4 sda]
WARNING: CPU: 4 PID: 359261 at fs/dcache.c:1767 umount_check+0x5d/0x70
CPU: 4 PID: 359261 Comm: umount Not tainted 6.6.0-dirty #25
RIP: 0010:umount_check+0x5d/0x70
Call Trace:
 <TASK>
 d_walk+0xda/0x2b0
 do_one_tree+0x20/0x40
 shrink_dcache_for_umount+0x2c/0x90
 generic_shutdown_super+0x20/0x160
 kill_block_super+0x1a/0x40
 ext4_kill_sb+0x22/0x40
 deactivate_locked_super+0x35/0x80
 cleanup_mnt+0x104/0x160
==================================================================

Whether cachefiles_open_file() returns true or false, the reference count
obtained by lookup_positive_unlocked() in cachefiles_look_up_object()
should be released.

Therefore release that reference count in cachefiles_look_up_object() to
fix the above issue and simplify the code.

Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
v1->v2:
	Use of new solution.

v1: https://lore.kernel.org/r/20240826040018.2990763-1-libaokun@huaweicloud.com

 fs/cachefiles/namei.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..2b3f9935dbb4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -595,14 +595,12 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 * write and readdir but not lookup or open).
 	 */
 	touch_atime(&file->f_path);
-	dput(dentry);
 	return true;
 
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
 	fput(file);
-	dput(dentry);
 	if (ret == -ESTALE)
 		return cachefiles_create_file(object);
 	return false;
@@ -611,7 +609,6 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	fput(file);
 error:
 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
-	dput(dentry);
 	return false;
 }
 
@@ -654,7 +651,9 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 		goto new_file;
 	}
 
-	if (!cachefiles_open_file(object, dentry))
+	ret = cachefiles_open_file(object, dentry);
+	dput(dentry);
+	if (!ret)
 		return false;
 
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
-- 
2.39.2


