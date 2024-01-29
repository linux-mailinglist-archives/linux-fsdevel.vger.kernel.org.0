Return-Path: <linux-fsdevel+bounces-9442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B584147F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C811C1C23BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CA157E87;
	Mon, 29 Jan 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LPtV3C+i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pz6UbtSl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LPtV3C+i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pz6UbtSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C704CB24;
	Mon, 29 Jan 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561026; cv=none; b=ud7mAbamv+3KBFy4CPUtxgcTs7QxV3FLu14B0Qvw//RsllA/5t98NeMO0duLbXmkZLrPExPqydFRPjKbx56iUEW1np/KxmFInrwzv8zGysw2mJQVZnH/XR4H6Ek/o935xoBz2M//19n2MgNuccaUcZ4B5+uR9iZSmZifAFymLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561026; c=relaxed/simple;
	bh=bqvR1ioSLEXM1TsuTdhMpzk64b5FBELlWtE3yTRwBsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1JqUh93i3Hvg2HKiPD41vpgfuD8sXMVV9J0bhWiM5Jjf0QceXc3fBvaC7L4ufTcqmHoNlEJ4n5x41VVkYsqtJKrkPDWRXJJ4hAjMMMOlpvhhdy5VgE5C1n7jFunfVhnvJIWFG29e+KECNIMvT0NR2lVw3twgkNKI7mit5EUU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LPtV3C+i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pz6UbtSl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LPtV3C+i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pz6UbtSl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C1A71F807;
	Mon, 29 Jan 2024 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706561022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWLoWz7nxQVTABtxNVN2ddgKtqXgJeF/RFCQQ5mld/o=;
	b=LPtV3C+izNGrDLVkatnrku0+kAUtkEwZiRKUVh0yxUBU6yBT44Jk5CkhsO3mvpMdFb9a2E
	dN/R45rcIniGeyCARF5zlgzvcY/tI+wAdNhiV2oYqktUMBrCKzJVURTH5HtdbUgTL5HQt5
	4ekUdyrOZ5CRCDUfahJnO1SMhyHCfdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706561022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWLoWz7nxQVTABtxNVN2ddgKtqXgJeF/RFCQQ5mld/o=;
	b=Pz6UbtSlxwQdRFrtYcTrP/0UBmY0IDFlV3m3pcAx/UAE/Vr+si8HUUCd+6QSOu2l0KgCCV
	/Ys+5GGtF3SwQABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706561022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWLoWz7nxQVTABtxNVN2ddgKtqXgJeF/RFCQQ5mld/o=;
	b=LPtV3C+izNGrDLVkatnrku0+kAUtkEwZiRKUVh0yxUBU6yBT44Jk5CkhsO3mvpMdFb9a2E
	dN/R45rcIniGeyCARF5zlgzvcY/tI+wAdNhiV2oYqktUMBrCKzJVURTH5HtdbUgTL5HQt5
	4ekUdyrOZ5CRCDUfahJnO1SMhyHCfdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706561022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWLoWz7nxQVTABtxNVN2ddgKtqXgJeF/RFCQQ5mld/o=;
	b=Pz6UbtSlxwQdRFrtYcTrP/0UBmY0IDFlV3m3pcAx/UAE/Vr+si8HUUCd+6QSOu2l0KgCCV
	/Ys+5GGtF3SwQABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D146A12FF7;
	Mon, 29 Jan 2024 20:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PxdCIf0NuGXHDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:43:41 +0000
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
Subject: [PATCH v5 02/12] fscrypt: Factor out a helper to configure the lookup dentry
Date: Mon, 29 Jan 2024 17:43:20 -0300
Message-ID: <20240129204330.32346-3-krisman@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[16.38%]
X-Spam-Flag: NO

Both fscrypt_prepare_lookup_dentry_partial and
fscrypt_prepare_lookup_dentry will set DCACHE_NOKEY_NAME for dentries
when the key is not available. Extract out a helper to set this flag in
a single place, in preparation to also add the optimization that will
disable ->d_revalidate if possible.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/crypto/hooks.c       | 18 ++++++++----------
 include/linux/fscrypt.h | 10 ++++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..71463cef08f9 100644
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
+	fscrypt_prepare_lookup_dentry(dentry, fname->is_nokey_name);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
@@ -131,12 +128,13 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
 int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
 {
 	int err = fscrypt_get_encryption_info(dir, true);
+	bool is_nokey_name = false;
+
+	if (!err && !fscrypt_has_encryption_key(dir))
+		is_nokey_name = true;
+
+	fscrypt_prepare_lookup_dentry(dentry, is_nokey_name);
 
-	if (!err && !fscrypt_has_encryption_key(dir)) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(fscrypt_prepare_lookup_partial);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..68ca8706483a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -948,6 +948,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
 	return 0;
 }
 
+static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
+						 bool is_nokey_name)
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


