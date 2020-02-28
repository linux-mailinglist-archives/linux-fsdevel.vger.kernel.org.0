Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727331733F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 10:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB1J12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 04:27:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgB1J12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:27:28 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S9K4au026384
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepwtq3nj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 28 Feb 2020 09:27:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 09:27:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S9RJFm36569186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:27:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C621E42049;
        Fri, 28 Feb 2020 09:27:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF9542047;
        Fri, 28 Feb 2020 09:27:17 +0000 (GMT)
Received: from dhcp-9-199-158-200.in.ibm.com (unknown [9.199.158.200])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 09:27:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Date:   Fri, 28 Feb 2020 14:56:57 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582880246.git.riteshh@linux.ibm.com>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022809-0028-0000-0000-000003DECD56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022809-0029-0000-0000-000024A3EF7A
Message-Id: <87fa0ddc5967fa707656212a3b66a7233425325c.1582880246.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=359 adultscore=0 mlxscore=0 suspectscore=5 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For indirect block mapping if the i_block > max supported block in inode
then ext4_ind_map_blocks() returns a -EIO error. But in case of fiemap
this could be a valid query to ->iomap_begin call.
So check if the offset >= s_bitmap_maxbytes in ext4_iomap_begin_report(),
then simply skip calling ext4_map_blocks().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 81fccbae0aea..4364864fc709 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3548,12 +3548,28 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
+	/*
+	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
+	 * So handle it here itself instead of querying ext4_map_blocks().
+	 * Since ext4_map_blocks() will warn about it and will return
+	 * -EIO error.
+	 */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
+		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+		if (offset >= sbi->s_bitmap_maxbytes) {
+			map.m_flags = 0;
+			goto set_iomap;
+		}
+	}
+
 	ret = ext4_map_blocks(NULL, inode, &map, 0);
 	if (ret < 0)
 		return ret;
 	if (ret == 0)
 		delalloc = ext4_iomap_is_delalloc(inode, &map);
 
+set_iomap:
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 	if (delalloc && iomap->type == IOMAP_HOLE)
 		iomap->type = IOMAP_DELALLOC;
-- 
2.21.0

