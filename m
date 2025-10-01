Return-Path: <linux-fsdevel+bounces-63191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4EBB0E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA42A705A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163AA3064B3;
	Wed,  1 Oct 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="diHL6oPb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDQNsuCV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="diHL6oPb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sDQNsuCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1D2ECD3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330370; cv=none; b=LgtqdH7BrZeom6xyh9mtsbESpcZ2BA858SZdH+zHu2gFO/bQAG4blTx7KpMOEXSrV3W3liBXF1uJNRNL74suSYl40Ig1bKO5ihdC8+c/IK+skpJi+ICkEMzqSFT58BclZRV793d/xUWhynARE+d8sZY9LEHRZYFY5NdwgJvKy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330370; c=relaxed/simple;
	bh=wXFCqqwCYGN+EwzSJcVvwIH8W93MhhrS6eKmpnIaf/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qnqcpbb632t3ZNs1V0sBSvqGQFYUSlX9RCIXK8t15sGb0NxJi3mSyf1akUz484oOy6wviQrMcAzJXqVF6ccPkkClpvJ6gBXS0nt6IiS5oeAKA/2bJ9cSmJ/6g9APXpmrApwTUes9QuO6bjKJ7ptKu0PGJFn82vIi5bp5g73zDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=diHL6oPb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDQNsuCV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=diHL6oPb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sDQNsuCV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FA0A337E0;
	Wed,  1 Oct 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759330363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C5kGo4uRbKTwuqSFG7yfFxGGPt9cgrg8HiylW4SEusY=;
	b=diHL6oPbyinBl0gYt6Q1jw1C2SHs5AWC/eFvEVQnXshCniOj8M0nOKaT2QxqX540Ids57l
	TP331AhU6FBvyHGH9zB574dsPNjS7zPsn6iIPF9Um9An7NodcnOca+HSmG6NPfV1ffmsTl
	7SOJOkp8mj6hz7+SJ5IaxyMVVrl28as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759330363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C5kGo4uRbKTwuqSFG7yfFxGGPt9cgrg8HiylW4SEusY=;
	b=sDQNsuCVwrmZIYThlUk/4TOgG0Re3bGT9RWR7YwCz9xGJpGNJplcaHTnG9g1+H6hnhdprT
	g4Nb9u5pr2tFlNCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=diHL6oPb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sDQNsuCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759330363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C5kGo4uRbKTwuqSFG7yfFxGGPt9cgrg8HiylW4SEusY=;
	b=diHL6oPbyinBl0gYt6Q1jw1C2SHs5AWC/eFvEVQnXshCniOj8M0nOKaT2QxqX540Ids57l
	TP331AhU6FBvyHGH9zB574dsPNjS7zPsn6iIPF9Um9An7NodcnOca+HSmG6NPfV1ffmsTl
	7SOJOkp8mj6hz7+SJ5IaxyMVVrl28as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759330363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C5kGo4uRbKTwuqSFG7yfFxGGPt9cgrg8HiylW4SEusY=;
	b=sDQNsuCVwrmZIYThlUk/4TOgG0Re3bGT9RWR7YwCz9xGJpGNJplcaHTnG9g1+H6hnhdprT
	g4Nb9u5pr2tFlNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 855F513A42;
	Wed,  1 Oct 2025 14:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ji6NIDtA3Wg2LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 14:52:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D1D7A094F; Wed,  1 Oct 2025 16:52:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID
Date: Wed,  1 Oct 2025 16:52:19 +0200
Message-ID: <20251001145218.24219-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=jack@suse.cz; h=from:subject; bh=wXFCqqwCYGN+EwzSJcVvwIH8W93MhhrS6eKmpnIaf/0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo3UAjUQwYiMPr6EHA3sWIjwaeBDtUc7gzklQhF ebPBAgm7F+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaN1AIwAKCRCcnaoHP2RA 2fb/B/9Ho7lmb5a2YfClzCNBD8+1Fo/ue/FwM8A4kQtVDaPcfGsDquCfgLAuwRHRJPNFq/j4NLN fYXMdL/zFpo4YH/V/JSu6D6Exg3EuhPkmcPiguItW/GxCgoWYnw5mYYQW0moz2EiVk/2zA1pcZK khbMabR5otaz9FNDETSXM4/0Aur9wvpB2xAvnrUucE7EhPB86WjikS89NjUmWQh9Q8ckLiQqpPi MkiIFDMk4G+xPW/dEmPSNUhJ79DtluVWi1fGVjJNBTJUUli4GNdfsKr6QhPML/+tZqqNx2CpL8+ BV6eDmTg2v0wQpWLu4MTdC0Q35LncFDq412ZkdSFO9fSFzUe
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8FA0A337E0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

After commit 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode
connectable file handles") we will fail to create non-decodable file
handles for filesystems without export operations. Fix it.

Fixes: 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable file handles")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/exportfs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cfb0dd1ea49c..b80286a73d0a 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -314,9 +314,6 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-	if (!nop)
-		return false;
-
 	/*
 	 * If a non-decodeable file handle was requested, we only need to make
 	 * sure that filesystem did not opt-out of encoding fid.
@@ -324,6 +321,10 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 	if (fh_flags & EXPORT_FH_FID)
 		return exportfs_can_encode_fid(nop);
 
+	/* Normal file handles cannot be created without export ops */
+	if (!nop)
+		return false;
+
 	/*
 	 * If a connectable file handle was requested, we need to make sure that
 	 * filesystem can also decode connected file handles.
-- 
2.51.0


