Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31E3E8AA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHKG4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 02:56:49 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49344 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234878AbhHKG4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:56:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UifR06g_1628664983;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UifR06g_1628664983)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Aug 2021 14:56:23 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [virtiofsd PATCH v2 4/4] virtiofsd: support per-file DAX in FUSE_LOOKUP
Date:   Wed, 11 Aug 2021 14:56:21 +0800
Message-Id: <20210811065621.12737-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210811065621.12737-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
 <20210811065621.12737-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For passthrough, when the corresponding virtiofs in guest is mounted
with '-o dax=inode', advertise that the file is capable of per-file
DAX if the inode in the backend fs is marked with FS_DAX_FL flag.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 5b6228210f..8904fa73e0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -171,6 +171,7 @@ struct lo_data {
     int allow_direct_io;
     int announce_submounts;
     int perfile_dax_cap; /* capability of backend fs */
+    bool perfile_dax; /* enable per-file DAX or not */
     bool use_statx;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
@@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
 
     if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
         conn->want |= FUSE_CAP_PERFILE_DAX;
+	lo->perfile_dax = 1;
+    }
+    else {
+	lo->perfile_dax = 0;
     }
 }
 
@@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
     return 0;
 }
 
+/*
+ * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
+ * enabled for this file.
+ */
+static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
+				 const char *name)
+{
+    int res, fd;
+    int ret = false;;
+    unsigned int attr;
+    struct fsxattr xattr;
+
+    if (!lo->perfile_dax)
+	return false;
+
+    /* Open file without O_PATH, so that ioctl can be called. */
+    fd = openat(dir->fd, name, O_NOFOLLOW);
+    if (fd == -1)
+        return false;
+
+    if (lo->perfile_dax_cap == DAX_FLAG_FLAGS) {
+        res = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+        if (!res && (attr & FS_DAX_FL))
+	    ret = true;
+    }
+    else if (lo->perfile_dax_cap == DAX_FLAG_XATTR) {
+	res = ioctl(fd, FS_IOC_FSGETXATTR, &xattr);
+	if (!res && (xattr.fsx_xflags & FS_XFLAG_DAX))
+	    ret = true;
+    }
+
+    close(fd);
+    return ret;
+}
+
 /*
  * Increments nlookup on the inode on success. unref_inode_lolocked() must be
  * called eventually to decrement nlookup again. If inodep is non-NULL, the
@@ -1038,6 +1078,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         e->attr_flags |= FUSE_ATTR_SUBMOUNT;
     }
 
+    if (lo_should_enable_dax(lo, dir, name))
+	e->attr_flags |= FUSE_ATTR_DAX;
+
     inode = lo_find(lo, &e->attr, mnt_id);
     if (inode) {
         close(newfd);
-- 
2.27.0

