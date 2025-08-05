Return-Path: <linux-fsdevel+bounces-56728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B880B1B034
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB544165D6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9002561D9;
	Tue,  5 Aug 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UZ3esxMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9CC8CE;
	Tue,  5 Aug 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382650; cv=none; b=SP62ntKrVtxW6k1iFkRNtn45APL/1YqLTyF+tTt4agEI07zCDsai0hRX+06ZO81nFs4d3R7ixqh/VAWadgGnt/daE6VI1Xx+2bl5nkVDwRs8jZYPlPssQP63J7OlZO7q4cqBuoDwapr7jIZkeo9mlVhvgiNrliCU5paiN+5ONB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382650; c=relaxed/simple;
	bh=dQFPlLpUZCm3YX4idu8YDib0SOi8lBQovynGkaau74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS8+YpF5q3Z4wJYoDFf3eJ89DNOXrzbhjdBAcGaSkEnoaAQEN518URkFlWyxI8IccO0Tvq+41PBmq8kbnn1hBSo9q3a/3NoIur7995SHxJEPL1083ALz4fqvW1orIMQwBr1Fna6qlof0+E1wComIM7ufTTGhI0CoCnNDxIb81Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UZ3esxMd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754uxj5002664;
	Tue, 5 Aug 2025 08:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FodkDBM716VS3jUFUdYENAuiD8PGpGTqC68YIrqyd
	Go=; b=UZ3esxMd6jApDH7PnxUIKLC1ndiC+0CdJDLbP0wh9Qgs2KLWWeqL0la8g
	FP86n00+/lm1DNfSEa1ZCzVC/5MoDUqmqAifPnDwviaGO23TvORxqxjT3l5FAVDz
	jmM0HxkA6vFuaw7bWpZXiVbQp2oAkZw2ih/XgeUnDV/SmKkb/G1Ivhdy5VUMjy3t
	WgNSStf2p/Nfcqhi4/Tnz9395lXXqNCUABWrgzcHdF27dL5pIDvOcc/R5gZ9zndO
	7B6mT3qg9XGr8kdNc8jl67rPWoELJEe9hlHF6ougxrlXqK4QMdd2Q3adTY5uvmwS
	b79ou3mckJ0yPPV/Yssmu/XQotPIw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq0v3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5758URU9020015;
	Tue, 5 Aug 2025 08:30:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq0v3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5753jVa6001881;
	Tue, 5 Aug 2025 08:30:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wd01qbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:30:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5758UYcY53281248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 08:30:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91B802004B;
	Tue,  5 Aug 2025 08:30:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F4AA20040;
	Tue,  5 Aug 2025 08:30:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 08:30:32 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 1/2] ext4: Fix fsmap end of range reporting with bigalloc
Date: Tue,  5 Aug 2025 14:00:30 +0530
Message-ID: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v9hMc5Onco47m_VQBbFAPPm1qbl29rrO
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891c12e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=3bgJNC2bSexIn_ObHfEA:9
X-Proofpoint-ORIG-GUID: f4Mv6syUl9YV4PQbd_vBZOd9eUFc_EsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2MCBTYWx0ZWRfX36Kp1C7R9wp1
 0G5tNh9SbrkbRs1sn8NfT6WzEOBIddBttEjcZnAbP3VHTVLY7SN2jj0qNLZ8MCOsbwe+vQFkBmZ
 kJ/j5vm6jj5NK6JSSHM4R+qpMSSJERffTNfpWQRszozmiucCa/dMGuGcongD8iGq5D4UtlIjvks
 Zs6XKvvIWbIU7uc/zkajsAOo7898ysqWRd1LBeIO/wHVIh3m8P59+sw/ItlKMgj6/pCrW8Gmlz0
 J+h4Np/GAUwos06q0XI9AwAo4DC1T/a7zVQL3Qm5IkjBihWYKqh5H8MyCOrQEQawnO8EyqpL2cj
 E9DEgZcPjyxMpe3PA7om0OD3FPL9hpNdqxbbwJhUojgFbEXYwm9GxabvEYFsZ1rwBgfJxb/AoZ3
 r4WI5ezrPiP7LMSOep5gzZZsMreWg5O7+CV7OIjTd4flvCXpUP19c9/ShC8BOqO87r1KWp9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050060

With bigalloc enabled, the logic to report last extent has a bug since
we try to use cluster units instead of block units. This can cause an issue
where extra incorrect entries might be returned back to the user. This was
flagged by generic/365 with 64k bs and -O bigalloc.

** Details of issue **

The issue was noticed on 5G 64k blocksize FS with -O bigalloc which has
only 1 bg.

$ xfs_io -c "fsmap -d" /mnt/scratch

  0: 253:48 [0..127]: static fs metadata 128   /* sb */
  1: 253:48 [128..255]: special 102:1 128   /* gdt */
  3: 253:48 [256..383]: special 102:3 128   /* block bitmap */
  4: 253:48 [384..2303]: unknown 1920       /* flex bg empty space */
  5: 253:48 [2304..2431]: special 102:4 128   /* inode bitmap */
  6: 253:48 [2432..4351]: unknown 1920      /* flex bg empty space */
  7: 253:48 [4352..6911]: inodes 2560
  8: 253:48 [6912..538623]: unknown 531712
  9: 253:48 [538624..10485759]: free space 9947136

The issue can be seen with:

$ xfs_io -c "fsmap -d 0 3" /mnt/scratch

  0: 253:48 [0..127]: static fs metadata 128
  1: 253:48 [384..2047]: unknown 1664

Only the first entry was expected to be returned but we get 2. This is
because:

ext4_getfsmap_datadev()
  first_cluster, last_cluster = 0
  ...
  info->gfi_last = true;
  ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1, 0, info);
    fsb = C2B(1) = 16
    fslen = 0
    ...
    /* Merge in any relevant extents from the meta_list */
    list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
      ...
      // since fsb = 16, considers all metadata which starts before 16 blockno
      iter 1: error = ext4_getfsmap_helper(sb, info, p);  // p = sb (0,1), nop
        info->gfi_next_fsblk = 1
      iter 2: error = ext4_getfsmap_helper(sb, info, p);  // p = gdt (1,2), nop
        info->gfi_next_fsblk = 2
      iter 3: error = ext4_getfsmap_helper(sb, info, p);  // p = blk bitmap (2,3), nop
        info->gfi_next_fsblk = 3
      iter 4: error = ext4_getfsmap_helper(sb, info, p);  // p = ino bitmap (18,19)
        if (rec_blk > info->gfi_next_fsblk) { // (18 > 3)
          // emits an extra entry ** BUG **
        }
    }

Fix this by directly calling ext4_getfsmap_datadev() with a dummy record
that has fmr_physical set to (end_fsb + 1) instead of last_cluster + 1. By
using the block instead of cluster we get the correct behavior.

Replacing ext4_getfsmap_datadev_helper() with ext4_getfsmap_helper() is
okay since the gfi_lastfree and metadata checks in
ext4_getfsmap_datadev_helper() are anyways redundant when we only want to
emit the last allocated block of the range, as we have already taken care
of emitting metadata and any last free blocks.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Fixes: 4a622e4d477b ("ext4: fix FS_IOC_GETFSMAP handling")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/fsmap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 383c6edea6dd..9d63c39f6077 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -526,6 +526,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	ext4_group_t end_ag;
 	ext4_grpblk_t first_cluster;
 	ext4_grpblk_t last_cluster;
+	struct ext4_fsmap irec;
 	int error = 0;
 
 	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -609,10 +610,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 			goto err;
 	}
 
-	/* Report any gaps at the end of the bg */
+	/*
+	 * The dummy record below will cause ext4_getfsmap_helper() to report
+	 * any allocated blocks at the end of the range.
+	 */
+	irec.fmr_device = 0;
+	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_length = 0;
+	irec.fmr_owner = EXT4_FMR_OWN_FREE;
+	irec.fmr_flags = 0;
+
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
-					     0, info);
+	error = ext4_getfsmap_helper(sb, info, &irec);
 	if (error)
 		goto err;
 
-- 
2.49.0


