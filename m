Return-Path: <linux-fsdevel+bounces-63939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B654BD233F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE43492E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA22FBE09;
	Mon, 13 Oct 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aQFZH/LG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aQFZH/LG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCA2FB608
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346341; cv=none; b=eVrYYBDPbC2j61I4nwED56U7xLIbZF5Qdq3xBRVnmdC0Mh9lgiZvMphWIYv0lb5wcZxx1IQZIrj2DbW8jJ0q7Xp1OJrNQ79xBmzGFHgcgNTu+c4d2PZNH002MlfmiOKGws/hCdGTbjR0hs2NrDcl7FfJq7SgLm9Lif4WtDL44hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346341; c=relaxed/simple;
	bh=htzUzsuPW5wUfngWhFU8Aq5SfZv/1CIaR47VE2cQhUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gp5ZQeEaFzcwQOkYS5k1KJlfXyHWoG4TT96XevruX8knEzSaxW8IB+Q0jIwkuCJBe8aLheV8CpoocIzjHGP4f6ikAcPAJ831IadJpY53d+plRJYn6dMx3Sgjs+D9fEqeQ0+mB2dw7wQWv4p725eHcyCTA4BC6UFU9YB8IeaXz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aQFZH/LG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aQFZH/LG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BBF61F7C3;
	Mon, 13 Oct 2025 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760346336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XVvXa6nuYdbk16HCTTXolPd2lu2jNhkyqs8wn63ILc=;
	b=aQFZH/LGUVeJwznLgeGB7KSr8ScmnJIhYLS2eQ7uK0PQrgJGIfDtK1JPfmRs0RdC+ZFD3h
	hT4ZTDf+4BDyltmbIIActASnT5y1udG8x1KM+i6N2bNmMpNYCr6UP8vBoYKCfyc0u8wYYT
	bP1tdPQfkj9VsXQKsOhFisJqw9Xjbu8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="aQFZH/LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760346336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XVvXa6nuYdbk16HCTTXolPd2lu2jNhkyqs8wn63ILc=;
	b=aQFZH/LGUVeJwznLgeGB7KSr8ScmnJIhYLS2eQ7uK0PQrgJGIfDtK1JPfmRs0RdC+ZFD3h
	hT4ZTDf+4BDyltmbIIActASnT5y1udG8x1KM+i6N2bNmMpNYCr6UP8vBoYKCfyc0u8wYYT
	bP1tdPQfkj9VsXQKsOhFisJqw9Xjbu8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EB4D1374A;
	Mon, 13 Oct 2025 09:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEYtAN7A7GgGVAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 13 Oct 2025 09:05:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: brauner@kernel.org,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Date: Mon, 13 Oct 2025 19:35:16 +1030
Message-ID: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BBF61F7C3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim];
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

Btrfs requires all of its bios to be fs block aligned, normally it's
totally fine but with the incoming block size larger than page size
(bs > ps) support, the requirement is no longer met for direct IOs.

Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
requiring alignment to be bdev_logical_block_size().

In the real world that value is either 512 or 4K, on 4K page sized
systems it means bio_iov_iter_get_pages() can break the bio at any page
boundary, breaking btrfs' requirement for bs > ps cases.

To address this problem, introduce a new public iomap dio flag,
IOMAP_DIO_FSBLOCK_ALIGNED.

When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
inherit that new flag, and iomap_dio_bio_iter() will take fs block size
into the calculation of the alignment, and pass the alignment to
bio_iov_iter_get_pages(), respecting the fs block size requirement.

The initial user of this flag will be btrfs, which needs to calculate the
checksum for direct read and thus requires the biovec to be fs block
aligned for the incoming bs > ps support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix too long lines
  To follow the old 80 chars limits.

- Reword the commit messages a little

- Rename the public IOMAP flag to IOMAP_DIO_FSBLOCK_ALIGNED

- Make the calculation of alignment eaiser to read
  With a short comment explaing why we need to use the larger value of
  bdev and fs block size.

- Remove the btrfs part that utilize the new flag
  Now it's in the enablement patch of btrfs' bs > ps direct IO support.

 fs/iomap/direct-io.c  | 13 ++++++++++++-
 include/linux/iomap.h |  8 ++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..ce9cbd2bace0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -336,10 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
+	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
 
+	/*
+	 * Align to the larger one of bdev and fs block size, to meet the
+	 * alignment requirement of both layers.
+	 */
+	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		alignment = max(alignment, fs_block_size);
+
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
@@ -434,7 +442,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-				bdev_logical_block_size(iomap->bdev) - 1);
+					     alignment - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -639,6 +647,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
+		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..4da13fe24ce8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -518,6 +518,14 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Ensure each bio is aligned to fs block size.
+ *
+ * For filesystems which need to calculate/verify the checksum of each fs
+ * block. Otherwise they may not be able to handle unaligned bios.
+ */
+#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.50.1


