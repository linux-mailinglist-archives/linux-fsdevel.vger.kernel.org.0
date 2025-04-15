Return-Path: <linux-fsdevel+bounces-46447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24BA897E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E017A16E7AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAF27A939;
	Tue, 15 Apr 2025 09:27:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247632820B0;
	Tue, 15 Apr 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709236; cv=none; b=AY7ETay/B0v7yu54jxXKoqnkKOBp15osUhghTtKUim0gkZEcrbwL2sBCeO1Kto/u5f57+8Fi299+1n1i9ne0qqYpXoWyJ8Jf0QtnPs/iv100WHJ/2YW9QgxNaNv0ChiMI2vyaK6kUa3yqkrHlOb+W5phcHWaJEKpMyLC8PupMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709236; c=relaxed/simple;
	bh=LP2dtJdyJA35myFiGrNHz8KbwDPs7k7TIUhuQIUB7U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6gxDjaMtaLIowz0x/5bVbJIusynr10gS0z/F2TlLVZRakiycmKCmtv+RzepiktExoHBTMviom/a4aO5/TsgfqLjiPaQ4S0sfou3JPuhmcZFeb07GLs6QvS1SQhD72a7n/FjH5oLe5ch6wlO6QBnPPt0xIbLfF2LR9jfPvHLzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6JK5V008571;
	Tue, 15 Apr 2025 09:26:42 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1k67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Apr 2025 09:26:41 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 15 Apr 2025 02:26:40 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 15 Apr 2025 02:26:37 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jack@suse.cz>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <hch@infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Tue, 15 Apr 2025 17:26:37 +0800
Message-ID: <20250415092637.251786-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <q5zbucxhdxsso7r3ydtnsz7jjkohc2zevz5swfbzwjizceqicp@32vssyaakhqo>
References: <q5zbucxhdxsso7r3ydtnsz7jjkohc2zevz5swfbzwjizceqicp@32vssyaakhqo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ajtiTctVFHTci5pOX7J_hLlgq0UvoyFH
X-Proofpoint-GUID: ajtiTctVFHTci5pOX7J_hLlgq0UvoyFH
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=67fe2651 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=wy8MQQXfsJFEdZ-aUNQA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=921 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150065

The ntfs3 can use the page cache directly, so its address_space_operations
need direct_IO. Exit ntfs_direct_IO() if it is a compressed file.

Fixes: b432163ebd15 ("fs/ntfs3: Update inode->i_mapping->a_ops on compression state")
Reported-by: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e36cc3297bd3afd25e19
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: exit direct io if it is a compressed file.

 fs/ntfs3/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3e2957a1e360..0f0d27d4644a 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -805,6 +805,10 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		ret = 0;
 		goto out;
 	}
+	if (is_compressed(ni)) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter,
 				 wr ? ntfs_get_block_direct_IO_W :
@@ -2068,5 +2072,6 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.dirty_folio	= block_dirty_folio,
+	.direct_IO	= ntfs_direct_IO,
 };
 // clang-format on
-- 
2.43.0


