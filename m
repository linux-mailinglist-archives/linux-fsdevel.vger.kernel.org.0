Return-Path: <linux-fsdevel+bounces-79147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOvTKE26pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E51ECCC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4061C30CE856
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515A31B114;
	Tue,  3 Mar 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3zBfOEm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYiwz28S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3zBfOEm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYiwz28S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9F39890C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534106; cv=none; b=S9zsnXtbkT8Hqzxa2+/od7kh/6TAP4tqNZz8GgyDVHyNhf19KeXkUUqR7Naj8vvl7x+fP7qmU126Cto/pmqrr5QkBFW51/ej9OUQpRHXR3EySMda3B5qLNj5/EZoxJ+jwI2/kj/xOA6vrJ4nMNINV0lMGQbmosjGxw78UYryPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534106; c=relaxed/simple;
	bh=K9wrCKmeO7BfHLYf4wsyZtDcyuSx9fmOTys9wQHOC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONGLKAIo3KUd9fSIBYfzwNVK/bgdsLdv2X1SODZF9wXunmsSlTMXfKg7/yz097lL2OiJHT381OIARF/xpYbKgyG+zoVK9MEbesYJugD3W4hFVDPfC4t84/6XOTu4LwNL6/VIjTc7rYdAA3XvfOngQVsasThmp2Auj0bpD8ot09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3zBfOEm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYiwz28S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3zBfOEm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYiwz28S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E625A3F8F5;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIk+3PM+jG2PiQ44UnRCyz0Pc5nehV9CBwg+OwnTyLw=;
	b=O3zBfOEmswK/ytkTA6R+NKxminmWN9raaPx+DDA8G6HEaUf1hV5TXIsSkgyryuuFkJz2nG
	pjyQkyNFZpV2ge+5DrFOVEiQBLJ5Y5xEoL1vvI4CO3OHvrYWEx+SVSTQ2HbV/9sc9dDTfV
	pDBq4x4p5qQ075pAM2h6ugKlanJqgCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIk+3PM+jG2PiQ44UnRCyz0Pc5nehV9CBwg+OwnTyLw=;
	b=AYiwz28S7e6WKGWDkovy93oKVAOkYtd2/WXEA7MNma3vwGoP3ekJUV5vEsPpsbjEbgH0sk
	dLp91HkIhcHzg6Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIk+3PM+jG2PiQ44UnRCyz0Pc5nehV9CBwg+OwnTyLw=;
	b=O3zBfOEmswK/ytkTA6R+NKxminmWN9raaPx+DDA8G6HEaUf1hV5TXIsSkgyryuuFkJz2nG
	pjyQkyNFZpV2ge+5DrFOVEiQBLJ5Y5xEoL1vvI4CO3OHvrYWEx+SVSTQ2HbV/9sc9dDTfV
	pDBq4x4p5qQ075pAM2h6ugKlanJqgCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIk+3PM+jG2PiQ44UnRCyz0Pc5nehV9CBwg+OwnTyLw=;
	b=AYiwz28S7e6WKGWDkovy93oKVAOkYtd2/WXEA7MNma3vwGoP3ekJUV5vEsPpsbjEbgH0sk
	dLp91HkIhcHzg6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4683EA6D;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2K4ENkS5pmlmFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7F836A0B2F; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 07/32] bfs: Sync and invalidate metadata buffers from bfs_evict_inode()
Date: Tue,  3 Mar 2026 11:33:56 +0100
Message-ID: <20260303103406.4355-39-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=jack@suse.cz; h=from:subject; bh=K9wrCKmeO7BfHLYf4wsyZtDcyuSx9fmOTys9wQHOC9M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkjZOEr4SoMR6litD6xJZ9vyOu7Qv8MRlaIP MceIDomSlWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5IwAKCRCcnaoHP2RA 2VB+CADgFJh19nlSbb70V3fRZwmBUEdqZKelbD2FwM1YKdE3CysN9YBk3d+n0xXje5DqWmFag7J CxfH7uwKQu1nkTgmg+d3F0Ykl3vPQVHl1hA33iwJP/xJWFW2W4lQjysTSuRfixonmgSXdix48eW +LiYGnMgXGA6ywu9FKZ4mrqy9/DP+Xntvp6P98n+Sl5btTcyfCxHgL774GZz9EQ5iFewtj6l0ad 2TGEA8v4kTLREsHeER1VFM3L8LOfwT/7/vrigo9gLT9URxDK1F3nsy8O40f/UX+DZy2n9fg2zf0 sJFonpT5GTYRGT6Ot4tf8e2X7k4qszNew0ctiXB2Zr+DkncM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 442E51ECCC7
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
	TAGGED_FROM(0.00)[bounces-79147-lists,linux-fsdevel=lfdr.de];
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
 fs/bfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 9da02f5cb6cd..e0e50a9dbe9c 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -187,6 +187,8 @@ static void bfs_evict_inode(struct inode *inode)
 	dprintf("ino=%08lx\n", ino);
 
 	truncate_inode_pages_final(&inode->i_data);
+	if (inode->i_nlink)
+		sync_mapping_buffers(&inode->i_data);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 
-- 
2.51.0


