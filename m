Return-Path: <linux-fsdevel+bounces-42712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98390A46734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833DC188B0CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4C221D80;
	Wed, 26 Feb 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kWx2vqNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q3CoRUW3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kWx2vqNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q3CoRUW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AE19005F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588684; cv=none; b=VxZh39VJlRxY/GvwXYNEmWK82hkm5Bo34degnqENuZ0bMFi2S9kc/niWptCHSFk81W+oTv+5gQA/rlWy8ShCkfOrWg7UM28qk8HC+8dRT7DgVeNxk2sc/pF44U4VZq2HeMTw8VRsb8CZfApXeK+IQi60vGCRFePpMXwzGH15avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588684; c=relaxed/simple;
	bh=5jWJt3ElwBSSlxHT3NPsO0/q1f37q8MaoI6ZKsnGtW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=giivQmbEYCylTAPR/6ClY1QEim0cFp7ye8m8mEZOngxj3kimvL2jMA7QiV+R37Q7jH2KXuU/xmKZlH3uv0T5qI++RJ/T+OJJbSKmDKlmZEMcNk2EdzxThxKleBRGEYf2Tum79bxOE1CS9x1wt6YzpSGLJN194ymBnygByqytM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kWx2vqNr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q3CoRUW3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kWx2vqNr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q3CoRUW3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A03B1F749;
	Wed, 26 Feb 2025 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740588681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8yyGtTaR7N11F7GCU59T57WH0cFUEXFUtFmmmXpX2zw=;
	b=kWx2vqNr6TSLqLMcGc+BDVbkrk1l2WCF32XjGvIG6V9kIv6G7DRp2yIokbiQ+SiEWOh806
	nCQMHVAfmu5lVuRRh2AdW7IQmzNT+R0R1q6WoKIFJJ8UmPfYTF+SVAKgrISt/Zk2/x3qpf
	tMMD6lM+MDFdULdg1UeeBCM/D+C8LXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740588681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8yyGtTaR7N11F7GCU59T57WH0cFUEXFUtFmmmXpX2zw=;
	b=q3CoRUW3fLPxWz9JETDuf7O1sTfWjsFJCxuktR3HmbAkjXKBtTdFH9TZYBg4aRe6H6/yLu
	+X1PmpXu5d8xJ7DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740588681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8yyGtTaR7N11F7GCU59T57WH0cFUEXFUtFmmmXpX2zw=;
	b=kWx2vqNr6TSLqLMcGc+BDVbkrk1l2WCF32XjGvIG6V9kIv6G7DRp2yIokbiQ+SiEWOh806
	nCQMHVAfmu5lVuRRh2AdW7IQmzNT+R0R1q6WoKIFJJ8UmPfYTF+SVAKgrISt/Zk2/x3qpf
	tMMD6lM+MDFdULdg1UeeBCM/D+C8LXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740588681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8yyGtTaR7N11F7GCU59T57WH0cFUEXFUtFmmmXpX2zw=;
	b=q3CoRUW3fLPxWz9JETDuf7O1sTfWjsFJCxuktR3HmbAkjXKBtTdFH9TZYBg4aRe6H6/yLu
	+X1PmpXu5d8xJ7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F5F1377F;
	Wed, 26 Feb 2025 16:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AkHLAYlGv2dqdgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 26 Feb 2025 16:51:21 +0000
Date: Wed, 26 Feb 2025 11:51:19 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de
Subject: [PATCH] make sure IOMAP_F_BOUNDARY does not merge with next IO
Message-ID: <hgvgztw7ip3purcsaxxozt3qmxskgzadifahxxaj3nzilqqzcz@3h7bcaeoy6gl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

If the current ioend is built for iomap with flags set to
IOMAP_F_BOUNDARY and the next iomap does not have IOMAP_F_BOUNDARY set,
IOMAP_F_BOUNDARY will not be respected because the iomap structure has
been overwritten during the map_blocks call for the next iomap. Fix this
by checking both iomap.flags and ioend->io_flags for IOMAP_F_BOUNDARY.

Fixes: 64c58d7c9934 ("iomap: add a merge boundary flag")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d303e6c8900c..0e2d24581bd3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1739,7 +1739,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 {
-	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+	if (wpc->iomap.offset == pos &&
+	    ((wpc->iomap.flags | wpc->ioend->io_flags) & IOMAP_F_BOUNDARY))
 		return false;
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))

-- 
Goldwyn

