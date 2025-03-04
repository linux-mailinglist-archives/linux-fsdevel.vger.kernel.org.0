Return-Path: <linux-fsdevel+bounces-43042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469BA4D380
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD19173102
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5091F473C;
	Tue,  4 Mar 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N21WRivF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ihjawd2U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N21WRivF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ihjawd2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496061F4264
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068667; cv=none; b=NyOoawLTTu6YOAyzz8DpjdQhOrUosYAf0ycNVjk34UgM5p/7k/LLBlaDMiSkC0N/owZuU3zcdAaplCQQ+i6nDXCf3iDCGJTtQg+3u2ROPOlfF+r1PbmrvDN7C8qjU4Q22hDQsVoYm6zARh4isxPkE9aGLRj+lyalCWJl7zmxVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068667; c=relaxed/simple;
	bh=wr94wuxAoWw6ZcCRtJuPUSP+VFngJt/W/KqI42uJVYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4C50EqKFVWrWED9LVvbAXKpuqLXPZHduGkWczPtoaJOl/vL0QVgelPrdE/I6FkW34NSIzaCrOwT9vkrQhJSIg1CkLYBaeXLkzPNdB9ss+ZACh7d3kzjsdHrDJjzJX9NAekAV67d4bgAliAkGB0eJu17YNvhYxcw27Ds27SLWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N21WRivF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ihjawd2U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N21WRivF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ihjawd2U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C2E71F393;
	Tue,  4 Mar 2025 06:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KG4mMqY6eMJW+C3Ta/SoMqbVps5Hjxb9QplpPEZcTs=;
	b=N21WRivFRB15j65yDYNnv9cNt9woEfWyqbDIXkN8COHTRsPOTUkoTBZTFx7Y2851hvag6M
	i0SW7dn1H/M8eic65atMkgFGk76maFsZxolrVWNx9er5+wWsJk50tszGhKHNJycuMjCnL8
	niYZgTfEju56d/U8LuYP7dXJs70YN/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KG4mMqY6eMJW+C3Ta/SoMqbVps5Hjxb9QplpPEZcTs=;
	b=ihjawd2UNNfE4rhV/07b7wv5VOI2EU7pGRaB1hUMnH2YUtHrXAB9x0UYuXSK/dpEkrqyp2
	41XrLSoSV9xbH6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KG4mMqY6eMJW+C3Ta/SoMqbVps5Hjxb9QplpPEZcTs=;
	b=N21WRivFRB15j65yDYNnv9cNt9woEfWyqbDIXkN8COHTRsPOTUkoTBZTFx7Y2851hvag6M
	i0SW7dn1H/M8eic65atMkgFGk76maFsZxolrVWNx9er5+wWsJk50tszGhKHNJycuMjCnL8
	niYZgTfEju56d/U8LuYP7dXJs70YN/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KG4mMqY6eMJW+C3Ta/SoMqbVps5Hjxb9QplpPEZcTs=;
	b=ihjawd2UNNfE4rhV/07b7wv5VOI2EU7pGRaB1hUMnH2YUtHrXAB9x0UYuXSK/dpEkrqyp2
	41XrLSoSV9xbH6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C82F1393C;
	Tue,  4 Mar 2025 06:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MERMDWSZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:44 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 5/8] initramfs: allocate heap buffers together
Date: Tue,  4 Mar 2025 16:57:48 +1100
Message-ID: <20250304061020.9815-6-ddiss@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-0.987];
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

header_buf, symlink_buf and name_buf all share the same lifecycle so
needn't be allocated / freed separately. This change leads to a minor
reduction in .text size:

before:
   text    data     bss     dec     hex filename
   7914    1110       8    9032    2348 init/initramfs.o

after:
   text    data     bss     dec     hex filename
   7854    1110       8    8972    230c init/initramfs.o

A previous iteration of this patch reused a single buffer instead of
three, given that buffer use is state-sequential (GotHeader, GotName,
GotSymlink). However, the slight decrease in heap use during early boot
isn't really worth the extra review complexity.

Link: https://lore.kernel.org/all/20241107002044.16477-7-ddiss@suse.de/
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6dd3b02c15d7e..df75624cdefbf 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -510,14 +510,19 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	decompress_fn decompress;
 	const char *compress_name;
 	static __initdata char msg_buf[64];
+	struct {
+		char header[CPIO_HDRLEN];
+		char symlink[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
+		char name[N_ALIGN(PATH_MAX)];
+	} *bufs = kmalloc(sizeof(*bufs), GFP_KERNEL);
 
-	header_buf = kmalloc(CPIO_HDRLEN, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
-	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-
-	if (!header_buf || !symlink_buf || !name_buf)
+	if (!bufs)
 		panic_show_mem("can't allocate buffers");
 
+	header_buf = bufs->header;
+	symlink_buf = bufs->symlink;
+	name_buf = bufs->name;
+
 	state = Start;
 	this_header = 0;
 	message = NULL;
@@ -560,9 +565,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
-	kfree(name_buf);
-	kfree(symlink_buf);
-	kfree(header_buf);
+	kfree(bufs);
 	return message;
 }
 
-- 
2.43.0


