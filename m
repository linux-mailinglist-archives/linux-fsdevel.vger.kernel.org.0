Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5055D45D51C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 08:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbhKYHKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:47 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59234 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352571AbhKYHIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyF6gzd_1637823933;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UyF6gzd_1637823933)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 15:05:33 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v8 3/7] fuse: support per inode DAX in fuse protocol
Date:   Thu, 25 Nov 2021 15:05:26 +0800
Message-Id: <20211125070530.79602-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expand the fuse protocol to support per inode DAX.

FUSE_HAS_INODE_DAX flag is added indicating if fuse server/client
supporting per inode DAX. It can be conveyed in both FUSE_INIT request
and reply.

FUSE_ATTR_DAX flag is added indicating if DAX shall be enabled for
corresponding file. It is conveyed in FUSE_LOOKUP reply.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/uapi/linux/fuse.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a1dc3ee1d17c..63a9a963f4d9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -187,6 +187,7 @@
  *
  *  7.35
  *  - add FOPEN_NOFLUSH
+ *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
  */
 
 #ifndef _LINUX_FUSE_H
@@ -341,6 +342,7 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_HAS_INODE_DAX:  use per inode DAX
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -372,6 +374,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_HAS_INODE_DAX	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
@@ -454,8 +457,10 @@ struct fuse_file_lock {
  * fuse_attr flags
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
+ * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX		(1 << 1)
 
 /**
  * Open flags
-- 
2.27.0

