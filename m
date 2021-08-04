Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD33F3DFC0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhHDHY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 03:24:27 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40243 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235857AbhHDHY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:24:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uhx5.Yu_1628061851;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uhx5.Yu_1628061851)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:24:12 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH virtiofsd 2/3] virtiofsd: support per-file DAX negotiation in FUSE_INIT
Date:   Wed,  4 Aug 2021 15:24:10 +0800
Message-Id: <20210804072411.1180-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804072411.1180-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
 <20210804072411.1180-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/fuse_common.h    | 5 +++++
 tools/virtiofsd/fuse_lowlevel.c  | 6 ++++++
 tools/virtiofsd/passthrough_ll.c | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 8a75729be9..ee6fc64c23 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -372,6 +372,11 @@ struct fuse_file_info {
  */
 #define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 28)
 
+/**
+ * Indicates support for per-file DAX.
+ */
+#define FUSE_CAP_PERFILE_DAX (1 << 29)
+
 /**
  * Ioctl flags
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 50fc5c8d5a..60fb82a92a 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2065,6 +2065,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
         se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
     }
+    if (arg->flags & FUSE_PERFILE_DAX) {
+        se->conn.capable |= FUSE_CAP_PERFILE_DAX;
+    }
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
     se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
@@ -2180,6 +2183,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (se->conn.want & FUSE_CAP_POSIX_ACL) {
         outarg.flags |= FUSE_POSIX_ACL;
     }
+    if (se->conn.want & FUSE_CAP_PERFILE_DAX) {
+        outarg.flags |= FUSE_PERFILE_DAX;
+    }
     outarg.max_readahead = se->conn.max_readahead;
     outarg.max_write = se->conn.max_write;
     if (se->conn.max_background >= (1 << 16)) {
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index b76d878509..da88304253 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -702,6 +702,9 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
         conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
         lo->killpriv_v2 = 0;
     }
+    if (conn->capable & FUSE_CAP_PERFILE_DAX) {
+        conn->want |= FUSE_CAP_PERFILE_DAX;
+    }
 }
 
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
-- 
2.27.0

