Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4888746EBA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhLIPko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbhLIPki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBBC0698CD;
        Thu,  9 Dec 2021 07:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA8FB8251F;
        Thu,  9 Dec 2021 15:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C0C004DD;
        Thu,  9 Dec 2021 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064219;
        bh=JY8GqC5VpxIQiXqTVBOkTYFBV5pApqLWmjK5Kb+nY+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCbj9IggqVIzEoZrZ276Tl8Ce1fNahbxrSgQnY6qf+KDah1iSxoEBd2/mqgz+mpWN
         imHBkncDlEFZkrSkjTyG+1juUELbYObxK+RZsjHj95uaxD2FvoWoDMUiw+OsO6naoC
         4ewJvVqeuVvaxc1N738DqnKk9JRIwwAZEvwEtieAB1vRR2CXQJI9OFfsU6MIhXitE7
         UilB01A8FiKG41PLmvwqo/BYKX7frYA5YB/UBTRGhqRXWUEFtyqzPvQUNOW/h3HZU8
         H1eg7N6C/jV25lQad72YfLXP4c3hy4nJADUclP3IWMzU+Ie01NsiQpOtoYvotncgAW
         o0ERE4O3EuVBQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/36] ceph: make ceph_msdc_build_path use ref-walk
Date:   Thu,  9 Dec 2021 10:36:25 -0500
Message-Id: <20211209153647.58953-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encryption potentially requires allocation, at which point we'll need to
be in a non-atomic context. Convert ceph_msdc_build_path to take dentry
spinlocks and references instead of using rcu_read_lock to walk the
path.

This is slightly less efficient, and we may want to eventually allow
using RCU when the leaf dentry isn't encrypted.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 709f3f654555..68552cee3e8e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2368,7 +2368,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 			   int stop_on_nosnap)
 {
-	struct dentry *temp;
+	struct dentry *cur;
+	struct inode *inode;
 	char *path;
 	int pos;
 	unsigned seq;
@@ -2385,34 +2386,35 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 	path[pos] = '\0';
 
 	seq = read_seqbegin(&rename_lock);
-	rcu_read_lock();
-	temp = dentry;
+	cur = dget(dentry);
 	for (;;) {
-		struct inode *inode;
+		struct dentry *temp;
 
-		spin_lock(&temp->d_lock);
-		inode = d_inode(temp);
+		spin_lock(&cur->d_lock);
+		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 			dout("build_path path+%d: %p SNAPDIR\n",
-			     pos, temp);
-		} else if (stop_on_nosnap && inode && dentry != temp &&
+			     pos, cur);
+		} else if (stop_on_nosnap && inode && dentry != cur &&
 			   ceph_snap(inode) == CEPH_NOSNAP) {
-			spin_unlock(&temp->d_lock);
+			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
 		} else {
-			pos -= temp->d_name.len;
+			pos -= cur->d_name.len;
 			if (pos < 0) {
-				spin_unlock(&temp->d_lock);
+				spin_unlock(&cur->d_lock);
 				break;
 			}
-			memcpy(path + pos, temp->d_name.name, temp->d_name.len);
+			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
 		}
+		temp = cur;
 		spin_unlock(&temp->d_lock);
-		temp = READ_ONCE(temp->d_parent);
+		cur = dget_parent(temp);
+		dput(temp);
 
 		/* Are we at the root? */
-		if (IS_ROOT(temp))
+		if (IS_ROOT(cur))
 			break;
 
 		/* Are we out of buffer? */
@@ -2421,8 +2423,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
 		path[pos] = '/';
 	}
-	base = ceph_ino(d_inode(temp));
-	rcu_read_unlock();
+	inode = d_inode(cur);
+	base = inode ? ceph_ino(inode) : 0;
+	dput(cur);
 
 	if (read_seqretry(&rename_lock, seq))
 		goto retry;
-- 
2.33.1

