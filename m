Return-Path: <linux-fsdevel+bounces-37437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D49F22EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CF17A0566
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE3187346;
	Sun, 15 Dec 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IYwZJxk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574D155312;
	Sun, 15 Dec 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254265; cv=none; b=oQHcXXvGja34Isy8DSN8+RaDS+QffJt8mzSNAnO4ihA/w9qGzF0JEUb4Nmnq0BZ7I1Yg8TFjeeLZy35Wxg4T985lMXC75AyYulRu1GtlyP6JPv6qC5uPEJk7dzqPEcr7yi0cUhkW9Ety+vZcXjvlpmGJIvvPyhV/Le2FY4ADbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254265; c=relaxed/simple;
	bh=pfGkfSRbBeBZe2pfv8FMlZ/K7pb4YLUhiD7uHI13nsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6AgxMJpea7RPcMbMfgzzAKcHD8+3buISr3eme1/JlXu525aYXHOWpSttD46AEks9ypRFVYJAdv2y3qvLxai9eOXM2I85W45IIIQAKIbUUhy/f3lOzhIs71QWxNkiS5Vxso9KQvDqsksRt0EVGboYezW/d1WzNOSnhODUgy41rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IYwZJxk8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BENaW5H013424;
	Sun, 15 Dec 2024 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=56iEWu45x5ZogUIJ3
	B7E3Njw8FYRxDwCN46dpTp1gNM=; b=IYwZJxk8/JZ0z/08M/N6Lf26RLoQ0ENr2
	oEZAqLDHLRQ+HAqvRviMwkSymIEITtXuHZ3X6cUs8mTk7vnLhJPYUrc3hyooYy+q
	cj6LK0Pe93XrTK+3PLwuJe+AYoT9wSkvVDIOW+jefqg/tQkNgxYinD8Cp3Eis0Ux
	/igAi+dPcDP0ERQw+wSANPMtqnMY0oKTLIZWz8cOchWYHNtDgeSO5ppMGi6Ngsd0
	IIV6s9mt/Xq0d01oBx/IhD0Coqj3NEiGRx9S7qLoRrLxCr9G4zeY243OQOUswjD5
	4aI+pZBORa/qRKicUYbu7IwsFIk8VbIysrlLoYeJHE/Ac9uaIqY5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hkua17mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BF9HaXs011753;
	Sun, 15 Dec 2024 09:17:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hkua17mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF7C5Tp024026;
	Sun, 15 Dec 2024 09:17:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnuk1731-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BF9HX0T64815366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 09:17:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B88A620043;
	Sun, 15 Dec 2024 09:17:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD70920040;
	Sun, 15 Dec 2024 09:17:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.213.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Dec 2024 09:17:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/3] xfs_io: add extsize command support
Date: Sun, 15 Dec 2024 14:47:17 +0530
Message-ID: <505e0447396daec6f3b574d5d0fa7d8f915dc090.1734253505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734253505.git.ojaswin@linux.ibm.com>
References: <cover.1734253505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cdVfGJaQdjyE28ipvQIpMmqOmbzot33I
X-Proofpoint-ORIG-GUID: FW2fEMr9DnHC1kU6rHdqX7Du6uBM2Vut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150072

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


