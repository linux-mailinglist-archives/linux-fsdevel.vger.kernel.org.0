Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1D55EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFZCgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 22:36:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFZCgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:36:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2Z0Zp120740;
        Wed, 26 Jun 2019 02:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RDkQFwhFFQ2vI5qz0xIqaf4zf8uM8p//mWlaoaNYF+I=;
 b=Qi2NwHnVvWi7uetKAFrtDLbEc7vBEztBO544xnn041sSZ7Fd3ocayxJrgUVLY5aWK0nf
 Ite4JKYpy0UTn6/XETb7boW3RhaAdXiKa1fL2V5TysE/aV9BaTPrGmv7gGnaw4E3aPVd
 h1eAr0iXSQgZ8bt1cz+Y/aA8/0mIndivv/2HisCjrSY7yBaaGjEge4/5om9TBbv2jvW3
 eOfa1J2vXFZDfhPdb+EttM0EV/jAq/YuGxJoz8dMa6tkFMJao88u3rFVpg9bj4ZNDBKS
 k6bGwT+rfiYQyJ1DPmadzn9S646qAfU1gSQw1fIjxewe/fI4Upnp6HJpT25nXB2TRGu8 EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brt7mt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:35:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2XQY8081296;
        Wed, 26 Jun 2019 02:33:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2tat7cjp2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 02:33:36 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5Q2XZtv081761;
        Wed, 26 Jun 2019 02:33:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7cjp28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:33:35 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q2XY3k021348;
        Wed, 26 Jun 2019 02:33:34 GMT
Received: from localhost (/10.159.230.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 19:33:34 -0700
Subject: [PATCH 5/5] vfs: don't allow writes to swap files
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
        josef@toxicpanda.com, hch@infradead.org, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org
Cc:     reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Tue, 25 Jun 2019 19:33:31 -0700
Message-ID: <156151641177.2283603.7806026378321236401.stgit@magnolia>
In-Reply-To: <156151637248.2283603.8458727861336380714.stgit@magnolia>
References: <156151637248.2283603.8458727861336380714.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260028
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
 fs/attr.c     |    3 +++
 mm/filemap.c  |    3 +++
 mm/memory.c   |    4 +++-
 mm/mmap.c     |    2 ++
 mm/swapfile.c |   15 +++++++++++++--
 5 files changed, 24 insertions(+), 3 deletions(-)


diff --git a/fs/attr.c b/fs/attr.c
index 1fcfdcc5b367..42f4d4fb0631 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -236,6 +236,9 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (IS_IMMUTABLE(inode))
 		return -EPERM;
 
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
 	if ((ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) &&
 	    IS_APPEND(inode))
 		return -EPERM;
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
index 4311cfdade90..c04c6a689995 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2235,7 +2235,9 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
 
-	if (vmf->vma->vm_file && IS_IMMUTABLE(file_inode(vmf->vma->vm_file)))
+	if (vmf->vma->vm_file &&
+	    (IS_IMMUTABLE(file_inode(vmf->vma->vm_file)) ||
+	     IS_SWAPFILE(file_inode(vmf->vma->vm_file))))
 		return VM_FAULT_SIGBUS;
 
 	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
diff --git a/mm/mmap.c b/mm/mmap.c
index ac1e32205237..031807339869 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1488,6 +1488,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 					return -EACCES;
 				if (IS_IMMUTABLE(file_inode(file)))
 					return -EPERM;
+				if (IS_SWAPFILE(file_inode(file)))
+					return -ETXTBSY;
 			}
 
 			/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 596ac98051c5..1ca4ee8c2d60 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3165,6 +3165,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap;
 
+	/*
+	 * Flush any pending IO and dirty mappings before we start using this
+	 * swap file.
+	 */
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_flags |= S_SWAPFILE;
+		error = inode_drain_writes(inode);
+		if (error) {
+			inode->i_flags &= ~S_SWAPFILE;
+			goto bad_swap;
+		}
+	}
+
 	mutex_lock(&swapon_mutex);
 	prio = -1;
 	if (swap_flags & SWAP_FLAG_PREFER)
@@ -3185,8 +3198,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-	if (S_ISREG(inode->i_mode))
-		inode->i_flags |= S_SWAPFILE;
 	error = 0;
 	goto out;
 bad_swap:

