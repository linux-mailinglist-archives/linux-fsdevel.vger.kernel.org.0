Return-Path: <linux-fsdevel+bounces-68051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142CC51E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8687B425E2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BD30F92E;
	Wed, 12 Nov 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOB7QhmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72072FDC3C;
	Wed, 12 Nov 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945732; cv=none; b=c+wGcg0pFbZ5z1j5pqbfLjk4eq7e7BqYh+hoHg0FEUUsBkYtmSVZ1RKXBuQs021WE/OPypdca5Ka4xGE2WrC/Uw5fc916Two1nGbb313XcsCooj+Bb4HPlTMogvQCgb2XaPDXxEL5lJLmr7Hejjfl0qmfDdjYDtnufGrtnOcm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945732; c=relaxed/simple;
	bh=7HYb7P746kTlQ448/enNTGByoCQvc5vWYJnuJdoRvhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=relhJAN++1YU4mwqYfwvcON0EuEZuFmrxMR4MN1Z8I004J0JO5olA+x8SGhLulRUgXjC5E7Ubs7asNOi1RK7OHJ7q3l3F7Tzud+jWsSfaUvwtZC6QJmWMdbamwvkOmOi5oMgqXJrSedzvkR+DLWXgNwdBwAdlmqQqPgMnUpco6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pOB7QhmM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC6nTkG028520;
	Wed, 12 Nov 2025 11:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lS0PV8URMxmmce+9y
	YxA6ZwV8ssL8Pfv2N3KgoOn0Oc=; b=pOB7QhmMKumE+2Ewk0J81JPbGPU/jfzXZ
	lQgYDaIKG+gR9FpX3LyQ1Df17NPun1GTooeAH52oDLyC3C+QHRc9BFPG+AdHTtRK
	wd3snm2oNdwwbMjZWANEa8pjXp4UVeYb3I35p1dPa9FkbsNLzBVusbf8HneBkgCu
	WWdXYPdOb0shtMsvVEPkhTRbJLESYAZuFF9BVGl2dVaYR7atgSYipSdQ0/6K5ITD
	8jjuzmu7DRI6F2rDTpTwvxzmkJ38HY6rb5/MRfSy6cIMNMotYCAvL+u/xFVOKmiv
	7lCR91WMcv+TU7Cf9jENRnTa+9o3RoEiquKFyM7RakWr9H/okbCow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjymnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB4SYB022695;
	Wed, 12 Nov 2025 11:07:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjymnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9QpsE014859;
	Wed, 12 Nov 2025 11:07:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk7qe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB7Pg551118504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:07:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83932004F;
	Wed, 12 Nov 2025 11:07:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F267120043;
	Wed, 12 Nov 2025 11:07:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:07:20 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] xfs: Lift the bs == ps restriction for HW buffered atomic writes
Date: Wed, 12 Nov 2025 16:36:11 +0530
Message-ID: <0f1f53d6fad8c25118b0348b0cb91dc2e4ecf456.1762945505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ADQK4HD0lQecC7xUBvMAVAknMXJGVpEF
X-Proofpoint-ORIG-GUID: iQAnc7Mvlf5AFos0tKRg3f3C_4ix3pmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX52SSPqtKtk4i
 cOa+6iOjuAAo2h3dK97pN8YCSCEGsYjvxno1zsFcUvQEs8u8QFoS8EVe4pT0zpMsHpPdVwbWA1T
 0zo5RABNZRExM0hTMZPRyOam0cl9R1euNDPgYUagq4a1jUJQXcD4MdbGR+DPYm19JsbetcQDbLp
 IQpdcmM02Hdswz10zt3coYGH2sQxqol1aaRs3Nno9T2vFNe2dBPp59Ks7j3Pe37MrPuoZmS3vVq
 +ks1ZnAEyrV5uifEEGDaPOsLzfMeDcTgtT/VBdftWRhkKkfyZsXRrAFwJW7wHSXcMsDjNIQg+am
 ejhzNtQRfiKZ7AuNzA5NnblMkDmXntu5WTp1V7TrOlqMmUnX3jgGAQAU45KJ5jLteLGR1AUaDQy
 OsFaBLrhNGF97igEbAhLryJJS6zuFA==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69146a71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=PLfzAVb2A4JWLM4niBMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

Now that we support bs < ps for HW atomic writes, lift this restirction from XFS
statx reporting

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/xfs/xfs_iops.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 67d370947d95..5bd31aacf514 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -622,10 +622,9 @@ xfs_get_atomic_write_min(
 			return bs;
 	}
 	/*
-	 * Buffered IO only supports hw single block atomic writes and bs == ps
-	 * configurations.
+	 * Buffered IO only supports hw single block atomic writes
 	 */
-	if (xfs_inode_can_hw_atomic_write(ip) && bs == PAGE_SIZE)
+	if (xfs_inode_can_hw_atomic_write(ip))
 		return bs;
 
 	return 0;
@@ -661,10 +660,9 @@ xfs_get_atomic_write_max(
 		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 	}
 	/*
-	 * Buffered IO only supports hw single block atomic writes and bs == ps
-	 * configurations.
+	 * Buffered IO only supports hw single block atomic writes
 	 */
-	if (xfs_inode_can_hw_atomic_write(ip) && bs == PAGE_SIZE)
+	if (xfs_inode_can_hw_atomic_write(ip))
 		return bs;
 
 	return 0;
-- 
2.51.0


