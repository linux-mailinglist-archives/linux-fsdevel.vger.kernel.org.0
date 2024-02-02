Return-Path: <linux-fsdevel+bounces-10009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78E846FF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924AE1C2699B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144A140779;
	Fri,  2 Feb 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="WCVxY8Vi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F497E76D;
	Fri,  2 Feb 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876215; cv=none; b=PeJiuAg72LgCjfK6bEYbUR3NPhrVCpIFZhhfKIvK9YouAJhAQYDXhtjTdYGIoleuroXniFvj/KVlevABBue14Sytf9khI+7LAcgVVyH0jmrqxookcKz4qyOmNF4s0h8UD6kuS44MPdnrQkROuhlHXrB+6QP/GYELzAGg7D7kC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876215; c=relaxed/simple;
	bh=l/aopIMOwoJ7HIS7T+cRzAwMN/3xy7HCXK2/ibsdft4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMKyJI6hQS/MPTQEdtx8UHT8AztXv+q6QP+rLmcsSV5sGUixTQJyGnmVWte9cAV3vAf8fNM1IDh0lwaBRlLQxBmBxJSWVeWpNp/RRJvcUMNmH3uw0zvnQEcVNEUoLX7Q1KYzk5hVTKEvEss9EnJ6tweJM9wwwx8/QbtkLObpVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=WCVxY8Vi; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412BQoac017730;
	Fri, 2 Feb 2024 04:15:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=UYcTMeXPca+N73s96cgEXe+7bZsHSgkXHU5oK5Zc7aU=; b=
	WCVxY8VinqwuwawmN5DF+AGfiuAh90rRLXOR+wjLtLmpSdHoVCi0pDsKX7J6IVWf
	Q/oBTNzvgxR2xNc6ExsXuCUXlmjtiVXNeTa35z4TBuX8DeQalh9LbykqsnvWWAUQ
	0VVCLjf5li+K0OlJbHFqSQY/n3/PCkbPdFcaQMZRIIwB4GfrLp4Jy8/3Wnyefuga
	S3jVRC3SONfcWGKj7vCkmreaL5+kt5DxrehB+Q4EVlxTZVedTfPTgDGE6drJ/VaH
	LkVvwLWySOta2yvp2nxdQm03T1RHvTyiDUSawWlVlOrDqUPklCMusNsha8A9ek5W
	724xz/iA7/RfpEZd1IuSoQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0puv0dvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Feb 2024 04:15:35 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 04:15:34 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 04:15:32 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
CC: <asmadeus@codewreck.org>, <ericvh@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux_oss@crudebyte.com>, <lucho@ionkov.net>,
        <syzkaller-bugs@googlegroups.com>, <v9fs@lists.linux.dev>
Subject: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
Date: Fri, 2 Feb 2024 20:15:31 +0800
Message-ID: <20240202121531.2550018-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000055ecb906105ed669@google.com>
References: <00000000000055ecb906105ed669@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F0ZlN-hNRdusUqWNtk5stVihewg4qzWd
X-Proofpoint-ORIG-GUID: F0ZlN-hNRdusUqWNtk5stVihewg4qzWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=753 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020090

The incorrect logical order of accessing the st object code in v9fs_fid_iget_dotl
is causing this uaf.

Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..2b313fe7003e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -78,11 +78,11 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 
 	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
+	v9fs_stat2inode_dotl(st, inode, 0);
 	kfree(st);
 	if (retval)
 		goto error;
 
-	v9fs_stat2inode_dotl(st, inode, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);
-- 
2.43.0


