Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471E3AE7D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFULGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFULGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:06:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB2C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 04:03:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j2so8601492wrs.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iex+j801dgrifzGUOXzt5yae52sqFNgh8gWMyhgDCXU=;
        b=Ri5dSI1gYjYQWrkCQlMGsxsqI1eU1U3UggSFmlZHeFa1k4MvYWpD5yhCHusacA+wGg
         znCFCYkaOlqrIKEUgCKgAznTqxPisG9XPFpasKV6iC6MGGXheE2Key2i1xUWpQhMHVdl
         bVjZmX3YAuPiCOxiuwZbURJmPEIj43VaklV2bOvsj28RGG9RS3/a9xgPKbTXK7SQD5+B
         PLd4/31cd7GqaEQJ7EiBbRmzRlYIIr/S2QEgj701W304Jni7rizrMuJJjbr4dWPiJlA8
         Mao9J+Jmfb9PtxoNTNltVsjzQF2XoHO3rmu966M9I/+gMlbqjAAGg4hLN+NuCX1onf1u
         w6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iex+j801dgrifzGUOXzt5yae52sqFNgh8gWMyhgDCXU=;
        b=lWYwLdDXR0Ve8fRkB5mLGSAZvhAZdmAAKkhhtYnI0CJFrZ0SMyTNNYW7V2BcHNh/MF
         cAzAEHZuhsumwHLA8GRz5MZC/Yw6Cej/2Axnd2Vc76+8dIFfXzx0HDhpCW6P8hETJSJj
         XhjATFfw2P+skV/CGs8suSr0rPHRTy45mIo5xnRJmKe2Hlj4gtb3a3BcnZa3d/iMNU1n
         nCgPYi6VCr/kUyHE6Moj1EEm3qfO7oAcVLNyBl8WecDek/KviRf6ruXyglG8qQyu+YbR
         Ao9XiEK4OPKK0HRdBf2wSKQDdHdfSrBY4pcSkGE3Eg4MSqPR4W7V1DOzj0pomhVuwEAX
         /y1g==
X-Gm-Message-State: AOAM530P6W1dgLURxi20uvduP7FNAEghoemZXjeaDEz5aLZvzCmPZJwP
        7xzAC4kh4etn5hG3CIkb41c=
X-Google-Smtp-Source: ABdhPJw2ZnQglhR1IstGe4TgpnHaR/CEDqenl1OqzBpDBJw38ujeNV8KgDvYJ9GgmHLTtoBEO3o0Wg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr24042638wrt.345.1624273436566;
        Mon, 21 Jun 2021 04:03:56 -0700 (PDT)
Received: from localhost.localdomain ([141.226.245.169])
        by smtp.gmail.com with ESMTPSA id l20sm16134697wmq.3.2021.06.21.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 04:03:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fuse: fix illegal access to inode with reused nodeid
Date:   Mon, 21 Jun 2021 14:03:53 +0300
Message-Id: <20210621110353.1203828-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
with ourarg containing nodeid and generation.

If a fuse inode is found in inode cache with the same nodeid but
different generation, the existing fuse inode should be unhashed and
marked "bad" and a new inode with the new generation should be hashed
instead.

This can happen, for example, with passhrough fuse filesystem that
returns the real filesystem ino/generation on lookup and where real inode
numbers can get recycled due to real files being unlinked not via the fuse
passthrough filesystem.

With current code, this situation will not be detected and an old fuse
dentry that used to point to an older generation real inode, can be used
to access a completely new inode, which should be accessed only via the
new dentry.

Note that because the FORGET message carries the nodeid w/o generation,
the server should wait to get FORGET counts for the nlookup counts of
the old and reused inodes combined, before it can free the resources
associated to that nodeid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Do not include automount in fuse_stale_inode() check
- Revert unintential behavior change in fuse_dentry_revalidate()
  of wrong type inode

 fs/fuse/dir.c     | 5 +++--
 fs/fuse/fuse_i.h  | 7 +++++++
 fs/fuse/inode.c   | 4 ++--
 fs/fuse/readdir.c | 7 +++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..f361bfdc8544 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -239,7 +239,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (!ret) {
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			    (bool) IS_AUTOMOUNT(inode) !=
+			    (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
 						  outarg.nodeid, 1);
 				goto invalid;
@@ -252,7 +253,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (ret == -ENOMEM)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    inode_wrong_type(inode, outarg.attr.mode))
+		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
 			goto invalid;
 
 		forget_all_cached_acls(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..d2045492ff5a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -867,6 +867,13 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
 
+static inline bool fuse_stale_inode(const struct inode *inode, int generation,
+				    struct fuse_attr *attr)
+{
+	return inode->i_generation != generation ||
+		inode_wrong_type(inode, attr->mode);
+}
+
 static inline void fuse_make_bad(struct inode *inode)
 {
 	remove_inode_hash(inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..257bb3e1cac8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -350,8 +350,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr);
 		unlock_new_inode(inode);
-	} else if (inode_wrong_type(inode, attr->mode)) {
-		/* Inode has changed type, any I/O on the old should fail */
+	} else if (fuse_stale_inode(inode, generation, attr)) {
+		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
 		iput(inode);
 		goto retry;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 277f7041d55a..bc267832310c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -200,9 +200,12 @@ static int fuse_direntplus_link(struct file *file,
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
+		if (inode && get_node_id(inode) != o->nodeid)
+			inode = NULL;
 		if (!inode ||
-		    get_node_id(inode) != o->nodeid ||
-		    inode_wrong_type(inode, o->attr.mode)) {
+		    fuse_stale_inode(inode, o->generation, &o->attr)) {
+			if (inode)
+				fuse_make_bad(inode);
 			d_invalidate(dentry);
 			dput(dentry);
 			goto retry;
-- 
2.32.0

