Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440B11867EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgCPJax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:30:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730356AbgCPJaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:30:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02G9LsjH126212
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 05:30:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yrr6sp6rd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 05:30:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 16 Mar 2020 09:30:49 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Mar 2020 09:30:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02G9Uigm39518486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 09:30:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528924C040;
        Mon, 16 Mar 2020 09:30:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B858A4C046;
        Mon, 16 Mar 2020 09:30:42 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.91.58])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Mar 2020 09:30:42 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>
Subject: [PATCH] ext4: Check for non-zero journal inum in ext4_calculate_overhead
Date:   Mon, 16 Mar 2020 15:00:38 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031609-0020-0000-0000-000003B52E0E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031609-0021-0000-0000-0000220D8C93
Message-Id: <20200316093038.25485-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_02:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=483 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003160044
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While calculating overhead for internal journal, also check
that j_inum shouldn't be 0. Otherwise we get below error with
xfstests generic/050 with external journal (XXX_LOGDEV config) enabled.

It could be simply reproduced with loop device with an external journal
and marking blockdev as RO before mounting.

[ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
------------[ cut here ]------------
generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
CPU: 107 PID: 115347 Comm: mount Tainted: G             L   --------- -t - 4.18.0-167.el8.ppc64le #1
NIP:  c0000000006f6d44 LR: c0000000006f6d40 CTR: 0000000030041dd4
<...>
NIP [c0000000006f6d44] generic_make_request_checks+0x6b4/0x7d0
LR [c0000000006f6d40] generic_make_request_checks+0x6b0/0x7d0
<...>
Call Trace:
generic_make_request_checks+0x6b0/0x7d0 (unreliable)
generic_make_request+0x3c/0x420
submit_bio+0xd8/0x200
submit_bh_wbc+0x1e8/0x250
__sync_dirty_buffer+0xd0/0x210
ext4_commit_super+0x310/0x420 [ext4]
__ext4_error+0xa4/0x1e0 [ext4]
__ext4_iget+0x388/0xe10 [ext4]
ext4_get_journal_inode+0x40/0x150 [ext4]
ext4_calculate_overhead+0x5a8/0x610 [ext4]
ext4_fill_super+0x3188/0x3260 [ext4]
mount_bdev+0x778/0x8f0
ext4_mount+0x28/0x50 [ext4]
mount_fs+0x74/0x230
vfs_kern_mount.part.6+0x6c/0x250
do_mount+0x2fc/0x1280
sys_mount+0x158/0x180
system_call+0x5c/0x70
EXT4-fs (pmem1p2): no journal found
EXT4-fs (pmem1p2): can't get journal size
EXT4-fs (pmem1p2): mounted filesystem without journal. Opts: dax,norecovery

Reported-by: Harish Sriram <harish@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index de5398c07161..5dc65b7583cb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3609,7 +3609,8 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 */
 	if (sbi->s_journal && !sbi->journal_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
-	else if (ext4_has_feature_journal(sb) && !sbi->s_journal) {
+	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
+		/* j_inum for internal journal is non-zero */
 		j_inode = ext4_get_journal_inode(sb, j_inum);
 		if (j_inode) {
 			j_blocks = j_inode->i_size >> sb->s_blocksize_bits;
-- 
2.21.0

