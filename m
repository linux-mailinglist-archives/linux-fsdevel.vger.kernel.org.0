Return-Path: <linux-fsdevel+bounces-24909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13E946750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AEEB2148C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 04:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2312B7F;
	Sat,  3 Aug 2024 04:07:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B997FF;
	Sat,  3 Aug 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722658075; cv=none; b=YkAUSuJu/qb+U/X3kZnF2N6uzYlQj4haZLBqfJhp63/ci6BroXdpT9FXhY3v2984rnqrIVy7SXwIQlHqawfgVjgmStl+gk3MGV73P8H8i/cu9QEsTPnCTjA6G1krxsrq6FAvBd2ZiM3gQ0YRatLVAjC6/NI7RwV1BN4H2opwlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722658075; c=relaxed/simple;
	bh=UklIIqxlnbqfNLyjxBzBHPaFjUAHAj9Ac/HgXWHVlIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7wSNSSzjch2zkFHHzjBuraQhWBIZJeuHIpEhf/StHr1ITYGTAbFAxC/AuWPxqN/ewM0xxAO1GawlGo+xCGG5J7xinK+gaHsOYMNJVt2ovgPLA6hm5yWqY3m4OPPHVANUP/Y8Ys5MfdFyaeFYkhK8N/rCp0JiDc+ps+V0t1PEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4733tSRq019728;
	Fri, 2 Aug 2024 21:07:34 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf097yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 21:07:33 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 21:07:33 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 21:07:30 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V6] squashfs: Add symlink size check in squash_read_inode
Date: Sat, 3 Aug 2024 12:07:29 +0800
Message-ID: <20240803040729.1677477-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802150348.GW5334@ZenIV>
References: <20240802150348.GW5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: n8es7XQiANWe4NmCxOwfJzw_s_1kNH4N
X-Proofpoint-ORIG-GUID: n8es7XQiANWe4NmCxOwfJzw_s_1kNH4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408030024

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The length is calculated from i_size, this case is about symlink, so i_size
value is derived from symlink_size, so it is necessary to add a check
when i_size is initialized to confirm that its value is correct, otherwise
an error -EINVAL will be returned. 

If symlink_size is too large, it will result in a negative value when
calculating length in squashfs_symlink_read_folio, and its value must
be greater than PAGE_SIZE at this time.

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


