Return-Path: <linux-fsdevel+bounces-24799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27596944EF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11271F23C70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FB13C672;
	Thu,  1 Aug 2024 15:18:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2F1EB4AC;
	Thu,  1 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525488; cv=none; b=O6XGIYTmc75ZH5S6ME9046yanWPvzxeQlzGlQ6zP3pJuRZSBH5739VLhuHapTtMtMiq5Kpl0lNLCNd/yihvb14gS5nioGudxs/sOfZGXpNAg3Zg+32acQSQNICTC2cLGqWGxVDLoRAScRffxtHTmIGIDrLoogsSFiW45b/hEXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525488; c=relaxed/simple;
	bh=3WBfOH1ud3f8afsbsqBlfOilHhJAvvgVu0/bTsQmips=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrjbwN1Wy+AmFpxn7aR9rfygIlFkqslbs39Ljc8aRtZzDQY2jq/bR7YGXlUeWaTq8GGuARG7oQCCikpdC7k7w125u2wJlBR4mUv9kYLsCXX1uMrNt77Y6+ENb6wuQqmfKHH9VPvOk4FZZFVyWRXkgdVZm4NTVIqJi+ed5Eb184w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Ca1bm018700;
	Thu, 1 Aug 2024 08:17:44 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mv61d5je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 01 Aug 2024 08:17:44 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 08:17:43 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 08:17:41 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] squashfs: Add length check in squashfs_symlink_read_folio
Date: Thu, 1 Aug 2024 23:17:40 +0800
Message-ID: <20240801151740.339272-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801124220.GP5334@ZenIV>
References: <20240801124220.GP5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: y8kMAY6nMZhi_1AstwZU_3jsk_A8TCUx
X-Proofpoint-ORIG-GUID: y8kMAY6nMZhi_1AstwZU_3jsk_A8TCUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_13,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408010099

syzbot report KMSAN: uninit-value in pick_link, the root cause is that
squashfs_symlink_read_folio did not check the length, resulting in folio
not being initialized and did not return the corresponding error code.

The incorrect value of length is due to the incorrect value of inode->i_size.

Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/squashfs/symlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 6ef735bd841a..d5fa5165ddd6 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -61,6 +61,12 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 		}
 	}
 
+	if (length < 0) {
+		ERROR("Unable to read symlink, wrong length [%d]\n", length);
+		error = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Read length bytes from symlink metadata.  Squashfs_read_metadata
 	 * is not used here because it can sleep and we want to use
-- 
2.43.0


