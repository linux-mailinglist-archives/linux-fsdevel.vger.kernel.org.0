Return-Path: <linux-fsdevel+bounces-6233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06868151CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28E31C23FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB949F67;
	Fri, 15 Dec 2023 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZSzfa7Mw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1CUvXabv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZSzfa7Mw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1CUvXabv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC67487BB;
	Fri, 15 Dec 2023 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A44BC21FFE;
	Fri, 15 Dec 2023 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=ZSzfa7MwSsHYGAFNw9ryGCh6mqYqzDsY5tqoyoISq8zKKiS/37cMsX6oZXSUvOeZ4Uf8Bx
	D9QPHlTY6ASoRnlnFfgEPAogaG4uOatZYW35nIXDRIh/QqB1T7Ryy7a5i1lSzFBU0RwFzf
	ra4SYnr8UdpqSqTXBvH9jxPt5lKU1K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=1CUvXabv3qKDYqzrcLLO7W5nC3jHZ2cTAa1j/ON69y8zhIIRu15ldmEj0thOd/wD1c94PZ
	XOoEmy8Rn75qwgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=ZSzfa7MwSsHYGAFNw9ryGCh6mqYqzDsY5tqoyoISq8zKKiS/37cMsX6oZXSUvOeZ4Uf8Bx
	D9QPHlTY6ASoRnlnFfgEPAogaG4uOatZYW35nIXDRIh/QqB1T7Ryy7a5i1lSzFBU0RwFzf
	ra4SYnr8UdpqSqTXBvH9jxPt5lKU1K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDxGCPqxcv+EGbtznoocxBQDbnIDFuyfDLE0ZhmlKns=;
	b=1CUvXabv3qKDYqzrcLLO7W5nC3jHZ2cTAa1j/ON69y8zhIIRu15ldmEj0thOd/wD1c94PZ
	XOoEmy8Rn75qwgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64304137D4;
	Fri, 15 Dec 2023 21:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mE1sESrCfGWQOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:26 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 4/8] libfs: Expose generic_ci_dentry_ops outside of libfs
Date: Fri, 15 Dec 2023 16:16:04 -0500
Message-ID: <20231215211608.6449-5-krisman@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Spamd-Bar: ++++
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.37%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZSzfa7Mw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1CUvXabv
X-Spam-Level: ****
X-Rspamd-Queue-Id: A44BC21FFE

In preparation to allow filesystems to set this through sb->s_d_op,
expose the symbol directly to the filesystems.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 2 +-
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 52c944173e57..b8ecada3a5b2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1765,7 +1765,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
-static const struct dentry_operations generic_ci_dentry_ops = {
+const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 #if defined(CONFIG_FS_ENCRYPTION)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..887a27d07f96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,7 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern const struct dentry_operations generic_ci_dentry_ops;
 
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
-- 
2.43.0


