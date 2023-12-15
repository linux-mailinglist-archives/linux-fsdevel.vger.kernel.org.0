Return-Path: <linux-fsdevel+bounces-6231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846E8151C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FF1C24078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED848CE6;
	Fri, 15 Dec 2023 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0PbC4ieI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5x41is8J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0PbC4ieI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5x41is8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2B47F7A;
	Fri, 15 Dec 2023 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E9371F863;
	Fri, 15 Dec 2023 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFdpRL19Qo72V5iD16rSLzA5DXdY7+DFwh/2hlpfLqI=;
	b=0PbC4ieIDnc8k96lBUCBSBJdgMCggwUaTxtfGkWiKpTA+onRQVeH/wvJNqbTBJhULfz31x
	AHAeyRPrSmhlndlcGEMsxGayZpOQ21lXWdl8YIlQYM82j+c3gJXtcbpmpoGkgBQVSAmfup
	MoPFCWyBEcBkWTxMNPMy5OxwIGDGXaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFdpRL19Qo72V5iD16rSLzA5DXdY7+DFwh/2hlpfLqI=;
	b=5x41is8J3UjiUO+NUlXQDmmbb0nMC4xGU9RXf5QraFMqwbtqsyesZG9vAMu4ulJHXexC9q
	Yb8Zd3TXBw8bVzAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFdpRL19Qo72V5iD16rSLzA5DXdY7+DFwh/2hlpfLqI=;
	b=0PbC4ieIDnc8k96lBUCBSBJdgMCggwUaTxtfGkWiKpTA+onRQVeH/wvJNqbTBJhULfz31x
	AHAeyRPrSmhlndlcGEMsxGayZpOQ21lXWdl8YIlQYM82j+c3gJXtcbpmpoGkgBQVSAmfup
	MoPFCWyBEcBkWTxMNPMy5OxwIGDGXaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFdpRL19Qo72V5iD16rSLzA5DXdY7+DFwh/2hlpfLqI=;
	b=5x41is8J3UjiUO+NUlXQDmmbb0nMC4xGU9RXf5QraFMqwbtqsyesZG9vAMu4ulJHXexC9q
	Yb8Zd3TXBw8bVzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02A4137D4;
	Fri, 15 Dec 2023 21:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9nfHKyLCfGWMOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:18 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 2/8] fscrypt: Drop d_revalidate if key is available
Date: Fri, 15 Dec 2023 16:16:02 -0500
Message-ID: <20231215211608.6449-3-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215211608.6449-1-krisman@suse.de>
References: <20231215211608.6449-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.63
X-Spamd-Result: default: False [4.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[73.94%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ****
X-Spam-Flag: NO

fscrypt dentries are always valid once the key is available.  Since the
key cannot be removed without evicting the dentry, we don't need to keep
retrying to revalidate it.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/crypto/fname.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 7b3fc189593a..0457ba2d7d76 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -591,8 +591,15 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	 * reverting to no-key names without evicting the directory's inode
 	 * -- which implies eviction of the dentries in the directory.
 	 */
-	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
+	if (!(dentry->d_flags & DCACHE_NOKEY_NAME)) {
+		/*
+		 * If fscrypt is the only feature requiring
+		 * revalidation for this dentry, we can just disable it.
+		 */
+		if (dentry->d_op->d_revalidate == &fscrypt_d_revalidate)
+			d_set_always_valid(dentry);
 		return 1;
+	}
 
 	/*
 	 * No-key name; valid if the directory's key is still unavailable.
-- 
2.43.0


