Return-Path: <linux-fsdevel+bounces-58242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2DB2B806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690241881F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893525EF81;
	Tue, 19 Aug 2025 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j63QoSB7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sQuBBuu+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DD2WIiAt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kr2zPdhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4462D839C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575432; cv=none; b=AVLNfocI/t0x7d2YO8Qtz1MI30KwPsCCcQ38vdgdVH6U5GhJYMC0PivmGnYZIgoEd/LWyVrsBO166GM4u+oINBkYq9pTkoJ1E1V5X5fu7Ql0gskMZHVa72II/Al0F3aMdvWLvhThHrFAyxl7cFpa8lkxu6U2E0u9TbAkqYm0kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575432; c=relaxed/simple;
	bh=/8GqTouvpICO3rq8wyUVLvRahyM05Hooc+oHUOGuVq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGk1nI2IPR2b4OSQoMPIS9Ihp9l0ej+3MOHn2hqljSu6Ai/TrX8/fOhGorEdLfEeJlj53rMOsr9KFSnZoLSaRqtCTZjzcBM73aEPX3D/F8l1zdExJXTI8pHUMYcpRx+MOTurhUejYwZYk6PdoP9jk94Hpaq9jMOOMSdZOYiIoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j63QoSB7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sQuBBuu+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DD2WIiAt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kr2zPdhF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32F682126B;
	Tue, 19 Aug 2025 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvemnRgmpNJUIGNceWAMhu36Hgm3Z0Mi60ibkK3Z2u4=;
	b=j63QoSB7DP9bZ1BUkn1wLjXvysmP/6SOcwzsUHtaCBRPifhwN5ZhdWIQu1sBznk+VyKGK2
	Awpb5uSazzh/RaRsVfGuaid8A0fXmMeqkuB9ty+W1yzvqotwRLp4JUSvcC9yrPVUUDoOuH
	QJooKaRYoInBHHgE0vu3RMDOcOZXpJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvemnRgmpNJUIGNceWAMhu36Hgm3Z0Mi60ibkK3Z2u4=;
	b=sQuBBuu+R6zIycqTZM1S8lL55XuejmXQtSQPKLAOQjlNKc9RLEzCGOxMnjYv1YkXgyikqG
	CuAtpTbt1vWMdFDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DD2WIiAt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kr2zPdhF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvemnRgmpNJUIGNceWAMhu36Hgm3Z0Mi60ibkK3Z2u4=;
	b=DD2WIiAtysH/hm1mHlkUIiBsB//18lQn4VwiZ4EJsE5kflDTwTcgJPPJU326yfD3x6k9iM
	4BN+Qd6gtCZn4C/rmJyJtIx2mkMzkXqefgpjLptmQhSTlOHTWfdSZ2D6sHj/o+KqGZ18ED
	ub/F3bXvk8ZZP+V//W/istI2LwiMxbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvemnRgmpNJUIGNceWAMhu36Hgm3Z0Mi60ibkK3Z2u4=;
	b=kr2zPdhF8VEdaMVMlGbSHI8R8WBUXbzIFTBOXI244vNaTIQQ+ixMAJfp61Sf8+9fO/E7wi
	PyaKGFdW574DWDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2610E13686;
	Tue, 19 Aug 2025 03:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MI+UM230o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:50:05 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 4/8] gen_init_cpio: avoid duplicate strlen calls
Date: Tue, 19 Aug 2025 13:05:47 +1000
Message-ID: <20250819032607.28727-5-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819032607.28727-1-ddiss@suse.de>
References: <20250819032607.28727-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 32F682126B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

We determine the filename length for the cpio header, so shouldn't
recalculate it when writing out the filename.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 usr/gen_init_cpio.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index aa73afd3756c8..729585342e16e 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -25,6 +25,7 @@
 #define str(s) xstr(s)
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #define CPIO_HDR_LEN 110
+#define CPIO_TRAILER "TRAILER!!!"
 #define padlen(_off, _align) (((_align) - ((_off) & ((_align) - 1))) % (_align))
 
 static char padding[512];
@@ -40,9 +41,8 @@ struct file_handler {
 	int (*handler)(const char *line);
 };
 
-static int push_string(const char *name)
+static int push_buf(const char *name, size_t name_len)
 {
-	unsigned int name_len = strlen(name) + 1;
 	ssize_t len;
 
 	len = write(outfd, name, name_len);
@@ -69,9 +69,8 @@ static int push_pad(size_t padlen)
 	return 0;
 }
 
-static int push_rest(const char *name)
+static int push_rest(const char *name, size_t name_len)
 {
-	unsigned int name_len = strlen(name) + 1;
 	ssize_t len;
 
 	len = write(outfd, name, name_len);
@@ -85,8 +84,8 @@ static int push_rest(const char *name)
 
 static int cpio_trailer(void)
 {
-	const char name[] = "TRAILER!!!";
 	int len;
+	unsigned int namesize = sizeof(CPIO_TRAILER);
 
 	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
@@ -102,12 +101,12 @@ static int cpio_trailer(void)
 		0,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name)+1, /* namesize */
+		namesize,		/* namesize */
 		0);			/* chksum */
 	offset += len;
 
 	if (len != CPIO_HDR_LEN ||
-	    push_rest(name) < 0 ||
+	    push_rest(CPIO_TRAILER, namesize) < 0 ||
 	    push_pad(padlen(offset, 512)) < 0)
 		return -1;
 
@@ -118,9 +117,12 @@ static int cpio_mkslink(const char *name, const char *target,
 			 unsigned int mode, uid_t uid, gid_t gid)
 {
 	int len;
+	unsigned int namesize, targetsize = strlen(target) + 1;
 
 	if (name[0] == '/')
 		name++;
+	namesize = strlen(name) + 1;
+
 	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
@@ -130,19 +132,19 @@ static int cpio_mkslink(const char *name, const char *target,
 		(long) gid,		/* gid */
 		1,			/* nlink */
 		(long) default_mtime,	/* mtime */
-		(unsigned)strlen(target)+1, /* filesize */
+		targetsize,		/* filesize */
 		3,			/* major */
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		namesize,		/* namesize */
 		0);			/* chksum */
 	offset += len;
 
 	if (len != CPIO_HDR_LEN ||
-	    push_string(name) < 0 ||
+	    push_buf(name, namesize) < 0 ||
 	    push_pad(padlen(offset, 4)) < 0 ||
-	    push_string(target) < 0 ||
+	    push_buf(target, targetsize) < 0 ||
 	    push_pad(padlen(offset, 4)) < 0)
 		return -1;
 
@@ -172,9 +174,12 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
 	int len;
+	unsigned int namesize;
 
 	if (name[0] == '/')
 		name++;
+	namesize = strlen(name) + 1;
+
 	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
@@ -189,12 +194,12 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		namesize,		/* namesize */
 		0);			/* chksum */
 	offset += len;
 
 	if (len != CPIO_HDR_LEN ||
-	    push_rest(name) < 0)
+	    push_rest(name, namesize) < 0)
 		return -1;
 
 	return 0;
@@ -265,6 +270,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		       unsigned int maj, unsigned int min)
 {
 	int len;
+	unsigned int namesize;
 
 	if (dev_type == 'b')
 		mode |= S_IFBLK;
@@ -273,6 +279,8 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
+	namesize = strlen(name) + 1;
+
 	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
@@ -287,12 +295,12 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		1,			/* minor */
 		maj,			/* rmajor */
 		min,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		namesize,		/* namesize */
 		0);			/* chksum */
 	offset += len;
 
 	if (len != CPIO_HDR_LEN ||
-	    push_rest(name) < 0)
+	    push_rest(name, namesize) < 0)
 		return -1;
 
 	return 0;
@@ -426,7 +434,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		offset += len;
 
 		if (len != CPIO_HDR_LEN ||
-		    push_string(name) < 0 ||
+		    push_buf(name, namesize) < 0 ||
 		    push_pad(padlen(offset, 4)) < 0)
 			goto error;
 
-- 
2.43.0


