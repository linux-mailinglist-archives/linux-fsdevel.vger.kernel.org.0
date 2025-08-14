Return-Path: <linux-fsdevel+bounces-57834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD55B25B40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B44564DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1481226D0C;
	Thu, 14 Aug 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0LCyhDQ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oDVE42l4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0LCyhDQ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oDVE42l4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D22576E
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150532; cv=none; b=LGHz32UVddoWc52NzlWrOWwyb1q7+SfcVJxh86GHRZO+Zkq+1o7P95gD7zIXyOZo6dmRULgr//+iVbKFjngS9vWRo4DXm3UfqdkkKn8O9u4DSfyKoN+PSsE9zxdn8jHWiZMx+whNMbyNzNGFGbAAZmNPKLvnPsgvuuedYQONOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150532; c=relaxed/simple;
	bh=8iEMOUgevb7D7UbQKo3u95ICyaLuLlZmoy6yd8JtojY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enIA7bTqGYY6iJBb3Ph6P0za4Ku6FX+3PVyc3y/6JAwOflGl5FRh8eIeVyrCVl9aIRXb39C25Gali+hmgSXrU44CAP1IhnG5vXKgG4xBbNZ5r8Qi2iP0yFHxHRwYjXKhx9922pUJ2KzWUtrfVKIeby3PlpGW92l+Vqm63C2UMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0LCyhDQ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oDVE42l4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0LCyhDQ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oDVE42l4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB89921B2B;
	Thu, 14 Aug 2025 05:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yrDH9Ni57tPz3BsabzDXrZ59llVGyMyh1ch+c/vYc=;
	b=0LCyhDQ/Qu+PNcIHW6UlXikXR65n3aNBj3CbS1vJrLkjozXCbJTaC6YgcNbyN7Pyq/MEzE
	1E66nl339F7+vamiyx1avLDIixPjaw5qUbrVNaIBxcLihTO6SEePUlvqVFbegQPqqIEhb1
	btbUH3uOTe9W/x8/j4d5teSk//fQQYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yrDH9Ni57tPz3BsabzDXrZ59llVGyMyh1ch+c/vYc=;
	b=oDVE42l4IO/3Ze0eKsgALfivQI5eoxbs9KzTDh2i7YQxPx7QQus1H29QXXqGmyguT73MUI
	dFxicy56qGUFFYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yrDH9Ni57tPz3BsabzDXrZ59llVGyMyh1ch+c/vYc=;
	b=0LCyhDQ/Qu+PNcIHW6UlXikXR65n3aNBj3CbS1vJrLkjozXCbJTaC6YgcNbyN7Pyq/MEzE
	1E66nl339F7+vamiyx1avLDIixPjaw5qUbrVNaIBxcLihTO6SEePUlvqVFbegQPqqIEhb1
	btbUH3uOTe9W/x8/j4d5teSk//fQQYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0yrDH9Ni57tPz3BsabzDXrZ59llVGyMyh1ch+c/vYc=;
	b=oDVE42l4IO/3Ze0eKsgALfivQI5eoxbs9KzTDh2i7YQxPx7QQus1H29QXXqGmyguT73MUI
	dFxicy56qGUFFYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DA4213479;
	Thu, 14 Aug 2025 05:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIkaLr54nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:46 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 4/7] gen_init_cpio: avoid duplicate strlen calls
Date: Thu, 14 Aug 2025 15:18:02 +1000
Message-ID: <20250814054818.7266-5-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>
References: <20250814054818.7266-1-ddiss@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

We determine the filename length for the cpio header, so shouldn't
recalculate it when writing out the filename.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 64421d410a88b..40f4cbd95844e 100644
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
 
 	if (len != CPIO_HDR_LEN
-	 || push_rest(name) < 0
+	 || push_rest(CPIO_TRAILER, namesize) < 0
 	 || push_pad(padlen(offset, 512)) < 0)
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
 
 	if (len != CPIO_HDR_LEN
-	 || push_string(name) < 0
+	 || push_buf(name, namesize) < 0
 	 || push_pad(padlen(offset, 4)) < 0
-	 || push_string(target) < 0
+	 || push_buf(target, targetsize) < 0
 	 || push_pad(padlen(offset, 4)) < 0)
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
 
 	if (len != CPIO_HDR_LEN
-	 || push_rest(name) < 0)
+	 || push_rest(name, namesize) < 0)
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
 
 	if (len != CPIO_HDR_LEN
-	 || push_rest(name) < 0)
+	 || push_rest(name, namesize) < 0)
 		return -1;
 
 	return 0;
@@ -426,7 +434,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		offset += len;
 
 		if (len != CPIO_HDR_LEN
-		 || push_string(name) < 0
+		 || push_buf(name, namesize) < 0
 		 || push_pad(padlen(offset, 4)) < 0)
 			goto error;
 
-- 
2.43.0


