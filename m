Return-Path: <linux-fsdevel+bounces-41016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7186A2A05B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9A87A35DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889122579D;
	Thu,  6 Feb 2025 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvN1p34O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYMM+LoC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvN1p34O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYMM+LoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD2225795;
	Thu,  6 Feb 2025 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820865; cv=none; b=OrGSMce2uBd1pY7FQ9HZAEhO1r3VWrgCnnmXQ7sx3ZHeV6/qf/wFOeDY1g15KKl0Mz02lsDrEPNUGshdP9htH+Dr2wj76E4AYV7wRqg2GRO4pmKoSC/+4oJ2QdkpWIHcdEAJ8QAnVEL7fHffD4BD5C9sdbRkzXXEJ6W15Ig2uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820865; c=relaxed/simple;
	bh=5mF5w1V9yLV67g4tPn5QDLeBlj+DVVj/m7JDd7Fc69E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3ryX0QoTUjn0DDnclmcLZADCp1etcvazbhzh68lwW9hzAz/VEDB21DFnhJpmkguRXFQpV1+bbTm7o9sJqAxbFnBoobY8NIgQQ4zMOwBNwnJ4N34145/oIHQw4P/j9cd4tqYvE2biOxFJluEbS9nE1Dn6rhHKd2YFbI82HThL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvN1p34O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYMM+LoC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvN1p34O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYMM+LoC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 487381F381;
	Thu,  6 Feb 2025 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISQS0x5SwttOGqFgesE90/7bW1l09gCDc3rMRbJYWAc=;
	b=gvN1p34O1OfTDE1faavLnBJfYxUnTfH8FYX4sUqMxrTcap9b+I28pZuhJ5XweFLmc52sOT
	+vSzIOuBMOfyLF10vtQDj2YHa06QFHl17bIa6rjCx9w6/vor0q+auksvqEVYPRVKLBMQqu
	CZn0u5X6bWe8DeWVIundeerEMAtRXe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISQS0x5SwttOGqFgesE90/7bW1l09gCDc3rMRbJYWAc=;
	b=cYMM+LoCdkmPim/VD4JpjZxn5/iFIRjDUftPhy0t/sY7K7eHo0wSDEtXoUHO4ta/39HxC5
	QbLRM/gVIg+oplCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gvN1p34O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cYMM+LoC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISQS0x5SwttOGqFgesE90/7bW1l09gCDc3rMRbJYWAc=;
	b=gvN1p34O1OfTDE1faavLnBJfYxUnTfH8FYX4sUqMxrTcap9b+I28pZuhJ5XweFLmc52sOT
	+vSzIOuBMOfyLF10vtQDj2YHa06QFHl17bIa6rjCx9w6/vor0q+auksvqEVYPRVKLBMQqu
	CZn0u5X6bWe8DeWVIundeerEMAtRXe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISQS0x5SwttOGqFgesE90/7bW1l09gCDc3rMRbJYWAc=;
	b=cYMM+LoCdkmPim/VD4JpjZxn5/iFIRjDUftPhy0t/sY7K7eHo0wSDEtXoUHO4ta/39HxC5
	QbLRM/gVIg+oplCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86D8C13795;
	Thu,  6 Feb 2025 05:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l4jkDvtMpGflBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:39 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] VFS: Ensure no async updates happening in directory being removed.
Date: Thu,  6 Feb 2025 16:42:51 +1100
Message-ID: <20250206054504.2950516-15-neilb@suse.de>
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
X-Rspamd-Queue-Id: 487381F381
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

vfs_rmdir takes an exclusive lock on the target directory to ensure
nothing new is created in it while the rmdir progresses.  With the
possibility of async updates continuing after the inode lock is dropped
we now need extra protection.

Any async updates will have DCACHE_PAR_UPDATE set on the dentry.  We
simply wait for that flag to be cleared on all children.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c |  2 +-
 fs/namei.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index fb331596f1b1..90dee859d138 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -53,7 +53,7 @@
  *   - d_lru
  *   - d_count
  *   - d_unhashed()
- *   - d_parent and d_chilren
+ *   - d_parent and d_children
  *   - childrens' d_sib and d_parent
  *   - d_u.d_alias, d_inode
  *
diff --git a/fs/namei.c b/fs/namei.c
index 3a107d6098be..e8a85c9f431c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1839,6 +1839,27 @@ bool d_update_lock(struct dentry *dentry,
 	return true;
 }
 
+static void d_update_wait(struct dentry *dentry, unsigned int subclass)
+{
+	/* Note this may only ever be called in a context where we have
+	 * a lock preventing this dentry from becoming locked, possibly
+	 * an update lock on the parent dentry.  The must be a smp_mb()
+	 * after that lock is taken and before this is called so that
+	 * the following test is safe. d_update_lock() provides that
+	 * barrier.
+	 */
+	if (!(dentry->d_flags & DCACHE_PAR_UPDATE))
+		return
+	lock_acquire_exclusive(&dentry->d_update_map, subclass,
+			       0, NULL, _THIS_IP_);
+	spin_lock(&dentry->d_lock);
+	wait_var_event_spinlock(&dentry->d_flags,
+				!check_dentry_locked(dentry),
+				&dentry->d_lock);
+	spin_unlock(&dentry->d_lock);
+	lock_map_release(&dentry->d_update_map);
+}
+
 bool d_update_trylock(struct dentry *dentry,
 		      struct dentry *base,
 		      const struct qstr *last)
@@ -4688,6 +4709,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
+	struct dentry *child;
 
 	if (error)
 		return error;
@@ -4697,6 +4719,24 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	dget(dentry);
 	inode_lock(dentry->d_inode);
+	/*
+	 * Some children of dentry might be active in an async update.
+	 * We need to wait for them.  New children cannot be locked
+	 * while the inode lock is held.
+	 */
+again:
+	spin_lock(&dentry->d_lock);
+	for (child = d_first_child(dentry); child;
+	     child = d_next_sibling(child)) {
+		if (child->d_flags & DCACHE_PAR_UPDATE) {
+			dget(child);
+			spin_unlock(&dentry->d_lock);
+			d_update_wait(child, I_MUTEX_CHILD);
+			dput(child);
+			goto again;
+		}
+	}
+	spin_unlock(&dentry->d_lock);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry) ||
-- 
2.47.1


