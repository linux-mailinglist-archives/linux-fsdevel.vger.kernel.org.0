Return-Path: <linux-fsdevel+bounces-54800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DAEB035BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BACB7ACC02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082C212FB6;
	Mon, 14 Jul 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f9Kt8aIk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f9Kt8aIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFE210F59
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470815; cv=none; b=IgZyzc6rfV1aK+XReESkosw9XiYUdsgqc2u2TCPLEt1Qmf55SXAKwVJAKsmEHwTzQlDHldDjA1Aav3o+4PKSOS5p3WmHLWr04MsooInio9yjDqf3KHozZWY9u+FtRwnlY7/L6NeesW4mD3CsNqLwni+DyxJetsOMmT/BEyXZ7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470815; c=relaxed/simple;
	bh=wWDGO7pzP9rCXMHMjoL4FMP5tS+sffm0fn5Zf5YTZoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGNL6euyQqcwGvtwOWLFOulaemStLCphieiJ1LCHelkST0HsKPizhJmkJ2tiX46rxv7qbYp9n+KD2qAYEPrOG+7O3CCErNqQdGlhKCwc5rE98QgJauROvOqq5vCEoQpmib+8N7YVh4M/vTmoEqY3zhZSwsX+T0glU49iVcmnXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f9Kt8aIk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f9Kt8aIk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C724221210;
	Mon, 14 Jul 2025 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MXsMkFFB/T7gW7HoVdhx3limpsAsokju8JTe977eA0=;
	b=f9Kt8aIkBkzF7dN9o2f/VCqiA+DGXjj8po1LK0Eej/HbLe5jB8riyEIv6uOvgIbGCDg0Ur
	5YcrB/oxATkQLcZDyQ3QHYKDT74S9GCSQcu8PctxTara6IRTIIecaeYIen0yiefToWFKm9
	VBF8+X7im3RZXqpPeFLHD0A8AzUUuuU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MXsMkFFB/T7gW7HoVdhx3limpsAsokju8JTe977eA0=;
	b=f9Kt8aIkBkzF7dN9o2f/VCqiA+DGXjj8po1LK0Eej/HbLe5jB8riyEIv6uOvgIbGCDg0Ur
	5YcrB/oxATkQLcZDyQ3QHYKDT74S9GCSQcu8PctxTara6IRTIIecaeYIen0yiefToWFKm9
	VBF8+X7im3RZXqpPeFLHD0A8AzUUuuU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE98C138A1;
	Mon, 14 Jul 2025 05:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADrdHwSVdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 3/6] btrfs: reject file operations if in shutdown state
Date: Mon, 14 Jul 2025 14:55:59 +0930
Message-ID: <2c7a5205f11aaa87041b2f220876ea6ff99c2084.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752470276.git.wqu@suse.com>
References: <cover.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index bc1e00db96c9..efcb9e6e34a3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1442,6 +1442,8 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
 
+	if (unlikely(btrfs_is_shutdown(inode->root->fs_info)))
+		return -EIO;
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
 	 * have opened a file as writable, we have to stop this write operation
@@ -2043,6 +2045,8 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = filp->f_mapping;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(filp)))))
+		return -EIO;
 	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
@@ -3102,6 +3106,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	/* Do not allow fallocate in ZONED mode */
 	if (btrfs_is_zoned(inode_to_fs_info(inode)))
 		return -EOPNOTSUPP;
@@ -3793,6 +3800,9 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 
 	ret = fsverity_file_open(inode, filp);
@@ -3805,6 +3815,9 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(iocb->ki_filp)))))
+		return -EIO;
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0 || !iov_iter_count(to) ||
@@ -3815,10 +3828,20 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
index 680c4e794e67..01d27f093eeb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5040,6 +5040,9 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(cmd->file)))))
+		return -EIO;
+
 	switch (cmd->cmd_op) {
 	case BTRFS_IOC_ENCODED_READ:
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ce25ab7f0e99..d88318ea31ba 100644
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


