Return-Path: <linux-fsdevel+bounces-33588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60499BAA59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 02:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946DE281418
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E016132E;
	Mon,  4 Nov 2024 01:37:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948816FD5;
	Mon,  4 Nov 2024 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684244; cv=none; b=BOn+/huCK8BZaiaDZTssAvIVRz8wuXSjeax1GM//g6bLdUGdN8jnfcr3ITEwtU7ipZ1gK1o30Mm9pllN/IV10l5SWOaH2xjGmIeNhb4u4HgPOVFPa0sgREUGI+JRjiAda8CJvygnkuXqWDjnioGggy0lqSA+leeedqvOpnBeMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684244; c=relaxed/simple;
	bh=Tslz76n65FpbPVucu0WTbEMvjXjflydo60zuHWAy+p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9TdtOOuSElUxPmrVO48F1l8WIcBuJiHnSkU+mzqBvvyiP5pHoSVLNRCyklTnBTexnIfisVvVYYfyr1Cq7M+ooIt3/L4gvWirf5Agurq6faqSyszclP46tNkqUU2jvOILpQz3ELHgfvY0VUxeL+Z15F2VqA8PkjxtNTaX8CZUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A41M3Us004445;
	Sun, 3 Nov 2024 17:37:11 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42nfc315h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 03 Nov 2024 17:37:11 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 17:37:11 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 17:37:09 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <miklos@szeredi.hu>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
Date: Mon, 4 Nov 2024 09:37:08 +0800
Message-ID: <20241104013708.3134548-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
References: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T7feTOKQ c=1 sm=1 tr=0 ts=67282547 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=i1PW8iXTy5kQwggbCGMA:9
X-Proofpoint-GUID: ZQcHO-ZO_BRP64XYQlqx3hXR9sJ4OZUO
X-Proofpoint-ORIG-GUID: ZQcHO-ZO_BRP64XYQlqx3hXR9sJ4OZUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-03_22,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 mlxlogscore=911 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411040011

about this case, calltrace is:
erofs_read_superblock()->
	erofs_read_metabuf()->
		erofs_bread()->
			read_mapping_folio()
	
41                  folio = read_mapping_folio(buf->mapping, index, NULL);
file is NULL in read_mapping_folio() at fs/erofs/data.c, and in fuse_do_readpage(),
it need file pass node id and file handle(in userspace), so need to add a
check for file in fuse_read_folio().

#syz test

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f33fbce86ae0..fe6df701da24 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -902,6 +902,9 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 	if (fuse_is_bad(inode))
 		goto out;
 
+	if (!file)
+		goto out;
+
 	err = fuse_do_readpage(file, page);
 	fuse_invalidate_atime(inode);
  out:

