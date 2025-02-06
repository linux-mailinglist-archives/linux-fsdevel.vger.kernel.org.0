Return-Path: <linux-fsdevel+bounces-41012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB220A2A057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A46C3A6B88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D2225414;
	Thu,  6 Feb 2025 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zvwTqS/x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PD87s1nV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zvwTqS/x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PD87s1nV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B9224B0E;
	Thu,  6 Feb 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820832; cv=none; b=UmJAr3UoCaPT+q/w6yO41w3HKhcXRyPx0sk8meQEjUon2m2aUcIJHLcM3ZYY/zMyIwhuVXBikajH14r2Gej90P+LMr89+qGxnziqC9EEfL0ghqz4aSTU7RoJYAyAwSDSxO8XtlUzbOWUQzBWZaeKLN0TvI7Zgj8zSHv/fmxaCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820832; c=relaxed/simple;
	bh=hpiSBFLLA3zJIzrDKR6EC2urgIUr9uaLWZtt1neW9wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSsfPrV4iBeQawAd5zxQCfiekTfbQ6rRGI6o7A1jstCxi3euSrP0ljiVlt81B0LUikIV0wbDeodXmg1SP9EfMBpzevBCwXc9YNmBX1+bxgjmus4HcgaI9Ve+Woo2PzLSN6bAT2hF99yXoTFQSzE7LMQZWh4qh7Uc1Dqj6Dz/Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zvwTqS/x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PD87s1nV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zvwTqS/x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PD87s1nV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62AA621108;
	Thu,  6 Feb 2025 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMpYvVJMWnlLZwdGjgJZ84ZYkT2VEezdAmlsywYkUn0=;
	b=zvwTqS/xttadY/b8wd01NIIG6xiReBxgTfDj85qjfDM2zb5ycn2/6tqJr7rN5Hi7SNWatn
	FAKFLSXsu9XD3sdsIOhK7xRIG5du6dHgS9m7ra+9jxTs4AmtN2PKZMbzhGvoPq4L9DiF+P
	5/MA06Np36cSOCHIYYRLWOQaJmTYjQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMpYvVJMWnlLZwdGjgJZ84ZYkT2VEezdAmlsywYkUn0=;
	b=PD87s1nVWoykQxw/voNOvfrMklaIi0eGnQnOrnFVvzAwfogj6YtufGtnwUiiwr59ECB7p0
	7dcaSDXT2wq32wAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMpYvVJMWnlLZwdGjgJZ84ZYkT2VEezdAmlsywYkUn0=;
	b=zvwTqS/xttadY/b8wd01NIIG6xiReBxgTfDj85qjfDM2zb5ycn2/6tqJr7rN5Hi7SNWatn
	FAKFLSXsu9XD3sdsIOhK7xRIG5du6dHgS9m7ra+9jxTs4AmtN2PKZMbzhGvoPq4L9DiF+P
	5/MA06Np36cSOCHIYYRLWOQaJmTYjQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMpYvVJMWnlLZwdGjgJZ84ZYkT2VEezdAmlsywYkUn0=;
	b=PD87s1nVWoykQxw/voNOvfrMklaIi0eGnQnOrnFVvzAwfogj6YtufGtnwUiiwr59ECB7p0
	7dcaSDXT2wq32wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E0A913795;
	Thu,  6 Feb 2025 05:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qHWXFNpMpGe5BwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:06 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] VFS: introduce inode flags to report locking needs for directory ops
Date: Thu,  6 Feb 2025 16:42:47 +1100
Message-ID: <20250206054504.2950516-11-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

If a filesystem supports _async ops for some directory ops we can take a
"shared" lock on i_rwsem otherwise we must take an "exclusive" lock.  As
the filesystem may support some async ops but not others we need to
easily determine which.

With this patch we group the ops into 4 groups that are likely be
supported together:

CREATE: create, link, mkdir, mknod
REMOVE: rmdir, unlink
RENAME: rename
OPEN: atomic_open, create

and set S_ASYNC_XXX for each when the inode in initialised.

We also add a LOOKUP_REMOVE intent flag which will be used by locking
interfaces to help know which group is being used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c           | 24 ++++++++++++++++++++++++
 include/linux/fs.h    |  5 +++++
 include/linux/namei.h |  5 +++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e49607d00d2d..37c0f655166d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -384,6 +384,27 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
 	smp_store_release(&dentry->d_flags, flags);
 }
 
+static void set_inode_flags(struct inode *inode)
+{
+	const struct inode_operations *i_op = inode->i_op;
+
+	lockdep_assert_held(&inode->i_lock);
+	if ((i_op->create_async || !i_op->create) &&
+	    (i_op->link_async || !i_op->link) &&
+	    (i_op->symlink_async || !i_op->symlink) &&
+	    (i_op->mkdir_async || !i_op->mkdir) &&
+	    (i_op->mknod_async || !i_op->mknod))
+		inode->i_flags |= S_ASYNC_CREATE;
+	if ((i_op->unlink_async || !i_op->unlink) &&
+	    (i_op->mkdir_async || !i_op->mkdir))
+		inode->i_flags |= S_ASYNC_REMOVE;
+	if (i_op->rename_async)
+		inode->i_flags |= S_ASYNC_RENAME;
+	if (i_op->atomic_open_async ||
+	    (!i_op->atomic_open && i_op->create_async))
+		inode->i_flags |= S_ASYNC_OPEN;
+}
+
 static inline void __d_clear_type_and_inode(struct dentry *dentry)
 {
 	unsigned flags = READ_ONCE(dentry->d_flags);
@@ -1893,6 +1914,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	raw_write_seqcount_end(&dentry->d_seq);
+	set_inode_flags(inode);
 	fsnotify_update_flags(dentry);
 	spin_unlock(&dentry->d_lock);
 }
@@ -1999,6 +2021,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 		spin_lock(&new->d_lock);
 		__d_set_inode_and_type(new, inode, add_flags);
+		set_inode_flags(inode);
 		hlist_add_head(&new->d_u.d_alias, &inode->i_dentry);
 		if (!disconnected) {
 			hlist_bl_lock(&sb->s_roots);
@@ -2701,6 +2724,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		raw_write_seqcount_begin(&dentry->d_seq);
 		__d_set_inode_and_type(dentry, inode, add_flags);
 		raw_write_seqcount_end(&dentry->d_seq);
+		set_inode_flags(inode);
 		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e414400c2487..9a9282fef347 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2361,6 +2361,11 @@ struct super_operations {
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 
+#define S_ASYNC_CREATE	BIT(18)	/* create, link, symlink, mkdir, mknod all _async */
+#define S_ASYNC_REMOVE	BIT(19)	/* unlink, mkdir both _async */
+#define S_ASYNC_RENAME	BIT(20) /* rename_async supported */
+#define S_ASYNC_OPEN	BIT(21) /* atomic_open_async or create_async supported */
+
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 76c587a5ec3a..72e351640406 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -40,10 +40,11 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
+#define LOOKUP_REMOVE		BIT(20)	/* ... in target of object removal */
 
 #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
-				 LOOKUP_RENAME_TARGET)
-/* 4 spare bits for intent */
+				 LOOKUP_RENAME_TARGET | LOOKUP_REMOVE)
+/* 3 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.47.1


