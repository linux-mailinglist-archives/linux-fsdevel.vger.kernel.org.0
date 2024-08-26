Return-Path: <linux-fsdevel+bounces-27087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8796F95E787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED03B209DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 04:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F646450;
	Mon, 26 Aug 2024 04:05:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A308C1F;
	Mon, 26 Aug 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645123; cv=none; b=kdZrcD5PEhyTzUsDw9bZo06uzlHUR9z9VKX3XYhuk3+DQ8s9cmyJjqrFxyP8it2MlsKTDt4MxVghEzssXE1A+Xyzpu4IJ2AUzprcHLsJ5ufwS6bhcEbIMv3hs1Sds9rOyKjxXj7Vu9VJy13eVeb2QYm0AvwkbCGXTNkgCUFDKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645123; c=relaxed/simple;
	bh=fPfRbYjyDO34aJFbbBoB95r71qblCD+PaqR0mwZcbkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fd35LGo0mdDaTJub+453M8dbYUwjcHuli9NyBrI6XCajJdaDPxCaKXCu1jg9PM5T3CEiZLWm72MZbtVjcxNHGC2LjIrt9aEc7Mrhk0q8SAuuUoygqAAS7l/ePg9Fsv+ThNlVVmW+VD7Z6iFAgY4Q0cg7NPdhWjthVi8lJEdpMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WscWz1XWHz4f3jMy;
	Mon, 26 Aug 2024 12:05:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A63161A1305;
	Mon, 26 Aug 2024 12:05:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4X7_stmGK71Cg--.11259S4;
	Mon, 26 Aug 2024 12:05:17 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Mon, 26 Aug 2024 12:00:18 +0800
Message-Id: <20240826040018.2990763-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4X7_stmGK71Cg--.11259S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7Cw1xCr4rWr43Gw1UAwb_yoW8uw4fpF
	ZIyryxGryrury8Gr48JF1rtr1rJ347JF4qqw1kXr18Ar1DZr1rXr17tr1FqryUGrWUZr42
	qF1UK343Jr1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYpnQUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAHBWbK6v869gAAs2

From: Baokun Li <libaokun1@huawei.com>

In ondemand mode, dentry leaks may be caused when the mount has the
following concurrency with cull:

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

Add the missing dput() to cachefiles_open_file() for a quick fix.

Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..0bd2f367c3ff 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -554,6 +554,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
 			  dentry, d_inode(dentry)->i_ino);
+		dput(dentry);
 		return false;
 	}
 
-- 
2.39.2


