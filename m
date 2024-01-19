Return-Path: <linux-fsdevel+bounces-8334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1267832F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F348B24D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21D56B86;
	Fri, 19 Jan 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JYMOM1me";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bgQpMhXL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JYMOM1me";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bgQpMhXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F31E4A4;
	Fri, 19 Jan 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690113; cv=none; b=QJsr86R2yzPboLktShQbDLckR7BhaYfrX0GGlNS4M/SzVaQAgLa5kphruijMiD0Ik1yUge0itKJNuF0ktgYtZOYVzEQG8J8usSsXpYfsSqTotXnPgKg8VGWVJpLE9nQWvi2giY420XZMA7Or0PF9TPqG+ZjnxUATCML7PwHenMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690113; c=relaxed/simple;
	bh=SyI2wLhlC/SY13QjjJmfT+fhtHMRlxjaM0zdsPjwQH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLnHqIAGU4fUhtNtsastK1KkCmY6+Zc48cOyIHkwKyFLOuxsrWxs+95fMPcCzyRZt0Ot0Adq3XdcikGqe0nSaSGhtwa6RoFcNmRUys/KYObZuMIgz50dhQCJ8744XTARdb8/UH1qXpRtUlae28d3GWqUziSzO/Ko3380W4OCkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JYMOM1me; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bgQpMhXL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JYMOM1me; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bgQpMhXL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B76E81F809;
	Fri, 19 Jan 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=JYMOM1meZr7Mi6ZSnnbOP228XrfLLJx3ZkYcMwVzTA/PMT3sL0HPcfK1GikWkhCi8DXGcp
	VK8caVmJzYvkkvsguBtZKKdEIlwmENNZwNJdvEwkQ8vbqLxo98R3KFvPAecI+GzdTmZSg0
	rBGGR0heKvVI/6GKZQYEPeqF9pTySNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=bgQpMhXLHiXed8QoiOc+YQaSuLjG/18LuGi2jYzZdzsK6X2CFRGnnPuIwTTgARlKZvt+nk
	BZjBHH1f8ggFIkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=JYMOM1meZr7Mi6ZSnnbOP228XrfLLJx3ZkYcMwVzTA/PMT3sL0HPcfK1GikWkhCi8DXGcp
	VK8caVmJzYvkkvsguBtZKKdEIlwmENNZwNJdvEwkQ8vbqLxo98R3KFvPAecI+GzdTmZSg0
	rBGGR0heKvVI/6GKZQYEPeqF9pTySNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=bgQpMhXLHiXed8QoiOc+YQaSuLjG/18LuGi2jYzZdzsK6X2CFRGnnPuIwTTgARlKZvt+nk
	BZjBHH1f8ggFIkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CB09136F5;
	Fri, 19 Jan 2024 18:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqpxMPzDqmVkDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:28 +0000
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
Subject: [PATCH v3 07/10] ext4: Configure dentry operations at dentry-creation time
Date: Fri, 19 Jan 2024 15:47:39 -0300
Message-ID: <20240119184742.31088-8-krisman@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
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
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

This was already the case for case-insensitive before commit
bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops"), but it
was changed to set at lookup-time to facilitate the integration with
fscrypt.  But it's a problem because dentries that don't get created
through ->lookup() won't have any visibility of the operations.

Since fscrypt now also supports configuring dentry operations at
creation-time, do it for any encrypted and/or casefold volume,
simplifying the implementation across these features.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/ext4/namei.c | 1 -
 fs/ext4/super.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..3f0b853a371e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,7 +1762,6 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..de80a9cc699a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5493,6 +5493,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount4;
 	}
 
+	generic_set_sb_d_ops(sb);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		ext4_msg(sb, KERN_ERR, "get root dentry failed");
-- 
2.43.0


