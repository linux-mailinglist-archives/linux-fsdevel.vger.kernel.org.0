Return-Path: <linux-fsdevel+bounces-8340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59124832FBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE761C23709
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2A5674C;
	Fri, 19 Jan 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTfLHEOB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eeq9M15K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTfLHEOB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eeq9M15K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24054F92
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695961; cv=none; b=r1xcKFeU/IBAZOJuB4m7NDzobRp5TZfAGYmNGirIvzGcAHdk1pcDI5iQ+xi3AVD/4akVl9gqM8qXZi8l9huINYw9urssPti13qaF/uwn9OD4c4aAHQhueuCC2E40ozLT4HFCZ1CWbTZOhMSR+vrvkaCvrjtoKOQfKvFbsT+2o0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695961; c=relaxed/simple;
	bh=vw0MCcWmfwYz814vGmNC3oOk9E8MHA6FjvtM4iAneJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZWRiXDXo9GRtOBgRoMaGukZ7nBVZW71EfntZZThN8QSV0dbKufxL8mRv89ijmZcBBDHqZ9l5YlTEjl/gglZ+BrWEPFy1zg9J0xVCx4CKnngRaBlFZi5IOO3nd5pCcXAoj9v48cbFQy0sZ8ZKabqF3pADUDsOpK/vbAvWaGlGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTfLHEOB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eeq9M15K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTfLHEOB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eeq9M15K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA34121F1A;
	Fri, 19 Jan 2024 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKC1/M3+2TR/q1Ad6mSemxaEfci9pXqisb1d8OKTpqg=;
	b=yTfLHEOB1TFPZAXZTlA21TKkJT8YI6aFf7T9L0tYlMABlyycEezCoyJk/95jIanA4Fg5fj
	HKo9qQ2BOf8cmEmjpn32teyM1CenHfzT2jBqQgZPuREB/ZE/MI85QMA67L9dbcAFK/e21B
	XScYcLBkV0BvhYN3kSsEmk2GTUKM3KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKC1/M3+2TR/q1Ad6mSemxaEfci9pXqisb1d8OKTpqg=;
	b=eeq9M15KgGCfXnkWsXIHuUzVnY2M69FAZRQJujRGORF+RyM9etnkoGpmxt9Ldd3+833OtK
	y34t35I30rxzafDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKC1/M3+2TR/q1Ad6mSemxaEfci9pXqisb1d8OKTpqg=;
	b=yTfLHEOB1TFPZAXZTlA21TKkJT8YI6aFf7T9L0tYlMABlyycEezCoyJk/95jIanA4Fg5fj
	HKo9qQ2BOf8cmEmjpn32teyM1CenHfzT2jBqQgZPuREB/ZE/MI85QMA67L9dbcAFK/e21B
	XScYcLBkV0BvhYN3kSsEmk2GTUKM3KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKC1/M3+2TR/q1Ad6mSemxaEfci9pXqisb1d8OKTpqg=;
	b=eeq9M15KgGCfXnkWsXIHuUzVnY2M69FAZRQJujRGORF+RyM9etnkoGpmxt9Ldd3+833OtK
	y34t35I30rxzafDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E2C1136F5;
	Fri, 19 Jan 2024 20:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JkJfMdTaqmX9JQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 20:25:56 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org
Cc: tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 2/2] libfs: Attempt exact-match comparison first during casefold lookup
Date: Fri, 19 Jan 2024 17:25:43 -0300
Message-ID: <20240119202544.19434-3-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119202544.19434-1-krisman@suse.de>
References: <20240119202544.19434-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

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
changes since v2:
  - Use dentry_string_cmp instead of memcmp (Linus, Eric)
changes since v1:
  - just return utf8_strncasemp directly (Al Viro)
---
 fs/libfs.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..f64036a2eb7f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1704,16 +1704,27 @@ bool is_empty_dir_inode(struct inode *inode)
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
+	 *
+	 * dentry->d_name might change from under us.  use str instead,
+           and make sure to not rely on len.
+	 */
+	if (!dentry_string_cmp(str, name->name, name->len))
+		return 0;
 
+	parent = READ_ONCE(dentry->d_parent);
+	dir = READ_ONCE(parent->d_inode);
 	if (!dir || !IS_CASEFOLDED(dir))
-		goto fallback;
+		return 1;
+
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
 	 * modified by a rename.  If this happens, the VFS will eventually retry
@@ -1724,20 +1735,14 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
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


