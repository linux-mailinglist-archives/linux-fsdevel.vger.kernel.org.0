Return-Path: <linux-fsdevel+bounces-37434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A69F22E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45609165F7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78669149C69;
	Sun, 15 Dec 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fTCF8Pfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6B28FD;
	Sun, 15 Dec 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254260; cv=none; b=KJthDSfPPfnqQ+u/vWJzm/g8dQEMN+4RjCl34gC3aTJQX0z9odykx0WmxV8I9BgqR894Xcq+x8fpeaV2F3qsgYRFYHt4wEAAWMFS4hPBL8mnMbpBFMKNPdbRHefdwQShVpVbCkFAEL6KuT/B1GjwubhPELGFaq5UhePUf8VfkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254260; c=relaxed/simple;
	bh=vwCXCO2YYl3Pt63xOWt0aCMdjbhNLBkp8wKREKWxyQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXdorSAXjS8gmivaox1C8xytZ37zRt995j38XWjOjjWaFU4RBh5t28GtI2N6jD44OyFqxl93wLpehNaJi7vM4OedH0dOSpfO8xfDz66J316vk00pOeVyTUd0pUttFK2K1MFfydoyk+bzy2Ujesswc8z7O5OZBf5wFlzYNxddo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fTCF8Pfw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF6RLKE026544;
	Sun, 15 Dec 2024 09:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ThmvBUaTspOQsZ0KTIGquZqDgRpM9heEsSI9xvVwE
	yQ=; b=fTCF8Pfw59zmdXpG02Vp9OXEUk8YNQYeFP52mK0unp1OtjPfiYVAvILB+
	GHa70z1WrGSV1aXE/KmVqSQTlZfUSPVNk/8u5NwCqdVqGB3WFZdMjkWRYLt2/urS
	mTNULnqAlWvyemmhHI/xHFt0IAMQN724ABYd5AS0k+ByIyWVV/3e3yeetN7G8e5R
	J4I4onWs3bV35n2oQE2qqB5YkLGp8wKi/rBDyH8Qdu7PMK15bhzYZBhf1mjH+K9N
	anKzJNuuswASCZC3W7qg0Cncy1tJWfXiDJxIJWeD4SDtsbhJukVXvQ4KNQpLrpKb
	e7/STXV/fuBnZE/7cI18PQXUzdcvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hm5gsc5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BF9HTiT017632;
	Sun, 15 Dec 2024 09:17:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hm5gsc58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF607iA014323;
	Sun, 15 Dec 2024 09:17:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxsdha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BF9HQJL57344394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 09:17:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2697B20043;
	Sun, 15 Dec 2024 09:17:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D74420040;
	Sun, 15 Dec 2024 09:17:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.213.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Dec 2024 09:17:24 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/3] xfs_io: enable extsize and stat -v support for ext4
Date: Sun, 15 Dec 2024 14:47:14 +0530
Message-ID: <cover.1734253505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xxKxMehP1PyUIHXcIRimfOTQIbs281Yt
X-Proofpoint-GUID: 6cK84czwamzl8yinaMDcEueSjkoQL2Ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=667 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150076

Changes since rfc [1]

 * Patch 1: Don't add ext4 specific checks
 * Patch 2: Rather than adding a check for ext4, allow FS_IOC_GETXATTR
   to be called by any FS that supports it.

[1]
https://lore.kernel.org/linux-ext4/cover.1733902742.git.ojaswin@linux.ibm.com/T/#t

** Original Cover **

With ext4 extsize hints support being worked on, enable extsize 
command to be run on FSes other than xfs so ext4 can utilize it.
Also extend stat -v to perform FS_IOC_FSGETXATTR ioctl on ext4.

No funtional changes are intended for XFS.

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


