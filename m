Return-Path: <linux-fsdevel+bounces-63912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F6BD1967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C46F3B318D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEB2DF151;
	Mon, 13 Oct 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fd+5fy2k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fd+5fy2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632019D071
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335744; cv=none; b=OUGLaK7emVQ+C3r4oJIC+MAM1wqA6/whUmc6ZM5wDSictQ2l9ObE9NyghwyOIHuqJGzYWiz+2EBxtlLK9bOdLoHjYts1IBbSkf9PhkwqN+c0JDfxkxqcH2Z6n7Gvs0i/tRVjCCfygQgTi56XlDw9RcEv4oloOQNlgF+8hjQaOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335744; c=relaxed/simple;
	bh=WNRmNFsl1avqdMV6/Tbah98S8Kpkv1EEd34Gvm9ZCp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtSNSZU/0Jm25sGo8wALmoMxlRSLeKl5aMIA/2/Xiern2jeF2Fklx6UQMlusoCpQlNwgbaHnhC1IvNYOcuBtb11a6ZGYDnUbAf369xZ0FbI63NVn8m+XQv7/8B4rrGO2KKBMixdEDgpxe7lGwXIiM+SF2wgrdAptfW21o2Hhhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fd+5fy2k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fd+5fy2k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C5391F45F;
	Mon, 13 Oct 2025 06:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760335740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NtbCDcfgEx4aeh/jr/2G5yFba+OLHx8IWPUAL+bTG2I=;
	b=Fd+5fy2kyHk7izJPHQfg5dg56oUVqjMIPBYwLUdj6qpm990Za5gCbtcDVfRXGitridGZI5
	Ry2abXxRgtg9t6B4ZU3F3+PjDAA+LZVbdLJyobZDRAKlgTcX8VGhjuKkrMsXmEWMMgHCzO
	TjDngKNOpK22RCqZNYzYBJXDy2SWkao=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Fd+5fy2k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760335740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NtbCDcfgEx4aeh/jr/2G5yFba+OLHx8IWPUAL+bTG2I=;
	b=Fd+5fy2kyHk7izJPHQfg5dg56oUVqjMIPBYwLUdj6qpm990Za5gCbtcDVfRXGitridGZI5
	Ry2abXxRgtg9t6B4ZU3F3+PjDAA+LZVbdLJyobZDRAKlgTcX8VGhjuKkrMsXmEWMMgHCzO
	TjDngKNOpK22RCqZNYzYBJXDy2SWkao=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67B2B13874;
	Mon, 13 Oct 2025 06:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jxi5CnqX7Gh2IQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 13 Oct 2025 06:08:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: brauner@kernel.org,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: add IOMAP_DIO_ALIGNED flag for btrfs
Date: Mon, 13 Oct 2025 16:38:40 +1030
Message-ID: <5dbcc1d717c1f8a6ed85da4768306efb0073ff78.1760335677.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C5391F45F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

With the recent bs > ps support for btrfs, btrfs requires block
alignment for all of its bios.

However the current iomap_dio_bio_iter() calls bio_iov_iter_get_pages()
which only ensure alignment to bdev_logical_block_size().

In the real world it's mostly 512 or 4K, resulting some bio to be split
at page boundary, breaking the btrfs requirement.

To address this problem, introduce a new public iomap dio flag,
IOMAP_DIO_ALIGNED.

When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
also get that new flag, and iomap_dio_bio_iter() will take fs block size
into the calculation of the alignment, and pass it to
bio_iov_iter_get_pages() so that the bio will always be fs block
aligned.

For now only btrfs will utilize this flag, as btrfs needs to calculate
checksum for direct read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/direct-io.c  | 4 ++--
 fs/iomap/direct-io.c  | 9 +++++++--
 include/linux/iomap.h | 7 +++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..15aff186642d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -763,7 +763,7 @@ static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct btrfs_dio_data data = { 0 };
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_ALIGNED, &data, done_before);
 }
 
 static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
@@ -772,7 +772,7 @@ static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *it
 	struct btrfs_dio_data data = { 0 };
 
 	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_ALIGNED, &data, done_before);
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..154bfc4ff3c4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -336,6 +336,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
+	const unsigned int alignment = (dio->flags & IOMAP_DIO_ALIGNED) ?
+		max(fs_block_size, bdev_logical_block_size(iomap->bdev)) :
+		bdev_logical_block_size(iomap->bdev);
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
@@ -433,8 +436,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-				bdev_logical_block_size(iomap->bdev) - 1);
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -639,6 +641,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (dio_flags & IOMAP_DIO_ALIGNED)
+		dio->flags |= IOMAP_DIO_ALIGNED;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..9bbd36fd69cf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -518,6 +518,13 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Ensure each bio is aligned to fs block size.
+ *
+ * For filesystems which need to calculate/verify data checksum for each data bio.
+ */
+#define IOMAP_DIO_ALIGNED		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.50.1


