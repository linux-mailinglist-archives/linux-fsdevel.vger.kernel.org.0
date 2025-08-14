Return-Path: <linux-fsdevel+bounces-57833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D3B25B47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6A18867A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB242222566;
	Thu, 14 Aug 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VzvFL3D9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SUYsO34G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pk4pGBp5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J9wQIZA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E942222AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150530; cv=none; b=hut2Kfs77KMWtEbBRLyi5XRHxCvbIhkAMSGQ/nBf4nLomyIxEnpArFLMTFaBh0+CbhTFVLbKyL2Z8cTzPkud07pgsyI2PwW9jtoag7ajIhBjBfd/sKj0ItgEeyayeyG+iAQ6Bh4U/Uqp72jBuXty3t9fS3KQCRnAH7I3QbYuP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150530; c=relaxed/simple;
	bh=Fwrcyxu8kJdHnWAMTtCF44OoDI97wppcxyl/lEIKZBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjohqFR9N+0FHbTzkwVWSrAVxlLeCp1znzFqkEaR4gnGu677exHh05ONmO/n8OCW1BieqSX78QlwVHtDfdPtBV3U0Hn7z08tXnfQAtzTGPs5XK+VGcd8LdeO/SzSrFkto+FvltejWJ3km4u/KgOXj9JeAmr3DHWJ/FQeb9I6LoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VzvFL3D9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SUYsO34G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pk4pGBp5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J9wQIZA3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2D4D1F7CB;
	Thu, 14 Aug 2025 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kcG0fAQ5RnsVdGcWgFchjbLpN/XsiaWG8Cc0su+JNA=;
	b=VzvFL3D98GXFZ9+e23TQAtdRzVWFx65ZidHvRAjwWhajFEXqLoOEhcpy5i4IeDKEYtxhXs
	MwDAIdJDg78ZZJCuDXMXWmm90QH2QXppXJLwY6ncoA4DWZGO1Wzr3yclY6UEMr9DyBZ7z1
	teGmXP/o2/+P+8ktkNtPP54oZMeokqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kcG0fAQ5RnsVdGcWgFchjbLpN/XsiaWG8Cc0su+JNA=;
	b=SUYsO34G2e/AMZPTA+q579xYgbn+og65NJH5kTV90vXOTnOg9g1DwSQVX1VzS4wzQW3Y/f
	UmIUqDpb/HkwwODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kcG0fAQ5RnsVdGcWgFchjbLpN/XsiaWG8Cc0su+JNA=;
	b=pk4pGBp5+NVRUFr8QfQ1l6FCPukCyML1ynugCVXj/Dy/4UoPsq/LktJXwHm/q3XwWu17w9
	oezNLkNShj2+auTAP4hAeqcnX8o6wJQRI0u7lShEG6z14EOKEis8dYPy1sdSA8h8KmuFIr
	mHH3vIyGEe3wY/DrF2lxXYyoKmrDzrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kcG0fAQ5RnsVdGcWgFchjbLpN/XsiaWG8Cc0su+JNA=;
	b=J9wQIZA3pNdgXDfdKM2anldTdy9f1EwikCKZUl7seNAe4/S9fF+8S8/twbiZ5AzIdbbJen
	UcPHzSWRelAxnRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 434FF13479;
	Thu, 14 Aug 2025 05:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CPc4O7d4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:39 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/7] gen_init_cpio: write to fd instead of stdout stream
Date: Thu, 14 Aug 2025 15:17:59 +1000
Message-ID: <20250814054818.7266-2-ddiss@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -6.80

In preparation for more efficient archiving using copy_file_range(),
switch from writing archive data to stdout to using STDOUT_FILENO and
I/O via write(), dprintf(), etc.
Basic I/O error handling is added to cover cases such as ENOSPC. Partial
writes are treated as errors.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 139 ++++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 58 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index edcdb8abfa31c..d8779fe4b8f1f 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -23,64 +23,71 @@
 #define xstr(s) #s
 #define str(s) xstr(s)
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
+#define CPIO_HDR_LEN 110
+#define padlen(_off, _align) (((_align) - ((_off) & ((_align) - 1))) % (_align))
 
+static char padding[512];
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
 static bool do_file_mtime;
 static bool do_csum = false;
+static int outfd = STDOUT_FILENO;
 
 struct file_handler {
 	const char *type;
 	int (*handler)(const char *line);
 };
 
-static void push_string(const char *name)
+static int push_string(const char *name)
 {
 	unsigned int name_len = strlen(name) + 1;
+	ssize_t len;
+
+	len = write(outfd, name, name_len);
+	if (len != name_len)
+		return -1;
 
-	fputs(name, stdout);
-	putchar(0);
 	offset += name_len;
+	return 0;
 }
 
-static void push_pad (void)
+static int push_pad(size_t padlen)
 {
-	while (offset & 3) {
-		putchar(0);
-		offset++;
-	}
+	ssize_t len = 0;
+
+	if (!padlen)
+		return 0;
+
+	if (padlen < sizeof(padding))
+		len = write(outfd, padding, padlen);
+	if (len != padlen)
+		return -1;
+
+	offset += padlen;
+	return 0;
 }
 
-static void push_rest(const char *name)
+static int push_rest(const char *name)
 {
 	unsigned int name_len = strlen(name) + 1;
-	unsigned int tmp_ofs;
+	ssize_t len;
 
-	fputs(name, stdout);
-	putchar(0);
-	offset += name_len;
+	len = write(outfd, name, name_len);
+	if (len != name_len)
+		return -1;
 
-	tmp_ofs = name_len + 110;
-	while (tmp_ofs & 3) {
-		putchar(0);
-		offset++;
-		tmp_ofs++;
-	}
-}
+	offset += name_len;
 
-static void push_hdr(const char *s)
-{
-	fputs(s, stdout);
-	offset += 110;
+	return push_pad(padlen(name_len + CPIO_HDR_LEN, 4));
 }
 
-static void cpio_trailer(void)
+static int cpio_trailer(void)
 {
-	char s[256];
 	const char name[] = "TRAILER!!!";
+	int len;
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
 		0,			/* ino */
@@ -96,23 +103,24 @@ static void cpio_trailer(void)
 		0,			/* rminor */
 		(unsigned)strlen(name)+1, /* namesize */
 		0);			/* chksum */
-	push_hdr(s);
-	push_rest(name);
+	offset += len;
 
-	while (offset % 512) {
-		putchar(0);
-		offset++;
-	}
+	if (len != CPIO_HDR_LEN
+	 || push_rest(name) < 0
+	 || push_pad(padlen(offset, 512)) < 0)
+		return -1;
+
+	return 0;
 }
 
 static int cpio_mkslink(const char *name, const char *target,
 			 unsigned int mode, uid_t uid, gid_t gid)
 {
-	char s[256];
+	int len;
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
@@ -128,12 +136,17 @@ static int cpio_mkslink(const char *name, const char *target,
 		0,			/* rminor */
 		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
-	push_hdr(s);
-	push_string(name);
-	push_pad();
-	push_string(target);
-	push_pad();
+	offset += len;
+
+	if (len != CPIO_HDR_LEN
+	 || push_string(name) < 0
+	 || push_pad(padlen(offset, 4)) < 0
+	 || push_string(target) < 0
+	 || push_pad(padlen(offset, 4)) < 0)
+		return -1;
+
 	return 0;
+
 }
 
 static int cpio_mkslink_line(const char *line)
@@ -157,11 +170,11 @@ static int cpio_mkslink_line(const char *line)
 static int cpio_mkgeneric(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
-	char s[256];
+	int len;
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
@@ -177,8 +190,12 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		0,			/* rminor */
 		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
-	push_hdr(s);
-	push_rest(name);
+	offset += len;
+
+	if (len != CPIO_HDR_LEN
+	 || push_rest(name) < 0)
+		return -1;
+
 	return 0;
 }
 
@@ -246,7 +263,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid, char dev_type,
 		       unsigned int maj, unsigned int min)
 {
-	char s[256];
+	int len;
 
 	if (dev_type == 'b')
 		mode |= S_IFBLK;
@@ -255,7 +272,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
@@ -271,8 +288,12 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		min,			/* rminor */
 		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
-	push_hdr(s);
-	push_rest(name);
+	offset += len;
+
+	if (len != CPIO_HDR_LEN
+	 || push_rest(name) < 0)
+		return -1;
+
 	return 0;
 }
 
@@ -324,11 +345,9 @@ static int cpio_mkfile(const char *name, const char *location,
 			unsigned int mode, uid_t uid, gid_t gid,
 			unsigned int nlinks)
 {
-	char s[256];
 	struct stat buf;
 	unsigned long size;
-	int file;
-	int retval;
+	int file, retval, len;
 	int rc = -1;
 	time_t mtime;
 	int namesize;
@@ -386,7 +405,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+		len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 		       "%08lX%08X%08X%08X%08X%08X%08X",
 			do_csum ? "070702" : "070701", /* magic */
 			ino,			/* ino */
@@ -402,9 +421,12 @@ static int cpio_mkfile(const char *name, const char *location,
 			0,			/* rminor */
 			namesize,		/* namesize */
 			size ? csum : 0);	/* chksum */
-		push_hdr(s);
-		push_string(name);
-		push_pad();
+		offset += len;
+
+		if (len != CPIO_HDR_LEN
+		 || push_string(name) < 0
+		 || push_pad(padlen(offset, 4)) < 0)
+			goto error;
 
 		while (size) {
 			unsigned char filebuf[65536];
@@ -417,14 +439,15 @@ static int cpio_mkfile(const char *name, const char *location,
 				goto error;
 			}
 
-			if (fwrite(filebuf, this_read, 1, stdout) != 1) {
+			if (write(outfd, filebuf, this_read) != this_read) {
 				fprintf(stderr, "writing filebuf failed\n");
 				goto error;
 			}
 			offset += this_read;
 			size -= this_read;
 		}
-		push_pad();
+		if (push_pad(padlen(offset, 4)) < 0)
+			goto error;
 
 		name += namesize;
 	}
@@ -691,7 +714,7 @@ int main (int argc, char *argv[])
 		}
 	}
 	if (ec == 0)
-		cpio_trailer();
+		ec = cpio_trailer();
 
 	exit(ec);
 }
-- 
2.43.0


