Return-Path: <linux-fsdevel+bounces-33602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A49BB75D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1681C234D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0D13B7AE;
	Mon,  4 Nov 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6Sy484V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eNDWp5mW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6Sy484V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eNDWp5mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A83398B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729890; cv=none; b=G8wJELkTFZz5HkOgwUIestnVUY8KvyysA4CEZs+yomHVfUdo9HGW+vZ1LtJ/9fqkYL4d7ylPwK31mIUC/XRHXXk6w3NAdzWy5mhA3TOBt41o7dCx6S5R+zWEy1/qhGUrzakw3/KvG0bby9Cdri3Jn/IYvA/zFBFzCN2eo2bfobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729890; c=relaxed/simple;
	bh=vaMZZsDlsC0OXX4/YW6sLIRZcTjRr82/f+FZADYuu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5DHzliG28ZAFmWhQDcqr9xhzvrNzbr6on/YQd4uYxgVgs281TRK+FZdQsKwYo9g4L1KVqKzPIwAiyr+dCBWRSuDfYDZsicJ9ftPSbDPk0xCFnhbdGnpwbYLTg+3Y6GWns3bvvxClPwv9woLzV1gAUg/2t+6K1CLr+psoSbz4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6Sy484V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eNDWp5mW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6Sy484V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eNDWp5mW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9717F1FF36;
	Mon,  4 Nov 2024 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=o6Sy484VvdDNsSBBYRBeWSCmKlaDOe/mTrbWosPKntRdBVBlHRncB84ac65bcU21qjqWdL
	gyOW8v2HsWu6oNz3Rpb1q9d3MRkBlPXKt1PxJ5R1+HkBUErsxH6TM/8OWZypceR6rfcJj/
	l2kPjDH2GeTIMEXDA1n8X1YzvLjHqKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=eNDWp5mWQmV6vFD0Sr9oJ36gqhXsSR2wrcVxXQLDi5L6RuNwGP3dS2ABwHa3tX0PwQsgtT
	CtO0p5VgpRl6rgDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o6Sy484V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eNDWp5mW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=o6Sy484VvdDNsSBBYRBeWSCmKlaDOe/mTrbWosPKntRdBVBlHRncB84ac65bcU21qjqWdL
	gyOW8v2HsWu6oNz3Rpb1q9d3MRkBlPXKt1PxJ5R1+HkBUErsxH6TM/8OWZypceR6rfcJj/
	l2kPjDH2GeTIMEXDA1n8X1YzvLjHqKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=eNDWp5mWQmV6vFD0Sr9oJ36gqhXsSR2wrcVxXQLDi5L6RuNwGP3dS2ABwHa3tX0PwQsgtT
	CtO0p5VgpRl6rgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C55BB13736;
	Mon,  4 Nov 2024 14:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKllHpzXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:04 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/9] init: add initramfs_internal.h
Date: Tue,  5 Nov 2024 01:14:40 +1100
Message-ID: <20241104141750.16119-2-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 9717F1FF36
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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


