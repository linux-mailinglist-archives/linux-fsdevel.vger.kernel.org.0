Return-Path: <linux-fsdevel+bounces-7939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319982D91F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C36F1C2179A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A5168A9;
	Mon, 15 Jan 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOOApOhS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQm8Gjnw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOOApOhS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQm8Gjnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771114293
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A37B0221BD;
	Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3raBL7YpNcPZiGs4WewFSU9rocqghd8EDtC6wQ3tk=;
	b=YOOApOhSCvpXzGX5LWwT3WkCovtlyD1MJZTch5p9qcYSWEqojpmIxMt2r/jBA0uohLkZTQ
	Xk7lchQ8hB1Bo8X62JjHrM31yg2sHEqx6WwOdLGEluTtrMudV/5QYB8xn3VcpPs8n385Lm
	jx3kDO8J0r1rSEEajZLCKARQhNRaYI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3raBL7YpNcPZiGs4WewFSU9rocqghd8EDtC6wQ3tk=;
	b=UQm8GjnwFxuw+9b7VLAfO0vovtpsG172LfzLgmhey4KYhhiJDXyqRUsqvI0sjBHd6Uel0Y
	Jmqm7li1P+YigRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3raBL7YpNcPZiGs4WewFSU9rocqghd8EDtC6wQ3tk=;
	b=YOOApOhSCvpXzGX5LWwT3WkCovtlyD1MJZTch5p9qcYSWEqojpmIxMt2r/jBA0uohLkZTQ
	Xk7lchQ8hB1Bo8X62JjHrM31yg2sHEqx6WwOdLGEluTtrMudV/5QYB8xn3VcpPs8n385Lm
	jx3kDO8J0r1rSEEajZLCKARQhNRaYI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3raBL7YpNcPZiGs4WewFSU9rocqghd8EDtC6wQ3tk=;
	b=UQm8GjnwFxuw+9b7VLAfO0vovtpsG172LfzLgmhey4KYhhiJDXyqRUsqvI0sjBHd6Uel0Y
	Jmqm7li1P+YigRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9216613751;
	Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NmatIsQqpWWWVQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Cc: Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com,
	mszeredi@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 3/4] syscalls: accept: Add tst_fd test
Date: Mon, 15 Jan 2024 13:53:50 +0100
Message-ID: <20240115125351.7266-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115125351.7266-1-chrubis@suse.cz>
References: <20240115125351.7266-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YOOApOhS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UQm8Gjnw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLuggmp1sxrj4d1wjxmfchp9q5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: A37B0221BD
X-Spam-Flag: NO

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/accept/.gitignore |  1 +
 testcases/kernel/syscalls/accept/accept01.c |  8 ---
 testcases/kernel/syscalls/accept/accept03.c | 60 +++++++++++++++++++++
 4 files changed, 62 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8216d86b0..5472c954b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -3,6 +3,7 @@ abort01 abort01
 
 accept01 accept01
 accept02 accept02
+accept03 accept03
 
 accept4_01 accept4_01
 
diff --git a/testcases/kernel/syscalls/accept/.gitignore b/testcases/kernel/syscalls/accept/.gitignore
index 5b1462699..f81d4bec9 100644
--- a/testcases/kernel/syscalls/accept/.gitignore
+++ b/testcases/kernel/syscalls/accept/.gitignore
@@ -1,2 +1,3 @@
 /accept01
 /accept02
+/accept03
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 85af0f8af..e5db1dfec 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -26,7 +26,6 @@
 struct sockaddr_in sin0, sin1, fsin1;
 
 int invalid_socketfd = 400; /* anything that is not an open file */
-int devnull_fd;
 int socket_fd;
 int udp_fd;
 
@@ -45,10 +44,6 @@ static struct test_case {
 		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
 		"bad file descriptor"
 	},
-	{
-		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
-		sizeof(fsin1), ENOTSOCK, "fd is not socket"
-	},
 	{
 		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
 		sizeof(fsin1), EINVAL, "invalid socket buffer"
@@ -73,8 +68,6 @@ static void test_setup(void)
 	sin0.sin_port = 0;
 	sin0.sin_addr.s_addr = INADDR_ANY;
 
-	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
-
 	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
 
@@ -88,7 +81,6 @@ static void test_setup(void)
 
 static void test_cleanup(void)
 {
-	SAFE_CLOSE(devnull_fd);
 	SAFE_CLOSE(socket_fd);
 	SAFE_CLOSE(udp_fd);
 }
diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
new file mode 100644
index 000000000..b85ec0d9b
--- /dev/null
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that accept() returns ENOTSOCK or EBADF for non-socket file
+ * descriptors. The EBADF is returned in the case that the file descriptor has
+ * not a file associated with it, which is for example in the case of O_PATH
+ * opened file.
+ */
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+void check_accept(struct tst_fd *fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = 0,
+		.sin_addr = {.s_addr = INADDR_ANY},
+	};
+
+	socklen_t size = sizeof(addr);
+
+	int exp_errno = ENOTSOCK;
+
+	switch (fd->type) {
+	case TST_FD_UNIX_SOCK:
+	case TST_FD_INET_SOCK:
+		return;
+	/*
+	 * With these two we fail even before we get to the do_accept() because
+	 * the fd does not have a struct file associated.
+	 */
+	case TST_FD_OPEN_TREE:
+	case TST_FD_PATH:
+		exp_errno = EBADF;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL2(accept(fd->fd, (void*)&addr, &size),
+		exp_errno, "accept() on %s", tst_fd_desc(fd));
+}
+
+static void verify_accept(void)
+{
+	TST_FD_FOREACH(fd)
+		check_accept(&fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_accept,
+};
-- 
2.43.0


