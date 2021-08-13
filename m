Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67AD3EB35B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbhHMJdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbhHMJdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:33:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C075C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 02:32:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so19874896pjs.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7umm9KfWSyLHlDYxo1zCTl5LX48KSYo4CEhjnBq0SX8=;
        b=rI0s8gs/mDWIJnKDkgqkM+e9jnAwMElbrtN4XpfOD8iQXPOknOjvicsqtK3nDtdNLl
         BOF6PV81Q8Wt0AhAIw4hJMY70xTLfkpxsSRbJFAKH9XFlPUoDyrWZ+MQrxro6eMRcvbY
         dWoKQXo3dhXDtGLxpX93Dr+LIgsN52seCT6lrNmHvmCBGATwp24txruqgFjuTHjSkYPY
         Qpo54yLwf9NxHPexYxWRyu526O/DTaz9Ik2QvrZKJzFGjIMq19wwvCayi90jqys7SDjw
         +SPz6E4pUNmUp41qVyyW5/brag+IhJabFPMMl0JKrTjsmliAwznWG+M7jv6FJ90rppfb
         6MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7umm9KfWSyLHlDYxo1zCTl5LX48KSYo4CEhjnBq0SX8=;
        b=Gl4vre71d30Uq2+lwxDkCvZV2/wdbeyvWnYrpKBL+oqCC4Zm7DUC0nQiMqboTmgLPr
         YWCYGby4aQ6FyJvMOaLONXpipBNTgHqD0Ns1u87jNMMI5W3JdC+Z6fgbUiesrFcnj9bB
         6wnFHzGVCJ9PmdxBwaKn4PwCQapr7Am95+pr8wsqnuSwVTgrykgIzSQ7OVbTg259gKYR
         kCBDJ+/FGQe2JansOFHBfXiA/gsQqYoPZUr7qpvur+c+nmbDU5YISoAIev7mTY1WG0eW
         tcDcMKo/7GyBeszF6Pqza5ff+pXi/CKgfTNknGimrHtUzYPXrkVOVj6whU3RBOw33IWl
         ICQg==
X-Gm-Message-State: AOAM532m1qWONmALFWkIeYpm6ySp4CspBi5mCiIM0OuiqrgxudCN+WYV
        2y+3kIOW7kwhG6VAxo870gdO
X-Google-Smtp-Source: ABdhPJzwLs+j3fmnPcXOYF4+/OLOcq3sQ9WpXad+k+vMckgH3KA3SqU3F3Ip6CLdG2vP4NSTwePCFw==
X-Received: by 2002:a05:6a00:1796:b029:3c4:25d6:9ee1 with SMTP id s22-20020a056a001796b02903c425d69ee1mr1650626pfg.21.1628847157999;
        Fri, 13 Aug 2021 02:32:37 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b128sm1535440pfb.144.2021.08.13.02.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 02:32:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
Date:   Fri, 13 Aug 2021 17:31:55 +0800
Message-Id: <20210813093155.45-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The invalidate_inode_pages2() might be called with FUSE_NOWRITE
set in fuse_finish_open(), which can lead to deadlock in
fuse_launder_page().

To fix it, this tries to delay calling invalidate_inode_pages2()
until FUSE_NOWRITE is removed.

Fixes: e4648309b85a ("fuse: truncate pending writes on O_TRUNC")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 19 +++++++++++++++----
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index eade6f965b2e..d919c3e89cb0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -548,7 +548,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		fuse_sync_release(fi, ff, flags);
 	} else {
 		file->private_data = ff;
-		fuse_finish_open(inode, file);
+		fuse_finish_open(inode, file, false);
 	}
 	return err;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 97f860cfc195..035af9c88eaf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -193,12 +193,12 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
-void fuse_finish_open(struct inode *inode, struct file *file)
+void fuse_finish_open(struct inode *inode, struct file *file, bool no_write)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+	if (!(ff->open_flags & FOPEN_KEEP_CACHE) && !no_write)
 		invalidate_inode_pages2(inode->i_mapping);
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
@@ -229,6 +229,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 			  fc->writeback_cache;
 	bool dax_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc && FUSE_IS_DAX(inode);
+	bool keep_cache = true;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -250,8 +251,12 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	}
 
 	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
-	if (!err)
-		fuse_finish_open(inode, file);
+	if (!err) {
+		struct fuse_file *ff = file->private_data;
+
+		fuse_finish_open(inode, file, is_wb_truncate | dax_truncate);
+		keep_cache = ff->open_flags & FOPEN_KEEP_CACHE;
+	}
 
 out:
 	if (dax_truncate)
@@ -259,6 +264,12 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 
 	if (is_wb_truncate | dax_truncate) {
 		fuse_release_nowrite(inode);
+		/*
+		 * Only call invalidate_inode_pages2() after removing
+		 * FUSE_NOWRITE, otherwise fuse_launder_page() would deadlock.
+		 */
+		if (!keep_cache)
+			invalidate_inode_pages2(inode->i_mapping);
 		inode_unlock(inode);
 	}
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 07829ce78695..8a8830e2cc7f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -969,7 +969,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
 void fuse_file_free(struct fuse_file *ff);
-void fuse_finish_open(struct inode *inode, struct file *file);
+void fuse_finish_open(struct inode *inode, struct file *file, bool no_write);
 
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
-- 
2.11.0

