Return-Path: <linux-fsdevel+bounces-31024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0B991040
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB361C239BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20CD1D90BD;
	Fri,  4 Oct 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L0kGluwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="01f9lBxJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L0kGluwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="01f9lBxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DC1D8DFC;
	Fri,  4 Oct 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072322; cv=none; b=p+3vpPEZVtqXDymy4XPS4yE1RgaNO3kiwU6G8sViOdXRwAZksiBXA2qWfrh331sleYNNcbRbimNjcD8AgEjO/rpOrZQxGi8jW3RGH5JsHp5nCwTvjxIzfy56TLz7UeOM4Tlnne0AGeau/4B1J9wdME1JtaQVNRySLBJ9oze+kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072322; c=relaxed/simple;
	bh=xFqljobrtngcrg1b+5fZW6YHgtWzCuFfuZzKFRW6P5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5Y4bLjzXqkHjNtvtx3zf5xUwmTgTq/hjgyPdEx5y/a6GsXnDSnk7dSak2wAj3A6/uWRS9884o3P2/sGjLhmNwI8NrJqJJyYyzu8JiiGpdVBiwiQgmeBF61nhznuYmges3AZxbFdo/nI2uhcsExFWpOxpe8J8eFRYjzOJFDVmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L0kGluwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=01f9lBxJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L0kGluwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=01f9lBxJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34B101F7B5;
	Fri,  4 Oct 2024 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgZFS3GNTLFgCUJGHY6skAlfe6CVirllKIEvQP2Avek=;
	b=L0kGluwxIBnp8uFJLoJ0sMx7CehoxO4PP7PRSpSRFfzdZ8ndzvYguE2wotBs4Bt0lxtp/2
	IjMQkWdX1GNbY7sQ0NLqQSFQItjCz0TSQ9faVne9YP1zVv22MdvJ/z6TsF5+bffERPWBr3
	Y8XOOYvhcItqerS7wMBJB00uZFL/76k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgZFS3GNTLFgCUJGHY6skAlfe6CVirllKIEvQP2Avek=;
	b=01f9lBxJJAaRbWMhZEJ9hdh/EZUy/SD7wB9dfLaY2eDxlMwfwj7l2CN7Nxp18tbX/G8zcv
	hEjjfN48rKbnOUBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L0kGluwx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=01f9lBxJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgZFS3GNTLFgCUJGHY6skAlfe6CVirllKIEvQP2Avek=;
	b=L0kGluwxIBnp8uFJLoJ0sMx7CehoxO4PP7PRSpSRFfzdZ8ndzvYguE2wotBs4Bt0lxtp/2
	IjMQkWdX1GNbY7sQ0NLqQSFQItjCz0TSQ9faVne9YP1zVv22MdvJ/z6TsF5+bffERPWBr3
	Y8XOOYvhcItqerS7wMBJB00uZFL/76k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgZFS3GNTLFgCUJGHY6skAlfe6CVirllKIEvQP2Avek=;
	b=01f9lBxJJAaRbWMhZEJ9hdh/EZUy/SD7wB9dfLaY2eDxlMwfwj7l2CN7Nxp18tbX/G8zcv
	hEjjfN48rKbnOUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F25EB13883;
	Fri,  4 Oct 2024 20:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ZdKNXxKAGfpRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:16 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 02/12] iomap: Introduce iomap_read_folio_ops
Date: Fri,  4 Oct 2024 16:04:29 -0400
Message-ID: <0bb16341dc43aa7102c1d959ebaecbf1b539e993.1728071257.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728071257.git.rgoldwyn@suse.com>
References: <cover.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34B101F7B5
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap_read_folio_ops provide additional functions to allocate or submit
the bio. Filesystems such as btrfs have additional operations with bios
such as verifying data checksums. Creating a bio submission hook allows
the filesystem to process and verify the bio.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/fops.c           |  4 ++--
 fs/erofs/data.c        |  4 ++--
 fs/gfs2/aops.c         |  4 ++--
 fs/iomap/buffered-io.c | 31 ++++++++++++++++++++++++-------
 fs/xfs/xfs_aops.c      |  4 ++--
 fs/zonefs/file.c       |  4 ++--
 include/linux/iomap.h  | 14 ++++++++++++--
 7 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49..41cbd8e5db11 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -483,12 +483,12 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
 }
 
 static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..335ce8be5894 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -347,12 +347,12 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 10d5acd3f742..3cc66b640cb9 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -451,7 +451,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -526,7 +526,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ad656f501f38..71370bbe466c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -341,6 +341,7 @@ struct iomap_readpage_ctx {
 	bool			cur_folio_in_bio;
 	struct bio		*bio;
 	struct readahead_control *rac;
+	const struct iomap_read_folio_ops *ops;
 };
 
 /**
@@ -424,8 +425,12 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		if (ctx->bio) {
+			if (ctx->ops && ctx->ops->submit_io)
+				ctx->ops->submit_io(iter->inode, ctx->bio);
+			else
+				submit_bio(ctx->bio);
+		}
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -475,7 +480,8 @@ static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
 	return done;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *read_folio_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
@@ -484,6 +490,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.cur_folio	= folio,
+		.ops		= read_folio_ops,
 	};
 	int ret;
 
@@ -493,7 +500,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		iter.processed = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ctx.bio) {
-		submit_bio(ctx.bio);
+		if (ctx.ops->submit_io)
+			ctx.ops->submit_io(iter.inode, ctx.bio);
+		else
+			submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_folio_in_bio);
@@ -538,6 +548,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @read_folio_ops: Function hooks for filesystems for special bio submissions
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -549,7 +560,8 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *read_folio_ops)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
@@ -558,6 +570,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
+		.ops	= read_folio_ops,
 	};
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
@@ -565,8 +578,12 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.processed = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
+	if (ctx.bio) {
+		if (ctx.ops && ctx.ops->submit_io)
+			ctx.ops->submit_io(iter.inode, ctx.bio);
+		else
+			submit_bio(ctx.bio);
+	}
 	if (ctx.cur_folio) {
 		if (!ctx.cur_folio_in_bio)
 			folio_unlock(ctx.cur_folio);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6dead20338e2..9a3221d738bd 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -517,14 +517,14 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 3b103715acc9..bf8db1ddd761 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..5b775213920e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,14 +256,24 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+struct iomap_read_folio_ops {
+	/*
+	 * Optional, allows the filesystem to perform a custom submission of
+	 * bio, such as csum calculations or multi-device bio split
+	 */
+	void (*submit_io)(struct inode *inode, struct bio *bio);
+};
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *);
+void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.46.1


