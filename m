Return-Path: <linux-fsdevel+bounces-33498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B079B98C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D26E1C20F99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D81D0DE8;
	Fri,  1 Nov 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4Lod8Yt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DC156880;
	Fri,  1 Nov 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489839; cv=none; b=TxC6YyV7lGh23fvs/qSfsTh+/AMFco7oqoaUCaT8oqpYnZs12zBCnq6im9hbQtKtCyv3S2kqbo6PG8mHav40W2J4RmC1+cY3XIxvlU1LangbR6VjSnZSb61HsGbnRWnkX6wDgTT9ANZ1qKYBUglEH29iBSMFIXi2rQOJF2SmYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489839; c=relaxed/simple;
	bh=OoWxJf4iBVjyTXJT/wfor5l782OhFK0RcLD9B0iQNFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=su4lfEQ5yqj47oW05+gM7b+drQiybWdI7zTdypkt6i2fzAVQY+afUVINIpDaYSvqmPLiHk6eTQ2YChDkbiYa9f8nW0V9JxrZxEmVf+fXQikTcnbW+efdEo3Xy33Qq2KGVcFfvdOolnCst5WGwFo7F8GObxL3QbhO1BZjM037+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4Lod8Yt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1EV4qN030018;
	Fri, 1 Nov 2024 19:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i2l4/Hj/mhka24zQg0cu1LYa/T2592hz+kjCUgTjJ
	Ek=; b=P4Lod8YtCK3/AYqk+nTvGgqgQ1bSwfovsVBtwS0+xDwnkxgKdGQdZ0YWF
	vchaI5plG2mnxi+UzocYn42Wf6tweHY+sTSUJ5g+EjMS3+MsRtIBPQMRCwgk7UlN
	tN/qMM/fAIZ+WkQgJKK7oTkHBuTFDp0tezKi8m75Dj3t+cwm+6uepOz3WDBSe3BX
	QjzbbOnt5TqfJsR6Cn0QXX5XOLA0/+bXHBbj7boLCRBNeThsKfulhTavrLF4IGTY
	otMVbM6AjDTKwqpk98Pb/+KQOcs7EauKgfJDHZnFkEljIO4Ftt7pc7q1NdUw9EPo
	tQKhfQlRXfpCqSzQ5t08cGNUwduzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42n0trs5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:37:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A1Jb7vs004278;
	Fri, 1 Nov 2024 19:37:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42n0trs5sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:37:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1FYwKd028181;
	Fri, 1 Nov 2024 19:37:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4yb91f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:37:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A1Jb50n53018924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 19:37:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A83E58060;
	Fri,  1 Nov 2024 19:37:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E1F5803F;
	Fri,  1 Nov 2024 19:37:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Nov 2024 19:37:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag
Date: Fri,  1 Nov 2024 15:37:03 -0400
Message-ID: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yG6F-hGE31ukWHgEfDQCKAvMFaRmBF7w
X-Proofpoint-GUID: JeiN5rPZehDvztK6czFOzCyPW_j7Pa1Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010138

From: Stefan Berger <stefanb@linux.ibm.com>

Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface
function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
call paths only call vfs_getattr_nosec if it is set instead of vfs_getattr.
Now, simplify the getattr interface functions of filesystems where the flag
AT_GETATTR_NOSEC is checked.

There is only a single caller of inode_operations getattr function and it
is located in fs/stat.c in vfs_getattr_nosec. The caller there is the only
one from which the AT_GETATTR_NOSEC flag is passed from.

Two filesystems are checking this flag in .getattr and the flag is always
passed to them unconditionally from only vfs_getattr_nosec:

- ecryptfs:  Simplify by always calling vfs_getattr_nosec in
             ecryptfs_getattr. From there the flag is passed to no other
             function and this function is not called otherwise.

- overlayfs: Simplify by always calling vfs_getattr_nosec in
             ovl_getattr. From there the flag is passed to no other
             function and this function is not called otherwise.

The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC from
any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
important inside this function. Also, since no filesystem is checking the
flag anymore, remove the flag entirely now, including the BUG_ON check that
never triggered.

The net change of the changes here combined with the originan commit is
that ecryptfs and overlayfs do not call vfs_getattr but only
vfs_getattr_nosec.

Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@ZenIV/T/#u
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/ecryptfs/inode.c        | 12 ++----------
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 --------
 fs/stat.c                  |  5 +----
 include/uapi/linux/fcntl.h |  4 ----
 5 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index cbdf82f0183f..a9819ddb1ab8 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1008,14 +1008,6 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
-			       u32 request_mask, unsigned int flags)
-{
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
-}
-
 static int ecryptfs_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
@@ -1024,8 +1016,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
 	struct kstat lower_stat;
 	int rc;
 
-	rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
-				 &lower_stat, request_mask, flags);
+	rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
+			       &lower_stat, request_mask, flags);
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 35fd3e3e1778..8b31f44c12cd 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -170,7 +170,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	type = ovl_path_real(dentry, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
+	err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
 
@@ -195,8 +195,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 					(!is_dir ? STATX_NLINK : 0);
 
 			ovl_path_lower(dentry, &realpath);
-			err = ovl_do_getattr(&realpath, &lowerstat, lowermask,
-					     flags);
+			err = vfs_getattr_nosec(&realpath, &lowerstat, lowermask,
+						flags);
 			if (err)
 				goto out;
 
@@ -248,8 +248,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 			ovl_path_lowerdata(dentry, &realpath);
 			if (realpath.dentry) {
-				err = ovl_do_getattr(&realpath, &lowerdatastat,
-						     lowermask, flags);
+				err = vfs_getattr_nosec(&realpath, &lowerdatastat,
+							lowermask, flags);
 				if (err)
 					goto out;
 			} else {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0bfe35da4b7b..910dbbb2bb7b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -412,14 +412,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 	return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
 }
 
-static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
-				 u32 request_mask, unsigned int flags)
-{
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
-}
-
 /* util.c */
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..cbc0fcd4fba3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -165,7 +165,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(idmap, path, stat,
 					    request_mask,
-					    query_flags | AT_GETATTR_NOSEC);
+					    query_flags);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
@@ -198,9 +198,6 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
 {
 	int retval;
 
-	if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
-		return -EPERM;
-
 	retval = security_inode_getattr(path);
 	if (retval)
 		return retval;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87e2dec79fea..a40833bf2855 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -154,8 +154,4 @@
 					   usable with open_by_handle_at(2). */
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 
-#if defined(__KERNEL__)
-#define AT_GETATTR_NOSEC	0x80000000
-#endif
-
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.47.0


