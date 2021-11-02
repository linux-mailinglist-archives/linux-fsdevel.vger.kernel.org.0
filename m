Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2554426AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 06:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKBF2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 01:28:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37827 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhKBF2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:28:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UuhHU.o_1635830765;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UuhHU.o_1635830765)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 13:26:06 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v7 3/7] fuse: support per inode DAX in fuse protocol
Date:   Tue,  2 Nov 2021 13:26:00 +0800
Message-Id: <20211102052604.59462-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
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
 include/uapi/linux/fuse.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..4ebe06091988 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -184,6 +184,9 @@
  *
  *  7.34
  *  - add FUSE_SYNCFS
+ *
+ *  7.35
+ *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
  */
 
 #ifndef _LINUX_FUSE_H
@@ -219,7 +222,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 34
+#define FUSE_KERNEL_MINOR_VERSION 35
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -336,6 +339,7 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_HAS_INODE_DAX:  use per inode DAX
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -367,6 +371,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_HAS_INODE_DAX	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
@@ -449,8 +454,10 @@ struct fuse_file_lock {
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

