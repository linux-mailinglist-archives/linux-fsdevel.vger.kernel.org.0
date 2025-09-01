Return-Path: <linux-fsdevel+bounces-59735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93009B3D8AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC6617938E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA923D7C8;
	Mon,  1 Sep 2025 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N21g7BeL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N21g7BeL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53423BD02
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704278; cv=none; b=oK4eRyGMkDiwv8ia3748t2ElwpbZ5q7wByKyLAuO5EkXfbYxk3PkZpXGUJQ6hItNqBKK2p0xF7qy+Ti41VdBCo5uuooJG1iet5fGXaW0a9hQRSfwrMo2G5bZ+LID8bE3gBhIV7+6JK91wmgWBmsAc8FeuQVGh2vVd1Last/SCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704278; c=relaxed/simple;
	bh=dGDXA5XSSYwT3vmQZwtZp5MtY/LdY8i/0NZOrMFj6Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgdElAYcjUQcRG8MBWr4sHgzDWHoiFxxihGxZXNicyi+xLac1PziVtdDJx0663Vttbh5C79KYsf23Xt8ausNw1TaWHWTUw5EnhVuxUK9EuQAW5wp1G1BEIMHVNLjExcz9u/rdpfBGjzeod/SuZnIfpeHdmM6YEx61bzaHV9MKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N21g7BeL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N21g7BeL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55370336AF;
	Mon,  1 Sep 2025 05:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQIbT408B9J58dIc6efCa2vGlWwlf8V+L8waeidAK4w=;
	b=N21g7BeLEsDWDeE6R5wFc8qV6ZPPH4hAGI1mju2GaWmMkilJ8kspqu9+RHGSynZyWUJuie
	dSDaFFLqWkEb+zYW5ToUvttTrGHn0HywcobrO/hvmuE3XbOHXQK+5bTmL2m4qYKle4znWt
	01h87k8H5Tz/Mg+yfVBDHsiqvnb6SnU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N21g7BeL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQIbT408B9J58dIc6efCa2vGlWwlf8V+L8waeidAK4w=;
	b=N21g7BeLEsDWDeE6R5wFc8qV6ZPPH4hAGI1mju2GaWmMkilJ8kspqu9+RHGSynZyWUJuie
	dSDaFFLqWkEb+zYW5ToUvttTrGHn0HywcobrO/hvmuE3XbOHXQK+5bTmL2m4qYKle4znWt
	01h87k8H5Tz/Mg+yfVBDHsiqvnb6SnU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 571BE13981;
	Mon,  1 Sep 2025 05:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kE7FBgwutWhBJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 01 Sep 2025 05:24:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] btrfs: replace single page bio_iter_iovec() usage
Date: Mon,  1 Sep 2025 14:54:05 +0930
Message-ID: <e1467a67f550f4d54afeac87051621fe58733ca5.1756703958.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756703958.git.wqu@suse.com>
References: <cover.1756703958.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 55370336AF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

There are several functions inside btrfs calling bio_iter_iovec(),
mostly to do a block-by-block iteration on a bio.

- btrfs_check_read_bio()
- btrfs_decompress_buf2page()
- index_one_bio() from raid56

However that helper is single page based, meaning it will never return a
bv_len larger than PAGE_SIZE. For now it's fine as we only support bs <=
ps at most.

But for the incoming bs > ps support, we want to get bv_len larger than
PAGE_SIZE so that the bio_vec will cover a full block, not just part of
the large folio of the block.

In fact the call site inside btrfs_check_read_bio() will trigger
ASSERT() inside btrfs_data_csum_ok() when bs > ps support is enabled.
As bio_iter_iovec() will return a bv_len == 4K, meanwhile the bs is
larger than 4K, triggering the ASSERT().

Replace those call sites with mp_bvec_iter_bvec(), which will return the
full length of from the bi_io_vec array.
Currently all call sites are already doing extra loop inside the bvec
range for bs < ps support, so they will be fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 3 ++-
 fs/btrfs/compression.c | 3 +--
 fs/btrfs/raid56.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ea7f7a17a3d5..f7aea4310dd6 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -277,8 +277,9 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	bbio->bio.bi_status = BLK_STS_OK;
 
 	while (iter->bi_size) {
-		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
+		struct bio_vec bv = mp_bvec_iter_bvec(bbio->bio.bi_io_vec, *iter);
 
+		ASSERT(bv.bv_len >= sectorsize && IS_ALIGNED(bv.bv_len, sectorsize));
 		bv.bv_len = min(bv.bv_len, sectorsize);
 		if (status || !btrfs_data_csum_ok(bbio, dev, offset, &bv))
 			fbio = repair_one_sector(bbio, offset, &bv, fbio);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 068339e86123..8b415c780ba8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1227,14 +1227,13 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 	cur_offset = decompressed;
 	/* The main loop to do the copy */
 	while (cur_offset < decompressed + buf_len) {
-		struct bio_vec bvec;
+		struct bio_vec bvec = mp_bvec_iter_bvec(orig_bio->bi_io_vec, orig_bio->bi_iter);
 		size_t copy_len;
 		u32 copy_start;
 		/* Offset inside the full decompressed extent */
 		u32 bvec_offset;
 		void *kaddr;
 
-		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
 		/*
 		 * cb->start may underflow, but subtracting that value can still
 		 * give us correct offset inside the full decompressed extent.
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3ff2bedfb3a4..df48dd6c3f54 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1214,7 +1214,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 	while (iter.bi_size) {
 		unsigned int index = (offset >> sectorsize_bits);
 		struct sector_ptr *sector = &rbio->bio_sectors[index];
-		struct bio_vec bv = bio_iter_iovec(bio, iter);
+		struct bio_vec bv = mp_bvec_iter_bvec(bio->bi_io_vec, iter);
 
 		sector->has_paddr = true;
 		sector->paddr = bvec_phys(&bv);
-- 
2.50.1


