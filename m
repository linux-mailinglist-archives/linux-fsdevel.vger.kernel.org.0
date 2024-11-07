Return-Path: <linux-fsdevel+bounces-33847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD149BFAB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EF1C203DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB77485;
	Thu,  7 Nov 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oKN3B4SR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fxPm4ppS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oKN3B4SR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fxPm4ppS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2FD515;
	Thu,  7 Nov 2024 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938924; cv=none; b=sj9lmMzshUQqu4eHgKtIgI9ZlRpvf2NFcOOJzg24xab4IboXhEY/sbxBCwZPEWTM4Y4eQo1qRj00Ssj7LvW1QgTAilwQmyqOWpUD2gYeS2mpum2Deq8YdQH6dIb/m+AGetDvi6aVj8cSo8d0FfKYSR4z6XOImjvIPs/fLElf4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938924; c=relaxed/simple;
	bh=m5hJjlSJ1opmfVlIWfPqkvhhmAI65ZdzM180nHf+/VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1aXK64WfUJhW/ck2X5iovOuR7g2GHkbEvkOBORtgrfMFwrYKRNAvNf/JVbkyJwz8rxVPZapOvXJFaYBiQAKTNIsegNSC/NAJ/HxQowCEQjI2lmRWuz/8sOsswKdd0vY2ma2qCH9SpIPDlhWaDm+WYiBizruRYaywZ1an6B9Sek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oKN3B4SR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fxPm4ppS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oKN3B4SR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fxPm4ppS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53DD41F392;
	Thu,  7 Nov 2024 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=oKN3B4SRZ49P8fOeeih7QqyRU9gCHDWcR52M5MSC+aM0Fl3ItaRiIM24Qxc4tqbHPCTY4k
	fuTs9drpQyJUd5o2BgaVW6zkQMZnNSMecib0J+TWeZzw/WKYuIIQQ17uwIRttBMKlZLqMg
	sCxOzosBzY1AqtX4376/wZeLDGKBmZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=fxPm4ppSeQz/hWIUI/eny4P4DxfbUsYVakQvqFyI5d1p/MCbYha8Z8sgij5jHcUB0IS/56
	yP218hFtAxMcyxBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oKN3B4SR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fxPm4ppS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=oKN3B4SRZ49P8fOeeih7QqyRU9gCHDWcR52M5MSC+aM0Fl3ItaRiIM24Qxc4tqbHPCTY4k
	fuTs9drpQyJUd5o2BgaVW6zkQMZnNSMecib0J+TWeZzw/WKYuIIQQ17uwIRttBMKlZLqMg
	sCxOzosBzY1AqtX4376/wZeLDGKBmZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=fxPm4ppSeQz/hWIUI/eny4P4DxfbUsYVakQvqFyI5d1p/MCbYha8Z8sgij5jHcUB0IS/56
	yP218hFtAxMcyxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3457E1394A;
	Thu,  7 Nov 2024 00:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CORuNiYILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:21:58 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 5/9] initramfs: remove extra symlink path buffer
Date: Thu,  7 Nov 2024 11:17:24 +1100
Message-ID: <20241107002044.16477-7-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107002044.16477-1-ddiss@suse.de>
References: <20241107002044.16477-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53DD41F392
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

A (newc/crc) cpio entry with mode.S_IFLNK set carries the symlink target
in the cpio data segment, following the padded name_len sized file
path. symlink_buf is heap-allocated for staging both file path and
symlink target, while name_buf is additionally allocated for staging
paths for non-symlink cpio entries.

Separate symlink / non-symlink buffers are unnecessary, so just extend
the size of name_buf and use it for both.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6dd3b02c15d7e..59b4a43fa491b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -250,7 +250,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *name_buf;
 
 static int __init do_start(void)
 {
@@ -294,7 +294,7 @@ static int __init do_header(void)
 	if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
 			return 0;
-		collect = collected = symlink_buf;
+		collect = collected = name_buf;
 		remains = N_ALIGN(name_len) + body_len;
 		next_state = GotSymlink;
 		state = Collect;
@@ -512,10 +512,9 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	static __initdata char msg_buf[64];
 
 	header_buf = kmalloc(CPIO_HDRLEN, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
-	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-
-	if (!header_buf || !symlink_buf || !name_buf)
+	/* 2x PATH_MAX as @name_buf is also used for staging symlink targets */
+	name_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!header_buf || !name_buf)
 		panic_show_mem("can't allocate buffers");
 
 	state = Start;
@@ -561,7 +560,6 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	}
 	dir_utime();
 	kfree(name_buf);
-	kfree(symlink_buf);
 	kfree(header_buf);
 	return message;
 }
-- 
2.43.0


