Return-Path: <linux-fsdevel+bounces-31027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5C9910C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6B9B2B065
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18531DDC2C;
	Fri,  4 Oct 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="od0eDtF0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WGxmOx1k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="od0eDtF0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WGxmOx1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFC1D959E;
	Fri,  4 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072333; cv=none; b=adtKQPMPwuYA2HLCgLpbPappaaklcxDMxboLYXEYkPeHQPJ3bK2bDonpUgRFLZZQcvjZwdwx4wvulgUm8tc6ceVUumKKDpp7oZxd/R32x3/dBLVT94Na4dBTqktKrMU+tpRPFdO/3Fxg6DPAiaauifMnQ3CzSb2PPoMWuSWV+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072333; c=relaxed/simple;
	bh=8DErGaIXJvy5ZwaYqrQe+6UwFIYJEFsf5yz4BYudoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjwgqDC/ppqwXcJmi+yDOyLkgvZyZadqzvbJFIt+wypu0bf3Z53EsrOwS7KqhW4RYsSq/vIkJsnVPrqnI304pqxTcdQUcfLtFeNf+yL/hTpfXoo+AlpAY1MkmkIky99V9C8O+s+y2QUbz+f10lksmlyPyKN668plWKdhyT+9QPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=od0eDtF0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WGxmOx1k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=od0eDtF0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WGxmOx1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A77DF21D73;
	Fri,  4 Oct 2024 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AQJHqCZURz5AYFAqbxGpLiNA1wJE6CG19ccDyjREC8=;
	b=od0eDtF0D46QMZlwDrJz0OxL4/Xm3CEIOpepatGF4NtJfxuK7SvZ1nUT/JtpOJYSYq+qGF
	mklhzRQZgmu6jsSHb+GofpEQFTd7YjU9pCMJ+79Z7tFld+Si2nbnfKj5ZeLVrG1Bcjdxfm
	csls7wgtZvmXkUpfTDIUMHjhTazlvvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AQJHqCZURz5AYFAqbxGpLiNA1wJE6CG19ccDyjREC8=;
	b=WGxmOx1kE8xxx08MFhwmQFUTyhrXDWkx1KAQ8UDpesILGcDfKC6s0ct5I4ajAajNUUh6fK
	M4SisfIWCrtcXWDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=od0eDtF0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WGxmOx1k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AQJHqCZURz5AYFAqbxGpLiNA1wJE6CG19ccDyjREC8=;
	b=od0eDtF0D46QMZlwDrJz0OxL4/Xm3CEIOpepatGF4NtJfxuK7SvZ1nUT/JtpOJYSYq+qGF
	mklhzRQZgmu6jsSHb+GofpEQFTd7YjU9pCMJ+79Z7tFld+Si2nbnfKj5ZeLVrG1Bcjdxfm
	csls7wgtZvmXkUpfTDIUMHjhTazlvvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AQJHqCZURz5AYFAqbxGpLiNA1wJE6CG19ccDyjREC8=;
	b=WGxmOx1kE8xxx08MFhwmQFUTyhrXDWkx1KAQ8UDpesILGcDfKC6s0ct5I4ajAajNUUh6fK
	M4SisfIWCrtcXWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55D3313883;
	Fri,  4 Oct 2024 20:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 74axCIlKAGf2RQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:29 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/12] iomap: Introduce IOMAP_ENCODED
Date: Fri,  4 Oct 2024 16:04:32 -0400
Message-ID: <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com>
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
X-Rspamd-Queue-Id: A77DF21D73
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

An encoded extent must be read completely. Make the bio just as a
regular bio and let filesystem deal with the rest of the extent.
A new bio must be created if a new iomap is returned.
The filesystem must be informed that the bio to be read is
encoded and the offset from which the encoded extent starts. So, pass
the iomap associated with the bio while calling submit_io. Save the
previous iomap (associated with the bio being submitted) in prev in
order to submit when the iomap changes.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 17 ++++++++++-------
 include/linux/iomap.h  | 11 +++++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0e682ff84e4a..4c734899a8e5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -378,12 +378,13 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 
-	return srcmap->type != IOMAP_MAPPED ||
+	return (srcmap->type != IOMAP_MAPPED &&
+			srcmap->type != IOMAP_ENCODED) ||
 		(srcmap->flags & IOMAP_F_NEW) ||
 		pos >= i_size_read(iter->inode);
 }
 
-static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
+static loff_t iomap_readpage_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -419,6 +420,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
+	    (iomap->type & IOMAP_ENCODED && iomap->offset != iter->prev.offset) ||
 	    bio_end_sector(ctx->bio) != sector ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		struct bio_set *bioset;
@@ -428,10 +430,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->bio) {
 			if (ctx->ops && ctx->ops->submit_io)
-				ctx->ops->submit_io(iter->inode, ctx->bio);
+				ctx->ops->submit_io(iter->inode, ctx->bio, &iter->prev);
 			else
 				submit_bio(ctx->bio);
 		}
+		iter->prev = iter->iomap;
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -470,7 +473,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
-static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
+static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -509,7 +512,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
 
 	if (ctx.bio) {
 		if (ctx.ops->submit_io)
-			ctx.ops->submit_io(iter.inode, ctx.bio);
+			ctx.ops->submit_io(iter.inode, ctx.bio, &iter.prev);
 		else
 			submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
@@ -527,7 +530,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
+static loff_t iomap_readahead_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	loff_t length = iomap_length(iter);
@@ -588,7 +591,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
 
 	if (ctx.bio) {
 		if (ctx.ops && ctx.ops->submit_io)
-			ctx.ops->submit_io(iter.inode, ctx.bio);
+			ctx.ops->submit_io(iter.inode, ctx.bio, &iter.prev);
 		else
 			submit_bio(ctx.bio);
 	}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7b757bea8455..a5cf00a01f23 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -30,6 +30,7 @@ struct vm_fault;
 #define IOMAP_MAPPED	2	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
 #define IOMAP_INLINE	4	/* data inline in the inode */
+#define IOMAP_ENCODED	5	/* data encoded, R/W whole extent */
 
 /*
  * Flags reported by the file system from iomap_begin:
@@ -107,6 +108,8 @@ struct iomap {
 
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
+	if (iomap->type & IOMAP_ENCODED)
+		return iomap->addr;
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
@@ -217,9 +220,13 @@ struct iomap_iter {
 	loff_t pos;
 	u64 len;
 	s64 processed;
+	unsigned type;
 	unsigned flags;
 	struct iomap iomap;
-	struct iomap srcmap;
+	union {
+		struct iomap srcmap;
+		struct iomap prev;
+	};
 	void *private;
 };
 
@@ -261,7 +268,7 @@ struct iomap_read_folio_ops {
 	 * Optional, allows the filesystem to perform a custom submission of
 	 * bio, such as csum calculations or multi-device bio split
 	 */
-	void (*submit_io)(struct inode *inode, struct bio *bio);
+	void (*submit_io)(struct inode *inode, struct bio *bio, const struct iomap *iomap);
 
 	/*
 	 * Optional, allows filesystem to specify own bio_set, so new bio's
-- 
2.46.1


