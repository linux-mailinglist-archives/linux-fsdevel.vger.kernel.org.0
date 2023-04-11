Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9877B6DDDE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDKO2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjDKO1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DA4680;
        Tue, 11 Apr 2023 07:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8123F627A7;
        Tue, 11 Apr 2023 14:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036DCC433EF;
        Tue, 11 Apr 2023 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223231;
        bh=Awb6q4i/Q5m9mXXhrXc+BP9AQEQgndLooZSbj9YNpPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Elt7PpUmN0Sf29ltkewWu6mezvigmPVjaCJ1Pxmswax9INQvsH/Q5/v+Fzlomn9BX
         fQrHnCzxZwcyaI2LVGbjh/nxPiZeknvdVI/SmuK1yQ728RCdLvTYkpM6Mx/7Ameo/d
         h+T86Q6B0zczecQdQfyI4AW1D84JOnFnz9aCFFbfGEIgss//ZEsoHPleDKhe7iD5Xx
         NkTZ+Ka8BHvEoru3NnidwGOZ1/pU4TriVilasgaTGtD5o28X9CMavUhDFVq585K5zB
         JApn8vXWxHQI7DA+5OZAq+60Ecvb/nizrYnNmclf3kc9mOk6lN3KIcmHJc3mW07KZu
         rqxN1TMpY4xDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 1/3] fs: add infrastructure for opportunistic high-res ctime/mtime updates
Date:   Tue, 11 Apr 2023 10:27:06 -0400
Message-Id: <20230411142708.62475-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411142708.62475-1-jlayton@kernel.org>
References: <20230411142708.62475-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS always uses coarse-grained timestamp updates for filling out the
ctime and mtime after a change. This has the benefit of allowing
filesystems to optimize away metadata updates.

Unfortunately, this has always been an issue when we're exporting via
NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
lot of exported filesystems don't properly support a change attribute
and are subject to the same problem of timestamp granularity. Other
applications have similar issues (e.g backup applications).

Switching to always using high resolution timestamps would improve the
situation for NFS, but that becomes rather expensive, as we'd have to
log a lot more metadata updates.

This patch grabs a new i_state bit to use as a flag that filesystems can
set in their getattr routine to indicate that the mtime or ctime was
queried since it was last updated.

It then adds a new current_cmtime function that acts like the
current_time helper, but will conditionally grab high-res timestamps
when the i_state flag is set in the inode.

This allows NFS and other applications to reap the benefits of high-res
ctime and mtime timestamps, but at a substantially lower cost than
fetching them every time.

Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 fs/stat.c          | 10 ++++++++++
 include/linux/fs.h |  5 ++++-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..3630f67fd042 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2062,6 +2062,42 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
 	return ret;
 }
 
+/**
+ * current_cmtime - Return FS time (possibly high-res)
+ * @inode: inode.
+ *
+ * Return the current time truncated to the time granularity supported by
+ * the fs, as suitable for a ctime or mtime change. If something recently
+ * fetched the ctime or mtime out of the inode via getattr, then get a
+ * high-resolution timestamp.
+ *
+ * Note that inode and inode->sb cannot be NULL.
+ * Otherwise, the function warns and returns coarse time without truncation.
+ */
+struct timespec64 current_cmtime(struct inode *inode)
+{
+	struct timespec64 now;
+
+	if (unlikely(!inode->i_sb)) {
+		WARN(1, "%s() called with uninitialized super_block in the inode", __func__);
+		ktime_get_coarse_real_ts64(&now);
+		return now;
+	}
+
+	/* Do a lockless check for the flag before taking the spinlock */
+	if (READ_ONCE(inode->i_state) & I_CMTIME_QUERIED) {
+		ktime_get_real_ts64(&now);
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_CMTIME_QUERIED;
+		spin_unlock(&inode->i_lock);
+	} else {
+		ktime_get_coarse_real_ts64(&now);
+	}
+
+	return timestamp_truncate(now, inode);
+}
+EXPORT_SYMBOL(current_cmtime);
+
 /**
  * file_update_time - update mtime and ctime time
  * @file: file accessed
@@ -2080,7 +2116,7 @@ int file_update_time(struct file *file)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_cmtime(inode);
 
 	ret = inode_needs_update_time(inode, &now);
 	if (ret <= 0)
@@ -2109,7 +2145,7 @@ static int file_modified_flags(struct file *file, int flags)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
+	struct timespec64 now = current_cmtime(inode);
 
 	/*
 	 * Clear the security bits if the process is not being run by root.
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..d8b80a2e36b7 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -64,6 +64,16 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 }
 EXPORT_SYMBOL(generic_fillattr);
 
+void fill_cmtime_and_mark(struct inode *inode, struct kstat *stat)
+{
+	spin_lock(&inode->i_lock);
+	inode->i_state |= I_CMTIME_QUERIED;
+	stat->ctime = inode->i_ctime;
+	stat->mtime = inode->i_mtime;
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL(fill_cmtime_and_mark);
+
 /**
  * generic_fill_statx_attr - Fill in the statx attributes from the inode flags
  * @inode:	Inode to use as the source
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..7dece4390979 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1457,7 +1457,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_cmtime(struct inode *inode);
 
 /*
  * Snapshotting support.
@@ -2116,6 +2117,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
 #define I_PINNING_FSCACHE_WB	(1 << 18)
+#define I_CMTIME_QUERIED	(1 << 19)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -2839,6 +2841,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void generic_fillattr(struct mnt_idmap *, struct inode *, struct kstat *);
+void fill_cmtime_and_mark(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
-- 
2.39.2

