Return-Path: <linux-fsdevel+bounces-11281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC83852756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF11C23228
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE85613C;
	Tue, 13 Feb 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ibFle493";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vNBVSpo2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ibFle493";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vNBVSpo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6684690;
	Tue, 13 Feb 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790422; cv=none; b=nS97KMow2jaB7j30cS7BRlFlFu5tt9XX9vZ0dMiRkQfMG0Z3dn5CzFH0UBJ3+wrsWR4dteN3hmtaq7y2qqQfRC9Kh1vc/eRWtUKB0aHHFel5FAbEGeLQblWHOZE9BuuDm5jsVBHPT0PLr6lyvGdCzdNpnSUBFXbJiwTO9EI4Q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790422; c=relaxed/simple;
	bh=v7qsPi0lxQy3ui+CjcbnoaVyhnRgYHpU4ORq0Eob8h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc4uakbFZsutLxv9l1Z++pCNCKrYmWWdytKOuy2Q5HyMi2hAfVRUnvG1tYIk0gIMDYSdG4e4mQZAkehmH2s/Qhlt+EXz2n14ccoOcshXn5KMyWmZwMGgcbUs307krSVDebVklURp4cwYpD9otMgtwX0zewp0O/j3a2ZsbvAaV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ibFle493; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vNBVSpo2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ibFle493; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vNBVSpo2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E74121D85;
	Tue, 13 Feb 2024 02:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5G03m8gBMLCKJSa0ZjoYUprI6wjRJAsMZ9XqZDtV8s=;
	b=ibFle493A0fvOOEkOf5Zw6YILb1a/xlaJdNEeEnjqrdW/WCnHulUO0rNuePY2uW+h1MZ/w
	fDEBHKG9YX6VNAMXuJlHSgaso0RqC/dzHOlvaK1oLnIXJcHA+EUl6lyj9HPribCEa+zjbS
	eYoER4IJiHJ917FwIDDdclNwt3L+Xtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5G03m8gBMLCKJSa0ZjoYUprI6wjRJAsMZ9XqZDtV8s=;
	b=vNBVSpo2C+8m9aeEQ4Ptbp4XF28bBckOEVXjUnJmPJeiy1mkVqyfU3d/rCdH3KEdAdJnij
	NbPs54NJoLlg82Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5G03m8gBMLCKJSa0ZjoYUprI6wjRJAsMZ9XqZDtV8s=;
	b=ibFle493A0fvOOEkOf5Zw6YILb1a/xlaJdNEeEnjqrdW/WCnHulUO0rNuePY2uW+h1MZ/w
	fDEBHKG9YX6VNAMXuJlHSgaso0RqC/dzHOlvaK1oLnIXJcHA+EUl6lyj9HPribCEa+zjbS
	eYoER4IJiHJ917FwIDDdclNwt3L+Xtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5G03m8gBMLCKJSa0ZjoYUprI6wjRJAsMZ9XqZDtV8s=;
	b=vNBVSpo2C+8m9aeEQ4Ptbp4XF28bBckOEVXjUnJmPJeiy1mkVqyfU3d/rCdH3KEdAdJnij
	NbPs54NJoLlg82Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 536B213A4B;
	Tue, 13 Feb 2024 02:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZb0DVLQymUSeAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:38 +0000
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
Subject: [PATCH v6 02/10] fscrypt: Factor out a helper to configure the lookup dentry
Date: Mon, 12 Feb 2024 21:13:13 -0500
Message-ID: <20240213021321.1804-3-krisman@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ibFle493;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vNBVSpo2
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.82%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 8E74121D85
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Both fscrypt_prepare_lookup_dentry_partial and
fscrypt_prepare_lookup_dentry will set DCACHE_NOKEY_NAME for dentries
when the key is not available. Extract out a helper to set this flag in
a single place, in preparation to also add the optimization that will
disable ->d_revalidate if possible.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v6
  - Use inline comparison for is_nokey_name (eric)
  - rename fscrypt_prepare_lookup_dentry->fscrypt_prepare_dentry (eric)
---
 fs/crypto/hooks.c       | 15 +++++----------
 include/linux/fscrypt.h | 10 ++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..104771c3d3f6 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -102,11 +102,8 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 	if (err && err != -ENOENT)
 		return err;
 
-	if (fname->is_nokey_name) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
+	fscrypt_prepare_dentry(dentry, fname->is_nokey_name);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
@@ -131,12 +128,10 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
 int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
 {
 	int err = fscrypt_get_encryption_info(dir, true);
+	bool is_nokey_name = (!err && !fscrypt_has_encryption_key(dir));
+
+	fscrypt_prepare_dentry(dentry, is_nokey_name);
 
-	if (!err && !fscrypt_has_encryption_key(dir)) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(fscrypt_prepare_lookup_partial);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..47567a6a4f9d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -948,6 +948,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
 	return 0;
 }
 
+static inline void fscrypt_prepare_dentry(struct dentry *dentry,
+					  bool is_nokey_name)
+{
+	if (is_nokey_name) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags |= DCACHE_NOKEY_NAME;
+		spin_unlock(&dentry->d_lock);
+	}
+}
+
 /**
  * fscrypt_prepare_lookup() - prepare to lookup a name in a possibly-encrypted
  *			      directory
-- 
2.43.0


