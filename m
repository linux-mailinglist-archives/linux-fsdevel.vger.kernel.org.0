Return-Path: <linux-fsdevel+bounces-32359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD89A4305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA19287605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922F202640;
	Fri, 18 Oct 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q/46ysZs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OfGQEtiG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uv/AQojz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F7q2W6Kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03F165EFC;
	Fri, 18 Oct 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266962; cv=none; b=eksz4SsER2hxhPZ1K2Ll/JZRwgyQXgTJ1yPUwR64NYMGBjrd4Zw/Sv2/NUjJvlsIQ20P1wrHNlfatGQAKwqlFTkafSDvlqJ0qA47LFmwtnTp5wwKPExBoxqd3D6hLzNGGVwdyLm3P7zxZ6jWnkhFiyIID7F3anlTIciFxKC8WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266962; c=relaxed/simple;
	bh=mzdF4Z+AYm4onIUjlaq/BOs4aeUbImE1nxsfhZ4LMF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IvebDlt1FVtpy912VICP0PYqveA8qQYooPNbgoRfaBMEZR3X5XsorvxzCDp2tLOr4Za5F3Dtgio7xihy4/w+7j9T8MlUWGRU7Sk9lfIqewq1JOOqqVS18AHltW7xE74C/1il45cuS9oYlE3/PXtRL+B47vQjgj06ANeUHRxt4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q/46ysZs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OfGQEtiG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uv/AQojz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F7q2W6Kl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6032721CC0;
	Fri, 18 Oct 2024 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729266957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OCBmksGnjAHAm7dBBbultPZCd4jnr3Q8BRqGtT7HV9Y=;
	b=Q/46ysZsSCuItvouRHtQT3Tkrjes9AC+RAcrBED/Mfp5sE7jTXxYhibY/J+6XPH9F9R8J9
	W5mzeHAWI2wDJaS6T+x+6dwVi8N9uTPDluc7IVELMqDM+/4kK9lfRjkDFKw7ESVSlYivi0
	6k555zYkyTztUhSjslJX8uZ/PVmzMRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729266957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OCBmksGnjAHAm7dBBbultPZCd4jnr3Q8BRqGtT7HV9Y=;
	b=OfGQEtiG/ycz0FGXECa0+mASyRCC1b10mbXrVKMRmOmLNOu18Anvb4rUj75padTHMOrfrs
	nA6DoVsim3isRyCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uv/AQojz";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F7q2W6Kl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729266956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OCBmksGnjAHAm7dBBbultPZCd4jnr3Q8BRqGtT7HV9Y=;
	b=uv/AQojzO+QXyfHq1hpKtHxwWQtiuBrZwA5M0NqD9drbtxDTbom2nuvdCFjiFdwNPPGYR9
	bOUqBUsL9Y54n2bIAOi8aQdpgz4ulheBfQlesYSkMx4f5LGwV0nC4id5gDZdrxdxECkfTM
	c1M4IuxtcWGUOpLjqR0/nA2GrKFDm2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729266956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OCBmksGnjAHAm7dBBbultPZCd4jnr3Q8BRqGtT7HV9Y=;
	b=F7q2W6KlpiRYkF4qjPtL35fEymdvya5MSaV54sHyLflqNl8XVabQBDRHVU83Fkeg6pQwQ9
	nVoqxtXAXCgNocBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ADC713680;
	Fri, 18 Oct 2024 15:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 92/LAAyFEmdMUAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 18 Oct 2024 15:55:56 +0000
Date: Fri, 18 Oct 2024 11:55:50 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-block@vger.kernel.org
Subject: [PATCH] iomap: writeback_control pointer part of iomap_writepage_ctx
Message-ID: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 6032721CC0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Reduces the number of arguments to functions iomap_writepages() and
all functions in the writeback path which require both wpc and wbc.
The filesystems need to initialize wpc with wbc before calling
iomap_writepages().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/fops.c           |  6 ++++--
 fs/gfs2/aops.c         |  6 ++++--
 fs/iomap/buffered-io.c | 31 +++++++++++++++----------------
 fs/xfs/xfs_aops.c      |  8 ++++++--
 fs/zonefs/file.c       |  6 ++++--
 include/linux/iomap.h  |  3 ++-
 6 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e696ae53bf1e..3425bb72e887 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -513,9 +513,11 @@ static const struct iomap_writeback_ops blkdev_writeback_ops = {
 static int blkdev_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.wbc	=	wbc,
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
+	return iomap_writepages(mapping, &wpc, &blkdev_writeback_ops);
 }
 
 const struct address_space_operations def_blk_aops = {
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68fc8af14700..e741bd34453d 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -149,7 +149,9 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+			.wbc	= wbc,
+	};
 	int ret;
 
 	/*
@@ -158,7 +160,7 @@ static int gfs2_writepages(struct address_space *mapping,
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
-	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
+	ret = iomap_writepages(mapping, &wpc, &gfs2_writeback_ops);
 	if (ret == 0 && wbc->nr_to_write > 0)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 78ebd265f425..9c199a34b017 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1757,17 +1757,17 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos)
+		struct inode *inode, loff_t pos)
 {
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
+			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
-	wbc_init_bio(wbc, bio);
+	wbc_init_bio(wpc->wbc, bio);
 	bio->bi_write_hint = inode->i_write_hint;
 
 	ioend = iomap_ioend_from_bio(bio);
@@ -1817,8 +1817,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
  * writepage context that the caller will need to submit.
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, unsigned len)
+		struct folio *folio, struct inode *inode,
+		loff_t pos, unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
@@ -1829,7 +1829,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		error = iomap_submit_ioend(wpc, 0);
 		if (error)
 			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
+		wpc->ioend = iomap_alloc_ioend(wpc, inode, pos);
 	}
 
 	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
@@ -1838,14 +1838,13 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	if (ifs)
 		atomic_add(len, &ifs->write_bytes_pending);
 	wpc->ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, &folio->page, len);
+	wbc_account_cgroup_owner(wpc->wbc, &folio->page, len);
 	return 0;
 }
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, unsigned dirty_len,
-		unsigned *count)
+		struct folio *folio, struct inode *inode, u64 pos,
+		unsigned dirty_len, unsigned *count)
 {
 	int error;
 
@@ -1869,7 +1868,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		case IOMAP_HOLE:
 			break;
 		default:
-			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
+			error = iomap_add_to_ioend(wpc, folio, inode, pos,
 					map_len);
 			if (!error)
 				(*count)++;
@@ -1952,7 +1951,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 }
 
 static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio)
+		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
@@ -2000,7 +1999,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * Walk through the folio to find dirty areas to write back.
 	 */
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
+		error = iomap_writepage_map_blocks(wpc, folio, inode,
 				pos, rlen, &count);
 		if (error)
 			break;
@@ -2037,7 +2036,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 }
 
 int
-iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
+iomap_writepages(struct address_space *mapping,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
@@ -2053,8 +2052,8 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		return -EIO;
 
 	wpc->ops = ops;
-	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, wbc, folio);
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+		error = iomap_writepage_map(wpc, folio);
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6dead20338e2..5d758910a843 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -471,10 +471,14 @@ xfs_vm_writepages(
 	struct address_space	*mapping,
 	struct writeback_control *wbc)
 {
-	struct xfs_writepage_ctx wpc = { };
+	struct xfs_writepage_ctx wpc = {
+		.ctx = {
+			.wbc	= wbc,
+		},
+	};
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
-	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
+	return iomap_writepages(mapping, &wpc.ctx, &xfs_writeback_ops);
 }
 
 STATIC int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 35166c92420c..51b03689b976 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -152,9 +152,11 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 static int zonefs_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.wbc	= wbc,
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+	return iomap_writepages(mapping, &wpc, &zonefs_writeback_ops);
 }
 
 static int zonefs_swap_activate(struct swap_info_struct *sis,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae..2435ad63d1ad 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -341,6 +341,7 @@ struct iomap_writeback_ops {
 struct iomap_writepage_ctx {
 	struct iomap		iomap;
 	struct iomap_ioend	*ioend;
+	struct writeback_control *wbc;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
 };
@@ -350,7 +351,7 @@ void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
 int iomap_writepages(struct address_space *mapping,
-		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
+		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
 
 /*
-- 
2.47.0


-- 
Goldwyn

