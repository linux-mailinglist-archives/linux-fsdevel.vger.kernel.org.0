Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC880433B8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhJSQFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhJSQFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:05:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0970C061749
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 09:03:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so5939526plr.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/jsHVQAvNzunGQb0wziwjY53g/EPbrMKbfjiqPl4Gc=;
        b=G4sSHUkJ8erVD2b59qOEY744aPEFAe9AohmIJVKL1ypzhMaHxSBPQuCebyfM0Fwe5M
         6YQpZBfsWF0I9i41yUbXiVo3xUcNw9pDd1ahgl75/3yJo22iqJaHBzRL26O6WmJ4dsqD
         CTgAaJNuxDFy8v2WwZ8OQhvASl8w6RNxDdyowUT0CKQIWgYmdvnUa91M3uVcAf2tJfwJ
         mX7SLbwC8pdJ17FRyL9wIcomyif0V8fYa6lrRo5ERO6JFNOgSOqSB4m6IlcLZhm33Cx+
         JZ6Rgh+H2cb6efDMIlObcliMmRSEOxDXw9HFz/btrelBKpFSmwPMGrPBCKeCyE8BgFFk
         0P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/jsHVQAvNzunGQb0wziwjY53g/EPbrMKbfjiqPl4Gc=;
        b=BPVXqWfZCLKgXeJXzjsvjzQ6zM2q3m5UEmGl051ZrbS6L7YB1XvtunPunD1igZNDwu
         RHAcCylormPv07GUEMS1a4ujCzTALJYeoLDeRHmBt+f0il1TrAol5tH0X5oqRWhoAUmk
         p+8DRnUR2X44uhB4aEBUz2OoMAiMVwJTylPBRd6ceJ6k2ZaDUHa8KYBbp//wWKy6N3ND
         lfpigXi4bFgqCOAnHWjAZmtNdXE8PMORdgsh3nOYR+hCSARIBQJdoixwJbpKwLCLuch6
         0XWo9NcGMNGZUImpFtHhVtkGCgIrGY+KNzXpQJCLaIOce3AAI3DI2TMQ+99Y7yRpsrWn
         OJ7Q==
X-Gm-Message-State: AOAM532ujEaSPg0UqASfnIejp9keFB5faaxYx+rL5t/nG1Tfllo6Vri4
        4zyryfIKUVxaaRCKn+NgmFlLbw==
X-Google-Smtp-Source: ABdhPJztw8G4kVbaF5witZLdYipqlYZuPBgEMLJep81ouknAKZ0Uhj1CKGz1mA+hiNDUWYV4H2SO1g==
X-Received: by 2002:a17:903:22d0:b0:13f:507:6414 with SMTP id y16-20020a17090322d000b0013f05076414mr34148954plg.69.1634659387661;
        Tue, 19 Oct 2021 09:03:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 66sm16431749pfu.185.2021.10.19.09.03.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:03:07 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [RFCv2] fuse: Sync attributes when the inode is clean in writeback mode
Date:   Wed, 20 Oct 2021 00:02:51 +0800
Message-Id: <20211019160251.6728-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the RFCv2 version of this patch. Compared with the previous
version, v2 based on the latest fuse for-next branch commit 83d9bf94c077
("fuse: add cache_mask"). With the new cleanups and fuse interfaces, this
commit is more clean compared with v1 [1].

The propose of this commit is still to relax the c/mtime and size updating
for writeback_cache mode. Because when writeback cache is enabled, kernel
will locally maintain the attributes, and never trusts any server side
attribute changes. This limitaion is too strict in some use cases. For
example, if a file is not actively wrote from the fuse mount in writeback
mode, the writeback related caches should be clean, and the user may expect
to see the new size changed from the server side. This commit tires to
relax the limitation.

If there is no dirty page of an fuse inode, update its ctime, atime and
size even in writeback_cache mode. The page cache cleaness checking is
based on a new fuse writeback helper (fuse_file_is_writeback_locked) and a
mm/filemap helper introduced in a recent commit 63135aa3866d ("mm: provide
filemap_range_needs_writeback() helper").

[1] https://patchwork.kernel.org/project/linux-fsdevel/patch/20211012145558.19137-1-zhangjiachen.jaycee@bytedance.com/

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c   | 21 +++++++++++++++++++++
 fs/fuse/fuse_i.h |  1 +
 fs/fuse/inode.c  | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bc450daf27a2..635624d65c76 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -412,6 +412,27 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
 	return NULL;
 }
 
+/*
+ * Check if any page of this file is under writeback.
+ *
+ * The fuse_inode lock should be held by the caller.
+ */
+bool fuse_file_is_writeback_locked(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	pgoff_t idx_from = 0;
+	pgoff_t idx_to = 0;
+	size_t fuse_inode_size = i_size_read(inode);
+	bool found;
+
+	if (fuse_inode_size > 0)
+		idx_to = (fuse_inode_size - 1) >> PAGE_SHIFT;
+
+	found = fuse_find_writeback(fi, idx_from, idx_to);
+
+	return found;
+}
+
 /*
  * Check if any page in a range is under writeback
  *
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 119459ad9e50..dbb2a5ae99b6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1288,5 +1288,6 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
+bool fuse_file_is_writeback_locked(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1620bf01246..72316ca5ecca 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/fs.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -244,8 +245,17 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	 * In case of writeback_cache enabled, writes update mtime, ctime and
 	 * may update i_size.  In these cases trust the cached value in the
 	 * inode.
+	 *
+	 * One expection is if the page cache is clean and there is no in-flight
+	 * fuse writeback request. The c/mtime and file size are allowed to be
+	 * updated from server, so clear cache_mask in this case.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
+	if (!filemap_range_needs_writeback(inode->i_mapping, 0,
+	    i_size_read(inode) - 1) && !fuse_file_is_writeback_locked(inode)) {
+		cache_mask = 0;
+	}
+
 	if (cache_mask & STATX_SIZE)
 		attr->size = i_size_read(inode);
 
-- 
2.20.1

