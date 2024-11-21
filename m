Return-Path: <linux-fsdevel+bounces-35420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709779D4BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007041F211AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492D1D9A79;
	Thu, 21 Nov 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldkxUmSn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ho0aKtua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427191D12EA;
	Thu, 21 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188149; cv=none; b=kRUxUO2UxBplSSqya2lqzfPgU/qJo9I+662US66LG+umnupf2CUJS1rPvytgqyTHEr7C7/vVJZp/AFduYeWI06ETBanHepghpA5B8ozFee7YnvZOuKPIZO03ZGluXFB7pyKtSU7Lj7dB5veG1vj6tOVygDvWllcwHgRRbsHNRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188149; c=relaxed/simple;
	bh=4Rkj/CGRMAX50uPYDYjn1U8zoTysoEZvjuUDTFgKlHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPco0V95wf5uTE3tJXqRy1t4BIEaDB+yaDyX+l8jJSyU/J2xUcOdURofDaJR264cW1iwjKLqxoKIckMp6hLh0/NhGdIIDD4h7rYlAHCY3FoLVV7XQyNjk1amUbfxXtpEs+JfUQGKETrMQqOtTPs99k0MQdgkP7FsoPVMBQ5VZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldkxUmSn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ho0aKtua; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47E57219FB;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2qxXVL2Jb2lG51DduQ/x+qQIqCY8ru0Auoofcr9Fgo=;
	b=ldkxUmSnk87XS1fQLVTzkv04jHEngOpg2yhKBoL45DbH67sk0wdFHY1XwzPXCm/uNA/rpx
	Mi/92oZP1SpHJMuD9uVMqgTLUUZ1YDatg3UW90zSlozoIro7ZKZQdLrOPkbQLSmezCyV/3
	1ZJEsDMo1eQjWzMKYy5lHHJRgdzz36U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2qxXVL2Jb2lG51DduQ/x+qQIqCY8ru0Auoofcr9Fgo=;
	b=Ho0aKtuajp0z3e7EHf/Ka4HJOoUO8ddZeluFft+W+S3VqR8yuJmTnrmZndAHTITAm/1Pod
	uhx0qPt35mTXcaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD9313AC9;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5WfpCvAXP2cdfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5391A08E1; Thu, 21 Nov 2024 12:22:23 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/19] fsnotify: check if file is actually being watched for pre-content events on open
Date: Thu, 21 Nov 2024 12:22:02 +0100
Message-Id: <20241121112218.8249-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 47E57219FB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

From: Amir Goldstein <amir73il@gmail.com>

So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
are no permission event watchers at all on the filesystem, but lack of
FMODE_NONOTIFY_ flags does not mean that the file is actually watched.

For pre-content events, it is possible to optimize things so that we
don't bother trying to send pre-content events if file was not watched
(through sb, mnt, parent or inode itself) on open. Set FMODE_NONOTIFY_
flags according to that.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com
---
 fs/notify/fsnotify.c             | 27 +++++++++++++++++++++++++--
 include/linux/fsnotify_backend.h |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 569ec356e4ce..dd1dffd89fd6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -193,7 +193,7 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask;
 }
 
-/* Are there any inode/mount/sb objects that are interested in this event? */
+/* Are there any inode/mount/sb objects that watch for these events? */
 static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 					   __u32 mask)
 {
@@ -632,7 +632,9 @@ EXPORT_SYMBOL_GPL(fsnotify);
  */
 void file_set_fsnotify_mode(struct file *file)
 {
-	struct super_block *sb = file->f_path.dentry->d_sb;
+	struct dentry *dentry = file->f_path.dentry, *parent;
+	struct super_block *sb = dentry->d_sb;
+	__u32 mnt_mask, p_mask;
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
 		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
 		return;
 	}
+
+	/*
+	 * OK, there are some pre-content watchers. Check if anybody can be
+	 * watching for pre-content events on *this* file.
+	 */
+	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
+	if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
+	    !fsnotify_object_watched(d_inode(dentry), mnt_mask,
+				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
+		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+		return;
+	}
+
+	/* Even parent is not watching for pre-content events on this file? */
+	parent = dget_parent(dentry);
+	p_mask = fsnotify_inode_watches_children(d_inode(parent));
+	dput(parent);
+	if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
+		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+		return;
+	}
 }
 #endif
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..9c105244815d 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -77,6 +77,9 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
+/* Pre-content events can be used to fill file content */
+#define FSNOTIFY_PRE_CONTENT_EVENTS 0
+
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
 
-- 
2.35.3


