Return-Path: <linux-fsdevel+bounces-400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A357CA80B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8982814FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14727729;
	Mon, 16 Oct 2023 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7bWTMK6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVYdcofE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5740273CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:32:48 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB9F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E53601F74A;
	Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697459565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG6qEanlcZAFrWtqDvq2DOjtZ/PgnCIAShHsDI4JaDA=;
	b=G7bWTMK6OeJm3c9u7GcSGRGnss2Y3L3N+g+C/h5ivPSYTtv895D+FUD1KoM24C16dRwWYv
	FBapv77jxR/8bnLec8mYcMAV/9gm5qjgsl7PatELvGxpwHqqECc6puOTZ1T40rdqjoBgtT
	HVlyAGlYuAlbVxN9S6YHm6xXrk1hmpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697459565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG6qEanlcZAFrWtqDvq2DOjtZ/PgnCIAShHsDI4JaDA=;
	b=iVYdcofEpNrDhRxzW6jwtJXIB3YHd/Iie27fgBeIdDuEmmm2DZMz7pW6kbPyARzVce0kF9
	CFcMv/1Ffg2FGfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF930133B7;
	Mon, 16 Oct 2023 12:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xlShMW0tLWVWHwAAMHmgww
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
Subject: [PATCH v2 4/4] syscalls: splice07: New splice tst_fd iterator test
Date: Mon, 16 Oct 2023 14:33:20 +0200
Message-ID: <20231016123320.9865-5-chrubis@suse.cz>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 6.90
X-Spamd-Result: default: False [6.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We loop over all possible combinations of file descriptors in the test
and filter out combinations that actually make sense and either block or
attempt to copy data.

The rest of invalid options produce either EINVAL or EBADF and there
does not seem to be any clear pattern to the choices of these two.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice07.c | 85 +++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 55396aad8..3af634c11 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1515,6 +1515,7 @@ splice03 splice03
 splice04 splice04
 splice05 splice05
 splice06 splice06
+splice07 splice07
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 61e979ad6..88a8dff78 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -4,3 +4,4 @@
 /splice04
 /splice05
 /splice06
+/splice07
diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
new file mode 100644
index 000000000..74d3e9c7a
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ */
+#define _GNU_SOURCE
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
+{
+	int exp_errno = EINVAL;
+
+	/* These combinations just hang */
+	if (fd_in->type == TST_FD_PIPE_READ) {
+		switch (fd_out->type) {
+		case TST_FD_FILE:
+		case TST_FD_PIPE_WRITE:
+		case TST_FD_UNIX_SOCK:
+		case TST_FD_INET_SOCK:
+		case TST_FD_MEMFD:
+			return;
+		default:
+		break;
+		}
+	}
+
+	if (fd_out->type == TST_FD_PIPE_WRITE) {
+		switch (fd_in->type) {
+		/* While these combinations succeeed */
+		case TST_FD_FILE:
+		case TST_FD_MEMFD:
+			return;
+		/* And this complains about socket not being connected */
+		case TST_FD_INET_SOCK:
+			return;
+		default:
+		break;
+		}
+	}
+
+	/* These produce EBADF instead of EINVAL */
+	switch (fd_out->type) {
+	case TST_FD_DIR:
+	case TST_FD_DEV_ZERO:
+	case TST_FD_PROC_MAPS:
+	case TST_FD_INOTIFY:
+	case TST_FD_PIPE_READ:
+		exp_errno = EBADF;
+	default:
+	break;
+	}
+
+	if (fd_in->type == TST_FD_PIPE_WRITE)
+		exp_errno = EBADF;
+
+	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
+	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
+		exp_errno = EBADF;
+
+	TST_EXP_FAIL2(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
+		exp_errno, "splice() on %s -> %s",
+		tst_fd_desc(fd_in), tst_fd_desc(fd_out));
+}
+
+static void verify_splice(void)
+{
+	TST_FD_FOREACH(fd_in) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd_in));
+		TST_FD_FOREACH(fd_out)
+			check_splice(&fd_in, &fd_out);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = verify_splice,
+};
-- 
2.41.0


