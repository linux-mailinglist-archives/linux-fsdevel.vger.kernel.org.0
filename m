Return-Path: <linux-fsdevel+bounces-37908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27D9F8A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F3F7A4103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28671A0B06;
	Fri, 20 Dec 2024 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yA+GRp9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="js7R4aye";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CbOmiBOt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BUgjUNhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED986326;
	Fri, 20 Dec 2024 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664184; cv=none; b=L7jw1R/cIeGasWBK0+17+ZZ1GXhnBmrBC9hQKrZJvFtjxk4X6pEfDEXzn2DXJpH1tw8CnSqE1Ct7QJMNrOw2IIBWzSBKbaXfeqhyngUlVPixMPxshTgpJWghyD52WtvvGGA8jDK0ltzzwnHzldhY/LQ6T8iNuEdXXdxIJ4syD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664184; c=relaxed/simple;
	bh=XUTEW85MMCiBnH/6G9YoXhQSf291hhsZaXmHVuR03DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ0Ec51zeNKWeEoQEchodVj3VN6cTIo1H0lLZUmrzwGCPmFqjfbZkPoncKBGbHn586Mg/WlPew4/MgQwHlEEPi3xm9udS7cxYa4LH18EcdOgM8Gf8d++1XqYBxWGqBVw4ypNo8NscrKW5tKCDFf5mxe/nj7gdesaxDSwe3w4Q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yA+GRp9w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=js7R4aye; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbOmiBOt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BUgjUNhk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB61321169;
	Fri, 20 Dec 2024 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVS4U6AEBMfCBjKPIhLdoeJu6UO4uozxamU759WDpMc=;
	b=yA+GRp9wU4YpC/nYWKAjIGqHqpOv5iOyht7A2lBZzLWELcwaJplcG6vSWmy8JR/xnxxJ3r
	gLXSj2daZtIl9e6OV3ITaQorccU8fdzSjeCGirzl8kNYdxn72wsc8+4HndxecAAlW2UG77
	aeW2Ln8s2O5FgxNcKruagB6LBitmrDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVS4U6AEBMfCBjKPIhLdoeJu6UO4uozxamU759WDpMc=;
	b=js7R4ayefaD9mtxUAJz5ppdSjtEmF9jef0S/WjyRbpna5QfHfksCu8vlFz+zmSo7Ls9cz6
	4g8RQoEKXxSXinAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CbOmiBOt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BUgjUNhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVS4U6AEBMfCBjKPIhLdoeJu6UO4uozxamU759WDpMc=;
	b=CbOmiBOt66l1hB3XoI8x9HySJWfji3ZjbeqVnuY/F/nectB0V5NALdg59kft/Dv091At6K
	M2B9P++GnMfdIDZS8VeKkkpClOrPZ7vxBISFaPih1an0R2EdFjKjYImj5q0Q0ML3yoevb/
	TJAIRQ5snYx+w8iDXBNXx/1gaFQwgWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVS4U6AEBMfCBjKPIhLdoeJu6UO4uozxamU759WDpMc=;
	b=BUgjUNhkaC8ov/Gx4/xfsD8T/lPWL9paRxobCqmJuh7I0VFFVYTvEsNVRgllZuGxmZ4gzs
	wmfE3It3SbyrdYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D493313A32;
	Fri, 20 Dec 2024 03:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzpGIvLfZGeAGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:38 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] VFS: re-pack DENTRY_ flags.
Date: Fri, 20 Dec 2024 13:54:27 +1100
Message-ID: <20241220030830.272429-10-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB61321169
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Bits 13, 23, 24, and 27 are not used.  Move all those holes to the end.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/dcache.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b64c0260e4be..fc7f571bd5bb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -191,34 +191,34 @@ struct dentry_operations {
 #define DCACHE_NFSFS_RENAMED		BIT(12)
      /* this dentry has been "silly renamed" and has to be deleted on the last
       * dput() */
-#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(14)
+#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(13)
      /* Parent inode is watched by some fsnotify listener */
 
-#define DCACHE_DENTRY_KILLED		BIT(15)
+#define DCACHE_DENTRY_KILLED		BIT(14)
 
-#define DCACHE_MOUNTED			BIT(16) /* is a mountpoint */
-#define DCACHE_NEED_AUTOMOUNT		BIT(17) /* handle automount on this dir */
-#define DCACHE_MANAGE_TRANSIT		BIT(18) /* manage transit from this dirent */
+#define DCACHE_MOUNTED			BIT(15) /* is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT		BIT(16) /* handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT		BIT(17) /* manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
-#define DCACHE_LRU_LIST			BIT(19)
+#define DCACHE_LRU_LIST			BIT(18)
 
-#define DCACHE_ENTRY_TYPE		(7 << 20) /* bits 20..22 are for storing type: */
-#define DCACHE_MISS_TYPE		(0 << 20) /* Negative dentry */
-#define DCACHE_WHITEOUT_TYPE		(1 << 20) /* Whiteout dentry (stop pathwalk) */
-#define DCACHE_DIRECTORY_TYPE		(2 << 20) /* Normal directory */
-#define DCACHE_AUTODIR_TYPE		(3 << 20) /* Lookupless directory (presumed automount) */
-#define DCACHE_REGULAR_TYPE		(4 << 20) /* Regular file type */
-#define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type */
-#define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink */
+#define DCACHE_ENTRY_TYPE		(7 << 19) /* bits 19..21 are for storing type: */
+#define DCACHE_MISS_TYPE		(0 << 19) /* Negative dentry */
+#define DCACHE_WHITEOUT_TYPE		(1 << 19) /* Whiteout dentry (stop pathwalk) */
+#define DCACHE_DIRECTORY_TYPE		(2 << 19) /* Normal directory */
+#define DCACHE_AUTODIR_TYPE		(3 << 19) /* Lookupless directory (presumed automount) */
+#define DCACHE_REGULAR_TYPE		(4 << 19) /* Regular file type */
+#define DCACHE_SPECIAL_TYPE		(5 << 19) /* Other file type */
+#define DCACHE_SYMLINK_TYPE		(6 << 19) /* Symlink */
 
-#define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
-#define DCACHE_OP_REAL			BIT(26)
+#define DCACHE_NOKEY_NAME		BIT(22) /* Encrypted name encoded without key */
+#define DCACHE_OP_REAL			BIT(23)
 
-#define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
-#define DCACHE_DENTRY_CURSOR		BIT(29)
-#define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
+#define DCACHE_PAR_LOOKUP		BIT(24) /* being looked up (with parent locked shared) */
+#define DCACHE_DENTRY_CURSOR		BIT(25)
+#define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
 
 extern seqlock_t rename_lock;
 
-- 
2.47.0


