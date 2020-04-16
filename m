Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56F1ACFF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDPSxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 14:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgDPSxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:53:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GIYZvn190107
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 14:53:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ev0w1wup-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 14:53:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 16 Apr 2020 19:52:27 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 19:52:23 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GIqpnS35586458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 18:52:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AE9D5204E;
        Thu, 16 Apr 2020 18:52:51 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.253])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 226B45204F;
        Thu, 16 Apr 2020 18:52:48 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/1] ext4: Fix overflow case for map.m_len in ext4_iomap_begin_*
Date:   Fri, 17 Apr 2020 00:22:43 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041618-0008-0000-0000-00000371E911
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041618-0009-0000-0000-00004A93A1F8
Message-Id: <1a2dc8f198e1225ddd40833de76b60c7ee20d22d.1587024137.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_07:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=906
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXT4_MAX_LOGICAL_BLOCK - map.m_lblk + 1 in case when
map.m_lblk (offset) is 0 could overflow an unsigned int
and become 0.

Fix this.

Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
Reported-and-tested-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
@Jan,
I retained your Reviewed by, since there was no logic change, but just couple
of minor change - missed semicolon and tab space issue.

 fs/ext4/inode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..d9feaaad8ab8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3424,6 +3424,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	loff_t len;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3435,8 +3436,11 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 * Calculate the first and last logical blocks respectively.
 	 */
 	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
-			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	len = min_t(loff_t, (offset + length - 1) >> blkbits,
+		    EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (len > EXT4_MAX_LOGICAL_BLOCK)
+		len = EXT4_MAX_LOGICAL_BLOCK;
+	map.m_len = len;
 
 	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, &map, flags);
@@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	bool delalloc = false;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	loff_t len;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	 * Calculate the first and last logical block respectively.
 	 */
 	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
-			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	len = min_t(loff_t, (offset + length - 1) >> blkbits,
+		    EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (len > EXT4_MAX_LOGICAL_BLOCK)
+		len = EXT4_MAX_LOGICAL_BLOCK;
+	map.m_len = len;
 
 	/*
 	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
-- 
2.21.0

