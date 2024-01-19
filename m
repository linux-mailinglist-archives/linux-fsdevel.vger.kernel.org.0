Return-Path: <linux-fsdevel+bounces-8330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B8832F1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6392880AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A901E4A4;
	Fri, 19 Jan 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTB6iGVT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HGnckEej";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTB6iGVT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HGnckEej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598A53E05;
	Fri, 19 Jan 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690093; cv=none; b=lpwUg292l5jqN6A8nkVd6hPXooKsT7fuJd9Asf0FagL377fOiJe/uIEMoFhAjS9X43Wq5uxGnUN7cb+uai30QrpDpkTgfBRUx0HOgSXSITttBaNLTYX8vzPvbcxt475MHz6nYeQ+9MUU+RuEDQ/ZUjEtdltEynbXOk3XbD5InrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690093; c=relaxed/simple;
	bh=z5lMrV4aNPnWj0Uc01svet8vkdqUGsbiPWRzOanz2LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWAfEqMUGAGg1xUiGQTDEqPIFF6Oy7qScsONj5+iTmFu/uyt15W996azXj6g0VRXcQai0LJGlxbfbljuGCFArGSMK1PMapWb6+76pJkUsFjgxiPyItGFogiqnImm361Z0vSTKKRtxs96bMDtABClpgg3Ly/2yUh6zdRa/ObRibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTB6iGVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HGnckEej; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTB6iGVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HGnckEej; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4906E21FBA;
	Fri, 19 Jan 2024 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=yTB6iGVTtAKVjDSux6UHrYx7magPfOqOABjcRFOfaeg8vufI6w78rY/hln+hc2MC2rCuOS
	DxWrsuM9DgodEomoAlYTPJa5DWTD9VRKXxpZQigbwuXdBN/9wGBKSFMQ8CrOENp+Qi3mX1
	ZQRKfk3E1bFD7NkTucPf+2R6GadPC6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=HGnckEejwWeYgmdjAfxABzuiLKczXOtzBsUcs6lQqJevyNXkrSH1IJyBwALuqI+ddCWMoM
	6A/wGdv4EKaADjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=yTB6iGVTtAKVjDSux6UHrYx7magPfOqOABjcRFOfaeg8vufI6w78rY/hln+hc2MC2rCuOS
	DxWrsuM9DgodEomoAlYTPJa5DWTD9VRKXxpZQigbwuXdBN/9wGBKSFMQ8CrOENp+Qi3mX1
	ZQRKfk3E1bFD7NkTucPf+2R6GadPC6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
	b=HGnckEejwWeYgmdjAfxABzuiLKczXOtzBsUcs6lQqJevyNXkrSH1IJyBwALuqI+ddCWMoM
	6A/wGdv4EKaADjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD995136F5;
	Fri, 19 Jan 2024 18:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gP1SHOXDqmVEDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:05 +0000
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
Subject: [PATCH v3 03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
Date: Fri, 19 Jan 2024 15:47:35 -0300
Message-ID: <20240119184742.31088-4-krisman@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.18 / 50.00];
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
	 BAYES_HAM(-1.08)[88.02%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.18

Unencrypted and encrypted-dentries where the key is available don't need
to be revalidated with regards to fscrypt, since they don't go stale
from under VFS and the key cannot be removed for the encrypted case
without evicting the dentry.  Mark them with d_set_always_valid, to
avoid unnecessary revalidation, in preparation to always configuring
d_op through sb->s_d_op.

Since the filesystem might have other features that require
revalidation, only apply this optimization if the d_revalidate handler
is fscrypt_d_revalidate itself.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/crypto/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 41df986d1230..53381acc83e7 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -127,6 +127,15 @@ int fscrypt_prepare_lookup_dentry(struct inode *dir,
 	spin_lock(&dentry->d_lock);
 	if (nokey_name) {
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
+	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
+		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
+		/*
+		 * Unencrypted dentries and encrypted dentries where the
+		 * key is available are always valid from fscrypt
+		 * perspective. Avoid the cost of calling
+		 * fscrypt_d_revalidate unnecessarily.
+		 */
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 	}
 	spin_unlock(&dentry->d_lock);
 
-- 
2.43.0


