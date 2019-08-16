Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A43905A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfHPQWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 12:22:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34192 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHPQWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:22:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGDiVv152799;
        Fri, 16 Aug 2019 16:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jya0qPo1pPR32aDptZ4+FxsmgJE6pUUHdS0nPLU6Bd0=;
 b=c5eKQPaV51MeJrEmkUfb/Q942v3idA3NxGMz/lzac58tTLdC0KjdNO/Epj1J8sOJoNEi
 ODOLhU19k9jWxLX+xcsGRCjgtMvMEivClO4Qu/FnkjQPXt9P5EPrwXbTIAIvVO5ogDna
 vsCK4levPW2EtcubmUjEdHwbASf0a+0ceF+4GDxCQ98qSJwiyDUB8C5LJj1k311gjJzJ
 DE5El4P5w+D87KzH26soW9FG7jiv9uWUu77Vb1yncuAwX6JxjnjEnbV0IGFXYE3hG8vU
 d874B7YITXEHcxNey+DNqK1irx5BdIaEBCpYJ/pnQmlUWRZCh98LKr1EPh8GHeEHzlmu 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbu1f9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:21:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGDhTZ128626;
        Fri, 16 Aug 2019 16:19:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2udgqg9yn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:19:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7GGJoVH032329;
        Fri, 16 Aug 2019 16:19:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 09:19:50 -0700
Date:   Fri, 16 Aug 2019 09:19:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] vfs: don't allow writes to swap files
Message-ID: <20190816161948.GJ15186@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <156588515613.111054.13578448017133006248.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156588515613.111054.13578448017133006248.stgit@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160171
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
v2: add missing inode_drain_writes
---
 fs/block_dev.c     |    3 +++
 include/linux/fs.h |   11 +++++++++++
 mm/filemap.c       |    3 +++
 mm/memory.c        |    4 ++++
 mm/mmap.c          |    8 ++++++--
 mm/swapfile.c      |   12 +++++++++++-
 6 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c2a85b587922..d9bab63a9b81 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1978,6 +1978,9 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
+	if (IS_SWAPFILE(bd_inode))
+		return -ETXTBSY;
+
 	if (!iov_iter_count(from))
 		return 0;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56b8e358af5c..a2e3d446ba8e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3547,4 +3547,15 @@ static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
 	fa->fsx_xflags = xflags;
 }
 
+/*
+ * Flush file data before changing attributes.  Caller must hold any locks
+ * required to prevent further writes to this file until we're done setting
+ * flags.
+ */
+static inline int inode_drain_writes(struct inode *inode)
+{
+	inode_dio_wait(inode);
+	return filemap_write_and_wait(inode->i_mapping);
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index f93c58dde9c8..89bcdde903a3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2989,6 +2989,9 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	loff_t count;
 	int ret;
 
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
 	if (!iov_iter_count(from))
 		return 0;
 
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..b1dff75640b7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2196,6 +2196,10 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
 
+	if (vmf->vma->vm_file &&
+	    IS_SWAPFILE(vmf->vma->vm_file->f_mapping->host))
+		return VM_FAULT_SIGBUS;
+
 	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
 	/* Restore original flags so that caller is not surprised */
 	vmf->flags = old_flags;
diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..6bc21fca20bc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1483,8 +1483,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		case MAP_SHARED_VALIDATE:
 			if (flags & ~flags_mask)
 				return -EOPNOTSUPP;
-			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
-				return -EACCES;
+			if (prot & PROT_WRITE) {
+				if (!(file->f_mode & FMODE_WRITE))
+					return -EACCES;
+				if (IS_SWAPFILE(file->f_mapping->host))
+					return -ETXTBSY;
+			}
 
 			/*
 			 * Make sure we don't allow writing to an append-only
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a53b7c49b40e..dab43523afdd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3275,6 +3275,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
@@ -3295,7 +3306,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-	inode->i_flags |= S_SWAPFILE;
 	error = 0;
 	goto out;
 bad_swap:
