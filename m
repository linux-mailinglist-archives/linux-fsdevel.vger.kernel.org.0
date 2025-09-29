Return-Path: <linux-fsdevel+bounces-62985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A5BA7BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5843B86E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E862C11F5;
	Mon, 29 Sep 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fImHCNq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D621D5AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107899; cv=none; b=GXNp+jVw/kZM3EE28x4TGfQvlNotITswjlc+31c0iFNx4LcnyCw7hBsQJ6kc13DWYKLJJssmAPLQxHgdfWOfzg5CpLpKa4vsKOu6bYZ+vykDNWSqY0f2dt7gp+lKedUZbiw2O+9v4oh2hL9PCxfMegX5WBfvWBKjpLpGeA4lH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107899; c=relaxed/simple;
	bh=y18JrZ+RKa4FFiODMr7HVly8Elqh7J5PFIpDsoHY7Xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnnhXpw0dImV/X5bHKwvgetazg9RZ/jdSX+P6aZMu+mFtyWwt6vcUbLrbob5R4W2+N9hQTPjDPCpcD0XdIS2fPaw6qNmjyxJHgyP/iah7wz2cqo+US53DKIxqrWqKqsvdPaxzokKce7UuGKrHNGbdRUexR4Daex/jbEUOq31Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fImHCNq3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-854fcb187b2so458013485a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107893; x=1759712693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YV/C30kHxyQuWB9Hp3Rra2QjX9aAIcMuuehexAQLV8=;
        b=fImHCNq3Z+iWOH0FqMxafwEwGN3QB8QUeXbZqbZ8yDThHT2/HRYwWQ0G+6NRO7Jsyn
         omYctiAJvYV1uyXoWM92vaotqfA/gAIVqnbQydQrOmTmsJxdmusjzlvWVOqx8vymBUMa
         dEYTRX/UCSR4qBo7ivPRifZB/+zi34kexc+bo+sRcspYeSik00+0k4aIiajM1p4/Irix
         kSfE11nF5N9EPyt9aeS6l14dnYN5AKZlMEseuTOKkZ4uHD5SDYmh3+FNuubpCsEv6sCY
         x+O5qKEIJxLCOB/anxKcjYpBe+fF0gRPAFQTYj8Snv0puabwP24RI0guVayanVwsyTxO
         zUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107893; x=1759712693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YV/C30kHxyQuWB9Hp3Rra2QjX9aAIcMuuehexAQLV8=;
        b=jAoOY6neaOGduCC4fH9fES3QP3P2CmUtK2YSpODXWMLeTi67zijNd97IsHPgwFNSt0
         0XeJe5LJ96xQJhtqobluOMPyhJ5HmTGwxKS0fpPbWmdlNuOdX4d07TyKOuI4OJcISAVO
         LYlqW37BsaGOH6wyFKf0op0LTQBvx4zoZGeV8DOksaJRIssUBu6GtRWOjpcUuDjOkX8s
         UGbcsSxiKwdcuB3Zx/moxfwRQIX+3PvpNkBfkdJRw4XKr3gy1C+sQt6Un0GP39j2vsKA
         fv1PKbPoIpGCYAWB3j0ed0jC/MmCXjKSl40QVUJjjOzWpq8NhW4Qe4VauV/EI6ubdZz2
         occQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9s2t1xzFEKwJsp9TQj9QJ7XDNwZaBajHtvRV6r5zjpMjWIXRs7CfOnwg2CPZ46Mrnomj2rbxRALY9GGfS@vger.kernel.org
X-Gm-Message-State: AOJu0YwCoqxZgTRUOgbbb1apcFzQIx7xxqncsTnHrA/MZzLqgqZanjMy
	Qlyc2xzJMl2n/4MtNRs5cMU+B7uQemgLJ0tXCjnCFbeTjAfLAuUzQzvWjme136UctQ0=
X-Gm-Gg: ASbGncsx3NWn5ji0woqaLwXk/F54DKgn2aLL8m7HQp+lKhZRkqhqndVuC5Dlklu5jjZ
	EQqvHuSNHMUpgx9reaugTeR+PZzUNvpP55Wq9bO1IEy5ls6SzNsH9nA3nfKfoF2Er/hB1LVtLfq
	c/aTYNIBNZ7Xwr52Lx0pMHyxq/qnTkjuFQAgryO4h2lpPV9hxzo/OTmhEbqLIRJfypFX4YpJ3LM
	YF2flFSOotBtcIvmDutOho7xeg+SFXJlzusxxBMrrVYIf8mHvG7JnkbSchcQBnEeun4/AHqDNHX
	yvvwJX8d8fgpUoJOlpqrb6EXfBxKaxwvfPW0ZDDpSIjwjZC5+d+v5yOJ2ufdH+XehUcL5gGbUFs
	Kr+caZNtSVIx57ijINYkaB3HnO4SLbyl/SCebyhtK0Qexu9Vema2PPWuIYyMzGKQxLkIB0CUHWf
	20LIV9zNyEbr1SRZOo4g==
X-Google-Smtp-Source: AGHT+IE/2gkO6BHU1Wstnbl9JT+BQr3NoLV1YqF2Ma44UH3Fg76MALcfhQNt/9B9O7w+tSiqkpudoA==
X-Received: by 2002:a05:620a:2805:b0:849:8fcc:69e4 with SMTP id af79cd13be357-85ae8c269e3mr1755065285a.68.1759107827446;
        Sun, 28 Sep 2025 18:03:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:46 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 11/30] liveupdate: luo_session: Add sessions support
Date: Mon, 29 Sep 2025 01:03:02 +0000
Message-ID: <20250929010321.3462457-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce concept of "Live Update Sessions" within the LUO framework.
LUO sessions provide a mechanism to group and manage `struct file *`
instances (representing file descriptors) that need to be preserved
across a kexec-based live update.

Each session is identified by a unique name and acts as a container
for file objects whose state is critical to a userspace workload, such
as a virtual machine or a high-performance database, aiming to maintain
their functionality across a kernel transition.

This groundwork establishes the framework for preserving file-backed
state across kernel updates, with the actual file data preservation
mechanisms to be implemented in subsequent patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/liveupdate.h  |   3 +
 kernel/liveupdate/Makefile       |   1 +
 kernel/liveupdate/luo_internal.h |  34 ++
 kernel/liveupdate/luo_session.c  | 607 +++++++++++++++++++++++++++++++
 4 files changed, 645 insertions(+)
 create mode 100644 kernel/liveupdate/luo_session.c

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 3cb09b2c4353..e8c0c210a790 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -91,4 +91,7 @@ enum liveupdate_event {
 	LIVEUPDATE_CANCEL = 3,
 };
 
+/* The maximum length of session name including null termination */
+#define LIVEUPDATE_SESSION_NAME_LENGTH 56
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index 2881bab0c6df..f64cfc92cbf0 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -3,6 +3,7 @@
 luo-y :=								\
 		luo_core.o						\
 		luo_ioctl.o						\
+		luo_session.o						\
 		luo_subsystems.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index c62fbbb0790c..9223f71844ca 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -32,6 +32,40 @@ void *luo_contig_alloc_preserve(size_t size);
 void luo_contig_free_unpreserve(void *mem, size_t size);
 void luo_contig_free_restore(void *mem, size_t size);
 
+/**
+ * struct luo_session - Represents an active or incoming Live Update session.
+ * @name:      A unique name for this session, used for identification and
+ *             retrieval.
+ * @files_xa:  An xarray used to store the files associated with this session.
+ * @ser:       Pointer to the serialized data for this session.
+ * @count:     A counter tracking the number of files currently stored in the
+ *             @files_xa for this session.
+ * @list:      A list_head member used to link this session into a global list
+ *             of either outgoing (to be preserved) or incoming (restored from
+ *             previous kernel) sessions.
+ * @retrieved: A boolean flag indicating whether this session has been retrieved
+ *             by a consumer in the new kernel. Valid only during the
+ *             LIVEUPDATE_STATE_UPDATED state.
+ * @mutex:     Session lock, protects files_xa, and count.
+ * @state:     State of this session: prepared/frozen/updated/normal.
+ * @files:     The physical address of a contiguous memory block that holds
+ *             the serialized state of files.
+ */
+struct luo_session {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	struct xarray files_xa;
+	struct luo_session_ser *ser;
+	long count;
+	struct list_head list;
+	bool retrieved;
+	struct mutex mutex;
+	enum liveupdate_state state;
+	u64 files;
+};
+
+int luo_session_create(const char *name, struct file **filep);
+int luo_session_retrieve(const char *name, struct file **filep);
+
 void luo_subsystems_startup(void *fdt);
 int luo_subsystems_fdt_setup(void *fdt);
 int luo_do_subsystems_prepare_calls(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
new file mode 100644
index 000000000000..74dee42e24b7
--- /dev/null
+++ b/kernel/liveupdate/luo_session.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO Sessions
+ *
+ * LUO Sessions provide the core mechanism for grouping and managing file
+ * descriptors that need to be preserved across a kexec-based live update.
+ * Each session acts as a named container for a set of file objects, allowing
+ * a userspace agent (e.g., a Live Update Orchestration Daemon) to manage the
+ * lifecycle of resources critical to a workload.
+ *
+ * Core Concepts:
+ *
+ * - Named Containers: Sessions are identified by a unique, user-provided name,
+ *   which is used for both creation and retrieval.
+ *
+ * - Userspace Interface: Session management is driven from userspace via
+ *   ioctls on /dev/liveupdate (e.g., CREATE_SESSION, RETRIEVE_SESSION).
+ *
+ * - Serialization: Session metadata is preserved using the KHO framework.
+ *   During the 'prepare' phase, an array of `struct luo_session_ser` is
+ *   allocated and preserved. An FDT node is also created, containing the
+ *   count of sessions and the physical address of this array.
+ *
+ * Session Lifecycle and State Management:
+ *
+ * 1.  Creation: A userspace agent calls `luo_session_create()` to create a new,
+ *     empty session, receiving a file descriptor handle. This can be done in
+ *     the NORMAL or UPDATED states.
+ *
+ * 2.  Name Collision: In the UPDATED state, `luo_session_create()` checks for
+ *     name conflicts against sessions preserved from the previous kernel to
+ *     prevent ambiguity.
+ *
+ * 3.  Preparation (`prepare` callback): When the global LUO PREPARE event is
+ *     triggered, the list of all created sessions is serialized. The main
+ *     `ser` array is allocated, and each active `struct luo_session` is given
+ *     a direct pointer to its corresponding entry in this array.
+ *
+ * 4.  Release After Prepare: When a session FD is closed *after* the PREPARE
+ *     event, the `.release` handler uses the session's direct pointer to
+ *     `memset(0)` its entry in the `ser` array. This effectively marks the
+ *     session as defunct without needing to resize the already-preserved
+ *     memory.
+ *
+ * 5.  Boot (`boot` callback): In the new kernel, the FDT is read to locate
+ *     the preserved `ser` array. The metadata (count, physical address) is
+ *     stored in the `luo_session` global.
+ *
+ * 6.  Lazy Deserialization: The actual `luo_session` list is populated on
+ *     first use (e.g., by `retrieve`, `finish`, or `create`). During this
+ *     process, any zeroed-out entries from step 4 are skipped.
+ *
+ * 7.  Retrieval: The userspace agent calls `luo_session_retrieve()` in the new
+ *     kernel to get a new FD handle for a preserved session by its name.
+ *
+ * 8.  Finalization (`finish` callback): When the global LUO FINISH event is
+ *     sent, any preserved sessions that were successfully retrieved are moved
+ *     to the `luo_session_global` list, making them available for a subsequent
+ *     live update. Any sessions that were not retrieved are considered stale
+ *     and are cleaned up.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/libfdt.h>
+#include <linux/liveupdate.h>
+#include <uapi/linux/liveupdate.h>
+#include "luo_internal.h"
+
+#define LUO_SESSION_NODE_NAME	"luo-session"
+#define LUO_SESSION_COMPATIBLE	"luo-session-v1"
+
+/**
+ * struct luo_session_ser - Represents the serialized metadata for a LUO session.
+ * @name:    The unique name of the session, copied from the `luo_session`
+ *           structure.
+ * @files:   The physical address of a contiguous memory block that holds
+ *           the serialized state of files.
+ * @pgcnt:   The number of pages occupied by the `files` memory block.
+ * @count:   The total number of files that were part of this session during
+ *           serialization. Used for iteration and validation during
+ *           restoration.
+ *
+ * This structure is used to package session-specific metadata for transfer
+ * between kernels via Kexec Handover. An array of these structures (one per
+ * session) is created and passed to the new kernel, allowing it to reconstruct
+ * the session context.
+ *
+ * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
+ */
+struct luo_session_ser {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	u64 files;
+	u64 pgcnt;
+	u64 count;
+} __packed;
+
+/**
+ * struct luo_session_global - Global container for managing LUO sessions.
+ * @count: The number of sessions currently tracked in the @list.
+ * @list:  The head of the linked list of `struct luo_session` instances.
+ * @rwsem: A read-write semaphore providing synchronized access to the session
+ *         list and other fields in this structure.
+ * @ser:   A pointer to the contiguous block of memory holding the serialized
+ *         session data (an array of `struct luo_session_ser`). For `_out`, this
+ *         is allocated and populated during `prepare`. For `_in`, this points
+ *         to the data restored from the previous kernel.
+ * @pgcnt: The size, in pages, of the memory block pointed to by @ser.
+ * @fdt:   A pointer to the FDT blob that contains the metadata for this group
+ *         of sessions. This FDT is what is ultimately passed to the parent LUO
+ *         subsystem for preservation.
+ */
+struct luo_session_global {
+	long count;
+	struct list_head list;
+	struct rw_semaphore rwsem;
+	struct luo_session_ser *ser;
+	u64 pgcnt;
+	void *fdt;
+	long ser_count;
+};
+
+static struct luo_session_global luo_session_global;
+
+static struct luo_session *luo_session_alloc(const char *name)
+{
+	struct luo_session *session = kzalloc(sizeof(*session), GFP_KERNEL);
+
+	if (!session)
+		return NULL;
+
+	strscpy(session->name, name, sizeof(session->name));
+	xa_init(&session->files_xa);
+	session->count = 0;
+	INIT_LIST_HEAD(&session->list);
+	mutex_init(&session->mutex);
+	session->state = LIVEUPDATE_STATE_NORMAL;
+
+	return session;
+}
+
+static void luo_session_free(struct luo_session *session)
+{
+	WARN_ON(session->count);
+	xa_destroy(&session->files_xa);
+	mutex_destroy(&session->mutex);
+	kfree(session);
+}
+
+static int luo_session_insert(struct luo_session *session)
+{
+	struct luo_session *it;
+
+	lockdep_assert_held_write(&luo_session_global.rwsem);
+	/*
+	 * For small number of sessions this loop won't hurt performance
+	 * but if we ever start using a lot of sessions, this might
+	 * become a bottle neck during deserialization time, as it would
+	 * cause O(n*n) complexity.
+	 */
+	list_for_each_entry(it, &luo_session_global.list, list) {
+		if (!strncmp(it->name, session->name, sizeof(it->name)))
+			return -EEXIST;
+	}
+	list_add_tail(&session->list, &luo_session_global.list);
+	luo_session_global.count++;
+
+	return 0;
+}
+
+static void luo_session_remove(struct luo_session *session)
+{
+	lockdep_assert_held_write(&luo_session_global.rwsem);
+	list_del(&session->list);
+	luo_session_global.count--;
+}
+
+/* One session switches from the updated state to  normal state */
+static void luo_session_finish_one(struct luo_session *session)
+{
+}
+
+/* Cancel one session from frozen or prepared state, back to normal */
+static void luo_session_cancel_one(struct luo_session *session)
+{
+}
+
+/* One session is changed from normal to prepare state */
+static int luo_session_prepare_one(struct luo_session *session)
+{
+	return 0;
+}
+
+static int luo_session_release(struct inode *inodep, struct file *filep)
+{
+	struct luo_session *session = filep->private_data;
+
+	scoped_guard(rwsem_read, &luo_session_global.rwsem) {
+		scoped_guard(mutex, &session->mutex) {
+			if (session->ser) {
+				memset(session->ser, 0,
+				       sizeof(struct luo_session_ser));
+			}
+		}
+	}
+
+	if (session->state == LIVEUPDATE_STATE_UPDATED)
+		luo_session_finish_one(session);
+	if (session->state == LIVEUPDATE_STATE_PREPARED ||
+	    session->state == LIVEUPDATE_STATE_FROZEN) {
+		luo_session_cancel_one(session);
+	}
+
+	scoped_guard(rwsem_write, &luo_session_global.rwsem)
+		luo_session_remove(session);
+	luo_session_free(session);
+
+	return 0;
+}
+
+static const struct file_operations luo_session_fops = {
+	.owner = THIS_MODULE,
+	.release = luo_session_release,
+};
+
+static void luo_session_deserialize(void)
+{
+	static int visited;
+	int i;
+
+	if (visited)
+		return;
+
+	guard(rwsem_write)(&luo_session_global.rwsem);
+	if (visited)
+		return;
+	visited++;
+	for (i = 0; i < luo_session_global.ser_count; i++) {
+		struct luo_session *session;
+
+		/*
+		 * If there is no name, this session was remove from
+		 * preservation after prepare. So, skip it.
+		 */
+		if (!luo_session_global.ser[i].name[0])
+			continue;
+
+		session = luo_session_alloc(luo_session_global.ser[i].name);
+		if (!session)
+			luo_restore_fail("Failed to allocate session on boot\n");
+
+		if (luo_session_insert(session)) {
+			luo_restore_fail("Failed to insert session due to name conflict [%s]\n",
+					 session->name);
+		}
+
+		session->state = LIVEUPDATE_STATE_UPDATED;
+		session->count = luo_session_global.ser[i].count;
+		session->files = luo_session_global.ser[i].files;
+	}
+}
+
+/* Create a "struct file" for session, and delete it on case of failure */
+static int luo_session_getfile(struct luo_session *session, struct file **filep)
+{
+	char name_buf[128];
+	struct file *file;
+
+	scoped_guard(mutex, &session->mutex) {
+		lockdep_assert_held(&session->mutex);
+		snprintf(name_buf, sizeof(name_buf), "[luo_session] %s",
+			 session->name);
+		file = anon_inode_getfile(name_buf, &luo_session_fops, session,
+					  O_RDWR);
+	}
+	if (IS_ERR(file)) {
+		scoped_guard(rwsem_write, &luo_session_global.rwsem)
+			luo_session_remove(session);
+		luo_session_free(session);
+		return PTR_ERR(file);
+	}
+
+	*filep = file;
+	return 0;
+}
+
+int luo_session_create(const char *name, struct file **filep)
+{
+	struct luo_session *session;
+	int ret;
+
+	guard(rwsem_read)(&luo_state_rwsem);
+
+	/* New sessions cannot be added after prepared state */
+	if (!liveupdate_state_normal() && !liveupdate_state_updated())
+		return -EAGAIN;
+
+	session = luo_session_alloc(name);
+	if (!session)
+		return -ENOMEM;
+
+	scoped_guard(rwsem_write, &luo_session_global.rwsem)
+		ret = luo_session_insert(session);
+	if (ret) {
+		luo_session_free(session);
+		return ret;
+	}
+
+	return luo_session_getfile(session, filep);
+}
+
+int luo_session_retrieve(const char *name, struct file **filep)
+{
+	struct luo_session *session = NULL;
+	struct luo_session *it;
+
+	guard(rwsem_read)(&luo_state_rwsem);
+
+	/* Can only retrieve in the updated state */
+	if (!liveupdate_state_updated())
+		return -EAGAIN;
+
+	luo_session_deserialize();
+	scoped_guard(rwsem_read, &luo_session_global.rwsem) {
+		list_for_each_entry(it, &luo_session_global.list, list) {
+			if (!strncmp(it->name, name, sizeof(it->name))) {
+				session = it;
+				break;
+			}
+		}
+	}
+
+	if (!session)
+		return -ENOENT;
+
+	scoped_guard(mutex, &session->mutex) {
+		/*
+		 * Session already retrieved or a session with the same name was
+		 * created during updated state
+		 */
+		if (session->retrieved || session->state != LIVEUPDATE_STATE_UPDATED)
+			return -EADDRINUSE;
+
+		session->retrieved = true;
+	}
+
+	return luo_session_getfile(session, filep);
+}
+
+static void luo_session_global_preserved_cleanup(void)
+{
+	lockdep_assert_held_write(&luo_session_global.rwsem);
+	if (luo_session_global.ser && !IS_ERR(luo_session_global.ser)) {
+		luo_contig_free_unpreserve(luo_session_global.ser,
+					   luo_session_global.pgcnt << PAGE_SHIFT);
+	}
+	if (luo_session_global.fdt && !IS_ERR(luo_session_global.fdt))
+		luo_contig_free_unpreserve(luo_session_global.fdt, PAGE_SIZE);
+
+	luo_session_global.fdt = NULL;
+	luo_session_global.ser = NULL;
+	luo_session_global.ser_count = 0;
+	luo_session_global.pgcnt = 0;
+}
+
+static int luo_session_fdt_setup(void)
+{
+	u64 ser_pa;
+	int ret;
+
+	lockdep_assert_held_write(&luo_session_global.rwsem);
+	luo_session_global.pgcnt = DIV_ROUND_UP(luo_session_global.count *
+				sizeof(struct luo_session_ser), PAGE_SIZE);
+
+	if (luo_session_global.pgcnt > 0) {
+		size_t ser_size = luo_session_global.pgcnt << PAGE_SHIFT;
+
+		luo_session_global.ser = luo_contig_alloc_preserve(ser_size);
+		if (IS_ERR(luo_session_global.ser)) {
+			ret = PTR_ERR(luo_session_global.ser);
+			goto exit_cleanup;
+		}
+	}
+
+	luo_session_global.fdt = luo_contig_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(luo_session_global.fdt)) {
+		ret = PTR_ERR(luo_session_global.fdt);
+		goto exit_cleanup;
+	}
+
+	ret = fdt_create(luo_session_global.fdt, PAGE_SIZE);
+	if (ret < 0)
+		goto exit_cleanup;
+
+	ret = fdt_finish_reservemap(luo_session_global.fdt);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_begin_node(luo_session_global.fdt, LUO_SESSION_NODE_NAME);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_property_string(luo_session_global.fdt, "compatible",
+				  LUO_SESSION_COMPATIBLE);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ret = fdt_property_u64(luo_session_global.fdt, "count",
+			       luo_session_global.count);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ser_pa = luo_session_global.ser ? __pa(luo_session_global.ser) : 0;
+	ret = fdt_property_u64(luo_session_global.fdt, "data", ser_pa);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ret = fdt_property_u64(luo_session_global.fdt, "pgcnt",
+			       luo_session_global.pgcnt);
+	if (ret < 0)
+		goto exit_end_node;
+
+	ret = fdt_end_node(luo_session_global.fdt);
+	if (ret < 0)
+		goto exit_finish;
+
+	ret = fdt_finish(luo_session_global.fdt);
+	if (ret < 0)
+		goto exit_cleanup;
+
+	return 0;
+
+exit_end_node:
+	fdt_end_node(luo_session_global.fdt);
+exit_finish:
+	fdt_finish(luo_session_global.fdt);
+exit_cleanup:
+	luo_session_global_preserved_cleanup();
+
+	return ret;
+}
+
+/*
+ * Change all sessions to normal state: make every file within each session
+ * to be in the normal state.
+ */
+static void luo_session_cancel(struct liveupdate_subsystem *h, u64 data)
+{
+	struct luo_session *it;
+
+	guard(rwsem_write)(&luo_session_global.rwsem);
+	list_for_each_entry(it, &luo_session_global.list, list)
+		luo_session_cancel_one(it);
+	luo_session_global_preserved_cleanup();
+}
+
+static int luo_session_prepare(struct liveupdate_subsystem *h, u64 *data)
+{
+	struct luo_session_ser *ser;
+	struct luo_session *it;
+	int ret;
+
+	scoped_guard(rwsem_write, &luo_session_global.rwsem) {
+		ret = luo_session_fdt_setup();
+		if (ret)
+			return ret;
+
+		ser = luo_session_global.ser;
+		list_for_each_entry(it, &luo_session_global.list, list) {
+			if (it->state == LIVEUPDATE_STATE_NORMAL) {
+				ret = luo_session_prepare_one(it);
+				if (ret)
+					break;
+			}
+			strscpy(ser->name, it->name, sizeof(ser->name));
+			ser->count = it->count;
+			ser->files = it->files;
+			it->ser = ser;
+			ser++;
+		}
+
+		if (!ret)
+			*data = __pa(luo_session_global.fdt);
+	}
+
+	if (ret)
+		luo_session_cancel(h, 0);
+
+	return ret;
+}
+
+static int luo_session_freeze(struct liveupdate_subsystem *h, u64 *data)
+{
+	return 0;
+}
+
+/*
+ * Finish every file within each session. If session has not been reclaimed
+ * remove it, otherwise keep this session, so it can participate in the
+ * next live update.
+ */
+static void luo_session_finish(struct liveupdate_subsystem *h, u64 data)
+{
+	struct luo_session *session, *tmp;
+
+	luo_session_deserialize();
+
+	list_for_each_entry_safe(session, tmp, &luo_session_global.list, list) {
+		/*
+		 * Skip sessions that were created in new kernel or have been
+		 * finished already.
+		 */
+		if (session->state != LIVEUPDATE_STATE_UPDATED)
+			continue;
+		luo_session_finish_one(session);
+		if (!session->retrieved) {
+			pr_warn("Removing unreclaimed session[%s]\n",
+				session->name);
+			scoped_guard(rwsem_write, &luo_session_global.rwsem)
+				luo_session_remove(session);
+			luo_session_free(session);
+		}
+	}
+
+	scoped_guard(rwsem_write, &luo_session_global.rwsem)
+		luo_session_global_preserved_cleanup();
+}
+
+static void luo_session_boot(struct liveupdate_subsystem *h, u64 data)
+{
+	u64 count, data_pa, pgcnt;
+	const void *prop;
+	int prop_len;
+	void *fdt;
+
+	fdt = __va(data);
+	if (fdt_node_check_compatible(fdt, 0, LUO_SESSION_COMPATIBLE))
+		luo_restore_fail("luo-session FDT incompatible\n");
+
+	prop = fdt_getprop(fdt, 0, "count", &prop_len);
+	if (!prop || prop_len != sizeof(u64))
+		luo_restore_fail("luo-session FDT missing or invalid 'count'\n");
+	count = be64_to_cpup(prop);
+
+	prop = fdt_getprop(fdt, 0, "data", &prop_len);
+	if (!prop || prop_len != sizeof(u64))
+		luo_restore_fail("luo-session FDT missing or invalid 'data'\n");
+	data_pa = be64_to_cpup(prop);
+
+	prop = fdt_getprop(fdt, 0, "pgcnt", &prop_len);
+	if (!prop || prop_len != sizeof(u64))
+		luo_restore_fail("luo-session FDT missing or invalid 'pgcnt'\n");
+	pgcnt = be64_to_cpup(prop);
+
+	if (!count)
+		return;
+
+	guard(rwsem_write)(&luo_session_global.rwsem);
+	luo_session_global.fdt = fdt;
+	luo_session_global.ser = __va(data_pa);
+	luo_session_global.ser_count = count;
+	luo_session_global.pgcnt = pgcnt;
+}
+
+static const struct liveupdate_subsystem_ops luo_session_subsys_ops = {
+	.prepare = luo_session_prepare,
+	.freeze = luo_session_freeze,
+	.cancel = luo_session_cancel,
+	.boot = luo_session_boot,
+	.finish = luo_session_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_subsystem luo_session_subsys = {
+	.ops = &luo_session_subsys_ops,
+	.name = LUO_SESSION_COMPATIBLE,
+};
+
+static int __init luo_session_startup(void)
+{
+	int ret;
+
+	if (!liveupdate_enabled())
+		return 0;
+
+	init_rwsem(&luo_session_global.rwsem);
+	INIT_LIST_HEAD(&luo_session_global.list);
+
+	ret = liveupdate_register_subsystem(&luo_session_subsys);
+	if (ret) {
+		pr_warn("Failed to register luo_session subsystem [%d]\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+late_initcall(luo_session_startup);
-- 
2.51.0.536.g15c5d4f767-goog


