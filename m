Return-Path: <linux-fsdevel+bounces-9446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E6841490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B451F22117
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A0158D64;
	Mon, 29 Jan 2024 20:44:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D622F0F;
	Mon, 29 Jan 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561041; cv=none; b=omK/JahonOFAByEbI/lhNbvmxFdzU3PQaU8qs68aWtSiheUWK4SqF6OulRzfWY3kcdEfq7yXG4OxcF//C7r2/JXat6wQ8K38YZEDIqQxbGe7iD6GHb5CyvJVw2jrPeHtgwlqc54gLG7GZsfjAFjonlQszEE59kI7ccMJupuRor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561041; c=relaxed/simple;
	bh=un4kre/ILHhmcznFdTkp80BZ85ebFf2UMSFeuyh9x9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNQQw3ECnSWUVrzteSPC+2tWs5kFV7b0QdJFV7cTOx8+xPdW8HKTqSbIB+QKubkgNxm4DXXnSXCAeXvoQ5bxT0jtD4p6KmynOQGlmtbxjPY2kexotJylMUMY3CJkOpnEN4VODbu6rDjrRaXhYNTcVJcBAATHcZ81iQTFPmQMTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5961B1FCFD;
	Mon, 29 Jan 2024 20:43:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B20A212FF7;
	Mon, 29 Jan 2024 20:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cq+xGA0OuGXiDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:43:57 +0000
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
Subject: [PATCH v5 06/12] fscrypt: Ignore plaintext dentries during d_move
Date: Mon, 29 Jan 2024 17:43:24 -0300
Message-ID: <20240129204330.32346-7-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129204330.32346-1-krisman@suse.de>
References: <20240129204330.32346-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5961B1FCFD
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Now that we do more than just clear the DCACHE_NOKEY_NAME in
fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
extra costs.

Note that VFS will call this function for any dentry, whether the volume
has fscrypt on not.  But, since we only care about DCACHE_NOKEY_NAME, we
can check for that, to avoid touching the superblock for other fields
that identify a fscrypt volume.

Note also that fscrypt_handle_d_move is hopefully inlined back into
__d_move, so the call cost is not significant.  Considering that
DCACHE_NOKEY_NAME is a fscrypt-specific flag, we do the check in fscrypt
code instead of the caller.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v4:
  - Check based on the dentry itself (eric)
---
 include/linux/fscrypt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c1e285053b3e..ab668760d63e 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -232,6 +232,15 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
  */
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
+	/*
+	 * VFS calls fscrypt_handle_d_move even for non-fscrypt
+	 * filesystems.  Since we only care about DCACHE_NOKEY_NAME
+	 * dentries here, check that to bail out quickly, if possible.
+	 */
+	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
+		return;
+
+	 /* Mark the dentry as a plaintext dentry. */
 	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
 
 	/*
-- 
2.43.0


