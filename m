Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1999403B86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbhIHOaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:16 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41484 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351926AbhIHOaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:16 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004rW-V4; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] coda: Avoid doing bad things on inode type changes during revalidation.
Date:   Wed,  8 Sep 2021 10:03:05 -0400
Message-Id: <20210908140308.18491-7-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When Coda discovers an inconsistent object, it turns it into a symlink.
However we can't just follow this change in the kernel on an existing
file or directory inode that may still have references.

This patch removes the inconsistent inode from the inode hash and
allocates a new inode for the symlink object.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/cnode.c      | 13 +++++++++----
 fs/coda/coda_linux.c | 39 +++++++++++++++++++--------------------
 fs/coda/coda_linux.h |  3 ++-
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 06855f6c7902..62a3d2565c26 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -63,9 +63,10 @@ struct inode * coda_iget(struct super_block * sb, struct CodaFid * fid,
 	struct inode *inode;
 	struct coda_inode_info *cii;
 	unsigned long hash = coda_f2i(fid);
+	umode_t inode_type = coda_inode_type(attr);
 
+retry:
 	inode = iget5_locked(sb, hash, coda_test_inode, coda_set_inode, fid);
-
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -75,11 +76,15 @@ struct inode * coda_iget(struct super_block * sb, struct CodaFid * fid,
 		inode->i_ino = hash;
 		/* inode is locked and unique, no need to grab cii->c_lock */
 		cii->c_mapcount = 0;
+		coda_fill_inode(inode, attr);
 		unlock_new_inode(inode);
+	} else if ((inode->i_mode & S_IFMT) != inode_type) {
+		/* Inode has changed type, mark bad and grab a new one */
+		remove_inode_hash(inode);
+		coda_flag_inode(inode, C_PURGE);
+		iput(inode);
+		goto retry;
 	}
-
-	/* always replace the attributes, type might have changed */
-	coda_fill_inode(inode, attr);
 	return inode;
 }
 
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index 2e1a5a192074..903ca8fa4b9b 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -87,28 +87,27 @@ static struct coda_timespec timespec64_to_coda(struct timespec64 ts64)
 }
 
 /* utility functions below */
+umode_t coda_inode_type(struct coda_vattr *attr)
+{
+	switch (attr->va_type) {
+	case C_VREG:
+		return S_IFREG;
+	case C_VDIR:
+		return S_IFDIR;
+	case C_VLNK:
+		return S_IFLNK;
+	case C_VNON:
+	default:
+		return 0;
+	}
+}
+
 void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 {
-        int inode_type;
-        /* inode's i_flags, i_ino are set by iget 
-           XXX: is this all we need ??
-           */
-        switch (attr->va_type) {
-        case C_VNON:
-                inode_type  = 0;
-                break;
-        case C_VREG:
-                inode_type = S_IFREG;
-                break;
-        case C_VDIR:
-                inode_type = S_IFDIR;
-                break;
-        case C_VLNK:
-                inode_type = S_IFLNK;
-                break;
-        default:
-                inode_type = 0;
-        }
+	/* inode's i_flags, i_ino are set by iget
+	 * XXX: is this all we need ??
+	 */
+	umode_t inode_type = coda_inode_type(attr);
 	inode->i_mode |= inode_type;
 
 	if (attr->va_mode != (u_short) -1)
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 3c2947bba5e5..9be281bbcc06 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -53,10 +53,11 @@ int coda_getattr(struct user_namespace *, const struct path *, struct kstat *,
 		 u32, unsigned int);
 int coda_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
-/* this file:  heloers */
+/* this file:  helpers */
 char *coda_f2s(struct CodaFid *f);
 int coda_iscontrol(const char *name, size_t length);
 
+umode_t coda_inode_type(struct coda_vattr *attr);
 void coda_vattr_to_iattr(struct inode *, struct coda_vattr *);
 void coda_iattr_to_vattr(struct iattr *, struct coda_vattr *);
 unsigned short coda_flags_to_cflags(unsigned short);
-- 
2.25.1

