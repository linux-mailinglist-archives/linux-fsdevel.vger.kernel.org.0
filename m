Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925521A5DBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgDLJZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 05:25:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDLJY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:24:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03C940jH100747
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 05:24:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b9vsfujf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 05:24:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sun, 12 Apr 2020 10:24:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 Apr 2020 10:24:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03C9OnlM59179236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 09:24:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1645A5204F;
        Sun, 12 Apr 2020 09:24:49 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.84.25])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D847652052;
        Sun, 12 Apr 2020 09:24:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger@dilger.ca
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        willy@infradead.org, linux-unionfs@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Subject: [RFC 1/1] ext4: Fix overflow case for map.m_len in ext4_iomap_begin_*
Date:   Sun, 12 Apr 2020 14:54:35 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <00000000000048518b05a2fef23a@google.com>
References: <00000000000048518b05a2fef23a@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041209-0028-0000-0000-000003F6C51E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041209-0029-0000-0000-000024BC6B50
Message-Id: <dea98f0b07e16de219d8741c1fefc7cb476cb482.1586681010.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxlogscore=817 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004120079
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXT4_MAX_LOGICAL_BLOCK - map.m_lblk + 1 in case when
map.m_lblk (offset) is 0 could overflow an unsigned int
and become 0.

Fix this.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
---
 fs/ext4/inode.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..d630ec7a9c8e 100644
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
+	len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (len > EXT4_MAX_LOGICAL_BLOCK)
+		len = EXT4_MAX_LOGICAL_BLOCK;
+	map.m_len = len;
 
 	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, &map, flags);
@@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	bool delalloc = false;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	loff_t len
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	 * Calculate the first and last logical block respectively.
 	 */
 	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+	len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (len > EXT4_MAX_LOGICAL_BLOCK)
+		len = EXT4_MAX_LOGICAL_BLOCK;
+	map.m_len = len;
 
 	/*
 	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
-- 
2.21.0

