Return-Path: <linux-fsdevel+bounces-7938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF782D91E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E511F211EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368216430;
	Mon, 15 Jan 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZTc0xCaT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6jny1b+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ffT9+otB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wi4iWWQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA212E6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E342F1F88D;
	Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gkor1SgtarxMZ+Qt7npFY955J36ZrdC1eGTk8xoP3Y=;
	b=ZTc0xCaTaARAQJfMR1tMORP3/IxakuGXAsZeiat5yXtI1rHp81RcyS1Tuhy9pwwA5M8ZTc
	QmlSoJNTIlaO6awQP/icTLiEzDaI2o30WizjYADFqwwbcZ5Mb1gYwBBhMuViZtrYJqEQqH
	j4I/rCBk1p5VJ+r1Xn1MNpuBHvUEfUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gkor1SgtarxMZ+Qt7npFY955J36ZrdC1eGTk8xoP3Y=;
	b=W6jny1b+QFlMMHnmxipjP2hq1F3dhWNJU7+gevhbMzMOX89yrarXPvFlFI5cCd/DlN/s8j
	tPNWYFLERf+MV4Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705323203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gkor1SgtarxMZ+Qt7npFY955J36ZrdC1eGTk8xoP3Y=;
	b=ffT9+otBjw7gbsyQJMvjq36r5L01I85UCuPEiakoqlv5JcGHkpg0KfoxAxz4juiVrzDQBa
	T7yxyjXLr3oNVRRGMXCK9j7/3VKpE3T0Rl5nOLgHVhBsRyPGAP43RMy34M24lIywqVGAl/
	ShNUa3v5vNqwbB8W1awYhwAlNSiID2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705323203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gkor1SgtarxMZ+Qt7npFY955J36ZrdC1eGTk8xoP3Y=;
	b=Wi4iWWQ6bvLgHDUNEbUNU8YrkDSG69FOfR0o70I0kBUt85O/9PdTqAqPmOifCWwFHWk0Fn
	5/oEie/JOgLpuJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D26AA13751;
	Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6+FpMsMqpWWRVQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:23 +0000
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
Subject: [PATCH v3 1/4] lib: Add tst_fd iterator
Date: Mon, 15 Jan 2024 13:53:48 +0100
Message-ID: <20240115125351.7266-2-chrubis@suse.cz>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ffT9+otB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wi4iWWQ6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: E342F1F88D
X-Spam-Flag: NO

Which allows tests to loop over different types of file descriptors

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fd.h   |  61 +++++++++
 include/tst_test.h |   1 +
 lib/tst_fd.c       | 325 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c

diff --git a/include/tst_fd.h b/include/tst_fd.h
new file mode 100644
index 000000000..2183ea068
--- /dev/null
+++ b/include/tst_fd.h
@@ -0,0 +1,61 @@
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
+	TST_FD_PATH,
+	TST_FD_DIR,
+	TST_FD_DEV_ZERO,
+	TST_FD_PROC_MAPS,
+	TST_FD_PIPE_READ,
+	TST_FD_PIPE_WRITE,
+	TST_FD_UNIX_SOCK,
+	TST_FD_INET_SOCK,
+	TST_FD_EPOLL,
+	TST_FD_EVENTFD,
+	TST_FD_SIGNALFD,
+	TST_FD_TIMERFD,
+	TST_FD_PIDFD,
+	TST_FD_FANOTIFY,
+	TST_FD_INOTIFY,
+	TST_FD_USERFAULTFD,
+	TST_FD_PERF_EVENT,
+	TST_FD_IO_URING,
+	TST_FD_BPF_MAP,
+	TST_FD_FSOPEN,
+	TST_FD_FSPICK,
+	TST_FD_OPEN_TREE,
+	TST_FD_MEMFD,
+	TST_FD_MEMFD_SECRET,
+	TST_FD_MAX,
+};
+
+struct tst_fd {
+	enum tst_fd_type type;
+	int fd;
+	/* used by the library, do not touch! */
+	long priv;
+};
+
+#define TST_FD_INIT {.type = TST_FD_FILE, .fd = -1}
+
+/*
+ * Advances the iterator to the next fd type, returns zero at the end.
+ */
+int tst_fd_next(struct tst_fd *fd);
+
+#define TST_FD_FOREACH(fd) \
+	for (struct tst_fd fd = TST_FD_INIT; tst_fd_next(&fd); )
+
+/*
+ * Returns human readable name for the file descriptor type.
+ */
+const char *tst_fd_desc(struct tst_fd *fd);
+
+#endif /* TST_FD_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 0c3171e5b..fda696eeb 100644
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
index 000000000..b0d6fb1d6
--- /dev/null
+++ b/lib/tst_fd.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <sys/epoll.h>
+#include <sys/eventfd.h>
+#include <sys/signalfd.h>
+#include <sys/timerfd.h>
+#include <sys/fanotify.h>
+#include <sys/inotify.h>
+#include <linux/perf_event.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#include "lapi/pidfd.h"
+#include "lapi/io_uring.h"
+#include "lapi/bpf.h"
+#include "lapi/fsmount.h"
+
+#include "tst_fd.h"
+
+struct tst_fd_desc {
+	void (*open_fd)(struct tst_fd *fd);
+	void (*destroy)(struct tst_fd *fd);
+	const char *desc;
+};
+
+static void open_file(struct tst_fd *fd)
+{
+	fd->fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT, 0666);
+	SAFE_UNLINK("fd_file");
+}
+
+static void open_path(struct tst_fd *fd)
+{
+	int tfd;
+
+	tfd = SAFE_CREAT("fd_file", 0666);
+	SAFE_CLOSE(tfd);
+
+	fd->fd = SAFE_OPEN("fd_file", O_PATH);
+
+	SAFE_UNLINK("fd_file");
+}
+
+static void open_dir(struct tst_fd *fd)
+{
+	SAFE_MKDIR("fd_dir", 0700);
+	fd->fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
+	SAFE_RMDIR("fd_dir");
+}
+
+static void open_dev_zero(struct tst_fd *fd)
+{
+	fd->fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+}
+
+static void open_proc_self_maps(struct tst_fd *fd)
+{
+	fd->fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
+}
+
+static void open_pipe_read(struct tst_fd *fd)
+{
+	int pipe[2];
+
+	SAFE_PIPE(pipe);
+	fd->fd = pipe[0];
+	fd->priv = pipe[1];
+}
+
+static void open_pipe_write(struct tst_fd *fd)
+{
+	int pipe[2];
+
+	SAFE_PIPE(pipe);
+	fd->fd = pipe[1];
+	fd->priv = pipe[0];
+}
+
+static void destroy_pipe(struct tst_fd *fd)
+{
+	SAFE_CLOSE(fd->priv);
+}
+
+static void open_unix_sock(struct tst_fd *fd)
+{
+	fd->fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+}
+
+static void open_inet_sock(struct tst_fd *fd)
+{
+	fd->fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+}
+
+static void open_epoll(struct tst_fd *fd)
+{
+	fd->fd = epoll_create(1);
+
+	if (fd->fd < 0)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+}
+
+static void open_eventfd(struct tst_fd *fd)
+{
+	fd->fd = eventfd(0, 0);
+
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_signalfd(struct tst_fd *fd)
+{
+	sigset_t sfd_mask;
+	sigemptyset(&sfd_mask);
+
+	fd->fd = signalfd(-1, &sfd_mask, 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_timerfd(struct tst_fd *fd)
+{
+	fd->fd = timerfd_create(CLOCK_REALTIME, 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_pidfd(struct tst_fd *fd)
+{
+	fd->fd = pidfd_open(getpid(), 0);
+	if (fd->fd < 0)
+		tst_brk(TBROK | TERRNO, "pidfd_open()");
+}
+
+static void open_fanotify(struct tst_fd *fd)
+{
+	fd->fd = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_inotify(struct tst_fd *fd)
+{
+	fd->fd = inotify_init();
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_userfaultfd(struct tst_fd *fd)
+{
+	fd->fd = syscall(__NR_userfaultfd, 0);
+
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_perf_event(struct tst_fd *fd)
+{
+	struct perf_event_attr pe_attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.size = sizeof(struct perf_event_attr),
+		.config = PERF_COUNT_SW_CPU_CLOCK,
+		.disabled = 1,
+		.exclude_kernel = 1,
+		.exclude_hv = 1,
+	};
+
+	fd->fd = syscall(__NR_perf_event_open, &pe_attr, 0, -1, -1, 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_io_uring(struct tst_fd *fd)
+{
+	struct io_uring_params uring_params = {};
+
+	fd->fd = io_uring_setup(1, &uring_params);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_bpf_map(struct tst_fd *fd)
+{
+	union bpf_attr array_attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = 1,
+	};
+
+	fd->fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_fsopen(struct tst_fd *fd)
+{
+	fd->fd = fsopen("ext2", 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_fspick(struct tst_fd *fd)
+{
+	fd->fd = fspick(AT_FDCWD, "/", 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_open_tree(struct tst_fd *fd)
+{
+	fd->fd = open_tree(AT_FDCWD, "/", 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_memfd(struct tst_fd *fd)
+{
+	fd->fd = syscall(__NR_memfd_create, "ltp_memfd", 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static void open_memfd_secret(struct tst_fd *fd)
+{
+	fd->fd = syscall(__NR_memfd_secret, 0);
+	if (fd->fd < 0) {
+		tst_res(TCONF | TERRNO,
+			"Skipping %s", tst_fd_desc(fd));
+	}
+}
+
+static struct tst_fd_desc fd_desc[] = {
+	[TST_FD_FILE] = {.open_fd = open_file, .desc = "file"},
+	[TST_FD_PATH] = {.open_fd = open_path, .desc = "O_PATH file"},
+	[TST_FD_DIR] = {.open_fd = open_dir, .desc = "directory"},
+	[TST_FD_DEV_ZERO] = {.open_fd = open_dev_zero, .desc = "/dev/zero"},
+	[TST_FD_PROC_MAPS] = {.open_fd = open_proc_self_maps, .desc = "/proc/self/maps"},
+	[TST_FD_PIPE_READ] = {.open_fd = open_pipe_read, .desc = "pipe read end", .destroy = destroy_pipe},
+	[TST_FD_PIPE_WRITE] = {.open_fd = open_pipe_write, .desc = "pipe write end", .destroy = destroy_pipe},
+	[TST_FD_UNIX_SOCK] = {.open_fd = open_unix_sock, .desc = "unix socket"},
+	[TST_FD_INET_SOCK] = {.open_fd = open_inet_sock, .desc = "inet socket"},
+	[TST_FD_EPOLL] = {.open_fd = open_epoll, .desc = "epoll"},
+	[TST_FD_EVENTFD] = {.open_fd = open_eventfd, .desc = "eventfd"},
+	[TST_FD_SIGNALFD] = {.open_fd = open_signalfd, .desc = "signalfd"},
+	[TST_FD_TIMERFD] = {.open_fd = open_timerfd, .desc = "timerfd"},
+	[TST_FD_PIDFD] = {.open_fd = open_pidfd, .desc = "pidfd"},
+	[TST_FD_FANOTIFY] = {.open_fd = open_fanotify, .desc = "fanotify"},
+	[TST_FD_INOTIFY] = {.open_fd = open_inotify, .desc = "inotify"},
+	[TST_FD_USERFAULTFD] = {.open_fd = open_userfaultfd, .desc = "userfaultfd"},
+	[TST_FD_PERF_EVENT] = {.open_fd = open_perf_event, .desc = "perf event"},
+	[TST_FD_IO_URING] = {.open_fd = open_io_uring, .desc = "io uring"},
+	[TST_FD_BPF_MAP] = {.open_fd = open_bpf_map, .desc = "bpf map"},
+	[TST_FD_FSOPEN] = {.open_fd = open_fsopen, .desc = "fsopen"},
+	[TST_FD_FSPICK] = {.open_fd = open_fspick, .desc = "fspick"},
+	[TST_FD_OPEN_TREE] = {.open_fd = open_open_tree, .desc = "open_tree"},
+	[TST_FD_MEMFD] = {.open_fd = open_memfd, .desc = "memfd"},
+	[TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd secret"},
+};
+
+const char *tst_fd_desc(struct tst_fd *fd)
+{
+	if (fd->type >= ARRAY_SIZE(fd_desc))
+		return "invalid";
+
+	return fd_desc[fd->type].desc;
+}
+
+int tst_fd_next(struct tst_fd *fd)
+{
+	size_t len = ARRAY_SIZE(fd_desc);
+
+	if (fd->fd >= 0) {
+		SAFE_CLOSE(fd->fd);
+
+		if (fd_desc[fd->type].destroy)
+			fd_desc[fd->type].destroy(fd);
+
+		fd->type++;
+	}
+
+	for (;;) {
+		if (fd->type >= len)
+			return 0;
+
+		fd_desc[fd->type].open_fd(fd);
+
+		if (fd->fd >= 0)
+			return 1;
+
+		fd->type++;
+	}
+}
-- 
2.43.0


