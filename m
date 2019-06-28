Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095965A3C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfF1Sfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 14:35:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF1Sf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:35:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYGGJ114587;
        Fri, 28 Jun 2019 18:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=o7DgJUcGo9xVHV7BN6dTCgC24ypKZRenCunIj09I43o=;
 b=W7BT12TUQkRJc9zRIeLhgn2TNRvJwTMiDY2FRc1JZiV7LY8SgJhVvHyo87i11W9DBPa0
 pdCDemTe0pkBz32X7/AXbMRQmMr+omDeTw82InHU3ID+hot/1bDViavs0AMQpu2xalrc
 /Mf0xks9kzi7JYAlYEHg/Hqdu98lhi5JaWG/YgM7H71rO7WVKKkOxQZ/7blOdeZgl/pr
 9FUAQNbeoiYEsIiEjutUGPEdZXAyInYOFdWCkcqe2teTVjDL3kR2iF0Xyo34VLK9uzF6
 2IvnN5yBkZH/gKUyJsWEo+UmyOPG6dvxFFdCOvc2rndw6PvnRWiSKpHisobdXsZiNLnJ MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqxym1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYqFH152196;
        Fri, 28 Jun 2019 18:35:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6w238c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SIZJNC027332;
        Fri, 28 Jun 2019 18:35:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:35:19 -0700
Subject: [PATCH 1/2] mm: set S_SWAPFILE on blockdev swap devices
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 28 Jun 2019 11:35:17 -0700
Message-ID: <156174691783.1557844.3238867236650883424.stgit@magnolia>
In-Reply-To: <156174691124.1557844.14293659081769020256.stgit@magnolia>
References: <156174691124.1557844.14293659081769020256.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280210
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
index 596ac98051c5..fa4edd0cca3a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2284,9 +2284,8 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
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
@@ -2551,13 +2550,14 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -2780,11 +2780,11 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
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
@@ -3185,8 +3185,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-	if (S_ISREG(inode->i_mode))
-		inode->i_flags |= S_SWAPFILE;
+	inode->i_flags |= S_SWAPFILE;
 	error = 0;
 	goto out;
 bad_swap:
@@ -3208,7 +3207,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
 	if (swap_file) {
-		if (inode && S_ISREG(inode->i_mode)) {
+		if (inode) {
 			inode_unlock(inode);
 			inode = NULL;
 		}
@@ -3221,7 +3220,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	if (name)
 		putname(name);
-	if (inode && S_ISREG(inode->i_mode))
+	if (inode)
 		inode_unlock(inode);
 	if (!error)
 		enable_swap_slots_cache();

