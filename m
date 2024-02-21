Return-Path: <linux-fsdevel+bounces-12287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755185E430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA61F25904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90683CCE;
	Wed, 21 Feb 2024 17:14:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DA33F7;
	Wed, 21 Feb 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535671; cv=none; b=uxEcRyIOdXuVnxxoJlz6qFcPmXBeh6gN0BA4t+ClsTcbDddtxpp59ezR5tU+XedVLXEiCmSNteJzstRc7DOnd13sEgnMgWNeQaiIyic/w19WjwmG2/L92ovI6G76OxeG7RprW02Dnt8a/F8jsKOOIlv/hfcEeP8Sc4Gf0ahlIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535671; c=relaxed/simple;
	bh=GWOcriDZ6/RCSRNtgUKVCdc752tbsc4zjdsjTuhCaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAs+Pw1E+UP7c8yOwNji49lFKlLsFl78CH8ctD8hs10H84aq/uzz01D0zUlpB4+USZNl3I+8tRDpjESj6JBEalIVc13hz7uDiAwuVIJAdv4lsUkGo6JqB+LoqcoLF4n0jHhpSkeEy8herNvrcN8xRCpKx8609Ip+LYOhoK1t344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C516821DB0;
	Wed, 21 Feb 2024 17:14:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89599139D0;
	Wed, 21 Feb 2024 17:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2S5XG3Mv1mVYKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:27 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org
Cc: tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v7 03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
Date: Wed, 21 Feb 2024 12:14:05 -0500
Message-ID: <20240221171412.10710-4-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221171412.10710-1-krisman@suse.de>
References: <20240221171412.10710-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C516821DB0
X-Spam-Level: 
X-Spam-Score: -4.00
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
index c76f859cf019..78af02b35bd9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -264,10 +264,29 @@ static inline bool fscrypt_is_nokey_name(const struct dentry *dentry)
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
 
@@ -997,6 +1016,9 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
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


