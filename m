Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94883B4512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhFYOBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231852AbhFYOBH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3508A6197D;
        Fri, 25 Jun 2021 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629526;
        bh=Lah9SxJ8NeroeUs7Pj9dfd4oj3gkMKIrcEjOXtoc7fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYdTsbRjCuLgbjUfZIBoXBPcfOS1Gsf5tkMovgLdBLq59H2ZECztNpFgNFrU3haJ2
         x0MmTmwd6MvqYG/pHEO7EleQfFmKUKRP3eQhcxjIiYBNMOoWd14/3pu3E1cB0GtDUY
         pbkjB0FBv/mPMg+2H51Yi/B20b9kcBbTMFk1K7l4bHF+IyQmWLAaRh2Llh2tcBm14I
         SNszRSbRLaeSkMLXu/bagrzggFwk88MnPHqawQW/BdfUBq4fMHpw188aCdeNYAsJpg
         nIeockOi4SVDte+MDJhOwUV8U0G/dlwjemTkTLckvXaNQ9KWQ7RzImk2xnKCkd2XBH
         JkAt8Gv1Ot5qg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 14/24] ceph: make ceph_msdc_build_path use ref-walk
Date:   Fri, 25 Jun 2021 09:58:24 -0400
Message-Id: <20210625135834.12934-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
index 08710b347c07..5b7872a61ad7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2396,7 +2396,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 			   int stop_on_nosnap)
 {
-	struct dentry *temp;
+	struct dentry *cur;
+	struct inode *inode;
 	char *path;
 	int pos;
 	unsigned seq;
@@ -2413,34 +2414,35 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
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
@@ -2449,8 +2451,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
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
2.31.1

