Return-Path: <linux-fsdevel+bounces-4397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6397FF2B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1902B20AFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B551019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNsP7bGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C273173E;
	Thu, 30 Nov 2023 05:53:40 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnWpb001333;
	Thu, 30 Nov 2023 13:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GEbojckG87Zkl5i2XvaH4H480xxiwFF4r2OKYlabK54=;
 b=bNsP7bGwRrqT00WlGk/iKOOA7N4n/iq5dA7a85ARavnDOx+4XDUHbnxWyWJLW6k99Z3r
 CGgG4d5lpUY0H2eQj8oulrRYCCawLy7oc6FdnMvvt7SuAqoFlO9ZE+ZckdC2Pu9APDA+
 fZIyJqW3wXuZvt1lHmpctR1PX/eTluy9SYOsVDAJZQBi5cr8dsV1D0S3qptmq14rIGo2
 PLjbhX4nLoxLctKffsZGhRwlhs4rlpY2H8+sY/C3Ch/a/AUfWhU5iyZxhvbZ+sHkBiLR
 JBRmqy1HIGtnCXeKEkJ2zOY74PoNnNcr4J0QErquGSI/iMu47Iu3r/VZ6B7lnJik2e0s yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:34 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDowTQ006599;
	Thu, 30 Nov 2023 13:53:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnBJU008115;
	Thu, 30 Nov 2023 13:53:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkx98c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrVvQ18416372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89C22004B;
	Thu, 30 Nov 2023 13:53:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E8CD20043;
	Thu, 30 Nov 2023 13:53:28 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 2/7] ext4: Factor out size and start prediction from ext4_mb_normalize_request()
Date: Thu, 30 Nov 2023 19:23:11 +0530
Message-Id: <a6fc4fc33c61be908d4977bcf35e6fb267baca08.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qy_SkSW57mW-hjhbyF5qADthnI7ePZDv
X-Proofpoint-ORIG-GUID: p6EWJrk5DgzIlF1RQ43yQLDbmbht6XtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=984 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

As a part of trimming down the size of ext4_mb_normalize_request(), factor
out the logic to predict normalized start and size to a separate function
ext4_mb_pa_predict_size().

This is no functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 95 ++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0b0aff458efd..3eb7b639d36e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4394,6 +4394,58 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	*end = new_end;
 }
 
+static void ext4_mb_pa_predict_size(struct ext4_allocation_context *ac,
+				    loff_t *start, loff_t *size)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	loff_t new_size = *size;
+	loff_t new_start = *start;
+	int bsbits, max;
+
+	bsbits = ac->ac_sb->s_blocksize_bits;
+	/* max size of free chunks */
+	max = 2 << bsbits;
+
+#define NRL_CHECK_SIZE(req, size, max, chunk_size) \
+	(req <= (size) || max <= (chunk_size))
+
+	if (new_size <= 16 * 1024) {
+		new_size = 16 * 1024;
+	} else if (new_size <= 32 * 1024) {
+		new_size = 32 * 1024;
+	} else if (new_size <= 64 * 1024) {
+		new_size = 64 * 1024;
+	} else if (new_size <= 128 * 1024) {
+		new_size = 128 * 1024;
+	} else if (new_size <= 256 * 1024) {
+		new_size = 256 * 1024;
+	} else if (new_size <= 512 * 1024) {
+		new_size = 512 * 1024;
+	} else if (new_size <= 1024 * 1024) {
+		new_size = 1024 * 1024;
+	} else if (NRL_CHECK_SIZE(new_size, 4 * 1024 * 1024, max, 2 * 1024)) {
+		new_start = ((loff_t)ac->ac_o_ex.fe_logical >>
+						(21 - bsbits)) << 21;
+		new_size = 2 * 1024 * 1024;
+	} else if (NRL_CHECK_SIZE(new_size, 8 * 1024 * 1024, max, 4 * 1024)) {
+		new_start = ((loff_t)ac->ac_o_ex.fe_logical >>
+							(22 - bsbits)) << 22;
+		new_size = 4 * 1024 * 1024;
+	} else if (NRL_CHECK_SIZE(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
+					(8<<20)>>bsbits, max, 8 * 1024)) {
+		new_start = ((loff_t)ac->ac_o_ex.fe_logical >>
+							(23 - bsbits)) << 23;
+		new_size = 8 * 1024 * 1024;
+	} else {
+		new_start = (loff_t) ac->ac_o_ex.fe_logical << bsbits;
+		new_size = (loff_t) EXT4_C2B(sbi,
+					      ac->ac_o_ex.fe_len) << bsbits;
+	}
+
+	*size = new_size;
+	*start = new_start;
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4404,7 +4456,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
-	int bsbits, max;
+	int bsbits;
 	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
@@ -4438,47 +4490,12 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		size = i_size_read(ac->ac_inode);
 	orig_size = size;
 
-	/* max size of free chunks */
-	max = 2 << bsbits;
-
-#define NRL_CHECK_SIZE(req, size, max, chunk_size)	\
-		(req <= (size) || max <= (chunk_size))
-
 	/* first, try to predict filesize */
 	/* XXX: should this table be tunable? */
 	start_off = 0;
-	if (size <= 16 * 1024) {
-		size = 16 * 1024;
-	} else if (size <= 32 * 1024) {
-		size = 32 * 1024;
-	} else if (size <= 64 * 1024) {
-		size = 64 * 1024;
-	} else if (size <= 128 * 1024) {
-		size = 128 * 1024;
-	} else if (size <= 256 * 1024) {
-		size = 256 * 1024;
-	} else if (size <= 512 * 1024) {
-		size = 512 * 1024;
-	} else if (size <= 1024 * 1024) {
-		size = 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-						(21 - bsbits)) << 21;
-		size = 2 * 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(size, 8 * 1024 * 1024, max, 4 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-							(22 - bsbits)) << 22;
-		size = 4 * 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
-					(8<<20)>>bsbits, max, 8 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-							(23 - bsbits)) << 23;
-		size = 8 * 1024 * 1024;
-	} else {
-		start_off = (loff_t) ac->ac_o_ex.fe_logical << bsbits;
-		size	  = (loff_t) EXT4_C2B(sbi,
-					      ac->ac_o_ex.fe_len) << bsbits;
-	}
+
+	ext4_mb_pa_predict_size(ac, &start_off, &size);
+
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
-- 
2.39.3


