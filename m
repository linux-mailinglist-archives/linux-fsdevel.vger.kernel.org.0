Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11225D475
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgIDJRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 05:17:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730040AbgIDJRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:17:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08491kUh185817;
        Fri, 4 Sep 2020 05:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kxEI8iXlDViTnVFGVh2NgyuwZv9fa58lOuPk5xL7oKs=;
 b=aBOcptUb2fP0ZUDz6YYB6El0QZgEUagC3WK2eYKw6+piOXOSUTZkhGixBDJSQD9Ifr0l
 aAx/GgtwpWGIROpJaKVvmSCVwaW9ZjsSjYbpFF2HqMnxvGd8STXDb+vsZYXXWtwxCX07
 bd4HfaWAcCFCE6GdJLSCIx3twVLiAbrylmL5GHzkfZggbcAIOE92B6I4x4cGpz2g1GLp
 jRHiObE8q2q5qHecYlRRESJKVSJ5mM0Ac4FI2Yp/6hqFgfBGa8qLFziKihzQ+UJ1b16s
 2Hn03tjnZcvy31KiSOFGGMRO1TQHaRo9SVIeLyvjDZNMuU3he2fWwcum8dThnoI3H6Co 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bjgs8h9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 05:17:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08492EUl187359;
        Fri, 4 Sep 2020 05:17:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bjgs8h8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 05:17:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0849EKLv018247;
        Fri, 4 Sep 2020 09:17:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8epnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 09:17:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0849Gxnb34996666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 09:16:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 886584C04E;
        Fri,  4 Sep 2020 09:16:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0814C040;
        Fri,  4 Sep 2020 09:16:58 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.40.27])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 09:16:57 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH] ext4: Implement swap_activate aops using iomap
Date:   Fri,  4 Sep 2020 14:46:53 +0530
Message-Id: <20200904091653.1014334-1-riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_05:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=1 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040079
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After moving ext4's bmap to iomap interface, swapon functionality
on files created using fallocate (which creates unwritten extents) are
failing. This is since iomap_bmap interface returns 0 for unwritten
extents and thus generic_swapfile_activate considers this as holes
and hence bail out with below kernel msg :-

[340.915835] swapon: swapfile has holes

To fix this we need to implement ->swap_activate aops in ext4
which will use ext4_iomap_report_ops. Since we only need to return
the list of extents so ext4_iomap_report_ops should be enough.

Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
Fixes: ac58e4fb03f ("ext4: move ext4 bmap to use iomap infrastructure")
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
[Tested xfstests with -g swap; Tested stress-ng with --thrash option]

 fs/ext4/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1556cabd3a7d..9ac0f83e6fbe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3605,6 +3605,13 @@ static int ext4_set_page_dirty(struct page *page)
 	return __set_page_dirty_buffers(page);
 }
 
+static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span,
+				       &ext4_iomap_report_ops);
+}
+
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
 	.readpages		= ext4_readpages,
@@ -3620,6 +3627,7 @@ static const struct address_space_operations ext4_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_journalled_aops = {
@@ -3636,6 +3644,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_da_aops = {
@@ -3653,6 +3662,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 static const struct address_space_operations ext4_dax_aops = {
@@ -3661,6 +3671,7 @@ static const struct address_space_operations ext4_dax_aops = {
 	.set_page_dirty		= noop_set_page_dirty,
 	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
+	.swap_activate		= ext4_iomap_swap_activate,
 };
 
 void ext4_set_aops(struct inode *inode)
-- 
2.25.1

