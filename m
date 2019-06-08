Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87D93A020
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFHN53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 09:57:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38844 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHN53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:57:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so4835361wrs.5;
        Sat, 08 Jun 2019 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ugquv+cQpSiI2Qu8XC8CXWcqfkSghoxUuZbFae3uhPE=;
        b=tpseAOirJpzZcaIdP0O3lk8ADXE5nTAhJAYEEypOy3rwNBAJifmiaa1lkBKFiB8Epd
         gXGbWnWJFJNliTOfkKeGKJyAFYM8giDZ0o8E/mG2d2xC5zr7VYteyQ2BVUvNCdTolGdE
         GCnwZiqoNGonQiDrr81fHNo2UnccHE6+ZQ/5B3RoLbNEkehICdEu1+5sa0SU8qqQimSq
         mODl/sdWTNMIkg1aA03wgUzqP3Pmq4LfD4H1JnpI3KS0CwsPzLr9ys6t74ginRiXf0QE
         lPZ4cA3U4Y9N07GZ36nOwZ52MF4WmMl0LPYRsmL2Rf6tD1ZKJtAWiBbykQbgxmOuSSKk
         cfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ugquv+cQpSiI2Qu8XC8CXWcqfkSghoxUuZbFae3uhPE=;
        b=Ty3b395k2jpG7my50NjO9rHN3zB/HItidbYl0Z6lMuu7j3fHwmocIJOV+uE5fagHm8
         PG80N5FQAKVDNSvoQCFnWac5qmNcpkcdwF0ax7sUh4DU6szIvuxGOKvBVZwYb7/1MyJJ
         7f9VHsFXDwgXZltaNRvd0kyXk4FUtcnS5D6kS4YMyXpDcsnRTf5waGBqocN/7Ms+x1Vg
         AusKUyOH2H7AMofyxPZbpB+GNwNWx+lQRokcg+mjzvPEdKxNzZ1UVhj73zyv2WPYaKhZ
         zcJgSS/yBQzQWKJMiHLG0lxYGFIM9hlLGwIc5RrlGs/frEUevSkYTIktIgL2V2mnGbYF
         ilsQ==
X-Gm-Message-State: APjAAAUPMOtpB/rIhVvDlexxlPTTmRZE3HCKLAOj/zAlbjdYCf0CGkxf
        CEWkmr+ldTM0zshpF2ihI+8=
X-Google-Smtp-Source: APXvYqzcqnRXXwVJkdzJSKVS39IDGQNSHq4J3r+dmbhJ1cq1hSj+iq9BgjqiZY4ybYxp+L7A5MTkig==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr11232468wrt.197.1560002246945;
        Sat, 08 Jun 2019 06:57:26 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id j132sm9423463wmj.21.2019.06.08.06.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 06:57:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] locks: eliminate false positive conflicts for write lease
Date:   Sat,  8 Jun 2019 16:57:17 +0300
Message-Id: <20190608135717.8472-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608135717.8472-1-amir73il@gmail.com>
References: <20190608135717.8472-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

check_conflicting_open() is checking for existing fd's open for read or
for write before allowing to take a write lease.  The check that was
implemented using i_count and d_count is an approximation that has
several false positives.  For example, overlayfs since v4.19, takes an
extra reference on the dentry; An open with O_PATH takes a reference on
the inode and dentry although the file cannot be read nor written.

Change the implementation to use inode_is_open_rdonly() and i_writecount
to eliminate the false positive conflicts and allow a write lease to be
taken on an overlayfs file.

The change of behavior with existing fd's open with O_PATH is symmetric
w.r.t. current behavior of lease breakers - an open with O_PATH currently
does not break a write lease.

Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/locks.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ec1e4a5df629..4937cfdf611a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1753,10 +1753,10 @@ int fcntl_getlease(struct file *filp)
 }
 
 /**
- * check_conflicting_open - see if the given dentry points to a file that has
+ * check_conflicting_open - see if the given file points to an inode that has
  *			    an existing open that would conflict with the
  *			    desired lease.
- * @dentry:	dentry to check
+ * @filp:	file to check
  * @arg:	type of lease that we're trying to acquire
  * @flags:	current lock flags
  *
@@ -1764,10 +1764,11 @@ int fcntl_getlease(struct file *filp)
  * conflict with the lease we're trying to set.
  */
 static int
-check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
+check_conflicting_open(struct file *filp, const long arg, int flags)
 {
 	int ret = 0;
-	struct inode *inode = dentry->d_inode;
+	struct inode *inode = locks_inode(filp);
+	int self_wcount = 0, self_rcount = 0;
 
 	if (flags & FL_LAYOUT)
 		return 0;
@@ -1775,8 +1776,14 @@ check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
 	if ((arg == F_RDLCK) && inode_is_open_for_write(inode))
 		return -EAGAIN;
 
-	if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
-	    (atomic_read(&inode->i_count) > 1)))
+	/* Make sure that only read/write count is from lease requestor */
+	if (filp->f_mode & FMODE_WRITE)
+		self_wcount = 1;
+	else if ((filp->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
+		self_rcount = 1;
+
+	if ((arg == F_WRLCK) && (i_readcount_read(inode) != self_rcount ||
+	     (atomic_read(&inode->i_writecount) != self_wcount)))
 		ret = -EAGAIN;
 
 	return ret;
@@ -1786,8 +1793,7 @@ static int
 generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
 {
 	struct file_lock *fl, *my_fl = NULL, *lease;
-	struct dentry *dentry = filp->f_path.dentry;
-	struct inode *inode = dentry->d_inode;
+	struct inode *inode = locks_inode(filp);
 	struct file_lock_context *ctx;
 	bool is_deleg = (*flp)->fl_flags & FL_DELEG;
 	int error;
@@ -1822,7 +1828,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(dentry, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->fl_flags);
 	if (error)
 		goto out;
 
@@ -1879,7 +1885,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
 	 * precedes these checks.
 	 */
 	smp_mb();
-	error = check_conflicting_open(dentry, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->fl_flags);
 	if (error) {
 		locks_unlink_lock_ctx(lease);
 		goto out;
-- 
2.17.1

