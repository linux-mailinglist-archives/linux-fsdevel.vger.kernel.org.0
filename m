Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19787B7F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbjJDMqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbjJDMqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:46:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC5C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 05:46:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B603E2183A;
        Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696423589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pad8hg3mqiq7KVkuWJoEhHoGMZyhbam01mzRl/lGIqs=;
        b=LmseKLVyN/nQe/vsWyEixbo+TQsj89cQl+NgsRE2oW1lmP+3kgxfijgl/ES2PXWymSUUmM
        Y2rH17oDll8LSubfe52/DpiZAEHePWcc973T/C1WH3PDaUg+DI7Xy5ecpVuR2xSuo95ku+
        YmMfk+SzFbwwm3XspzmhT/vx55avIB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696423589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pad8hg3mqiq7KVkuWJoEhHoGMZyhbam01mzRl/lGIqs=;
        b=hR9SEoHneh6On1/FWwrqz3BUHW4/M0mDvGSxLasox/mB+RMzo5ZJdjA325fcsqxbTZn6ZX
        5xieGGkHVgqKBdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A001113A2E;
        Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 772qJaVeHWXbPAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:29 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     Matthew Wilcox <willy@infradead.org>, amir73il@gmail.com,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] lib: Add tst_fd_iterate()
Date:   Wed,  4 Oct 2023 14:47:10 +0200
Message-ID: <20231004124712.3833-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Which allows us to call a function on bunch of different file
descriptors.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fd.h   |  39 +++++++++++++++
 include/tst_test.h |   1 +
 lib/tst_fd.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c

diff --git a/include/tst_fd.h b/include/tst_fd.h
new file mode 100644
index 000000000..711e043dd
--- /dev/null
+++ b/include/tst_fd.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_FD_H__
+#define TST_FD_H__
+
+enum tst_fd_type {
+	TST_FD_FILE,
+	TST_FD_DIR,
+	TST_FD_DEV_ZERO,
+	TST_FD_PROC_MAPS,
+	TST_FD_PIPE_IN,
+	TST_FD_PIPE_OUT,
+	TST_FD_UNIX_SOCK,
+	TST_FD_INET_SOCK,
+	TST_FD_IO_URING,
+	TST_FD_BPF_MAP,
+	TST_FD_MAX,
+};
+
+struct tst_fd {
+	enum tst_fd_type type;
+	int fd;
+};
+
+/*
+ * Iterates over all fd types and calls the run_test function for each of them.
+ */
+void tst_fd_iterate(void (*run_test)(struct tst_fd *fd));
+
+/*
+ * Returns human readable name for the file descriptor type.
+ */
+const char *tst_fd_desc(struct tst_fd *fd);
+
+#endif /* TST_FD_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..5eee36bac 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -44,6 +44,7 @@
 #include "tst_taint.h"
 #include "tst_memutils.h"
 #include "tst_arch.h"
+#include "tst_fd.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_fd.c b/lib/tst_fd.c
new file mode 100644
index 000000000..7b6cb767e
--- /dev/null
+++ b/lib/tst_fd.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/io_uring.h"
+#include "lapi/bpf.h"
+
+#include "tst_fd.h"
+
+const char *tst_fd_desc(struct tst_fd *fd)
+{
+	switch (fd->type) {
+	case TST_FD_FILE:
+		return "regular file";
+	case TST_FD_DIR:
+		return "directory";
+	case TST_FD_DEV_ZERO:
+		return "/dev/zero";
+	case TST_FD_PROC_MAPS:
+		return "/proc/self/maps";
+	case TST_FD_PIPE_IN:
+		return "pipe read end";
+	case TST_FD_PIPE_OUT:
+		return "pipe write end";
+	case TST_FD_UNIX_SOCK:
+		return "unix socket";
+	case TST_FD_INET_SOCK:
+		return "inet socket";
+	case TST_FD_IO_URING:
+		return "io_uring";
+	case TST_FD_BPF_MAP:
+		return "bpf map";
+	case TST_FD_MAX:
+	break;
+	}
+
+	return "invalid";
+}
+
+void tst_fd_iterate(void (*run_test)(struct tst_fd *fd))
+{
+	enum tst_fd_type i;
+	struct tst_fd fd;
+	int pipe[2];
+	struct io_uring_params uring_params = {};
+	union bpf_attr array_attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = 1,
+	};
+
+	SAFE_PIPE(pipe);
+
+	for (i = 0; i < TST_FD_MAX; i++) {
+		fd.type = i;
+
+		switch (i) {
+		case TST_FD_FILE:
+			fd.fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT);
+			SAFE_UNLINK("fd_file");
+		break;
+		case TST_FD_DIR:
+			SAFE_MKDIR("fd_dir", 0700);
+			fd.fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
+			SAFE_RMDIR("fd_dir");
+		break;
+		case TST_FD_DEV_ZERO:
+			fd.fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+		break;
+		case TST_FD_PROC_MAPS:
+			fd.fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
+		break;
+		case TST_FD_PIPE_IN:
+			fd.fd = pipe[0];
+		break;
+		case TST_FD_PIPE_OUT:
+			fd.fd = pipe[1];
+		break;
+		case TST_FD_UNIX_SOCK:
+			fd.fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+		break;
+		case TST_FD_INET_SOCK:
+			fd.fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+		break;
+		case TST_FD_IO_URING:
+			fd.fd = io_uring_setup(1, &uring_params);
+			if (fd.fd < 0) {
+				tst_res(TCONF | TERRNO,
+					"Skipping %s", tst_fd_desc(&fd));
+				continue;
+			}
+		break;
+		case TST_FD_BPF_MAP:
+			fd.fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
+			if (fd.fd < 0) {
+				tst_res(TCONF | TERRNO,
+					"Skipping %s", tst_fd_desc(&fd));
+				continue;
+			}
+		break;
+		case TST_FD_MAX:
+		break;
+		}
+
+		run_test(&fd);
+
+		SAFE_CLOSE(fd.fd);
+	}
+}
-- 
2.41.0

