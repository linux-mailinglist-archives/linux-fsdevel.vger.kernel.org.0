Return-Path: <linux-fsdevel+bounces-57835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8983B25B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E84C887072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653A227B9F;
	Thu, 14 Aug 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bActRxYv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5YVVCBbF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bActRxYv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5YVVCBbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C802222AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150537; cv=none; b=FS12vIqCn8dpkFBSjr9xk/FWiduPW3nNhQTp68h1LuewKXJ0+iAR+47a75xHEXxZCgDLNo7d7492/RPALQkXzxGGcs4CT2rR8o7qfOiGJXf4P37uWOeTqPnYqWk+MPBD5fnH+rN8ss4u92Og/56tUwlbf8S1npFeWUcDDm3LAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150537; c=relaxed/simple;
	bh=GGrohtwC6NbDUwDq9BT3jJaIAlNnzGJZIG4kt0idbSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkuSMgrGeP/joIaCjEATa+Y65BuCH2RaCv/+4ea9wpgO7n4S/lbxPK08dGOz6nkrcOalXIzmimvr1UJXXlIU5iTiDujXZintRL57UewUy0jLoBVyP7RR8c2WYWnHPMqW1cnVyXf/Z91Ol0xL2BrGLg1McFVlmitrmGJlKYYW8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bActRxYv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5YVVCBbF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bActRxYv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5YVVCBbF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 483EF1F7CD;
	Thu, 14 Aug 2025 05:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvZ1fIen0Q9X3JJDvdn7/FlFTERaK5IQyVgY5iDRbF0=;
	b=bActRxYvJenQBkTYZnR4txqLk1mC3lRgbOZcL+us1m1+1s0P/dQ741WfbhcwqD1qN/64UC
	o0dcPNDPws1tlU4JMbwbD8uK3u+wYaG4rczrK6g8eCSnX4knmQiZPPAF91rc4nmBoKk5Ea
	pp86ymBBUPtpRxKS9u9XMhFSFrWaWYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvZ1fIen0Q9X3JJDvdn7/FlFTERaK5IQyVgY5iDRbF0=;
	b=5YVVCBbFbRsa5ox52blxc9Qb1fuMKIZ6M+xt0SYshHgety5LMwiEmpffgz8E5Dtl3fCTbV
	n1WBrkCpasOq8LAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvZ1fIen0Q9X3JJDvdn7/FlFTERaK5IQyVgY5iDRbF0=;
	b=bActRxYvJenQBkTYZnR4txqLk1mC3lRgbOZcL+us1m1+1s0P/dQ741WfbhcwqD1qN/64UC
	o0dcPNDPws1tlU4JMbwbD8uK3u+wYaG4rczrK6g8eCSnX4knmQiZPPAF91rc4nmBoKk5Ea
	pp86ymBBUPtpRxKS9u9XMhFSFrWaWYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvZ1fIen0Q9X3JJDvdn7/FlFTERaK5IQyVgY5iDRbF0=;
	b=5YVVCBbFbRsa5ox52blxc9Qb1fuMKIZ6M+xt0SYshHgety5LMwiEmpffgz8E5Dtl3fCTbV
	n1WBrkCpasOq8LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838A713479;
	Thu, 14 Aug 2025 05:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOZMD7p4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:42 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/7] gen_init_cpio: support -o <output_path> parameter
Date: Thu, 14 Aug 2025 15:18:00 +1000
Message-ID: <20250814054818.7266-3-ddiss@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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

This is another preparatory change to allow for reflink-optimized
cpio archives with file data written / cloned via copy_file_range().
The output file is truncated prior to write, so that it maps to
usr/gen_initramfs.sh usage. It may make sense to offer an append option
in future, for easier archive concatenation.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index d8779fe4b8f1f..563594a0662a6 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -110,7 +110,7 @@ static int cpio_trailer(void)
 	 || push_pad(padlen(offset, 512)) < 0)
 		return -1;
 
-	return 0;
+	return fsync(outfd);
 }
 
 static int cpio_mkslink(const char *name, const char *target,
@@ -532,7 +532,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] [-c] <cpio_list>\n"
+		"\t%s [-t <timestamp>] [-c] [-o <output_path>] <cpio_list>\n"
 		"\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
@@ -569,7 +569,8 @@ static void usage(const char *prog)
 		"as mtime for symlinks, directories, regular and special files.\n"
 		"The default is to use the current time for all files, but\n"
 		"preserve modification time for regular files.\n"
-		"-c: calculate and store 32-bit checksums for file data.\n",
+		"-c: calculate and store 32-bit checksums for file data.\n"
+		"<output_path>: write cpio to this file instead of stdout\n",
 		prog);
 }
 
@@ -611,7 +612,7 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:ch");
+		int opt = getopt(argc, argv, "t:cho:");
 		char *invalid;
 
 		if (opt == -1)
@@ -630,6 +631,16 @@ int main (int argc, char *argv[])
 		case 'c':
 			do_csum = true;
 			break;
+		case 'o':
+			outfd = open(optarg,
+				     O_WRONLY | O_CREAT | O_LARGEFILE | O_TRUNC,
+				     0600);
+			if (outfd < 0) {
+				fprintf(stderr, "failed to open %s\n", optarg);
+				usage(argv[0]);
+				exit(1);
+			}
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
-- 
2.43.0


