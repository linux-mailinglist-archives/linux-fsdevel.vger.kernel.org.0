Return-Path: <linux-fsdevel+bounces-11282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF94852759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18D91C2323D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239134416;
	Tue, 13 Feb 2024 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s2Osc7Be";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8SptKwGP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s2Osc7Be";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8SptKwGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27516FA8;
	Tue, 13 Feb 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790427; cv=none; b=IIxok8vDJhDto9Rgq8tvOppvIWx2GSPZS+8Ko8WQfl+VANEtbjdXHEBU7VILzmsra/2PWRe4GVM6jBuekTddQA58IeIx3eQqgSugJz5m61NaLCnLEP8nWGSVy8Cyt3RgTSQiUvdYeD06w4ACXZbgJjxEAsoFoBRLB93CKGesgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790427; c=relaxed/simple;
	bh=W9+BV1dtP5KtyGgxXGMUfGsAVbNa7mDVbqyrZpfwJ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3kXfG/Ov8POoL9odl8lQNSvw8EgzZ8V3VF+HBWET1i56cjiQC0oWB+8OaYGBTI0Mw8BsCpbfmhpEd/1B+bejPsdg6EgeeGFEr8Gvgww8W16HhwRgI3ftkNJQkRS1QSkMCOHx7i4ukJEBI0lVQou/jBliI8WvICcH/EaOQVBYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s2Osc7Be; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8SptKwGP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s2Osc7Be; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8SptKwGP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2105D21E2B;
	Tue, 13 Feb 2024 02:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRqtXwf6B46aK5CAeQBaqHxSfCeg8lo7xfelx6b6v4k=;
	b=s2Osc7BeZgZIKekmdM1hrlZidnCGG0K0p2qgsUlqLjOAyHJK3l+AZlTtzd971zxkcEXteJ
	nMVm8ZML/C295iG9xKY/9bTW+1R2M+45n6oYELd0dLfSoAfT67py6zTXl5xdyw3E6zy4mn
	MupZ/uLPK4TjobUICR3T4e2mWAWenrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRqtXwf6B46aK5CAeQBaqHxSfCeg8lo7xfelx6b6v4k=;
	b=8SptKwGP066vLS8tZ+19xWbXXiLzYuNVEZ39T9hDBz6yMYIEghcZlGxVlzD6EuRKSSir4t
	c+m69r8GzhbixwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRqtXwf6B46aK5CAeQBaqHxSfCeg8lo7xfelx6b6v4k=;
	b=s2Osc7BeZgZIKekmdM1hrlZidnCGG0K0p2qgsUlqLjOAyHJK3l+AZlTtzd971zxkcEXteJ
	nMVm8ZML/C295iG9xKY/9bTW+1R2M+45n6oYELd0dLfSoAfT67py6zTXl5xdyw3E6zy4mn
	MupZ/uLPK4TjobUICR3T4e2mWAWenrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRqtXwf6B46aK5CAeQBaqHxSfCeg8lo7xfelx6b6v4k=;
	b=8SptKwGP066vLS8tZ+19xWbXXiLzYuNVEZ39T9hDBz6yMYIEghcZlGxVlzD6EuRKSSir4t
	c+m69r8GzhbixwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD2C13A4B;
	Tue, 13 Feb 2024 02:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FSXL1fQymUXeAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:43 +0000
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
Subject: [PATCH v6 03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
Date: Mon, 12 Feb 2024 21:13:14 -0500
Message-ID: <20240213021321.1804-4-krisman@suse.de>
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
	none
X-Spamd-Result: default: False [4.85 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.01%]
X-Spam-Level: ****
X-Spam-Score: 4.85
X-Spam-Flag: NO

Unencrypted and encrypted-dentries where the key is available don't need
to be revalidated by fscrypt, since they don't go stale from under VFS
and the key cannot be removed for the encrypted case without evicting
the dentry.  Disable their d_revalidate hook on the first lookup, to
avoid repeated revalidation later. This is done in preparation to always
configuring d_op through sb->s_d_op.

The only part detail is that, since the filesystem might have other
features that require revalidation, we only apply this optimization if
the d_revalidate handler is fscrypt_d_revalidate itself.

Finally, we need to clean the dentry->flags even for unencrypted
dentries, so the ->d_lock might be acquired even for them.  In order to
avoid doing it for filesystems that don't care about fscrypt at all, we
peek ->d_flags without the lock at first, and only acquire it if we
actually need to write the flag.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v5
 - d_set_always_valid -> d_revalidate (eric)
 - Avoid acquiring the lock for !fscrypt-capable filesystems (eric, Christian)
---
 include/linux/fscrypt.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 47567a6a4f9d..d1f17b90c30f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -951,10 +951,29 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
 static inline void fscrypt_prepare_dentry(struct dentry *dentry,
 					  bool is_nokey_name)
 {
+	/*
+	 * This code tries to only take ->d_lock when necessary to write
+	 * to ->d_flags.  We shouldn't be peeking on d_flags for
+	 * DCACHE_OP_REVALIDATE unlocked, but in the unlikely case
+	 * there is a race, the worst it can happen is that we fail to
+	 * unset DCACHE_OP_REVALIDATE and pay the cost of an extra
+	 * d_revalidate.
+	 */
 	if (is_nokey_name) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
 		spin_unlock(&dentry->d_lock);
+	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
+		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
+		/*
+		 * Unencrypted dentries and encrypted dentries where the
+		 * key is available are always valid from fscrypt
+		 * perspective. Avoid the cost of calling
+		 * fscrypt_d_revalidate unnecessarily.
+		 */
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
+		spin_unlock(&dentry->d_lock);
 	}
 }
 
@@ -992,6 +1011,9 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 	fname->usr_fname = &dentry->d_name;
 	fname->disk_name.name = (unsigned char *)dentry->d_name.name;
 	fname->disk_name.len = dentry->d_name.len;
+
+	fscrypt_prepare_dentry(dentry, false);
+
 	return 0;
 }
 
-- 
2.43.0


