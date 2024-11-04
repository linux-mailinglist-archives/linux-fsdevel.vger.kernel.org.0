Return-Path: <linux-fsdevel+bounces-33608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD909BB769
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B181C23C2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BB165F1A;
	Mon,  4 Nov 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FL9DAxJw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pVPVTXcO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1JLR+SGO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i+g6k+eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B01632C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729904; cv=none; b=kpLcVEP0KOHkbaCRjTETgmof6mDYBw/VonoArGVS8z6kJvPBzrAddSYn1YxZCkVyfCxMZMhg9yT1xDfqaReU9luQZFMP2IXNCmRgZi2TFVXPSrsK0iA+o81IPTt///d/WSmnLsdBE70kuI2DgfoJUvgaST3MU/QLNjUBUufFamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729904; c=relaxed/simple;
	bh=KtCvMQnoTAGnjG8Y+Sk2AzwfZ4BixyKP/vWn/8eLMoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLMQZVWqVlfRfv7TH7z+ZlO9zHdZGRKpQBTbpTu+M+GemWAvWD2yyFcAwqIIZT0oSTFhisuqLSmsNUOH/RuqptN2g+3V7F/yOgLtilYEa6GmB2e73L5Vax5uGv7l98JcLOvIjaqQSX9hSJfRU0o9WzYU/pU0kZY/5NvOJ5VU/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FL9DAxJw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pVPVTXcO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1JLR+SGO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i+g6k+eZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4FC71FB82;
	Mon,  4 Nov 2024 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=FL9DAxJwaiL/GEQfszvsbE3UWh2ryfN1fNV2bbP1uWRBbUMEIPfbF2S1ThYd0RunDSTwL0
	DhhZzoWSLG63lP4BJq8qSDb14iWRygIaC3P3+20RVUgEhRR38S68os7Py4xabeReytkm1F
	V6sscPDS3RQdX4nWpKXbgPXLh1F4v/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=pVPVTXcO6w4l8inH37x0Mrfx/lv3AlkNkMP3UId3uFk33b3sCh1dOiHeOyZ1AJvfkgn5tK
	WfkktwVyozz7OXBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1JLR+SGO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i+g6k+eZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=1JLR+SGOJQzo9Ym1XIxC9Nsb6ZkBstzuNEUtF09XUMBpWOZ9MuFvcu0QNrDJ/Bg2puL4a1
	vn2SRx9Lpn67klvnVaZS6DVxnZ9txNElE5/Y2YnVgJEAsd9cN6+WeRp3vxqr/NYBayr94V
	kde5scAN88tZRwjVmtvFX8x73NgviuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXGzLqa7ndw2VlNeIeFuPasg/cAnz8Fj/bNSm06DPsg=;
	b=i+g6k+eZlVk9Dn/nB9VKCv6pqhs9QR/dYVyvpKEyHLC9YDZu90GLI02+cfA+GStT01v9Pe
	7p3zgu8BFaDzQOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FFD913736;
	Mon,  4 Nov 2024 14:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YKqvMarXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:18 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 7/9] initramfs: reuse name_len for dir mtime tracking
Date: Tue,  5 Nov 2024 01:14:46 +1100
Message-ID: <20241104141750.16119-8-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104141750.16119-1-ddiss@suse.de>
References: <20241104141750.16119-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4FC71FB82
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

We already have a nulterm-inclusive, checked name_len for the directory
name, so use that instead of calling strlen().

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4e2506a4bc76f..c264f136c5281 100644
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


