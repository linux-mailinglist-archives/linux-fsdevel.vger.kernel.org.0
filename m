Return-Path: <linux-fsdevel+bounces-31985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C299ED8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0279A1C21D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE8250F8;
	Tue, 15 Oct 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3kU8P+1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cq+Mk/XR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3kU8P+1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cq+Mk/XR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538B147C91
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999039; cv=none; b=jjbLfz0oH4UVgadkfA5aqfOY+Eqay3pMamZ0Yn32DYTdsf28TxHKTm0can7rb05yU0GdbEo4ZUajaGCiBYt2MgwaaeF4QyTj9XMbQ53TCauwUENcHJ8ao0GHCIMntjWBLTJoUs5/YGcFoJKJnaSZczg0jTLEgDCU4AIvBCXwsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999039; c=relaxed/simple;
	bh=+ruySnQ8RYBA9ugiLnAnW/Oq6X69aW3703tf8hhlwdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5Xt/v5BDIISnMABfsvNgM5+7QUoHlfb6JnffyHjYbz7EEAfraWsjA2GNVenZxi14sf4GHTXdbXy+egwPcG732DpYOjiaJknC/Pu7+wIHyjkIEmqFGlH9A43Zh+6DRsy32O4li1mInKIP8iF1pvyGUzUFORryQr6Q/qC/7Dm/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3kU8P+1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cq+Mk/XR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3kU8P+1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cq+Mk/XR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4819F1FE44;
	Tue, 15 Oct 2024 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAUCatqpnqiacXQDuxmwbSwhGqqLisoaQvkF8TeSibw=;
	b=B3kU8P+1ncpqcI0f1FNd7voZhMDspIH6xSWpCxoaD25c87RkvCiYlqsdAOTKaWFZGK4WQj
	OToeK2mZ5hf9eHu1odGeINQrOEo+l8KpxZp/FEUJ9srWYGy2bQlbylRbY6Xhzm52+at29K
	+bJ3FLFx/kgYneXFCexagRZY7flm6cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAUCatqpnqiacXQDuxmwbSwhGqqLisoaQvkF8TeSibw=;
	b=cq+Mk/XR2HPzNLcB7lu7Yz9nv2sfzOh7i9derkDFp5xBrew59R0bIezJxA3weSUbGwmXQk
	99HiZiB82FfjtzAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAUCatqpnqiacXQDuxmwbSwhGqqLisoaQvkF8TeSibw=;
	b=B3kU8P+1ncpqcI0f1FNd7voZhMDspIH6xSWpCxoaD25c87RkvCiYlqsdAOTKaWFZGK4WQj
	OToeK2mZ5hf9eHu1odGeINQrOEo+l8KpxZp/FEUJ9srWYGy2bQlbylRbY6Xhzm52+at29K
	+bJ3FLFx/kgYneXFCexagRZY7flm6cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAUCatqpnqiacXQDuxmwbSwhGqqLisoaQvkF8TeSibw=;
	b=cq+Mk/XR2HPzNLcB7lu7Yz9nv2sfzOh7i9derkDFp5xBrew59R0bIezJxA3weSUbGwmXQk
	99HiZiB82FfjtzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BD3613A42;
	Tue, 15 Oct 2024 13:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UB4qCHpuDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:34 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 4/6] initramfs: merge header_buf and name_buf
Date: Tue, 15 Oct 2024 13:12:01 +0000
Message-ID: <20241015133016.23468-5-ddiss@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

header_buf is only used in FSM states up to GotHeader, while name_buf is
only used in states following GotHeader (Collect is shared, but the
collect pointer tracks each buffer). These buffers can therefore be
combined into a single cpio_buf, which is used for both header and file
name storage.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4b7f20fbf23ae..c0aea453d2792 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -249,11 +249,11 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *name_buf;
+static __initdata char *cpio_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
+	read_into(cpio_buf, 110, GotHeader);
 	return 0;
 }
 
@@ -293,14 +293,14 @@ static int __init do_header(void)
 	if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
 			return 0;
-		collect = collected = name_buf;
+		collect = collected = cpio_buf;
 		remains = N_ALIGN(name_len) + body_len;
 		next_state = GotSymlink;
 		state = Collect;
 		return 0;
 	}
 	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
+		read_into(cpio_buf, N_ALIGN(name_len), GotName);
 	return 0;
 }
 
@@ -486,10 +486,14 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(110, GFP_KERNEL);
-	/* 2x PATH_MAX as @name_buf is also used for staging symlink targets */
-	name_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
-	if (!header_buf || !name_buf)
+	/*
+	 * @cpio_buf is first used for staging the 110 byte newc/crc cpio
+	 * header, after which parse_header() converts and stashes fields into
+	 * corresponding types. The same buffer is then reused for file path
+	 * staging. 2 x PATH_MAX covers any possible symlink target.
+	 */
+	cpio_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!cpio_buf)
 		panic_show_mem("can't allocate buffers");
 
 	state = Start;
@@ -534,8 +538,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
-	kfree(name_buf);
-	kfree(header_buf);
+	kfree(cpio_buf);
 	return message;
 }
 
-- 
2.43.0


