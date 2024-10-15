Return-Path: <linux-fsdevel+bounces-31987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48E99ED8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD61F2341C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B651AF0AA;
	Tue, 15 Oct 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpJrs7M1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VZvtRKps";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpJrs7M1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VZvtRKps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750F14A60D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999044; cv=none; b=R9jf/7bVwC86TRmf7368j2dnoFcyr9nJKOIeR0737FEhwnGRbhVhjPyOdNwsgInQWllmNyDicnly9cEGI6h4/9+yzRoI2uu71Rsyj7ZqVCBtA3z0Tq5I3RK2L2IpYvoREIOE5M9U9LwguzKwdxEyswBDDpq741V9ukhNN2etsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999044; c=relaxed/simple;
	bh=TEZF/t8lA82lb7rM98auy44WfIzJGUwGTyKJvID814E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG7H4tKGG2U+relVQ0Onf4efc/O0G5LHzD/vlt9ulbEio7I7iVgv6bs6sjjRQppk4IrDxIvPtE96eo7VjDTF5ua+b+fXTaGQgbmwGxXyr7gH6UrI+jB4bpiKWgZrwyrb20sBMEzGx53xRX91S8GNTCtJMgkfIqfen+k2AUfF+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpJrs7M1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VZvtRKps; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpJrs7M1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VZvtRKps; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E97721DAF;
	Tue, 15 Oct 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsaCBDbLaw9klUnmeEZEErbNcuRPrGKCoviTHPf7KjI=;
	b=RpJrs7M1lF7rbYTtdhLpZmSupKgU0Esldx7YL58qDCIrSyccIC0H5fXRj+7x18zBf0qgut
	GY3Z7ojl0umnbV5S8ZccRhv9hjjMeMA5vU52mqga/nNMcvwRoPh7wlsgAUnXG+Qaw71q/n
	Hwe8w31tt9dA8xO+jXYsiAJLDtsJv94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsaCBDbLaw9klUnmeEZEErbNcuRPrGKCoviTHPf7KjI=;
	b=VZvtRKps2Iaxh9GlN+bs5fjKdq4E56ZzBJWGsvWjQjcRfqRoV8uj8O1HxCCPP83eHpxwim
	2nrIcevrrE5BowCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsaCBDbLaw9klUnmeEZEErbNcuRPrGKCoviTHPf7KjI=;
	b=RpJrs7M1lF7rbYTtdhLpZmSupKgU0Esldx7YL58qDCIrSyccIC0H5fXRj+7x18zBf0qgut
	GY3Z7ojl0umnbV5S8ZccRhv9hjjMeMA5vU52mqga/nNMcvwRoPh7wlsgAUnXG+Qaw71q/n
	Hwe8w31tt9dA8xO+jXYsiAJLDtsJv94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsaCBDbLaw9klUnmeEZEErbNcuRPrGKCoviTHPf7KjI=;
	b=VZvtRKps2Iaxh9GlN+bs5fjKdq4E56ZzBJWGsvWjQjcRfqRoV8uj8O1HxCCPP83eHpxwim
	2nrIcevrrE5BowCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5250C13A42;
	Tue, 15 Oct 2024 13:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mP/oAX9uDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:39 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 6/6] initramfs: avoid static buffer for error message
Date: Tue, 15 Oct 2024 13:12:03 +0000
Message-ID: <20241015133016.23468-7-ddiss@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

With cpio_buf now allocated / freed by the unpack_to_rootfs() caller,
FSM-exit error messages can now be stashed in cpio_buf instead of in a
static buffer.

Before:
   text    data     bss     dec     hex filename
   7423    1062       8    8493    212d ./init/initramfs.o

After:
   text    data     bss     dec     hex filename
   7423     966       8    8397    20cd ./init/initramfs.o

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7594a176d8d91..815a5daaa27ce 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -484,7 +484,6 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	long written;
 	decompress_fn decompress;
 	const char *compress_name;
-	static __initdata char msg_buf[64];
 
 	state = Start;
 	this_header = 0;
@@ -514,10 +513,12 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 				error("decompressor failed");
 		} else if (compress_name) {
 			if (!message) {
-				snprintf(msg_buf, sizeof msg_buf,
+				/* FSM exit: cpio_buf reuse is safe */
+				snprintf(cpio_buf,
+					 N_ALIGN(PATH_MAX) + PATH_MAX + 1,
 					 "compression method %s not configured",
 					 compress_name);
-				message = msg_buf;
+				message = cpio_buf;
 			}
 		} else
 			error("invalid magic at start of compressed archive");
@@ -684,6 +685,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * header, after which parse_header() converts and stashes fields into
 	 * corresponding types. The same buffer is then reused for file path
 	 * staging. 2 x PATH_MAX covers any possible symlink target.
+	 * On error, @err may point to a @cpio_buf backed error message.
 	 */
 	cpio_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
 	if (!cpio_buf)
-- 
2.43.0


