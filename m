Return-Path: <linux-fsdevel+bounces-31031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DD99104D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849821F210CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360101E5703;
	Fri,  4 Oct 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BJXp+8GE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQ1NImr3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BJXp+8GE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQ1NImr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93C1E47D0;
	Fri,  4 Oct 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072348; cv=none; b=L8vdVWN+7xyXxnkZhSUh9+yTEL0vQG6Jx3vVHnY7rjbNwJ8mpWxEnAmaxF8pDPwf8tF46H4HU/eQL2g+8N5SyunmTDPi8TAUdqRlSv3F6rTZ/A14ScX5MQ5/26vMLpwysA/Wh575X3fvTZ83Nu2rC+9sMg8YzLZ8E6h+7X5FpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072348; c=relaxed/simple;
	bh=PuD/I5QXqYP/O4WImRLYF56eQyQMPoPQIYm7NEd+g1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWHIHspX2h+TqgBRfiL7nEsQ6Mh8kgXoLh0Nl+HazkD8oyt/0MFMGEdCFTQPiZpKsGIX/4Xfqpr1r/CCM+6BXxuxeYYR8eVkQQ5VhpaeDWpj+UpymbC/L65Dj+wuXWix/v20wp8q8WxXkMG9+o8um2b0BYeR0ryZDgunwH8nchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BJXp+8GE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQ1NImr3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BJXp+8GE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQ1NImr3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87D801F7B4;
	Fri,  4 Oct 2024 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN85Mr+H2PhAw1Iz0PjMb3XgLjDwYMp6X1VHr0q1Bds=;
	b=BJXp+8GEPFNTDEdYur3EAm2QxT3sALsWI7l5T/TrvQd0oPT+TyQ4lCGNvaRmDmJtZ28sF+
	Qjd5Ixlouo+S6/+g6BTvsmbh/7g0jaj8YMZ1N+3ALJErZ7BCbSlRB5h8y6mtb2SyEim1Oq
	XRKPr93bGNXCu+oHOipfn5w/AgbaDhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN85Mr+H2PhAw1Iz0PjMb3XgLjDwYMp6X1VHr0q1Bds=;
	b=jQ1NImr3LtK8L7T9jiE9aG2pWHbgkqE9uluHP/VCL6DtnLj2RSPPutT57PnkgDI+pmTceB
	oSNlN/gHikR2j2BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN85Mr+H2PhAw1Iz0PjMb3XgLjDwYMp6X1VHr0q1Bds=;
	b=BJXp+8GEPFNTDEdYur3EAm2QxT3sALsWI7l5T/TrvQd0oPT+TyQ4lCGNvaRmDmJtZ28sF+
	Qjd5Ixlouo+S6/+g6BTvsmbh/7g0jaj8YMZ1N+3ALJErZ7BCbSlRB5h8y6mtb2SyEim1Oq
	XRKPr93bGNXCu+oHOipfn5w/AgbaDhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN85Mr+H2PhAw1Iz0PjMb3XgLjDwYMp6X1VHr0q1Bds=;
	b=jQ1NImr3LtK8L7T9jiE9aG2pWHbgkqE9uluHP/VCL6DtnLj2RSPPutT57PnkgDI+pmTceB
	oSNlN/gHikR2j2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EC3113883;
	Fri,  4 Oct 2024 20:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FsSLNphKAGcYRgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:44 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/12] btrfs: define btrfs_iomap_read_folio_ops
Date: Fri,  4 Oct 2024 16:04:36 -0400
Message-ID: <3b91f2eb82e9b6614732dc2df03c41c63dfc0a12.1728071257.git.rgoldwyn@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use btrfs_bioset so iomap allocates btrfs_bio for bios to be submitted
for btrfs.

Set the file_offset of the bbio from the first folio in the bio.

For compressed/encoded reads, call btrfs_submit_compressed_read()
else call btrfs_submit_bbio()

After the read is complete, call iomap_read_end_io() to finish reads on
the folios.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/bio.c       |  2 +-
 fs/btrfs/bio.h       |  1 +
 fs/btrfs/extent_io.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 056f8a171bba..9d448235b8bd 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -15,7 +15,7 @@
 #include "file-item.h"
 #include "raid-stripe-tree.h"
 
-static struct bio_set btrfs_bioset;
+struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
 static struct bio_set btrfs_repair_bioset;
 static mempool_t btrfs_failed_bio_pool;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e48612340745..687a8361202a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -15,6 +15,7 @@
 struct btrfs_bio;
 struct btrfs_fs_info;
 struct btrfs_inode;
+extern struct bio_set btrfs_bioset;
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6ef2fa802c30..43418b6d4824 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -985,10 +985,39 @@ static int btrfs_read_iomap_begin(struct inode *inode, loff_t pos,
 	return 0;
 }
 
+static void btrfs_read_endio(struct btrfs_bio *bbio)
+{
+       iomap_read_end_io(&bbio->bio);
+}
+
+static void btrfs_read_submit_io(struct inode *inode, struct bio *bio,
+				 const struct iomap *iomap)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct folio_iter fi;
+
+	btrfs_bio_init(bbio, btrfs_sb(inode->i_sb), btrfs_read_endio, NULL);
+	bbio->inode = BTRFS_I(inode);
+
+	bio_first_folio(&fi, bio, 0);
+	bbio->file_offset = folio_pos(fi.folio);
+
+	if (iomap->type & IOMAP_ENCODED) {
+		bbio->bio.bi_iter.bi_sector = iomap->addr >> SECTOR_SHIFT;
+		btrfs_submit_compressed_read(bbio);
+	} else {
+		btrfs_submit_bbio(bbio, 0);
+	}
+}
+
 static const struct iomap_ops btrfs_buffered_read_iomap_ops = {
 	.iomap_begin = btrfs_read_iomap_begin,
 };
 
+static const struct iomap_read_folio_ops btrfs_iomap_read_folio_ops = {
+	.submit_io      = btrfs_read_submit_io,
+	.bio_set        = &btrfs_bioset,
+};
 
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
-- 
2.46.1


