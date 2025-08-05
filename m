Return-Path: <linux-fsdevel+bounces-56729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C2B1B037
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB4C189B3E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E72586C2;
	Tue,  5 Aug 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLwkzzos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EABC8CE;
	Tue,  5 Aug 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382657; cv=none; b=qpMaPx3Fl9f33LhztcukrwmS23AKvTafWJ3ziuVcbilBmvOvzkPAf9ITizs/uqcChzekyVepjDWM1eqm8gEor6trXVN+hAm89vrazhFnX4Nd4SLg/+I64V55Nf+m46Vu+NOvWAdCjNO5wxKDc7PZRHKMdb5wwIAwl/fQAOqNSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382657; c=relaxed/simple;
	bh=HJLGhmtZjtxlwctfLmbtm5Bnx7QwQHprGDvVTVu1JoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRFRG34Bz0JTjesBS+9X5yle+IuymsmgiowFJ4gHPyCsEkJFmKVakDCyJ3ExF48S/LCTIpi9ObA7LY2d6Uu9o7WRR1EOr/Yemy0OqaZpkrFpCPJfnx2/0hPkPosZ40/SRUJghhNL/IkcrG+FhCb37Ddp+LHyTBPYJVbvSMvOCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLwkzzos; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575205JS011311;
	Tue, 5 Aug 2025 08:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o7izcwLCVE4tTWcTn
	iDnTcJlhoZRr6ztBYok3Db+JA8=; b=kLwkzzosmDq+c2DLWNMgaiQa92PVWp3Vf
	dKc5evgY+b0vWn8G6QZk0k5MsqJBEPh4r8VWEkwfJLWYuytOgx0Q8c0G6XFrrWwQ
	AfZLUIO+NDVSz5pluY8IBbmKT9R2IUY0seItnNqUY3Wearnl0/8mpM1D7DGtuhT8
	KyQDAulPUhWEMvp25Jcu4iJgAfjZjqE/bqnQwFyKXG3HuuJkC2QqaTaoJgOkJrPv
	v3kjNWuvpLw9IcpLCo9L0Ca4Lcs4riDOdRm/PHK+sm9rpD8ZUsvdnJtB0Qmq1RWV
	Gu7uIaZXY3ScFATm/bZjfQeL1HWHk7QvkNPicSxQ/EaY7+CdSMGtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0wajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5758IpaG005765;
	Tue, 5 Aug 2025 08:30:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0wajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5755CMY7004558;
	Tue, 5 Aug 2025 08:30:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2hbbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5758UaUV53346648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 08:30:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76BC420040;
	Tue,  5 Aug 2025 08:30:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 022C32004F;
	Tue,  5 Aug 2025 08:30:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 08:30:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ext4: Fix reserved gdt blocks handling in fsmap
Date: Tue,  5 Aug 2025 14:00:31 +0530
Message-ID: <08781b796453a5770112aa96ad14c864fbf31935.1754377641.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
References: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NFRd-Gjr_vjarIkfFH4KIKBQLQWtTu-R
X-Proofpoint-ORIG-GUID: 8XyL0S1Qd62oFcULz-cTKEb1QYwmJXrY
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=6891c12f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=GBxxKAqwAsD-tcH_wUcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2MCBTYWx0ZWRfX2c+NSAkHFWjZ
 LQXVkWFjSMXcpp4U6inrCBId3jThU/3LjvGg9D1T4sFKbB/TclBFgguvKSmlQNZ4I6oUNTQwBRc
 ex9psnliGKAL8T6i8yYcMYCvq7oZ1Al/1H4ypumUuGgzExF8IIeOWJZ75+g151KJHhNWmFwoWql
 6ECBz7SDl07h1qmLw6Euc4J7jmFczMwAiCfr0JgPlSv5PpkUnUM4Ejfwwgz1IzstnirFS2ffIRZ
 EFS/2z+K6RxtCbA4w52xqpbq7beECPsg24o1Y+ZKrtH+u+rTOcuag9bqDlbBhNzw1dtyvnTaQSd
 A9F5sKFXfmQ65gyHIBbR97o7nNmC/Gpp/Yg2zzXkHpK+b+9bOQB9BAeU4bm0ftYh7HGt3MFfi+n
 wlLt0SrvqH6KvGioX0t7H59bzPq1xvjpjX6TYHYur7XZAF2AFbCN6p7I3a1UQ5TQJsg6LAV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050060

In some cases like small FSes with no meta_bg and where the resize doesn't
need extra gdt blocks as it can fit in the current one,
s_reserved_gdt_blocks is set as 0, which causes fsmap to emit a 0 length
entry, which is incorrect.

  $ mkfs.ext4 -b 65536 -O bigalloc /dev/sda 5G
  $ mount /dev/sda /mnt/scratch
  $ xfs_io -c "fsmap -d" /mnt/scartch

        0: 253:48 [0..127]: static fs metadata 128
        1: 253:48 [128..255]: special 102:1 128
        2: 253:48 [256..255]: special 102:2 0     <---- 0 len entry
        3: 253:48 [256..383]: special 102:3 128

Fix this by adding a check for this case.

Fixes: 0c9ec4beecac ("ext4: support GETFSMAP ioctls")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/fsmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 9d63c39f6077..91185c40f755 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -393,6 +393,14 @@ static unsigned int ext4_getfsmap_find_sb(struct super_block *sb,
 	/* Reserved GDT blocks */
 	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg) {
 		len = le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks);
+
+		/*
+		 * mkfs.ext4 can set s_reserved_gdt_blocks as 0 in some cases,
+		 * check for that.
+		 */
+		if (!len)
+			return 0;
+
 		error = ext4_getfsmap_fill(meta_list, fsb, len,
 					   EXT4_FMR_OWN_RESV_GDT);
 		if (error)
-- 
2.49.0


