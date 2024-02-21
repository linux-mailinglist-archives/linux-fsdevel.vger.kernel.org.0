Return-Path: <linux-fsdevel+bounces-12294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D385E446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540221C222AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CD85267;
	Wed, 21 Feb 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tmb2j3Cr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SowLOEs9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tmb2j3Cr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SowLOEs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618883CA3;
	Wed, 21 Feb 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535694; cv=none; b=TsaCmPcJW8jba30wT23C4ZDNID4KBt3ymjHYVYpURoZ0Y6fTq2cZswvgtE7WN8znPZGVkczrT0dm6uPpeDeFj6XGqdAhaOSb0ZWvmNpwVDJCqKtfqO+wyFM6N99gpaidSh9cBbySJJs3z6TE1uP+0c1Mw6Dal6f7Me9CXhWn8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535694; c=relaxed/simple;
	bh=KOnqlMNszEIlSwX+P2d5aY5eD+NpqDq/T3vISrCyP7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQMAjrkO+3kPtsTWn8pT9ZggGC3tE+BsGaZ8NAZi7iiANoLKubEWnKwCpGJ7BJk4X4EErDY5/VgKAe2ZTC9P07GY6PurANLFgJuTsvbzbPnIiGmJmufWeelvzpo7c888m2JIGgJ1j+Bqsle9Pv754oIfoPEBhDpFcLBGXYMDFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tmb2j3Cr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SowLOEs9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tmb2j3Cr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SowLOEs9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E8A81FB6F;
	Wed, 21 Feb 2024 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdpLcH0KspyYreOUudTmM94kWGbFgdXTKIvo+uwB7A=;
	b=Tmb2j3CrKWdzN0T0/mMxFyBJ5fYbpLOasb79TbV0cTfMXl8C8p6BjVzZL0ml2zXRPSAKXs
	0u69SKnROP4zkmU76uTAUK9xvEKrZo/OwMP24y4yT8RqdTyYWQWNWh2kcWqAEutYib/I1o
	Qf5l4gzVyJuklE/BP4GV13n4cZWjzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdpLcH0KspyYreOUudTmM94kWGbFgdXTKIvo+uwB7A=;
	b=SowLOEs9pFyqp1zEY50XpvdyYmx3ficUTCb2Es9N5Fp3YelpoWV4LiTjSFBuDJokjeFI99
	OgpAVY7Xs2vTdzAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdpLcH0KspyYreOUudTmM94kWGbFgdXTKIvo+uwB7A=;
	b=Tmb2j3CrKWdzN0T0/mMxFyBJ5fYbpLOasb79TbV0cTfMXl8C8p6BjVzZL0ml2zXRPSAKXs
	0u69SKnROP4zkmU76uTAUK9xvEKrZo/OwMP24y4yT8RqdTyYWQWNWh2kcWqAEutYib/I1o
	Qf5l4gzVyJuklE/BP4GV13n4cZWjzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdpLcH0KspyYreOUudTmM94kWGbFgdXTKIvo+uwB7A=;
	b=SowLOEs9pFyqp1zEY50XpvdyYmx3ficUTCb2Es9N5Fp3YelpoWV4LiTjSFBuDJokjeFI99
	OgpAVY7Xs2vTdzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA41D139D0;
	Wed, 21 Feb 2024 17:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+tMK4ov1mV/KgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:50 +0000
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
Subject: [PATCH v7 10/10] libfs: Drop generic_set_encrypted_ci_d_ops
Date: Wed, 21 Feb 2024 12:14:12 -0500
Message-ID: <20240221171412.10710-11-krisman@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLzk7q5dcbbphp39zi8hi5jhbt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,kernel.org,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.96%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

No filesystems depend on it anymore, and it is generally a bad idea.
Since all dentries should have the same set of dentry operations in
case-insensitive capable filesystems, it should be propagated through
->s_d_op.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 34 ----------------------------------
 include/linux/fs.h |  1 -
 2 files changed, 35 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0aa388ee82ff..35124987f162 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1788,40 +1788,6 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 };
 #endif
 
-/**
- * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
- * @dentry:	dentry to set ops on
- *
- * Casefolded directories need d_hash and d_compare set, so that the dentries
- * contained in them are handled case-insensitively.  Note that these operations
- * are needed on the parent directory rather than on the dentries in it, and
- * while the casefolding flag can be toggled on and off on an empty directory,
- * dentry_operations can't be changed later.  As a result, if the filesystem has
- * casefolding support enabled at all, we have to give all dentries the
- * casefolding operations even if their inode doesn't have the casefolding flag
- * currently (and thus the casefolding ops would be no-ops for now).
- *
- * Encryption works differently in that the only dentry operation it needs is
- * d_revalidate, which it only needs on dentries that have the no-key name flag.
- * The no-key flag can't be set "later", so we don't have to worry about that.
- */
-void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
-{
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (dentry->d_sb->s_encoding) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
-#ifdef CONFIG_FS_ENCRYPTION
-	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
-		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
-		return;
-	}
-#endif
-}
-EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
-
 /**
  * generic_set_sb_d_ops - helper for choosing the set of
  * filesystem-wide dentry operations for the enabled features
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c985d9392b61..c0cfc53f95bb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3201,7 +3201,6 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
-extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 extern void generic_set_sb_d_ops(struct super_block *sb);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
-- 
2.43.0


