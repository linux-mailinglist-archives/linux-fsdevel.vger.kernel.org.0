Return-Path: <linux-fsdevel+bounces-2928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A27ED9E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0771C20AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3508C19;
	Thu, 16 Nov 2023 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Q/xS+7bM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EE98;
	Wed, 15 Nov 2023 19:14:05 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AG2lIlD018161;
	Wed, 15 Nov 2023 19:13:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=/U+OKTrjTaTjZpiPlxKE8wMpB+i1XVATRI/cqJG1CRE=; b=
	Q/xS+7bMF1oWAKSMMWiqRlZ7zyXDVCZMbbCN+2rdc844rOagw+Gqg7sLqoaXBIy2
	yQApR/tzpwa0JQBgkJs/M1kZCHeLISeNUJHhc6RiC/88+hdgh/akZZ0LZyESnSHB
	+7sNhlFPSzsw+lWuGXp58EoeTalOZPzIUtwq4E9kRKzEA3+bzrai2G5xsT4taquG
	f/FyRg5p2qdP2Fl2D2tbyOsXrNNpUb+zRGVIA58kojmUzghA/AQSobjaPZZo/WDZ
	InERDLUNi+iZUIsd37oSqnlz8gPmtAi+JVkwibedgNrJgUZDil30odTuNlNtvgeU
	OdvjWoJDqLNfIPFYBgTGOg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uaa0km94p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Nov 2023 19:13:55 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:14:00 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:13:58 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] squashfs: squashfs_read_data need to check if the length is 0
Date: Thu, 16 Nov 2023 11:13:52 +0800
Message-ID: <20231116031352.40853-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000000526f2060a30a085@google.com>
References: <0000000000000526f2060a30a085@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Wlqcm3DvHphV4joZwIaJWP-_HNpXNzkX
X-Proofpoint-GUID: Wlqcm3DvHphV4joZwIaJWP-_HNpXNzkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=871 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311160024

when the length passed in is 0, the subsequent process should be exited.

Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 581ce9519339..2dc730800f44 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -321,7 +321,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
 	}
-	if (length < 0 || length > output->length ||
+	if (length <= 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
 		res = -EIO;
 		goto out;
-- 
2.25.1


