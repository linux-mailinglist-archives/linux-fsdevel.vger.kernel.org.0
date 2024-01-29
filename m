Return-Path: <linux-fsdevel+bounces-9449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8E841497
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2166A1C24177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5194CB24;
	Mon, 29 Jan 2024 20:44:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BA157E92;
	Mon, 29 Jan 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561054; cv=none; b=jOvm47zAUDtPeCNZusurD6m7YlU5He32LtMkDLRocDwaUic6C08tMhJeE660e8XQkX5XgMOirLcZXWEzP5ZKXsYiq01QHGWOAPgjcqCIXVsJK8eKY62gA2vUWyWpzq2HJgMG294/nOF57FiE+6b1t5Xe5titDzpVOhmZY/nZ6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561054; c=relaxed/simple;
	bh=SyI2wLhlC/SY13QjjJmfT+fhtHMRlxjaM0zdsPjwQH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPm4CSalIxlSVAWNE3jlOfo8qhYkyifw7TmTdcLKHv/nrgQul0JmjoGCpxqBUyc4XPPYRUZQR9TDKAR3nfePZ+KK2+YcIzz8UBv0E+GcrQbo6PerU/uy0TZnUQY35G7U/+VBZccNjhhpVTw2I9Wrol5pvzGwx6Gvj1MuHvsZI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E55342208D;
	Mon, 29 Jan 2024 20:44:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46F9712FF7;
	Mon, 29 Jan 2024 20:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hepvAxkOuGXyDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:44:09 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 09/12] ext4: Configure dentry operations at dentry-creation time
Date: Mon, 29 Jan 2024 17:43:27 -0300
Message-ID: <20240129204330.32346-10-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129204330.32346-1-krisman@suse.de>
References: <20240129204330.32346-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E55342208D
X-Spam-Flag: NO

This was already the case for case-insensitive before commit
bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops"), but it
was changed to set at lookup-time to facilitate the integration with
fscrypt.  But it's a problem because dentries that don't get created
through ->lookup() won't have any visibility of the operations.

Since fscrypt now also supports configuring dentry operations at
creation-time, do it for any encrypted and/or casefold volume,
simplifying the implementation across these features.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/ext4/namei.c | 1 -
 fs/ext4/super.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..3f0b853a371e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,7 +1762,6 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..de80a9cc699a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5493,6 +5493,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount4;
 	}
 
+	generic_set_sb_d_ops(sb);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		ext4_msg(sb, KERN_ERR, "get root dentry failed");
-- 
2.43.0


