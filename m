Return-Path: <linux-fsdevel+bounces-25345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547794AFC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C861EB2375D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED9144D0F;
	Wed,  7 Aug 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9154zgf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aP2LkDHv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9154zgf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aP2LkDHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364314388F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055412; cv=none; b=EGriPiRGKgN7kWRv2BsOeeCEoSpT0k8jQaRZnhJCGVJBbsb0PLqNpyG6Kig1mgPOB4jr6vj9yTasWgQ9kWbXFm0Lp6HaX5LnDN1MjmR4u7Xz83ozRn4Jj/o3SAFbpqNmRwXcjrMWjzWIxSVlijnXCq9s/4f5I+Qz5PlJCDkTuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055412; c=relaxed/simple;
	bh=LcL3BHzsZSUskp27VS2JLcjy7YZAv2wBS/LrWsqpkpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3NG9Hhq6leBIN+PCT9UP4k5DPWAHzhQ2YoiJ+CXLRe3tAXM3FUMKyY6j4qKyI7bIKc0DPAtlDJhxiyHV5H5w1uYMyrY8WcZAgMKvuYDh5mruguCttwQ5RT3SGtajhcTAmHPMVEBqOLwvrqCLjWpgcamd6b6CxBOVJWa62vxj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9154zgf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aP2LkDHv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9154zgf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aP2LkDHv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 868FC21CF8;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdXwsqLXfONFWUtMvQutXzXRdGwYALr88CknhQRoGfM=;
	b=i9154zgf+KTffLJGuSMnIrEvFdDmhyQJ9wYNCq6qSFrsyfcjcmW1B6RmtXU42P1kPOHvSB
	DBiHI8vQzMN9A3tt5gSjZHttTurKvloXs1eoFohTTUUs8fo0F2kUBfyVgGIOFmHjf0pwkz
	iWZ/TNbbjUgY5e6KN8fwwKdtFvS03HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdXwsqLXfONFWUtMvQutXzXRdGwYALr88CknhQRoGfM=;
	b=aP2LkDHvp+la3qCX8lzuHSzGaXz2GZcbSykcNfMxgmPfwVpE3D69gsZmkNEDQJePS02xTc
	L9ZC+0bP6c2Z+LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdXwsqLXfONFWUtMvQutXzXRdGwYALr88CknhQRoGfM=;
	b=i9154zgf+KTffLJGuSMnIrEvFdDmhyQJ9wYNCq6qSFrsyfcjcmW1B6RmtXU42P1kPOHvSB
	DBiHI8vQzMN9A3tt5gSjZHttTurKvloXs1eoFohTTUUs8fo0F2kUBfyVgGIOFmHjf0pwkz
	iWZ/TNbbjUgY5e6KN8fwwKdtFvS03HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdXwsqLXfONFWUtMvQutXzXRdGwYALr88CknhQRoGfM=;
	b=aP2LkDHvp+la3qCX8lzuHSzGaXz2GZcbSykcNfMxgmPfwVpE3D69gsZmkNEDQJePS02xTc
	L9ZC+0bP6c2Z+LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 784B913B15;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MXVeHSy9s2Z/NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8560A0893; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/13] fs: Teach callers of file_start_write() to handle errors
Date: Wed,  7 Aug 2024 20:29:54 +0200
Message-Id: <20240807183003.23562-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6709; i=jack@suse.cz; h=from:subject; bh=LcL3BHzsZSUskp27VS2JLcjy7YZAv2wBS/LrWsqpkpM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70hfABh09Hl32zEhViYc5oJcWa/zlUoDMStc2wE 9AsRNkOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9IQAKCRCcnaoHP2RA2S2UB/ 4tR/9vNEhr7XkTb74UcQ0tvnSthx2OzTamK6/ZmWEIg1gLVJ52IBaelusMwBsmnws5wdyqI/anK9oA dtYNL4oHD9zLvvQjgcTqUP8mkFW6NWvuHb0z6QKQ3archZmEoDDrdSLOWyezrj6Y6b1JdvaI1rVADE PmMAj6c/2+wg6wJGtr5CeARMuAKgCiFePLHgjsZ206IOZX8lqj7TqJXjWVtw//RMJz8lmod9+2vmR+ 3zYaFxkyENCxZWr+9vff76YBlBAJnZJtDFIWHYhhfSDe9mF/ePEEgdJpH8I3AYvfxD8PQrKhwubTIK wr9VkIiDmWAQJdWEadQ+QdqHy/WWga
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

sb_start_write() will be returning error on shutdown filesystem. Teach
callers of file_start_write() to handle the error.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/backing-file.c      |  4 +++-
 fs/btrfs/ioctl.c       |  4 +++-
 fs/coredump.c          |  4 +++-
 fs/open.c              |  4 +++-
 fs/read_write.c        | 20 +++++++++++++++-----
 fs/remap_range.c       |  4 +++-
 fs/splice.c            |  8 ++++++--
 fs/xfs/xfs_exchrange.c |  4 +++-
 include/linux/fs.h     |  5 +++--
 9 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index afb557446c27..3df3fb48cb42 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -308,7 +308,9 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 		return ret;
 
 	old_cred = override_creds(ctx->cred);
-	file_start_write(out);
+	ret = file_start_write(out);
+	if (ret)
+		return ret;
 	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
 	revert_creds(old_cred);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..4cadba17a5a3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4676,7 +4676,9 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 		goto out_iov;
 	kiocb.ki_pos = pos;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret < 0)
+		goto out_iov;
 
 	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
 	if (ret > 0)
diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3..aa24964dc1e4 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -763,7 +763,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (!dump_vma_snapshot(&cprm))
 			goto close_fail;
 
-		file_start_write(cprm.file);
+		retval = file_start_write(cprm.file);
+		if (retval)
+			goto close_fail;
 		core_dumped = binfmt->core_dump(&cprm);
 		/*
 		 * Ensures that file size is big enough to contain the current
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..4bce4ba776ab 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -330,7 +330,9 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (!file->f_op->fallocate)
 		return -EOPNOTSUPP;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret)
+		return ret;
 	ret = file->f_op->fallocate(file, mode, offset, len);
 
 	/*
diff --git a/fs/read_write.c b/fs/read_write.c
index 12996892bb1d..4d2831891e84 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -560,7 +560,9 @@ ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 	if (ret)
 		return ret;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret)
+		return ret;
 	ret =  __kernel_write(file, buf, count, pos);
 	file_end_write(file);
 	return ret;
@@ -583,7 +585,9 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 		return ret;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret)
+		return ret;
 	if (file->f_op->write)
 		ret = file->f_op->write(file, buf, count, pos);
 	else if (file->f_op->write_iter)
@@ -893,7 +897,9 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 	if (ret < 0)
 		return ret;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret)
+		return ret;
 	ret = do_iter_readv_writev(file, iter, ppos, WRITE, flags);
 	if (ret > 0)
 		fsnotify_modify(file);
@@ -968,7 +974,9 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	if (ret < 0)
 		goto out;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret < 0)
+		goto out;
 	if (file->f_op->write_iter)
 		ret = do_iter_readv_writev(file, &iter, pos, WRITE, flags);
 	else
@@ -1509,7 +1517,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (len == 0)
 		return 0;
 
-	file_start_write(file_out);
+	ret = file_start_write(file_out);
+	if (unlikely(ret))
+		return ret;
 
 	/*
 	 * Cloning is supported by more file systems, so we implement copy on
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 28246dfc8485..d1aa23c16f15 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -399,7 +399,9 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 	if (ret)
 		return ret;
 
-	file_start_write(file_out);
+	ret = file_start_write(file_out);
+	if (ret)
+		return ret;
 	ret = file_in->f_op->remap_file_range(file_in, pos_in,
 			file_out, pos_out, len, remap_flags);
 	file_end_write(file_out);
diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..5d66a4dc93fc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1160,7 +1160,9 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	struct file *file = sd->u.file;
 	long ret;
 
-	file_start_write(file);
+	ret = file_start_write(file);
+	if (ret)
+		return ret;
 	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
 	file_end_write(file);
 	return ret;
@@ -1350,7 +1352,9 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if (in->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		file_start_write(out);
+		ret = file_start_write(out);
+		if (unlikely(ret))
+			return ret;
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index c8a655c92c92..e4840cbbe276 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -756,7 +756,9 @@ xfs_exchange_range(
 	if (!(fxr->file2->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode2))
 		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME2;
 
-	file_start_write(fxr->file2);
+	ret = file_start_write(fxr->file2);
+	if (ret)
+		return ret;
 	ret = xfs_exchrange_contents(fxr);
 	file_end_write(fxr->file2);
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3ac37d9884f5..952f11170296 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2886,11 +2886,12 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
  * This is a variant of sb_start_write() which is a noop on non-regualr file.
  * Should be matched with a call to file_end_write().
  */
-static inline void file_start_write(struct file *file)
+static inline int __must_check file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
-		return;
+		return 0;
 	sb_start_write(file_inode(file)->i_sb);
+	return 0;
 }
 
 static inline bool file_start_write_trylock(struct file *file)
-- 
2.35.3


