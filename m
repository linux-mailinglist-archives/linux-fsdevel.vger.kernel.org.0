Return-Path: <linux-fsdevel+bounces-73107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF05D0CE53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AAEF3048BB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC326529A;
	Sat, 10 Jan 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TqqD8T6o";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XSK1hU4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367826E6F8
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017419; cv=none; b=vEUzSsHQPbItNXdZt4Kx1DsWb0Hjncze4je/Mlm976Dvb7ZnutqOrJUnmV/kk7uxP4hUtUpcwE0SniEDOb8t42hFBY3rcx6vtxRaSj6FfoxAixe4px3lv6Yy1EoG6XeGYpVq7WSsy+xwsfnAXQRbWrWwFjvzvwdcqMKar4pmgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017419; c=relaxed/simple;
	bh=Tq2VSDicnJ3/HuM4fSQ710cEQxkoe5+raE33VtTXYPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7N9ALcNS87Jy9NpEqG7IKaR6tv9Mj/7k6erKeujF/LuX32QzJerO5ciP7kc4RhR7br/7wGv3tXCxgPt/s3ckrvwhKyXZLlHudM7YDEtGJQ/l6joPc29wk7oLRE1bg6qL8vUQJ3ksfZ7btrViToe8idrwQwjoDYBvIK3EPNCP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TqqD8T6o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XSK1hU4T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFE275BCE4;
	Sat, 10 Jan 2026 03:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7K+iJAKu9W/3o+edB9PU4EpwvE8KBa9zxkB6dHkKgI=;
	b=TqqD8T6o7Za5/+imW0djYuqQbfsYI53t6+bXhehS0Z1skjYu1E++aeSCV4aEBId6neP38A
	PltV2TUPenOTix8JSxH0Pdi2CrM3w0UfY/Vrn3S6SKlUWQXcuSvkEde0V6LxCNP+vFsszt
	iTJT+U9crWCw+sr+DRXF5YKkh5gcfjI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XSK1hU4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7K+iJAKu9W/3o+edB9PU4EpwvE8KBa9zxkB6dHkKgI=;
	b=XSK1hU4TRsAxF0f1Jlf4rwmHnQfSkyLve7iys7p4AhY/XS6gHs46ob8L/3pJ/mZk3UFKgJ
	50CBTdK32GxjZtj5VCwHQvbHOcTEOAYhcUozCftylasNZRppI0pxiTC+9EqQKbL7Gw4DXt
	h3UwXNJ2Wg0Q7pmYiEzu+saExqh7ZYQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A08F3EA63;
	Sat, 10 Jan 2026 03:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kP8zD/vNYWlqLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 10 Jan 2026 03:56:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: minor improvement on super block writeback
Date: Sat, 10 Jan 2026 14:26:20 +1030
Message-ID: <9faf8ee5927455018e55bdca32c5299ba3b5e1ec.1768017091.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768017091.git.wqu@suse.com>
References: <cover.1768017091.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFE275BCE4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

This includes:

- Move the write error handling out of the folio iteration
  This is not a big deal, since our super block is never going to be
  larger than a single page.

- Add a comment on why we want to lock the folio for writeback
  And the fact that we use folio locked state to track if the write has
  finished.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0dd77b56dfdf..96b7b71e6911 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3650,24 +3650,24 @@ static void btrfs_end_super_write(struct bio *bio)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		if (bio->bi_status) {
-			btrfs_warn_rl(device->fs_info,
-				"lost super block write due to IO error on %s (%d)",
-				btrfs_dev_name(device),
-				blk_status_to_errno(bio->bi_status));
-			btrfs_dev_stat_inc_and_print(device,
-						     BTRFS_DEV_STAT_WRITE_ERRS);
-			/* Ensure failure if the primary sb fails. */
-			if (bio->bi_opf & REQ_FUA)
-				atomic_add(BTRFS_SUPER_PRIMARY_WRITE_ERROR,
-					   &device->sb_write_errors);
-			else
-				atomic_inc(&device->sb_write_errors);
-		}
 		folio_unlock(fi.folio);
 		folio_put(fi.folio);
 	}
 
+	if (bio->bi_status) {
+		btrfs_warn_rl(device->fs_info,
+			"lost super block write due to IO error on %s (%d)",
+			btrfs_dev_name(device),
+			blk_status_to_errno(bio->bi_status));
+		btrfs_dev_stat_inc_and_print(device,
+					     BTRFS_DEV_STAT_WRITE_ERRS);
+		/* Ensure failure if the primary sb fails. */
+		if (bio->bi_opf & REQ_FUA)
+			atomic_add(BTRFS_SUPER_PRIMARY_WRITE_ERROR,
+				   &device->sb_write_errors);
+		else
+			atomic_inc(&device->sb_write_errors);
+	}
 	bio_put(bio);
 }
 
@@ -3721,6 +3721,15 @@ static int write_dev_supers(struct btrfs_device *device,
 		btrfs_csum(fs_info->csum_type, (const u8 *)sb + BTRFS_CSUM_SIZE,
 			   BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, sb->csum);
 
+		/*
+		 * Lock the folio containing the super block.
+		 *
+		 * This will prevent user space dev scan from getting half-backed
+		 * super block.
+		 *
+		 * Also keep the folio locked until write finished, as a way to
+		 * track if the write has finished.
+		 */
 		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
 					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 					    GFP_NOFS);
-- 
2.52.0


