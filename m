Return-Path: <linux-fsdevel+bounces-37903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1D9F8A68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7F7165F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF21531C8;
	Fri, 20 Dec 2024 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L9vPEMp/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iKz9WiNl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L9vPEMp/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iKz9WiNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC613B5AE;
	Fri, 20 Dec 2024 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664150; cv=none; b=ZyK3lWrq2n+AUjWJ58tFKVTvc/4Mx/UyI3GBlnA5D3nEXgGWEKCmrYXn6hEIC5uE2VrgTod00bjYqKUSRv3IXZ016KazJ+hgixPYdrriq/se8zYJIrJg0JB9kqsuoDK2QB+37iGzCC8VwAaIaCBiu1Alpy8mgI/xspO3ckzInTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664150; c=relaxed/simple;
	bh=Bo7QEoD4d6wXAjUqhWsYKI7k/1L8cMEEFHwZm/53sQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy2LpunAxxDnpBylOykpeo5EnDPDEqgnPYYxlYfgOP2z4rMdUZMWMhokL00cMsTPERVnFQjMZb3B8WI0mkWqwwmczuVZ/TwkBycyxrRbCwzclgNZcyplC71Orgz4ZE3GueqoJsuU+ErzgM8H8Db71Jn9Oj3dWZpgLYJTROldiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L9vPEMp/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iKz9WiNl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L9vPEMp/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iKz9WiNl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73D6E1F385;
	Fri, 20 Dec 2024 03:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SySF3mKOgCcyFExR0bWEbGojqlSsrDz567ZlnXh0aQ=;
	b=L9vPEMp/UxYN+/TvCtANB7QEIAIwECEGukTeCEbqMvpqmcPFRh5DqTxE2rjbnexf/xpP1x
	n6DzMhA2/W0DXYI7nb0vhnZYVKRHEL8TKVZ+i0FI9IxwPaZfdizYvqXWd6PAeCFnCyVu0S
	2/4FlWWeZQwRQpWcX8tyPf8cXRaYWeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SySF3mKOgCcyFExR0bWEbGojqlSsrDz567ZlnXh0aQ=;
	b=iKz9WiNlUyZaC1s+qMBX9OEtt7CTp4R2wPOrXM8iP76DyH5zZuZ3j1hoKbbdRmHzB9i9OX
	9oGgVEa3FGl2IOCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="L9vPEMp/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iKz9WiNl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SySF3mKOgCcyFExR0bWEbGojqlSsrDz567ZlnXh0aQ=;
	b=L9vPEMp/UxYN+/TvCtANB7QEIAIwECEGukTeCEbqMvpqmcPFRh5DqTxE2rjbnexf/xpP1x
	n6DzMhA2/W0DXYI7nb0vhnZYVKRHEL8TKVZ+i0FI9IxwPaZfdizYvqXWd6PAeCFnCyVu0S
	2/4FlWWeZQwRQpWcX8tyPf8cXRaYWeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SySF3mKOgCcyFExR0bWEbGojqlSsrDz567ZlnXh0aQ=;
	b=iKz9WiNlUyZaC1s+qMBX9OEtt7CTp4R2wPOrXM8iP76DyH5zZuZ3j1hoKbbdRmHzB9i9OX
	9oGgVEa3FGl2IOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB9813A32;
	Fri, 20 Dec 2024 03:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p52qAM/fZGdNGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:03 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl()
Date: Fri, 20 Dec 2024 13:54:22 +1100
Message-ID: <20241220030830.272429-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73D6E1F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

lookup_one_qstr_excl() is used for lookups prior to directory
modifications, whether create, unlink, rename, or whatever.

To prepare for allowing modification to happen in parallel, change
lookup_one_qstr_excl() to use d_alloc_parallel().

If any for the "intent" LOOKUP flags are passed, the caller must ensure
d_lookup_done() is called at an appropriate time.  If none are passed
then we can be sure ->lookup() will do a real lookup and d_lookup_done()
is called internally.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 21 ++++++++++++++-------
 fs/smb/server/vfs.c   |  1 +
 include/linux/namei.h |  3 +++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 174e6693304e..395bfbc8fc92 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1664,11 +1664,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
+ * Parent directory has inode locked exclusive.
+ * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
+ * must be called after the intended operation is performed - or aborted.
  */
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
@@ -1685,15 +1683,22 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR_OR_NULL(dentry)))
 		return ERR_PTR(-ENOMEM);
+	if (!d_in_lookup(dentry))
+		/* Raced with another thread which did the lookup */
+		return dentry;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
+	if ((flags & LOOKUP_INTENT_FLAGS) == 0)
+		/* ->lookup must have given final answer */
+		d_lookup_done(dentry);
 	return dentry;
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
@@ -4112,6 +4117,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	}
 	return dentry;
 fail:
+	d_lookup_done(dentry);
 	dput(dentry);
 	dentry = ERR_PTR(error);
 unlock:
@@ -5340,6 +5346,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
 exit5:
+	d_lookup_done(new_dentry);
 	dput(new_dentry);
 exit4:
 	dput(old_dentry);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index dfb0eee5f5f3..83131f08bfb4 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -772,6 +772,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
 out4:
+	d_lookup_done(new_dentry);
 	dput(new_dentry);
 out3:
 	dput(old_parent);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ec8fed3bce8..15118992f745 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -34,6 +34,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
 #define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
 
+#define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
+				 LOOKUP_RENAME_TARGET)
+
 /* internal use only */
 #define LOOKUP_PARENT		0x0010
 
-- 
2.47.0


