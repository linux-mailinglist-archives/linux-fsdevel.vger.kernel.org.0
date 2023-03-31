Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6556D19C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCaI0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 04:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCaIZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:25:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010A1D84F;
        Fri, 31 Mar 2023 01:25:43 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PntZ63ZxnzgZTg;
        Fri, 31 Mar 2023 16:22:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] fs: fix sysctls.c built
Date:   Fri, 31 Mar 2023 16:45:02 +0800
Message-ID: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
or it won't be built as it is overwrited.

Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 05f89b5c962f..8d4736fcc766 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -6,7 +6,6 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-$(CONFIG_SYSCTL)		+= sysctls.o
 
 obj-y :=	open.o read_write.o file_table.o super.o \
 		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
@@ -50,7 +49,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 obj-$(CONFIG_COREDUMP)		+= coredump.o
-obj-$(CONFIG_SYSCTL)		+= drop_caches.o
+obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-y				+= iomap/
-- 
2.35.3

