Return-Path: <linux-fsdevel+bounces-11286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A3852767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C6280E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BB8BE8;
	Tue, 13 Feb 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hVuMOjbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tPjQit1Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hVuMOjbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tPjQit1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEEF79DF;
	Tue, 13 Feb 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790437; cv=none; b=op8xGS241HrE5eMbglVj9GmWzJuK/qXzFnk5GhZhgYB8O+zUahmhTxghIu2X0TJv4f0cqaHelsnC0DmennuJAIufnwdFrtFzKgPcaWEPD+px2Oi6zvRHf6aDmkB5eOXqJlIc0ZiBUrc0VhAkLzrqGuw55pn3iagrTMDN5h/SdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790437; c=relaxed/simple;
	bh=YSq2jkFW7hjiLtpR74KFKwNmniOT+cj5vvdZvcq/S0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2MZTC8Ae8mDpUwz/qEWnymzEH3oXJHwQu764AK56szNM/UGXFWagYuOY89go0ok0gBdKVNeOnVlueNvVQ6EJUGjQ22CAEzZCMfxDu5FIdWKfC2W0W1ZLGu2dvOKbzKaZ1eC9bBdwT3vgOWxRFWs54Z3qalvx+38Bs+n5Z03eFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hVuMOjbE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tPjQit1Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hVuMOjbE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tPjQit1Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B28321D85;
	Tue, 13 Feb 2024 02:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi5jtsblHY1BOgkoB3I3CrylBb57gl+1FT3PsX85sGM=;
	b=hVuMOjbEPjAKxO+eRdFT0k4FmFsY97JekKQX6tPSkfGoKcdIVjpZtbeMBxsNTROlzge+LC
	CZ1OeOI6c8HSgQAdCyUEsIIR2Gn+scexYaSSnDE8Rv37dyNQDoQBAEyaYqBCsX3aaWbkHA
	RPGhQnqoSJFsO0SCxplcbeO8kwn6gSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi5jtsblHY1BOgkoB3I3CrylBb57gl+1FT3PsX85sGM=;
	b=tPjQit1ZCC4CLiuqICPID+Z0SOAlg/CvCj7Quy0i4TpcH+sYWdy4at33oIE73ewdTd21Sk
	lmN9y46o6suEVzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi5jtsblHY1BOgkoB3I3CrylBb57gl+1FT3PsX85sGM=;
	b=hVuMOjbEPjAKxO+eRdFT0k4FmFsY97JekKQX6tPSkfGoKcdIVjpZtbeMBxsNTROlzge+LC
	CZ1OeOI6c8HSgQAdCyUEsIIR2Gn+scexYaSSnDE8Rv37dyNQDoQBAEyaYqBCsX3aaWbkHA
	RPGhQnqoSJFsO0SCxplcbeO8kwn6gSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi5jtsblHY1BOgkoB3I3CrylBb57gl+1FT3PsX85sGM=;
	b=tPjQit1ZCC4CLiuqICPID+Z0SOAlg/CvCj7Quy0i4TpcH+sYWdy4at33oIE73ewdTd21Sk
	lmN9y46o6suEVzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2383213A4B;
	Tue, 13 Feb 2024 02:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WG+2AmLQymUneAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:54 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jaegeuk@kernel.org,
	tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v6 07/10] ext4: Configure dentry operations at dentry-creation time
Date: Mon, 12 Feb 2024 21:13:18 -0500
Message-ID: <20240213021321.1804-8-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213021321.1804-1-krisman@suse.de>
References: <20240213021321.1804-1-krisman@suse.de>
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.43%]
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
Acked-by: Theodore Ts'o <tytso@mit.edu>
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


