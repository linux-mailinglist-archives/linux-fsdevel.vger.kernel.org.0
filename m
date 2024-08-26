Return-Path: <linux-fsdevel+bounces-27143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C395EFD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D0E28128C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF301547D8;
	Mon, 26 Aug 2024 11:35:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A214D6ED;
	Mon, 26 Aug 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672114; cv=none; b=mBq9lyiJDoM1xrxGA321hw2Qzo8XOgSmpVjtG7N/CDrYWRDIn5nKQH26MSN+mYWEvj9MZakRNnCIygaqlSbRzfyIEBlyuZLqqriNYPGm5jjf+p5aUGsnqv7CojSLrsCa6Q3cYTP66ENKneKnRRocdp35+HEhRrsLriU+CrcEcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672114; c=relaxed/simple;
	bh=mLBT6mTdBJnwc+dF9PGzGVBQ3Av2W02Ffrkq0yV/usw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rzeP4oXzKg8r88RTvmUQgvY1Hz7zVzyk+gDSggIr8kYL3wX9+iAH8TLu0U7glUPZHM/6Etm0uQK9P9ED1suO8gjNwNc0eEQa2v9Ng4XGxcz537BwH0zfgnX+Qk90NOQa+Z4vqAj/WkKWdPK3vnPc7LkSmb7T5lYB8XN+wp9Wxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WspW06z8yz4f3jHh;
	Mon, 26 Aug 2024 19:34:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E72F1A0568;
	Mon, 26 Aug 2024 19:35:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4VoaMxmkUITCw--.22524S4;
	Mon, 26 Aug 2024 19:35:07 +0800 (CST)
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
Subject: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Date: Mon, 26 Aug 2024 19:34:04 +0800
Message-Id: <20240826113404.3214786-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4VoaMxmkUITCw--.22524S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xXr1kCFyxXr1UCrWxJFb_yoW8ZFWxp3
	ZrZryxGr1jqryUJF45Ja1Utr1UZF1qg3W7GryxCr1fZan7Aw1UX3W0qr15ZFy2kF48AFs8
	t3W8trnYvr15Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1bdb5UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEIwADs+

From: Baokun Li <libaokun1@huawei.com>

In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
deleting its subtree. This triggers the following WARNING:

==================================================================
remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
Modules linked in: netfs(-)
CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
RIP: 0010:remove_proc_entry+0x160/0x1c0
Call Trace:
 <TASK>
 netfs_exit+0x12/0x620 [netfs]
 __do_sys_delete_module.isra.0+0x14c/0x2e0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

Therefore use remove_proc_subtree instead() of remove_proc_entry() to
fix the above problem.

Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/netfs/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..9d6b49dc6694 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -142,7 +142,7 @@ static int __init netfs_init(void)
 
 error_fscache:
 error_procfile:
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 error_proc:
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
@@ -159,7 +159,7 @@ fs_initcall(netfs_init);
 static void __exit netfs_exit(void)
 {
 	fscache_exit();
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 	mempool_exit(&netfs_subrequest_pool);
 	kmem_cache_destroy(netfs_subrequest_slab);
 	mempool_exit(&netfs_request_pool);
-- 
2.39.2


