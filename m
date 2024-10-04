Return-Path: <linux-fsdevel+bounces-31029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E920991049
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C428177A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D91E3DDF;
	Fri,  4 Oct 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MP6wujyD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N6xnXhOB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MP6wujyD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N6xnXhOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6C1DF72C;
	Fri,  4 Oct 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072338; cv=none; b=BCGGq2VF0IzE+WdFxk5KTbms35o8xR9oOWvcYpBxpV0rLow3dGQAA/hVVwqD8qHb9i5MKb35u2TEursQYm+ceWw4g+A2x1bY1P7EBMk5lWVMd4YQ47XlsbIS812/+JXjd5SpgyBOZapa6N6cJZc1XwtkQuVHXWJG4N9v+QTnne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072338; c=relaxed/simple;
	bh=qNoTbfrD2fiD/WYead95JSHx65XyGde9xKUbHYGUgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ7H6Gvud5Le3SuZqGEJMidLLxmZP29MRolVeG11cKFRIcZVeq6fp0O/+psAfG4lRRwcmQF3am0ncpWeWWIjnVklEfxjVdRBbGwwdocU//HYnLycwUQklcQx32KJRvzcrHBJJuvtQ6lH+e55/5nP4AC/ibSK6qtHq+5bJAKnLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MP6wujyD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N6xnXhOB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MP6wujyD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N6xnXhOB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B078321D52;
	Fri,  4 Oct 2024 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGPkM6gewJ/SPePSMUm19utfX+Gmzgakh66Hi9khGMI=;
	b=MP6wujyD470A8pflac8i3UVxRtS1pIqy/czN5/jjAPF632/m5xhw8KC2n9PrPDqpmxP+88
	DpkJcll41aAXOnKRYxJVGW/FP812TksEvqK+p6iXG+wEQ0orFQHF6H0qvZfsmsAgiRJ2jE
	7Axbuq65pNegZlDVfh5HegQHCAJUWgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGPkM6gewJ/SPePSMUm19utfX+Gmzgakh66Hi9khGMI=;
	b=N6xnXhOBAi/PO7CNycPa9RcfmOLx/Ubla876sjvE3cJ8+NSGkxAC5/JRRcyzk9nhFCDxio
	S+xlf0+jjK399LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGPkM6gewJ/SPePSMUm19utfX+Gmzgakh66Hi9khGMI=;
	b=MP6wujyD470A8pflac8i3UVxRtS1pIqy/czN5/jjAPF632/m5xhw8KC2n9PrPDqpmxP+88
	DpkJcll41aAXOnKRYxJVGW/FP812TksEvqK+p6iXG+wEQ0orFQHF6H0qvZfsmsAgiRJ2jE
	7Axbuq65pNegZlDVfh5HegQHCAJUWgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGPkM6gewJ/SPePSMUm19utfX+Gmzgakh66Hi9khGMI=;
	b=N6xnXhOBAi/PO7CNycPa9RcfmOLx/Ubla876sjvE3cJ8+NSGkxAC5/JRRcyzk9nhFCDxio
	S+xlf0+jjK399LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D40413883;
	Fri,  4 Oct 2024 20:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dhaFOo5KAGf/RQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:34 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/12] btrfs: btrfs_em_to_iomap() to convert em to iomap
Date: Fri,  4 Oct 2024 16:04:34 -0400
Message-ID: <23762f818bfb84bd38b4ad0e803588dc140cd14a.1728071257.git.rgoldwyn@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_em_to_iomap() converts and extent map into passed argument struct
iomap. It makes sure the information is in multiple of sectorsize block.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cb0a39370d30..7f40c2b8bfb8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -14,6 +14,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/fsverity.h>
+#include <linux/iomap.h>
 #include "extent_io.h"
 #include "extent-io-tree.h"
 #include "extent_map.h"
@@ -900,6 +901,35 @@ void clear_folio_extent_mapped(struct folio *folio)
 	folio_detach_private(folio);
 }
 
+static void btrfs_em_to_iomap(struct inode *inode,
+		struct extent_map *em, struct iomap *iomap,
+		loff_t sector_pos, bool write)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	if (!btrfs_is_data_reloc_root(BTRFS_I(inode)->root) &&
+	    em->flags & EXTENT_FLAG_PINNED) {
+		iomap->type = IOMAP_UNWRITTEN;
+		iomap->addr = extent_map_block_start(em);
+	} else if (em->disk_bytenr == EXTENT_MAP_INLINE) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_INLINE;
+	} else if (em->disk_bytenr == EXTENT_MAP_HOLE ||
+			(!write && (em->flags & EXTENT_FLAG_PREALLOC))) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_HOLE;
+	} else if (extent_map_is_compressed(em)) {
+		iomap->type = IOMAP_ENCODED;
+		iomap->addr = em->disk_bytenr;
+	} else {
+		iomap->addr = extent_map_block_start(em);
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = em->start;
+	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap->length = em->len;
+}
+
 static struct extent_map *__get_extent_map(struct inode *inode,
 					   struct folio *folio, u64 start,
 					   u64 len, struct extent_map **em_cached)
-- 
2.46.1


