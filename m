Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497198F017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHOQGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:06:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46786 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfHOQGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:06:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FG3t30003048;
        Thu, 15 Aug 2019 16:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=fGMpErgCA/O5M9vyBFLeT14i3Vu31Za+KYREJqkVJ/U=;
 b=cHB+qxHp9WxMM2txiWT1G6ixmPnpbAvSckZYGJB52VFTP8AzGOFCYoMwMsLM11+Inwyv
 lIYMdRSYhpDpCkmI/arv9j1G3prLRfMXufbsY+DuG8v5i6EvZwUwLbtTeuqjHpEXermQ
 tPrkFDh2onQ3ZDiRbZ5o/pzG0XvBRVTwYUnGeRChFXsEov6EB96DwWRYyt6IYP5JNYif
 OHyCXuGQCWpOCWcN7d7Hkc0n1k7XPIkX4mYuJmMEb69EHvCJRMUcqhsKw+fuiVxMmJGq
 Bb7DWejbd0+wXSDlLwWbGZpSwbDnbIKU+icMP/4QG+7Hq4sHN1baanZtY00F6yVaGBp3 jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvpkp3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 16:05:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FG31ul107851;
        Thu, 15 Aug 2019 16:05:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ucmwjuwmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 16:05:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FG5pJX002636;
        Thu, 15 Aug 2019 16:05:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 09:05:50 -0700
Subject: [PATCH 1/2] mm: set S_SWAPFILE on blockdev swap devices
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 15 Aug 2019 09:05:47 -0700
Message-ID: <156588514761.111054.15427341787826850860.stgit@magnolia>
In-Reply-To: <156588514105.111054.13645634739408399209.stgit@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Set S_SWAPFILE on block device inodes so that they have the same
protections as a swap flie.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 mm/swapfile.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)


diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0789a762ce2f..a53b7c49b40e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2368,9 +2368,8 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
  * requirements, they are simply tossed out - we will never use those blocks
  * for swapping.
  *
- * For S_ISREG swapfiles we set S_SWAPFILE across the life of the swapon.  This
- * prevents root from shooting her foot off by ftruncating an in-use swapfile,
- * which will scribble on the fs.
+ * For all swap devices we set S_SWAPFILE across the life of the swapon.  This
+ * prevents users from writing to the swap device, which will corrupt memory.
  *
  * The amount of disk space which a single swap extent represents varies.
  * Typically it is in the 1-4 megabyte range.  So we can have hundreds of
@@ -2661,13 +2660,14 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	inode = mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		struct block_device *bdev = I_BDEV(inode);
+
 		set_blocksize(bdev, old_block_size);
 		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-	} else {
-		inode_lock(inode);
-		inode->i_flags &= ~S_SWAPFILE;
-		inode_unlock(inode);
 	}
+
+	inode_lock(inode);
+	inode->i_flags &= ~S_SWAPFILE;
+	inode_unlock(inode);
 	filp_close(swap_file, NULL);
 
 	/*
@@ -2890,11 +2890,11 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
 		p->bdev = inode->i_sb->s_bdev;
-		inode_lock(inode);
-		if (IS_SWAPFILE(inode))
-			return -EBUSY;
-	} else
-		return -EINVAL;
+	}
+
+	inode_lock(inode);
+	if (IS_SWAPFILE(inode))
+		return -EBUSY;
 
 	return 0;
 }
@@ -3295,8 +3295,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-	if (S_ISREG(inode->i_mode))
-		inode->i_flags |= S_SWAPFILE;
+	inode->i_flags |= S_SWAPFILE;
 	error = 0;
 	goto out;
 bad_swap:
@@ -3318,7 +3317,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
 	if (swap_file) {
-		if (inode && S_ISREG(inode->i_mode)) {
+		if (inode) {
 			inode_unlock(inode);
 			inode = NULL;
 		}
@@ -3331,7 +3330,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	if (name)
 		putname(name);
-	if (inode && S_ISREG(inode->i_mode))
+	if (inode)
 		inode_unlock(inode);
 	if (!error)
 		enable_swap_slots_cache();

