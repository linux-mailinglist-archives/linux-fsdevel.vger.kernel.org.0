Return-Path: <linux-fsdevel+bounces-37791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547779F7B99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BBC1892670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617522541A;
	Thu, 19 Dec 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNka8ei/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915412253F8;
	Thu, 19 Dec 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611982; cv=none; b=FM7bfY9U6x0l50LHYF26UNkcS9AbpzMevlAxE0hKgfvva4qbVXmSedBPKuLxA1DlUzU/WWpL8413e8wIM5VlM2fPj8n6s5P6s0uEtg9dtJHXDDxaTEDUXQTuHKdw7H9/ewGkO2KDCSaec5DGq6RODg5zDxVw4EikCxDtnGypoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611982; c=relaxed/simple;
	bh=pfGkfSRbBeBZe2pfv8FMlZ/K7pb4YLUhiD7uHI13nsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3g8U5KWyoq8OJ23oRMLkxJewIUg48uxQ5D/zKXaTRDX9XSjf0cM34bKxZj1A7y38ixTkjC3EqXzKamkPKeviFvXe71Pda8OvfaQAO/4lyKqOrG4NWgxjfV8BC8DkAgNSEIPm/FQ8tdRVenfLPzj3joF8g+HE8Pz1JrssoYaBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZNka8ei/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ3qMCj012952;
	Thu, 19 Dec 2024 12:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=56iEWu45x5ZogUIJ3
	B7E3Njw8FYRxDwCN46dpTp1gNM=; b=ZNka8ei/DdSx3P8jezCG1BFdPAkkxYG7n
	rPIP9FoCBG4TUCZ2VpWIhnAq+LnQxazYU8HBIgzM4ERPpE9ZIKYBfiKlXEvYFGg4
	OcuBvyt6ABMftRPJtgnmmTkMoE9bc5TIImwIqvhYo24s72X2/JcRyZ7RZMqUYfcm
	XCX1NMG0lo2mIbIA2WYNQAQHTOAbKRU3EmACJzHQ2SNbhIXr2WsOURwgxgWSYABj
	QCjfRfJ4Jya8zHI9tuPpSUjmAfTNe8Hb8t5K8KwYeXIHPgiJMvjZxhjnfd30EtkM
	mpACQgwqFmI+uZ5gkF8UeccMnbLqDxf9xCVVVo0ohgmsNiMib8eKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyc242v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJCc9vV025819;
	Thu, 19 Dec 2024 12:39:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyc242t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJAhP5E014391;
	Thu, 19 Dec 2024 12:39:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21vqy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJCdZmk30605656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 12:39:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2456F20043;
	Thu, 19 Dec 2024 12:39:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5791620040;
	Thu, 19 Dec 2024 12:39:33 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.219.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 12:39:33 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 3/3] xfs_io: add extsize command support
Date: Thu, 19 Dec 2024 18:09:15 +0530
Message-ID: <931b3f0da15da34cfd9d6460e930ce301e721cf5.1734611784.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: ZWVJrq1aX-NeksQ9JZSwX-1sLjowNjnx
X-Proofpoint-ORIG-GUID: o3FufTq2-XpEVn0_9XQTSF2ILr_HfmXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190100

extsize command is currently only supported with XFS filesystem.
Lift this restriction now that ext4 is also supporting extsize hints.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 io/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/open.c b/io/open.c
index a30dd89a1fd5..2582ff9b862e 100644
--- a/io/open.c
+++ b/io/open.c
@@ -997,7 +997,7 @@ open_init(void)
 	extsize_cmd.args = _("[-D | -R] [extsize]");
 	extsize_cmd.argmin = 0;
 	extsize_cmd.argmax = -1;
-	extsize_cmd.flags = CMD_NOMAP_OK;
+	extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
 	extsize_cmd.oneline =
 		_("get/set preferred extent size (in bytes) for the open file");
 	extsize_cmd.help = extsize_help;
-- 
2.43.5


