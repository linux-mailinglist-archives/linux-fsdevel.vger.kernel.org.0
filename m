Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190044A4A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiAaPRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240373AbiAaPRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VD6fX5011753;
        Mon, 31 Jan 2022 15:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2hchAsb5U1n+eHouQ2OEPBpgZLCLuzV7bPzNx4Wwf98=;
 b=D1m3Oyauop852g7o7PwzaoM8jGkT1WsvUud4//zLrLSxqbK3aNQkrfsN8diN2nsODJZ4
 CvUsTbLetr71DhfAevoR7yNaMJ7Ark807Cd0ylq/5JoFlUu6VOr4M7rTY/3EQf2DMV5W
 ZoPZkx5SPAejaXDbZ5G188NVjsLLpshAtPXZ6b9ZoYeKKR71f4mZ93idOM4G3eAPU2Bw
 wmt42y0djP6FSR6kmc4YldL2MIzmCfhcEKzB1u8gLgFg7Z555cZb2rIlaxQqT5RXVuf4
 YXKaUPIun8y3GEAaFRGVWCx/dmj9i/+xXz95EqogxAUsYRWeI74P+mP2iTA5gNe4rpI+ Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dwv2y5d47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:14 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VEIsu4000778;
        Mon, 31 Jan 2022 15:17:13 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dwv2y5d3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:13 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCC0t014649;
        Mon, 31 Jan 2022 15:17:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3dvw7941wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFH9gY43188648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78F9DA4053;
        Mon, 31 Jan 2022 15:17:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12522A405E;
        Mon, 31 Jan 2022 15:17:09 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:17:08 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 2/6] ext4: Implement ext4_group_block_valid() as common function
Date:   Mon, 31 Jan 2022 20:46:51 +0530
Message-Id: <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643642105.git.riteshh@linux.ibm.com>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pVZ2jPevnDuQh1vWE2AuwmQGwPWm6XiC
X-Proofpoint-ORIG-GUID: HCEhS36c6OEqQLjNGv9R5ikZ69q-vn6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=533 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements ext4_group_block_valid() check functionality,
and refactors all the callers to use this common function instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/block_validity.c | 31 +++++++++++++++++++++++++++++++
 fs/ext4/ext4.h           |  3 +++
 fs/ext4/mballoc.c        | 16 +++-------------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 4666b55b736e..01d822c664df 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -361,3 +361,34 @@ int ext4_check_blockref(const char *function, unsigned int line,
 	return 0;
 }
 
+/*
+ * ext4_group_block_valid - This checks if any of FS metadata blocks of a
+ * given group (@bg) lies in the given range [block, block + count - 1]
+ * or not.
+ *
+ * Return -
+ * - false if it does
+ * - else true
+ */
+bool ext4_group_block_valid(struct super_block *sb, ext4_group_t bg,
+			    ext4_fsblk_t block, unsigned int count)
+{
+	struct ext4_group_desc *gdp;
+	bool ret = true;
+
+	gdp = ext4_get_group_desc(sb, bg, NULL);
+	if (!gdp) {
+		ret = false;
+		goto out;
+	}
+
+	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
+	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
+	    in_range(block, ext4_inode_table(sb, gdp),
+		    EXT4_SB(sb)->s_itb_per_group) ||
+	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
+		    EXT4_SB(sb)->s_itb_per_group))
+		ret = false;
+out:
+	return ret;
+}
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18cd5b3b4815..fc7aa4b3e415 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3706,6 +3706,9 @@ extern int ext4_inode_block_valid(struct inode *inode,
 				  unsigned int count);
 extern int ext4_check_blockref(const char *, unsigned int,
 			       struct inode *, __le32 *, unsigned int);
+extern bool ext4_group_block_valid(struct super_block *sb, ext4_group_t bg,
+				   ext4_fsblk_t block, unsigned int count);
+
 
 /* extents.c */
 struct ext4_ext_path;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8d23108cf9d7..60d32d3d8dc4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6001,13 +6001,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
-	    in_range(block, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group)) {
-
+	if (!ext4_group_block_valid(sb, block_group, block, count)) {
 		ext4_error(sb, "Freeing blocks in system zone - "
 			   "Block = %llu, count = %lu", block, count);
 		/* err = 0. ext4_std_error should be a no op */
@@ -6078,7 +6072,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 						 NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
-					 " group:%d block:%d count:%lu failed"
+					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
 		} else
@@ -6194,11 +6188,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
-	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, desc),
-		     sbi->s_itb_per_group)) {
+	if (!ext4_group_block_valid(sb, block_group, block, count)) {
 		ext4_error(sb, "Adding blocks in system zones - "
 			   "Block = %llu, count = %lu",
 			   block, count);
-- 
2.31.1

