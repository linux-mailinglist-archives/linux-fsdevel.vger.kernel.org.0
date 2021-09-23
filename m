Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB4415B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhIWJhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:37:21 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50533 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240204AbhIWJhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:37:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpK3fFP_1632389746;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpK3fFP_1632389746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 17:35:47 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [virtiofsd PATCH v5 2/2] virtiofsd: support per-file DAX
Date:   Thu, 23 Sep 2021 17:35:45 +0800
Message-Id: <20210923093545.81512-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923093545.81512-1-jefflexu@linux.alibaba.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923093545.81512-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When DAX window is fully utilized and needs to be exapnded to avoid the
performance fluctuation triggered by DAX window recaliming, it may not
be wise to allocate DAX window for files with size smaller than some
specific point, considering from the perspective of reducing memory
overhead.

To maintain one DAX window chunk (e.g., 2MB in size), 32KB
(512 * 64 bytes) memory footprint will be consumed for page descriptors
inside guest. Thus it'd better disable DAX for those files smaller than
32KB, to reduce the demand for DAX window and thus avoid the unworthy
memory overhead.

Thus only flag the file with FUSE_ATTR_DAX when the file size is greater
than 32 KB. The guest will enable DAX only for those files flagged with
FUSE_ATTR_DAX, when virtiofs is mounted with '-o dax=inode'.

To be noted that both FUSE_LOOKUP and FUSE_READDIRPLUS are affected, and
will convey FUSE_ATTR_DAX flag to the guest.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index b76d878509..6893180c6b 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -53,12 +53,26 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
+#include <sys/user.h>
 #include <syslog.h>
 
 #include "qemu/cutils.h"
 #include "passthrough_helpers.h"
 #include "passthrough_seccomp.h"
 
+/*
+ * One page descriptor (64 bytes in size) needs to be maintained for every page
+ * in the DAX window chunk, i.e., there is certain guest memory overhead when
+ * DAX is enabled. Thus disable DAX for those files smaller than this certain
+ * memory overhead if virtiofs is mounted in per-file DAX mode, in which case
+ * the guest page cache will consume less memory when DAX is disabled.
+ */
+#define FUSE_DAX_SHIFT	21
+#define PAGE_DESC_SHIFT	6
+#define FUSE_PERFILE_DAX_SHIFT \
+    (FUSE_DAX_SHIFT - PAGE_SHIFT + PAGE_DESC_SHIFT)
+#define FUSE_PERFILE_DAX_POINT	(1 << FUSE_PERFILE_DAX_SHIFT)
+
 /* Keep track of inode posix locks for each owner. */
 struct lo_inode_plock {
     uint64_t lock_owner;
@@ -1023,6 +1037,11 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         e->attr_flags |= FUSE_ATTR_SUBMOUNT;
     }
 
+    if (S_ISREG(e->attr.st_mode) &&
+        (e->attr.st_size > FUSE_PERFILE_DAX_POINT)) {
+        e->attr_flags |= FUSE_ATTR_DAX;
+    }
+
     inode = lo_find(lo, &e->attr, mnt_id);
     if (inode) {
         close(newfd);
-- 
2.27.0

