Return-Path: <linux-fsdevel+bounces-401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0837CA80E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BBEB20FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9027730;
	Mon, 16 Oct 2023 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bDWK0juB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5ccWy6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1131273E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:32:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BCF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5744C21958;
	Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697459565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1jFvbv4hA/1toVo6u3oxunZc5j+r4/Tpabndl9eowA=;
	b=bDWK0juBPHdAxNbo6faw96Dq6vU80lGHAOhfOvoJNscSR9ZgFS0ITnXwu85Ll2j0FzEjPm
	ZIL12N7RtZRKYi/0tRXTzwkJf1oCMcFTJ/ZvXXj/6/uDe1DSMMAyIC+Vp2x0r37VrQ+unO
	g9odbbvM6pkrKyFh72mwkVQgHtOL5xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697459565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1jFvbv4hA/1toVo6u3oxunZc5j+r4/Tpabndl9eowA=;
	b=v5ccWy6Nif8pOuMXXlXI4xElV98T/R9DIgnXjCNLt75uVlxqVE6g2hwfjp55VjPqe0qs26
	Ia0Kd/D7fDl5sqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43A96133B7;
	Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id F6dZEG0tLWVUHwAAMHmgww
	(envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 12:32:45 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Cc: Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com,
	mszeredi@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] syscalls: accept: Add tst_fd test
Date: Mon, 16 Oct 2023 14:33:19 +0200
Message-ID: <20231016123320.9865-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016123320.9865-1-chrubis@suse.cz>
References: <20231016123320.9865-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 12.00
X-Spamd-Result: default: False [12.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLwca6rbpw4iejis8bsi6)];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-0.998];
	 NEURAL_SPAM_LONG(3.00)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It looks like we return wrong errno on O_PATH file and open_tree() file descriptors.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/accept/.gitignore |  1 +
 testcases/kernel/syscalls/accept/accept01.c |  8 ----
 testcases/kernel/syscalls/accept/accept03.c | 47 +++++++++++++++++++++
 4 files changed, 49 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 53e519639..55396aad8 100644
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
index 000000000..084bedaf4
--- /dev/null
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that accept() returns ENOTSOCK for non-socket file descriptors.
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
+	socklen_t size = sizeof(addr);
+
+	switch (fd->type) {
+	case TST_FD_UNIX_SOCK:
+	case TST_FD_INET_SOCK:
+		return;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL2(accept(fd->fd, (void*)&addr, &size),
+		ENOTSOCK, "accept() on %s", tst_fd_desc(fd));
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
2.41.0


