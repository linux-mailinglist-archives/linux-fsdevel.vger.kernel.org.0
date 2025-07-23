Return-Path: <linux-fsdevel+bounces-55830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65263B0F3D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CEA7B4E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA52E7BAA;
	Wed, 23 Jul 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1e4Oh2Mc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHBnnz8M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1e4Oh2Mc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHBnnz8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1B8F7D
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276924; cv=none; b=o8HWrm1YS693bHMzhXuE8MscbpIpVLbKP5uia3iiFWUhg0hD/rhQ02ba7TcHiS54CGKGIlgDGqBtQ4k/RLLJJXHcyaTMKl9MTiYQblrEy03itGhb+MWRuqC7FuvYK4iOCMHZQEsdu2h5X0H6VXowcN/tG/gY8d8tBj/iqv+vamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276924; c=relaxed/simple;
	bh=C+v61yW3x8TfkFwWKjxhrz1QRhUdaQLWzodXnI6v4f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkLwu8vD6lR1May4lC8fOeBidfWvNeXmIfg/oQIWyZc5cdntH/4w2pboUn+KFEBKaDhEQtavZeeRHXUrPpwxzUvxDGFY2scthK+TMkwoBQtHS51mpxYanavy5azcYXDjBHnfsElt6Bf6J7KvV5RaEbDeWg5eFzmbi+VPYtGlFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1e4Oh2Mc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHBnnz8M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1e4Oh2Mc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHBnnz8M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25EFC218EC;
	Wed, 23 Jul 2025 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdakhAkbJUMr+z1tMZA2FYKLCFZQ2CzBklc3B+ZWaiM=;
	b=1e4Oh2Mc3Jyo44UZbYqdpo13yZXcviWq8/TRUivPurJo0vSnu8BnKjOfLfTo9uAvg1P8CM
	/CskdvkwwT1hg8q5LzTPbyfN450GtQnAH6iXa4JkAophRmHoaZMc/OScbfABsHWHZ7mCZM
	Y4F8MUmCqrvuoYnUPzEp31MPvBA4pt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdakhAkbJUMr+z1tMZA2FYKLCFZQ2CzBklc3B+ZWaiM=;
	b=FHBnnz8Myew+fNSInUEJHTgF4KCNBTaZn2+Fqfh2VA3tMrOQ18YragToJwTU95Tb8sYGW2
	tqPSIFHlPh7xMoBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753276921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdakhAkbJUMr+z1tMZA2FYKLCFZQ2CzBklc3B+ZWaiM=;
	b=1e4Oh2Mc3Jyo44UZbYqdpo13yZXcviWq8/TRUivPurJo0vSnu8BnKjOfLfTo9uAvg1P8CM
	/CskdvkwwT1hg8q5LzTPbyfN450GtQnAH6iXa4JkAophRmHoaZMc/OScbfABsHWHZ7mCZM
	Y4F8MUmCqrvuoYnUPzEp31MPvBA4pt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753276921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdakhAkbJUMr+z1tMZA2FYKLCFZQ2CzBklc3B+ZWaiM=;
	b=FHBnnz8Myew+fNSInUEJHTgF4KCNBTaZn2+Fqfh2VA3tMrOQ18YragToJwTU95Tb8sYGW2
	tqPSIFHlPh7xMoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8314113ADD;
	Wed, 23 Jul 2025 13:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QFCyHPjhgGhnHwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 13:22:00 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 1/3] fs: Remove mount_nodev
Date: Wed, 23 Jul 2025 14:21:54 +0100
Message-ID: <20250723132156.225410-2-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723132156.225410-1-pfalcato@suse.de>
References: <20250723132156.225410-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

mount_nodev has had no in-tree users since
cc0876f817d6 ("vfs: Convert devpts to use the new mount API").
Remove it.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 fs/super.c         | 20 --------------------
 include/linux/fs.h |  3 ---
 2 files changed, 23 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..7daa20737f2e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1773,26 +1773,6 @@ void kill_block_super(struct super_block *sb)
 EXPORT_SYMBOL(kill_block_super);
 #endif
 
-struct dentry *mount_nodev(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	int error;
-	struct super_block *s = sget(fs_type, NULL, set_anon_super, flags, NULL);
-
-	if (IS_ERR(s))
-		return ERR_CAST(s);
-
-	error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-	s->s_flags |= SB_ACTIVE;
-	return dget(s->s_root);
-}
-EXPORT_SYMBOL(mount_nodev);
-
 /**
  * vfs_get_tree - Get the mountable root
  * @fc: The superblock configuration context.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b2c567b0889..65bb19e457d8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2716,9 +2716,6 @@ static inline bool is_mgtime(const struct inode *inode)
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
-extern struct dentry *mount_nodev(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
-- 
2.50.1


