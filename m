Return-Path: <linux-fsdevel+bounces-31026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E853B991043
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FFA1F2323C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9FE1D959C;
	Fri,  4 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mY1gxnA2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A4GCrkmm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mY1gxnA2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A4GCrkmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0541D9586;
	Fri,  4 Oct 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072330; cv=none; b=CKAtAjpn7EwOZxOhCA0RxIpLfMWJ5v4fkPeb86wprNqcsAwMpwCSTBPMSos4c77B6PGay//0cUg7kUwsmiJ0PGjOQZ4xS8l2KpEbn/9t4Lh4XQ8JGIq193L/B44MB/sgvLGKjnqeg0glJR7efFQiMxxvLquuT/9zATp1DDec4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072330; c=relaxed/simple;
	bh=Ylmf39fNl3rrw2QwvEVjUjbX63Vqipfj3lQsGTZMzO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXr43eux4QXPdHBV6IKR8Q2k9ydnI1uzO++8QfwLyuzzM1jnON+8V5/VfT34lQuv5XWUCghcdvpy2NKIix/yi23GJ6Gh6goNn8i/+EF3z3kBFmkJItlFvlpKOZhv4Db/1g4WBYV8chFxwvAMNYpGuaNo5Aep/lo9gWo3JVfpzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mY1gxnA2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4GCrkmm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mY1gxnA2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4GCrkmm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D43521D52;
	Fri,  4 Oct 2024 20:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l912tuLUa+IEmsUS77BR6e/XwLT4qu25ITIvaRN17ZQ=;
	b=mY1gxnA2539lhMupkqYNLcSvRi3uQ+PN+4kFcLwb/bC9XMwZOG8NPLs75tn2XEj2Hk1qsm
	QqJ/BxMTPhUETJ0kXvIfFyyDKiK3tcEy0ZfLFnMjOCuWcOJrK2cAUNgkp3Y12JbnjXB/3r
	aO7zdHlYqRPDlselZOdjunvkVh9Lh8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l912tuLUa+IEmsUS77BR6e/XwLT4qu25ITIvaRN17ZQ=;
	b=A4GCrkmmS6cczQRr8xkq+RpeLX1Z0Cp+FFW5V3Q+8Z/qT0BObKUEPR4XEoa0H0PghnnsJ8
	caBMqv0sxNNHS9DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mY1gxnA2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A4GCrkmm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l912tuLUa+IEmsUS77BR6e/XwLT4qu25ITIvaRN17ZQ=;
	b=mY1gxnA2539lhMupkqYNLcSvRi3uQ+PN+4kFcLwb/bC9XMwZOG8NPLs75tn2XEj2Hk1qsm
	QqJ/BxMTPhUETJ0kXvIfFyyDKiK3tcEy0ZfLFnMjOCuWcOJrK2cAUNgkp3Y12JbnjXB/3r
	aO7zdHlYqRPDlselZOdjunvkVh9Lh8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l912tuLUa+IEmsUS77BR6e/XwLT4qu25ITIvaRN17ZQ=;
	b=A4GCrkmmS6cczQRr8xkq+RpeLX1Z0Cp+FFW5V3Q+8Z/qT0BObKUEPR4XEoa0H0PghnnsJ8
	caBMqv0sxNNHS9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A772113883;
	Fri,  4 Oct 2024 20:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3kTQHIZKAGfzRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:26 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/12] iomap: include iomap_read_end_io() in header
Date: Fri,  4 Oct 2024 16:04:31 -0400
Message-ID: <b608329aef0841544f380acede9252caf10a48c6.1728071257.git.rgoldwyn@suse.com>
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
X-Rspamd-Queue-Id: 1D43521D52
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

iomap_read_end_io() will be used BTRFS after it has completed the reads
to handle control back to iomap to finish reads on all folios.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 2 +-
 include/linux/iomap.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d007b4a8307c..0e682ff84e4a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -326,7 +326,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		folio_end_read(folio, uptodate);
 }
 
-static void iomap_read_end_io(struct bio *bio)
+void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f876d16353c6..7b757bea8455 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -280,6 +280,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
 		const struct iomap_read_folio_ops *);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
 		const struct iomap_read_folio_ops *);
+void iomap_read_end_io(struct bio *bio);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.46.1


