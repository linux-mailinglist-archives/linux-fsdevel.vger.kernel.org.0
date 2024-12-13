Return-Path: <linux-fsdevel+bounces-37394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945C9F1B29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6E16B518
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 00:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC041F03E9;
	Fri, 13 Dec 2024 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpYy9Wi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E21DED70;
	Fri, 13 Dec 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134244; cv=none; b=kLFwg7gNFe6cKx6RReubQZhpKOL6vMxhW/qmNQE59rzbs/oDRoFAZL4c6oNfRv12Awb5n7u4FNvg76k52m+hUcA0z1FVgVWjE4d8GdyovtwaQeXrHydWyj3n2ZnMoHXH1St/7YivWWWgt6QAYgi0cKXbPitW8Kg9ORIbh2UKsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134244; c=relaxed/simple;
	bh=1YYTaVqGIazxOCO5qZ8bTy5t+fwoP7FXeMFgkaaU1f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cmygvxs1hByK0CIa8rf5ySqdF9oGYu2oK0mUJmEzaN7zstdtqy5cDLVg5cksbZsVSoXg18uSbdIrdpF3w+B2jkn9GxdpXyrTMTwKwWmin8jg+Wal+17rGeD481czjSk0MWy21eBlhQhYuwWlf2jRQzb/jmudBJftLqy49LNGC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpYy9Wi+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKBoaT015471;
	Fri, 13 Dec 2024 23:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=yt7M4uZ2L/ft+OJbYnX0YlOwwKxkG
	uYZ1Cixgs9PFnk=; b=QpYy9Wi+kBgDdyRJ8ItmAq1hefTBOzF/Q4FgC4bAdh4ac
	TstYrnBI+ypNdQfuOEi7BcydbmoA+LP9aLkUaPbixF4iKdThIiT0etKugWPbzlYD
	NTqkSsrUrflaJVv7b5XMhQDmBMmhE4ulRiLQW/8aClHaoyn8biud73V0yM2Zbp06
	vFvoh3abnWOiIOFscw49WvZzSeau5ji3oDCvvhzl2JGvtjUpxOTXM6Nv77Juc/HH
	nlXW1paFb0hq3lV6YjBIppBFRGIlfxFJvpwCNlmvw9iJXwHCvJ1RXeKojKVKbVrq
	5NHHdpAsK+Fg2Gbr7vPfoD+COK83jt+EhL0SSyryw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcejsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 23:57:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDNlx06020564;
	Fri, 13 Dec 2024 23:57:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctd4nub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 23:57:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BDNvBFI006513;
	Fri, 13 Dec 2024 23:57:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43cctd4nrj-1;
	Fri, 13 Dec 2024 23:57:11 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: sherry.yang@oracle.com, linkinjeon@kernel.org, sj1557.seo@samsung.com,
        wataru.aoyama@sony.com, Andy.Wu@sony.com, Yuezhang.Mo@sony.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on __exfat_get_dentry_set
Date: Fri, 13 Dec 2024 15:57:05 -0800
Message-ID: <20241213235705.2201714-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_11,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130170
X-Proofpoint-ORIG-GUID: AQuBSZG9LllaOzN6H40-WJCWIgZElyXQ
X-Proofpoint-GUID: AQuBSZG9LllaOzN6H40-WJCWIgZElyXQ

From: Sungjong Seo <sj1557.seo@samsung.com>

commit 89fc548767a2155231128cb98726d6d2ea1256c9 upstream.

When accessing a file with more entries than ES_MAX_ENTRY_NUM, the bh-array
is allocated in __exfat_get_entry_set. The problem is that the bh-array is
allocated with GFP_KERNEL. It does not make sense. In the following cases,
a deadlock for sbi->s_lock between the two processes may occur.

       CPU0                CPU1
       ----                ----
  kswapd
   balance_pgdat
    lock(fs_reclaim)
                      exfat_iterate
                       lock(&sbi->s_lock)
                       exfat_readdir
                        exfat_get_uniname_from_ext_entry
                         exfat_get_dentry_set
                          __exfat_get_dentry_set
                           kmalloc_array
                            ...
                            lock(fs_reclaim)
    ...
    evict
     exfat_evict_inode
      lock(&sbi->s_lock)

To fix this, let's allocate bh-array with GFP_NOFS.

Fixes: a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000fef47e0618c0327f@google.com
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Sherry: The problematic commit was backported to 5.15.y and 5.10.y,
thus backport this fix]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 fs/exfat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index be7570d01ae1..0a1b1de032ef 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -878,7 +878,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
 	if (num_bh > ARRAY_SIZE(es->__bh)) {
-		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_NOFS);
 		if (!es->bh) {
 			brelse(bh);
 			kfree(es);
-- 
2.46.0


