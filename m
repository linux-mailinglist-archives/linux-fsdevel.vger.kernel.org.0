Return-Path: <linux-fsdevel+bounces-31023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B10699103E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D32F1C23913
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E51D8E07;
	Fri,  4 Oct 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Op1+bNr6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4H4jytF6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Op1+bNr6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4H4jytF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7061D8A0D;
	Fri,  4 Oct 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072319; cv=none; b=Go0UCR+Q0BCzIHMXKlR4gUV/dfv4ilqkDkCAB+XkX/yT5UjIb+kxL9iWN2AmQlkbAcN6BJwvvayZr0IhujxfOgzazZ5WZFjX9FlGZxGDLQwqkPF4qOfZt9AI3YgN8Y6l5Yvx4nf3ALbM09rbkRypjCtNLP77G/Y6Xbt7YD+l5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072319; c=relaxed/simple;
	bh=Q5r8578SDLV4SgqipaEHDdunhwK+7jrpc37aUEPk79k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/0cPOMiFkBrRef1lQLWDMoXbB9szino5SDIDKCltHxsw97P160vqS6lZPg6qd2hIYK9Qu+Moxm5MgIfEJ46vWaaYVNQw6U/FDJFKiChTBEIgxMUd2L154DjZUJP0CkiEHV1SP30IFjzsODMzLI4VHbSvPKMHPtU7yPy/lKmf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Op1+bNr6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4H4jytF6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Op1+bNr6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4H4jytF6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC88B1F7B4;
	Fri,  4 Oct 2024 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lg5HOi+E1Ye9/hwOAZzXYI4MTcQMFAmikAygyE8p4VU=;
	b=Op1+bNr6JPfn5aRSjSoNRW1paxpRFcudqI3TTm9jh2G02f5sPP5+qxcyIj4OCZ0SetFOcu
	8PUEUqppjPi+ol9V0D42XgF+Udht9UJvIHFTz7PwpiKjetzpdSgaYanRvdPseijEndIHMn
	WCTIZP3Kmcnp0lMpbxPSftnXAs0vJJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lg5HOi+E1Ye9/hwOAZzXYI4MTcQMFAmikAygyE8p4VU=;
	b=4H4jytF6FSbb6xjQyTJNSqyhN6o8l+T/U9uOhOp2mpmvMKz2kj17PX9wdFHk6d2KUQx02T
	kBzwnxB5dmZ56tCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Op1+bNr6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4H4jytF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lg5HOi+E1Ye9/hwOAZzXYI4MTcQMFAmikAygyE8p4VU=;
	b=Op1+bNr6JPfn5aRSjSoNRW1paxpRFcudqI3TTm9jh2G02f5sPP5+qxcyIj4OCZ0SetFOcu
	8PUEUqppjPi+ol9V0D42XgF+Udht9UJvIHFTz7PwpiKjetzpdSgaYanRvdPseijEndIHMn
	WCTIZP3Kmcnp0lMpbxPSftnXAs0vJJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lg5HOi+E1Ye9/hwOAZzXYI4MTcQMFAmikAygyE8p4VU=;
	b=4H4jytF6FSbb6xjQyTJNSqyhN6o8l+T/U9uOhOp2mpmvMKz2kj17PX9wdFHk6d2KUQx02T
	kBzwnxB5dmZ56tCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75E3713883;
	Fri,  4 Oct 2024 20:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AbLqFntKAGfmRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:15 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/12] iomap: check if folio size is equal to FS block size
Date: Fri,  4 Oct 2024 16:04:28 -0400
Message-ID: <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
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
X-Rspamd-Queue-Id: AC88B1F7B4
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
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

Filesystems such as BTRFS use folio->private so that they receive a
callback while releasing folios. Add check if folio size is same as
filesystem block size while evaluating iomap_folio_state from
folio->private.

I am hoping this will be removed when all of btrfs code has moved to
iomap and BTRFS uses iomap's subpage.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..ad656f501f38 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,6 +43,21 @@ struct iomap_folio_state {
 
 static struct bio_set iomap_ioend_bioset;
 
+static inline struct iomap_folio_state *folio_state(struct folio *folio)
+{
+	struct inode *inode;
+
+	if (folio->mapping && folio->mapping->host)
+		inode = folio->mapping->host;
+	else
+		return folio->private;
+
+	if (i_blocks_per_folio(inode, folio) <= 1)
+		return NULL;
+
+	return folio->private;
+}
+
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs)
 {
@@ -72,7 +87,7 @@ static bool ifs_set_range_uptodate(struct folio *folio,
 static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		size_t len)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	unsigned long flags;
 	bool uptodate = true;
 
@@ -123,7 +138,7 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
 static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
 		u64 range_end)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 
 	if (*range_start >= range_end)
 		return 0;
@@ -150,7 +165,7 @@ static void ifs_clear_range_dirty(struct folio *folio,
 
 static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 
 	if (ifs)
 		ifs_clear_range_dirty(folio, ifs, off, len);
@@ -173,7 +188,7 @@ static void ifs_set_range_dirty(struct folio *folio,
 
 static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 
 	if (ifs)
 		ifs_set_range_dirty(folio, ifs, off, len);
@@ -182,7 +197,7 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 	gfp_t gfp;
 
@@ -234,7 +249,7 @@ static void ifs_free(struct folio *folio)
 static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		loff_t *pos, loff_t length, size_t *offp, size_t *lenp)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
@@ -292,7 +307,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	bool uptodate = !error;
 	bool finished = true;
 
@@ -568,7 +583,7 @@ EXPORT_SYMBOL_GPL(iomap_readahead);
  */
 bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned first, last, i;
 
@@ -1062,7 +1077,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 	 * but not dirty. In that case it is necessary to punch
 	 * out such blocks to avoid leaking any delalloc blocks.
 	 */
-	ifs = folio->private;
+	ifs = folio_state(folio);
 	if (!ifs)
 		return ret;
 
@@ -1522,7 +1537,7 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
@@ -1768,7 +1783,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, loff_t pos, unsigned len)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	size_t poff = offset_in_folio(folio, pos);
 	int error;
 
@@ -1807,7 +1822,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 
 		map_len = min_t(u64, dirty_len,
 			wpc->iomap.offset + wpc->iomap.length - pos);
-		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+		WARN_ON_ONCE(!folio_state(folio) && map_len < dirty_len);
 
 		switch (wpc->iomap.type) {
 		case IOMAP_INLINE:
@@ -1902,7 +1917,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio)
 {
-	struct iomap_folio_state *ifs = folio->private;
+	struct iomap_folio_state *ifs = folio_state(folio);
 	struct inode *inode = folio->mapping->host;
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
-- 
2.46.1


