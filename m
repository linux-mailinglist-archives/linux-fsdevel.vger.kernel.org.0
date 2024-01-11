Return-Path: <linux-fsdevel+bounces-7826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E482B764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7081C243B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D75914B;
	Thu, 11 Jan 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mZDO2nNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mBc57u00";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mZDO2nNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mBc57u00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412239FC5;
	Thu, 11 Jan 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5CC52224C;
	Thu, 11 Jan 2024 22:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705013933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=mZDO2nNrpqHQMxg8euhKqdOuPjYCb/FFILlqbK6LTximzV6F67BWOOzkHex/xiTWBG6OJY
	VhwGJe74+sdDs4oijT0DIFoI/cPpXqmRL/X2k51HMo0N5CXgmUnrrj4fPskMK4Ju1Ekn2I
	9Dmhh0WdRNLPFzPLIIqnC17jRY+d+wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705013933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=mBc57u00PH/hw+n8mGU5jVB7oke0VDIvO1byYPDa/eZclL4jSOHDQBD1kBOOa2QZVFUf3+
	2JN/Ek7GE5eO0dBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705013933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=mZDO2nNrpqHQMxg8euhKqdOuPjYCb/FFILlqbK6LTximzV6F67BWOOzkHex/xiTWBG6OJY
	VhwGJe74+sdDs4oijT0DIFoI/cPpXqmRL/X2k51HMo0N5CXgmUnrrj4fPskMK4Ju1Ekn2I
	9Dmhh0WdRNLPFzPLIIqnC17jRY+d+wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705013933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=mBc57u00PH/hw+n8mGU5jVB7oke0VDIvO1byYPDa/eZclL4jSOHDQBD1kBOOa2QZVFUf3+
	2JN/Ek7GE5eO0dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5DB13946;
	Thu, 11 Jan 2024 22:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RHP+MKxyoGVeLwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 11 Jan 2024 22:58:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
Date: Thu, 11 Jan 2024 19:58:09 -0300
Message-ID: <20240111225816.18117-4-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111225816.18117-1-krisman@suse.de>
References: <20240111225816.18117-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.41 / 50.00];
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
	 FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.49)[79.74%]
X-Spam-Level: ****
X-Spam-Score: 4.41
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
 fs/crypto/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 41df986d1230..53381acc83e7 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -127,6 +127,15 @@ int fscrypt_prepare_lookup_dentry(struct inode *dir,
 	spin_lock(&dentry->d_lock);
 	if (nokey_name) {
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
+	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
+		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
+		/*
+		 * Unencrypted dentries and encrypted dentries where the
+		 * key is available are always valid from fscrypt
+		 * perspective. Avoid the cost of calling
+		 * fscrypt_d_revalidate unnecessarily.
+		 */
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 	}
 	spin_unlock(&dentry->d_lock);
 
-- 
2.43.0


