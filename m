Return-Path: <linux-fsdevel+bounces-78201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCqiHSHonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1751800D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E582315F21E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622043803C2;
	Mon, 23 Feb 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbjLem0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BB37FF74;
	Mon, 23 Feb 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890516; cv=none; b=AaLObQhO/Oe45Na5IA7ZoWyr0oXkP57C0N5CE3onK9wTTqe8ymjmwHggEI55VLYezN7KsfejRYSfWNdkDEu4O6hJ0giX6KD4xu5PjT2uBj6BrdekVkLSs9KeSDWCF6og/TukbkJ0sMkFISkorVfw5jVq+sRBq3a8SFdtXdSKhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890516; c=relaxed/simple;
	bh=ZDcR6k7gpR92u7sya7g0rergZw4UHG0euQF0o7CCHZs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWqiiMoCzvVHmmi40Jxh0EmAlfByhJ9+SeK0VnNXoE0f4WAlRUmFtW/tQ9mEj6TcWEx5RCp/EsXEGm1zbx4Fw6VU1GTb7YPKqTPXqdhqrOB1YLmfA+CQG9GkoU8pzCkZONKAOqSOGK/ucCZH6H5TCaYn4bs1bYQRP1BHaAVnv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbjLem0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771ABC19421;
	Mon, 23 Feb 2026 23:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890515;
	bh=ZDcR6k7gpR92u7sya7g0rergZw4UHG0euQF0o7CCHZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KbjLem0Zkj1WVyU3+v+Ua2DG/vAKXeXx/O0oGqdvAV9EXvtoXu7YZCZ1Sgg3qV6CB
	 CUhB6L8RCtcX4ui5i5EVSrCbKfJCVTr9kwrFu89l/UL58FyZBE3Rp+iq8+y0jbXQQm
	 ArG5scR9Iopug4XsL9tjxevQC1/IlnYst8LZXGM5gmXRa4DNYggCQ4xIGWIsWQqMve
	 7UN8d4PKUfofQ0d99vGW2BdeJ75gJoGN7paX+Ewkrgra/YVBj6E2o7yIT4elgpjdKt
	 upugGR2L4MCotTWIRYfwiOVoLUbXybnx6BSIdxYpAdP2tumuOdOJfGripzcxTb8Big
	 E/MmM8j3kDvAA==
Date: Mon, 23 Feb 2026 15:48:35 -0800
Subject: [PATCH 1/4] libsupport: add pressure stall monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746253.3945260.17612476931342204199.stgit@frogsfrogsfrogs>
In-Reply-To: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
References: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78201-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E1751800D0
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create some monitoring code that will sit in the background and watch
for resource pressure stalls and call some sort of handler when this
happens.  This will be useful for shrinking the buffer cache when memory
gets tight.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/psi.h       |   57 +++++
 lib/support/Makefile.in |    4 
 lib/support/iocache.c   |   19 ++
 lib/support/psi.c       |  510 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 590 insertions(+)
 create mode 100644 lib/support/psi.h
 create mode 100644 lib/support/psi.c


diff --git a/lib/support/psi.h b/lib/support/psi.h
new file mode 100644
index 00000000000000..675ebeb553da3e
--- /dev/null
+++ b/lib/support/psi.h
@@ -0,0 +1,57 @@
+/*
+ * psi.h - Pressure stall monitor
+ *
+ * Copyright (C) 2025-2026 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#ifndef __PSI_H__
+#define __PSI_H__
+
+struct psi;
+struct psi_handler;
+
+enum psi_type {
+	PSI_MEMORY,
+};
+
+void psi_destroy(struct psi **psip);
+
+/* call malloc_trim after calling handlers */
+#define PSI_TRIM_HEAP		(1U << 0)
+
+#define PSI_FLAGS		(PSI_TRIM_HEAP)
+
+int psi_create(enum psi_type type, unsigned int psi_flags,
+	       uint64_t stall_us, uint64_t window_us, uint64_t timeout_us,
+	       struct psi **psip);
+
+/* psi triggered due to timeout (and not pressure) */
+#define PSI_REASON_TIMEOUT	(1U << 0)
+
+/*
+ * Prototype of a function to call when a stall occurs.  Implementations must
+ * not block on any resources that are held if psi_stop_thread is called.
+ */
+typedef void (*psi_handler_fn)(const struct psi *psi, unsigned int reasons,
+			       void *data);
+
+int psi_add_handler(struct psi *psi, psi_handler_fn callback, void *data,
+		    struct psi_handler **hanp);
+void psi_del_handler(struct psi *psi, struct psi_handler **hanp);
+void psi_cancel_handler(struct psi *psi, struct psi_handler **hanp);
+
+int psi_start_thread(struct psi *psi);
+void psi_stop_thread(struct psi *psi);
+
+bool psi_thread_cancelled(const struct psi *psi);
+
+static inline bool psi_active(struct psi *psi)
+{
+	return psi != NULL;
+}
+
+#endif /* __PSI_H__ */
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index 2950e80222ee72..dd4cee928fee5c 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -23,6 +23,7 @@ OBJS=		bthread.o \
 		print_fs_flags.o \
 		profile_helpers.o \
 		prof_err.o \
+		psi.o \
 		quotaio.o \
 		quotaio_v2.o \
 		quotaio_tree.o \
@@ -40,6 +41,7 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/profile.c \
 		$(srcdir)/profile_helpers.c \
 		prof_err.c \
+		$(srcdir)/psi.c \
 		$(srcdir)/quotaio.c \
 		$(srcdir)/quotaio_tree.c \
 		$(srcdir)/quotaio_v2.c \
@@ -195,3 +197,5 @@ cache.o: $(srcdir)/cache.c $(top_builddir)/lib/config.h \
  $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
 iocache.o: $(srcdir)/iocache.c $(top_builddir)/lib/config.h \
  $(srcdir)/iocache.h $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
+psi.o: $(srcdir)/psi.c $(top_builddir)/lib/config.h \
+ $(srcdir)/psi.h $(srcdir)/list.h $(srcdir)/xbitops.h
diff --git a/lib/support/iocache.c b/lib/support/iocache.c
index 478d89174422df..dfb81d3cf58513 100644
--- a/lib/support/iocache.c
+++ b/lib/support/iocache.c
@@ -452,6 +452,20 @@ static errcode_t iocache_set_option(io_channel channel, const char *option,
 	if (!strcmp(option, "cache"))
 		return 0;
 
+	if (!strcmp(option, "cache_auto_shrink")) {
+		if (!arg)
+			return EXT2_ET_INVALID_ARGUMENT;
+		if (!strcmp(arg, "on")) {
+			cache_set_flag(&data->cache, CACHE_AUTO_SHRINK);
+			return 0;
+		}
+		if (!strcmp(arg, "off")) {
+			cache_clear_flag(&data->cache, CACHE_AUTO_SHRINK);
+			return 0;
+		}
+		return EXT2_ET_INVALID_ARGUMENT;
+	}
+
 	if (!strcmp(option, "cache_blocks")) {
 		long long size;
 
@@ -467,6 +481,11 @@ static errcode_t iocache_set_option(io_channel channel, const char *option,
 		return 0;
 	}
 
+	if (!strcmp(option, "cache_shrink")) {
+		cache_shrink(&data->cache);
+		return 0;
+	}
+
 	retval = iocache_flush_cache(data);
 	if (retval)
 		return retval;
diff --git a/lib/support/psi.c b/lib/support/psi.c
new file mode 100644
index 00000000000000..26ce6ee1985641
--- /dev/null
+++ b/lib/support/psi.c
@@ -0,0 +1,510 @@
+/*
+ * psi.c - Pressure stall monitor
+ *
+ * Copyright (C) 2025-2026 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#include "config.h"
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <poll.h>
+#include <pthread.h>
+#include <malloc.h>
+#include <signal.h>
+#include <limits.h>
+
+#include "support/list.h"
+#include "support/psi.h"
+
+enum psi_state {
+	/* waiting to be put in the running state */
+	PSI_WAITING,
+	/* running */
+	PSI_RUNNING,
+	/* cancelled */
+	PSI_CANCELLED,
+};
+
+struct psi_handler {
+	struct list_head list;
+	psi_handler_fn callback;
+	void *data;
+};
+
+struct psi {
+	int system_fd;
+	int cgroup_fd;
+	unsigned int flags;
+	uint64_t timeout_us;
+
+	pthread_t thread;
+	pthread_mutex_t lock;
+	struct list_head handlers;
+
+	enum psi_type type;
+	enum psi_state state;
+};
+
+static const char *psi_system_path(enum psi_type type)
+{
+	switch (type) {
+	case PSI_MEMORY:
+		return "/proc/pressure/memory";
+	default:
+		return NULL;
+	}
+}
+
+static const char *psi_cgroup_fname(enum psi_type type)
+{
+	switch (type) {
+	case PSI_MEMORY:
+		return "memory.pressure";
+	default:
+		return NULL;
+	}
+}
+
+static const char *psi_shortname(enum psi_type type)
+{
+	switch (type) {
+	case PSI_MEMORY:
+		return "psi:memory";
+	default:
+		return NULL;
+	}
+}
+
+static void psi_run_callbacks(struct psi *psi, unsigned int reasons)
+{
+	struct psi_handler *h, *i;
+
+	pthread_mutex_lock(&psi->lock);
+	list_for_each_entry_safe(h, i, &psi->handlers, list)
+		h->callback(psi, reasons, h->data);
+	pthread_mutex_unlock(&psi->lock);
+
+	if (psi->flags & PSI_TRIM_HEAP)
+		malloc_trim(0);
+}
+
+static inline void psi_fill_pollfd(struct pollfd *pfd, int fd)
+{
+	memset(pfd, 0, sizeof(*pfd));
+	pfd->fd = fd;
+	pfd->events = POLLPRI | POLLRDHUP | POLLERR | POLLHUP;
+}
+
+static unsigned int psi_fill_pollfds(struct psi *psi, struct pollfd *pfds)
+{
+	unsigned int ret = 0;
+
+	if (psi->system_fd >= 0) {
+		psi_fill_pollfd(pfds, psi->system_fd);
+		pfds++;
+		ret++;
+	}
+
+	if (psi->cgroup_fd >= 0) {
+		psi_fill_pollfd(pfds, psi->cgroup_fd);
+		pfds++;
+		ret++;
+	}
+
+	return ret;
+}
+
+static void *psi_thread(void *arg)
+{
+	struct psi *psi = arg;
+	int oldstate;
+
+	/*
+	 * Don't let pthread_cancel kill us except while we're in poll()
+	 * because we don't hold any resources during that call.  Everywhere
+	 * else, there could be resource cleanups that would have to be done.
+	 * Hence we just turn off cancelling for simplicity's sake.
+	 */
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &oldstate);
+
+	pthread_mutex_lock(&psi->lock);
+	psi->state = PSI_RUNNING;
+	pthread_mutex_unlock(&psi->lock);
+
+	while (1) {
+		struct pollfd pfds[2];
+		unsigned int nr_pfds;
+		int timeout_ms;
+		int n;
+
+		pthread_mutex_lock(&psi->lock);
+		if (psi_thread_cancelled(psi)) {
+			pthread_mutex_unlock(&psi->lock);
+			break;
+		}
+
+		nr_pfds = psi_fill_pollfds(psi, pfds);
+		timeout_ms = psi->timeout_us ? psi->timeout_us / 1000 : -1;
+		pthread_mutex_unlock(&psi->lock);
+
+		pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+		n = poll(pfds, nr_pfds, timeout_ms);
+		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
+		if (n == 0) {
+			/* run callbacks on timeout */
+			psi_run_callbacks(psi, PSI_REASON_TIMEOUT);
+			continue;
+		}
+		if (n < 0) {
+			perror(psi_shortname(psi->type));
+			break;
+		}
+
+		/* psi fd closed */
+		if ((pfds[0].revents & POLLNVAL) ||
+		    (pfds[1].revents & POLLNVAL))
+			break;
+
+		if ((pfds[0].revents & POLLERR) ||
+		    (pfds[1].revents & POLLERR)) {
+			fprintf(stderr, "%s: event source dead?\n",
+				psi_shortname(psi->type));
+			break;
+		}
+
+		/* POLLPRI on a psi fd means we hit the pressure threshold */
+		if ((pfds[0].revents & POLLPRI) ||
+		    (pfds[1].revents & POLLPRI)) {
+			psi_run_callbacks(psi, 0);
+			continue;
+		}
+
+		fprintf(stderr, "%s: unknown events 0x%x/0x%x, ignoring.\n",
+			psi_shortname(psi->type), pfds[0].revents,
+			pfds[1].revents);
+	}
+
+	pthread_setcancelstate(oldstate, NULL);
+	return NULL;
+}
+
+/* Call a function whenever there is resource pressure */
+int psi_add_handler(struct psi *psi, psi_handler_fn callback, void *data,
+		    struct psi_handler **hanp)
+{
+	struct psi_handler *handler;
+
+	handler = malloc(sizeof(*handler));
+	if (!handler)
+		return -1;
+
+	INIT_LIST_HEAD(&handler->list);
+	handler->callback = callback;
+	handler->data = data;
+
+	pthread_mutex_lock(&psi->lock);
+	list_add_tail(&handler->list, &psi->handlers);
+	pthread_mutex_unlock(&psi->lock);
+
+	*hanp = handler;
+	return 0;
+}
+
+/* Stop calling this handler when there is resource pressure */
+void psi_del_handler(struct psi *psi, struct psi_handler **hanp)
+{
+	struct psi_handler *handler = *hanp;
+
+	if (handler) {
+		pthread_mutex_lock(&psi->lock);
+		list_del_init(&handler->list);
+		pthread_mutex_unlock(&psi->lock);
+		free(handler);
+	}
+
+	*hanp = NULL;
+}
+
+/* Cancel a running handler. */
+void psi_cancel_handler(struct psi *psi, struct psi_handler **hanp)
+{
+	struct psi_handler *handler = *hanp;
+
+	if (handler) {
+		list_del_init(&handler->list);
+		free(handler);
+	}
+
+	*hanp = NULL;
+}
+
+/*
+ * Stop monitoring for resource pressure stalls.  The monitor cannot be
+ * restarted after this call completes.
+ */
+void psi_stop_thread(struct psi *psi)
+{
+	int system_fd;
+	int cgroup_fd;
+	enum psi_state old_state;
+
+	pthread_mutex_lock(&psi->lock);
+	system_fd = psi->system_fd;
+	cgroup_fd = psi->cgroup_fd;
+	old_state = psi->state;
+	psi->system_fd = -1;
+	psi->cgroup_fd = -1;
+	psi->state = PSI_CANCELLED;
+	pthread_mutex_unlock(&psi->lock);
+
+	if (system_fd >= 0)
+		close(system_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+
+	if (old_state == PSI_RUNNING) {
+		/* Cancelling the thread interrupts the poll() call */
+		pthread_cancel(psi->thread);
+		pthread_join(psi->thread, NULL);
+	}
+}
+
+/* Is this stall monitor active and its thread running? */
+bool psi_thread_cancelled(const struct psi *psi)
+{
+	return !psi || psi->state == PSI_CANCELLED;
+}
+
+/* Destroy this resource pressure stall monitor having stopped the thread */
+void psi_destroy(struct psi **psip)
+{
+	struct psi *psi = *psip;
+
+	if (psi) {
+		psi_stop_thread(psi);
+		pthread_mutex_destroy(&psi->lock);
+		free(psi);
+	}
+
+	*psip = NULL;
+}
+
+static int psi_open_control(const char *path)
+{
+	return open(path, O_RDWR | O_NONBLOCK);
+}
+
+static void psi_open_system_control(struct psi *psi)
+{
+	/* PSI may not exist, so we don't error if it's not there */
+	psi->system_fd = psi_open_control(psi_system_path(psi->type));
+}
+
+static ssize_t psi_cgroup_path(enum psi_type type, char *path, size_t pathsize)
+{
+	char cgpath[PATH_MAX];
+	char *p = cgpath;
+	ssize_t bytes;
+	int pscgroupfd = open("/proc/self/cgroup", O_RDONLY);
+	int nr_colons = 0;
+
+	/*
+	 * Read the contents of /proc/self/cgroup, which should have the
+	 * format:
+	 *
+	 * <id>:<stuff>:<absolute path under cgroupfs>\n
+	 *
+	 * We care about the cgroupfs path (column 3) and not the newline.
+	 */
+	if (pscgroupfd < 0)
+		return 0;
+
+	bytes = read(pscgroupfd, cgpath, sizeof(cgpath) - 1);
+	close(pscgroupfd);
+	if (bytes < 0)
+		return 0;
+	cgpath[bytes] = 0;
+
+	/*
+	 * Find the second colon, turn it into a dot so that we have a relative
+	 * path.  sysfs paths can contain colons, so this will always be the
+	 * last column... right?
+	 */
+	while (*p != 0) {
+		if (*p == ':')
+			nr_colons++;
+		if (nr_colons == 2) {
+			*p = '.';
+			break;
+		}
+
+		p++;
+	}
+
+	if (nr_colons != 2)
+		return 0;
+
+	/* Trim trailing newline, p points to column 3 */
+	bytes = strlen(p);
+	if (p[bytes - 1] == '\n')
+		p[bytes - 1] = 0;
+
+	/* /sys/fs/cgroup/$col3/$psi_cgroup_fname */
+	return snprintf(path, pathsize, "/sys/fs/cgroup/%s/%s", p,
+			psi_cgroup_fname(type));
+}
+
+static void psi_open_cgroup_control(struct psi *psi)
+{
+	char path[PATH_MAX];
+	ssize_t pathlen;
+
+	pathlen = psi_cgroup_path(psi->type, path, sizeof(path));
+	if (!pathlen || pathlen >= sizeof(path)) {
+		psi->cgroup_fd = -1;
+		return;
+	}
+
+	/* PSI may not exist, so we don't error if it's not there */
+	psi->cgroup_fd = psi_open_control(path);
+}
+
+static int psi_config_fd(struct psi *psi, int fd, uint64_t stall_us,
+			 uint64_t window_us)
+{
+	char buf[256];
+	size_t bytes;
+	ssize_t written;
+
+	if (fd < 0)
+		return 0;
+
+	/*
+	 * The kernel blindly nulls out the last byte we write into the psi
+	 * file, so put a newline at the end because I bet they're only testing
+	 * this with bash scripts.
+	 */
+	bytes = snprintf(buf, sizeof(buf), "some %llu %llu\n",
+			 (unsigned long long)stall_us,
+			 (unsigned long long)window_us);
+	if (bytes > sizeof(buf))
+		return -1;
+
+	written = write(fd, buf, bytes);
+	if (written >= 0 && written != bytes) {
+		written = -1;
+		errno = EMSGSIZE;
+	}
+	if (written < 0) {
+		perror(psi_shortname(psi->type));
+		return -1;
+	}
+
+	return 0;
+}
+
+static inline struct psi *psi_alloc(enum psi_type type, unsigned int psi_flags,
+				    uint64_t timeout_us)
+{
+	struct psi *psi = calloc(1, sizeof(*psi));
+	if (!psi)
+		return NULL;
+
+	psi->type = type;
+	psi->flags = psi_flags;
+	psi->timeout_us = timeout_us;
+	psi->state = PSI_WAITING;
+	INIT_LIST_HEAD(&psi->handlers);
+	pthread_mutex_init(&psi->lock, NULL);
+
+	return psi;
+}
+
+/*
+ * Create a pressure stall indicator monitor thread that monitors for
+ * resource availability stalls exceeding @stall_us in any @window_us time
+ * period and calls any attached handlers.  If @timeout_us is nonzero, the
+ * handlers will be called at that interval with PSI_REASON_TIMEOUT.
+ *
+ * Unprivileged processes are not allowed to set a @window_us that is not a
+ * multiple of 2 seconds(!)
+ *
+ * Returns 0 on success.  On error, returns -1 and sets errno.  errno values
+ * are as follows:
+ *
+ *    ENOENT means the monitor file cannot be found
+ *    EACCESS or EPERM mean that monitoring is not available
+ *    EINVAL means the window values are not valid
+ *    Any other errno is a sign of deeper problems
+ */
+int psi_create(enum psi_type type, unsigned int psi_flags, uint64_t stall_us,
+	       uint64_t window_us, uint64_t timeout_us, struct psi **psip)
+{
+	struct psi *psi;
+	int ret;
+
+	if (psi_flags & ~PSI_FLAGS) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	psi = psi_alloc(type, psi_flags, timeout_us);
+	if (!psi)
+		return -1;
+
+	psi_open_system_control(psi);
+	psi_open_cgroup_control(psi);
+
+	if (psi->system_fd < 0 && psi->cgroup_fd < 0 && !psi->timeout_us) {
+		errno = ENOENT;
+		goto out_fds;
+	}
+
+	ret = psi_config_fd(psi, psi->system_fd, stall_us, window_us);
+	if (ret)
+		goto out_fds;
+
+	ret = psi_config_fd(psi, psi->cgroup_fd, stall_us, window_us);
+	if (ret)
+		goto out_fds;
+
+	*psip = psi;
+	return 0;
+
+out_fds:
+	psi_destroy(&psi);
+	return -1;
+}
+
+/* Start monitoring for resource pressure stalls */
+int psi_start_thread(struct psi *psi)
+{
+	int error;
+
+	if (psi->state != PSI_WAITING) {
+		fprintf(stderr, "%s: psi already torn down\n",
+			psi_shortname(psi->type));
+		errno = EINVAL;
+		return -1;
+	}
+
+	error = pthread_create(&psi->thread, NULL, psi_thread, psi);
+	if (error) {
+		fprintf(stderr, "%s: could not create thread: %s\n",
+			psi_shortname(psi->type), strerror(error));
+		errno = error;
+		return -1;
+	}
+
+	pthread_setname_np(psi->thread, psi_shortname(psi->type));
+	return 0;
+}


