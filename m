Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429BA269566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgINTSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgINTRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:22 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55756221E3;
        Mon, 14 Sep 2020 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111037;
        bh=XBuKIJKYWo4X96EaNBsjlN57O/qWQZFBBji2cS8s4nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3OAC3hSRtQhtrlGACMNL0A9TwZwl0LY8P48rqRMzEhjjvgvGfAOght8q7n+8WV87
         h9K8Nyk2ahOhZUuf0NB+JbWoiHKTBJEYVoXBtoDZMcQX3JobEnpRZw9SMh4DoAsM7w
         vbwuH2szRsxIx9hGRN5RQp1+/Awepe7n53lu4diI=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 12/16] ceph: add encrypted fname handling to ceph_mdsc_build_path
Date:   Mon, 14 Sep 2020 15:17:03 -0400
Message-Id: <20200914191707.380444-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow ceph_mdsc_build_path to encrypt and base64 encode the filename
when the parent is encrypted and we're sending the path to the MDS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 70 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e3dc061252d4..7eb504170981 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2314,18 +2314,27 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 	return mdsc->oldest_tid;
 }
 
-/*
- * Build a dentry's path.  Allocate on heap; caller must kfree.  Based
- * on build_path_from_dentry in fs/cifs/dir.c.
+/**
+ * ceph_mdsc_build_path - build a path string to a given dentry
+ * @dentry: dentry to which path should be built
+ * @plen: returned length of string
+ * @pbase: returned base inode number
+ * @for_wire: is this path going to be sent to the MDS?
+ *
+ * Build a string that represents the path to the dentry. This is mostly called
+ * for two different purposes:
+ *
+ * 1) we need to build a path string to send to the MDS (for_wire == true)
+ * 2) we need a path string for local presentation (e.g. debugfs) (for_wire == false)
  *
- * If @stop_on_nosnap, generate path relative to the first non-snapped
- * inode.
+ * The path is built in reverse, starting with the dentry. Walk back up toward
+ * the root, building the path until the first non-snapped inode is reached (for_wire)
+ * or the root inode is reached (!for_wire).
  *
  * Encode hidden .snap dirs as a double /, i.e.
  *   foo/.snap/bar -> foo//bar
  */
-char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
-			   int stop_on_nosnap)
+char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
 {
 	struct dentry *cur;
 	struct inode *inode;
@@ -2347,30 +2356,59 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 	seq = read_seqbegin(&rename_lock);
 	cur = dget(dentry);
 	for (;;) {
-		struct dentry *temp;
+		struct dentry *parent;
 
 		spin_lock(&cur->d_lock);
 		inode = d_inode(cur);
+		parent = cur->d_parent;
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 			dout("build_path path+%d: %p SNAPDIR\n",
 			     pos, cur);
-		} else if (stop_on_nosnap && inode && dentry != cur &&
-			   ceph_snap(inode) == CEPH_NOSNAP) {
+			dget(parent);
+			spin_unlock(&cur->d_lock);
+		} else if (for_wire && inode && dentry != cur && ceph_snap(inode) == CEPH_NOSNAP) {
 			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
-		} else {
+		} else if (!for_wire || !IS_ENCRYPTED(d_inode(parent))) {
 			pos -= cur->d_name.len;
 			if (pos < 0) {
 				spin_unlock(&cur->d_lock);
 				break;
 			}
 			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
+			dget(parent);
+			spin_unlock(&cur->d_lock);
+		} else {
+			int err;
+			struct fscrypt_name fname = { };
+			int len;
+			char buf[FSCRYPT_BASE64_CHARS(NAME_MAX)];
+
+			dget(parent);
+			spin_unlock(&cur->d_lock);
+
+			err = fscrypt_setup_filename(d_inode(parent), &cur->d_name, 1, &fname);
+			if (err) {
+				dput(parent);
+				dput(cur);
+				return ERR_PTR(err);
+			}
+
+			/* base64 encode the encrypted name */
+			len = fscrypt_base64_encode(fname.disk_name.name, fname.disk_name.len, buf);
+			pos -= len;
+			if (pos < 0) {
+				dput(parent);
+				fscrypt_free_filename(&fname);
+				break;
+			}
+			memcpy(path + pos, buf, len);
+			dout("non-ciphertext name = %.*s\n", len, buf);
+			fscrypt_free_filename(&fname);
 		}
-		temp = cur;
-		cur = dget(temp->d_parent);
-		spin_unlock(&temp->d_lock);
-		dput(temp);
+		dput(cur);
+		cur = parent;
 
 		/* Are we at the root? */
 		if (IS_ROOT(cur))
@@ -2415,7 +2453,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 	rcu_read_lock();
 	if (!dir)
 		dir = d_inode_rcu(dentry->d_parent);
-	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP) {
+	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP && !IS_ENCRYPTED(dir)) {
 		*pino = ceph_ino(dir);
 		rcu_read_unlock();
 		*ppath = dentry->d_name.name;
-- 
2.26.2

