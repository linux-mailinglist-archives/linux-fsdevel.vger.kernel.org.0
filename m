Return-Path: <linux-fsdevel+bounces-11280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C60852750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F182285B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB24C6E;
	Tue, 13 Feb 2024 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CraUMEH6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nBIJYWX3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CraUMEH6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nBIJYWX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49914687;
	Tue, 13 Feb 2024 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790420; cv=none; b=fczHVSC2KYjlXo0wg6kODLs4XGfgY2aVfJrEs7HxkHrWCN9LnO70QTS44oo1IQNgnxiRojBt0dXniG8iThj6tWyTswx/IYYmloIZ3Nu4k+UxqEIHFU9yT7TY/o48xBM0O6hvMfR4aub1NSllqwib8klRG3vSIqnbcs8DINnVQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790420; c=relaxed/simple;
	bh=7+dsiojWXQnyMkcnZ66iDi2GpW5QMmMk/n+bMml/AvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gce20+xlK+wLJ0/L8fCM7E0KY3gO8VGc4zNR6yE1XG0r2PwEObsqIw4VI/2GcHhizlqmUga7aDnCtRmyA/cVGiILFvqI/kmhUgzLPw8+WFUuxJxx2mRtiJDD6r3eX3OFMsB1/g+LdjbZ2SmwSocNXr26gbU7mFWlxkWJOF+mLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CraUMEH6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nBIJYWX3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CraUMEH6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nBIJYWX3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3DAF1F79E;
	Tue, 13 Feb 2024 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D59OP2BUYYvV4JTaStIU9zARbS/Uaxo74njoDI27EFI=;
	b=CraUMEH6+JSJXxxKfYKxIUtWQXjV4gLU+0ryRS54WdfayCSdO4VQPZWxH4/xQkxfoNouuF
	RUU8yNDI2f3H6d5fz99vs/GEkJ9bdLrigswoTDqF0i8MG6optfOYT+ZTxqICK83qmu4o30
	gtOAqvC9MYXbkH1OAzTqBAnYUriRaxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D59OP2BUYYvV4JTaStIU9zARbS/Uaxo74njoDI27EFI=;
	b=nBIJYWX3zz4DqX2iFnYIpnXt80NZW/eJsUPkpQk4yTOCdJWqJh0iBFwMaXuo/WD+q+i3x6
	NOaE2gXbY7Mp2vBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D59OP2BUYYvV4JTaStIU9zARbS/Uaxo74njoDI27EFI=;
	b=CraUMEH6+JSJXxxKfYKxIUtWQXjV4gLU+0ryRS54WdfayCSdO4VQPZWxH4/xQkxfoNouuF
	RUU8yNDI2f3H6d5fz99vs/GEkJ9bdLrigswoTDqF0i8MG6optfOYT+ZTxqICK83qmu4o30
	gtOAqvC9MYXbkH1OAzTqBAnYUriRaxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D59OP2BUYYvV4JTaStIU9zARbS/Uaxo74njoDI27EFI=;
	b=nBIJYWX3zz4DqX2iFnYIpnXt80NZW/eJsUPkpQk4yTOCdJWqJh0iBFwMaXuo/WD+q+i3x6
	NOaE2gXbY7Mp2vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA60F13A4B;
	Tue, 13 Feb 2024 02:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TLReJ1DQymUQeAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jaegeuk@kernel.org,
	tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v6 01/10] ovl: Always reject mounting over case-insensitive directories
Date: Mon, 12 Feb 2024 21:13:12 -0500
Message-ID: <20240213021321.1804-2-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213021321.1804-1-krisman@suse.de>
References: <20240213021321.1804-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

overlayfs relies on the filesystem setting DCACHE_OP_HASH or
DCACHE_OP_COMPARE to reject mounting over case-insensitive directories.

Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
d_ops"), we set ->d_op through a hook in ->d_lookup, which
means the root dentry won't have them, causing the mount to accidentally
succeed.

In v6.7-rc7, the following sequence will succeed to mount, but any
dentry other than the root dentry will be a "weird" dentry to ovl and
fail with EREMOTE.

  mkfs.ext4 -O casefold lower.img
  mount -O loop lower.img lower
  mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work ovl /mnt

Mounting on a subdirectory fails, as expected, because DCACHE_OP_HASH
and DCACHE_OP_COMPARE are properly set by ->lookup.

Fix by explicitly rejecting superblocks that allow case-insensitive
dentries. Yes, this will be solved when we move d_op configuration back
to ->s_d_op. Yet, we better have an explicit fix to avoid messing up
again.

While there, re-sort the entries to have more descriptive error messages
first.

Fixes: bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Acked-by: Amir Goldstein <amir73il@gmail.com>

---
changes since v5:
  - summary line again (eric)
changes since v3:
  - Case insensitive filesystem ->Case insensitive capable
  filesystem (eric)
  - clarify patch summary line
changes since v2:
  - Re-sort checks to trigger more descriptive error messages
  first (Amir)
  - Add code comment (Amir)
---
 fs/overlayfs/params.c | 14 +++++++++++---
 include/linux/fs.h    |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 3fe2dde1598f..488f920f79d2 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -280,12 +280,20 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 {
 	struct ovl_fs_context *ctx = fc->fs_private;
 
-	if (ovl_dentry_weird(path->dentry))
-		return invalfc(fc, "filesystem on %s not supported", name);
-
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
+	/*
+	 * Root dentries of case-insensitive capable filesystems might
+	 * not have the dentry operations set, but still be incompatible
+	 * with overlayfs.  Check explicitly to prevent post-mount
+	 * failures.
+	 */
+	if (sb_has_encoding(path->mnt->mnt_sb))
+		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
+
+	if (ovl_dentry_weird(path->dentry))
+		return invalfc(fc, "filesystem on %s not supported", name);
 
 	/*
 	 * Check whether upper path is read-only here to report failures
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..e6667ece5e64 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3203,6 +3203,15 @@ extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	return !!sb->s_encoding;
+#else
+	return false;
+#endif
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
-- 
2.43.0


