Return-Path: <linux-fsdevel+bounces-31033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF0991053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9DA1F20FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78B1E7C01;
	Fri,  4 Oct 2024 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g0Z7/b0y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Ty92CDL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g0Z7/b0y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Ty92CDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648A1E572D;
	Fri,  4 Oct 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072355; cv=none; b=sPyXFAx2Aa0zNMBeLpIh4KsdNWR4D4vhTo7sQopJam6FwS8vmBKlflFMe8rIM0H8jOq7P0wgBis8d1WfFjjfeX7MPhPAAppvy2Q8r8niE8U9pjivrmkXh89YtHrT12q8AZtjGLfVuJMHKwtb+KsVGCXfXQrMVNdAXH5vudaIKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072355; c=relaxed/simple;
	bh=ziEcWdyrEd3AJEAja2+Tdj/EPxHT8uE15hsZbtn3Pxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3DbzIF4ybO6TKhXZS5C1Z7QadvTsSL2Chfxgpk6biYyQECbT6nRiJ+OtpNn46Z8oExyVZK4Tsoyby3YeEuraf30zKDJl46tCBtlSH9ErEHD3Rkymec2cFKS0KGs5j89pF32q45N/jTG7PCfS9SMOi37IwKq33soP8H9v2HU+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g0Z7/b0y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Ty92CDL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g0Z7/b0y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Ty92CDL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01DE321D52;
	Fri,  4 Oct 2024 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAdg/Dy5/k3zGiStjJba9gGroujDlcopd/g/2dyWjeo=;
	b=g0Z7/b0yipL2GJg7vA5MzCxf+kSNDfb/RjN/3koM3no+IXFhX/tuluzj3GEyslwfn69BTC
	HLZ0iwLsZlIxMedKOAq51fbZVj+88bEGZiNm5H06NJE3IG4X9ihFf2glNjHD2cto6nE/im
	udprZluijGq0KQTmpB/Dr0bEpTOgcOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAdg/Dy5/k3zGiStjJba9gGroujDlcopd/g/2dyWjeo=;
	b=5Ty92CDLpMEISrRnFu+m+HkKR0MRK3mxCu5voYI7leCPH14u3EnEJouOLnexpj4DgG7+aq
	9S+srC1Y8Amv6BDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAdg/Dy5/k3zGiStjJba9gGroujDlcopd/g/2dyWjeo=;
	b=g0Z7/b0yipL2GJg7vA5MzCxf+kSNDfb/RjN/3koM3no+IXFhX/tuluzj3GEyslwfn69BTC
	HLZ0iwLsZlIxMedKOAq51fbZVj+88bEGZiNm5H06NJE3IG4X9ihFf2glNjHD2cto6nE/im
	udprZluijGq0KQTmpB/Dr0bEpTOgcOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAdg/Dy5/k3zGiStjJba9gGroujDlcopd/g/2dyWjeo=;
	b=5Ty92CDLpMEISrRnFu+m+HkKR0MRK3mxCu5voYI7leCPH14u3EnEJouOLnexpj4DgG7+aq
	9S+srC1Y8Amv6BDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B44713883;
	Fri,  4 Oct 2024 20:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NLnYFZ9KAGcjRgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:51 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 11/12] btrfs: add read_inline for folio operations for read() calls
Date: Fri,  4 Oct 2024 16:04:38 -0400
Message-ID: <fb5e429f782d09d72544d940d4ab8d085d10e3d7.1728071257.git.rgoldwyn@suse.com>
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

Use the iomap read_inline() hook to fill data into the folio passed.
Just call btrfs_get_extent() again, because this time read_inline()
function has the folio present.

Comment:
Another way to do this is to bounce around btrfs_path all the way to
read_inline() function. This was getting too complicated with cleanup,
but should reduce the number of operations to fetch an inline extent.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ee0d37388441..01408bc5b04e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -909,8 +909,26 @@ static void btrfs_put_folio(struct inode *inode, loff_t pos,
 	folio_put(folio);
 }
 
+static int btrfs_iomap_read_inline(const struct iomap *iomap, struct folio *folio)
+{
+	int ret = 0;
+	struct inode *inode = folio->mapping->host;
+	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
+
+	lock_extent(&BTRFS_I(inode)->io_tree, 0, folio_size(folio) - 1, &cached_state);
+	em = btrfs_get_extent(BTRFS_I(inode), folio, 0, folio_size(folio));
+	unlock_extent(&BTRFS_I(inode)->io_tree, 0, folio_size(folio) - 1, &cached_state);
+	if (IS_ERR(em))
+		ret = PTR_ERR(em);
+	free_extent_map(em);
+	return ret;
+}
+
+
 static const struct iomap_folio_ops btrfs_iomap_folio_ops = {
 	.put_folio = btrfs_put_folio,
+	.read_inline = btrfs_iomap_read_inline,
 };
 
 static void btrfs_em_to_iomap(struct inode *inode,
-- 
2.46.1


