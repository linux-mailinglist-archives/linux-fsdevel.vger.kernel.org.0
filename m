Return-Path: <linux-fsdevel+bounces-79149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJZsA2O6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683A1ECCE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D41073153EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E939D6D9;
	Tue,  3 Mar 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQWs6zGP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="662EpqO8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQWs6zGP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="662EpqO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B839D6CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534113; cv=none; b=bols+TyNKuUF0e4TSJLMs2p+NHEK+8yjBpH2DnAoVUEkdRevh+E5o3keBrrxWUb2orfc2iFn560jiDEc6bvGzJT9N3bSfH/tmS9Oe++UqUzw3bcTQ6zrQx+jh4o1z6cinTVfaKGqbuSCwWWDZ7LU2N0C9ZNtXplFgsR/c2U2VNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534113; c=relaxed/simple;
	bh=IGpn2U38477v+c6PsdjKXPDX/u4w8/iXEhPzBY2PBAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8dXKQob9cwHHe7iCixNN4siRIcfiLUJCDKLArzRU+tc+qKbo0nVUqqbnXuITqgONWFJyNLa17kzx8YE+/GcqyHqBxUA0hmuQyC6Ndci8YtWfCXsez1hXOVoqlLi4UNCX5PwqWP7QpNrGmXWHL1u7gIvf6uyH0OQ4YIZDP3ZuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQWs6zGP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=662EpqO8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQWs6zGP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=662EpqO8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4A9C3F8F1;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BrEbcwxHzsuw5/1iQnP6jk/azHihcilg6iUu/naUsg=;
	b=sQWs6zGPYLXKaYf9cvr1oyKMK4RgMpnvEfedtkA5GV4fopa4whQfkn6EsrbAH7+/wBeGJL
	ZNaI8ZUJRCUiUkY2yq6ydwP8faMROvV3MX9MKXq0GnhmDiEgnAd89FFyivExEF9Xy57cDs
	Th+8QQdzaXioKukJiGLAcCKUtPky0as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BrEbcwxHzsuw5/1iQnP6jk/azHihcilg6iUu/naUsg=;
	b=662EpqO8HHYWgaVUqeEtdELcTIeiD0t55bGUqR7mw5HjDCgqE0NJLZ78EE953OAgbNcgrx
	KiBo2dHpqmFDuDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BrEbcwxHzsuw5/1iQnP6jk/azHihcilg6iUu/naUsg=;
	b=sQWs6zGPYLXKaYf9cvr1oyKMK4RgMpnvEfedtkA5GV4fopa4whQfkn6EsrbAH7+/wBeGJL
	ZNaI8ZUJRCUiUkY2yq6ydwP8faMROvV3MX9MKXq0GnhmDiEgnAd89FFyivExEF9Xy57cDs
	Th+8QQdzaXioKukJiGLAcCKUtPky0as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BrEbcwxHzsuw5/1iQnP6jk/azHihcilg6iUu/naUsg=;
	b=662EpqO8HHYWgaVUqeEtdELcTIeiD0t55bGUqR7mw5HjDCgqE0NJLZ78EE953OAgbNcgrx
	KiBo2dHpqmFDuDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7E5C3EA69;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DfutNES5pmlkFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E7B7A0AFD; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/32] ext4: Sync and invalidate metadata buffers from ext4_evict_inode()
Date: Tue,  3 Mar 2026 11:33:54 +0100
Message-ID: <20260303103406.4355-37-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=jack@suse.cz; h=from:subject; bh=IGpn2U38477v+c6PsdjKXPDX/u4w8/iXEhPzBY2PBAQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkiwvoOz0rMEX/Q3fhsgA4Ot0pM7sp6flswL aWQHP6KuUWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5IgAKCRCcnaoHP2RA 2VnHCACqstiVFtyMN9RhMfncMO1Ev44P2kUvv/aYJoePCuTOIE+9vai6hetbUiwxr+tAZAaRqX4 TDkl2nwgsJ7fp92ylLb1+FFtpQTdkIzI6F7fVWcjJ0V0naqyZX2Mavnp5EOyZJBWP/1Yx0iy9eN KEMnlDQqNf2TmO9ocTFD4rxLgbJS3pIH7vmjGaxgEjCCmnHCl0bPiW5kkkKkF5oTYw8r9dCLx6Z P4Q87rkalL5TI5os2Nl1ncKmAo6HJHNurYSaUIeqgsIiSWNbSDCfEEjInh+EeZw3wsls88BREZn 7sxW20dAcaEUXrolKyv2VNzV5Mf/Nj1k6aiPk8n5PHGNS9a+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6683A1ECCE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79149-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There are only very few filesystems using generic metadata buffer head
tracking and everybody is paying the overhead. When we remove this
tracking for inode reclaim code .evict will start to see inodes with
metadata buffers attached so write them out and prune them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 +++-
 fs/ext4/super.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b..c2692b9c7123 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -185,7 +185,9 @@ void ext4_evict_inode(struct inode *inode)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
 		truncate_inode_pages_final(&inode->i_data);
-
+		/* Avoid mballoc special inode which has no proper iops */
+		if (!EXT4_SB(inode->i_sb)->s_journal)
+			sync_mapping_buffers(&inode->i_data);
 		goto no_delete;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 43f680c750ae..ea827b0ecc8d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1524,7 +1524,8 @@ static void destroy_inodecache(void)
 void ext4_clear_inode(struct inode *inode)
 {
 	ext4_fc_del(inode);
-	invalidate_inode_buffers(inode);
+	if (!EXT4_SB(inode->i_sb)->s_journal)
+		invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
-- 
2.51.0


