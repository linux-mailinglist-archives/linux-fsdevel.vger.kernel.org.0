Return-Path: <linux-fsdevel+bounces-31032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83869910B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A192CB2C5E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582001E5726;
	Fri,  4 Oct 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kHV6nNBC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8bODU4BO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kHV6nNBC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8bODU4BO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372911E570E;
	Fri,  4 Oct 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072351; cv=none; b=LUdFmX7Q1zqIqrt15dWKSCwWNhRuHxgxeij9A1S05Z9mJY+k9Tmlc1bqNUwgLEZak8js5L4drIr/EAG+xUleD5mXXi9JptSlq305xsIU4JnWFQQBHFX8in2ZphAPOAV+Q5qw/zdkE4a8EcR2h+zbpnR9wxCQVpuONdtBAqq156U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072351; c=relaxed/simple;
	bh=yfGJjnBSUPGrHM1dD5nGyR1mtPukB3paH1VRSRCcrUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOzxWLGPigB83h/1ddO/jiyfMdzOefoyNuvwEaCiH8ERTABUjCRRb8XrFpixve5tpuXK4dmQ+iGO3+OwS8tHVgit/ByHa8cihgu5S2Dqtik1GZpQw5aJeY0ZSLLfPSuysmspod+0SQ0dW7+YciBu82DV29v6rhhEfN0o21nmL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kHV6nNBC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8bODU4BO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kHV6nNBC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8bODU4BO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76B0721D52;
	Fri,  4 Oct 2024 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtZfPO1TX+6o6miSxN7nepDGS71ntxoJ0o0onBRQM6o=;
	b=kHV6nNBC6UjmyEp1Vd2HeWiT8gdRTpioxaBRqRfNG5yYG64VtroUOUzpJcR5eNbDtYwpc0
	FgEvzAWhGcCeF+GdiPxaK+HZf40CT0EAtg585+tr9tfOudVqaQRQuf75pMbLn6EePPxVYH
	mWBkJI8gKK+XpXBK3jdc9Ls4qXST4Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtZfPO1TX+6o6miSxN7nepDGS71ntxoJ0o0onBRQM6o=;
	b=8bODU4BO6xTKeiYe8R7VUHkxDGU0LHWTa25fhvd57+wXb0/hX8zi0VwVud3FwoIAGKHNr8
	7CY6pt3UszZq7LBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kHV6nNBC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8bODU4BO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtZfPO1TX+6o6miSxN7nepDGS71ntxoJ0o0onBRQM6o=;
	b=kHV6nNBC6UjmyEp1Vd2HeWiT8gdRTpioxaBRqRfNG5yYG64VtroUOUzpJcR5eNbDtYwpc0
	FgEvzAWhGcCeF+GdiPxaK+HZf40CT0EAtg585+tr9tfOudVqaQRQuf75pMbLn6EePPxVYH
	mWBkJI8gKK+XpXBK3jdc9Ls4qXST4Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtZfPO1TX+6o6miSxN7nepDGS71ntxoJ0o0onBRQM6o=;
	b=8bODU4BO6xTKeiYe8R7VUHkxDGU0LHWTa25fhvd57+wXb0/hX8zi0VwVud3FwoIAGKHNr8
	7CY6pt3UszZq7LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1566313883;
	Fri,  4 Oct 2024 20:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kb23NJtKAGceRgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:47 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/12] btrfs: define btrfs_iomap_folio_ops
Date: Fri,  4 Oct 2024 16:04:37 -0400
Message-ID: <3ff1d03f6be91450830060372337b27c0a600d38.1728071257.git.rgoldwyn@suse.com>
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
X-Rspamd-Queue-Id: 76B0721D52
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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

The put_folio() sets folio->private to EXTENT_PAGE_PRIVATE if not
already set using set_page_extent_mapped().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 43418b6d4824..ee0d37388441 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -901,6 +901,18 @@ void clear_folio_extent_mapped(struct folio *folio)
 	folio_detach_private(folio);
 }
 
+static void btrfs_put_folio(struct inode *inode, loff_t pos,
+		unsigned copied, struct folio *folio)
+{
+	set_folio_extent_mapped(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+static const struct iomap_folio_ops btrfs_iomap_folio_ops = {
+	.put_folio = btrfs_put_folio,
+};
+
 static void btrfs_em_to_iomap(struct inode *inode,
 		struct extent_map *em, struct iomap *iomap,
 		loff_t sector_pos, bool write)
@@ -928,6 +940,7 @@ static void btrfs_em_to_iomap(struct inode *inode,
 	iomap->offset = em->start;
 	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = em->len;
+	iomap->folio_ops =  &btrfs_iomap_folio_ops;
 }
 
 static struct extent_map *__get_extent_map(struct inode *inode,
-- 
2.46.1


