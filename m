Return-Path: <linux-fsdevel+bounces-9147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46E83E80E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0D71F22C7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CE612E;
	Sat, 27 Jan 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s7cKuHyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIdwbnv9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s7cKuHyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIdwbnv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E626FD2;
	Sat, 27 Jan 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314256; cv=none; b=kK9Nqv0/CU8CK9/NODURBBNWi/vyIdtEwwULtZlpSOVeD7IAJkw4gIaaMrFIo3RnqfGPn8rjO1b3TjFZWG8Zw657pLemFqRdzqpLavBig6f2hQz2a4TWw8V8Om4hiCxY+Cewcf10BENk0WgESDRFH/wGrG+OWU16BEz4Sh9riLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314256; c=relaxed/simple;
	bh=SyI2wLhlC/SY13QjjJmfT+fhtHMRlxjaM0zdsPjwQH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAuieM28YC8XHcLrpefpu2QPuEm2PMn1uJbhqIuNHFMOBgIHq8q4l181jL05nL5JeOTYELHh4Umrxlge1805y0l4DD+c9+1sj/x6Cl6M8mMVgiD/3Mk5X+YCENoZvbqWeCWJwKfRRcWc/ioQTNP80uIWo1UPqD2NhVkb71sXydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s7cKuHyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIdwbnv9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s7cKuHyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIdwbnv9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37BBA2214A;
	Sat, 27 Jan 2024 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=s7cKuHygqyE9yfCRe+LTUyAI/SuU30COqK7Pv1yQ3kYSwb0yXIkwAXXUqHBJZugSpyIp0H
	JnDrPyOF9C6IoxuLyLm2HTYI4qc72G2BdMAxOwDDJHJUXlZ6Sb6QP3sWBhhU5soRVlguzJ
	yY6Cc7W38nZNqcVjE+gDdXvM2KQmOLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=AIdwbnv9OJbSjYPR65RW+ftI2yUqq3M7/nYWMv7XaU9oeLeLtZcXhwHQKqeZiwU3zJqrsy
	SH1QNqVZkuk9QBAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=s7cKuHygqyE9yfCRe+LTUyAI/SuU30COqK7Pv1yQ3kYSwb0yXIkwAXXUqHBJZugSpyIp0H
	JnDrPyOF9C6IoxuLyLm2HTYI4qc72G2BdMAxOwDDJHJUXlZ6Sb6QP3sWBhhU5soRVlguzJ
	yY6Cc7W38nZNqcVjE+gDdXvM2KQmOLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAXxsZUzQs43nPmCR7QF70NpWme+IPIt3kqL7m9PrBY=;
	b=AIdwbnv9OJbSjYPR65RW+ftI2yUqq3M7/nYWMv7XaU9oeLeLtZcXhwHQKqeZiwU3zJqrsy
	SH1QNqVZkuk9QBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93BCF13998;
	Sat, 27 Jan 2024 00:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5w7IEAxKtGV/EQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:52 +0000
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
Subject: [PATCH v4 09/12] ext4: Configure dentry operations at dentry-creation time
Date: Fri, 26 Jan 2024 21:10:09 -0300
Message-ID: <20240127001013.2845-10-krisman@suse.de>
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
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLzk7q5dcbbphp39zi8hi5jhbt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
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


