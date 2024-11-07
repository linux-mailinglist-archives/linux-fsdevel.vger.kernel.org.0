Return-Path: <linux-fsdevel+bounces-33851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAC9BFABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5561C21460
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7F8F5E;
	Thu,  7 Nov 2024 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JbRAFEw4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="budqmE87";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JbRAFEw4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="budqmE87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB86D53F;
	Thu,  7 Nov 2024 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938936; cv=none; b=ESShiNcdTT+VQT7ENGI9Gm30abPif5Sal/L7BxKzfvgaRyWtgoNZ8WwGBiMQuXBD+61RldlHqBRQBd1tmWLs6oFUxnmJvZ5X0jz8lFo9ACg232Tx1c7GSYEegcCpyQKSNdkQ5lahEhFJcNw0DmOGYWFoO47MDYHdTo1AUl30hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938936; c=relaxed/simple;
	bh=E4bOtcamvsZQyV8i49+tvTolrYnEthbpE/LTW55KkK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzo4tVqF91Mv7ajt20Qrf8ulvWfJx5Qns2xvvFRWUceSimD/ABAR04KBkBMnhhGxCZ0LPlaY+UQuHlQ5AX6kI01BNT5L96ymr5uZtA/+oIecU68JR0eo9x9JQxmu1ExPdelJqFSLaViQO6gLucun5JRlQjKFNTBfQUFAlIULSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JbRAFEw4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=budqmE87; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JbRAFEw4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=budqmE87; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB1521CBD;
	Thu,  7 Nov 2024 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=JbRAFEw4fmhgWa0c7XziCjUsn4c7N4T/iHF7qyzzS10C69Edy/mJVm7Sw1eCbW55SnqWGK
	OfYXnRjYYR/2hekUIJ4PVUk6Sl7w28XgrjQLtmfTZc4wMMbs4nnHmC+xyGIcWLRb1/1fHb
	BQkfJoVXF22+HzDdV00/sFh+MSocby0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=budqmE87YlNLPmX1jju18QdcN4vn2h55CAjbcM9or4X0+Cxtzz0wn3nzJcVHOInhazPupc
	d/R8D8NLVwWhu8BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JbRAFEw4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=budqmE87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=JbRAFEw4fmhgWa0c7XziCjUsn4c7N4T/iHF7qyzzS10C69Edy/mJVm7Sw1eCbW55SnqWGK
	OfYXnRjYYR/2hekUIJ4PVUk6Sl7w28XgrjQLtmfTZc4wMMbs4nnHmC+xyGIcWLRb1/1fHb
	BQkfJoVXF22+HzDdV00/sFh+MSocby0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=budqmE87YlNLPmX1jju18QdcN4vn2h55CAjbcM9or4X0+Cxtzz0wn3nzJcVHOInhazPupc
	d/R8D8NLVwWhu8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D85E1394A;
	Thu,  7 Nov 2024 00:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCP3LDEILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:22:09 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 9/9] initramfs: avoid static buffer for error message
Date: Thu,  7 Nov 2024 11:17:28 +1100
Message-ID: <20241107002044.16477-11-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 2CB1521CBD
X-Spam-Level: 
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The dynamic error message printed if CONFIG_RD_$ALG compression support
is missing needn't be propagated up to the caller via a static buffer.
Print it immediately via pr_err() and set @message to a const string to
flag error.

Before:
   text    data     bss     dec     hex filename
   7695    1102       8    8805    2265 ./init/initramfs.o

After:
   text    data     bss     dec     hex filename
   7683    1006       8    8697    21f9 ./init/initramfs.o

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 99f3cac10d392..f946b7680867b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -511,7 +511,6 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	long written;
 	decompress_fn decompress;
 	const char *compress_name;
-	static __initdata char msg_buf[64];
 
 	/*
 	 * @cpio_buf can be used for staging the 110 byte newc/crc cpio header,
@@ -551,12 +550,9 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 			if (res)
 				error("decompressor failed");
 		} else if (compress_name) {
-			if (!message) {
-				snprintf(msg_buf, sizeof msg_buf,
-					 "compression method %s not configured",
-					 compress_name);
-				message = msg_buf;
-			}
+			pr_err("compression method %s not configured\n",
+			       compress_name);
+			error("decompressor failed");
 		} else
 			error("invalid magic at start of compressed archive");
 		if (state != Reset)
-- 
2.43.0


