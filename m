Return-Path: <linux-fsdevel+bounces-37793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07C9F7B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851587A289D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BE225A21;
	Thu, 19 Dec 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLaPxZfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156021D58E;
	Thu, 19 Dec 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611988; cv=none; b=kbkFYmGpRmV/47Hgm16SIN1kxLjB86PrNil0SnfDLrWG1wfNpElhfnDbbsRw++mqw8J0I2o590HpH8hV5L4cqaXJMAE+IdOTqBqQ3ULYveJiQbLCM4d5/uCKI8ZlQQ1qQHRC6l4ejNxyo5Kqq57umc2EhvqSc3Mip7eG4FcSYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611988; c=relaxed/simple;
	bh=CuBOXjTuvHfA0Uu7CO0zK1h+lN97EAVcve9h1X9zP7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/V6sM3LSPqjDCyUb5cRq5qwjuem4SxkZ6SYXJO09Glj01p1yOCn2jJEiF91pe6nam6FyKV0JyASTLa6lLVaGg6NEsUS9CLJ7HyVHhWAuGtEZnBjV7RE+/z9SDyCxop6zMiSyr1r447X7kR5GbGaXOkJrsqj1iwC93e/lAc5b7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLaPxZfz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJB0ada014467;
	Thu, 19 Dec 2024 12:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qenZDd2Pg2oH6MmP0
	yiyoUp+FSIFvvyOcjz6tEO+sp8=; b=RLaPxZfzSq4XrLytywrb35As5P3Ea5Uqs
	pvUkBOKsEUzNbDRQQQgZ8DxHQDWYq+LVUbOzU1eSPMVUHVpm3Eh9ggO8hJIO9xMR
	qas4TRaVafLbPeCl2mMORlDVpf0K2eJ2ImEehtVRBxCiHeSTACJZXyiNdBPrCHTj
	mH+a2rWW2N/CfuYrlyMdUVvt6lKQIZnA70g7O8FtKcBLPwTYn67butVpTnOcnlQF
	jvXXDdatbMvuox1+zdXWqMJDM8hYY55tNJorH9E9/oc40SQvmgi+uBKpqCrUjFpl
	qKSihLoLB0ftLBKKitM9w+/Bn2jUmRzDLrQ6jPzQbrBgE0LsoANjA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mj808dg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJCQOFd003695;
	Thu, 19 Dec 2024 12:39:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mj808dg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ8vSDo024047;
	Thu, 19 Dec 2024 12:39:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukn0wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJCdVuq50463176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 12:39:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329D620043;
	Thu, 19 Dec 2024 12:39:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9659E20040;
	Thu, 19 Dec 2024 12:39:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.219.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 12:39:29 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] include/linux.h: use linux/magic.h to get XFS_SUPER_MAGIC
Date: Thu, 19 Dec 2024 18:09:13 +0530
Message-ID: <66f4220d2c2da6ce143114f9635ed8cd4e54af1d.1734611784.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734611784.git.ojaswin@linux.ibm.com>
References: <cover.1734611784.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OI_ZFSzmbKymEj-HCiJebYcX9P__ipPg
X-Proofpoint-ORIG-GUID: VLgjs2cL8888JOEYdeEjwUrH29TrVKQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=592 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190100

This avoids open coding the magic number

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 include/linux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux.h b/include/linux.h
index e9eb7bfb26a1..b3516d54c51b 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -37,6 +37,7 @@
 #endif
 #include <unistd.h>
 #include <assert.h>
+#include <linux/magic.h> /* super block magic numbers */
 
 static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
 {
@@ -60,7 +61,7 @@ static __inline__ int platform_test_xfs_fd(int fd)
 		return 0;
 	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
 		return 0;
-	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
+	return statfsbuf.f_type == XFS_SUPER_MAGIC;
 }
 
 static __inline__ int platform_test_xfs_path(const char *path)
-- 
2.43.5


