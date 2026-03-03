Return-Path: <linux-fsdevel+bounces-79155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dPowNZy6pmkPTQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102B1ECD42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B45230E7866
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6139C623;
	Tue,  3 Mar 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="03MCN+dR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RFA4Hsw9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="03MCN+dR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RFA4Hsw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5813822B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534132; cv=none; b=Yi2NHy1ofQB/eDvj/ZxLilK4xL5Nql8WbURkhuxKY15eclwvnzwKdsq3cUvaRIfeCUJslUrrjVLiQ04Jzr8r1sw32cB35HdTqJexL4Wovjh9TCaOPj5ytHc68H0Dsfz3pGJtPV9uGVEzNDp75kqb+rxSsGeg0s7H6l9LiFb+gT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534132; c=relaxed/simple;
	bh=xOXiQzAtrNWDiR7AO50veb6qdtBrMAe4XfXWWLiNxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6qUtI+rb9gRQVDJgj1PYiujyv9b/TYsjNILjHjj4eHLu79cVUfKQe6YzeIUcUZJbPqEh3q5ukLzK9z3Div1AYHt/mYAlQF3Ovw8JJZxfOAh0PzbjWv+b6U0NP3Ozd4G4N8neLOdwd9lka5P+EHwWA6bfGq4xF+HdUmsygmlV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=03MCN+dR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RFA4Hsw9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=03MCN+dR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RFA4Hsw9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 097A53F91A;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPthJE6VVMGk/qjtQ/G9eE0lKHs2glQSc7ppBVHf+S0=;
	b=03MCN+dR1GVa7o9znWI2olxlHaWCH06h06tIe9FA/qKtVOg0uo3eHyIlIojahXdqfHZkCT
	/VaNr0VTeHaeDtBt9YCsPa4KdjKfjUrRPYW+n3IVC3PoCdKeqRgiZOxu+wUrlarOhOtGBX
	L7x7AbNR9g5MQmcXTrfVyiBk7jn8I6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPthJE6VVMGk/qjtQ/G9eE0lKHs2glQSc7ppBVHf+S0=;
	b=RFA4Hsw9cN7NoXU+etKkvj9XHg7IbEpOJNGzgfI8A/ptlUTmzCIQsIk80olHe09GcVmL2s
	Am+0L1MMLdEJX8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPthJE6VVMGk/qjtQ/G9eE0lKHs2glQSc7ppBVHf+S0=;
	b=03MCN+dR1GVa7o9znWI2olxlHaWCH06h06tIe9FA/qKtVOg0uo3eHyIlIojahXdqfHZkCT
	/VaNr0VTeHaeDtBt9YCsPa4KdjKfjUrRPYW+n3IVC3PoCdKeqRgiZOxu+wUrlarOhOtGBX
	L7x7AbNR9g5MQmcXTrfVyiBk7jn8I6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPthJE6VVMGk/qjtQ/G9eE0lKHs2glQSc7ppBVHf+S0=;
	b=RFA4Hsw9cN7NoXU+etKkvj9XHg7IbEpOJNGzgfI8A/ptlUTmzCIQsIk80olHe09GcVmL2s
	Am+0L1MMLdEJX8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7373EA6C;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DPkDOkS5pmluFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A025EA0B47; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Subject: [PATCH 11/32] gfs2: Don't zero i_private_data
Date: Tue,  3 Mar 2026 11:34:00 +0100
Message-ID: <20260303103406.4355-43-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=jack@suse.cz; h=from:subject; bh=xOXiQzAtrNWDiR7AO50veb6qdtBrMAe4XfXWWLiNxX8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprknbtjHRMGivtKh5++SBYmELyG3KBGp9gefM MGDwJ6NPnGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5JwAKCRCcnaoHP2RA 2fx1B/kBKNGudUfUYTJuii1aG06VLA/8KFxWPRhB/7z2V9FoDKcR1RHvsBw6gjXgvNcYsyAfcta Su7QOV47Wo9rvgttIYC1ZeAwkxwrURJzVbVIbPNxRaRTPY4iLGivNJQdohTBhrjCdGZxLpkpT3g NNhO8eouLhfk/wjZOkfKXPitXt5O5QT8p8AgMwxgekOB4Zh64imv/x4UHbDUgrDrFF6z5Ps50bx MIsbDXr8dS2nOk5TGRodIhxGCv7yBF+l8lS6Ss5ixIrl9uRQ18v0/rs38VQVcWkg4V8vExQ88S+ YdfbBGrMD5nC6yH7OLMjT08VmyZrxHtf8Rz0N+NBKLWxizrh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4102B1ECD42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-79155-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz,redhat.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The zeroing is the only use within gfs2 so it is pointless.

CC: Andreas Gruenbacher <agruenba@redhat.com>
CC: gfs2@lists.linux.dev
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2acbabccc8ad..b8a144d3a73b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1149,7 +1149,6 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		mapping->flags = 0;
 		gfp_mask = mapping_gfp_mask(sdp->sd_inode->i_mapping);
 		mapping_set_gfp_mask(mapping, gfp_mask);
-		mapping->i_private_data = NULL;
 		mapping->writeback_index = 0;
 	}
 
-- 
2.51.0


