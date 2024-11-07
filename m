Return-Path: <linux-fsdevel+bounces-33843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3579BFAA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C5A1C21414
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C047747F;
	Thu,  7 Nov 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SB1mAg8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="496vMjkI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SB1mAg8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="496vMjkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343355227;
	Thu,  7 Nov 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938883; cv=none; b=eGSL7nyTyveW+Nzmf6nTWzll+87jicshYTQMLzNasQXSVjrgGPGWJQSLK+od7Cx821hjLSbzBPPQxv/EXGsVMRQP6aXgVAcVmsTZfI4S88Dga61wGr774oWfyX0jPn2Py648gCqAkMwZBJdo81ec1x6g4o2wZXM7cw3ufn33nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938883; c=relaxed/simple;
	bh=vaMZZsDlsC0OXX4/YW6sLIRZcTjRr82/f+FZADYuu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd9X6GB8acvcBVHN8/ZJs2eek/ysaWD5ROR29fIkyhy8zurb9daXKV6Ay0uFB03K8nBZdlftblHPvZXc2ddjq5jFImyq5tl9zKjcC2cCTWt1nSb3DbwQuGzgo7I+akUVzY59vZxPU7yTiY3HSfiKX19Lwvc63ep+/VTfG7l7W+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SB1mAg8Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=496vMjkI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SB1mAg8Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=496vMjkI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4567C21E3C;
	Thu,  7 Nov 2024 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=SB1mAg8QQ+JSfCef9M/eoEeayQdmEdEA06vSucsHzhlQwKigP0mAtkNwp7XawTcthGI4xK
	r286qyLa4bKWABUmkCfkH/Ip+vIv/qj1hzPYoAKCUNwnQjwE6tIRLr7EPHSRXY0wNZCwuI
	YBpeurexDWRj0x10NfO3/tcH1otccM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=496vMjkI5SCfKWSFMBvK1jF9igaG+lQ9Uvn1qIOKI+78JmK7mxtApG4ujagfeDo89+W5ht
	Fykp1b/hggzxbEAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SB1mAg8Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=496vMjkI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=SB1mAg8QQ+JSfCef9M/eoEeayQdmEdEA06vSucsHzhlQwKigP0mAtkNwp7XawTcthGI4xK
	r286qyLa4bKWABUmkCfkH/Ip+vIv/qj1hzPYoAKCUNwnQjwE6tIRLr7EPHSRXY0wNZCwuI
	YBpeurexDWRj0x10NfO3/tcH1otccM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=496vMjkI5SCfKWSFMBvK1jF9igaG+lQ9Uvn1qIOKI+78JmK7mxtApG4ujagfeDo89+W5ht
	Fykp1b/hggzxbEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B551394A;
	Thu,  7 Nov 2024 00:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDPrMv0HLGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:21:17 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 1/9] init: add initramfs_internal.h
Date: Thu,  7 Nov 2024 11:17:19 +1100
Message-ID: <20241107002044.16477-2-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 4567C21E3C
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

The new header only exports a single unpack function and a CPIO_HDRLEN
constant for future test use.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c          | 16 +++++++++++++---
 init/initramfs_internal.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 init/initramfs_internal.h

diff --git a/init/initramfs.c b/init/initramfs.c
index b2f7583bb1f5c..002e83ae12ac7 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -20,6 +20,7 @@
 #include <linux/security.h>
 
 #include "do_mounts.h"
+#include "initramfs_internal.h"
 
 static __initdata bool csum_present;
 static __initdata u32 io_csum;
@@ -256,7 +257,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
+	read_into(header_buf, CPIO_HDRLEN, GotHeader);
 	return 0;
 }
 
@@ -497,14 +498,23 @@ static unsigned long my_inptr __initdata; /* index of next byte to be processed
 
 #include <linux/decompress/generic.h>
 
-static char * __init unpack_to_rootfs(char *buf, unsigned long len)
+/**
+ * unpack_to_rootfs - decompress and extract an initramfs archive
+ * @buf: input initramfs archive to extract
+ * @len: length of initramfs data to process
+ *
+ * Returns: NULL for success or an error message string
+ *
+ * This symbol shouldn't be used externally. It's available for unit tests.
+ */
+char * __init unpack_to_rootfs(char *buf, unsigned long len)
 {
 	long written;
 	decompress_fn decompress;
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(110, GFP_KERNEL);
+	header_buf = kmalloc(CPIO_HDRLEN, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
diff --git a/init/initramfs_internal.h b/init/initramfs_internal.h
new file mode 100644
index 0000000000000..233dad16b0a00
--- /dev/null
+++ b/init/initramfs_internal.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __INITRAMFS_INTERNAL_H__
+#define __INITRAMFS_INTERNAL_H__
+
+char *unpack_to_rootfs(char *buf, unsigned long len);
+#define CPIO_HDRLEN 110
+
+#endif
-- 
2.43.0


