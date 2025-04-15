Return-Path: <linux-fsdevel+bounces-46428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E10A890FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9451516DEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3C13C8EA;
	Tue, 15 Apr 2025 01:05:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32BA927;
	Tue, 15 Apr 2025 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679151; cv=none; b=VLupAkXgW9zYSrwcXkfJrdifJtfzDyQzxvFmmAz8mgtTXtfeEdKFCbjMmWcdu61JfhzQAloMm7Q2zvA/RhEPVq5OQpLF10KztmkMifAmQXnhdr4tsgB9psvedGDAH+L3tjmUp7biNj34Wup+A1S4Ir+Of9kOiTV2c8mk18n5qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679151; c=relaxed/simple;
	bh=3NDf5j7eWrHrW440/AaqxeY/A1RC9zY1VXbHkDEQ154=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDeBWECGfrO9iRBuP12L8hUShwtkcWq9sVdarVwy8ZnVMIG5cn73CW601LoTTRvDwTXRXioewRzbsJhjW8SODmIR+hVydbbiWeNX8GZ3eNgW1oHxYujcyzFJcFI6vabRFVHkWld1YtvqiqcukZ7g/mgvu2xqDwinYBCVvZ9+4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F0oDJr007332;
	Tue, 15 Apr 2025 01:05:23 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1js6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Apr 2025 01:05:23 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 14 Apr 2025 18:05:22 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 14 Apr 2025 18:05:19 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Tue, 15 Apr 2025 09:05:18 +0800
Message-ID: <20250415010518.2008216-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_yiPk7AkwJo0c6n@infradead.org>
References: <Z_yiPk7AkwJo0c6n@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ty7NNuGZDoar7YOn9Kc2ENxMCfgW6Xuv
X-Proofpoint-GUID: ty7NNuGZDoar7YOn9Kc2ENxMCfgW6Xuv
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=67fdb0d3 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ntnxu_dxGi-Q_OBSk1sA:9
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150003

On Sun, 13 Apr 2025 22:50:54 -0700, Christoph Hellwig wrote:
> On Fri, Apr 11, 2025 at 09:24:27AM +0800, Lizhi Xu wrote:
> > The ntfs3 can use the page cache directly, so its address_space_operations
> > need direct_IO.
> 
> I can't parse that sentence.  What are you trying to say with it?
The comments [1] of generic_file_read_iter() clearly states "read_iter()
for all filesystems that can use the page cache directly".

In the calltrace of this example, it is clear that direct_IO is not set.
In [3], it is also clear that the lack of direct_IO in ntfs_aops_cmpr
caused this problem.

In summary, direct_IO must be set in this issue.

[1]
 * generic_file_read_iter - generic filesystem read routine
 * @iocb:	kernel I/O control block
 * @iter:	destination for the data read
 *
 * This is the "read_iter()" routine for all filesystems
 * that can use the page cache directly.

[2]
generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
{
	size_t count = iov_iter_count(iter);
	ssize_t retval = 0;

	if (!count)
		return 0; /* skip atime */

	if (iocb->ki_flags & IOCB_DIRECT) {
		struct file *file = iocb->ki_filp;
		struct address_space *mapping = file->f_mapping;
		struct inode *inode = mapping->host;

		retval = kiocb_write_and_wait(iocb, count);
		if (retval < 0)
			return retval;
		file_accessed(file);

		retval = mapping->a_ops->direct_IO(iocb, iter); 
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b432163ebd15a0fb74051949cb61456d6c55ccbd
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4d9d84cc3c6f55..9b6a3f8d2e7c5c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Allowed to change compression for empty files and for directories only. */
 	if (!is_dedup(ni) && !is_encrypted(ni) &&
 	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		/* Change compress state. */
-		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
+		int err = 0;
+		struct address_space *mapping = inode->i_mapping;
+
+		/* write out all data and wait. */
+		filemap_invalidate_lock(mapping);
+		err = filemap_write_and_wait(mapping);
+
+		if (err >= 0) {
+			/* Change compress state. */
+			bool compr = flags & FS_COMPR_FL;
+			err = ni_set_compress(inode, compr);
+
+			/* For files change a_ops too. */
+			if (!err)
+				mapping->a_ops = compr ? &ntfs_aops_cmpr :
+							 &ntfs_aops;

BR,
Lizhi

