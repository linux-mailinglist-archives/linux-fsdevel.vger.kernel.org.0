Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E545D2A8E16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 05:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgKFEKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 23:10:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:10:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A645EZH121769;
        Fri, 6 Nov 2020 04:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y1V5UKpvZl7SoelSV6SSCFD8cKpEZEi8WjLcTgXPGZM=;
 b=f9aLxLhMQtbL76Prr8uD4pgh6OKP8EJwkU5SsGkdTbHgwr2C2lZqHNfOZla3gmxpSS4A
 XGGecpVjXtpEGvfBiO9bD2tcEZRy9IyvfosOBr6t8ALC3NFBtL17smKj2nSjgp+Tc7Bf
 0rOr/xJlk4HwtcBboBpxA/liNO8KqPCyx4Fj88xk4fRwQ/6+k3dcV0ztcZVOprYocqHU
 JZ2XOnVRUJX3rnaSa51YMHKoDNAlZq3+VcNXCDkxDZ+kwSSQWCZutF9Vwm6ku0sFwjF8
 IbVrgHr4+I3drUQG6vWTX2SpKSXsN5HAMrLD/AHbgmdlvomYSS6/gZ1rqzkFYgXro67D ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34hhw2y5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 04:10:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A644oBb013986;
        Fri, 6 Nov 2020 04:10:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34hw0jj33m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 04:10:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A64AZXb005812;
        Fri, 6 Nov 2020 04:10:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 20:10:35 -0800
Subject: [PATCH 2/2] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 05 Nov 2020 20:10:34 -0800
Message-ID: <160463583438.1669281.14783057013328963357.stgit@magnolia>
In-Reply-To: <160463582157.1669281.13010940328517200152.stgit@magnolia>
References: <160463582157.1669281.13010940328517200152.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060026
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
index c45c20d87538..04bb4bac327f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1572,7 +1572,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		 * we return to userspace.
 		 */
 		if (S_ISREG(file_inode(file)->i_mode)) {
-			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index b42dfa0243bf..b735fecb49da 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3532,8 +3532,7 @@ static int io_write(struct io_kiocb *req, bool force_nonblock,
 	 * we return to userspace.
 	 */
 	if (req->flags & REQ_F_ISREG) {
-		__sb_start_write(file_inode(req->file)->i_sb,
-					SB_FREEZE_WRITE, true);
+		__sb_start_write(file_inode(req->file)->i_sb, SB_FREEZE_WRITE);
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
index 0bd126418bb6..98548ec7de0b 100644
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
+	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 }
 
 static inline bool file_start_write_trylock(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return true;
-	return __sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, false);
+	return __sb_start_write_trylock(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 }
 
 static inline void file_end_write(struct file *file)

