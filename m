Return-Path: <linux-fsdevel+bounces-24859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24652945D13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4491F224BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957811DF677;
	Fri,  2 Aug 2024 11:17:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997B134B6;
	Fri,  2 Aug 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597430; cv=none; b=rDfaU33tHrKx98J8gPbGSyaXnINHe/QZrsvg/GyZYz2s7FeNDMYzeRNGv147H3RKdyP0DFoRBYGb3g3NovBJA2K9j80tffAKjdJz7hoDSZrfSst5O0in3xlUjWCtzkO2Oj3yVILRLJXfQeK7PpO98tQBRBbMt686oMfJdjdtmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597430; c=relaxed/simple;
	bh=kdLR7/cpds8pc5n/xWKZBwHekmR7maVn/tf0jPEHv98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiAls1pg4exPdcXNdAxqB4txFmJ717wfIH2pjHnIdH7Dtc40kggb4P53tvzTW/cRZFwvtugTWgT2zh0JRUEpdQ9D3vNTJZPPYt/lwfPjuekuAALynjpcQtYMqo4Ds6SPwr1B5nnNSJAPYtnpuTvat1Rzcf4Tgnv5gFYPK/H1ccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AYG5Z009941;
	Fri, 2 Aug 2024 11:16:45 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf18j1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 11:16:45 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 04:16:43 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 04:16:41 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jack@suse.cz>
CC: <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH V5] squashfs: Add i_size check in squash_read_inode
Date: Fri, 2 Aug 2024 19:16:40 +0800
Message-ID: <20240802111640.2762325-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802093310.twbwdi5hpgpth63z@quack3>
References: <20240802093310.twbwdi5hpgpth63z@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xwEG6FKVqN5OaHtAnOmZiVlsrsO9UCJV
X-Proofpoint-GUID: xwEG6FKVqN5OaHtAnOmZiVlsrsO9UCJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_07,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408020076

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The length is calculated from i_size, so it is necessary to add a check
when i_size is initialized to confirm that its value is correct, otherwise
an error -EINVAL will be returned. Strictly, the check only applies to the
symlink type. Add larger symlink check.

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
+		if ((int)inode->i_size < 0 || inode->i_size > PAGE_SIZE) {
+			ERROR("Wrong i_size %d!\n", inode->i_size);
+			return -EINVAL;
+		}
+
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
-- 
2.43.0


