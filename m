Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B872C25DF03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIDQFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgIDQFv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:51 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF6220795;
        Fri,  4 Sep 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235550;
        bh=oB/UhCpayB7Hy6EtU70lBgzh3xCwDnnDzHfyLmISOBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/u+nzZNnsH3DRMLzlcd5BFmtOptl1arW/psc/cOsLG5Pmf54g4XLcyAVSNdrzVGs
         HrDtLyB/oNRpdUUVc7ivrTQUDFPQ3ckQK4j4fo4bCIdV0tLP0eD2/05soX/IL0MI3u
         aXiT2juQC39k/ALmfYEOFVbRZ7IB9r4Q2+ihVrhM=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 14/18] ceph: add encrypted fname handling to ceph_mdsc_build_path
Date:   Fri,  4 Sep 2020 12:05:33 -0400
Message-Id: <20200904160537.76663-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
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
 fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e3dc061252d4..26b43ae09823 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/bits.h>
 #include <linux/ktime.h>
+#include <linux/base64_fname.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -2324,8 +2325,7 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
  * Encode hidden .snap dirs as a double /, i.e.
  *   foo/.snap/bar -> foo//bar
  */
-char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
-			   int stop_on_nosnap)
+char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
 {
 	struct dentry *cur;
 	struct inode *inode;
@@ -2347,30 +2347,59 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
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
+			char buf[BASE64_CHARS(NAME_MAX)];
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
+			len = base64_encode_fname(fname.disk_name.name, fname.disk_name.len, buf);
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
@@ -2415,7 +2444,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
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

