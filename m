Return-Path: <linux-fsdevel+bounces-37015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB09EC62B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2758282051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC321CCB40;
	Wed, 11 Dec 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4Q8Urke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686D1C726D;
	Wed, 11 Dec 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903890; cv=none; b=PGvtTlAQLmFRGgvwiTvyRj6gLe25HMPx5Y7t/wrX3qZSegPpSPGwuvT0a1d77gzZ0tQLHrvHUJYYAdvQnX0u+8BhLh39A8p6kAqa0mLdhJ5M0i/JNgPwxGovhLjq9lf9zacHB9gcCkTlN5+qDKzD0k9ArNUUoPpm3jSeON983Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903890; c=relaxed/simple;
	bh=n8zCjiDsfiS//FqtctNEGW1zxuO3fu5pAeaCg5jeZ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJxlqRjBvYorpjD4QamK/HWsnUm+aW/PpGEzOgfIadvzFMHTQopkL1fWaOYkiDn4JqIdzNEdBxAOcRRplYefJD634umad6pjdLnZfiCP1mW3W/ynEjndFIA4K9E8Apnml8Zf42V4ZTb43P0uUaupsZqIzEU1k2AF9V9R4MMulHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4Q8Urke; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANODjQ025855;
	Wed, 11 Dec 2024 07:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OFoUqZ/J95ZNxIxu6/8FRWrZlwXn2VwUvqiep8eIC
	ug=; b=N4Q8UrkeFnruPYf2H4m3YF41A+g+nhkBM8shQ0VNw4mfw1ilo2y4LBftr
	lgKhA6sdLWBEC7hD0CccsnAYR4pPE86bxtr5PL2x+qtlwify2bY2DbOEoh+0a82U
	Dft6NAciSweLGWnbkcgYt/iN8EkVYkgHdh/s/oKNj5ySFUWgk9yZtMkosU0k168F
	OOF3yBUMThBUx8Mm/69Kf9eA8Dur51jY22Ho+jee3Rn1NpLuPxVblYlaK+8pM56l
	YFyEqsLi6p5mVTFl08FXDyLEOxXwHfl0Vhft3q5Eff8YsuGzML6nfdcdzFatDVNc
	cJfs3/1hhoD+tEmLUxKXOBj4GO96A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7sHo4002061;
	Wed, 11 Dec 2024 07:58:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:58:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5CLk3032727;
	Wed, 11 Dec 2024 07:57:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psgf6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:57:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7vwr530736894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:57:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5ADC20043;
	Wed, 11 Dec 2024 07:57:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47C7C2004D;
	Wed, 11 Dec 2024 07:57:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:57:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        Nirjhar Roy <nirjhar@linux.ibm.com>
Subject: [RFC v2 0/6] ext4: Implement support for extsize hints
Date: Wed, 11 Dec 2024 13:27:49 +0530
Message-ID: <cover.1733901374.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ptlQF1DH1KmiKi9soGJ5W4sr5n5A0NZf
X-Proofpoint-GUID: YPfVYoE84Ga92X9MseYjPKbvOcRjj2ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=839 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

** Changes since rfc v1 [1] **

1. Allocations beyond EOF also respect extsize hint however we 
   unlink XFS, we don't trim the blocks allocated beyond EOF due
   to extsize hints. The reasoning behind this is explained in 
   patch 6/6.

2. Minor fixes in extsize ioctl handling logic.

Rest of the design detials can be in individual patches as well as
the original cover leter which can be found here:

[1]
https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Further, xfsprogs changes to enable extsize get/set for ext4 can be
found here:
https://lore.kernel.org/linux-ext4/cover.1733902742.git.ojaswin@linux.ibm.com/T/#t

Comments and suggestions are welcome!

Regards,
ojaswin

Ojaswin Mujoo (6):
  ext4: add aligned allocation hint in mballoc
  ext4: allow inode preallocation for aligned alloc
  ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
  ext4: pass lblk and len explicitly to ext4_split_extent*()
  ext4: add extsize hint support
  ext4: make extsize work with EOF allocations

 fs/ext4/ext4.h              |  12 +-
 fs/ext4/ext4_jbd2.h         |  15 ++
 fs/ext4/extents.c           | 224 +++++++++++++++----
 fs/ext4/inode.c             | 435 ++++++++++++++++++++++++++++++++----
 fs/ext4/ioctl.c             | 122 ++++++++++
 fs/ext4/mballoc.c           | 126 +++++++++--
 fs/ext4/super.c             |   1 +
 include/trace/events/ext4.h |   2 +
 8 files changed, 836 insertions(+), 101 deletions(-)

-- 
2.43.5


