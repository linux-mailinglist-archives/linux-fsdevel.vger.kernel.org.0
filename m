Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477782FD88F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392043AbhATSfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404431AbhATSam (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 075412343B;
        Wed, 20 Jan 2021 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167335;
        bh=8pcWHI345+9ossnRiDH68wI/Aw6safCdTrbCM5oLkRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=det7pMfll/l2QLqp/lbv4WWTxhnGmcThzCcAgvymVPUANNvdkP1bo3UdgEJYLa6r9
         oum57LmIXHjCPfdk3G4CI16sQmE9gJnFeycsUznTuyYHvs6CfS/ZxS+EpEeOLXns8K
         DEDBHTlhSDhmtxqNxgjNJj8Hx1BX3v9Gtfa/xxXtY5Wmg2YWF1JH8R3j3JJpR7JHPT
         Fj/YI+sPWNs9YQMBemvDAWeCBTjoeqqq/9sr252g+WYMdnQflPKrWx2d40y5inP45Q
         ahlb6Cx4/wQOZNOgmg+bJljD6nepT/xGAyKD4o5rFi1V2q/ZZBZ903fVyghcjXr/9d
         9zqUuwlexjhBA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 09/17] ceph: make ceph_msdc_build_path use ref-walk
Date:   Wed, 20 Jan 2021 13:28:39 -0500
Message-Id: <20210120182847.644850-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
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
index 45c06873f28c..77cee8a0de3f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2323,7 +2323,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 			   int stop_on_nosnap)
 {
-	struct dentry *temp;
+	struct dentry *cur;
+	struct inode *inode;
 	char *path;
 	int pos;
 	unsigned seq;
@@ -2340,34 +2341,35 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
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
@@ -2376,8 +2378,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
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
2.29.2

