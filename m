Return-Path: <linux-fsdevel+bounces-43037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D9A4D37A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991E93A8908
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4D1F4736;
	Tue,  4 Mar 2025 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOCpJR2n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JqeCvHki";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOCpJR2n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JqeCvHki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C31F416B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068644; cv=none; b=q6uPBm34Z3uEHcXoCIl6kiS+Up++Wn34oGhj2QNpL9pg+XPxbEAPvscgIOGOE8ucyzWFnV2bItz1eVgxjncdmdHE/eeKe6gETqwG2hiI8GBXFxTssjX5mLIAuk7sv6vhBG4fbF/cUZrPiQTHeRgYEU0olqpaCr2qj47qI/0cFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068644; c=relaxed/simple;
	bh=vaMZZsDlsC0OXX4/YW6sLIRZcTjRr82/f+FZADYuu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMQeFm7Ay8nFld6A2G4ngAhK80fQFj/bYbwbWQtqRC0tGtTxrIfseIKoni9ZUPize9HsPNUjO1ejoFOi3+cMFcz6ia3mXU6HgAXR1mISTBgGhH7WK4POO/ejZfkBeMt3jufttsGNgx1FBxKVQr428zFcNsDxXEJhwxn0wwLfxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOCpJR2n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JqeCvHki; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOCpJR2n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JqeCvHki; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 379731F393;
	Tue,  4 Mar 2025 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=OOCpJR2nmSJtftVzcaEyMip7boqeOW1eVBaizdgbiLqj4sS7/Gbhh3UJZbkXb32rsEEUkq
	qzibKlJyLDgixHkpwtntoB4fUK/5siNTtSK13ADaD7PYtNHft5vIwaH70k5jbcYyR80MTr
	9xviYZkM00FVGKBvlmpORToL+AFXmUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=JqeCvHkigRCzmQ98WhsXxl24N8k/8OOSHJmip0MKN+bAcDXeLc+revbLAhz6OsomAhPrWh
	5qpwIll0zxCdvkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=OOCpJR2nmSJtftVzcaEyMip7boqeOW1eVBaizdgbiLqj4sS7/Gbhh3UJZbkXb32rsEEUkq
	qzibKlJyLDgixHkpwtntoB4fUK/5siNTtSK13ADaD7PYtNHft5vIwaH70k5jbcYyR80MTr
	9xviYZkM00FVGKBvlmpORToL+AFXmUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR4Otz75vEf5Pg16S0hLDPNqprTjRsnE7GGU4lnD1HQ=;
	b=JqeCvHkigRCzmQ98WhsXxl24N8k/8OOSHJmip0MKN+bAcDXeLc+revbLAhz6OsomAhPrWh
	5qpwIll0zxCdvkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31C961393C;
	Tue,  4 Mar 2025 06:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNe5NlmZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:33 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 1/8] init: add initramfs_internal.h
Date: Tue,  4 Mar 2025 16:57:44 +1100
Message-ID: <20250304061020.9815-2-ddiss@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

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


