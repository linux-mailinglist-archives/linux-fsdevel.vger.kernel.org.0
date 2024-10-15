Return-Path: <linux-fsdevel+bounces-31984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8541F99ED8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A41F21CA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA2139D04;
	Tue, 15 Oct 2024 13:30:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E611AF0BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999037; cv=none; b=C8ZqOSaGBG0+Or1acI03Jan21kzZlJTLou1SkYRw1+KH7njdjA7LHOegDDGxj5/RCsYunv+CZkVKLYAs0l4VAQcH2I981pOEgm0DGQHg5BJGZUSMOhH8j+H/NEbiWKx7l4AmD3Aykr88VgNUWkKxcaojZD2wNMwIi/vUTnv/jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999037; c=relaxed/simple;
	bh=ac6FvTfBGLWOGFEiJupZW3Nyb4bFepsDOdlrqAPMPdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ4sVtYIPkR7fbjNsG8iJ1q60b55h8X1gZxTwVLB2h4Py5z5BV6jp3ybUNXS3wKCTIqvuJYuSzqB5WrGcoQi9yYOJFYDDgtyq9pspRB+R0jbLb4E2WoFQ5YPQQxGV4cYokP/rZTXRGZBpVNoG9yEDU+1fDn9AQwLmIh9RVkGRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF8BE21D8E;
	Tue, 15 Oct 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F41F513AAF;
	Tue, 15 Oct 2024 13:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MHBtKXduDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:31 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 3/6] initramfs: remove extra symlink path buffer
Date: Tue, 15 Oct 2024 13:12:00 +0000
Message-ID: <20241015133016.23468-4-ddiss@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CF8BE21D8E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

A (newc/crc) cpio entry with mode.S_IFLNK set carries the symlink target
in the cpio data segment, following the padded name_len sized file
path. symlink_buf is heap-allocated for staging both file path and
symlink target, while name_buf is additionally allocated for staging the
path for non-symlink cpio entries.

Separate symlink / non-symlink buffers are unnecessary, so just extend
the size of name_buf and use it for both.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c35600d49a50a..4b7f20fbf23ae 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -249,7 +249,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *name_buf;
 
 static int __init do_start(void)
 {
@@ -293,7 +293,7 @@ static int __init do_header(void)
 	if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
 			return 0;
-		collect = collected = symlink_buf;
+		collect = collected = name_buf;
 		remains = N_ALIGN(name_len) + body_len;
 		next_state = GotSymlink;
 		state = Collect;
@@ -487,10 +487,9 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	static __initdata char msg_buf[64];
 
 	header_buf = kmalloc(110, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
-	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-
-	if (!header_buf || !symlink_buf || !name_buf)
+	/* 2x PATH_MAX as @name_buf is also used for staging symlink targets */
+	name_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!header_buf || !name_buf)
 		panic_show_mem("can't allocate buffers");
 
 	state = Start;
@@ -536,7 +535,6 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	}
 	dir_utime();
 	kfree(name_buf);
-	kfree(symlink_buf);
 	kfree(header_buf);
 	return message;
 }
-- 
2.43.0


