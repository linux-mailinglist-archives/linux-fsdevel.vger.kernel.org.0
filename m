Return-Path: <linux-fsdevel+bounces-33732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E69BE36B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3EF1C215A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7A1DC046;
	Wed,  6 Nov 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E/0mRUTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE721D358B;
	Wed,  6 Nov 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887412; cv=none; b=hbSm7sMHBOyEEXZFBp3ikBTEZyGjeB4MO2otDNU6gIhurbkiPY5Zvu8fKEX8z+wXIwFizCvwdpDCVI554B8qII93eJckuCAEFF344cRlf5Cb4hvk4F6B7MPEgnGTZiGiP2+CG/HdvwqoCIFTfOqPkikD7ovTtM/czt+/9fZyy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887412; c=relaxed/simple;
	bh=eYDOWcPa2ciGS4G1ET/o3nhJOJjUKeCB0RU3cD7giJ8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z0h3DGoRORIksO1tBsrB3AuOW51ZFJkN/yY12za2J1baw0E1jd9deOLs1wb3NpEYfiSu9Ib0VmuVm5sTIYpKruGzzLFQIvyBxoXhgXIDpPf3z9eQxb2hymU9EuzhAMwvb2RqfCBLGAcNrxHrrmnNC0tRrQUk4hSzFZH+LDfwp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E/0mRUTS; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730887103; bh=T6ISGij/28iNi571YET1e4ZKWBp2zqaPu/RNUpV/bCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/0mRUTSGvJZOX+cfi6OBFC6nLOoz7RAKbvQp161pfeK4z4L+7uOTjHSdXtGpR+8y
	 U5p/kVHtZjtaXJdVx2hYo+5CSerGKqUVR5AN34R7LqUmZ7UsX3fNmZcXDwz/bf4lHu
	 PAqOQIxCxbhlLVNenr0sqN7YhyCCtASsthUrcCu0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id E93128B6; Wed, 06 Nov 2024 17:58:19 +0800
X-QQ-mid: xmsmtpt1730887099twabkf3i3
Message-ID: <tencent_E298974436464AA47527762F67923C3D3609@qq.com>
X-QQ-XMAILINFO: MIXpHopat2IaQcxi7iiR1KyaoM2oCRhE6iZ60lk7MFlWJV8jD2LfeMbm9ywJIa
	 ExUZhoW18VztkueoaR4BoDxA4+47uwc8V/0Sllvx4TgT8NW8zg8pZhiLMqrPQS4RZtN2r3OI1Lz0
	 v6wWcxERrozACgGxZQQzytGTPS9t8duFciUOgdaCzOqQ/ZyB7vyHivDu0GPOqeHOi3DhugfuYmhW
	 b1eYkvKeeA7YuOhBlLU0zwf4IWee30yjYUUE/hHPMSpXpC5wCEN0yjB/TbWH0ampvOnRhgB3u4UW
	 kddP3fQsqc2O1E5P8VwQjl10qGdcRnMsR/o6IV1asxMt3SVIr889Sgw4NFicrvd9eG7UWxQSjSF1
	 ztUQB/9ELFzhGkUeGK0h1m4aGKLn1hXHF7cnPd29fhNwj2J3zbq/eY3twbhFWPgTXh1NKwgZw9w6
	 owzSQo79j5au3FZP5MaHdlsWqE2OylYVz5CHBr5Ivt/rjCVMr96UnYaO+Fhk53yg1jzJrbcy7ATy
	 skzcabo4xqUtyOhNz8j7EYX/I8haYSWxcHMr041ajkjFn04Q1JQRxtWXeByH96w6qxZXOmuXMgKB
	 QhILp5BCmpzPR9aKvVVdHoTUKMEJ7rwqtZSX89b0+kO8+e+JimfCsrNWdM9UZOOSnEcIkZ01GiYY
	 /vgi+8h6VacaRW8K+MF4wDGHN3z39kr0sQD8CWibEJnJwldeTdG0ypKHoIb6qve9nWRRV9ifakqV
	 WDFPhg9d+urQAlBGRvVeEag9uWZ1Tjy9rnicd/ik8lZG1cvoEKMIlgSBqBUTCCrIpPXINq3S2GKA
	 cMqphXITW8T517nogyzggFYQGSd6GsR8nWr88L/srIGdzi/S8sztUZ5/LVRsyXf8GC5eBfIJ/wlR
	 Eew/uyi1kWRSvcPM3X832GfNbpaery+0uW9yEMTLlMP1FNcfAATdRWFGhMX8q2kw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: add check for cat key length
Date: Wed,  6 Nov 2024 17:58:07 +0800
X-OQ-MSGID: <20241106095806.2695499-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <672af85a.050a0220.2edce.151c.GAE@google.com>
References: <672af85a.050a0220.2edce.151c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a uninit-value in hfsplus_cat_bin_cmp_key.
The result of reading from the raw data of the node in hfs_bnode_read_u16()
is 0, and the final calculated catalog key length is 2, which will eventually
lead to too little key data read from the node to initialize the parent member
of struct hfsplus_cat_key.

The solution is to increase the key length judgment, and terminate the
subsequent operations if it is too small.

#syz test

Reported-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=968ecf5dc01b3e0148ec
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/brec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..da38638ad808 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -51,6 +51,13 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 		}
 
 		retval = hfs_bnode_read_u16(node, recoff) + 2;
+		if (node->tree->cnid == HFSPLUS_CAT_CNID &&
+		    retval < offsetof(struct hfsplus_cat_key, parent) +
+			     sizeof(hfsplus_cnid)) {
+			pr_err("keylen %d too small\n",
+				retval);
+			return 0;
+		}
 		if (retval > node->tree->max_key_len + 2) {
 			pr_err("keylen %d too large\n",
 				retval);
-- 
2.43.0


