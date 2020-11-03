Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5EB2A4EF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKCSdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:33:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46250 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:33:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3IT0Gg030172;
        Tue, 3 Nov 2020 18:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x6Q0KbrXw9cyuNUCXm365zzHmQkB3VvNc3NWJaqzRVc=;
 b=HYrLbvXk6MKkeQmz8ayYd2mDcMoS7nJWL+AIQqS429DLSSJaa4YnoonnyYSZTOBnMNjp
 c0cuFIjFeLp7wGa5NpkYUDYNsD/9EFKq5dtpjEXbGQPKeonmeD3oBq6a8Iz/VJk/HPA/
 Z/bpcumFs4m/Jg/QlGmtG2rZy00t53Om+Ao3B6Qz8NZjKLd4c0o4+Jl9gIGpIUvXVhRy
 xAHBl20Zv42Vl3KJJD3HqKHVxWKPweYu+jqwuyZoOyQJCPzLAE4iW1hiNHANV+yE07Hj
 /SF2/zOVBtRLYkpCZ5GKMw8AUyJH6A9GFeDM3VXpgFunZfZAVplavN/kBhKn3eaIYyjU Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2juwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 18:33:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3IPi3L029558;
        Tue, 3 Nov 2020 18:33:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34hvrw974c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 18:33:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A3IXjvn006172;
        Tue, 3 Nov 2020 18:33:45 GMT
Received: from localhost (/10.159.234.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 10:33:45 -0800
Date:   Tue, 3 Nov 2020 10:33:44 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 2/2] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
Message-ID: <20201103183344.GG7123@magnolia>
References: <20201103173300.GF7123@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103173300.GF7123@magnolia>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=1 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030125
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Break this function into two helpers so that it's obvious that the
trylock versions return a value that must be checked, and the blocking
versions don't require that.  While we're at it, clean up the return
type mismatches.

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
