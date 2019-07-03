Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8271E5ED47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCUOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 16:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCUOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:14:45 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223A0218A3;
        Wed,  3 Jul 2019 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562184883;
        bh=uDlAVAXYjXmm4B5M2nwWI+0/AJcHJT1oBoLLjIsPYBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edV+btjMBD2SL+cX2HjG9NAUVpkTZdnc27S8YV74/CAEz+PujugvTi9OrWKc3Umfk
         MDyG1ewzFQ008WFqmwbBgaZTVY0eyh1FrySTkTItwY1ICodG7TyTgKZ1fX6bgfVaH7
         S7Hcqp/OrvqWKg/p/i1Hjs1aFK9YeVHV9a3gxZXg=
Date:   Wed, 3 Jul 2019 13:14:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 10/17] fs-verity: implement FS_IOC_ENABLE_VERITY ioctl
Message-ID: <20190703201440.GB10080@gmail.com>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701153237.1777-11-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:32:30AM -0700, Eric Biggers wrote:
> +	err = mnt_want_write_file(filp);
> +	if (err) /* -EROFS */
> +		return err;
> +
> +	err = deny_write_access(filp);
> +	if (err) /* -ETXTBSY */
> +		goto out_drop_write;
> +
> +	inode_lock(inode);
> +
> +	if (IS_VERITY(inode)) {
> +		err = -EEXIST;
> +		goto out_unlock;
> +	}
> +
> +	err = enable_verity(filp, &arg);
> +	if (err)
> +		goto out_unlock;
> +
> +	/*
> +	 * Some pages of the file may have been evicted from pagecache after
> +	 * being used in the Merkle tree construction, then read into pagecache
> +	 * again by another process reading from the file concurrently.  Since
> +	 * these pages didn't undergo verification against the file measurement
> +	 * which fs-verity now claims to be enforcing, we have to wipe the
> +	 * pagecache to ensure that all future reads are verified.
> +	 */
> +	filemap_write_and_wait(inode->i_mapping);
> +	invalidate_inode_pages2(inode->i_mapping);
> +
> +	/*
> +	 * allow_write_access() is needed to pair with deny_write_access().
> +	 * Regardless, the filesystem won't allow writing to verity files.
> +	 */
> +out_unlock:
> +	inode_unlock(inode);
> +	allow_write_access(filp);
> +out_drop_write:
> +	mnt_drop_write_file(filp);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(fsverity_ioctl_enable);

FYI, I've been thinking about the use of inode_lock() here.  I don't think it's
good to hold it during the whole Merkle tree construction, since it means that
all syscalls that take the inode lock (e.g. chown(), chmod(), utimes()) will
block uninterruptibly.  E.g. 'touch file' hangs in the following:

	dd bs=1 count=0 seek=$((1<<40)) of=file
	fsverity enable file &
	touch file

It will proceed if you kill 'fsverity enable', but it's not ideal.

But AFAICS, it's safe to not hold the inode lock as long as we (a) keep using
deny_write_access() so that writes and truncates are not allowed (this is also
how the kernel handles files being executed), and (b) still take the inode lock
temporarily when beginning and ending enabling verity and enforce that only one
thread can build the Merkle tree at a time, and any other threads get EBUSY.

Does anyone have any objection to doing it that way instead?  I.e. basically the
following incremental patch:

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 3a7a44ba7bb771..395f299ce25ea5 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -147,6 +147,7 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
 - ``EBADMSG``: the signature is malformed
+- ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
 - ``EFAULT``: the caller provided inaccessible memory
 - ``EINTR``: the operation was interrupted by a fatal signal
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dd0d1093e362cb..bb0a3b8e6ea71e 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
 	handle_t *handle;
 	int err;
 
+	if (ext4_verity_in_progress(inode))
+		return -EBUSY;
+
 	/*
 	 * Since the file was opened readonly, we have to initialize the jbd
 	 * inode and quotas here and not rely on ->open() doing it.  This must
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 91184cecbade1c..2a33c765a56860 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -123,6 +123,9 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int err;
 
+	if (f2fs_verity_in_progress(inode))
+		return -EBUSY;
+
 	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
 		return -EOPNOTSUPP;
 
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index e9dca76fe5104f..a8430283a52a44 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -187,8 +187,6 @@ static int enable_verity(struct file *filp,
 
 	desc->data_size = cpu_to_le64(inode->i_size);
 
-	pr_debug("Building Merkle tree...\n");
-
 	/* Prepare the Merkle tree parameters */
 	err = fsverity_init_merkle_tree_params(&params, inode,
 					       arg->hash_algorithm,
@@ -197,12 +195,29 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
-	/* Tell the filesystem that verity is being enabled on the file */
-	err = vops->begin_enable_verity(filp);
+	/*
+	 * Start enabling verity on this file, serialized by the inode lock.
+	 * Fail if verity is already enabled or is already being enabled.
+	 */
+	inode_lock(inode);
+	if (IS_VERITY(inode))
+		err = -EEXIST;
+	else
+		err = vops->begin_enable_verity(filp);
+	inode_unlock(inode);
 	if (err)
 		goto out;
 
-	/* Build the Merkle tree */
+	/*
+	 * Build the Merkle tree.  Don't hold the inode lock during this, since
+	 * on huge files it may take a very long time and we don't want to force
+	 * unrelated syscalls like chown() to block forever.  We don't need the
+	 * inode lock because deny_write_access() already prevents the file from
+	 * being written to or truncated, and we still serialize
+	 * ->begin_enable_verity() and ->end_enable_verity() with the inode lock
+	 * and only allow one process to be here at a time.
+	 */
+	pr_debug("Building Merkle tree...\n");
 	BUILD_BUG_ON(sizeof(desc->root_hash) < FS_VERITY_MAX_DIGEST_SIZE);
 	err = build_merkle_tree(inode, &params, desc->root_hash);
 	if (err) {
@@ -229,8 +244,13 @@ static int enable_verity(struct file *filp,
 		pr_debug("Storing a %u-byte PKCS#7 signature alongside the file\n",
 			 arg->sig_size);
 
-	/* Tell the filesystem to finish enabling verity on the file */
+	/*
+	 * Tell the filesystem to finish enabling verity on the file.  The
+	 * inode_lock() serializes this with ->begin_enable_verity().
+	 */
+	inode_lock(inode);
 	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
+	inode_unlock(inode);
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
 			     vops->end_enable_verity, err);
@@ -254,7 +274,9 @@ static int enable_verity(struct file *filp,
 	return err;
 
 rollback:
+	inode_lock(inode);
 	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
+	inode_unlock(inode);
 	goto out;
 }
 
@@ -319,16 +341,9 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	if (err) /* -ETXTBSY */
 		goto out_drop_write;
 
-	inode_lock(inode);
-
-	if (IS_VERITY(inode)) {
-		err = -EEXIST;
-		goto out_unlock;
-	}
-
 	err = enable_verity(filp, &arg);
 	if (err)
-		goto out_unlock;
+		goto out_allow_write_access;
 
 	/*
 	 * Some pages of the file may have been evicted from pagecache after
@@ -345,8 +360,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	 * allow_write_access() is needed to pair with deny_write_access().
 	 * Regardless, the filesystem won't allow writing to verity files.
 	 */
-out_unlock:
-	inode_unlock(inode);
+out_allow_write_access:
 	allow_write_access(filp);
 out_drop_write:
 	mnt_drop_write_file(filp);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 9ebb97c174c7c4..e31a6b974ab0ef 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -23,7 +23,8 @@ struct fsverity_operations {
 	 * @filp: a readonly file descriptor for the file
 	 *
 	 * The filesystem must do any needed filesystem-specific preparations
-	 * for enabling verity, e.g. evicting inline data.
+	 * for enabling verity, e.g. evicting inline data.  It also must return
+	 * -EBUSY if verity is already being enabled on the given file.
 	 *
 	 * i_rwsem is held for write.
 	 *
@@ -46,7 +47,8 @@ struct fsverity_operations {
 	 * inode, e.g. setting a bit in the on-disk inode.  The filesystem is
 	 * also responsible for setting the S_VERITY flag in the VFS inode.
 	 *
-	 * i_rwsem is held for write.
+	 * i_rwsem is held for write, but it may have been dropped between the
+	 * calls to ->begin_enable_verity() and ->end_enable_verity().
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
@@ -96,7 +98,7 @@ struct fsverity_operations {
 	 * @log_blocksize: log base 2 of the Merkle tree block size
 	 *
 	 * This is only called between ->begin_enable_verity() and
-	 * ->end_enable_verity().  i_rwsem is held for write.
+	 * ->end_enable_verity().
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
