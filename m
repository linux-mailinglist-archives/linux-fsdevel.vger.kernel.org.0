Return-Path: <linux-fsdevel+bounces-888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4827D249F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B1CB20E70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1BE10A2E;
	Sun, 22 Oct 2023 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bIcB8nYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADA20F4;
	Sun, 22 Oct 2023 16:45:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4E112;
	Sun, 22 Oct 2023 09:45:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MEdkv3004249;
	Sun, 22 Oct 2023 16:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=Zh2RhPHkkwL5TykscjMWfVwEOp5tS5gDOkOqAVBOMcQ=;
 b=bIcB8nYe91eGm+LsuAazglgAFa7KtNy03WUWY10Q2Qca/EpfeCdNjIJBQ1TvYYV7gzVa
 eZ1KpLa33Nj/xIhFm4ZRO8890YEv4yKmf5eHlgHnL6FTMSGaEHt0EzHUTClbE/lyEZf9
 bTA8Qg5xAGNCJV65Bom6vgbgXzrshn9QyK/arjsUW20eGr1cJITd4vyIDtURihEG3TBz
 hiZbOE4Qlc4IsqTXkHNe4u6+UxYiFZ5TuULmEPYkMaENF6g3qTjoyfpa+g0E4gVqdW2M
 m8vFrZxY0zsBgWjiXfQUi5Vq0kjftbhMhnbbQealTfenEqHXjFCoodgdO0fCHiSFEuIG 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e31s6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 16:45:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MFPOB8034583;
	Sun, 22 Oct 2023 16:45:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5335f9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 16:45:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MGjQ7Y012619;
	Sun, 22 Oct 2023 16:45:26 GMT
Received: from localhost.localdomain (dhcp-10-175-40-192.vpn.oracle.com [10.175.40.192])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv5335f8t-1;
	Sun, 22 Oct 2023 16:45:26 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        linux-fsdevel@vger.kernel.org, Nick Piggin <npiggin@kernel.dk>,
        Waiman Long <Waiman.Long@hp.com>, linux-doc@vger.kernel.org
Subject: [PATCH] dcache: remove unnecessary NULL check in dget_dlock()
Date: Sun, 22 Oct 2023 18:45:20 +0200
Message-Id: <20231022164520.915013-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_14,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310220153
X-Proofpoint-GUID: 8rxQNoV07y9lM9luPH__Hao80Mvckud8
X-Proofpoint-ORIG-GUID: 8rxQNoV07y9lM9luPH__Hao80Mvckud8

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

Testing: x86 defconfig build + boot; make htmldocs for the kerneldoc
warning. objdump shows there are code generation changes.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Nick Piggin <npiggin@kernel.dk>
Cc: Waiman Long <Waiman.Long@hp.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 fs/dcache.c            | 14 ++++----------
 include/linux/dcache.h | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 25ac74d30bff..8c3c0d691605 100644
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
@@ -1707,7 +1701,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
 	if (d_mountpoint(dentry)) {
-		__dget_dlock(dentry);
+		dget_dlock(dentry);
 		*victim = dentry;
 		return D_WALK_QUIT;
 	}
@@ -1853,7 +1847,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	 * don't need child lock because it is not subject
 	 * to concurrency here
 	 */
-	__dget_dlock(parent);
+	dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
 	spin_unlock(&parent->d_lock);
@@ -2851,7 +2845,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 			spin_unlock(&alias->d_lock);
 			alias = NULL;
 		} else {
-			__dget_dlock(alias);
+			dget_dlock(alias);
 			__d_rehash(alias);
 			spin_unlock(&alias->d_lock);
 		}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..e22f1520ea3b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -300,20 +300,28 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
- *	destroyed when it has references.
+ *	Given a dentry, increment the reference count and return the
+ *	dentry.
+ *
+ *	Context: @dentry->d_lock must be held.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
-	if (dentry)
-		dentry->d_lockref.count++;
+	dentry->d_lockref.count++;
 	return dentry;
 }
 
+/**
+ *	dget -	get a reference to a dentry
+ *	@dentry: dentry to get a reference to
+ *
+ *	Given a dentry or %NULL pointer increment the reference count
+ *	if appropriate and return the dentry. A dentry will not be
+ *	destroyed when it has references.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.34.1


