Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4611DAAD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETGlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 02:41:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726658AbgETGlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 02:41:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K6VScC040115;
        Wed, 20 May 2020 02:41:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312c659wbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 02:41:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04K6ejhu003252;
        Wed, 20 May 2020 06:41:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehk2r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 06:41:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04K6dr6H13959648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 06:39:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F13BA4064;
        Wed, 20 May 2020 06:41:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81AF3A4054;
        Wed, 20 May 2020 06:41:04 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.188.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 06:41:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 5/5] ext4: mballoc: Use lock for checking free blocks while retrying
Date:   Wed, 20 May 2020 12:10:36 +0530
Message-Id: <9cb740a117c958c36596f167b12af1beae9a68b7.1589955723.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589955723.git.riteshh@linux.ibm.com>
References: <cover.1589955723.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_02:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=3 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200051
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently while doing block allocation grp->bb_free may be getting
modified if discard is happening in parallel.
For e.g. consider a case where there are lot of threads who have
preallocated lot of blocks and there is a thread which is trying
to discard all of this group's PA. Now it could happen that
we see all of those group's bb_free is zero and fail the allocation
while there is sufficient space if we free up all the PA.

So this patch adds another flag "EXT4_MB_STRICT_CHECK" which will be set
if we are unable to allocate any blocks in the first try (since we may
not have considered blocks about to be discarded from PA lists).
So during retry attempt to allocate blocks we will use ext4_lock_group()
for checking if the group is good or not.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/mballoc.c           | 13 ++++++++++++-
 include/trace/events/ext4.h |  3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb37fb3fe689..d185f3bcb9eb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -150,6 +150,8 @@ enum SHIFT_DIRECTION {
 #define EXT4_MB_USE_ROOT_BLOCKS		0x1000
 /* Use blocks from reserved pool */
 #define EXT4_MB_USE_RESERVED		0x2000
+/* Do strict check for free blocks while retrying block allocation */
+#define EXT4_MB_STRICT_CHECK		0x4000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c9297c878a90..a9083113a8c0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2176,9 +2176,13 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 				     ext4_group_t group, int cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
+	struct super_block *sb = ac->ac_sb;
+	bool should_lock = ac->ac_flags & EXT4_MB_STRICT_CHECK;
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (should_lock)
+		ext4_lock_group(sb, group);
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
@@ -2186,6 +2190,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
+	if (should_lock)
+		ext4_unlock_group(sb, group);
 
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -2194,8 +2200,12 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			return ret;
 	}
 
+	if (should_lock)
+		ext4_lock_group(sb, group);
 	ret = ext4_mb_good_group(ac, group, cr);
 out:
+	if (should_lock)
+		ext4_unlock_group(sb, group);
 	return ret;
 }
 
@@ -4610,7 +4620,8 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 		goto out_dbg;
 	}
 	seq_retry = ext4_get_discard_pa_seq_sum();
-	if (seq_retry != *seq) {
+	if (!(ac->ac_flags & EXT4_MB_STRICT_CHECK) || seq_retry != *seq) {
+		ac->ac_flags |= EXT4_MB_STRICT_CHECK;
 		*seq = seq_retry;
 		ret = true;
 	}
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19c87661eeec..0df9efa80b16 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -35,7 +35,8 @@ struct partial_cluster;
 	{ EXT4_MB_DELALLOC_RESERVED,	"DELALLOC_RESV" },	\
 	{ EXT4_MB_STREAM_ALLOC,		"STREAM_ALLOC" },	\
 	{ EXT4_MB_USE_ROOT_BLOCKS,	"USE_ROOT_BLKS" },	\
-	{ EXT4_MB_USE_RESERVED,		"USE_RESV" })
+	{ EXT4_MB_USE_RESERVED,		"USE_RESV" },		\
+	{ EXT4_MB_STRICT_CHECK,		"STRICT_CHECK" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",			\
 	{ EXT4_GET_BLOCKS_CREATE,		"CREATE" },		\
-- 
2.21.0

