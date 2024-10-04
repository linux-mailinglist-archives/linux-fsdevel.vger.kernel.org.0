Return-Path: <linux-fsdevel+bounces-31034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB082991059
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267B2B28EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996831E7C1C;
	Fri,  4 Oct 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CsbIGiaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d7yWeA6z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CsbIGiaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d7yWeA6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DF1E5738;
	Fri,  4 Oct 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072358; cv=none; b=Yyb1P0B7E80uvnNNdhdziUVMbK3qGgsSkXW3Xa4VSSDM/cuyaXjWB1a7r1aRI+Fax2StIXvJzh0p2d9WYo8s7Q/Y0Y6g99hvMvcjS3Ls9KeFMqETao0l636S0d58YNlHrciQMXckpedGCRxii57cj3AhxaL0kBjd1uEoKd37NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072358; c=relaxed/simple;
	bh=jfjst3E5k0T2B6zwqixGj4yYauvR0JGYmKe7AjK0JHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHUAEKy9ncZWHunb91gmy4L8gV5p03NbuQX3tIXpX4wFKfPlufm+/DPhDx1GvDQcV8XBxp1MzXM+NpmImm5GPL/dFh2b44GmOiFhOB5zY5W1TyqaOH0AhX1X1g1W8LAFcHNwNJ4mNLtz39F98/HldVQVphwDsk0f00e15I2V9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CsbIGiaK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d7yWeA6z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CsbIGiaK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d7yWeA6z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5ADA1F7B4;
	Fri,  4 Oct 2024 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bhyoD+vXWDSv7I9433nLLALeIWNmirY85fvj5iloo=;
	b=CsbIGiaKDGGN2nqjI53FXD00QOoqin/aPN8c7JdYHSgcHKhOd1+CoHWO5yaIEwSfxHCCh0
	TXbld0F7GwBlI0gQNYd7rhTtSu+2uiP9yTaEsdsF3CWxrBw1jsFT4DdralN2eNJq7GQ+ZS
	3JcCJD7KXXqOdNWNDyMvsyh9QY/2LOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bhyoD+vXWDSv7I9433nLLALeIWNmirY85fvj5iloo=;
	b=d7yWeA6zvalmhHwcTTgWyG1nkkXiJVhJOZeyVXS/vymXeJpZ0HhzSBSnKcgNOILL5DuBog
	hLSZX88KUFWQt3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bhyoD+vXWDSv7I9433nLLALeIWNmirY85fvj5iloo=;
	b=CsbIGiaKDGGN2nqjI53FXD00QOoqin/aPN8c7JdYHSgcHKhOd1+CoHWO5yaIEwSfxHCCh0
	TXbld0F7GwBlI0gQNYd7rhTtSu+2uiP9yTaEsdsF3CWxrBw1jsFT4DdralN2eNJq7GQ+ZS
	3JcCJD7KXXqOdNWNDyMvsyh9QY/2LOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4bhyoD+vXWDSv7I9433nLLALeIWNmirY85fvj5iloo=;
	b=d7yWeA6zvalmhHwcTTgWyG1nkkXiJVhJOZeyVXS/vymXeJpZ0HhzSBSnKcgNOILL5DuBog
	hLSZX88KUFWQt3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AF5F13883;
	Fri,  4 Oct 2024 20:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzjgDaJKAGcqRgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:54 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 12/12] btrfs: switch to iomap for buffered reads
Date: Fri,  4 Oct 2024 16:04:39 -0400
Message-ID: <edc8da1d3d6c5a09662a7a788dc17c963f50dfab.1728071257.git.rgoldwyn@suse.com>
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

For buffered reads, call iomap_readahead() and iomap_read_folio().

This is limited to non-subpage calls.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 01408bc5b04e..cfe771cebb36 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1205,9 +1205,15 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
+	struct inode *inode = folio->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em_cached = NULL;
 	int ret;
 
+	if (!btrfs_is_subpage(fs_info, inode->i_mapping))
+		return iomap_read_folio(folio, &btrfs_buffered_read_iomap_ops,
+				&btrfs_iomap_read_folio_ops);
+
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	free_extent_map(em_cached);
 
@@ -2449,10 +2455,17 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
+	struct inode *inode = rac->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct folio *folio;
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
+	if (!btrfs_is_subpage(fs_info, rac->mapping)) {
+		iomap_readahead(rac, &btrfs_buffered_read_iomap_ops, &btrfs_iomap_read_folio_ops);
+		return;
+	}
+
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
-- 
2.46.1


