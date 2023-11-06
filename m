Return-Path: <linux-fsdevel+bounces-2093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A37E25EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3A528146C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FA250EA;
	Mon,  6 Nov 2023 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2NTeiBTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318223777;
	Mon,  6 Nov 2023 13:45:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B0D8;
	Mon,  6 Nov 2023 05:45:00 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6D276V011570;
	Mon, 6 Nov 2023 13:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=6YHJjY4Bdvy1h7hf5nC46l/cIWxl0iVN7Q28DIqENBo=;
 b=2NTeiBTzaAHfDuf9ZRTEFTFMA0KiNylDlLF+4se3wOMcv7DkqSsTr+WRbSeRqAUSC9l8
 wyChpgaMyU0D1wCZKhmcU871dSYsqgj48lTKcY951CFGCvSZDiNCH+T52vXPlhZ+nNIk
 R6DFdX1LOk4Sk71j70tFeD5z9fuMS1g7+gRsWmvJ7x5fplOf75m2JclqGTkxnU9locCp
 aj5wLbvF7S4VYvNK/0dq0iMNElxXk4eBPdspMVhr84QWcDETRvQoQSd+BnCqUnvyiJou
 RtSKRa0rUAzBewR36FVLhDaGxVa2Od7vvpvCRkgcFKQG5DxJpGt917vBLNpVRTNW+yv7 GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cj2u4gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Nov 2023 13:44:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6D6iBO020666;
	Mon, 6 Nov 2023 13:44:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdbc8d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Nov 2023 13:44:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6DifHf024328;
	Mon, 6 Nov 2023 13:44:41 GMT
Received: from localhost.localdomain (dhcp-10-175-43-221.vpn.oracle.com [10.175.43.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u5cdbc8bj-1;
	Mon, 06 Nov 2023 13:44:41 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        linux-fsdevel@vger.kernel.org, Nick Piggin <npiggin@kernel.dk>,
        Waiman Long <Waiman.Long@hp.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2] dcache: remove unnecessary NULL check in dget_dlock()
Date: Mon,  6 Nov 2023 14:44:17 +0100
Message-Id: <20231106134417.98833-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060111
X-Proofpoint-ORIG-GUID: _jd5P7Syl5cgkzIKqm3ezlqYqdq0z8Sr
X-Proofpoint-GUID: _jd5P7Syl5cgkzIKqm3ezlqYqdq0z8Sr

dget_dlock() requires dentry->d_lock to be held when called, yet
contains a NULL check for dentry.

An audit of all calls to dget_dlock() shows that it is never called
with a NULL pointer (as spin_lock()/spin_unlock() would crash in these
cases):

  $ git grep -W '\<dget_dlock\>'

  arch/powerpc/platforms/cell/spufs/inode.c-              spin_lock(&dentry->d_lock);
  arch/powerpc/platforms/cell/spufs/inode.c-              if (simple_positive(dentry)) {
  arch/powerpc/platforms/cell/spufs/inode.c:                      dget_dlock(dentry);

  fs/autofs/expire.c-             spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
  fs/autofs/expire.c-             if (simple_positive(child)) {
  fs/autofs/expire.c:                     dget_dlock(child);

  fs/autofs/root.c:                       dget_dlock(active);
  fs/autofs/root.c-                       spin_unlock(&active->d_lock);

  fs/autofs/root.c:                       dget_dlock(expiring);
  fs/autofs/root.c-                       spin_unlock(&expiring->d_lock);

  fs/ceph/dir.c-          if (!spin_trylock(&dentry->d_lock))
  fs/ceph/dir.c-                  continue;
  [...]
  fs/ceph/dir.c:                          dget_dlock(dentry);

  fs/ceph/mds_client.c-           spin_lock(&alias->d_lock);
  [...]
  fs/ceph/mds_client.c:                   dn = dget_dlock(alias);

  fs/configfs/inode.c-            spin_lock(&dentry->d_lock);
  fs/configfs/inode.c-            if (simple_positive(dentry)) {
  fs/configfs/inode.c:                    dget_dlock(dentry);

  fs/libfs.c:                             found = dget_dlock(d);
  fs/libfs.c-                     spin_unlock(&d->d_lock);

  fs/libfs.c:             found = dget_dlock(child);
  fs/libfs.c-     spin_unlock(&child->d_lock);

  fs/libfs.c:                             child = dget_dlock(d);
  fs/libfs.c-                     spin_unlock(&d->d_lock);

  fs/ocfs2/dcache.c:                      dget_dlock(dentry);
  fs/ocfs2/dcache.c-                      spin_unlock(&dentry->d_lock);

  include/linux/dcache.h:static inline struct dentry *dget_dlock(struct dentry *dentry)

After taking out the NULL check, dget_dlock() becomes almost identical
to __dget_dlock(); the only difference is that dget_dlock() returns the
dentry that was passed in. These are static inline helpers, so we can
rely on the compiler to discard unused return values. We can therefore
also remove __dget_dlock() and replace calls to it by dget_dlock().

Also fix up and improve the kerneldoc comments while we're at it.

Al Viro pointed out that we can also clean up some of the callers to
make use of the returned value and provided a bit more info for the
kerneldoc.

While preparing v2 I also noticed that the tabs used in the kerneldoc
comments were causing the kerneldoc to get parsed incorrectly so I also
fixed this up (including for d_unhashed, which is otherwise unrelated).

Testing: x86 defconfig build + boot; make htmldocs for the kerneldoc
warning. objdump shows there are code generation changes.

Link: https://lore.kernel.org/all/20231022164520.915013-1-vegard.nossum@oracle.com/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Nick Piggin <npiggin@kernel.dk>
Cc: Waiman Long <Waiman.Long@hp.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 fs/dcache.c            | 16 ++++------------
 include/linux/dcache.h | 29 +++++++++++++++++++----------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..4bf33ba588d8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -942,12 +942,6 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	spin_unlock(&dentry->d_lock);
 }
 
-/* This must be called with d_lock held */
-static inline void __dget_dlock(struct dentry *dentry)
-{
-	dentry->d_lockref.count++;
-}
-
 static inline void __dget(struct dentry *dentry)
 {
 	lockref_get(&dentry->d_lockref);
@@ -1034,7 +1028,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&alias->d_lock);
  		if (!d_unhashed(alias)) {
-			__dget_dlock(alias);
+			dget_dlock(alias);
 			spin_unlock(&alias->d_lock);
 			return alias;
 		}
@@ -1707,8 +1701,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
 	if (d_mountpoint(dentry)) {
-		__dget_dlock(dentry);
-		*victim = dentry;
+		*victim = dget_dlock(dentry);
 		return D_WALK_QUIT;
 	}
 	return D_WALK_CONTINUE;
@@ -1853,8 +1846,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	 * don't need child lock because it is not subject
 	 * to concurrency here
 	 */
-	__dget_dlock(parent);
-	dentry->d_parent = parent;
+	dentry->d_parent = dget_dlock(parent);
 	list_add(&dentry->d_child, &parent->d_subdirs);
 	spin_unlock(&parent->d_lock);
 
@@ -2851,7 +2843,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 			spin_unlock(&alias->d_lock);
 			alias = NULL;
 		} else {
-			__dget_dlock(alias);
+			dget_dlock(alias);
 			__d_rehash(alias);
 			spin_unlock(&alias->d_lock);
 		}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..82127cf10992 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -301,20 +301,29 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
- *	@dentry: dentry to get a reference to
+ * dget_dlock - get a reference to a dentry
+ * @dentry: dentry to get a reference to
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
- *	destroyed when it has references.
+ * Given a live dentry, increment the reference count and return
+ * the dentry.  For a dentry to be live, it can be hashed, positive,
+ * or have a non-negative &dentry->d_lockref.count
+ *
+ * Context: @dentry->d_lock must be held.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
-	if (dentry)
-		dentry->d_lockref.count++;
+	dentry->d_lockref.count++;
 	return dentry;
 }
 
+/**
+ * dget - get a reference to a dentry
+ * @dentry: dentry to get a reference to
+ *
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry.  A dentry will not be
+ * destroyed when it has references.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
@@ -325,10 +334,10 @@ static inline struct dentry *dget(struct dentry *dentry)
 extern struct dentry *dget_parent(struct dentry *dentry);
 
 /**
- *	d_unhashed -	is dentry hashed
- *	@dentry: entry to check
+ * d_unhashed - is dentry hashed
+ * @dentry: entry to check
  *
- *	Returns true if the dentry passed is not currently hashed.
+ * Returns true if the dentry passed is not currently hashed.
  */
  
 static inline int d_unhashed(const struct dentry *dentry)
-- 
2.34.1


