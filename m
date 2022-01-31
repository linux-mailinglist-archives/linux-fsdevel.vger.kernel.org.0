Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27684A4A41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiAaPRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231818AbiAaPRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VE5gYh029246;
        Mon, 31 Jan 2022 15:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yUTvk0+ijXPJW7909ewP2J+BwsxkYnd5g7xfT25Z7yM=;
 b=OnREpmGWBItBazQYmaSEShJbGh5bj45eOd9X1B3PKtr8uwi6kSGEfbFfBsrAhvJGHLla
 lLOoxL+KBcUwf/RPtthAk/1lSZO2VXvJ5g0HvADoDdCJWYLAUhQEpJjFcFX8Jzjskdmx
 6l3Qtpo+d0JPnlBaMv0qHwRYC5Y+A9SeVhO29JzATLhPrarJrTCIW6yYyEKP9TEgsG7g
 olHHETZl7jUT5nGbABpIrD5ZODG7of8ojF2mZuee0c+b0bFxx5EY/C4pfCy5nSeJyocX
 tkk/1qNDP0ribBD8DOhm4SPYzJ+DXe0KJFcl72E/kqLerzUZT7Ahw+GuqFplDUvjp/p9 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxh7rsprt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:13 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VEdnRQ000918;
        Mon, 31 Jan 2022 15:17:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxh7rspqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCOgF007172;
        Mon, 31 Jan 2022 15:17:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3dvw79csm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFH7om42402258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C919FAE053;
        Mon, 31 Jan 2022 15:17:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D5DEAE051;
        Mon, 31 Jan 2022 15:17:07 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:17:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 1/6] ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
Date:   Mon, 31 Jan 2022 20:46:50 +0530
Message-Id: <a9770b46522c03989bdd96f63f7d0bfb2cf499ab.1643642105.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643642105.git.riteshh@linux.ibm.com>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uw2F_MWSY3mCt1g1Jxic3pfuPqDG6m7t
X-Proofpoint-GUID: OuwVm4YdkRMFjaL3780EUdFn14f18uha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of flex_bg feature (which is by default enabled), extents for
any given inode might span across blocks from two different block group.
ext4_mb_mark_bb() only reads the buffer_head of block bitmap once for the
starting block group, but it fails to read it again when the extent length
boundary overflows to another block group. Then in this below loop it
accesses memory beyond the block group bitmap buffer_head and results
into a data abort.

	for (i = 0; i < clen; i++)
		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
			already++;

This patch adds this functionality for checking block group boundary in
ext4_mb_mark_bb() and update the buffer_head(bitmap_bh) for every different
block group.

w/o this patch, I was easily able to hit a data access abort using Power platform.

<...>
[   74.327662] EXT4-fs error (device loop3): ext4_mb_generate_buddy:1141: group 11, block bitmap and bg descriptor inconsistent: 21248 vs 23294 free clusters
[   74.533214] EXT4-fs (loop3): shut down requested (2)
[   74.536705] Aborting journal on device loop3-8.
[   74.702705] BUG: Unable to handle kernel data access on read at 0xc00000005e980000
[   74.703727] Faulting instruction address: 0xc0000000007bffb8
cpu 0xd: Vector: 300 (Data Access) at [c000000015db7060]
    pc: c0000000007bffb8: ext4_mb_mark_bb+0x198/0x5a0
    lr: c0000000007bfeec: ext4_mb_mark_bb+0xcc/0x5a0
    sp: c000000015db7300
   msr: 800000000280b033
   dar: c00000005e980000
 dsisr: 40000000
  current = 0xc000000027af6880
  paca    = 0xc00000003ffd5200   irqmask: 0x03   irq_happened: 0x01
    pid   = 5167, comm = mount
<...>
enter ? for help
[c000000015db7380] c000000000782708 ext4_ext_clear_bb+0x378/0x410
[c000000015db7400] c000000000813f14 ext4_fc_replay+0x1794/0x2000
[c000000015db7580] c000000000833f7c do_one_pass+0xe9c/0x12a0
[c000000015db7710] c000000000834504 jbd2_journal_recover+0x184/0x2d0
[c000000015db77c0] c000000000841398 jbd2_journal_load+0x188/0x4a0
[c000000015db7880] c000000000804de8 ext4_fill_super+0x2638/0x3e10
[c000000015db7a40] c0000000005f8404 get_tree_bdev+0x2b4/0x350
[c000000015db7ae0] c0000000007ef058 ext4_get_tree+0x28/0x40
[c000000015db7b00] c0000000005f6344 vfs_get_tree+0x44/0x100
[c000000015db7b70] c00000000063c408 path_mount+0xdd8/0xe70
[c000000015db7c40] c00000000063c8f0 sys_mount+0x450/0x550
[c000000015db7d50] c000000000035770 system_call_exception+0x4a0/0x4e0
[c000000015db7e10] c00000000000c74c system_call_common+0xec/0x250
--- Exception: c00 (System Call) at 00007ffff7dbfaa4

Fixes: 8016e29f4362e28 ("ext4: fast commit recovery path")
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c781974df9d0..8d23108cf9d7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3899,12 +3899,29 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, clen, err;
+	int i, err;
 	int already;
+	unsigned int clen, overflow;
 
-	clen = EXT4_B2C(sbi, len);
-
+again:
+	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
+
+	/*
+	 * Check to see if we are freeing blocks across a group
+	 * boundary.
+	 * In case of flex_bg, this can happen that (block, len) may span across
+	 * more than one group. In that case we need to get the corresponding
+	 * group metadata to work with. For this we have goto again loop.
+	 */
+	if (EXT4_C2B(sbi, blkoff) + len > EXT4_BLOCKS_PER_GROUP(sb)) {
+		overflow = EXT4_C2B(sbi, blkoff) + len -
+			EXT4_BLOCKS_PER_GROUP(sb);
+		len -= overflow;
+	}
+
+	clen = EXT4_NUM_B2C(sbi, len);
+
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
@@ -3960,6 +3977,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
 	sync_dirty_buffer(gdp_bh);
 
+	if (overflow && !err) {
+		block += len;
+		len = overflow;
+		put_bh(bitmap_bh);
+		goto again;
+	}
+
 out_err:
 	brelse(bitmap_bh);
 }
-- 
2.31.1

