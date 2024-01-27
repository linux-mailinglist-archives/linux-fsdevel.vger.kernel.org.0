Return-Path: <linux-fsdevel+bounces-9149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B057283E812
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ABC1F22D6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCF97481;
	Sat, 27 Jan 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rUco1wkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GVxuysbt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rUco1wkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GVxuysbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39328C0C;
	Sat, 27 Jan 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314264; cv=none; b=RdyhXWKWMKvoz59ZHl9xEbd0DhJXN3gkdm834EM0tFtqX291XwN5PPFn7w01yZ1yJLT8e14sV2TMX8DyPPabz0txYMJBXrnraXOm3aPpqUMRY1i84pYLiZgjIaSRUsOvsnM6GVpTUixpO/0/7JWCn4f5N50kWlzNf5/+gv9SYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314264; c=relaxed/simple;
	bh=1Ao/c/JxfzxL9II9Yp4/ihYQEUaG7i9u2Xgh2Znp3r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoepLqqw01KQ6yjZv1C2Q9ny7BGMnSM3ahyRXI/tjL5S7nfOEAd0x9nPNTu6OEtxJDhkHLqZCOc2FISuF0SFo9YR8EXE1dS2qpx7YEvvahHXARRdV16O4nVDEpKW1TOBKO+2xU8Bn23CtMokDeCLYXOvbmpemDm/UjyCXMPvVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rUco1wkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GVxuysbt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rUco1wkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GVxuysbt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3EC5223A6;
	Sat, 27 Jan 2024 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=rUco1wkmJdL6RcqVP2pN2DT0mbj9rej6Bg90Q4RmrD21jBjqSm4oi7hs2aZ0k6lpkEbLku
	11Ejddv4+oD9nPYXJ2YaycHrTDGU1g3Y6d0iSJ7QySnzFG5JXMghELKZjGPJQRR6vxT8iP
	qhb/TPwMS4FZYox6E2D7RsIluqrrd44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=GVxuysbt1zhzuKUTPhZyq0XwEAxw/D/7mveNnduI03axx+G7/p98c1VWrtRYTqPDCLIYbI
	/F2PZdqA6eUUCaBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=rUco1wkmJdL6RcqVP2pN2DT0mbj9rej6Bg90Q4RmrD21jBjqSm4oi7hs2aZ0k6lpkEbLku
	11Ejddv4+oD9nPYXJ2YaycHrTDGU1g3Y6d0iSJ7QySnzFG5JXMghELKZjGPJQRR6vxT8iP
	qhb/TPwMS4FZYox6E2D7RsIluqrrd44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=GVxuysbt1zhzuKUTPhZyq0XwEAxw/D/7mveNnduI03axx+G7/p98c1VWrtRYTqPDCLIYbI
	/F2PZdqA6eUUCaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ACD013998;
	Sat, 27 Jan 2024 00:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ad0FBRRKtGWNEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:11:00 +0000
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
Subject: [PATCH v4 11/12] ubifs: Configure dentry operations at dentry-creation time
Date: Fri, 26 Jan 2024 21:10:11 -0300
Message-ID: <20240127001013.2845-12-krisman@suse.de>
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
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLzk7q5dcbbphp39zi8hi5jhbt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.70%]
X-Spam-Flag: NO

fscrypt now supports configuring dentry operations at dentry-creation
time through the preset sb->s_d_op, instead of at lookup time.
Enable this in ubifs, since the lookup-time mechanism is going away.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/ubifs/dir.c   | 1 -
 fs/ubifs/super.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 3b13c648d490..51b9a10a9851 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -205,7 +205,6 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
 
 	err = fscrypt_prepare_lookup(dir, dentry, &nm);
-	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return d_splice_alias(NULL, dentry);
 	if (err)
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 09e270d6ed02..304646b03e99 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2239,6 +2239,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 
+	generic_set_sb_d_ops(sb);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		err = -ENOMEM;
-- 
2.43.0


