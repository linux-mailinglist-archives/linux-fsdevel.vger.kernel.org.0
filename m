Return-Path: <linux-fsdevel+bounces-33610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6279BB76B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F6285C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48818595F;
	Mon,  4 Nov 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGH91hMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XMyecr1d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGH91hMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XMyecr1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BB1632C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729910; cv=none; b=ej1BpFKFcPkzuIcaHHI9710tmkn25uL2Xg4t+uRnllMwbpHtFwFRDH2rnnaXPBmqOomVFB2iiXHI3qZiAkgAxkYlQNlexrkdmLWdUw0IquF6PD4zjFTFTBzpudUpPqgRHCVSwv7N0Qz73h0lMOQOVgp94X74vWwjU6TUqhINOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729910; c=relaxed/simple;
	bh=E4bOtcamvsZQyV8i49+tvTolrYnEthbpE/LTW55KkK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFOr7SAocrDTB1nmhoFr4NQDBDxyCYDso4NmS/ADcIArksrl1leHC6kAur3CCR2aWzQZ/JcjPr2kBjrI4Qvpz4K6ODHVG963JUS1ri0ugZhvol8Xxd4072N/ZkL7pGZ7KA/Pos8C+zShuvkj29WliweMV7I6BlmbnXPb0LU9R3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGH91hMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XMyecr1d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGH91hMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XMyecr1d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC6CF1F7DD;
	Mon,  4 Nov 2024 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=jGH91hMJIo5SbzdHdoDBrEJbV5GpzVbCmxBPV7wnaJuC9Q0OwGitkn9EqXhYsEkmbf2guM
	I9wEucyBpwdgvusEgUNqOvjW6oMX+U52XXHTXCBzfoYrgYmiaXKsq7K2r+PRoLJrVqLZLG
	Bx5KuSNMHlDwLMFd1gTKT6B42FjezcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=XMyecr1dk3vcrQvUI2wT9/LLUQs0GOFsNlZH8M6U/DEKPfdmv3zWM2X3o1/eQixA3TvnUC
	2j4D3mXj6NvBEECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jGH91hMJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XMyecr1d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=jGH91hMJIo5SbzdHdoDBrEJbV5GpzVbCmxBPV7wnaJuC9Q0OwGitkn9EqXhYsEkmbf2guM
	I9wEucyBpwdgvusEgUNqOvjW6oMX+U52XXHTXCBzfoYrgYmiaXKsq7K2r+PRoLJrVqLZLG
	Bx5KuSNMHlDwLMFd1gTKT6B42FjezcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNvOOFuGt9tkdf6fAWxzGM7alCqjdS46d9Z5/BWrlE=;
	b=XMyecr1dk3vcrQvUI2wT9/LLUQs0GOFsNlZH8M6U/DEKPfdmv3zWM2X3o1/eQixA3TvnUC
	2j4D3mXj6NvBEECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB97713736;
	Mon,  4 Nov 2024 14:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4BrSI6/XKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:23 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 9/9] initramfs: avoid static buffer for error message
Date: Tue,  5 Nov 2024 01:14:48 +1100
Message-ID: <20241104141750.16119-10-ddiss@suse.de>
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
X-Rspamd-Queue-Id: AC6CF1F7DD
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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


