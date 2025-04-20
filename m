Return-Path: <linux-fsdevel+bounces-46736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273EFA94839
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4824516BFE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6A20C028;
	Sun, 20 Apr 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUIZORBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C91EB1BC;
	Sun, 20 Apr 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745164770; cv=none; b=nB5/J+LCIOL1s1hVVQAezENYwv7EmMKx4h6PtJFvprPV61E6oiPOkDNPEQ9klZDu14cZV+tU/LoizOhcN6sGKsZBjSqcqT05zQhnxdMYUfgCU0D8pTbusjGU8uyJEB7nul3eKT9UX+IZeJyjSE4EgEsyNJmoaFWdFuUaTtn0428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745164770; c=relaxed/simple;
	bh=93kECPvpfHLvi3qDs25Onj8GT4ggPIYfsb3O6TfKzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXXSUGBr1zrAyPWi0x0jm1MyAd9RDq01F+IEm+eNcdeyL5EZllXSx3aul0q+Yg24WSXG9xYDHR/DAzSO6X2EhSq9TkHaa0Y8KAE/1MXUWVyrYmb6PCIBA2apNmmye7RvZqkp52oHWNg4b51V31a8HN3xiHiNF5AzyHsnzLmVDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUIZORBi; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745164765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0cdqSd9eqgxjb0DRh6oAeCxxzKsmrIexabjD/n3lQo=;
	b=kUIZORBiJnEt2TOQoAnwsjOq5Q+olLJUhaeywBijv98iOmQRgBiOgNO9kMa6Kzmx4oW7+C
	t05IJILh8t9qiiaG9MNza1cLGXQf8Ou3vL8YXEaeBry6HACjkwAQw9D/kxoygb2D1npktU
	KRew8Hnvo9P9k8r3CecDDkwIbBRbNSA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/3] bcachefs: enumerated_ref.c
Date: Sun, 20 Apr 2025 11:59:14 -0400
Message-ID: <20250420155918.749455-2-kent.overstreet@linux.dev>
In-Reply-To: <20250420155918.749455-1-kent.overstreet@linux.dev>
References: <20250420155918.749455-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Factor out the debug code for rw filesystem refs into a small library.

In release mode an enumerated ref is a normal percpu refcount, but in
debug mode all enumerated users of the ref get their own atomic_long_t
ref - making it much easier to chase down refcount usage bugs for when a
refcount has many users.

For debugging, we have enumerated_ref_to_text(), which prints the
current value of each different user.

Additionally, in debug mode enumerated_ref_stop() has a 10 second
timeout, after which it will dump outstanding refcounts.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/Makefile               |   1 +
 fs/bcachefs/enumerated_ref.c       | 144 +++++++++++++++++++++++++++++
 fs/bcachefs/enumerated_ref.h       |  54 +++++++++++
 fs/bcachefs/enumerated_ref_types.h |  19 ++++
 4 files changed, 218 insertions(+)
 create mode 100644 fs/bcachefs/enumerated_ref.c
 create mode 100644 fs/bcachefs/enumerated_ref.h
 create mode 100644 fs/bcachefs/enumerated_ref_types.h

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index baf859bf83bb..3be39845e4f6 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -35,6 +35,7 @@ bcachefs-y		:=	\
 	disk_accounting.o	\
 	disk_groups.o		\
 	ec.o			\
+	enumerated_ref.o	\
 	errcode.o		\
 	error.o			\
 	extents.o		\
diff --git a/fs/bcachefs/enumerated_ref.c b/fs/bcachefs/enumerated_ref.c
new file mode 100644
index 000000000000..56ab430f209f
--- /dev/null
+++ b/fs/bcachefs/enumerated_ref.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bcachefs.h"
+#include "enumerated_ref.h"
+#include "util.h"
+
+#include <linux/completion.h>
+
+#ifdef ENUMERATED_REF_DEBUG
+void enumerated_ref_get(struct enumerated_ref *ref, unsigned idx)
+{
+	BUG_ON(idx >= ref->nr);
+	atomic_long_inc(&ref->refs[idx]);
+}
+
+bool __enumerated_ref_tryget(struct enumerated_ref *ref, unsigned idx)
+{
+	BUG_ON(idx >= ref->nr);
+	return atomic_long_inc_not_zero(&ref->refs[idx]);
+}
+
+bool enumerated_ref_tryget(struct enumerated_ref *ref, unsigned idx)
+{
+	BUG_ON(idx >= ref->nr);
+	return !ref->dying &&
+		atomic_long_inc_not_zero(&ref->refs[idx]);
+}
+
+void enumerated_ref_put(struct enumerated_ref *ref, unsigned idx)
+{
+	BUG_ON(idx >= ref->nr);
+	long v = atomic_long_dec_return(&ref->refs[idx]);
+
+	BUG_ON(v < 0);
+	if (v)
+		return;
+
+	for (unsigned i = 0; i < ref->nr; i++)
+		if (atomic_long_read(&ref->refs[i]))
+			return;
+
+	if (ref->stop_fn)
+		ref->stop_fn(ref);
+	complete(&ref->stop_complete);
+}
+#endif
+
+#ifndef ENUMERATED_REF_DEBUG
+static void enumerated_ref_kill_cb(struct percpu_ref *percpu_ref)
+{
+	struct enumerated_ref *ref =
+		container_of(percpu_ref, struct enumerated_ref, ref);
+
+	if (ref->stop_fn)
+		ref->stop_fn(ref);
+	complete(&ref->stop_complete);
+}
+#endif
+
+void enumerated_ref_stop_async(struct enumerated_ref *ref)
+{
+	reinit_completion(&ref->stop_complete);
+
+#ifndef ENUMERATED_REF_DEBUG
+	percpu_ref_kill(&ref->ref);
+#else
+	ref->dying = true;
+	for (unsigned i = 0; i < ref->nr; i++)
+		enumerated_ref_put(ref, i);
+#endif
+}
+
+void enumerated_ref_stop(struct enumerated_ref *ref,
+			 const char * const names[])
+{
+	enumerated_ref_stop_async(ref);
+	while (!wait_for_completion_timeout(&ref->stop_complete, HZ * 10)) {
+		struct printbuf buf = PRINTBUF;
+
+		prt_str(&buf, "Waited for 10 seconds to shutdown enumerated ref\n");
+		prt_str(&buf, "Outstanding refs:\n");
+		enumerated_ref_to_text(&buf, ref, names);
+		printk(KERN_ERR "%s", buf.buf);
+		printbuf_exit(&buf);
+	}
+}
+
+void enumerated_ref_start(struct enumerated_ref *ref)
+{
+#ifndef ENUMERATED_REF_DEBUG
+	percpu_ref_reinit(&ref->ref);
+#else
+	ref->dying = false;
+	for (unsigned i = 0; i < ref->nr; i++) {
+		BUG_ON(atomic_long_read(&ref->refs[i]));
+		atomic_long_inc(&ref->refs[i]);
+	}
+#endif
+}
+
+void enumerated_ref_exit(struct enumerated_ref *ref)
+{
+#ifndef ENUMERATED_REF_DEBUG
+	percpu_ref_exit(&ref->ref);
+#else
+	kfree(ref->refs);
+	ref->refs = NULL;
+	ref->nr = 0;
+#endif
+}
+
+int enumerated_ref_init(struct enumerated_ref *ref, unsigned nr,
+			void (*stop_fn)(struct enumerated_ref *))
+{
+	init_completion(&ref->stop_complete);
+	ref->stop_fn = stop_fn;
+
+#ifndef ENUMERATED_REF_DEBUG
+	return percpu_ref_init(&ref->ref, enumerated_ref_kill_cb,
+			    PERCPU_REF_INIT_DEAD, GFP_KERNEL);
+#else
+	ref->refs = kzalloc(sizeof(ref->refs[0]) * nr, GFP_KERNEL);
+	if (!ref->refs)
+		return -ENOMEM;
+
+	ref->nr = nr;
+	return 0;
+#endif
+}
+
+void enumerated_ref_to_text(struct printbuf *out,
+			    struct enumerated_ref *ref,
+			    const char * const names[])
+{
+#ifdef ENUMERATED_REF_DEBUG
+	bch2_printbuf_tabstop_push(out, 32);
+
+	for (unsigned i = 0; i < ref->nr; i++)
+		prt_printf(out, "%s\t%li\n", names[i],
+			   atomic_long_read(&ref->refs[i]));
+#else
+	prt_str(out, "(not in debug mode)\n");
+#endif
+}
diff --git a/fs/bcachefs/enumerated_ref.h b/fs/bcachefs/enumerated_ref.h
new file mode 100644
index 000000000000..6d2283cf298d
--- /dev/null
+++ b/fs/bcachefs/enumerated_ref.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_ENUMERATED_REF_H
+#define _BCACHEFS_ENUMERATED_REF_H
+
+#include "enumerated_ref_types.h"
+
+/*
+ * A refcount where the users are enumerated: in debug mode, we create sepate
+ * refcounts for each user, to make leaks and refcount errors easy to track
+ * down:
+ */
+
+#ifdef ENUMERATED_REF_DEBUG
+void enumerated_ref_get(struct enumerated_ref *, unsigned);
+bool __enumerated_ref_tryget(struct enumerated_ref *, unsigned);
+bool enumerated_ref_tryget(struct enumerated_ref *, unsigned);
+void enumerated_ref_put(struct enumerated_ref *, unsigned);
+#else
+
+static inline void enumerated_ref_get(struct enumerated_ref *ref, unsigned idx)
+{
+	percpu_ref_get(&ref->ref);
+}
+
+static inline bool __enumerated_ref_tryget(struct enumerated_ref *ref, unsigned idx)
+{
+	return percpu_ref_tryget(&ref->ref);
+}
+
+static inline bool enumerated_ref_tryget(struct enumerated_ref *ref, unsigned idx)
+{
+	return percpu_ref_tryget_live(&ref->ref);
+}
+
+static inline void enumerated_ref_put(struct enumerated_ref *ref, unsigned idx)
+{
+	percpu_ref_put(&ref->ref);
+}
+#endif
+
+void enumerated_ref_stop_async(struct enumerated_ref *);
+void enumerated_ref_stop(struct enumerated_ref *, const char * const[]);
+void enumerated_ref_start(struct enumerated_ref *);
+
+void enumerated_ref_exit(struct enumerated_ref *);
+int enumerated_ref_init(struct enumerated_ref *, unsigned,
+			void (*stop_fn)(struct enumerated_ref *));
+
+struct printbuf;
+void enumerated_ref_to_text(struct printbuf *,
+			    struct enumerated_ref *,
+			    const char * const[]);
+
+#endif /* _BCACHEFS_ENUMERATED_REF_H */
diff --git a/fs/bcachefs/enumerated_ref_types.h b/fs/bcachefs/enumerated_ref_types.h
new file mode 100644
index 000000000000..0e6076f466d3
--- /dev/null
+++ b/fs/bcachefs/enumerated_ref_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_ENUMERATED_REF_TYPES_H
+#define _BCACHEFS_ENUMERATED_REF_TYPES_H
+
+#include <linux/percpu-refcount.h>
+
+struct enumerated_ref {
+#ifdef ENUMERATED_REF_DEBUG
+	unsigned		nr;
+	bool			dying;
+	atomic_long_t		*refs;
+#else
+	struct percpu_ref	ref;
+#endif
+	void			(*stop_fn)(struct enumerated_ref *);
+	struct completion	stop_complete;
+};
+
+#endif /* _BCACHEFS_ENUMERATED_REF_TYPES_H */
-- 
2.49.0


