Return-Path: <linux-fsdevel+bounces-8331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB8832F1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8681F21D56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403B56475;
	Fri, 19 Jan 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bd7a8Fzj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxc5z4J3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bd7a8Fzj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxc5z4J3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288D53E05;
	Fri, 19 Jan 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690097; cv=none; b=kk9QM6uio5xRNhcerUF4EVr3x8pXFQKaggZD3IOQo3TcRl6paFfe6ftANyVlIf4RdsE6Jaz5nPdKqObcchFE4EQgRqjzNc/aFYBMS3MUJzC1P/Vvk7Xf1cUycuQKM+MMuUVppPSCtFWuGhaEH10L1d1nO/hZJ4nZBA5dYRz5b9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690097; c=relaxed/simple;
	bh=2BHZ4kOSFbgXIkl/spG50+rGShJ4A0UpcXXmJMbRaz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEOKUKeu6Zhh7gSSgMjQAfcixE3Tj4RXhqgPLY2PCZ8p9qiZ5YpslG39iolJk/ZLSuhs4yXuLKbLQwCytOhLR4kSROs2x14tEsoQpl1oI9Hs2Vr3O6jJtCjm0Cje2Izz3x5eas47bIuvZZov/NFf+Qt23sripNFL7G83mOj0cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bd7a8Fzj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxc5z4J3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bd7a8Fzj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxc5z4J3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C5161FD18;
	Fri, 19 Jan 2024 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuWHocVl9abpii7GXQfvM5RHPREe41daj4BzZwpSSVQ=;
	b=Bd7a8Fzj8c5ZBMJm1o1Odd57/XNoshOK9cuk+lVxPmOG3sYJiVbF8LJIVMwAUeR/88lpNT
	oI8k8NqQ0/DMNKLvrqPniwMG+VDkcKcLLDW0yMoI0Jp4MrtQ1Bc0Y8s3JdLfoC9+bcDL2i
	dRn9stEMaLPIhoOELjGKnToA97x6sy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuWHocVl9abpii7GXQfvM5RHPREe41daj4BzZwpSSVQ=;
	b=mxc5z4J3uUD8/iN48mbV2a9x3yYabCHscrhlhp8U5cOme6kHbpTHFlBlPi/kYnEfx4ovWt
	N9yqAm8p6BPOJlBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuWHocVl9abpii7GXQfvM5RHPREe41daj4BzZwpSSVQ=;
	b=Bd7a8Fzj8c5ZBMJm1o1Odd57/XNoshOK9cuk+lVxPmOG3sYJiVbF8LJIVMwAUeR/88lpNT
	oI8k8NqQ0/DMNKLvrqPniwMG+VDkcKcLLDW0yMoI0Jp4MrtQ1Bc0Y8s3JdLfoC9+bcDL2i
	dRn9stEMaLPIhoOELjGKnToA97x6sy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuWHocVl9abpii7GXQfvM5RHPREe41daj4BzZwpSSVQ=;
	b=mxc5z4J3uUD8/iN48mbV2a9x3yYabCHscrhlhp8U5cOme6kHbpTHFlBlPi/kYnEfx4ovWt
	N9yqAm8p6BPOJlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 852C7136F5;
	Fri, 19 Jan 2024 18:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uugLDu3DqmVQDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:13 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
Date: Fri, 19 Jan 2024 15:47:36 -0300
Message-ID: <20240119184742.31088-5-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119184742.31088-1-krisman@suse.de>
References: <20240119184742.31088-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.32)[75.74%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.58

From fscrypt perspective, once the key is available, the dentry will
remain valid until evicted for other reasons, since keyed dentries don't
require revalidation and, if the key is removed, the dentry is
forcefully evicted.  Therefore, we don't need to keep revalidating them
repeatedly.

Obviously, we can only do this if fscrypt is the only thing requiring
revalidation for a dentry.  For this reason, we only disable
d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.

It is safe to do it here because when moving the dentry to the
plain-text version, we are holding the d_lock.  We might race with a
concurrent RCU lookup but this is harmless because, at worst, we will
get an extra d_revalidate on the keyed dentry, which is will find the
dentry is valid.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v3:
  - Fix null-ptr-deref for filesystems that don't support fscrypt (ktr)
Changes since v2:
  - Do it when moving instead of when revalidating the dentry. (me)

Changes since v1:
  - Improve commit message (Eric)
  - Drop & in function comparison (Eric)
---
 include/linux/fscrypt.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 3801c5c94fb6..0ba3928f3020 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -192,6 +192,8 @@ struct fscrypt_operations {
 					     unsigned int *num_devs);
 };
 
+int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
+
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info(const struct inode *inode)
 {
@@ -230,6 +232,14 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
 	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
+
+	/*
+	 * Save the d_revalidate call cost during VFS operations.  We
+	 * can do it because, when the key is available, the dentry
+	 * can't go stale and the key won't go away without eviction.
+	 */
+	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 }
 
 /**
@@ -368,7 +378,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-- 
2.43.0


