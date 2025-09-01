Return-Path: <linux-fsdevel+bounces-59737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDDB3D8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB1179364
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F8243387;
	Mon,  1 Sep 2025 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxxntPJO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxxntPJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F092417C6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704284; cv=none; b=V3hJihHmXDh84RVYF8BwPn40bhhwHqvw/gDve47mYMHycXywEHIjoJNNTbE1qWVrXZAYyW5TYss05v5xTIQDQ8sh9emApceZrUW/qJHzW2TQKJorDTMkkmrbbICZZoU8Jo8XL4BOMMZY5OvUVdFlni6KxOctXXNGsnr1PiNnEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704284; c=relaxed/simple;
	bh=jaoldoaGQxCnxPhO01iLdXxQeAdBzfI2FH8XLcIlS5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMintapft7wyNF8RvIaqRpE3TGmN8xU07iLqsqXsyY5pzpcKzEIBAs3RvFbJqfp+WwGrCB2TyexiyA1emhYb03Hj0qlsVNLzgMSyXkL369Aj1j3Qenen17p0AkQE8rh3ub1lVarwmRl2NcVJPg0yWmc5xv0at5dik3Lnb5MHo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxxntPJO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxxntPJO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C66DC336C1;
	Mon,  1 Sep 2025 05:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6rfdIx5FzJiNL3A9ZqIrdGabPJiQqTbU3RX3329EPw=;
	b=QxxntPJOGX3SPCLT45gySb9PpKgyVrbPuLlsT2PKy+X7DbVbvpRRNNqclRA6STJeXo0rYh
	lDkP/c1rjM+hO14LmVIUnXbyaEWQ9NnTOjc5/iUeYWkiOB75nbZfvV0EQuNcpV9UCZWuiq
	o3pQg4Hq9FhINhLWJpRB8hwRH+hGbsQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6rfdIx5FzJiNL3A9ZqIrdGabPJiQqTbU3RX3329EPw=;
	b=QxxntPJOGX3SPCLT45gySb9PpKgyVrbPuLlsT2PKy+X7DbVbvpRRNNqclRA6STJeXo0rYh
	lDkP/c1rjM+hO14LmVIUnXbyaEWQ9NnTOjc5/iUeYWkiOB75nbZfvV0EQuNcpV9UCZWuiq
	o3pQg4Hq9FhINhLWJpRB8hwRH+hGbsQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7E5813981;
	Mon,  1 Sep 2025 05:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qINSIg0utWhBJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 01 Sep 2025 05:24:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] btrfs: replace bio_for_each_segment usage
Date: Mon,  1 Sep 2025 14:54:06 +0930
Message-ID: <80ada25b72261dcaedc2ccc6d801de19c56f3ece.1756703958.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Inside btrfs we have some call sites using bio_for_each_segment() and
bio_for_each_segment_all().

They are fine for now, as we only support bs <= ps, thus the returned
bv_len is no larger than block size.

However for the incoming bs > ps support, a block can cross several
pages (although they are still physical contiguous, as such block is
backed by large folio), in that case the single page iterator is not
going to handle such blocks.

Replace the followinng call sites with bio_for_each_bvec*() helpers:

- btrfs_csum_one_bio()
  This one is critical for basic uncompressed writes for bs > ps case.
  Or it will use the content of the page to calculate the checksum
  instead of the correct block (which crosses multiple pages).

- set_bio_pages_uptodate()
- verify_bio_data_sectors()
  They are mostly fine even with the old single-page interface, as they
  won't bother bv_len at all.
  But it's still helpful to replace them, as the new multi-page helper
  will save some bytes from the stack memory.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 13 +++++++------
 fs/btrfs/raid56.c    |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4dd3d8a02519..bb08b27983a7 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -775,6 +775,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
+	const u32 blocksize = fs_info->sectorsize;
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
@@ -799,16 +800,16 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	shash->tfm = fs_info->csum_shash;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
-						 bvec.bv_len + fs_info->sectorsize
-						 - 1);
+	bio_for_each_bvec(bvec, bio, iter) {
+		ASSERT(bvec.bv_len >= blocksize);
+		ASSERT(IS_ALIGNED(bvec.bv_len, blocksize));
+		blockcount = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
 
 		for (i = 0; i < blockcount; i++) {
 			data = bvec_kmap_local(&bvec);
 			crypto_shash_digest(shash,
-					    data + (i * fs_info->sectorsize),
-					    fs_info->sectorsize,
+					    data + (i << fs_info->sectorsize_bits),
+					    blocksize,
 					    sums->sums + index);
 			kunmap_local(data);
 			index += fs_info->csum_size;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index df48dd6c3f54..2c810fe96bdf 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1513,11 +1513,11 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	int i;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_bvec_all(bvec, bio, i) {
 		struct sector_ptr *sector;
 		phys_addr_t paddr = bvec_phys(bvec);
 
@@ -1574,7 +1574,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
 	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	int i;
 
 	/* No data csum for the whole stripe, no need to verify. */
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
@@ -1584,7 +1584,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
 		return;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_bvec_all(bvec, bio, i) {
 		void *kaddr;
 
 		kaddr = bvec_kmap_local(bvec);
-- 
2.50.1


