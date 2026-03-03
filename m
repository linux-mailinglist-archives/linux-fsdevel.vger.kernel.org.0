Return-Path: <linux-fsdevel+bounces-79158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFtgAeK5pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86B1ECBEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1EAE30928F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076B38836C;
	Tue,  3 Mar 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u0Y+D/ZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V96DDmGf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u0Y+D/ZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V96DDmGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F0386C2C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534144; cv=none; b=NFXt1xy+6Jp+/aC0zvb+X+6rNgO/w/GNPu/QqOlAT/+aAcMmN5apGGKp1GyoqaEQrbG6oQL4I9DY9xf+3vDYf74+4M5q1NfXNwDFtsnAPuXQ4/gBXHC6+JhLTL9rtqfzN9ySBcgQg80a+bNi2DWV82pO/pt81WGFS3u8QKMlSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534144; c=relaxed/simple;
	bh=pZUzO0hnYx3VPJNnxZXYMMaUnllZ7MJ4fz1iv846qsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2T3/Cqu3z4Me6rYZN+Qv5d10cwBDsqp+MctOVOC/bKwlA9byxH7KXXlWVwCEQ7P6xm7y9J4vx0OpNt3T4Qu4O3m14rkaSUaZWKGtVjIVTjTB+8F+4+sEtzzSu3H4+NGNHDa1C0mUc3jXwNPmnRf3Z92yvG1fBEyLxh6G3UK4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u0Y+D/ZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V96DDmGf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u0Y+D/ZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V96DDmGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 546605BE2C;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs1A0J2AL1T/IRKBpTjU944a9ZIMa3+5mBAmaRi4STY=;
	b=u0Y+D/ZLQjwNHn/rJbBqYq/oVB+Zu+ul3X2eXycKEhrl4KbA/onpHPVFS+U4lD9TeZWl0w
	IQYDOUDtTgZljTqDswasRT+WkS0tCgXgtfg1SxW10enGLwGXxtyMcavW4hpOlE7Wj5Q0we
	BGjEigMR5vVxqSWn9LffANSKwqQSBcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs1A0J2AL1T/IRKBpTjU944a9ZIMa3+5mBAmaRi4STY=;
	b=V96DDmGfvVXm8bYh0kF0rVvHsKTkKq2C7/BZbgPcuYbNJEJgFGMjbw+BgEKMBsPONLOKOl
	MLYjzMhXwGAm/4AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs1A0J2AL1T/IRKBpTjU944a9ZIMa3+5mBAmaRi4STY=;
	b=u0Y+D/ZLQjwNHn/rJbBqYq/oVB+Zu+ul3X2eXycKEhrl4KbA/onpHPVFS+U4lD9TeZWl0w
	IQYDOUDtTgZljTqDswasRT+WkS0tCgXgtfg1SxW10enGLwGXxtyMcavW4hpOlE7Wj5Q0we
	BGjEigMR5vVxqSWn9LffANSKwqQSBcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs1A0J2AL1T/IRKBpTjU944a9ZIMa3+5mBAmaRi4STY=;
	b=V96DDmGfvVXm8bYh0kF0rVvHsKTkKq2C7/BZbgPcuYbNJEJgFGMjbw+BgEKMBsPONLOKOl
	MLYjzMhXwGAm/4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 489E53EA6D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aSi7EUW5pmmQFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 162C6A0B79; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 24/32] affs: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:13 +0100
Message-ID: <20260303103406.4355-56-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003; i=jack@suse.cz; h=from:subject; bh=pZUzO0hnYx3VPJNnxZXYMMaUnllZ7MJ4fz1iv846qsk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkyNW9q1c7xYSgZn5R/jEDels33OBe2mcj/w GfHrPofXM2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5MgAKCRCcnaoHP2RA 2QoGCAC1AqDmWxxwwJdmiEx1bMe1FArDA6tiehKcVHlgsDBx3Fz41skGykdLU5YmWoSsd/pHj3y 7ZRLFv21HDZlEidUx6K9vttxWDGYtNDxXYXqy+DycdDCIqJo+Zov6G+KaNPYnIU8UN44gbENKI8 03QsRQ0hylu9yaElKwqK05RduYivxRfFvtANJ/LMsf5ZyFWrrqnsjxrYsrig0qhXK/LdE6PV4TR zxKWLbRAEhCWOoobEPQf6zWouv511Q1vOCzCFAuWvAQ0vAAtLTYP7hsne8WP0s6gZQMfLvEuZ3s XSEJrSo6ld0J/TDNkpjKdRLSwTwHMc13U8BzGNFWTDV7rGbQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 6D86B1ECBEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79158-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Track metadata bhs for an inode in fs-private part of the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/affs/affs.h    | 2 ++
 fs/affs/dir.c     | 1 +
 fs/affs/file.c    | 1 +
 fs/affs/super.c   | 6 ++++++
 fs/affs/symlink.c | 1 +
 5 files changed, 11 insertions(+)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index ac4e9a02910b..a1eb400e1018 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -44,6 +44,7 @@ struct affs_inode_info {
 	struct mutex i_link_lock;		/* Protects internal inode access. */
 	struct mutex i_ext_lock;		/* Protects internal inode access. */
 #define i_hash_lock i_ext_lock
+	struct mapping_metadata_bhs i_metadata_bhs;
 	u32	 i_blkcnt;			/* block count */
 	u32	 i_extcnt;			/* extended block count */
 	u32	*i_lc;				/* linear cache of extended blocks */
@@ -151,6 +152,7 @@ extern bool	affs_nofilenametruncate(const struct dentry *dentry);
 extern int	affs_check_name(const unsigned char *name, int len,
 				bool notruncate);
 extern int	affs_copy_name(unsigned char *bstr, struct dentry *dentry);
+struct mapping_metadata_bhs *affs_get_metadata_bhs(struct inode *inode);
 
 /* bitmap. c */
 
diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index 5c8d83387a39..6b0314c84972 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -72,6 +72,7 @@ const struct inode_operations affs_dir_inode_operations = {
 	.rmdir		= affs_rmdir,
 	.rename		= affs_rename2,
 	.setattr	= affs_notify_change,
+	.get_metadata_bhs = affs_get_metadata_bhs,
 };
 
 static int
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 6c9258359ddb..4dbd9351eea0 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -1014,4 +1014,5 @@ const struct file_operations affs_file_operations = {
 
 const struct inode_operations affs_file_inode_operations = {
 	.setattr	= affs_notify_change,
+	.get_metadata_bhs = affs_get_metadata_bhs,
 };
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 8451647f3fea..dff272df0636 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -108,6 +108,7 @@ static struct inode *affs_alloc_inode(struct super_block *sb)
 	i->i_lc = NULL;
 	i->i_ext_bh = NULL;
 	i->i_pa_cnt = 0;
+	mmb_init(&i->i_metadata_bhs);
 
 	return &i->vfs_inode;
 }
@@ -147,6 +148,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(affs_inode_cachep);
 }
 
+struct mapping_metadata_bhs *affs_get_metadata_bhs(struct inode *inode)
+{
+	return &AFFS_I(inode)->i_metadata_bhs;
+}
+
 static const struct super_operations affs_sops = {
 	.alloc_inode	= affs_alloc_inode,
 	.free_inode	= affs_free_inode,
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index 094aec8d17b8..68fa091bd377 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -72,4 +72,5 @@ const struct address_space_operations affs_symlink_aops = {
 const struct inode_operations affs_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.setattr	= affs_notify_change,
+	.get_metadata_bhs = affs_get_metadata_bhs,
 };
-- 
2.51.0


