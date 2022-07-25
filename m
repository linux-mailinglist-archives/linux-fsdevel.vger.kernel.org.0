Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5E57F84D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 04:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiGYCjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 22:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGYCjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:39:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16159DF87;
        Sun, 24 Jul 2022 19:39:06 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lrkh30rRszkXD4;
        Mon, 25 Jul 2022 10:36:35 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 10:39:04 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Subject: [PATCH] fsdax: Fix infinite loop in dax_iomap_rw()
Date:   Mon, 25 Jul 2022 11:20:50 +0800
Message-ID: <20220725032050.3873372-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I got an infinite loop and a WARNING report when executing a tail command
in virtiofs.

  WARNING: CPU: 10 PID: 964 at fs/iomap/iter.c:34 iomap_iter+0x3a2/0x3d0
  Modules linked in:
  CPU: 10 PID: 964 Comm: tail Not tainted 5.19.0-rc7
  Call Trace:
  <TASK>
  dax_iomap_rw+0xea/0x620
  ? __this_cpu_preempt_check+0x13/0x20
  fuse_dax_read_iter+0x47/0x80
  fuse_file_read_iter+0xae/0xd0
  new_sync_read+0xfe/0x180
  ? 0xffffffff81000000
  vfs_read+0x14d/0x1a0
  ksys_read+0x6d/0xf0
  __x64_sys_read+0x1a/0x20
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

The tail command will call read() with a count of 0. In this case,
iomap_iter() will report this WARNING, and always return 1 which casuing
the infinite loop in dax_iomap_rw().

Fixing by checking count whether is 0 in dax_iomap_rw().

Fixes: ca289e0b95af ("fsdax: switch dax_iomap_rw to use iomap_iter")
Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 fs/dax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 4155a6107fa1..7ab248ed21aa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1241,6 +1241,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t done = 0;
 	int ret;
 
+	if (!iomi.len)
+		return 0;
+
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-- 
2.30.2

