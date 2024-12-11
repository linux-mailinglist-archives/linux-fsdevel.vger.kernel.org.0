Return-Path: <linux-fsdevel+bounces-37019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687909EC637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5151D165A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458991DC9AA;
	Wed, 11 Dec 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DYnno/Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EE1D8A08;
	Wed, 11 Dec 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903897; cv=none; b=SMnTCH7WwCEjwAWj+QLbB0YnopNrHCZmSw/gurmanOAU53whVLQDBlR5MSLRRXaA64l2YBcF2S/j5SVzQharl9D6AfQcnPiYhD8K4EYMTOrBJLw8cEr+tmX4q+HWKVBCzcNKsXvbIUwMVZVv20C6uKNuqNanQ4ON7AfrCyzBLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903897; c=relaxed/simple;
	bh=Mgf1YHGsSe/K1NxZNnDPVQwbZ7+NkO89c6Lrz/zkKQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti0ZdwKCWm/0FyY2iUv6iCxcUNTjcEIGPvHEX6GEOOuJainLg08xsWyKJNUrW5xtR0UijV6xKCNAK+D68kNsOg0vR0zHbUWetMYI04eJg2y8P1zeGvmLU6ota+nkiQJkkWEiI+TisbqG/Ov3ythWO1e99Vrc12XFMsxP6cvL05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DYnno/Cf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAMXpBo025862;
	Wed, 11 Dec 2024 07:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r3Elre7/yhg7vCeAT
	VTTxYqyq67KZzmrA0vLHG4TIUY=; b=DYnno/CfHKlTlQ6attVIRdc2xT3x89vB0
	8cVxsFTz9dN5KhEsW+/P1m6daglWgY8k+cWnZKQ/bplCi/1ADDvknlQ9DnSYQOzw
	8SFtkxbyK83imZbiTtph1nk/6zGo6g0Yzf8l1yU7UB7gOce3vZSQ4JdjQtxBEIlY
	me+jngKRAJu6EGTKRnWcBFXlCZzCQYC7wmnZlAwKlOCAxAysGHVo+XCYhRvtnJmy
	05CvE4XYChgFMHFvqRH7Ofkp9ZNxWxjeC/L3AcJCDPC37j1mO8VVa66wtAhURZYW
	EcIjg1p3v1EUCVlvVDH0fnp3dtJIx2KiEAhArH3KufCL9W1SbI1gA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7riXv001005;
	Wed, 11 Dec 2024 07:58:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB7Zk0X017428;
	Wed, 11 Dec 2024 07:58:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1qvdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7w49665077580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:58:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E9920040;
	Wed, 11 Dec 2024 07:58:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 560CD20043;
	Wed, 11 Dec 2024 07:58:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:58:02 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        Nirjhar Roy <nirjhar@linux.ibm.com>
Subject: [RFC v2 3/6] ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
Date: Wed, 11 Dec 2024 13:27:52 +0530
Message-ID: <5002cd0f881bbcd5303455c51193807d7221f999.1733901374.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1733901374.git.ojaswin@linux.ibm.com>
References: <cover.1733901374.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FxixmN85AHneV4wgg2uoJGuNeExO9RLB
X-Proofpoint-GUID: q1x4GmmgaVrI8cXxN_nKIXaYxorizw-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

This patch adds support for getting and setting extsize hint using
FS_IOC_GETXATTR and FS_IOC_SETXATTR interface. The extsize is stored
in xattr of type EXT4_XATTR_INDEX_SYSTEM.

Restrictions on setting extsize:

1. extsize can't be set on files with data
2. extsize can't be set on non regular files
3. extsize hint can't be used with bigalloc (yet)
4. extsize (in blocks) should be power-of-2 for simplicity.
5. extsize must be a multiple of block size

The ioctl behavior has been kept as close to the XFS equivalent
as possible.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h  |   6 +++
 fs/ext4/inode.c |  89 +++++++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c |   1 +
 4 files changed, 218 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fbcde1e71b03..6e889a92247c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1170,6 +1170,8 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+	/* The extentsize hint for the inode in blocks */
+	ext4_grpblk_t i_extsize;
 };
 
 /*
@@ -3031,6 +3033,10 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 					int used, int quota_claim);
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
+int ext4_inode_xattr_get_extsize(struct inode *inode);
+int ext4_inode_xattr_set_extsize(struct inode *inode, ext4_grpblk_t extsize);
+ext4_grpblk_t ext4_inode_get_extsize(struct ext4_inode_info *ei);
+void ext4_inode_set_extsize(struct ext4_inode_info *ei, ext4_grpblk_t extsize);
 
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index aadd8bb3c679..73097d584ca9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4931,6 +4931,20 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		}
 	}
 
+	ret = ext4_inode_xattr_get_extsize(&ei->vfs_inode);
+	if (ret >= 0) {
+		ei->i_extsize = ret;
+	} else if (ret == -ENODATA) {
+		/* extsize is not set */
+		ei->i_extsize = 0;
+	} else {
+		ext4_error_inode(
+			inode, function, line, 0,
+			"iget: error while retrieving extsize from xattr: %ld", ret);
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	EXT4_INODE_GET_CTIME(inode, raw_inode);
 	EXT4_INODE_GET_ATIME(inode, raw_inode);
 	EXT4_INODE_GET_MTIME(inode, raw_inode);
@@ -6241,3 +6255,78 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	ext4_journal_stop(handle);
 	goto out;
 }
+
+/*
+ * Returns positive extsize if set, 0 if not set else error
+ */
+ext4_grpblk_t ext4_inode_xattr_get_extsize(struct inode *inode)
+{
+	char *buf;
+	int size, ret = 0;
+	ext4_grpblk_t extsize = 0;
+
+	size = ext4_xattr_get(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize", NULL, 0);
+
+	if (size == -ENODATA || size == 0) {
+		return 0;
+	} else if (size < 0) {
+		ret = size;
+		goto exit;
+	}
+
+	buf = (char *)kmalloc(size + 1, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	size = ext4_xattr_get(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize", buf,
+			      size);
+	if (size == -ENODATA)
+		/* No extsize is set */
+		extsize = 0;
+	else if (size < 0)
+		ret = size;
+	else {
+		buf[size] = '\0';
+		ret = kstrtoint(buf, 10, &extsize);
+	}
+
+	kfree(buf);
+exit:
+	if (ret)
+		return ret;
+	return extsize;
+}
+
+int ext4_inode_xattr_set_extsize(struct inode *inode, ext4_grpblk_t extsize)
+{
+	int err = 0;
+	/* max value of extsize should fit within 11 chars */
+	char extsize_str[11];
+
+	err = snprintf(extsize_str, 10, "%u", extsize);
+	if (err < 0)
+		return err;
+
+	/* Try to replace the xattr if it exists, else try to create it */
+	err = ext4_xattr_set(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize",
+			     extsize_str, strlen(extsize_str), XATTR_REPLACE);
+
+	if (err == -ENODATA)
+		err = ext4_xattr_set(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize",
+				     extsize_str, strlen(extsize_str),
+				     XATTR_CREATE);
+
+	return err;
+}
+
+ext4_grpblk_t ext4_inode_get_extsize(struct ext4_inode_info *ei)
+{
+	return ei->i_extsize;
+}
+
+void ext4_inode_set_extsize(struct ext4_inode_info *ei, ext4_grpblk_t extsize)
+{
+	ei->i_extsize = extsize;
+}
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1c77400bd88e..ffe56a603456 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -708,6 +708,93 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	return err;
 }
 
+static u32 ext4_ioctl_getextsize(struct inode *inode)
+{
+	ext4_grpblk_t extsize;
+
+	extsize = ext4_inode_get_extsize(EXT4_I(inode));
+
+	return (u32) extsize << inode->i_blkbits;
+}
+
+
+static int ext4_ioctl_setextsize(struct inode *inode, u32 extsize, u32 xflags)
+{
+	int err;
+	ext4_grpblk_t extsize_blks = extsize >> inode->i_blkbits;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int blksize = 1 << inode->i_blkbits;
+	char *msg = NULL;
+
+	if (!S_ISREG(inode->i_mode)) {
+		msg = "Cannot set extsize on non regular file";
+		err = -EOPNOTSUPP;
+		goto error;
+	}
+
+	/*
+	 *  We are okay with a non-zero i_size as long as there is no data.
+	 */
+	if (ext4_has_inline_data(inode) ||
+	    READ_ONCE(EXT4_I(inode)->i_disksize) ||
+	    EXT4_I(inode)->i_reserved_data_blocks) {
+		msg = "Cannot set extsize on file with data";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize % blksize) {
+		msg = "extsize must be multiple of blocksize";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (sbi->s_cluster_ratio > 1) {
+		msg = "Can't use extsize hint with bigalloc";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if ((xflags & FS_XFLAG_EXTSIZE) && extsize == 0) {
+		msg = "fsx_extsize can't be 0 if FS_XFLAG_EXTSIZE is passed";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize_blks > sbi->s_blocks_per_group) {
+		msg = "extsize cannot exceed number of bytes in block group";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize && !is_power_of_2(extsize_blks)) {
+		msg = "extsize must be either power-of-2 in fs blocks or 0";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		msg = "extsize can't be set on non-extent based files";
+		err = -EINVAL;
+		goto error;
+	}
+
+	/* update the extsize in inode xattr */
+	err = ext4_inode_xattr_set_extsize(inode, extsize_blks);
+	if (err < 0)
+		return err;
+
+	/* Update the new extsize in the in-core inode */
+	ext4_inode_set_extsize(EXT4_I(inode), extsize_blks);
+	return 0;
+
+error:
+	if (msg)
+		ext4_warning_inode(inode, "%s\n", msg);
+
+	return err;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
@@ -985,6 +1072,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	u32 flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
+	u32 extsize = 0;
 
 	if (S_ISREG(inode->i_mode))
 		flags &= ~FS_PROJINHERIT_FL;
@@ -993,6 +1081,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	extsize = ext4_ioctl_getextsize(inode);
+	/* Flag is only set if extsize is non zero */
+	if (extsize > 0) {
+		fa->fsx_extsize = extsize;
+		fa->fsx_xflags |= FS_XFLAG_EXTSIZE;
+	}
+
 	return 0;
 }
 
@@ -1022,6 +1117,33 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
 	if (err)
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
+	if (err)
+		goto out;
+
+	if (fa->fsx_xflags & FS_XFLAG_EXTSIZE) {
+		err = ext4_ioctl_setextsize(inode, fa->fsx_extsize,
+					    fa->fsx_xflags);
+		if (err)
+			goto out;
+	} else if (fa->fsx_extsize == 0) {
+		/*
+		 * Even when user explicitly passes extsize=0 the flag is cleared in
+		 * fileattr_set_prepare().
+		 */
+		if (ext4_inode_get_extsize(EXT4_I(inode)) != 0) {
+			err = ext4_ioctl_setextsize(inode, fa->fsx_extsize,
+						    fa->fsx_xflags);
+			if (err)
+				goto out;
+		}
+
+	} else {
+		/* Unexpected usage, reset extsize to 0 */
+		err = ext4_ioctl_setextsize(inode, 0, fa->fsx_xflags);
+		if (err)
+			goto out;
+		fa->fsx_xflags = 0;
+	}
 out:
 	return err;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a09f4621b10d..7acdb6d51d80 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1428,6 +1428,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
+	ei->i_extsize = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-- 
2.43.5


