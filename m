Return-Path: <linux-fsdevel+bounces-37014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63B9EC618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FD71646A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994161DBB38;
	Wed, 11 Dec 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TYy2zpvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785511D7E57;
	Wed, 11 Dec 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903668; cv=none; b=rmQ9Bg8SewLCpuThz4KBf2Co4XqK82zp5/v6BkdeMCEOufHKiNbYfUtscBKKUaATeYMM3AJ9K3tROJtxTBVlFgFlOaKBkQrkhXmRbOx42uaw7fQpWFVXIvRT79DlShgoCdTgG6+CIA9q1XJhHeHbvhPiidAac6bp/VcDivDLhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903668; c=relaxed/simple;
	bh=pfGkfSRbBeBZe2pfv8FMlZ/K7pb4YLUhiD7uHI13nsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ7eqraqpz3tLxCplFx3r7+CMNbRx/oCFqtG8umN7Uwz+ND00mNBg2JRWPjZxgGBS2e7ki9cTtIQYiVTroDPCW2QZsijqfdPejYke4Pv27vWFS6hx+G0ofDcsg4F/05APo10DKWERuk+mt2HuLrYO7K9pXVz8ofXW5rt1tUCuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TYy2zpvA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB0QRQH003998;
	Wed, 11 Dec 2024 07:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=56iEWu45x5ZogUIJ3
	B7E3Njw8FYRxDwCN46dpTp1gNM=; b=TYy2zpvAaLe+j65ZSKM9ilCNfobngMCBQ
	6cnqrWBKxKxPE95N3thMlapaZEahiTXvefvH5gzG7yxzTEAUekEnEfTLklA0xRds
	uGgc4Jlu78XErlpt0/h1sto1rIwZl15OEW52cEHZpsjDbpemP1UfJ/py6PohHv0L
	paaz3MQwstbQrwn8e4ds3SAXCg5KOy018Ffd5sPNqsakqRZ0Nly57ahDKIEdjybQ
	M4wOf0adGABOizcqCvOMx1sqSNtUUPLdJHnv8YuI/uzGXFkRU5vPWqD2q1irmHNL
	NPwstQcIP4+/h8a35SBi1ALlcZxh0jxdzvdTFnHW8Dvr481ji2l2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xjpw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7sL4T027263;
	Wed, 11 Dec 2024 07:54:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xjpw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5RaBS032724;
	Wed, 11 Dec 2024 07:54:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psges1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7sJXc56754476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:54:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E37020043;
	Wed, 11 Dec 2024 07:54:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE4BF2004B;
	Wed, 11 Dec 2024 07:54:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:54:16 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [RFC 3/3] xfs_io: add extsize command support
Date: Wed, 11 Dec 2024 13:24:04 +0530
Message-ID: <6448e3adc13eff8b152f7954c838eb9315c91574.1733902742.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1733902742.git.ojaswin@linux.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zPgKlWGDTEiC5BBEweJUQkS2-JFkl0GQ
X-Proofpoint-ORIG-GUID: gGOaBbh5aCzP7gqrkh6LrX6uO8hz8naR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

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


