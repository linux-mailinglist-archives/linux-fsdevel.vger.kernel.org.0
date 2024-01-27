Return-Path: <linux-fsdevel+bounces-9141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983D83E800
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E757F1F284EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D92907;
	Sat, 27 Jan 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIlMEfCT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xz9TFm/U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIlMEfCT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xz9TFm/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AB20F0;
	Sat, 27 Jan 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314237; cv=none; b=riQrikEyaQKmVUrwZ1nyWzAp5ISbXuieEbR+Kr/kEyGB1K/0rFpfMsRDxupGbH+SHJQTi8JuFpiRO7xDOb17xZrNQOv8hufp0U7WvOutd3Eu0qqjocTYAoNCOHJywrMhdsqEmXcmfdS9drLg7u+lvT1TJGTA3Lhycso2JDiTV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314237; c=relaxed/simple;
	bh=J1AU5YIm+7xYPJh5a3WE5kWCW+pWVpLtgvTZl5Zp1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAkOJ8uX6xjI0H3vHoJshvNG9D79rjGlJ4h2P6+Tnf39KkBFtxGnuZ+fRdGITN9vO4SATA/YKYXqFeZLFe6bwwZw9HXqhtz6LiVe1DHlzvDKB9BzuBuls28/oQl/0gXDQ9ts818NOmmvbFKG+0mUv7g2G44CpRo8N2B4vwxePPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIlMEfCT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xz9TFm/U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIlMEfCT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xz9TFm/U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B14C223A2;
	Sat, 27 Jan 2024 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFf2P+TvRG7M8VFr2Z2JnXZ5zzx7Ytjk1bFgdtQ+JA4=;
	b=hIlMEfCT7leuXNVllpw9w9CRYtDpDP90wFY6jwfG1Ems9IEkQ+axCJlNKVS7dTqCayQoyk
	Uzedamq/+Js/DlqgrGXc6IKRumm8g0VLoYYT8En67JHkDpxCsl8zF0Qzs5CeIQ3EGpfuy+
	NhIJwnr6G7zS+a9HQy0InkFozTXP4/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFf2P+TvRG7M8VFr2Z2JnXZ5zzx7Ytjk1bFgdtQ+JA4=;
	b=xz9TFm/U7icSMnJnAlTHBobbjA1hdhJbRhHD/nGTVtlg4APzeti3QbimNVnGBrTFbrVbBr
	wIUPAGyBR0I3rkCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFf2P+TvRG7M8VFr2Z2JnXZ5zzx7Ytjk1bFgdtQ+JA4=;
	b=hIlMEfCT7leuXNVllpw9w9CRYtDpDP90wFY6jwfG1Ems9IEkQ+axCJlNKVS7dTqCayQoyk
	Uzedamq/+Js/DlqgrGXc6IKRumm8g0VLoYYT8En67JHkDpxCsl8zF0Qzs5CeIQ3EGpfuy+
	NhIJwnr6G7zS+a9HQy0InkFozTXP4/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFf2P+TvRG7M8VFr2Z2JnXZ5zzx7Ytjk1bFgdtQ+JA4=;
	b=xz9TFm/U7icSMnJnAlTHBobbjA1hdhJbRhHD/nGTVtlg4APzeti3QbimNVnGBrTFbrVbBr
	wIUPAGyBR0I3rkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0841313998;
	Sat, 27 Jan 2024 00:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGm1LPhJtGVhEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:32 +0000
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
Subject: [PATCH v4 04/12] fscrypt: Drop d_revalidate for valid dentries during lookup
Date: Fri, 26 Jan 2024 21:10:04 -0300
Message-ID: <20240127001013.2845-5-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127001013.2845-1-krisman@suse.de>
References: <20240127001013.2845-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.36 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.54)[80.63%]
X-Spam-Level: ****
X-Spam-Score: 4.36
X-Spam-Flag: NO

Unencrypted and encrypted-dentries where the key is available don't need
to be revalidated with regards to fscrypt, since they don't go stale
from under VFS and the key cannot be removed for the encrypted case
without evicting the dentry.  Mark them with d_set_always_valid, to
avoid unnecessary revalidation, in preparation to always configuring
d_op through sb->s_d_op.

Since the filesystem might have other features that require
revalidation, only apply this optimization if the d_revalidate handler
is fscrypt_d_revalidate itself.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 include/linux/fscrypt.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4aaf847955c0..a22997b9f35c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
 static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
 						 bool is_nokey_name)
 {
-	if (is_nokey_name) {
-		spin_lock(&dentry->d_lock);
+	spin_lock(&dentry->d_lock);
+
+	if (is_nokey_name)
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
+	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
+		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
+		/*
+		 * Unencrypted dentries and encrypted dentries where the
+		 * key is available are always valid from fscrypt
+		 * perspective. Avoid the cost of calling
+		 * fscrypt_d_revalidate unnecessarily.
+		 */
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 	}
+
+	spin_unlock(&dentry->d_lock);
 }
 
 /**
-- 
2.43.0


