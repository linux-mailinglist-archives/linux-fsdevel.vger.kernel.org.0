Return-Path: <linux-fsdevel+bounces-55540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1EB0B839
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D583018940C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349D23506A;
	Sun, 20 Jul 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cq//Y9k3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03DC22A813;
	Sun, 20 Jul 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045084; cv=none; b=VF7OKMIZfzRNRlDGyoQCXSWM0CrsF2CP9nQZO5uNPP29HTpLiJv24uuXBXiL9vhLPVx6NnWxTVpDthpOFhHVowjv0F5rsSXUqu9CDzSwMCCaJHVXJY0HPf5oLwQ9a+VbwpkATmfNiM6Ku6Kuf9HjMHALLJ9iE2NWqej5/LCDssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045084; c=relaxed/simple;
	bh=dMWXZEpMPzPvqB8x+sjy03HPUuoNIXkVVXOj8G5xmpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW4yuei8WtM5Pz6RrlaQ0tjqd5nrerUbxyt9MLIlE0EcAO4S17BfuerZd80a3nQloXQrA37cg5yi0tTEkZ6zt7OD/TqBPBFBj9UWVJnAuhQwzRjeKQVEK4JSmrntGusT3YUXe5w+okNoQ5w2Cm73Qa3wHxTYYaA6PY3iTgALGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cq//Y9k3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KCTmtJ021072;
	Sun, 20 Jul 2025 20:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HdaDUyEXubSkBMogF
	soBBTRu8f8w+09MeBodlYXydAs=; b=cq//Y9k3MnPj/wcWqVYOF0DpD5teHDdgk
	5NKqwPRgGsyDJVQVtiULg3xfoQO4CucYixKDekDGl3kC/m6WL1vUR2pa3TASB1W5
	rdJBAgVBu3aD081CZbG+f3cOA0KB6UmBVeHFoD4uNtxfmJGKgSgxigv41QtGWdjF
	nDIkhxzx/bujQ83utOXJ4+vO1lWwoMGaz1B4H892Afm7g1IVmkBFxQUKQlsam4b+
	ObWJKV9pS4zPdEtiT2+3XRzqOW9eRoC4SsSUuDPVDVROdCv+qEU1dhDBa/08YHpJ
	mNwfwzMU1+EsJkw7UWnSyU+4iF6vK5BeXZmc6Bi34PvYlUJaUu3ww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfnhsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvmfZ020577;
	Sun, 20 Jul 2025 20:57:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfnhse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KH303Z005057;
	Sun, 20 Jul 2025 20:57:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fjcey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvjE335127780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5787E20043;
	Sun, 20 Jul 2025 20:57:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1778D20040;
	Sun, 20 Jul 2025 20:57:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 3/7] ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
Date: Mon, 21 Jul 2025 02:27:29 +0530
Message-ID: <24053b9376e369be0ffffea0d91eb22b7634aed4.1753044253.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753044253.git.ojaswin@linux.ibm.com>
References: <cover.1753044253.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfXyPhEcTMOWmnr
 8J2sY9G6vqOq4/hylG/BsRA77xDre9+NzTSkR3gHkN/B8bJPFCqxIs2kZha+rdQeQRyx+/xV1/k
 esWLYQdBbrzCcLN0lxh9xBpMtwyOmREq8t4GUdEroPVmSDVkcoQ5BibzTizOGdnqSQBbVdtUtZH
 iWM3aWp5iRQVi6aQL7r94v7FzVDdsI03hMrgdcGzWLAqlafIJ68lQ5G9u6HqCAyHfsCEhFIyfy+
 K+mgGb+kn2NxpkFffdX0o9MNmUL0HO3BInDvCBKSG2uoVbXHmNALACTnoLZyvN+vBm7cPTEU7jF
 QjnzuQFLoVr/BJoGXnVo/NFZunqrwoFKFWI6Jkm+tTehDUKJZOzMCnTXcBfQOkoH13+YkUtXsfE
 oR5MpFkiEI4HgAQnnqWpW7k3/2iOVGorg1C237ijaWRPKQ/x7RrJe6qYbVa5oYe5Rro9VImV
X-Proofpoint-GUID: naCah_AFQ0-zCT2pSK7zzV29cGqO6XuK
X-Proofpoint-ORIG-GUID: F3UjfYlAQvjdf-9BjXQlLu6fTJ6mIMSS
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687d584c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Pq_v2OHg8FMu9Aes55EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200198

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
index 7b353d1af580..d00870cb15f2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1199,6 +1199,8 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+	/* The extentsize hint for the inode in blocks */
+	ext4_grpblk_t i_extsize;
 };
 
 /*
@@ -3081,6 +3083,10 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 					int used, int quota_claim);
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
+int ext4_inode_xattr_get_extsize(struct inode *inode);
+int ext4_inode_xattr_set_extsize(struct inode *inode, ext4_grpblk_t extsize);
+ext4_grpblk_t ext4_inode_get_extsize(struct ext4_inode_info *ei);
+void ext4_inode_set_extsize(struct ext4_inode_info *ei, ext4_grpblk_t extsize);
 
 static inline bool is_special_ino(struct super_block *sb, unsigned long ino)
 {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8bdf2029ebc7..664218228fd5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5432,6 +5432,20 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
@@ -6779,3 +6793,78 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_end_pagefault(inode->i_sb);
 	return ret;
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
+	buf = kmalloc(size + 1, GFP_KERNEL);
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
index 5668a17458ae..64a394869317 100644
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
index c7d39da7e733..2237cb2240f8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1409,6 +1409,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
+	ei->i_extsize = 0;
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
-- 
2.49.0


