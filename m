Return-Path: <linux-fsdevel+bounces-8206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCBD830F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52180B240D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5F286B4;
	Wed, 17 Jan 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMRRDo65";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6bG3T+Vo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMRRDo65";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6bG3T+Vo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0725569
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530542; cv=none; b=cnG34c/6Ai3aHfx3tEqx7/lrSR1khjcj4VisZLjdpxJZ/o6IyjmBmoDamqA5EVE7Yph4oGWQCglOd+1txY9gutppr3SfPH3ZJF09iqhxvhgTyXzv24K/svGr4hE+y9oxmFS1+bv5XssHqeTuo1BzyTaKSc1ie5b0OAeNZtBL2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530542; c=relaxed/simple;
	bh=vDc0J/J131zuk5Xssw7kyCwIlAdX0r4qUKnK5Xp7cIc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=aP/0CfSZlEp4Y3AQl9TPm3jMsZlID4o8mFyJo5npcmL0pdf5AJKFHsUTXA8cgaIkpjb0hnKrL3OvrNHwyXMCZ5hLP9Q9HhrEdFYEObuP4uU3XZSdPsGwuQYoSKQQ9pwy5V5Krgm3xoBqAzC3pMqz/Tjen4LLIyP0KcZVvUkQgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMRRDo65; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6bG3T+Vo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMRRDo65; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6bG3T+Vo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F8D121F6D;
	Wed, 17 Jan 2024 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705530538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=56Zi2+OC43dvCoXN5VWO4gOvQqcFhBpoynTAfbhXVkc=;
	b=TMRRDo65XoAouq2JynBoMRk/hmvOi+12kZmiCSbcSlOrOsR6MettUGnqigW+VoM5jxl9LC
	cL+hwcz4hZg0PozpJ/2MeCuLu1NGBED7AXGi0C9KdN474RXUoIWrDRKFhehs/YOMae/5qc
	RX9fM4d3sKaJWrrfGHDuAQK6f7ZjZL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705530538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=56Zi2+OC43dvCoXN5VWO4gOvQqcFhBpoynTAfbhXVkc=;
	b=6bG3T+VoHL7k/4x7Sxrbym0D++MGwP8jHgne/1yA10OfRk1jhqoFO4A1rsCC3cY1H+vqBI
	JV+v7mCQ9EbtawAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705530538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=56Zi2+OC43dvCoXN5VWO4gOvQqcFhBpoynTAfbhXVkc=;
	b=TMRRDo65XoAouq2JynBoMRk/hmvOi+12kZmiCSbcSlOrOsR6MettUGnqigW+VoM5jxl9LC
	cL+hwcz4hZg0PozpJ/2MeCuLu1NGBED7AXGi0C9KdN474RXUoIWrDRKFhehs/YOMae/5qc
	RX9fM4d3sKaJWrrfGHDuAQK6f7ZjZL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705530538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=56Zi2+OC43dvCoXN5VWO4gOvQqcFhBpoynTAfbhXVkc=;
	b=6bG3T+VoHL7k/4x7Sxrbym0D++MGwP8jHgne/1yA10OfRk1jhqoFO4A1rsCC3cY1H+vqBI
	JV+v7mCQ9EbtawAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA3F013751;
	Wed, 17 Jan 2024 22:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id na6DKKlUqGVHFQAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 17 Jan 2024 22:28:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] libfs: Attempt exact-match comparison first during casefold lookup
Date: Wed, 17 Jan 2024 19:28:36 -0300
Message-ID: <20240117222836.11086-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux-foundation.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

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
 fs/libfs.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..d17a8adb4a35 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1704,17 +1704,28 @@ bool is_empty_dir_inode(struct inode *inode)
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
+	struct qstr qstr;
 	int ret;
 
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 */
+	if (len == name->len && !memcmp(str, name->name, len))
+		return 0;
+
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
@@ -1724,20 +1735,17 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
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
-
-	if (sb_has_strict_encoding(sb))
+	qstr.len = len;
+	qstr.name = str;
+	ret = utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
+	if (ret < 0)
 		return -EINVAL;
-fallback:
-	if (len != name->len)
-		return 1;
-	return !!memcmp(str, name->name, len);
+
+	return ret;
 }
 
 /**
-- 
2.43.0


