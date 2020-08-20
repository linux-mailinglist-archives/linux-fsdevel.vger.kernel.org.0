Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EBA24B8FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgHTLhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:37:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730860AbgHTLgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:36:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KBYhe3043007;
        Thu, 20 Aug 2020 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SH3r8zO0T156Tqbtqgkajzax4aNk7O027h4poQWfte4=;
 b=JPFjhdvWp5wukbvvzgQRr7fUshAVPCmwhGxg4DymRocChWz4LEgR414YtKI/WRH5q5oN
 3yzuWeTxNRI4870nqqaygZvjZeesYoURZxDjVMNa6P8qDEtXxXqC4svvABozcmR9J1aQ
 I7NzG8vKwp7okL2KDUSqGb3MLJ+kEXHOAZYRsdhMTIejvKUtRTHbOHAhcD1KUtLoI4Wd
 TRi94BZv4tjYmX0HzDtXWDhVIfZLe5rx071wbn5uKirGZWt9c0rZVWjQlZFQTwJpFGmx
 YxNc03SxxmcLNq71Z1u/3AzttB+xNwX3MrMZHuKbRaMycEMAbS1v3qkdTYnL+Jw8rkq6 tw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3310f0a933-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 07:36:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KBVJ4D001237;
        Thu, 20 Aug 2020 11:36:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3304um32a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 11:36:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KBae1E28901764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 11:36:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1D07A4040;
        Thu, 20 Aug 2020 11:36:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E5A9A404D;
        Thu, 20 Aug 2020 11:36:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 11:36:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC 1/1] ext4: Optimize ext4 DAX overwrites
Date:   Thu, 20 Aug 2020 17:06:28 +0530
Message-Id: <696f5386f1c306e769be409c8b1d90a3358bbf8d.1597855360.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1597855360.git.riteshh@linux.ibm.com>
References: <cover.1597855360.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=898 mlxscore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently in case of DAX, we are starting a transaction
everytime for IOMAP_WRITE case. This can be optimized
away in case of an overwrite (where the blocks were already
allocated). This could give a significant performance boost
for multi-threaded random writes.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h  | 1 +
 fs/ext4/file.c  | 2 +-
 fs/ext4/inode.c | 8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..9a2138afc751 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3232,6 +3232,7 @@ extern const struct dentry_operations ext4_dentry_ops;
 extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
 extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
+extern bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len);
 
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..51cd92ac1758 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -188,7 +188,7 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
 }
 
 /* Is IO overwriting allocated and initialized blocks? */
-static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
+bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 {
 	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..f0ac0ee9e991 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3423,6 +3423,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	bool overwrite = false;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3430,6 +3431,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
 		return -ERANGE;
 
+	if (IS_DAX(inode) && (flags & IOMAP_WRITE) &&
+	    ext4_overwrite_io(inode, offset, length))
+		overwrite = true;
 	/*
 	 * Calculate the first and last logical blocks respectively.
 	 */
@@ -3437,13 +3441,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
-	if (flags & IOMAP_WRITE)
+	if ((flags & IOMAP_WRITE) && !overwrite)
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	else
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 
 	if (ret < 0)
 		return ret;
+	if (IS_DAX(inode) && overwrite)
+		WARN_ON(!(map.m_flags & EXT4_MAP_MAPPED));
 
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 
-- 
2.25.4

