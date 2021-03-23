Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90D0345B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCWJpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCWJpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:45:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23040C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:45:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so20067521wrn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=42PObNwl+EGBWQzXnn9pfgxSs+/Qvnc0W0+cc7s3UJA=;
        b=IoCnL70/dw/vDH/eBOjYSXXK+ZyM9heQo4SENisgeZDodImzACX1f9HbR+9yJ3ryoY
         8HgoCE8PPZEENiJhGR/+IEfvJlTZErhg7W9VfTOsWMP2KGMvA1mm7ZTRH915CHEZzc8u
         z84shksludo+qrxR5UQ0jBYQW44jxDAR7Aq8bGNnm8ihod77FfST9ilgfyOT2yiK2i0D
         kzoolLI8od7iRVwPEDRJtxHly4pDr/CKEAhTn1j+NtJyAmpujpGdSSny6VRil2S9bJZu
         MZzit1ZTXJeE7YP0Qnx889lseRQHWP7g79mYFMNoa/3YQymidqmCBR4zhxID0G9twpCh
         W1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=42PObNwl+EGBWQzXnn9pfgxSs+/Qvnc0W0+cc7s3UJA=;
        b=kf19Jc9ARzeJHXfxNhW5aiOydXPwDcITzOtmpWP9G9dy+A+kJzzoabFZeqBndo4SLn
         0g7SBVuDMEEHBZT4yZMZoTqtOzhJ/1kcolhw09PqQMUYXSVlb0JBPYFJZVq1YWN8CasX
         vTYLKpVYZe9bvZ+kKiTuVSOuyJ0rUmu9tWibn7GR0XiZBPLJbpyFennd1355yBKeJizi
         GWx1mNRRJYKD0bIRUlc1oFFZBybtwJYK4Bs+kHus60Cpnnza0WKiZ9WqBkY2Spksan6j
         f8XNh7+1FP1xhR3fnR1kyNx2JIGfuBG7suN6hkZT+9GScG5cor7ze8gDNWnzuoA0rwwh
         0dNg==
X-Gm-Message-State: AOAM533JiER86NM3Ly8GVZ8kGaUMn8ii102/xd9xWeBZUIfu04luH2+/
        qXwDAg0VFnGxMz32WS4F2eY=
X-Google-Smtp-Source: ABdhPJyWb6OCj/UNVV9Al0VpE+IYk0bZPnc5eIYPKF6uBqk8MjGUxAuLLLSbPeQgw0WWNmbi4u+KJQ==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr3003000wrm.221.1616492721811;
        Tue, 23 Mar 2021 02:45:21 -0700 (PDT)
Received: from lpc (bzq-79-177-7-30.red.bezeqint.net. [79.177.7.30])
        by smtp.gmail.com with ESMTPSA id v13sm26093641wrt.45.2021.03.23.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:45:21 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:45:18 +0200
From:   Shachar Sharon <synarete@gmail.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.or
Subject: [PATCH] fuse: add FUSE_STATX
Message-ID: <YFm4rjXYXiboLgxv@lpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit a528d35e8bfc ("statx: Add a system call to make enhanced
file info available") kernel has statx(2) system call. This patch
implements FUSE_STATX as a superset of FUSE_GETATTR, which enables
user-space file-systems to report statx information; in particular,
creation (birth) time.

The newly added struct fuse_statx_timestamp has same members as
struct statx_timestamp, where 'sec' is __s64 and padded with reserved
field. Likewise, layout of struct fuse_statx follows struct statx,
including trailing spare place-holders, making it 240 bytes in size,
and struct fuse_statx_out 256 bytes in size. Due to difference in size
(strcut fuse_attr is only 88 bytes), FUSE_GETATTR is preferred over
FUSE_STATX unless request_mask has STATX_BTIME active.

With this patch:
  $ stat --format %w /path/to/fuse/fs/file
  2021-03-19 10:42:07.284912429 +0200

Tested with glibc-2.32 and coreutils-8.32 over 'voluta' user-space
file-system.

Signed-off-by: Shachar Sharon <synarete@gmail.com>
---
 fs/fuse/dir.c             | 161 ++++++++++++++++++++++++++++++++++----
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |  48 +++++++++++-
 3 files changed, 194 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 06a18700a845..aa33669b9fda 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -111,6 +111,11 @@ static u64 attr_timeout(struct fuse_attr_out *o)
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
+static u64 statx_timeout(struct fuse_statx_out *o)
+{
+	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+}
+
 u64 entry_attr_timeout(struct fuse_entry_out *o)
 {
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
@@ -1022,8 +1027,116 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 	stat->blksize = 1 << blkbits;
 }
 
-static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+static void fuse_fillattr2(struct inode *inode, struct fuse_attr *attr,
+			   struct fuse_statx *stx, struct kstat *stat)
+{
+	fuse_fillattr(inode, attr, stat);
+	stat->result_mask = stx->mask;
+	stat->attributes = stx->attributes;
+	stat->attributes_mask = stx->attributes_mask;
+	if (stx->mask & STATX_BTIME) {
+		stat->btime.tv_sec = stx->btime.sec;
+		stat->btime.tv_nsec = stx->btime.nsec;
+	}
+}
+
+static void fuse_statx_to_attr(struct fuse_statx *stx, struct fuse_attr *attr)
+{
+	attr->ino = stx->ino;
+	attr->size = stx->size;
+	attr->blocks = stx->blocks;
+	attr->atime = stx->atime.sec;
+	attr->mtime = stx->mtime.sec;
+	attr->ctime = stx->ctime.sec;
+	attr->atimensec = stx->atime.nsec;
+	attr->mtimensec = stx->mtime.nsec;
+	attr->ctimensec = stx->ctime.nsec;
+	attr->mode = stx->mode;
+	attr->nlink = stx->nlink;
+	attr->uid = stx->uid;
+	attr->gid = stx->gid;
+	attr->rdev = MKDEV(stx->rdev_major, stx->rdev_minor);
+	attr->blksize = stx->blksize;
+	attr->flags = stx->flags;
+}
+
+static int fuse_require_valid_attr(struct inode *inode, struct fuse_attr *attr)
+{
+	int ret = 0;
+
+	if (fuse_invalid_attr(attr) || (inode->i_mode ^ attr->mode) & S_IFMT) {
+		fuse_make_bad(inode);
+		ret = -EIO;
+	}
+	return ret;
+}
+
+static void fuse_getattr_inargs(struct inode *inode, struct file *file,
+				u32 *getattr_flags, u64 *fh)
+{
+	/* Directories have separate file-handle space */
+	if (file && S_ISREG(inode->i_mode)) {
+		struct fuse_file *ff = file->private_data;
+
+		*getattr_flags |= FUSE_GETATTR_FH;
+		*fh = ff->fh;
+	}
+}
+
+static int __fuse_do_statx(struct inode *inode, struct kstat *stat,
+			   struct file *file, u32 request_mask)
+{
+	int err;
+	struct fuse_attr attr;
+	struct fuse_statx_in inarg;
+	struct fuse_statx_out outarg;
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	u64 attr_version;
+
+	attr_version = fuse_get_attr_version(fm->fc);
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+	fuse_getattr_inargs(inode, file, &inarg.getattr_flags, &inarg.fh);
+	inarg.mask = request_mask | STATX_BASIC_STATS;
+	args.opcode = FUSE_STATX;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		goto no_statx;
+
+	if (err)
+		return err;
+
+	if ((outarg.attr.mask & STATX_BASIC_STATS) != STATX_BASIC_STATS)
+		goto no_statx;
+
+	fuse_statx_to_attr(&outarg.attr, &attr);
+	err = fuse_require_valid_attr(inode, &attr);
+	if (err)
+		return err;
+
+	fuse_change_attributes(inode, &attr,
+				statx_timeout(&outarg), attr_version);
+	if (stat)
+		fuse_fillattr2(inode, &attr, &outarg.attr, stat);
+
+	return err;
+
+no_statx:
+	fm->fc->no_statx = 1;
+	return -EINVAL;
+}
+
+static int __fuse_do_getattr(struct inode *inode, struct kstat *stat,
+			     struct file *file)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1036,13 +1149,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
-	/* Directories have separate file-handle space */
-	if (file && S_ISREG(inode->i_mode)) {
-		struct fuse_file *ff = file->private_data;
-
-		inarg.getattr_flags |= FUSE_GETATTR_FH;
-		inarg.fh = ff->fh;
-	}
+	fuse_getattr_inargs(inode, file, &inarg.getattr_flags, &inarg.fh);
 	args.opcode = FUSE_GETATTR;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1053,11 +1160,8 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
-		if (fuse_invalid_attr(&outarg.attr) ||
-		    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
-			fuse_make_bad(inode);
-			err = -EIO;
-		} else {
+		err = fuse_require_valid_attr(inode, &outarg.attr);
+		if (!err) {
 			fuse_change_attributes(inode, &outarg.attr,
 					       attr_timeout(&outarg),
 					       attr_version);
@@ -1068,11 +1172,31 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	return err;
 }
 
+static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
+			   struct file *file, u32 request_mask)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	if (fc->no_statx || fc->minor < 34 || !(request_mask & STATX_BTIME))
+		goto getattr;
+
+	err = __fuse_do_statx(inode, stat, file, request_mask);
+	if (err && fc->no_statx)
+		goto getattr;
+
+	return err;
+
+getattr:
+	return __fuse_do_getattr(inode, stat, file);
+}
+
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err = 0;
 	bool sync;
 
@@ -1082,12 +1206,14 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		sync = false;
 	else if (request_mask & READ_ONCE(fi->inval_mask))
 		sync = true;
+	else if (!fc->no_statx && (request_mask & STATX_BTIME))
+		sync = true;
 	else
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		err = fuse_do_getattr(inode, stat, file);
+		err = fuse_do_getattr(inode, stat, file, request_mask);
 	} else if (stat) {
 		generic_fillattr(&init_user_ns, inode, stat);
 		stat->mode = fi->orig_i_mode;
@@ -1235,7 +1361,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(inode, NULL, NULL, STATX_BASIC_STATS);
 }
 
 /*
@@ -1789,7 +1915,8 @@ static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			ret = fuse_do_getattr(inode, NULL, file,
+					      STATX_BASIC_STATS);
 			if (ret)
 				return ret;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63d97a15ffde..15cd1968aac9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -755,6 +755,9 @@ struct fuse_conn {
 	/* Auto-mount submounts announced by the server */
 	unsigned int auto_submounts:1;
 
+	/** Is statx not implemented by fs? */
+	unsigned int no_statx:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 54442612c48b..36ac3c40b922 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -179,6 +179,9 @@
  *  7.33
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
+ *
+ *  7.34
+ *  - add FUSE_STATX
  */
 
 #ifndef _LINUX_FUSE_H
@@ -214,7 +217,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 33
+#define FUSE_KERNEL_MINOR_VERSION 34
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -499,6 +502,7 @@ enum fuse_opcode {
 	FUSE_COPY_FILE_RANGE	= 47,
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
+	FUSE_STATX		= 50,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -957,4 +961,46 @@ struct fuse_removemapping_one {
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
 
+struct fuse_statx_timestamp {
+	int64_t		sec;
+	uint32_t	nsec;
+	int32_t		reserved;
+};
+
+struct fuse_statx {
+	uint32_t	mask;
+	uint32_t	blksize;
+	uint64_t	attributes;
+	uint32_t	nlink;
+	uint32_t	uid;
+	uint32_t	gid;
+	uint32_t	mode;
+	uint64_t	ino;
+	uint64_t	size;
+	uint64_t	blocks;
+	uint64_t	attributes_mask;
+	struct fuse_statx_timestamp atime;
+	struct fuse_statx_timestamp btime;
+	struct fuse_statx_timestamp ctime;
+	struct fuse_statx_timestamp mtime;
+	uint32_t	rdev_major;
+	uint32_t	rdev_minor;
+	uint32_t	flags;
+	uint32_t	padding;
+	uint64_t	spare[12];
+};
+
+struct fuse_statx_in {
+	uint32_t	getattr_flags;
+	uint32_t	mask;
+	uint64_t	fh;
+};
+
+struct fuse_statx_out {
+	uint64_t	attr_valid;
+	uint32_t	attr_valid_nsec;
+	uint32_t	dummy;
+	struct fuse_statx attr;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.26.3

