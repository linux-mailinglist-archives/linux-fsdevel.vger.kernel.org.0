Return-Path: <linux-fsdevel+bounces-43043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A383A4D382
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9338E17336A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF031F4CA7;
	Tue,  4 Mar 2025 06:11:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565B16F0CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068673; cv=none; b=TMcJwxJ2yk2DW9yOBH6LOm8S11BcS/ArGKf/iEbrtvARYLgvOjLaN1LOXIgJogdnKTkWJ39HFwNM+4XOoidY23GHrFzBy08oi13b9Nh9kPd/oSov1uF5aInm49Y70zLLcHhiKO9kcLE2WKNxU6013XGMQvjan3x55m+FOULgMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068673; c=relaxed/simple;
	bh=Z2XdDkakfcn0EXCB6W5wjFngphXEDKUG6SzKPfMUQSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORx/T+yNWgQA4TeKRx8BNTfYEeSM+R3z5+BZUMG7xoYS+lw9N0dMtRvSj639Kb0oOdUuD7wvsM2xxepE/ryFX92XJaz4GzOuZSvYcPeRNHNfUtEwFLWJ6Y65Jo9Mg9F/zKN1bBwH4+K/n34eE9SnFJoMph5ZJMH+sVqIG4zDNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 195241F74C;
	Tue,  4 Mar 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 151161393C;
	Tue,  4 Mar 2025 06:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PjGL2aZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:46 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 6/8] initramfs: reuse name_len for dir mtime tracking
Date: Tue,  4 Mar 2025 16:57:49 +1100
Message-ID: <20250304061020.9815-7-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304061020.9815-1-ddiss@suse.de>
References: <20250304061020.9815-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 195241F74C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

We already have a nulterm-inclusive, checked name_len for the directory
name, so use that instead of calling strlen().

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index df75624cdefbf..b9cacdc54eaf1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -144,9 +144,8 @@ struct dir_entry {
 	char name[];
 };
 
-static void __init dir_add(const char *name, time64_t mtime)
+static void __init dir_add(const char *name, size_t nlen, time64_t mtime)
 {
-	size_t nlen = strlen(name) + 1;
 	struct dir_entry *de;
 
 	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
@@ -170,7 +169,7 @@ static void __init dir_utime(void)
 #else
 static void __init do_utime(char *filename, time64_t mtime) {}
 static void __init do_utime_path(const struct path *path, time64_t mtime) {}
-static void __init dir_add(const char *name, time64_t mtime) {}
+static void __init dir_add(const char *name, size_t nlen, time64_t mtime) {}
 static void __init dir_utime(void) {}
 #endif
 
@@ -394,7 +393,7 @@ static int __init do_name(void)
 		init_mkdir(collected, mode);
 		init_chown(collected, uid, gid, 0);
 		init_chmod(collected, mode);
-		dir_add(collected, mtime);
+		dir_add(collected, name_len, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-- 
2.43.0


