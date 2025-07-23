Return-Path: <linux-fsdevel+bounces-55832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC5B0F3EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D837B5C1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087912E8897;
	Wed, 23 Jul 2025 13:22:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA42E54A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276930; cv=none; b=pl0j2VB0zIwk9NDp6Ie4EebVBkWZQBZwA2xYmdH0moV3EJY5FA31fn2PmlxQB1SUFI87UBbsDcuq+SG9hhI/hreLUdm9AG37feRc0V597aUIFIV8AsHoS3PTEywpLw00gcX1RVuJan3CULOKjwYgdolzKl7/47VSMGs2vxL41Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276930; c=relaxed/simple;
	bh=bllb9uHHyMTFtmt/5d2fX8e0rbRkg+5tT2YXQJE8gW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx/KjrzVK+53MSKv+xaVBQ4F1HU7VfwdCVsYb/57N7l0xmPVbaSXOcDqpfuj1YkD1Yvcp3JP9NFVcrWpAn6eJFX6mnnm0lOwJiKCRrdAHotuMj2xI7r8786HCcNpSCC259Hdwdc0NTbYFmtVhvD7s/EfYBOep5Gc9UbzCMHjmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D579A218F0;
	Wed, 23 Jul 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C06713302;
	Wed, 23 Jul 2025 13:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKJwC/nhgGhnHwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 13:22:01 +0000
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
Subject: [PATCH 2/3] fs: Remove mount_bdev
Date: Wed, 23 Jul 2025 14:21:55 +0100
Message-ID: <20250723132156.225410-3-pfalcato@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D579A218F0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

mount_bdev has no in-tree users ever since f2fs adopted the new mount
API. Remove it.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 fs/super.c         | 43 -------------------------------------------
 include/linux/fs.h |  3 ---
 2 files changed, 46 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 7daa20737f2e..a038848e8d1f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1716,49 +1716,6 @@ int get_tree_bdev(struct fs_context *fc,
 }
 EXPORT_SYMBOL(get_tree_bdev);
 
-static int test_bdev_super(struct super_block *s, void *data)
-{
-	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
-}
-
-struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	struct super_block *s;
-	int error;
-	dev_t dev;
-
-	error = lookup_bdev(dev_name, &dev);
-	if (error)
-		return ERR_PTR(error);
-
-	flags |= SB_NOSEC;
-	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, &dev);
-	if (IS_ERR(s))
-		return ERR_CAST(s);
-
-	if (s->s_root) {
-		if ((flags ^ s->s_flags) & SB_RDONLY) {
-			deactivate_locked_super(s);
-			return ERR_PTR(-EBUSY);
-		}
-	} else {
-		error = setup_bdev_super(s, flags, NULL);
-		if (!error)
-			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
-		if (error) {
-			deactivate_locked_super(s);
-			return ERR_PTR(error);
-		}
-
-		s->s_flags |= SB_ACTIVE;
-	}
-
-	return dget(s->s_root);
-}
-EXPORT_SYMBOL(mount_bdev);
-
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 65bb19e457d8..a09e25841026 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2713,9 +2713,6 @@ static inline bool is_mgtime(const struct inode *inode)
 	return inode->i_opflags & IOP_MGTIME;
 }
 
-extern struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
-- 
2.50.1


