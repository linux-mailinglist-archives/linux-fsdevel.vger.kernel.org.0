Return-Path: <linux-fsdevel+bounces-33607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DFD9BB767
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB79A1F22F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017F1B6CE4;
	Mon,  4 Nov 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2B+djzp+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nLB7X39W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2B+djzp+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nLB7X39W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5B1B532F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729901; cv=none; b=iR66MY8Jn/0HI2aAGLUNc0Cz1KHqyA0vBTLwqrZEddyGpzfCmzb5voWmMWKyEnK2zJAxOKCGSf6G3a9GtJeRaZYIRsKG4Vhy/CK1n2F5ES5R3zfBR61sCndAAeuZ/MFDahNorgiUEP3sVEqbr1so4Ahc1+6HVnORkBX12h2bN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729901; c=relaxed/simple;
	bh=r4sq3LI7v7kwFFXYAxXz5vmFrRMftt3nBQybD1gjXjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s94mqTZrecI+nzaJ0a3r89GWQ+QJZ/mcbau95TZTY+7zxucD73dQahGB49jwGPCWFMy2a2kQ98TUNWGUnhn8Zldnzwo2wTKrAD9M7CKiQ37Clq1384DP21z9p2waqpy/5EcJkz1d053t8Lio98CKXS8W+srzUYZjmmc2Go8jHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2B+djzp+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nLB7X39W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2B+djzp+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nLB7X39W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8776A1F7DD;
	Mon,  4 Nov 2024 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=2B+djzp+mA/6IK3SV3n/Pd/WGyiL3proTYOmwf/JWsD3CVvLkQT0jQ78rSgSAJnt+nhBXE
	xP8bNgym3RP0op53Agqe2mfX3qRuDOtXthX2ZM7CxGQ7jswNLpuXcoUknW2Hb4NjnKpeLL
	PIOnO7zJfgh0qTKQx1wsCy+S4rbwoq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=nLB7X39WIHAE83WNmVNkS02SEHgXDN1DRub2cj0dwhD/b778zqc7rb33LoJDwcAOH9t/rv
	8CMeR1ApprXtuVBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2B+djzp+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nLB7X39W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=2B+djzp+mA/6IK3SV3n/Pd/WGyiL3proTYOmwf/JWsD3CVvLkQT0jQ78rSgSAJnt+nhBXE
	xP8bNgym3RP0op53Agqe2mfX3qRuDOtXthX2ZM7CxGQ7jswNLpuXcoUknW2Hb4NjnKpeLL
	PIOnO7zJfgh0qTKQx1wsCy+S4rbwoq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=nLB7X39WIHAE83WNmVNkS02SEHgXDN1DRub2cj0dwhD/b778zqc7rb33LoJDwcAOH9t/rv
	8CMeR1ApprXtuVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B61D813736;
	Mon,  4 Nov 2024 14:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SKi9GqjXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:16 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 6/9] initramfs: merge header_buf and name_buf
Date: Tue,  5 Nov 2024 01:14:45 +1100
Message-ID: <20241104141750.16119-7-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 8776A1F7DD
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

header_buf is only used in FSM states up to GotHeader, while name_buf is
only used in states following GotHeader (Collect is shared, but the
collect pointer tracks each buffer). These buffers can therefore be
combined into a single cpio_buf, which can be used for both header and
file name storage.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 59b4a43fa491b..4e2506a4bc76f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -250,11 +250,11 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *name_buf;
+static __initdata char *cpio_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, CPIO_HDRLEN, GotHeader);
+	read_into(cpio_buf, CPIO_HDRLEN, GotHeader);
 	return 0;
 }
 
@@ -294,14 +294,14 @@ static int __init do_header(void)
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
 
@@ -511,11 +511,16 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(CPIO_HDRLEN, GFP_KERNEL);
-	/* 2x PATH_MAX as @name_buf is also used for staging symlink targets */
-	name_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
-	if (!header_buf || !name_buf)
-		panic_show_mem("can't allocate buffers");
+	/*
+	 * @cpio_buf can be used for staging the 110 byte newc/crc cpio header,
+	 * after which parse_header() converts and stashes fields into
+	 * corresponding types. The same buffer can then be reused for file
+	 * path staging. 2 x PATH_MAX covers any possible symlink target.
+	 */
+	BUILD_BUG_ON(CPIO_HDRLEN > N_ALIGN(PATH_MAX) + PATH_MAX + 1);
+	cpio_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!cpio_buf)
+		panic_show_mem("can't allocate buffer");
 
 	state = Start;
 	this_header = 0;
@@ -559,8 +564,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
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


