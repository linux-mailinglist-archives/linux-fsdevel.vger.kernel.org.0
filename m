Return-Path: <linux-fsdevel+bounces-11288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39585276B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC3C2820C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1AC9479;
	Tue, 13 Feb 2024 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rsrh2VJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UdpJYFW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rsrh2VJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UdpJYFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF6610E;
	Tue, 13 Feb 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790440; cv=none; b=KEbMlFA83r35I3PGr2qD6OkJ8gqCRem4tdqKCemG6wZLqNiFTXZicoqM3mMIIPr1VQeSZ7NeTMB7YD8ZBiJRE/H0l5iRg4GD+7766VdsCltDVepVF4u7fiRPONF8sLc5Vr3Cy9bknjdihT0ncUCN5V/Ba0jXeaU+Hk+McKE1khA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790440; c=relaxed/simple;
	bh=1Ao/c/JxfzxL9II9Yp4/ihYQEUaG7i9u2Xgh2Znp3r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ9NW9sYCOXbe8Nub4M0S2YRZL7L0P+LLlvD07DDmOnWRkqiERPNcGfPFxl2mPH6poEcloIIijAYMg2dsu9cCEjwTpGvx6/zIoRye+aWkBl3xRfim7qHVNW2h6lSiBIyg13GYBjPDgTtu7bjgQ/34rO6l6+nPYyoHJpeUGKjhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rsrh2VJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UdpJYFW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rsrh2VJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UdpJYFW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78E971F7A0;
	Tue, 13 Feb 2024 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=Rsrh2VJx29Ga0UNe29VajDeeb5BJPu+sCIp7TaVJbtcS3C6Jfa9eeYpvuC88gaVQU4UYng
	H2Lat5/i1aIrjRatyM3v3zIxuXA+7/PTKBm6hxmcRAF8G8zB4WGR5OWJBec6mkHGQ3CiGs
	BUdccngycvE6o5KrvzVcmNlzQI7Vvxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=8UdpJYFWgLqiQlzE5nhvo48s8dVJdo+nALXqbJ0aMcVBPCE0QJls536A/6TlvudvvH6UkS
	o2z0D8XJUMXXAOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=Rsrh2VJx29Ga0UNe29VajDeeb5BJPu+sCIp7TaVJbtcS3C6Jfa9eeYpvuC88gaVQU4UYng
	H2Lat5/i1aIrjRatyM3v3zIxuXA+7/PTKBm6hxmcRAF8G8zB4WGR5OWJBec6mkHGQ3CiGs
	BUdccngycvE6o5KrvzVcmNlzQI7Vvxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHkl1+gHuQ53whsCv6aHWAEO4kmheKoUmT6NcMFQk8=;
	b=8UdpJYFWgLqiQlzE5nhvo48s8dVJdo+nALXqbJ0aMcVBPCE0QJls536A/6TlvudvvH6UkS
	o2z0D8XJUMXXAOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E28E13A4B;
	Tue, 13 Feb 2024 02:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mzjuCGXQymUveAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:57 +0000
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
Subject: [PATCH v6 09/10] ubifs: Configure dentry operations at dentry-creation time
Date: Mon, 12 Feb 2024 21:13:20 -0500
Message-ID: <20240213021321.1804-10-krisman@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.78%]
X-Spam-Level: ****
X-Spam-Score: 4.90
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


