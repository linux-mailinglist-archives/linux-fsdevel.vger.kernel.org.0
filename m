Return-Path: <linux-fsdevel+bounces-33848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE89BFAB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DB91C21459
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF728802;
	Thu,  7 Nov 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sVkY2S2a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/4+xcUX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sVkY2S2a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/4+xcUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF788BA50;
	Thu,  7 Nov 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938927; cv=none; b=VtxkyW0jD6ftsQ5qzTbtdNof3zOHy+I6KACxzbK8gZV6eIEmpXJbnC56MMV1dOBswxPjUYyMS7DO2Jgi2Vtq2v4WB/SPCmXq+kWHpXlgKq6SXOTM68P4S81/4r0RqcZfKLWnL1Z3ZsOFMQdpqkLMZbxYcIkTxlckGDDgO/W1Jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938927; c=relaxed/simple;
	bh=r4sq3LI7v7kwFFXYAxXz5vmFrRMftt3nBQybD1gjXjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfELDV/tfbuhRZQ80MZrylTWBoMSOIx37bxwSmi9f1c4LL1vrbrMy/KHWlv82WcPVJFGxFDSWcD7nicGwNt0c/3Vs14v+F8J+t2Yx6zeWj1fx9YzJjV0zrgXN6VxEAMefPU4I2AgAEP/QGlya3zjqz+QhCk/uEmmHfhHfifMHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sVkY2S2a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/4+xcUX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sVkY2S2a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/4+xcUX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DD6F21CBD;
	Thu,  7 Nov 2024 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=sVkY2S2aLw2GtTG+08ihVKiiZUcgZ8wY1XHFcjPd5VXkt9/8MuZDCT4JQUs3QOPmPBsHkR
	JM/7YAgZdLYq4hZoSvgq7hwHqfQZWv5Z5hQI21GX80Bt/+1o955zjmEcwnV60nQ9oMHPcv
	wci7E0zF/2iBkeN330xLwbUqUp6buqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=J/4+xcUXYeiCqqujzWSbI5cbCBWcddA+JREao3jMZyhrBqoej55sowhRwCBIU0ZmQ/MhNk
	pmpDrbDUeRpJ9mAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sVkY2S2a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J/4+xcUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=sVkY2S2aLw2GtTG+08ihVKiiZUcgZ8wY1XHFcjPd5VXkt9/8MuZDCT4JQUs3QOPmPBsHkR
	JM/7YAgZdLYq4hZoSvgq7hwHqfQZWv5Z5hQI21GX80Bt/+1o955zjmEcwnV60nQ9oMHPcv
	wci7E0zF/2iBkeN330xLwbUqUp6buqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funV3ntCCjs65WT4XelhOUCAGazAb0yRa0Q2DOqjLZQ=;
	b=J/4+xcUXYeiCqqujzWSbI5cbCBWcddA+JREao3jMZyhrBqoej55sowhRwCBIU0ZmQ/MhNk
	pmpDrbDUeRpJ9mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1DF31394A;
	Thu,  7 Nov 2024 00:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kHtCJSkILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:22:01 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 6/9] initramfs: merge header_buf and name_buf
Date: Thu,  7 Nov 2024 11:17:25 +1100
Message-ID: <20241107002044.16477-8-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 0DD6F21CBD
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


