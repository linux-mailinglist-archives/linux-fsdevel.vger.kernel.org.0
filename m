Return-Path: <linux-fsdevel+bounces-6236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F18151D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B461286E73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244947F76;
	Fri, 15 Dec 2023 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mnpwUyDq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1/g+stk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mnpwUyDq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1/g+stk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38349F7E;
	Fri, 15 Dec 2023 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E13C22002;
	Fri, 15 Dec 2023 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Nii7VhaRES/V/l6FUEUsiUl+Zlzav4SYIkwy9riFEY=;
	b=mnpwUyDq76hOsZvLQXEF4yxHpbTP7eTkOzpHs9mxDwH+zZhcUlPkSWZRPT5a95brEd99T8
	j/6Y0exh8cLA2EtK0qcuxfTAi26akVsKUhyLLTs3NM8y32z9mcua+HWJAv08cY4ni4LpDK
	hDUkPsRAZrzf96jARsrzZDGxl+dG91w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Nii7VhaRES/V/l6FUEUsiUl+Zlzav4SYIkwy9riFEY=;
	b=s1/g+stkWnkL1ArIQbPkv0fnwQCqX4mGD4MBn9R798AhDjXP7VveV0jVwRHBMxwvu7YV5T
	sxgCzBI7unrs7gBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Nii7VhaRES/V/l6FUEUsiUl+Zlzav4SYIkwy9riFEY=;
	b=mnpwUyDq76hOsZvLQXEF4yxHpbTP7eTkOzpHs9mxDwH+zZhcUlPkSWZRPT5a95brEd99T8
	j/6Y0exh8cLA2EtK0qcuxfTAi26akVsKUhyLLTs3NM8y32z9mcua+HWJAv08cY4ni4LpDK
	hDUkPsRAZrzf96jARsrzZDGxl+dG91w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Nii7VhaRES/V/l6FUEUsiUl+Zlzav4SYIkwy9riFEY=;
	b=s1/g+stkWnkL1ArIQbPkv0fnwQCqX4mGD4MBn9R798AhDjXP7VveV0jVwRHBMxwvu7YV5T
	sxgCzBI7unrs7gBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3A20137D4;
	Fri, 15 Dec 2023 21:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yrRiJC/CfGWgOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:31 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 7/8] libfs: Don't support setting casefold operations during lookup
Date: Fri, 15 Dec 2023 16:16:07 -0500
Message-ID: <20231215211608.6449-8-krisman@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.58%]
X-Spam-Flag: NO

No filesystems depend on it anymore, and it is generally a bad idea.
Since all dentries should have the same set of dentry operations in
case-insensitive filesystems, it should be configured through ->s_d_op.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index b8ecada3a5b2..41c02c003265 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1784,27 +1784,12 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
  * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
  * @dentry:	dentry to set ops on
  *
- * Casefolded directories need d_hash and d_compare set, so that the dentries
- * contained in them are handled case-insensitively.  Note that these operations
- * are needed on the parent directory rather than on the dentries in it, and
- * while the casefolding flag can be toggled on and off on an empty directory,
- * dentry_operations can't be changed later.  As a result, if the filesystem has
- * casefolding support enabled at all, we have to give all dentries the
- * casefolding operations even if their inode doesn't have the casefolding flag
- * currently (and thus the casefolding ops would be no-ops for now).
- *
  * Encryption works differently in that the only dentry operation it needs is
  * d_revalidate, which it only needs on dentries that have the no-key name flag.
  * The no-key flag can't be set "later", so we don't have to worry about that.
  */
 void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (dentry->d_sb->s_encoding) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
 #ifdef CONFIG_FS_ENCRYPTION
 	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
 		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
-- 
2.43.0


