Return-Path: <linux-fsdevel+bounces-53867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7BAF84F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F513173F51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5072608;
	Fri,  4 Jul 2025 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2KRn6/P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2KRn6/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AF1A275
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589791; cv=none; b=OoodSkjQjtemJDdRAOSa5iX+G5WUz+QBbBAN+5TcMEE1sa6pwNqE8LPxCMEiA0YZtdphgPp3MvnaBvY5KLxtmj4Ow5H2H5vi+yUKneFXzGQmSX6xPKDDJ7z0lSiuVKvLstNq1e/KTiPVUzIu1/svFLCH9ms6Ug/6Lu4Vht/q4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589791; c=relaxed/simple;
	bh=TzHJLasz4cSNicNaEG0ztPqLTnWWR5p1o8pqfj8evjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An+HDa1Sy8Uy8ahdi9/rMzBUzFg6uhjZhZwZHDRxiwrsTauj7of1eRahwv+WDD//IIlQ7xGtH82i3+Jyb3cK7jigW0nCreAx6REqpQM3webFwW+cUxv+HRzJv9qIs0GrOLEu6orJ1EV4jUxz7/iSAFKs78iuMU5BpdPfTHg6PbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2KRn6/P; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2KRn6/P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 483941F454;
	Fri,  4 Jul 2025 00:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNBQNcm5C6Koa8GEcK9hI0fxIfRGT6mRA5QFGxYYMA0=;
	b=U2KRn6/PDO7rM6LdWJ6EJXkIgYii4NNwtgI6+Yw5GPzfNPMEXwcPuHJkCx98VedoVK6hgN
	JwKuakPnWTrhA9ntAJQTnOTGknvtB4x4n1UklTFZSZhWk91VJ/iX0qvflYH9e+GZxSUDpr
	heWSG0srMiml62vnKlV7+H1cBlZwtzo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="U2KRn6/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNBQNcm5C6Koa8GEcK9hI0fxIfRGT6mRA5QFGxYYMA0=;
	b=U2KRn6/PDO7rM6LdWJ6EJXkIgYii4NNwtgI6+Yw5GPzfNPMEXwcPuHJkCx98VedoVK6hgN
	JwKuakPnWTrhA9ntAJQTnOTGknvtB4x4n1UklTFZSZhWk91VJ/iX0qvflYH9e+GZxSUDpr
	heWSG0srMiml62vnKlV7+H1cBlZwtzo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88AB213757;
	Fri,  4 Jul 2025 00:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBjAEpMjZ2hMEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Jul 2025 00:42:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v4 3/6] btrfs: reject file operations if in shutdown state
Date: Fri,  4 Jul 2025 10:12:31 +0930
Message-ID: <e818baae5bc6c55ceb9ee6ae56fe1ddafea04ac8.1751589725.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751589725.git.wqu@suse.com>
References: <cover.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 483941F454
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

This includes the following callbacks of file_operations:

- read_iter()
- write_iter()
- mmap()
- open()
- remap_file_range()
- uring_cmd()
- splice_read()
  This requires a small wrapper to do the extra shutdown check, then call
  the regular filemap_splice_read() function

This should reject most of the file operations on a shutdown btrfs.

The callback ioctl() is intentionally skipped, as ext4 doesn't do the
shutdown check on ioctl() either, thus I believe there is some special
require for ioctl() callback even if the fs is fully shutdown.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c    | 25 ++++++++++++++++++++++++-
 fs/btrfs/ioctl.c   |  3 +++
 fs/btrfs/reflink.c |  3 +++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05b046c6806f..cb7d1d53fc13 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1419,6 +1419,8 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
 
+	if (unlikely(btrfs_is_shutdown(inode->root->fs_info)))
+		return -EIO;
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
 	 * have opened a file as writable, we have to stop this write operation
@@ -1981,6 +1983,8 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = filp->f_mapping;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(filp)))))
+		return -EIO;
 	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
@@ -3040,6 +3044,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	/* Do not allow fallocate in ZONED mode */
 	if (btrfs_is_zoned(inode_to_fs_info(inode)))
 		return -EOPNOTSUPP;
@@ -3731,6 +3738,9 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 
 	ret = fsverity_file_open(inode, filp);
@@ -3743,6 +3753,9 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(iocb->ki_filp)))))
+		return -EIO;
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0 || !iov_iter_count(to) ||
@@ -3753,10 +3766,20 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return filemap_read(iocb, to, ret);
 }
 
+static ssize_t btrfs_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(in)))))
+		return -EIO;
+
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
 	.read_iter      = btrfs_file_read_iter,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= btrfs_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.splice_write	= iter_file_splice_write,
 	.mmap		= btrfs_file_mmap,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 503c469249e5..2f3b7be13bea 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5048,6 +5048,9 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(cmd->file)))))
+		return -EIO;
+
 	switch (cmd->cmd_op) {
 	case BTRFS_IOC_ENCODED_READ:
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 0197bd9160a7..123a5682514b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -869,6 +869,9 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	bool same_inode = dst_inode == src_inode;
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(src_file)))))
+		return -EIO;
+
 	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
-- 
2.50.0


