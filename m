Return-Path: <linux-fsdevel+bounces-31025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28548991042
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C91C239AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027811D90D5;
	Fri,  4 Oct 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NY3PHX1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U5J8L0C/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+/OU30k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZZFMxc1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51901D90B7;
	Fri,  4 Oct 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072323; cv=none; b=r5vuyYng44P++BBlKabHU+wMS1oivjkWWEoZnlgzUF+75DxLqY333uj7uDhPttENCOwANJ8XiJExE8S+CNKNL/c9bOYxgCGuShsXuwu5fSd8rIF/HUM+x7VjRi+t7Su6jf98eJPvT2RjKNriru4mnrEwhg5x+PzL/++wri/mp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072323; c=relaxed/simple;
	bh=Fpt4YPr87mHv4JmGMIh8GwlBLkDcdX+nghxJNit8v1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihbd/iJ+a0G3LQkRtdxNgPZpabZivk89INC9QfiIT1dWSzA/1PMb5N3zXMmw3QM86mDh+/x9TNnUXIK+3y3MEcoHxJerfn1yEFL115UA9a4D1rO78UybvMMb6+vsCZI2NCnPMYn4oB3h1DkkJ3J7jz5JYvK96ZKxBgFl5c5dZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NY3PHX1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U5J8L0C/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+/OU30k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZZFMxc1w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E958A21D52;
	Fri,  4 Oct 2024 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAlPD+GUVZwmk0Pd7GZDO3MjGJpMAgMWe/gHTxltMc4=;
	b=NY3PHX1fxGqdEPfxRNxTTdl2Z5eDzMB9vdY/F6Rofg2iEMcdcJJ010NaC1zcqmVYgCYQcY
	lGHeY5+kWn07Wk2Gk8P76Khsx10E0TVHq4KeZuSgRNLvwTzG9fks1gqnnehXVqYMIIL8Xu
	Up6wzKp/h7mq9GORpk8DG21fgX/0NR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAlPD+GUVZwmk0Pd7GZDO3MjGJpMAgMWe/gHTxltMc4=;
	b=U5J8L0C/OOjtiGNDqEz+CQiAuEENL3C1HWRiMZoJeG8ke2anWSpZenOI1v5hGeXUsBY9G0
	aFQDLt4jGExR8aAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAlPD+GUVZwmk0Pd7GZDO3MjGJpMAgMWe/gHTxltMc4=;
	b=i+/OU30ka0A3dgc6s83GVNrbZMOhCiRCtvB762K6TXVVcsyqqUBRuLc648DMPO2W4xHAkV
	AtrTefCef/OQa/AO7rAij79LRdhS7l0oTRjduI6o8bwCe20b1eUN9cwwpfiPxm1r5jeyQh
	iGHm2h92iuhLbeHCr6d9gOe3CIeRqJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAlPD+GUVZwmk0Pd7GZDO3MjGJpMAgMWe/gHTxltMc4=;
	b=ZZFMxc1wy6b6IWsIHaauxn4gzYgTbOWA2k9fscrKps3gAfn+98/QFnyDzaXzR8ZANzamqV
	wKYW9DbbUOHDg4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F08613883;
	Fri,  4 Oct 2024 20:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ul+5En9KAGftRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:19 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 03/12] iomap: add bioset in iomap_read_folio_ops for filesystems to use own bioset
Date: Fri,  4 Oct 2024 16:04:30 -0400
Message-ID: <95262994f8ba468ab26f1e855224c54c2a439669.1728071257.git.rgoldwyn@suse.com>
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
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Allocate the bio from the bioset provided in iomap_read_folio_ops.
If no bioset is provided, fs_bio_set is used which is the standard
bioset for filesystems.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 20 ++++++++++++++------
 include/linux/iomap.h  |  6 ++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71370bbe466c..d007b4a8307c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -421,6 +421,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+		struct bio_set *bioset;
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -434,17 +435,24 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+
+		if (ctx->ops && ctx->ops->bio_set)
+			bioset = ctx->ops->bio_set;
+		else
+			bioset = &fs_bio_set;
+
+		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
+				REQ_OP_READ, gfp, bioset);
+
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		if (!ctx->bio)
+			ctx->bio = bio_alloc_bioset(iomap->bdev, 1, REQ_OP_READ,
+					orig_gfp, bioset);
+
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5b775213920e..f876d16353c6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -262,6 +262,12 @@ struct iomap_read_folio_ops {
 	 * bio, such as csum calculations or multi-device bio split
 	 */
 	void (*submit_io)(struct inode *inode, struct bio *bio);
+
+	/*
+	 * Optional, allows filesystem to specify own bio_set, so new bio's
+	 * can be allocated from the provided bio_set.
+	 */
+	struct bio_set *bio_set;
 };
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-- 
2.46.1


