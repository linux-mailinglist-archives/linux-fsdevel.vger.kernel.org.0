Return-Path: <linux-fsdevel+bounces-55543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFACB0B841
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 23:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CC3165820
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB02239E84;
	Sun, 20 Jul 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fIUMteZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4B224B14;
	Sun, 20 Jul 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045098; cv=none; b=YhELWm2h6JY+4SNYqU6cnlAo648OVSUBTbfUg8CSbqkqWIuSjspBogub6VKci82TgyNbw026xExk4Q9eCTGkSIFzr7RlaSqxOnpvwHWdVWtPP3+BrMsmj9jPx7AnJvMz3eqxmfLUcHh9fixbnvR2mGdbHokvlkNAm9ySxj6Eguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045098; c=relaxed/simple;
	bh=3VpNrGSLDTgpaTVBXL34gCyZusAFCU/AunfM3eAf/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erYfAr+JyzOpV+MMfV6BYQyjYndiA2661S11jyllPZ6TUEZEt+VfJn5C5V07ALjK6lf09Ng2Xiywbv4Sg9e/ktDtTxiW7cuvV1xRr4FluoOIZMWH4C2ROhX43/S3Gt3NtzXRG62bEeFTLV1AA5kuLL9uWB8LebltWweB7f1fSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fIUMteZ/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJs8Ri005549;
	Sun, 20 Jul 2025 20:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8pcU36a3QVQA9/SFF
	vKQWwkrB68bBongYrNmMfiIH5k=; b=fIUMteZ/03+wHObeB2BxJ8UZRsrO3SyiB
	d7c9OwQKzlgFveN93k109oKqoB9kyROYBs2GfL9m1B+7po7oQB4gGZNiHnrZ6deA
	w4J+KFpaCNa+Vi2srnBd3Y53th/S6wR7g8DujAo8aztVeVXl8W1u7snAuIE3W2eK
	+nwzm2BqIueD9nAS8uWOATM0gDJYui76Qix7PP3JDhaEAc90n8DEllSdwJm+XEZb
	Q7y25rIatypkTcYVTdGerVmzIyJ2dJdUGT5PFOg2mhnD2CrQP7mcykD+wNJy1Pk1
	mQ0dmpgkq9f6t+P8tzCnJHuKeJ4WmLGlj2s2/dPl+ok1/0gm8ODPw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:58:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKvx6U021062;
	Sun, 20 Jul 2025 20:58:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v5jxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KH84TG014391;
	Sun, 20 Jul 2025 20:57:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppnu8mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvusH47710508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97BAB20043;
	Sun, 20 Jul 2025 20:57:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595A220040;
	Sun, 20 Jul 2025 20:57:54 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:54 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 7/7] ext4: add ext4_map_blocks_extsize() wrapper to handle overwrites
Date: Mon, 21 Jul 2025 02:27:33 +0530
Message-ID: <4531e266d4b26b1c3d51da732ff305869e56dcf3.1753044253.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753044253.git.ojaswin@linux.ibm.com>
References: <cover.1753044253.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687d5858 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=XbQIVu7OBCAAiYVp_M0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfXykg1hwk4nAgb
 xROE1waIrLTo/2VPt7oXhC1aLbWJ7xHHgc23el/aJOjGxUkh8rSRR3MhNj57I6X01jmcdHpsgYd
 vYIv8IAZoYUK8UxYg3pIdGSGx/x/IHtDZho12S0f1+RSoBd23vASha+ZQNhpY64QM1caSRpWQs8
 EeEK9XBEMaWb66+Sb5Kn8LPDajYMYzhgJd5XoNzZYX6zetfq5s40iLM+odGXn/3Qv8Nhd6hC4r0
 6v4jiaG3jIeFhCUsKfZwdHjzydTzAAAzfEZudaNNmmA8gr7599f2neTzwgfSMhGymKPzdb48Iag
 MXvofVTuRH1/7ni4R2qc3yi/Go3tEEEdLowQ0s/iCKy8GvuItmksMo26YgXUuDaIQCobP3ViDNE
 8Hk9z9i3TmL//Rdx47uSS7pC7MDoUeYUp78vOmiMhEfBst3YXfIlNZhDR93NvYeoe7Wk7lDr
X-Proofpoint-ORIG-GUID: KLoetVI8SyMxBp_7bMGJaqXj6PEX-jwy
X-Proofpoint-GUID: 7NDJ-ZzSSvuTUBxfCTHBipT0Ep8YrumW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

Currently, with the extsize hints, if we consider a scenario where
the hint is set to 16k and we do a write of (0,4k) we get the below
mapping:

[  4k written ] [       12k unwritten      ]

Now, if we do a (4k,4k) write, ext4_map_blocks will again try for a
extsize aligned write, adjust the range to (0, 16k) and then run into
issues since the new range is already has a mapping in it. Although this
does not lead to a failure since we eventually fallback to a non extsize
allocation, this is not a good approach.

Hence, implement a wrapper over ext4_map_blocks() which detects if a
mapping already exists for an extsize based allocation and then reuses
the same mapping.

In case the mapping completely covers the original request we simply
disable extsize allocation and call map_blocks to correctly process the
mapping and set the map flags. Otherwise, if there is a hole or partial
mapping, then we just let ext4_map_blocks() handle the allocation.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1b60e45a593e..010ca890b29c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -772,6 +772,41 @@ static inline void ext4_extsize_reset_map(struct ext4_map_blocks *map,
 	map->m_flags = 0;
 }
 
+static int ext4_map_blocks_extsize(handle_t *handle, struct inode *inode,
+		    struct ext4_map_blocks *map, int flags)
+{
+	int orig_mlen = map->m_len;
+	int ret = 0;
+	int tmp_flags;
+
+	WARN_ON(!ext4_inode_get_extsize(EXT4_I(inode)));
+	WARN_ON(!(flags & EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT));
+
+	/*
+	 * First check if there are any existing allocations
+	 */
+	ret = ext4_map_blocks(handle, inode, map, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * the present mapping fully covers the requested range. In this
+	 * case just go for a non extsize based allocation. Note that we won't
+	 * really be allocating new blocks but the call to ext4_map_blocks is
+	 * important to ensure things like extent splitting and proper map flags
+	 * are taken care of. For all other cases, just let ext4_map_blocks handle
+	 * the allocations
+	 */
+	if (ret > 0 && map->m_len == orig_mlen)
+		tmp_flags = flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+	else
+		tmp_flags = flags;
+
+	ret = ext4_map_blocks(handle, inode, map, tmp_flags);
+
+	return ret;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -1153,8 +1188,12 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 	map.m_lblk = iblock;
 	map.m_len = orig_mlen;
 
-	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
-			      flags);
+	if ((flags & EXT4_GET_BLOCKS_CREATE) && ext4_should_use_extsize(inode))
+		ret = ext4_map_blocks_extsize(ext4_journal_current_handle(), inode,
+				      &map, flags);
+	else
+		ret = ext4_map_blocks(ext4_journal_current_handle(), inode,
+				      &map, flags);
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
@@ -4016,6 +4055,8 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	if (flags & IOMAP_ATOMIC)
 		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
 						   &force_commit);
+	else if (ext4_should_use_extsize(inode))
+		ret = ext4_map_blocks_extsize(handle, inode, map, m_flags);
 	else
 		ret = ext4_map_blocks(handle, inode, map, m_flags);
 
-- 
2.49.0


