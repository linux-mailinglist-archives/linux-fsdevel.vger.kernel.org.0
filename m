Return-Path: <linux-fsdevel+bounces-9142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1F83E802
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6500284B7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94933DD;
	Sat, 27 Jan 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKo1zCKb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aZVg/Fsb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKo1zCKb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aZVg/Fsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C02F30;
	Sat, 27 Jan 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314239; cv=none; b=fHrUuHpZMTQehOHg+APwkppa36awOZQxWT68zfi1kTUmpxgVNKlmNFuBL5c6z3z0BZwKDa86dH4TWotNre3/PuHugBJOwUNVudbK+LEpQ1BG12+5fWcAUPF6NKrL3NRGT+jg88ztb+HlQiHq3rd/ilEdEqPaLxxkZV7pfM2y84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314239; c=relaxed/simple;
	bh=S8wRZe/duQmKvG5LJ7bzdS0gi1Iz5Uta3lawZrqNAPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn8kLyXqNhDpFhblq5Evq1rvqDkPc+Fwucmdcx6DrxTZo7tU2lAraGTDeiPuP+N17uaMCUoo9UUX+W89y2zzo7mWcxu1/lelhmmGZ03ntqmfhpaWwXmIPX7oZr5SmIsMhgzxHqTleIlF783Pv4YAAmJIXSnDcO4GYDRJ826EJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKo1zCKb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aZVg/Fsb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKo1zCKb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aZVg/Fsb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCD5A1FDB5;
	Sat, 27 Jan 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pedrDAyodui+t1vV5VqCovZAmeHiWI4BdqWsbJ87tRE=;
	b=CKo1zCKbYgnNFY/q1JmBghIYJv2lhPqdGMadhM3O33D5mJClGb3MfaDz9TF4IjuWecNKjY
	ejj0njC7dMyrI0FzFwHxdc0VoX/USWhleVmoNn7JnPzjqOmuSLidFr71k7f4i/Lewwaj/o
	GHUVUlxKcueG/ppSmTXZWIuMo43In+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pedrDAyodui+t1vV5VqCovZAmeHiWI4BdqWsbJ87tRE=;
	b=aZVg/Fsbf/TWSmpzAs2dAn80uqTvMOiaFj5RUVMcOK6HoUOXf/UnBy1UjfSOO6KG+ibGb2
	Fv6i0TZ6YUQ7TdBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pedrDAyodui+t1vV5VqCovZAmeHiWI4BdqWsbJ87tRE=;
	b=CKo1zCKbYgnNFY/q1JmBghIYJv2lhPqdGMadhM3O33D5mJClGb3MfaDz9TF4IjuWecNKjY
	ejj0njC7dMyrI0FzFwHxdc0VoX/USWhleVmoNn7JnPzjqOmuSLidFr71k7f4i/Lewwaj/o
	GHUVUlxKcueG/ppSmTXZWIuMo43In+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pedrDAyodui+t1vV5VqCovZAmeHiWI4BdqWsbJ87tRE=;
	b=aZVg/Fsbf/TWSmpzAs2dAn80uqTvMOiaFj5RUVMcOK6HoUOXf/UnBy1UjfSOO6KG+ibGb2
	Fv6i0TZ6YUQ7TdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2159413998;
	Sat, 27 Jan 2024 00:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XxL8MfRJtGVcEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:28 +0000
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
Subject: [PATCH v4 03/12] fscrypt: Call fscrypt_prepare_lookup_dentry on unencrypted dentries
Date: Fri, 26 Jan 2024 21:10:03 -0300
Message-ID: <20240127001013.2845-4-krisman@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CKo1zCKb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="aZVg/Fsb"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: BCD5A1FDB5
X-Spam-Flag: NO

In preparation to dropping DCACHE_OP_REVALIDATE for dentries that
don't need it at lookup time, refactor the code to make unencrypted
denties also call fscrypt_prepare_dentry.  This makes the
non-inline __fscrypt_prepare_lookup superfulous, so drop it.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/crypto/hooks.c       | 14 --------------
 include/linux/fscrypt.h | 31 +++++++++++++++----------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 71463cef08f9..eb870bc162e6 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -94,20 +94,6 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_rename);
 
-int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
-			     struct fscrypt_name *fname)
-{
-	int err = fscrypt_setup_filename(dir, &dentry->d_name, 1, fname);
-
-	if (err && err != -ENOENT)
-		return err;
-
-	fscrypt_prepare_lookup_dentry(dentry, fname->is_nokey_name);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
-
 /**
  * fscrypt_prepare_lookup_partial() - prepare lookup without filename setup
  * @dir: the encrypted directory being searched
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 68ca8706483a..4aaf847955c0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -382,8 +382,6 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags);
-int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
-			     struct fscrypt_name *fname);
 int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry);
 int __fscrypt_prepare_readdir(struct inode *dir);
 int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr);
@@ -704,13 +702,6 @@ static inline int __fscrypt_prepare_rename(struct inode *old_dir,
 	return -EOPNOTSUPP;
 }
 
-static inline int __fscrypt_prepare_lookup(struct inode *dir,
-					   struct dentry *dentry,
-					   struct fscrypt_name *fname)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int fscrypt_prepare_lookup_partial(struct inode *dir,
 						 struct dentry *dentry)
 {
@@ -985,14 +976,22 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 struct fscrypt_name *fname)
 {
-	if (IS_ENCRYPTED(dir))
-		return __fscrypt_prepare_lookup(dir, dentry, fname);
+	int err = 0;
+
+	if (IS_ENCRYPTED(dir)) {
+		err = fscrypt_setup_filename(dir, &dentry->d_name, 1, fname);
+		if (err && err != -ENOENT)
+			return err;
+	} else {
+		memset(fname, 0, sizeof(*fname));
+		fname->usr_fname = &dentry->d_name;
+		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
+		fname->disk_name.len = dentry->d_name.len;
+	}
 
-	memset(fname, 0, sizeof(*fname));
-	fname->usr_fname = &dentry->d_name;
-	fname->disk_name.name = (unsigned char *)dentry->d_name.name;
-	fname->disk_name.len = dentry->d_name.len;
-	return 0;
+	fscrypt_prepare_lookup_dentry(dentry, fname->is_nokey_name);
+
+	return err;
 }
 
 /**
-- 
2.43.0


