Return-Path: <linux-fsdevel+bounces-37011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6A9EC60D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0511644AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411F1CEAA3;
	Wed, 11 Dec 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TgV72ARl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F902451E2;
	Wed, 11 Dec 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903662; cv=none; b=IcTMFB8LHMbtUFXqCEveYth4bi4v5nCKIy7EVi26EZp2sKEUvExax6h0ldptIPo2yg17T/EPcx8YDr/9TiZkhyOxS0h/TNADHmPhZmMpM3SwUtaCvvCFqrdn+/3L7BAyarPvChzsf0VNEZrUbbJqbq05uB13cHua6c/ixlv4Xso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903662; c=relaxed/simple;
	bh=0eb2ChwuhJO3aXALnXIz6OyBLLpbdmY1b4fnmlWmxa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPZCrKR5TO47gxILGK2F2DrAfKPzEBLSsn6ceh8FemRPPJB4f4U+mdLHbaWra7cPGODeTJ6EvRcLNnQrq/VLi2uNErZq4fhzaz88YDOjGS4cLdZ3x/83NiQ4H+nbI8Qrq9n1EF5W/Wc6r92XDr3hZz7509C4CcEFb510BfyveQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TgV72ARl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANsJgm008997;
	Wed, 11 Dec 2024 07:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZS0AQESLf9JjVRA3zxZdEunf/JmsRRHE1CbcWshP0
	+k=; b=TgV72ARlv+leJOTOxYIR3XuR/NMu/tU38nmVUV6GEA84qUv0RrUw1TTRj
	+VZqTFsOU/QLNPB23G5BzrOmXriJNM56uGqE+WqxaIEPl4G0y9KPUe34MW72ZSAJ
	+Pdyf+/39fwtqIxsB6nohk5LQrwJNO8kRJK3fyuHbtfR6akomfMRVR7WZsGkJNcD
	7DFJV3k25BZWHqRUr9oNZq2tZEU/yXx5y6LbzznYZO1zdi5GTfC/MpktP/a2Wqxx
	8/KkbSJ5rDzIGTGiDo4M6Fen6iLsqq120PgdmM/rNyOuPWx5sK2jTPvy1/dRJTlo
	PHunRO2+St3QuWdNlrctODEtlyfKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjjtxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7jtMr025746;
	Wed, 11 Dec 2024 07:54:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjjtx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5TMI4016926;
	Wed, 11 Dec 2024 07:54:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y8daq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7sCm657606632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:54:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A4D20043;
	Wed, 11 Dec 2024 07:54:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F63320040;
	Wed, 11 Dec 2024 07:54:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:54:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [RFC 0/3] xfs_io: enable extsize and stat -v support for ext4
Date: Wed, 11 Dec 2024 13:24:01 +0530
Message-ID: <cover.1733902742.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: st4vE7iTocGsOOR6ZQ37UAF4Nbb7SZ9t
X-Proofpoint-ORIG-GUID: J0ZhtBwtYfkK84xiW480FSn6iRGtGBVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=731
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110056

With ext4 extsize hints support being worked on, enable extsize 
command to be run on FSes other than xfs so ext4 can utilize it.
Also extend stat -v to perform FS_IOC_FSGETXATTR ioctl on ext4.

No funtional changes are intended for XFS.

Ojaswin Mujoo (3):
  include/linux.h: Factor out generic platform_test_fs_fd() helper
  xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR details
  xfs_io: add extsize command support

 include/linux.h | 25 +++++++++++++++++--------
 io/open.c       |  2 +-
 io/stat.c       | 38 +++++++++++++++++++++-----------------
 3 files changed, 39 insertions(+), 26 deletions(-)

-- 
2.43.5


