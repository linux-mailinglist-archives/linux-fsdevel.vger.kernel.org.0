Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC42AC38E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgKISTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:19:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56744 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgKISTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:19:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IA7LS121092;
        Mon, 9 Nov 2020 18:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=i7WPSJBrWuFM7VjiIoMSGNOSzc9x9FJR+5wrYmvgi6Q=;
 b=J9BImtAj76NCALBbxwGAxYxs3kU62QtceULlY1+NzOnj3g9appCom1Ddb6rbJp8rp7HZ
 V9QB8S3Ocx6hgQYVpH24fGKZ3NzJzSS129hATZq/OP/qfidWqLRGU+fqGHKm+8XpROpb
 TjNCLG9bBEWHlUFxe2sMqYwsX6Fq+akeaBuBWM5TwkKPJz+0MBRG1IWJcSSESY8m18xo
 a5S3P4CEnMHEkWZoitZmxLgwf113Iqr0nkDKcoTj2i6A2hOJabs0LqmaWPey6uux1nGy
 OI5iOCR4xTewah8LrF9qZ4Xh/2Ethb9xNFpAtGjCHMPSRUCXILqsWIm9LJOabhSOR86H rA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3aqngp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 18:19:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IA5Xw159110;
        Mon, 9 Nov 2020 18:17:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gvm3fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 18:17:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9IGxFn019426;
        Mon, 9 Nov 2020 18:16:59 GMT
Received: from localhost (/10.159.239.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 10:16:58 -0800
Subject: [PATCH 2/3] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Nov 2020 10:16:57 -0800
Message-ID: <160494581731.772573.9685036230289776579.stgit@magnolia>
In-Reply-To: <160494580419.772573.9286165021627298770.stgit@magnolia>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=1
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Break this function into two helpers so that it's obvious that the
trylock versions return a value that must be checked, and the blocking
versions don't require that.  While we're at it, clean up the return
type mismatch.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c           |    2 +-
 fs/io_uring.c      |    3 +--
 fs/super.c         |   18 ++++++++++++------
 include/linux/fs.h |   21 +++++++++++----------
 4 files changed, 25 insertions(+), 19 deletions(-)


diff --git a/fs/aio.c b/fs/aio.c
index c45c20d87538..6a21d8919409 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1572,7 +1572,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		 * we return to userspace.
 		 */
 		if (S_ISREG(file_inode(file)->i_mode)) {
-			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+			sb_start_write(file_inode(file)->i_sb);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index b42dfa0243bf..4cbaddfe3d80 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3532,8 +3532,7 @@ static int io_write(struct io_kiocb *req, bool force_nonblock,
 	 * we return to userspace.
 	 */
 	if (req->flags & REQ_F_ISREG) {
-		__sb_start_write(file_inode(req->file)->i_sb,
-					SB_FREEZE_WRITE, true);
+		sb_start_write(file_inode(req->file)->i_sb);
 		__sb_writers_release(file_inode(req->file)->i_sb,
 					SB_FREEZE_WRITE);
 	}
diff --git a/fs/super.c b/fs/super.c
index e1fd667454d4..59aa59279133 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1645,16 +1645,22 @@ EXPORT_SYMBOL(__sb_end_write);
  * This is an internal function, please use sb_start_{write,pagefault,intwrite}
  * instead.
  */
-int __sb_start_write(struct super_block *sb, int level, bool wait)
+void __sb_start_write(struct super_block *sb, int level)
 {
-	if (!wait)
-		return percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
-
-	percpu_down_read(sb->s_writers.rw_sem + level-1);
-	return 1;
+	percpu_down_read(sb->s_writers.rw_sem + level - 1);
 }
 EXPORT_SYMBOL(__sb_start_write);
 
+/*
+ * This is an internal function, please use sb_start_{write,pagefault,intwrite}
+ * instead.
+ */
+bool __sb_start_write_trylock(struct super_block *sb, int level)
+{
+	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
+}
+EXPORT_SYMBOL_GPL(__sb_start_write_trylock);
+
 /**
  * sb_wait_write - wait until all writers to given file system finish
  * @sb: the super for which we wait
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0bd126418bb6..305989afd49c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1581,7 +1581,8 @@ extern struct timespec64 current_time(struct inode *inode);
  */
 
 void __sb_end_write(struct super_block *sb, int level);
-int __sb_start_write(struct super_block *sb, int level, bool wait);
+void __sb_start_write(struct super_block *sb, int level);
+bool __sb_start_write_trylock(struct super_block *sb, int level);
 
 #define __sb_writers_acquired(sb, lev)	\
 	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
@@ -1645,12 +1646,12 @@ static inline void sb_end_intwrite(struct super_block *sb)
  */
 static inline void sb_start_write(struct super_block *sb)
 {
-	__sb_start_write(sb, SB_FREEZE_WRITE, true);
+	__sb_start_write(sb, SB_FREEZE_WRITE);
 }
 
-static inline int sb_start_write_trylock(struct super_block *sb)
+static inline bool sb_start_write_trylock(struct super_block *sb)
 {
-	return __sb_start_write(sb, SB_FREEZE_WRITE, false);
+	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
 }
 
 /**
@@ -1674,7 +1675,7 @@ static inline int sb_start_write_trylock(struct super_block *sb)
  */
 static inline void sb_start_pagefault(struct super_block *sb)
 {
-	__sb_start_write(sb, SB_FREEZE_PAGEFAULT, true);
+	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
 }
 
 /*
@@ -1692,12 +1693,12 @@ static inline void sb_start_pagefault(struct super_block *sb)
  */
 static inline void sb_start_intwrite(struct super_block *sb)
 {
-	__sb_start_write(sb, SB_FREEZE_FS, true);
+	__sb_start_write(sb, SB_FREEZE_FS);
 }
 
-static inline int sb_start_intwrite_trylock(struct super_block *sb)
+static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 {
-	return __sb_start_write(sb, SB_FREEZE_FS, false);
+	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
 
@@ -2756,14 +2757,14 @@ static inline void file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+	sb_start_write(file_inode(file)->i_sb);
 }
 
 static inline bool file_start_write_trylock(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return true;
-	return __sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, false);
+	return sb_start_write_trylock(file_inode(file)->i_sb);
 }
 
 static inline void file_end_write(struct file *file)

