Return-Path: <linux-fsdevel+bounces-46702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE560A93F50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 23:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B5016F123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CC223316;
	Fri, 18 Apr 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzXUx/VM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9062868B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010400; cv=none; b=oglrMlyFdTGAi5VkIxZWQW9cz5Nw9pdi7+XP5A+Q9hqbqw/mwkYmmIAU+4TRTFOfoM1UjgLiaZu4tsaPYgWM2FBJyMyZ1HP6YS1+4qUv523L/pCux2zfWfvGkGhbWkVNTE/mSSwFkohuVVXbqQ11cAWDfiKRjyjBRYjUB9MCm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010400; c=relaxed/simple;
	bh=TmW0ZZ9IFxEwwblwEOGYlIc8RjXV+fEfzEH/1xVM6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1RVy9E/3lmQZTUguqJQJ8iUkE7CTdoM3Oi6F3aRkHtEjwqQiPH+1WIcyacMDjbzj906k24m64/1yJM9mBYKE1irq5OTlVESr2A+J/f7OOjfjeqsEYMg2L8stK9WTAPf1X9IQwmdBcx5/1vGiqpjwj6CTF9s9HBNcvpRUG+OJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzXUx/VM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so1890217a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745010397; x=1745615197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNJ4fGjTq18DhdCE7URm2F4Sm1I3e8JMWha+UGO08uc=;
        b=FzXUx/VM/O3MGc1L6Zc6BGtvSb97Ik8lgKcRzrPmaHWiQ6uuGA7fkfG3InLftWQRQy
         wXsMFB9tslzf8OKb+aKMJr3BJvrjzXKqPtebNeHpxqvL/MJi/UMkakft/dGAi6mS2Czu
         xHUJRsRJewphoW3maGtF/Hluu/LHdPjvGkiOh/pcx83tP/11G085Xdh/SPkTZvUNcnMY
         V61vJSLGvV4AA8kMxQhkdlQ6s4QHsRv98uE8/+1SpJUoNt1OKs5eTljKiT2jsps8DkEh
         hNRUM95ryK8rfj/SvdHoqAv5nRWA9wjKgcofBDaLj9cjGuBABaOwNeQKmLRZK4ckCVWo
         /LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745010397; x=1745615197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNJ4fGjTq18DhdCE7URm2F4Sm1I3e8JMWha+UGO08uc=;
        b=ve8pbhkOY7EqOBVW5zzxGay986D3zyTiWzCveo08XlKbgBpeHz6XgEEElEear7Jtg0
         B8KibT1Rvb9/YsnrdNFBo9i1X8tgpX7mSSb3x+wyN/nnR40GbjGHiW04HbgqAS7yfrnA
         BLDlMOt52Y6E3cfqyt3qvtxOMHrEIPTi9i0l+Ab9ccHKqvCYxLVGno6i01788UcyUcEA
         pg8kWNf3MkaQwJu+lijq0eDOKm4+jxCuAROpzKqNPh3pG5/8TUTacWUIyqNRILvqhHys
         jsXy9R9++KQTH7tF4pBUYcDR0s06pCnZZb0v56ovKyTVPKLtjEdnNIwKa9qjvXBMUWRM
         nkzA==
X-Gm-Message-State: AOJu0Yw8rbRC45b80W625oEYZREJvlvgekU43UjOTPB5Mh91o5XeVwoN
	Wi4MYO/3v0fi/2AX4PpjQLEPFz0WX2zKAETnCC6dYEab4JYmdpLc
X-Gm-Gg: ASbGncvr3mNV956cwqWfePI+KQrcequ1KhgceUN/nsb2uI6HPjpHufD5pB0gULmRUJ7
	nOAlgBWOuAHItH4gOiYBacfZE+LYeyGKtScmKtkhUul5i2gj+j7RbnY4erO3upBemFsQHLFhNH6
	TPmR5BhrHUQvjRrdjN5TLqe4sCx7kPOs2fnXgt/sfxyYDLo1mL/r7puxUdBRYtVAHuTE19XQNsM
	EqEcrQwiZQOAwPPkL1+20QCTYyGy8dTxxrbfyULmTA2oBwbN/t1DrpejeRHIEXUHMDtbA2dGKPg
	fq/F+lHn1wYlQzlMMEDvJKxwUhi5rUCEZc0=
X-Google-Smtp-Source: AGHT+IH0J25hFOSf5ic7eBAoFXgXkmIBx//RlMAvwDOU563LywFwDi7NdYkU7Dt0raHKjhfxBy2dng==
X-Received: by 2002:a17:90b:2e88:b0:2fe:b016:a6ac with SMTP id 98e67ed59e1d1-3087bb67c9bmr6300582a91.15.1745010397063;
        Fri, 18 Apr 2025 14:06:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecc432sm21204875ad.159.2025.04.18.14.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:06:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH 2/2] fuse: clean up struct fuse_conn bitfields
Date: Fri, 18 Apr 2025 14:06:17 -0700
Message-ID: <20250418210617.734152-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418210617.734152-1-joannelkoong@gmail.com>
References: <20250418210617.734152-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use boolean bitfields to improve clarity/readability and to be
consistent with bitfields in other fuse structs (eg fuse_fs_context,
fuse_args). Set bitfield values with true/false to improve readability.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/cuse.c      |   2 +-
 fs/fuse/dev.c       |  10 ++--
 fs/fuse/dev_uring.c |   4 +-
 fs/fuse/dir.c       |  16 +++---
 fs/fuse/file.c      |  18 +++----
 fs/fuse/fuse_i.h    | 122 ++++++++++++++++++++++----------------------
 fs/fuse/inode.c     |  76 +++++++++++++--------------
 fs/fuse/virtio_fs.c |   4 +-
 fs/fuse/xattr.c     |   8 +--
 9 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b39844d75a80..d5f926b4547c 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -523,7 +523,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 
 	INIT_LIST_HEAD(&cc->list);
 
-	cc->fc.initialized = 1;
+	cc->fc.initialized = true;
 	rc = cuse_send_init(cc);
 	if (rc) {
 		fuse_dev_free(fud);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 155bb6aeaef5..67d07b4c778a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -166,7 +166,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
 {
 	/* Make sure stores before this are seen on another CPU */
 	smp_wmb();
-	fc->initialized = 1;
+	fc->initialized = true;
 }
 
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
@@ -460,7 +460,7 @@ void fuse_request_end(struct fuse_req *req)
 		spin_lock(&fc->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
 		if (fc->num_background == fc->max_background) {
-			fc->blocked = 0;
+			fc->blocked = false;
 			wake_up(&fc->blocked_waitq);
 		} else if (!fc->blocked) {
 			/*
@@ -720,7 +720,7 @@ static int fuse_request_queue_background(struct fuse_req *req)
 	if (likely(fc->connected)) {
 		fc->num_background++;
 		if (fc->num_background == fc->max_background)
-			fc->blocked = 1;
+			fc->blocked = true;
 		list_add_tail(&req->list, &fc->bg_queue);
 		flush_bg_queue(fc);
 		queued = true;
@@ -2173,7 +2173,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		if (nbytes != sizeof(struct fuse_out_header))
 			err = -EINVAL;
 		else if (oh.error == -ENOSYS)
-			fc->no_interrupt = 1;
+			fc->no_interrupt = true;
 		else if (oh.error == -EAGAIN)
 			err = queue_interrupt(req);
 
@@ -2435,7 +2435,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 			spin_unlock(&fpq->lock);
 		}
 		spin_lock(&fc->bg_lock);
-		fc->blocked = 0;
+		fc->blocked = false;
 		fc->max_background = UINT_MAX;
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1..ef470c4a9261 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1169,7 +1169,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		if (err) {
 			pr_info_once("FUSE_IO_URING_CMD_REGISTER failed err=%d\n",
 				     err);
-			fc->io_uring = 0;
+			fc->io_uring = false;
 			wake_up_all(&fc->blocked_waitq);
 			return err;
 		}
@@ -1325,7 +1325,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	spin_lock(&fc->bg_lock);
 	fc->num_background++;
 	if (fc->num_background == fc->max_background)
-		fc->blocked = 1;
+		fc->blocked = true;
 	fuse_uring_flush_bg(queue);
 	spin_unlock(&fc->bg_lock);
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1fb0b15a6088..25e06c73f83b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -774,7 +774,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
-		fc->no_create = 1;
+		fc->no_create = true;
 		goto mknod;
 	} else if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
@@ -923,7 +923,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	err = fuse_create_open(idmap, dir, file->f_path.dentry, file,
 			       file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
-		fc->no_tmpfile = 1;
+		fc->no_tmpfile = true;
 		err = -EOPNOTSUPP;
 	}
 	return err;
@@ -1133,7 +1133,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 					 FUSE_RENAME2,
 					 sizeof(struct fuse_rename2_in));
 		if (err == -ENOSYS) {
-			fc->no_rename2 = 1;
+			fc->no_rename2 = true;
 			err = -EINVAL;
 		}
 	} else {
@@ -1172,7 +1172,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 		fuse_invalidate_attr(inode);
 
 	if (err == -ENOSYS)
-		fm->fc->no_link = 1;
+		fm->fc->no_link = true;
 out:
 	if (fm->fc->no_link)
 		return -EPERM;
@@ -1376,7 +1376,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {
-				fc->no_statx = 1;
+				fc->no_statx = true;
 				err = 0;
 				goto retry;
 			}
@@ -1521,7 +1521,7 @@ static int fuse_access(struct inode *inode, int mask)
 	/*
 	 * We should not send FUSE_ACCESS to the userspace
 	 * when idmapped mounts are enabled as for this case
-	 * we have fc->default_permissions = 1 and access
+	 * we have fc->default_permissions = true and access
 	 * permission checks are done on the kernel side.
 	 */
 	WARN_ON_ONCE(!(fm->sb->s_iflags & SB_I_NOIDMAP));
@@ -1538,7 +1538,7 @@ static int fuse_access(struct inode *inode, int mask)
 	args.in_args[0].value = &inarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_access = 1;
+		fm->fc->no_access = true;
 		err = 0;
 	}
 	return err;
@@ -1754,7 +1754,7 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	inode_lock(inode);
 	err = fuse_fsync_common(file, start, end, datasync, FUSE_FSYNCDIR);
 	if (err == -ENOSYS) {
-		fc->no_fsyncdir = 1;
+		fc->no_fsyncdir = true;
 		err = 0;
 	}
 	inode_unlock(inode);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e203dd4fcc0f..f8ca57cebc3b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -155,9 +155,9 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			kfree(ff->args);
 			ff->args = NULL;
 			if (isdir)
-				fc->no_opendir = 1;
+				fc->no_opendir = true;
 			else
-				fc->no_open = 1;
+				fc->no_open = true;
 		}
 	}
 
@@ -474,7 +474,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_flush = 1;
+		fm->fc->no_flush = true;
 		err = 0;
 	}
 
@@ -549,7 +549,7 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 
 	err = fuse_fsync_common(file, start, end, datasync, FUSE_FSYNC);
 	if (err == -ENOSYS) {
-		fc->no_fsync = 1;
+		fc->no_fsync = true;
 		err = 0;
 	}
 out:
@@ -2548,7 +2548,7 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS)
-		fm->fc->no_bmap = 1;
+		fm->fc->no_bmap = true;
 
 	return err ? 0 : outarg.block;
 }
@@ -2581,7 +2581,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	err = fuse_simple_request(fm, &args);
 	if (err) {
 		if (err == -ENOSYS) {
-			fm->fc->no_lseek = 1;
+			fm->fc->no_lseek = true;
 			goto fallback;
 		}
 		return err;
@@ -2716,7 +2716,7 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	if (!err)
 		return demangle_poll(outarg.revents);
 	if (err == -ENOSYS) {
-		fm->fc->no_poll = 1;
+		fm->fc->no_poll = true;
 		return DEFAULT_POLLMASK;
 	}
 	return EPOLLERR;
@@ -2935,7 +2935,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	args.in_args[0].value = &inarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_fallocate = 1;
+		fm->fc->no_fallocate = true;
 		err = -EOPNOTSUPP;
 	}
 	if (err)
@@ -3047,7 +3047,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fc->no_copy_file_range = 1;
+		fc->no_copy_file_range = true;
 		err = -EOPNOTSUPP;
 	}
 	if (err)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6aecada8aadd..3d5289cb82a5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -699,12 +699,12 @@ struct fuse_conn {
 
 	/** Flag indicating that INIT reply has been received. Allocating
 	 * any fuse request will be suspended until the flag is set */
-	int initialized:1;
+	bool initialized:1;
 
 	/** Flag indicating if connection is blocked.  This will be
 	    the case before the INIT reply is received, and if there
 	    are too many outstanding backgrounds requests */
-	int blocked:1;
+	bool blocked:1;
 
 	/** Connection aborted via sysfs */
 	bool aborted:1;
@@ -712,37 +712,37 @@ struct fuse_conn {
 	/** Connection failed (version mismatch).  Cannot race with
 	    setting other bitfields since it is only set once in INIT
 	    reply, before any other request, and never cleared */
-	unsigned conn_error:1;
+	bool conn_error:1;
 
 	/** Connection successful.  Only set in INIT */
-	unsigned conn_init:1;
+	bool conn_init:1;
 
 	/** Do readahead asynchronously?  Only set in INIT */
-	unsigned async_read:1;
+	bool async_read:1;
 
 	/** Return an unique read error after abort.  Only set in INIT */
-	unsigned abort_err:1;
+	bool abort_err:1;
 
 	/** Do not send separate SETATTR request before open(O_TRUNC)  */
-	unsigned atomic_o_trunc:1;
+	bool atomic_o_trunc:1;
 
 	/** Filesystem supports NFS exporting.  Only set in INIT */
-	unsigned export_support:1;
+	bool export_support:1;
 
 	/** write-back cache policy (default is write-through) */
-	unsigned writeback_cache:1;
+	bool writeback_cache:1;
 
 	/** allow parallel lookups and readdir (default is serialized) */
-	unsigned parallel_dirops:1;
+	bool parallel_dirops:1;
 
 	/** handle fs handles killing suid/sgid/cap on write/chown/trunc */
-	unsigned handle_killpriv:1;
+	bool handle_killpriv:1;
 
 	/** cache READLINK responses in page cache */
-	unsigned cache_symlinks:1;
+	bool cache_symlinks:1;
 
 	/* show legacy mount options */
-	unsigned int legacy_opts_show:1;
+	bool legacy_opts_show:1;
 
 	/*
 	 * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
@@ -750,7 +750,7 @@ struct fuse_conn {
 	 * on write/truncate only if caller did not have CAP_FSETID as well as
 	 * file has group execute permission.
 	 */
-	unsigned handle_killpriv_v2:1;
+	bool handle_killpriv_v2:1;
 
 	/*
 	 * The following bitfields are only for optimization purposes
@@ -758,145 +758,145 @@ struct fuse_conn {
 	 */
 
 	/** Is open/release not implemented by fs? */
-	unsigned no_open:1;
+	bool no_open:1;
 
 	/** Is opendir/releasedir not implemented by fs? */
-	unsigned no_opendir:1;
+	bool no_opendir:1;
 
 	/** Is fsync not implemented by fs? */
-	unsigned no_fsync:1;
+	bool no_fsync:1;
 
 	/** Is fsyncdir not implemented by fs? */
-	unsigned no_fsyncdir:1;
+	bool no_fsyncdir:1;
 
 	/** Is flush not implemented by fs? */
-	unsigned no_flush:1;
+	bool no_flush:1;
 
 	/** Is setxattr not implemented by fs? */
-	unsigned no_setxattr:1;
+	bool no_setxattr:1;
 
 	/** Does file server support extended setxattr */
-	unsigned setxattr_ext:1;
+	bool setxattr_ext:1;
 
 	/** Is getxattr not implemented by fs? */
-	unsigned no_getxattr:1;
+	bool no_getxattr:1;
 
 	/** Is listxattr not implemented by fs? */
-	unsigned no_listxattr:1;
+	bool no_listxattr:1;
 
 	/** Is removexattr not implemented by fs? */
-	unsigned no_removexattr:1;
+	bool no_removexattr:1;
 
 	/** Are posix file locking primitives not implemented by fs? */
-	unsigned no_lock:1;
+	bool no_lock:1;
 
 	/** Is access not implemented by fs? */
-	unsigned no_access:1;
+	bool no_access:1;
 
 	/** Is create not implemented by fs? */
-	unsigned no_create:1;
+	bool no_create:1;
 
 	/** Is interrupt not implemented by fs? */
-	unsigned no_interrupt:1;
+	bool no_interrupt:1;
 
 	/** Is bmap not implemented by fs? */
-	unsigned no_bmap:1;
+	bool no_bmap:1;
 
 	/** Is poll not implemented by fs? */
-	unsigned no_poll:1;
+	bool no_poll:1;
 
 	/** Do multi-page cached writes */
-	unsigned big_writes:1;
+	bool big_writes:1;
 
 	/** Don't apply umask to creation modes */
-	unsigned dont_mask:1;
+	bool dont_mask:1;
 
 	/** Are BSD file locking primitives not implemented by fs? */
-	unsigned no_flock:1;
+	bool no_flock:1;
 
 	/** Is fallocate not implemented by fs? */
-	unsigned no_fallocate:1;
+	bool no_fallocate:1;
 
 	/** Is rename with flags implemented by fs? */
-	unsigned no_rename2:1;
+	bool no_rename2:1;
 
 	/** Use enhanced/automatic page cache invalidation. */
-	unsigned auto_inval_data:1;
+	bool auto_inval_data:1;
 
 	/** Filesystem is fully responsible for page cache invalidation. */
-	unsigned explicit_inval_data:1;
+	bool explicit_inval_data:1;
 
 	/** Does the filesystem support readdirplus? */
-	unsigned do_readdirplus:1;
+	bool do_readdirplus:1;
 
 	/** Does the filesystem want adaptive readdirplus? */
-	unsigned readdirplus_auto:1;
+	bool readdirplus_auto:1;
 
 	/** Does the filesystem support asynchronous direct-IO submission? */
-	unsigned async_dio:1;
+	bool async_dio:1;
 
 	/** Is lseek not implemented by fs? */
-	unsigned no_lseek:1;
+	bool no_lseek:1;
 
 	/** Does the filesystem support posix acls? */
-	unsigned posix_acl:1;
+	bool posix_acl:1;
 
 	/** Check permissions based on the file mode or not? */
-	unsigned default_permissions:1;
+	bool default_permissions:1;
 
 	/** Allow other than the mounter user to access the filesystem ? */
-	unsigned allow_other:1;
+	bool allow_other:1;
 
 	/** Does the filesystem support copy_file_range? */
-	unsigned no_copy_file_range:1;
+	bool no_copy_file_range:1;
 
 	/* Send DESTROY request */
-	unsigned int destroy:1;
+	bool destroy:1;
 
 	/* Delete dentries that have gone stale */
-	unsigned int delete_stale:1;
+	bool delete_stale:1;
 
 	/** Do not create entry in fusectl fs */
-	unsigned int no_control:1;
+	bool no_control:1;
 
 	/** Do not allow MNT_FORCE umount */
-	unsigned int no_force_umount:1;
+	bool no_force_umount:1;
 
 	/* Auto-mount submounts announced by the server */
-	unsigned int auto_submounts:1;
+	bool auto_submounts:1;
 
 	/* Propagate syncfs() to server */
-	unsigned int sync_fs:1;
+	bool sync_fs:1;
 
 	/* Initialize security xattrs when creating a new inode */
-	unsigned int init_security:1;
+	bool init_security:1;
 
 	/* Add supplementary group info when creating a new inode */
-	unsigned int create_supp_group:1;
+	bool create_supp_group:1;
 
 	/* Does the filesystem support per inode DAX? */
-	unsigned int inode_dax:1;
+	bool inode_dax:1;
 
 	/* Is tmpfile not implemented by fs? */
-	unsigned int no_tmpfile:1;
+	bool no_tmpfile:1;
 
 	/* Relax restrictions to allow shared mmap in FOPEN_DIRECT_IO mode */
-	unsigned int direct_io_allow_mmap:1;
+	bool direct_io_allow_mmap:1;
 
 	/* Is statx not implemented by fs? */
-	unsigned int no_statx:1;
+	bool no_statx:1;
 
 	/** Passthrough support for read/write IO */
-	unsigned int passthrough:1;
+	bool passthrough:1;
 
 	/* Use pages instead of pointer for kernel I/O */
-	unsigned int use_pages_for_kvec_io:1;
+	bool use_pages_for_kvec_io:1;
 
 	/* Is link not implemented by fs? */
-	unsigned int no_link:1;
+	bool no_link:1;
 
 	/* Use io_uring for communication */
-	unsigned int io_uring:1;
+	bool io_uring:1;
 
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..43b6643635ee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -751,7 +751,7 @@ static int fuse_sync_fs(struct super_block *sb, int wait)
 
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fc->sync_fs = 0;
+		fc->sync_fs = false;
 		err = 0;
 	}
 
@@ -973,9 +973,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
 	atomic64_set(&fc->khctr, 0);
 	fc->polled_files = RB_ROOT;
-	fc->blocked = 0;
-	fc->initialized = 0;
-	fc->connected = 1;
+	fc->blocked = false;
+	fc->initialized = false;
+	fc->connected = true;
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
@@ -1323,54 +1323,54 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-				fc->async_read = 1;
+				fc->async_read = true;
 			if (!(flags & FUSE_POSIX_LOCKS))
-				fc->no_lock = 1;
+				fc->no_lock = true;
 			if (arg->minor >= 17) {
 				if (!(flags & FUSE_FLOCK_LOCKS))
-					fc->no_flock = 1;
+					fc->no_flock = true;
 			} else {
 				if (!(flags & FUSE_POSIX_LOCKS))
-					fc->no_flock = 1;
+					fc->no_flock = true;
 			}
 			if (flags & FUSE_ATOMIC_O_TRUNC)
-				fc->atomic_o_trunc = 1;
+				fc->atomic_o_trunc = true;
 			if (arg->minor >= 9) {
 				/* LOOKUP has dependency on proto version */
 				if (flags & FUSE_EXPORT_SUPPORT)
-					fc->export_support = 1;
+					fc->export_support = true;
 			}
 			if (flags & FUSE_BIG_WRITES)
-				fc->big_writes = 1;
+				fc->big_writes = true;
 			if (flags & FUSE_DONT_MASK)
-				fc->dont_mask = 1;
+				fc->dont_mask = true;
 			if (flags & FUSE_AUTO_INVAL_DATA)
-				fc->auto_inval_data = 1;
+				fc->auto_inval_data = true;
 			else if (flags & FUSE_EXPLICIT_INVAL_DATA)
-				fc->explicit_inval_data = 1;
+				fc->explicit_inval_data = true;
 			if (flags & FUSE_DO_READDIRPLUS) {
-				fc->do_readdirplus = 1;
+				fc->do_readdirplus = true;
 				if (flags & FUSE_READDIRPLUS_AUTO)
-					fc->readdirplus_auto = 1;
+					fc->readdirplus_auto = true;
 			}
 			if (flags & FUSE_ASYNC_DIO)
-				fc->async_dio = 1;
+				fc->async_dio = true;
 			if (flags & FUSE_WRITEBACK_CACHE)
-				fc->writeback_cache = 1;
+				fc->writeback_cache = true;
 			if (flags & FUSE_PARALLEL_DIROPS)
-				fc->parallel_dirops = 1;
+				fc->parallel_dirops = true;
 			if (flags & FUSE_HANDLE_KILLPRIV)
-				fc->handle_killpriv = 1;
+				fc->handle_killpriv = true;
 			if (arg->time_gran && arg->time_gran <= 1000000000)
 				fm->sb->s_time_gran = arg->time_gran;
 			if ((flags & FUSE_POSIX_ACL)) {
-				fc->default_permissions = 1;
-				fc->posix_acl = 1;
+				fc->default_permissions = true;
+				fc->posix_acl = true;
 			}
 			if (flags & FUSE_CACHE_SYMLINKS)
-				fc->cache_symlinks = 1;
+				fc->cache_symlinks = true;
 			if (flags & FUSE_ABORT_ERROR)
-				fc->abort_err = 1;
+				fc->abort_err = true;
 			if (flags & FUSE_MAX_PAGES) {
 				fc->max_pages =
 					min_t(unsigned int, fc->max_pages_limit,
@@ -1389,20 +1389,20 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					ok = false;
 				}
 				if (flags & FUSE_HAS_INODE_DAX)
-					fc->inode_dax = 1;
+					fc->inode_dax = true;
 			}
 			if (flags & FUSE_HANDLE_KILLPRIV_V2) {
-				fc->handle_killpriv_v2 = 1;
+				fc->handle_killpriv_v2 = true;
 				fm->sb->s_flags |= SB_NOSEC;
 			}
 			if (flags & FUSE_SETXATTR_EXT)
-				fc->setxattr_ext = 1;
+				fc->setxattr_ext = true;
 			if (flags & FUSE_SECURITY_CTX)
-				fc->init_security = 1;
+				fc->init_security = true;
 			if (flags & FUSE_CREATE_SUPP_GROUP)
-				fc->create_supp_group = 1;
+				fc->create_supp_group = true;
 			if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
-				fc->direct_io_allow_mmap = 1;
+				fc->direct_io_allow_mmap = true;
 			/*
 			 * max_stack_depth is the max stack depth of FUSE fs,
 			 * so it has to be at least 1 to support passthrough
@@ -1422,7 +1422,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			    arg->max_stack_depth > 0 &&
 			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH &&
 			    !(flags & FUSE_WRITEBACK_CACHE))  {
-				fc->passthrough = 1;
+				fc->passthrough = true;
 				fc->max_stack_depth = arg->max_stack_depth;
 				fm->sb->s_stack_depth = arg->max_stack_depth;
 			}
@@ -1435,14 +1435,14 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					ok = false;
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
-				fc->io_uring = 1;
+				fc->io_uring = true;
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
-			fc->no_lock = 1;
-			fc->no_flock = 1;
+			fc->no_lock = true;
+			fc->no_flock = true;
 		}
 
 		init_server_timeout(fc, timeout);
@@ -1452,13 +1452,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
-		fc->conn_init = 1;
+		fc->conn_init = true;
 	}
 	kfree(ia);
 
 	if (!ok) {
-		fc->conn_init = 0;
-		fc->conn_error = 1;
+		fc->conn_init = false;
+		fc->conn_error = true;
 	}
 
 	fuse_set_initialized(fc);
@@ -1835,7 +1835,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	/* Handle umasking inside the fuse code */
 	if (sb->s_flags & SB_POSIXACL)
-		fc->dont_mask = 1;
+		fc->dont_mask = true;
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2c7b24cb67ad..d7b0f7f288e3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1531,8 +1531,8 @@ static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 {
 	ctx->rootmode = S_IFDIR;
-	ctx->default_permissions = 1;
-	ctx->allow_other = 1;
+	ctx->default_permissions = true;
+	ctx->allow_other = true;
 	ctx->max_read = UINT_MAX;
 	ctx->blksize = 512;
 	ctx->destroy = true;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 93dfb06b6cea..73100df1b24b 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -39,7 +39,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	args.in_args[2].value = value;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_setxattr = 1;
+		fm->fc->no_setxattr = true;
 		err = -EOPNOTSUPP;
 	}
 	if (!err)
@@ -83,7 +83,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	if (!ret && !size)
 		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
-		fm->fc->no_getxattr = 1;
+		fm->fc->no_getxattr = true;
 		ret = -EOPNOTSUPP;
 	}
 	return ret;
@@ -147,7 +147,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {
-		fm->fc->no_listxattr = 1;
+		fm->fc->no_listxattr = true;
 		ret = -EOPNOTSUPP;
 	}
 	return ret;
@@ -170,7 +170,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 	args.in_args[1].value = name;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_removexattr = 1;
+		fm->fc->no_removexattr = true;
 		err = -EOPNOTSUPP;
 	}
 	if (!err)
-- 
2.47.1


