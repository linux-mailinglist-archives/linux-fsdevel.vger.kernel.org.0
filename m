Return-Path: <linux-fsdevel+bounces-9976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A6846C2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36532295E64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C37E59A;
	Fri,  2 Feb 2024 09:34:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8097868B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866466; cv=none; b=tZLNecS7ufGYNrm60Y7HsQr5qOhH8VYlMLi9zp7VuaenXemRNa6YLQuMobuWQ6BBZ6GdEyGNwlClHdhul9GV/wkktoXN36yn31DlEU6I8ZJZ6LZBPif3ShHC0qApUPJVBcoYYtq57mDCKIaJm6zniJClwfgiwVEHVyBbUTsCMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866466; c=relaxed/simple;
	bh=2loglzf8ho+WNl3WNFbqNHUlLCJyKbhRhgXaQkX4U5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvvMvCFS4h9PYaOKR6yFRg3XzR4QotvDpH4/rWt3Y1xAsKQbTOc/LcmWlsO+D+Ke4hGR9vcz+BfcQU29ZGSh0/jTATRfYqUNjlkYQJGLPutmYRxC3xpKIlYchrme2p+R8NFDwS8m9gktPYhObZwNqvabkIObSHyU4juZCp2oM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1706866448-1eb14e0c7c34d00001-kl68QG
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id itrmuT3weJpcB1hE (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 02 Feb 2024 17:34:08 +0800 (CST)
X-Barracuda-Envelope-From: JonasZhou-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 2 Feb
 2024 17:34:08 +0800
Received: from zjh-VirtualBox.zhaoxin.com (10.28.66.66) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 2 Feb 2024 17:34:07 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
	<LouisQi@zhaoxin.com>, <JonasZhou@zhaoxin.com>
Subject: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Date: Fri, 2 Feb 2024 17:34:07 +0800
X-ASG-Orig-Subj: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Message-ID: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1706866448
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6709
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0204
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120276
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

In the struct address_space, there is a 32-byte gap between i_mmap
and i_mmap_rwsem. Due to the alignment of struct address_space
variables to 8 bytes, in certain situations, i_mmap and
i_mmap_rwsem may end up in the same CACHE line.

While running Unixbench/execl, we observe high false sharing issues
when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
after i_private_list, ensuring a 64-byte gap between i_mmap and
i_mmap_rwsem.

For Intel Silver machines (2 sockets) using kernel v6.8 rc-2, the
score of Unixbench/execl improves by ~3.94%, and the score of
Unixbench/shell improves by ~3.26%.

Baseline:
-------------------------------------------------------------
  162      546      748    11374       21  0xffff92e266af90c0
-------------------------------------------------------------
        46.89%   44.65%    0.00%    0.00%                 0x0     1       1  0xffffffff86d5fb96       460       258       271     1069        32  [k] __handle_mm_fault          [kernel.vmlinux]  memory.c:2940            0  1
         4.21%    4.41%    0.00%    0.00%                 0x4     1       1  0xffffffff86d0ed54       473       311       288       95        28  [k] filemap_read               [kernel.vmlinux]  atomic.h:23              0  1
         0.00%    0.00%    0.04%    4.76%                 0x8     1       1  0xffffffff86d4bcf1         0         0         0        5         4  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:204   0  1
         6.41%    6.02%    0.00%    0.00%                 0x8     1       1  0xffffffff86d4ba85       411       271       339      210        32  [k] vma_interval_tree_insert   [kernel.vmlinux]  interval_tree.c:23       0  1
         0.00%    0.00%    0.47%   95.24%                0x10     1       1  0xffffffff86d4bd34         0         0         0       74        32  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:339   0  1
         0.37%    0.13%    0.00%    0.00%                0x10     1       1  0xffffffff86d4bb4f       328       212       380        7         5  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:338   0  1
         5.13%    5.08%    0.00%    0.00%                0x10     1       1  0xffffffff86d4bb4b       416       255       357      197        32  [k] vma_interval_tree_remove   [kernel.vmlinux]  rbtree_augmented.h:338   0  1
         1.10%    0.53%    0.00%    0.00%                0x28     1       1  0xffffffff86e06eb8       395       228       351       24        14  [k] do_dentry_open             [kernel.vmlinux]  open.c:966               0  1
         1.10%    2.14%   57.07%    0.00%                0x38     1       1  0xffffffff878c9225      1364       792       462     7003        32  [k] down_write                 [kernel.vmlinux]  atomic64_64.h:109        0  1
         0.00%    0.00%    0.01%    0.00%                0x38     1       1  0xffffffff878c8e75         0         0       252        3         2  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:109        0  1
         0.00%    0.13%    0.00%    0.00%                0x38     1       1  0xffffffff878c8e23         0       596        63        2         2  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:15         0  1
         2.38%    2.94%    6.53%    0.00%                0x38     1       1  0xffffffff878c8ccb      1150       818       570     1197        32  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:109        0  1
        30.59%   32.22%    0.00%    0.00%                0x38     1       1  0xffffffff878c8cb4       423       251       380      648        32  [k] rwsem_down_write_slowpath  [kernel.vmlinux]  atomic64_64.h:15         0  1
         1.83%    1.74%   35.88%    0.00%                0x38     1       1  0xffffffff86b4f833      1217      1112       565     4586        32  [k] up_write                   [kernel.vmlinux]  atomic64_64.h:91         0  1

with this change:
-------------------------------------------------------------
  360       12      300       57       35  0xffff982cdae76400
-------------------------------------------------------------
        50.00%   59.67%    0.00%    0.00%                 0x0     1       1  0xffffffff8215fb86       352       200       191      558        32  [k] __handle_mm_fault         [kernel.vmlinux]  memory.c:2940            0  1
         8.33%    5.00%    0.00%    0.00%                 0x4     1       1  0xffffffff8210ed44       370       284       263       42        24  [k] filemap_read              [kernel.vmlinux]  atomic.h:23              0  1
         0.00%    0.00%    5.26%    2.86%                 0x8     1       1  0xffffffff8214bce1         0         0         0        4         4  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:204   0  1
        33.33%   14.33%    0.00%    0.00%                 0x8     1       1  0xffffffff8214ba75       344       186       219      140        32  [k] vma_interval_tree_insert  [kernel.vmlinux]  interval_tree.c:23       0  1
         0.00%    0.00%   94.74%   97.14%                0x10     1       1  0xffffffff8214bd24         0         0         0       88        29  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:339   0  1
         8.33%   20.00%    0.00%    0.00%                0x10     1       1  0xffffffff8214bb3b       296       209       226      167        31  [k] vma_interval_tree_remove  [kernel.vmlinux]  rbtree_augmented.h:338   0  1
         0.00%    0.67%    0.00%    0.00%                0x28     1       1  0xffffffff82206f45         0       140       334        4         3  [k] do_dentry_open            [kernel.vmlinux]  open.c:966               0  1
         0.00%    0.33%    0.00%    0.00%                0x38     1       1  0xffffffff8250a6c4         0       286       126        5         5  [k] errseq_sample             [kernel.vmlinux]  errseq.c:125             0

Signed-off-by: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..2d6ccde5d1be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -482,10 +482,10 @@ struct address_space {
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
-	struct rw_semaphore	i_mmap_rwsem;
 	errseq_t		wb_err;
 	spinlock_t		i_private_lock;
 	struct list_head	i_private_list;
+	struct rw_semaphore	i_mmap_rwsem;
 	void *			i_private_data;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
-- 
2.25.1


