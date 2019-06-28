Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3463C5A3DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfF1Sfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 14:35:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54214 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfF1Sfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:35:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYILG027632;
        Fri, 28 Jun 2019 18:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=MiY2VYpSFpzY6WkWYo65+t0yY/S+2bgdM8Tfcy+RPHs=;
 b=EsEaGQJIsCrbPmH9OznS4Gvkxc1orFTlcEwxQExpwlUwRPJJ9/2dGYPxRHFWSzZmu3PI
 oz2WYxk4CJsXjWlDQqTaUTzi4QBK2xaXdZRS0x/XQ0n46azFi8QfHloIyya1nw/juBCv
 /GcNjv/IJGQrLp4Oz3RwgLvBPC4WljMtRCvxbicMqns6wNmSrHmhKHNqH77k4EAGUxdc
 /W1fzi3PzDN1nIDiHkcbLDcLd+ZiOZYxKdRPC5KmuODEGdubVjskPrZl2cKTFxlVG+N0
 uztVyNgEzIwjOCyFmMrxhWXH+XJo1bOazdUdyCKnzZrU7GMwZOJbkKkRTvt6ps9SySM6 Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9q72tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIXjZ1001279;
        Fri, 28 Jun 2019 18:35:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7e3gfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SIZP9g002352;
        Fri, 28 Jun 2019 18:35:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:35:25 -0700
Subject: [PATCH 2/2] vfs: don't allow writes to swap files
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 28 Jun 2019 11:35:24 -0700
Message-ID: <156174692434.1557844.13804911834937629088.stgit@magnolia>
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

Don't let userspace write to an active swap file because the kernel
effectively has a long term lease on the storage and things could get
seriously corrupted if we let this happen.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/attr.c      |   16 ++++++++--------
 fs/block_dev.c |    3 +++
 mm/filemap.c   |    3 +++
 mm/memory.c    |    3 ++-
 mm/mmap.c      |    2 ++
 mm/swapfile.c  |   12 +++++++++++-
 6 files changed, 29 insertions(+), 10 deletions(-)


diff --git a/fs/attr.c b/fs/attr.c
index 1fcfdcc5b367..7480d5dd22c0 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -134,6 +134,14 @@ EXPORT_SYMBOL(setattr_prepare);
  */
 int inode_newsize_ok(const struct inode *inode, loff_t offset)
 {
+	/*
+	 * Truncation of in-use swapfiles is disallowed - the kernel owns the
+	 * disk space now.  We must prevent subsequent swapout to scribble on
+	 * the now-freed blocks.
+	 */
+	if (IS_SWAPFILE(inode) && inode->i_size != offset)
+		return -ETXTBSY;
+
 	if (inode->i_size < offset) {
 		unsigned long limit;
 
@@ -142,14 +150,6 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 			goto out_sig;
 		if (offset > inode->i_sb->s_maxbytes)
 			goto out_big;
-	} else {
-		/*
-		 * truncation of in-use swapfiles is disallowed - it would
-		 * cause subsequent swapout to scribble on the now-freed
-		 * blocks.
-		 */
-		if (IS_SWAPFILE(inode))
-			return -ETXTBSY;
 	}
 
 	return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 749f5984425d..f57d15e5338b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1948,6 +1948,9 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
+	if (IS_SWAPFILE(bd_inode))
+		return -ETXTBSY;
+
 	if (!iov_iter_count(from))
 		return 0;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index dad85e10f5f8..fd80bc20e30a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2938,6 +2938,9 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_IMMUTABLE(inode))
 		return -EPERM;
 
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
 	if (!iov_iter_count(from))
 		return 0;
 
diff --git a/mm/memory.c b/mm/memory.c
index abf795277f36..5acb5bb04e21 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2236,7 +2236,8 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
 
 	if (vmf->vma->vm_file &&
-	    IS_IMMUTABLE(vmf->vma->vm_file->f_mapping->host))
+	    (IS_IMMUTABLE(vmf->vma->vm_file->f_mapping->host) ||
+	     IS_SWAPFILE(vmf->vma->vm_file->f_mapping->host)))
 		return VM_FAULT_SIGBUS;
 
 	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
diff --git a/mm/mmap.c b/mm/mmap.c
index b3ebca2702bf..1abe55822324 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1488,6 +1488,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 					return -EACCES;
 				if (IS_IMMUTABLE(file->f_mapping->host))
 					return -EPERM;
+				if (IS_SWAPFILE(file->f_mapping->host))
+					return -ETXTBSY;
 			}
 
 			/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index fa4edd0cca3a..1fc820c71baf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3165,6 +3165,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap;
 
+	/*
+	 * Flush any pending IO and dirty mappings before we start using this
+	 * swap device.
+	 */
+	inode->i_flags |= S_SWAPFILE;
+	error = inode_drain_writes(inode);
+	if (error) {
+		inode->i_flags &= ~S_SWAPFILE;
+		goto bad_swap;
+	}
+
 	mutex_lock(&swapon_mutex);
 	prio = -1;
 	if (swap_flags & SWAP_FLAG_PREFER)
@@ -3185,7 +3196,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-	inode->i_flags |= S_SWAPFILE;
 	error = 0;
 	goto out;
 bad_swap:

