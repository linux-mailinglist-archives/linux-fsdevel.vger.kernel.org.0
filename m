Return-Path: <linux-fsdevel+bounces-24848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B589945680
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C41C233FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D11BF2B;
	Fri,  2 Aug 2024 03:01:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640983D68;
	Fri,  2 Aug 2024 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567713; cv=none; b=AQvhLnEDc+BOnFgoIX0SwmaVJYC8mNXQvSFp3GxwpYMW1ksuz5q3ovYmlXcp0BUW3SjPjVIr4G6OrUPsZZg3HfLqjFAihHO5YgI7HRZc6bTQSgiUe68dPekNlKQlAcqythX8wiQpUe6wEikU8Qg1wgwh/1ejNYBnLcOqa+30xTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567713; c=relaxed/simple;
	bh=nPgduAN7V2KzsCg/8hkD+4lmpoVidWGJmhdMh5v8kEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRxQZ4hnPu+N6lp3u7flBsvQwKdazd9mt0dPfl0kjezk/2pO9ZXFMH7/ngoFFv7dLRxqJVCjen4Pi/KvIqT8yfcGE+G/2KJMdtL9OttdwLKbzrFijsbvpQzcb0a8HXuE56sumUdLE1iN3RAlGQ2yO40FwdSngM+7mFJofSZjXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4720V5bR008263;
	Fri, 2 Aug 2024 03:01:19 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf186b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 03:01:19 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 20:01:18 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 20:01:15 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH V4] squashfs: Add i_size check in squash_read_inode
Date: Fri, 2 Aug 2024 11:01:14 +0800
Message-ID: <20240802030114.1400462-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802015006.900168-1-lizhi.xu@windriver.com>
References: <20240802015006.900168-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Kpm6qnmiWBeKOSmBQ4e9dC8V98HXQU73
X-Proofpoint-GUID: Kpm6qnmiWBeKOSmBQ4e9dC8V98HXQU73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_23,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408020019

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The length is calculated from i_size, so it is necessary to add a check
when i_size is initialized to confirm that its value is correct, otherwise
an error -EINVAL will be returned. Strictly, the check only applies to the
symlink type.

Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/squashfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..6c5dd225482f 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -287,6 +287,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
+		if ((int)inode->i_size < 0) {
+			ERROR("Wrong i_size %d!\n", inode->i_size);
+			return -EINVAL;
+		}
+
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
-- 
2.43.0


