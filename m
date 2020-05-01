Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C11C0E25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEAGau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbgEAGau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162Qak018939;
        Fri, 1 May 2020 02:30:34 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r82sgx3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:34 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AtJx015132;
        Fri, 1 May 2020 06:30:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu5bae0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UT4P58523742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17727A4060;
        Fri,  1 May 2020 06:30:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71144A405B;
        Fri,  1 May 2020 06:30:27 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 10/20] ext4: mballoc: Remove EXT4_MB_HINT_GOAL_ONLY and it's related code
Date:   Fri,  1 May 2020 11:59:52 +0530
Message-Id: <3bcf0e3c4a3f7326af909f091767fbf348a3497a.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't set EXT4_MB_HINT_GOAL_ONLY flag at any place and from our last
during discussion, we don't see a need/use case of it anytime in near
future too.
So just kill the flag and all of it's references.
This also adjusts the remaining ac_flags macro values accordingly.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h              | 12 +++++-------
 fs/ext4/mballoc.c           | 10 ----------
 include/trace/events/ext4.h |  1 -
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..db4fb62c1169 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -130,18 +130,16 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_HINT_NOPREALLOC		0x0040
 /* allocate for locality group */
 #define EXT4_MB_HINT_GROUP_ALLOC	0x0080
-/* allocate goal blocks or none */
-#define EXT4_MB_HINT_GOAL_ONLY		0x0100
 /* goal is meaningful */
-#define EXT4_MB_HINT_TRY_GOAL		0x0200
+#define EXT4_MB_HINT_TRY_GOAL		0x0100
 /* blocks already pre-reserved by delayed allocation */
-#define EXT4_MB_DELALLOC_RESERVED	0x0400
+#define EXT4_MB_DELALLOC_RESERVED	0x0200
 /* We are doing stream allocation */
-#define EXT4_MB_STREAM_ALLOC		0x0800
+#define EXT4_MB_STREAM_ALLOC		0x0400
 /* Use reserved root blocks if needed */
-#define EXT4_MB_USE_ROOT_BLOCKS		0x1000
+#define EXT4_MB_USE_ROOT_BLOCKS		0x0800
 /* Use blocks from reserved pool */
-#define EXT4_MB_USE_RESERVED		0x2000
+#define EXT4_MB_USE_RESERVED		0x1000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6e7232fd109e..4d6effe22652 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2157,9 +2157,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (err || ac->ac_status == AC_STATUS_FOUND)
 		goto out;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
-		goto out;
-
 	/*
 	 * ac->ac2_order is set only if the fe_len is a power of 2
 	 * if ac2_order is set we also set criteria to 0 so that we
@@ -3139,10 +3136,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
 
-	/* sometime caller may want exact blocks */
-	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
-		return;
-
 	/* caller may indicate that preallocation isn't
 	 * required (it's a tail, for example) */
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
@@ -4257,9 +4250,6 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return;
 
-	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
-		return;
-
 	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19c87661eeec..a2a603172f57 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -30,7 +30,6 @@ struct partial_cluster;
 	{ EXT4_MB_HINT_DATA,		"HINT_DATA" },		\
 	{ EXT4_MB_HINT_NOPREALLOC,	"HINT_NOPREALLOC" },	\
 	{ EXT4_MB_HINT_GROUP_ALLOC,	"HINT_GRP_ALLOC" },	\
-	{ EXT4_MB_HINT_GOAL_ONLY,	"HINT_GOAL_ONLY" },	\
 	{ EXT4_MB_HINT_TRY_GOAL,	"HINT_TRY_GOAL" },	\
 	{ EXT4_MB_DELALLOC_RESERVED,	"DELALLOC_RESV" },	\
 	{ EXT4_MB_STREAM_ALLOC,		"STREAM_ALLOC" },	\
-- 
2.21.0

