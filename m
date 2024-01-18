Return-Path: <linux-fsdevel+bounces-8213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E430883109F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1371F24C95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E638F63;
	Thu, 18 Jan 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uaIbHhYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EEQYjqUD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uaIbHhYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EEQYjqUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53279E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538787; cv=none; b=mCYzZ5Qbvnb974VWp4g2tG9I1urFkkCA7+zaB7wNGvS9HNRknxjgTWl0OGwOr24s0NI52dsYmSObh02/OP8yJOi9Kj/d4BaEBAWyq2R9T3tWjBJzVym1nVWlI3k7wa9/IAGhQ14dOcqTrk4EVdW9BTJHNWXc4A4YPTtuUeLeYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538787; c=relaxed/simple;
	bh=QUyBKStaloCvKEHaIBCS3aZ87yv3pRj+2bC6MROQXQc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Spam-Flag:X-Spamd-Bar; b=pFuI+jCb+Zigl9AeJPIDNCB8mx4ui2N0vhlOA5RYmVRQxqfVfnVK3IRa4Y19PLTuAzIhwiG60OKfnap84cTgxpn1I9Z1BzI9vMIO7mJDmU011yfKsqB+0WJNgM/4/bCOhcyRxPznQXeOeVGXLO/jWYy1nspCeqbsgcFmekuzsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uaIbHhYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EEQYjqUD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uaIbHhYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EEQYjqUD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 971E021FD6;
	Thu, 18 Jan 2024 00:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705538783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cIBztgFZMyETZNo0STNuqiBsJwxK54/hj5pO0I2/7eE=;
	b=uaIbHhYJd8hafwwqrcbYQy29zePQjhyAl4Zk111sXkWIuvbia1EVOK95gHPJTa04iI/RiG
	0eHNYAVlr5Q3rfB56yjVRuduuCZJE9QW3XaQQSYqffi58/s4EFREV2GlBI50KDwmZUm9e6
	TcWdteV+3IJlrQXRYdmH//NSL/1kPWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705538783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cIBztgFZMyETZNo0STNuqiBsJwxK54/hj5pO0I2/7eE=;
	b=EEQYjqUDJ5oOewVcZ1HnH4NRgtoAafb0PQqLM4liMQ11S6d2xcxEJU4gUfbcO+MT0oC16u
	Phb4UpNsBgpSNADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705538783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cIBztgFZMyETZNo0STNuqiBsJwxK54/hj5pO0I2/7eE=;
	b=uaIbHhYJd8hafwwqrcbYQy29zePQjhyAl4Zk111sXkWIuvbia1EVOK95gHPJTa04iI/RiG
	0eHNYAVlr5Q3rfB56yjVRuduuCZJE9QW3XaQQSYqffi58/s4EFREV2GlBI50KDwmZUm9e6
	TcWdteV+3IJlrQXRYdmH//NSL/1kPWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705538783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cIBztgFZMyETZNo0STNuqiBsJwxK54/hj5pO0I2/7eE=;
	b=EEQYjqUDJ5oOewVcZ1HnH4NRgtoAafb0PQqLM4liMQ11S6d2xcxEJU4gUfbcO+MT0oC16u
	Phb4UpNsBgpSNADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDDC6136F5;
	Thu, 18 Jan 2024 00:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DFLTKt50qGWcNwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 00:46:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] libfs: Attempt exact-match comparison first during casefold lookup
Date: Wed, 17 Jan 2024 21:46:18 -0300
Message-ID: <20240118004618.19707-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uaIbHhYJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EEQYjqUD
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 971E021FD6
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Casefolded comparisons are (obviously) way more costly than a simple
memcmp.  Try the case-sensitive comparison first, falling-back to the
case-insensitive lookup only when needed.  This allows any exact-match
lookup to complete without having to walk the utf8 trie.

Note that, for strict mode, generic_ci_d_compare used to reject an
invalid UTF-8 string, which would now be considered valid if it
exact-matches the disk-name.  But, if that is the case, the filesystem
is corrupt.  More than that, it really doesn't matter in practice,
because the name-under-lookup will have already been rejected by
generic_ci_d_hash and we won't even get here.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v1:
  - just return utf8_strncasemp directly (Al Viro)
---
 fs/libfs.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..0b553215eda8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1704,17 +1704,27 @@ bool is_empty_dir_inode(struct inode *inode)
 static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 				const char *str, const struct qstr *name)
 {
-	const struct dentry *parent = READ_ONCE(dentry->d_parent);
-	const struct inode *dir = READ_ONCE(parent->d_inode);
-	const struct super_block *sb = dentry->d_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct qstr qstr = QSTR_INIT(str, len);
+	const struct dentry *parent;
+	const struct inode *dir;
 	char strbuf[DNAME_INLINE_LEN];
-	int ret;
+	struct qstr qstr;
+
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 */
+	if (len == name->len && !memcmp(str, name->name, len))
+		return 0;
 
+	parent = READ_ONCE(dentry->d_parent);
+	dir = READ_ONCE(parent->d_inode);
 	if (!dir || !IS_CASEFOLDED(dir))
-		goto fallback;
+		return 1;
+
 	/*
+	 * Finally, try the case-insensitive match.
+	 *
 	 * If the dentry name is stored in-line, then it may be concurrently
 	 * modified by a rename.  If this happens, the VFS will eventually retry
 	 * the lookup, so it doesn't matter what ->d_compare() returns.
@@ -1724,20 +1734,14 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	if (len <= DNAME_INLINE_LEN - 1) {
 		memcpy(strbuf, str, len);
 		strbuf[len] = 0;
-		qstr.name = strbuf;
+		str = strbuf;
 		/* prevent compiler from optimizing out the temporary buffer */
 		barrier();
 	}
-	ret = utf8_strncasecmp(um, name, &qstr);
-	if (ret >= 0)
-		return ret;
+	qstr.len = len;
+	qstr.name = str;
 
-	if (sb_has_strict_encoding(sb))
-		return -EINVAL;
-fallback:
-	if (len != name->len)
-		return 1;
-	return !!memcmp(str, name->name, len);
+	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
 
 /**
-- 
2.43.0


