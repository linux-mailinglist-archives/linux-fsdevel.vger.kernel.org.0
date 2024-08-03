Return-Path: <linux-fsdevel+bounces-24913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410894688E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A2E1C20C0E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5D14D44D;
	Sat,  3 Aug 2024 07:44:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D0D2EE;
	Sat,  3 Aug 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722671073; cv=none; b=t53u5aVh7ycWYmE2Vyaw/680VjiIwTPId0pXOFj/DrT4YOiC0Vn149FcsuBPSxLwKCvL9PBfhYtVHnyChJwhSpIdS/tHD7hlUuE+escs1VRNv14EvKkbgvWV4oGtx8yQ1CSKVzQkqHq/lLUyfxpObAJ1eKC6eBgWb7qu1GR6lOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722671073; c=relaxed/simple;
	bh=v+bOWT/FY3VGKxKZHQVk9E/gqV65zK1Em0aeUn6okFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3XSEn4YQNNk4Bg1PzN9NMfBhqTdypTh5+gtm3ycEZNp7gWZN3LZoHSRXBi5A8+0Be0efrTNjv0fa6XXvX68ou5kGVbsmQAUwXBUkfmdtMcbfWl2Cy7zLH3lFp+9A26fQ6fqR0yjgwiSjpwxCGV6YN0gVmBInD/6iKfH/9Zh7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4737hsMO021803;
	Sat, 3 Aug 2024 07:43:54 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry06h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 03 Aug 2024 07:43:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 3 Aug 2024 00:43:53 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 3 Aug 2024 00:43:50 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Date: Sat, 3 Aug 2024 15:43:49 +0800
Message-ID: <20240803074349.3599957-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803040729.1677477-1-lizhi.xu@windriver.com>
References: <20240803040729.1677477-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iUNmPIyKVUgqU62z4qZ2NzI6MyHBxWaX
X-Proofpoint-GUID: iUNmPIyKVUgqU62z4qZ2NzI6MyHBxWaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-03_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408030050

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The length is calculated from i_size, this case is about symlink, so i_size
value is derived from symlink_size, so it is necessary to add a check to
confirm that symlink_size value is valid, otherwise an error -EINVAL will
be returned. 

If symlink_size is too large, it may result in a negative value when
calculating length in squashfs_symlink_read_folio due to int overflow,
and its value must be greater than PAGE_SIZE at this time.

Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/squashfs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..bed6764e4461 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -273,14 +273,21 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	case SQUASHFS_SYMLINK_TYPE:
 	case SQUASHFS_LSYMLINK_TYPE: {
 		struct squashfs_symlink_inode *sqsh_ino = &squashfs_ino.symlink;
+		loff_t symlink_size;
 
 		err = squashfs_read_metadata(sb, sqsh_ino, &block, &offset,
 				sizeof(*sqsh_ino));
 		if (err < 0)
 			goto failed_read;
 
+		symlink_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (symlink_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink, size [%llu]\n", symlink_size);
+			return -EINVAL;
+		}
+
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		inode->i_size = symlink_size;
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
-- 
2.43.0


