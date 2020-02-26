Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD716FB69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBZJ5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:57:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727359AbgBZJ5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:57:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q9omTW004326
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 04:57:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcng88we-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 04:57:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 09:57:34 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 09:57:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q9uXfw47645044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 09:56:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D9044203F;
        Wed, 26 Feb 2020 09:57:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0EAB4204F;
        Wed, 26 Feb 2020 09:57:27 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.47.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 09:57:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Date:   Wed, 26 Feb 2020 15:27:06 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582702693.git.riteshh@linux.ibm.com>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022609-0020-0000-0000-000003ADB3C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022609-0021-0000-0000-00002205CDED
Message-Id: <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For indirect block mapping if the i_block > max supported block in inode
then ext4_ind_map_blocks may return a -EIO error. But in case of fiemap
this could be a valid query to ext4_map_blocks.
So in case if !create then return 0. This also makes ext4_warning to
ext4_debug in ext4_block_to_path() for the same reason.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/indirect.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 3a4ab70fe9e0..e1ab495dd900 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -102,7 +102,11 @@ static int ext4_block_to_path(struct inode *inode,
 		offsets[n++] = i_block & (ptrs - 1);
 		final = ptrs;
 	} else {
-		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
+		/*
+		 * It's not yet an error to just query beyond max
+		 * block in inode. Fiemap callers may do so.
+		 */
+		ext4_debug("block %lu > max in inode %lu",
 			     i_block + direct_blocks +
 			     indirect_blocks + double_blocks, inode->i_ino);
 	}
@@ -537,8 +541,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
 				   &blocks_to_boundary);
 
-	if (depth == 0)
+	if (depth == 0) {
+		if (!(flags & EXT4_GET_BLOCKS_CREATE))
+			err = 0;
 		goto out;
+	}
 
 	partial = ext4_get_branch(inode, depth, offsets, chain, &err);
 
-- 
2.21.0

