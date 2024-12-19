Return-Path: <linux-fsdevel+bounces-37790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10479F7B96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD97618941EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0C224B17;
	Thu, 19 Dec 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+DYs6Z7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31522489F;
	Thu, 19 Dec 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611977; cv=none; b=G0vguvAwgZUiz9ykkAoJUzxfin5azRev5qY/hna3NCACRC7mkpOIGUGmlmcpRnIWQie3bOaSBGz/NbUwUhZFllFhd10K37h43Ik2EEWwZaDsuZG6imIoduYSFyDg2vy4S5ZI4CLLmsMpJ00mFtU/7yM133OSR2w+/9p1FI+KhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611977; c=relaxed/simple;
	bh=gHb0LpMwwWWFlugIO+LU2yDk7aKlPpCMfBeLtH2verE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4pm2HjvF5TkdCE+zcYV3oWGIqBZ9QHXDdVfS96Bm8Sjgk9Q4QZgLkLMVa3lIAsMoGrPskgrWbTfoRLbNwC1gSEVpB7+/TzseLaFg8rPwId/vjU/J8e0V/ay0rFXbfrnCbL9AJ2nFNBpjAFAxvrbiXf8cWrplTexjtfHgWhZDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F+DYs6Z7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ3qLBt012946;
	Thu, 19 Dec 2024 12:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BKvoqNZf5eUmp6wCRcMIYsVfeV/7YAkGFsr1+Oa9b
	hA=; b=F+DYs6Z7aAldwn40i0TMnawBc9EAiN1lElrNUvSrQD56P1Dn8XmTliNm1
	yJW3X03SVobhnE3M7/v5fyhOBWQm/gH7xZurbYPOnhTlPm9Lu+7kCPCrPo0bPo8H
	g5XafX1OK7Ug+NBNIc585LsL1N4tShwbESIHZTY2vPmC8gojeqZwz071ZiPAfaDG
	P0kgwkYKAq5tt5g/zWg9k96ZJwDTaG61eXcm8IX3GUbz5x1Gey1QJblT2pfmbXbf
	a+BgwTRW5Rm2vdpgGAlPI7w4PPzSWENZ1UgMlo8dKG2LvqnAjQb52UzndvS7Bg2/
	8bGYTlLpeVRgz6pg0lfNiU0jqqqZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyc242p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJCYtpQ019521;
	Thu, 19 Dec 2024 12:39:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyc242h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBqxG6014323;
	Thu, 19 Dec 2024 12:39:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqyd8mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJCdTlp46137744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 12:39:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C48420043;
	Thu, 19 Dec 2024 12:39:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8509A20040;
	Thu, 19 Dec 2024 12:39:27 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.219.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 12:39:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 0/3] xfs_io: enable extsize and stat -v support for ext4
Date: Thu, 19 Dec 2024 18:09:12 +0530
Message-ID: <cover.1734611784.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ib5ME6NQ_0hWh8F44rSzUCfm5UKlDaAF
X-Proofpoint-ORIG-GUID: SO5Skz8J10qrr-tmzWtMfT1ewXEZ3RFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=575 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190100

Changes since patch v1 [2]

  * Patch 1:
    - Remove extra brackets 
    - RVB from Christoph

Changes since rfc [1]

 * Patch 1: Don't add ext4 specific checks
 * Patch 2: 
   - Rather than adding a check for ext4, allow FS_IOC_GETXATTR to be
     called by any FS that supports it.

** Original Cover **

With ext4 extsize hints support being worked on, enable extsize 
command to be run on FSes other than xfs so ext4 can utilize it.
Also extend stat -v to perform FS_IOC_FSGETXATTR ioctl on ext4.

No funtional changes are intended for XFS.

[1]
https://lore.kernel.org/linux-ext4/cover.1733902742.git.ojaswin@linux.ibm.com/T/#t

Ojaswin Mujoo (3):
  include/linux.h: use linux/magic.h to get XFS_SUPER_MAGIC
  xfs_io: allow foreign FSes to show FS_IOC_FSGETXATTR details
  xfs_io: add extsize command support

 include/linux.h |  3 ++-
 io/open.c       |  2 +-
 io/stat.c       | 63 ++++++++++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.43.5


