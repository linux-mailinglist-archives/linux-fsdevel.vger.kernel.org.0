Return-Path: <linux-fsdevel+bounces-41017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE0A2A05D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CAF18884B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6961C225A2E;
	Thu,  6 Feb 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S9yAQuLQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0/B3ygud";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S9yAQuLQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0/B3ygud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9A1917E7;
	Thu,  6 Feb 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820871; cv=none; b=lncKPjYomELBvePjAUEONCVrByVPAN6mH2arJcoPp3v3JBIDTSIQqROSkswlcgAJ0RnVk1JDLBiMfczwZI4e9y7fPQ4++S5IBrKQZ/PhNumHZq6irYQRh1podSnpTZrrWhmeKzmk9PZkICRXt9ea1D/KcZV1hJMDX91RCodBKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820871; c=relaxed/simple;
	bh=5rb3dCvIL+H7JSAVIxkaOakHRBqE6OO9tk8d8n5onME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy4ttyb10UVKoLXunJv8/MbYI/XEJtNGERqucRyHRh6FZGANatN5F5QSDFDG3dnIfZNRYxdIThhXGtulOgpVyopX3Nx/9EehkCDuTUGIoctb7nmL0fFnpq9fcnFfrVPzBi+TOXKaSD1IDeyyHkCxHld1Ddou0NnN4xkoOLdYjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S9yAQuLQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0/B3ygud; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S9yAQuLQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0/B3ygud; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FB4D1F381;
	Thu,  6 Feb 2025 05:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg8jyQtR1PM07jDy9w8zaloI2V0UH9zumpbWDHes2ss=;
	b=S9yAQuLQ2LTurbYoxNPnMB6T/tzb3tYHHGFn2+c7xqOqpe9eBVqeqW0NZOLHJ8DD0j8Ip5
	WmoRejNVVoM9UAHIcEn6SHeNO4lieIJ6dyoSAp7MzDty3Kh4Yj8FP0e6MC2xaFB6FiCh5y
	5qTp+ToX3mSz8ulsW7WoxcLcrEyYzWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg8jyQtR1PM07jDy9w8zaloI2V0UH9zumpbWDHes2ss=;
	b=0/B3ygudQRPJoXl7t1AcTSk2/OJYTr4P1U7uHsUJdtsIazkoasqB++fV6vZM5KAFQBeGkF
	uGfu3ITmc4bPOZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg8jyQtR1PM07jDy9w8zaloI2V0UH9zumpbWDHes2ss=;
	b=S9yAQuLQ2LTurbYoxNPnMB6T/tzb3tYHHGFn2+c7xqOqpe9eBVqeqW0NZOLHJ8DD0j8Ip5
	WmoRejNVVoM9UAHIcEn6SHeNO4lieIJ6dyoSAp7MzDty3Kh4Yj8FP0e6MC2xaFB6FiCh5y
	5qTp+ToX3mSz8ulsW7WoxcLcrEyYzWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg8jyQtR1PM07jDy9w8zaloI2V0UH9zumpbWDHes2ss=;
	b=0/B3ygudQRPJoXl7t1AcTSk2/OJYTr4P1U7uHsUJdtsIazkoasqB++fV6vZM5KAFQBeGkF
	uGfu3ITmc4bPOZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C78F413795;
	Thu,  6 Feb 2025 05:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ZSUHgFNpGfrBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:45 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] VFS: Change lookup_and_lock() to use shared lock when possible.
Date: Thu,  6 Feb 2025 16:42:52 +1100
Message-ID: <20250206054504.2950516-16-neilb@suse.de>
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
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLg91jkc8ace7pgw6s4553jw4p),from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

lookup_and_lock() and done_lookup_and_lock() are now told, via LOOKUP_
intent flags what operation is being performed, including a new
LOOKUP_REMOVE.

They use this to determine whether shared or exclusive locking is
needed.

If all filesystems eventually support all async interface, this locking
can be discarded.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e8a85c9f431c..c7b7445c770e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1898,13 +1898,26 @@ static struct dentry *lookup_and_lock_nested(const struct qstr *last,
 					     unsigned int subclass)
 {
 	struct dentry *dentry;
+	unsigned int shared = 0;
 
-	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
-		inode_lock_nested(base->d_inode, subclass);
+	if (!(lookup_flags & LOOKUP_PARENT_LOCKED)) {
+		if (lookup_flags & LOOKUP_CREATE)
+			shared = S_ASYNC_CREATE;
+		if (lookup_flags & LOOKUP_REMOVE)
+			shared = S_ASYNC_REMOVE;
+
+		if (base->d_inode->i_flags & shared)
+			inode_lock_shared_nested(base->d_inode, subclass);
+		else
+			inode_lock_nested(base->d_inode, subclass);
+	}
 	do {
 		dentry = lookup_one_qstr(last, base, lookup_flags);
 	} while (!IS_ERR(dentry) && !d_update_lock(dentry, base, last, subclass));
 	if (IS_ERR(dentry) && !(lookup_flags & LOOKUP_PARENT_LOCKED)) {
+		if (base->d_inode->i_flags & shared)
+			inode_unlock_shared(base->d_inode);
+		else
 			inode_unlock(base->d_inode);
 	}
 	return dentry;
@@ -1921,11 +1934,22 @@ static struct dentry *lookup_and_lock(const struct qstr *last,
 void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
 			  unsigned int lookup_flags)
 {
+	unsigned int shared = 0;
+
+	if (lookup_flags & LOOKUP_CREATE)
+		shared = S_ASYNC_CREATE;
+	if (lookup_flags & LOOKUP_REMOVE)
+		shared = S_ASYNC_REMOVE;
+
 	d_lookup_done(dentry);
 	d_update_unlock(dentry);
 	dput(dentry);
-	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
-		inode_unlock(base->d_inode);
+	if (!(lookup_flags & LOOKUP_PARENT_LOCKED)) {
+		if (base->d_inode->i_flags & shared)
+			inode_unlock_shared(base->d_inode);
+		else
+			inode_unlock(base->d_inode);
+	}
 }
 EXPORT_SYMBOL(done_lookup_and_lock);
 
@@ -4004,7 +4028,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
+	if ((open_flag & O_CREAT) && !(dir->d_inode->i_flags & S_ASYNC_OPEN))
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
@@ -4015,7 +4039,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
-	if (open_flag & O_CREAT)
+	if ((open_flag & O_CREAT) && !(dir->d_inode->i_flags & S_ASYNC_OPEN))
 		inode_unlock(dir->d_inode);
 	else
 		inode_unlock_shared(dir->d_inode);
@@ -4775,7 +4799,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct path path;
 	struct qstr last;
 	int type;
-	unsigned int lookup_flags = 0;
+	unsigned int lookup_flags = LOOKUP_REMOVE;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4914,7 +4938,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	int type;
 	struct inode *inode = NULL;
 	struct inode *delegated_inode = NULL;
-	unsigned int lookup_flags = 0;
+	unsigned int lookup_flags = LOOKUP_REMOVE;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
-- 
2.47.1


