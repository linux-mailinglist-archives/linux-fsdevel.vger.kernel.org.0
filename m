Return-Path: <linux-fsdevel+bounces-31986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16F99ED8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B271C21F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E714D2B9;
	Tue, 15 Oct 2024 13:30:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE914A60D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999041; cv=none; b=AePn42mrPGWCy2YbLdc2H9sisxdKI7naN2tAROJ8UxeZB1ma6+CyH2moXMgbVxairOOPrcB+IU7uAfuuuBU0dPKUQrSGhEUipHC0gZSU6Cuzi9BBYBR8UOjbXuZS+fqe5RZjXN4SzlE5RMwr1n3vcpu8MZ8kYoVPK51SRFJywiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999041; c=relaxed/simple;
	bh=C+TJgwOTuSZURjB6iXcKZ3Q9z0aJ94sz0D01lXhND2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHQ43kiEhFqGAjqVHvHOv2kBeJ5ZOIg1tvcBz6xbrSFj9wu2Mmpeh4SwfsTVHI+WdsFOEFrlO69cwoSlpMx/08FwuJOKGHgO5dCFCcrKedKTAlh20Kh2GQ8Eg2vkWYDQSzixwpkJ8KznvIBXuWnnQUWbAz2NoL8gtYqFaFrIdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B524C21D8E;
	Tue, 15 Oct 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D920713A42;
	Tue, 15 Oct 2024 13:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EIvEInxuDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:36 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 5/6] initramfs: reuse buf for built-in and bootloader initramfs
Date: Tue, 15 Oct 2024 13:12:02 +0000
Message-ID: <20241015133016.23468-6-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015133016.23468-1-ddiss@suse.de>
References: <20241015133016.23468-1-ddiss@suse.de>
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
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: B524C21D8E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

cpio_buf is allocated and freed within unpack_to_rootfs(), while the
do_populate_rootfs() parent function may call it twice to unpack both
built-in and bootloader-provided cpio archives.
Move allocation out into the caller and reuse cpio_buf.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c0aea453d2792..7594a176d8d91 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -486,16 +486,6 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	/*
-	 * @cpio_buf is first used for staging the 110 byte newc/crc cpio
-	 * header, after which parse_header() converts and stashes fields into
-	 * corresponding types. The same buffer is then reused for file path
-	 * staging. 2 x PATH_MAX covers any possible symlink target.
-	 */
-	cpio_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
-	if (!cpio_buf)
-		panic_show_mem("can't allocate buffers");
-
 	state = Start;
 	this_header = 0;
 	message = NULL;
@@ -538,7 +528,6 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
-	kfree(cpio_buf);
 	return message;
 }
 
@@ -688,8 +677,20 @@ static void __init populate_initrd_image(char *err)
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
+	char *err;
+
+	/*
+	 * @cpio_buf is first used for staging the 110 byte newc/crc cpio
+	 * header, after which parse_header() converts and stashes fields into
+	 * corresponding types. The same buffer is then reused for file path
+	 * staging. 2 x PATH_MAX covers any possible symlink target.
+	 */
+	cpio_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!cpio_buf)
+		panic_show_mem("can't allocate buffers");
+
 	/* Load the built in initramfs */
-	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
+	err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
@@ -711,6 +712,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	}
 
 done:
+	kfree(cpio_buf);
 	security_initramfs_populated();
 
 	/*
-- 
2.43.0


