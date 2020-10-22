Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BA296125
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368217AbgJVOwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 10:52:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S368214AbgJVOwJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:52:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 30F26FF6DDC4680DAA83;
        Thu, 22 Oct 2020 22:52:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 22:51:54 +0800
To:     <miklos@szeredi.hu>, <mszeredi@redhat.com>
CC:     linfeilong <linfeilong@huawei.com>,
        <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lihaotian <lihaotian9@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] fuse: fix potential accessing NULL pointer problem in
 fuse_send_init()
Message-ID: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
Date:   Thu, 22 Oct 2020 22:51:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In fuse_send_init func, ia is allocated by calling kzalloc func, and
we donot check whether ia is NULL before using it. Thus, if allocating
ia fails, accessing NULL pointer problem will occur.

Here, we will call process_init_reply func if ia is NULL.

Fixes: 615047eff108 ("fuse: convert init to simple api")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Haotian Li <lihaotian9@huawei.com>
---
 fs/fuse/inode.c | 161 ++++++++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 74 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 581329203d68..bb526d8cf5b0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -898,88 +898,97 @@ struct fuse_init_args {
 static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 			       int error)
 {
-	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
-	struct fuse_init_out *arg = &ia->out;
+	struct fuse_init_args *ia;
+	struct fuse_init_out *arg;
+	unsigned long ra_pages;

-	if (error || arg->major != FUSE_KERNEL_VERSION)
+	if (!args) {
 		fc->conn_error = 1;
-	else {
-		unsigned long ra_pages;
+		goto out;
+	}

-		process_init_limits(fc, arg);
+	ia = container_of(args, typeof(*ia), args);
+	arg = &ia->out;
+	if (error || arg->major != FUSE_KERNEL_VERSION) {
+		fc->conn_error = 1;
+		goto out_free_ia;
+	}

-		if (arg->minor >= 6) {
-			ra_pages = arg->max_readahead / PAGE_SIZE;
-			if (arg->flags & FUSE_ASYNC_READ)
-				fc->async_read = 1;
-			if (!(arg->flags & FUSE_POSIX_LOCKS))
-				fc->no_lock = 1;
-			if (arg->minor >= 17) {
-				if (!(arg->flags & FUSE_FLOCK_LOCKS))
-					fc->no_flock = 1;
-			} else {
-				if (!(arg->flags & FUSE_POSIX_LOCKS))
-					fc->no_flock = 1;
-			}
-			if (arg->flags & FUSE_ATOMIC_O_TRUNC)
-				fc->atomic_o_trunc = 1;
-			if (arg->minor >= 9) {
-				/* LOOKUP has dependency on proto version */
-				if (arg->flags & FUSE_EXPORT_SUPPORT)
-					fc->export_support = 1;
-			}
-			if (arg->flags & FUSE_BIG_WRITES)
-				fc->big_writes = 1;
-			if (arg->flags & FUSE_DONT_MASK)
-				fc->dont_mask = 1;
-			if (arg->flags & FUSE_AUTO_INVAL_DATA)
-				fc->auto_inval_data = 1;
-			else if (arg->flags & FUSE_EXPLICIT_INVAL_DATA)
-				fc->explicit_inval_data = 1;
-			if (arg->flags & FUSE_DO_READDIRPLUS) {
-				fc->do_readdirplus = 1;
-				if (arg->flags & FUSE_READDIRPLUS_AUTO)
-					fc->readdirplus_auto = 1;
-			}
-			if (arg->flags & FUSE_ASYNC_DIO)
-				fc->async_dio = 1;
-			if (arg->flags & FUSE_WRITEBACK_CACHE)
-				fc->writeback_cache = 1;
-			if (arg->flags & FUSE_PARALLEL_DIROPS)
-				fc->parallel_dirops = 1;
-			if (arg->flags & FUSE_HANDLE_KILLPRIV)
-				fc->handle_killpriv = 1;
-			if (arg->time_gran && arg->time_gran <= 1000000000)
-				fc->sb->s_time_gran = arg->time_gran;
-			if ((arg->flags & FUSE_POSIX_ACL)) {
-				fc->default_permissions = 1;
-				fc->posix_acl = 1;
-				fc->sb->s_xattr = fuse_acl_xattr_handlers;
-			}
-			if (arg->flags & FUSE_CACHE_SYMLINKS)
-				fc->cache_symlinks = 1;
-			if (arg->flags & FUSE_ABORT_ERROR)
-				fc->abort_err = 1;
-			if (arg->flags & FUSE_MAX_PAGES) {
-				fc->max_pages =
-					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
-					max_t(unsigned int, arg->max_pages, 1));
-			}
-		} else {
-			ra_pages = fc->max_read / PAGE_SIZE;
+	process_init_limits(fc, arg);
+
+	if (arg->minor >= 6) {
+		ra_pages = arg->max_readahead / PAGE_SIZE;
+		if (arg->flags & FUSE_ASYNC_READ)
+			fc->async_read = 1;
+		if (!(arg->flags & FUSE_POSIX_LOCKS))
 			fc->no_lock = 1;
-			fc->no_flock = 1;
+		if (arg->minor >= 17) {
+			if (!(arg->flags & FUSE_FLOCK_LOCKS))
+				fc->no_flock = 1;
+		} else {
+			if (!(arg->flags & FUSE_POSIX_LOCKS))
+				fc->no_flock = 1;
 		}
-
-		fc->sb->s_bdi->ra_pages =
-				min(fc->sb->s_bdi->ra_pages, ra_pages);
-		fc->minor = arg->minor;
-		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
-		fc->max_write = max_t(unsigned, 4096, fc->max_write);
-		fc->conn_init = 1;
+		if (arg->flags & FUSE_ATOMIC_O_TRUNC)
+			fc->atomic_o_trunc = 1;
+		if (arg->minor >= 9) {
+			/* LOOKUP has dependency on proto version */
+			if (arg->flags & FUSE_EXPORT_SUPPORT)
+				fc->export_support = 1;
+		}
+		if (arg->flags & FUSE_BIG_WRITES)
+			fc->big_writes = 1;
+		if (arg->flags & FUSE_DONT_MASK)
+			fc->dont_mask = 1;
+		if (arg->flags & FUSE_AUTO_INVAL_DATA)
+			fc->auto_inval_data = 1;
+		else if (arg->flags & FUSE_EXPLICIT_INVAL_DATA)
+			fc->explicit_inval_data = 1;
+		if (arg->flags & FUSE_DO_READDIRPLUS) {
+			fc->do_readdirplus = 1;
+			if (arg->flags & FUSE_READDIRPLUS_AUTO)
+				fc->readdirplus_auto = 1;
+		}
+		if (arg->flags & FUSE_ASYNC_DIO)
+			fc->async_dio = 1;
+		if (arg->flags & FUSE_WRITEBACK_CACHE)
+			fc->writeback_cache = 1;
+		if (arg->flags & FUSE_PARALLEL_DIROPS)
+			fc->parallel_dirops = 1;
+		if (arg->flags & FUSE_HANDLE_KILLPRIV)
+			fc->handle_killpriv = 1;
+		if (arg->time_gran && arg->time_gran <= 1000000000)
+			fc->sb->s_time_gran = arg->time_gran;
+		if ((arg->flags & FUSE_POSIX_ACL)) {
+			fc->default_permissions = 1;
+			fc->posix_acl = 1;
+			fc->sb->s_xattr = fuse_acl_xattr_handlers;
+		}
+		if (arg->flags & FUSE_CACHE_SYMLINKS)
+			fc->cache_symlinks = 1;
+		if (arg->flags & FUSE_ABORT_ERROR)
+			fc->abort_err = 1;
+		if (arg->flags & FUSE_MAX_PAGES) {
+			fc->max_pages =
+				min_t(unsigned int, FUSE_MAX_MAX_PAGES,
+				max_t(unsigned int, arg->max_pages, 1));
+		}
+	} else {
+		ra_pages = fc->max_read / PAGE_SIZE;
+		fc->no_lock = 1;
+		fc->no_flock = 1;
 	}
-	kfree(ia);

+	fc->sb->s_bdi->ra_pages =
+			min(fc->sb->s_bdi->ra_pages, ra_pages);
+	fc->minor = arg->minor;
+	fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
+	fc->max_write = max_t(unsigned int, 4096, fc->max_write);
+	fc->conn_init = 1;
+
+out_free_ia:
+	kfree(ia);
+out:
 	fuse_set_initialized(fc);
 	wake_up_all(&fc->blocked_waitq);
 }
@@ -989,6 +998,10 @@ void fuse_send_init(struct fuse_conn *fc)
 	struct fuse_init_args *ia;

 	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	if (!ia) {
+		process_init_reply(fc, NULL, -ENOTCONN);
+		return;
+	}

 	ia->in.major = FUSE_KERNEL_VERSION;
 	ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
-- 
2.19.1


