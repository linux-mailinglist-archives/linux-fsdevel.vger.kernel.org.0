Return-Path: <linux-fsdevel+bounces-7940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FB82D922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E9282E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2702168BB;
	Mon, 15 Jan 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TWfMI0Ht";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWIjA+AG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TWfMI0Ht";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWIjA+AG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAED14F8C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17D221FD36;
	Mon, 15 Jan 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
	b=TWfMI0HtIVA9MIvfOg/JFV+XYy9HdzmO1mbe+dGRyYlkqv8J54JslTPYv9enCYnk/vwFrS
	YV4hIW4PMwGxlvHCkn+8kCEa13AksUvambT5nil6RQNIA25OSHL1YIEDseQnMjGAr7eGpd
	/uhWN6IxgzFUs+iUmHWq3yyt/dvoaAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
	b=tWIjA+AGSN0sjwcPxOyBsZsqi9bs9Z+dxUeyum9vq51K5QAYdxF4RcB1RstFnFGmYGkFGe
	7xFSFJTOTt77UBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
	b=TWfMI0HtIVA9MIvfOg/JFV+XYy9HdzmO1mbe+dGRyYlkqv8J54JslTPYv9enCYnk/vwFrS
	YV4hIW4PMwGxlvHCkn+8kCEa13AksUvambT5nil6RQNIA25OSHL1YIEDseQnMjGAr7eGpd
	/uhWN6IxgzFUs+iUmHWq3yyt/dvoaAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMYGoEo+sMvfo1eg8aUY/kv/N44CSJBYuXa/vHZJSMA=;
	b=tWIjA+AGSN0sjwcPxOyBsZsqi9bs9Z+dxUeyum9vq51K5QAYdxF4RcB1RstFnFGmYGkFGe
	7xFSFJTOTt77UBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0BCC13751;
	Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i7nAOcQqpWWZVQAAD6G6ig
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
	Richard Palethorpe <rpalethorpe@suse.com>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v3 4/4] syscalls: splice07: New splice tst_fd iterator test
Date: Mon, 15 Jan 2024 13:53:51 +0100
Message-ID: <20240115125351.7266-5-chrubis@suse.cz>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

We loop over all possible combinations of file descriptors in the test
and filter out combinations that actually make sense and either block or
attempt to copy data.

The rest of invalid options produce either EINVAL or EBADF.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice07.c | 70 +++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5472c954b..6e2407879 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1516,6 +1516,7 @@ splice03 splice03
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
index 000000000..135c42e47
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Iterate over all kinds of file descriptors and feed splice() with all possible
+ * combinations where at least one file descriptor is invalid. We do expect the
+ * syscall to fail either with EINVAL or EBADF.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
+{
+	/* These combinations just hang since the pipe is empty */
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
+	const int exp_errnos[] = {EBADF, EINVAL};
+
+	TST_EXP_FAIL2_ARR(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
+		exp_errnos, "splice() on %s -> %s",
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
2.43.0


