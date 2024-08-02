Return-Path: <linux-fsdevel+bounces-24845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0794561A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D102AB22961
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE417BA4;
	Fri,  2 Aug 2024 01:50:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA479F0;
	Fri,  2 Aug 2024 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563428; cv=none; b=F90WOna6qT0PQA00S6N+qAbWjch7DzF//i43bT+Y0oBILPe1uy+3vmUFTq05yVdsV+hCN+EcetWB1km18OWdsVRel9z7EdwB+Oko6PuqD5slbxUgYq8aWiiF+Y07cGRCluIHgs806ZV6JVWEe36ljknaJ0y19urW8DzlvOXrLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563428; c=relaxed/simple;
	bh=IkN4TBJpwf8VUhVoftKLj45ogkUDwA7T0rVt0p6O1Q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbiOiRb5DMyFt91cID+zJ2TQeriKKxzMJiuiDP9aXtKoEPCEOGNuzFFSmn3rpVt5gy558fd9OdE3VoAiF2wqalZ2IPQ2BICTNi+4xw2R6jV/2Abyulm4+/KAoNLlS+WTm2MkJtbsNFu/IrF8N2sDf6byl2bQtp0PSLTlo8BLaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4720xmrF014142;
	Fri, 2 Aug 2024 01:50:11 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf184yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 01:50:11 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 18:50:10 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 18:50:07 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jack@suse.cz>
CC: <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH V3] squashfs: Add i_size check in squash_read_inode
Date: Fri, 2 Aug 2024 09:50:06 +0800
Message-ID: <20240802015006.900168-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801153042.prhbovbuys4zmprv@quack3>
References: <20240801153042.prhbovbuys4zmprv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HfIKw6mRCkilvhk2pj7yHfDrDtzr6CnJ
X-Proofpoint-GUID: HfIKw6mRCkilvhk2pj7yHfDrDtzr6CnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_23,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=989
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408020011

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The length is calculated from i_size, so it is necessary to add a check
when i_size is initialized to confirm that its value is correct, otherwise
an error -EINVAL will be returned.

Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/squashfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..3c667939f1d7 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -394,6 +394,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		return -EINVAL;
 	}
 
+	if ((int)inode->i_size < 0) {
+		ERROR("Wrong i_size %d!\n", inode->i_size);
+		return -EINVAL;
+	}
+
 	if (xattr_id != SQUASHFS_INVALID_XATTR && msblk->xattr_id_table) {
 		err = squashfs_xattr_lookup(sb, xattr_id,
 					&squashfs_i(inode)->xattr_count,
-- 
2.43.0


