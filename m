Return-Path: <linux-fsdevel+bounces-68581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BC9C60D44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538974E871D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF828C860;
	Sat, 15 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eILqezXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C8280330
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249682; cv=none; b=gKwSGofcVPEKj8FDVPJ1xIbbSL7kdIs62L7JcuZiqYO+GupMr8mCoFXJb1JU1dAhyOwt5u1T295oLX8XysVJcr5KFUzJfEzEJxggfVfx3RDKwEOUalk6KtEccoaFyrp/UO9TRHm+p5S6XFZkA07NPky4+6BltqWDIjwfLFQIYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249682; c=relaxed/simple;
	bh=fA9qK8MUzM7dL9JdYokqTDAEIy1y2cay9xGJX4+k77k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLVbPpYfMG5bkkFgI1+2laJest7oyZfACRYdB9mU9xztfnFb5SNtuRFMDeL+AUMfX+1gjClfOVmBq8DElDG4LBxvKJym89WyB3KJyIln5+SjAMjrBIzV20elaefGTAYAnovda9TD2Fs0sk2DYSjAS3tlvDkZqAxSbNQmLdx8Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eILqezXt; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63fc6115d65so2974765d50.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249676; x=1763854476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkLBy5NcjxjmnDRSa+ox2cXiOPEVeruJrbcFG+QjG9I=;
        b=eILqezXtWYW0RhCPUoy/GQIfKpFZ/bH7vVQXQ1DXOlAiEfBtlWOP+hrvOGcV/9pzB+
         osK5sJkz1guQCSJ1Qk4AuxunO0RJ7ebX0B1ANHhQBDebDFFPZ9H8+g4f75G56KU7pmkb
         g5AsfaXtLvUpJyD4Fay+8rBIhNpLksjSbmysXRuHssrRxezlqOKKa01woxaVMCbLCPRw
         8MWbPXUjP/up2qzPQ11SKGpsNa0KyR8/ZoNO5CLBc+qrfeVnzr+AKN/TbfGvxXkq42QU
         4rkAysVgm5yhta6J9T5zRtBPZeaDQIGjudJAGVKuRP3L+7tnjf5hdYNsmuLElim1E28d
         GyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249676; x=1763854476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkLBy5NcjxjmnDRSa+ox2cXiOPEVeruJrbcFG+QjG9I=;
        b=KcuIhQvh69M5QloVwta7EAV3EEBI10RnZkme3BUn34i5rsXQL64m3WDsOzpEWazz5I
         K1GLi0mTlybzIdh9IxgudBkuF7CzPKe1kpze7ThaVQw/Pjvt9ra1ub7QfJFvl4MBeVGY
         BgrpPr5C2ijsS/kk8rZV8m2Zag2rs+4wDPrmEYNJZ/18AH+R+oN108LOAIj5zq8xeLgJ
         CRTT7QYFyyycfHmIeEJt+HfFVFgcGOdYTGwClV++Ke6vIYXnmc+idpqqqe5NRTzZbiZ+
         STN6O/kG+YjeGowl04JMyL4a25HEkOfkPLTqA9Nmelg6PNcxEy9z3RdjZfphF4yWFWjE
         Jhig==
X-Forwarded-Encrypted: i=1; AJvYcCX2SQ6jrIQ4tzDXsS8Uxo166YsWl1em9AFyVdcIjzoARCTYz97Tcbt/Q9/d9D37QQnwyfpJWXEugEFYWso2@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVPleMJqd86f1nkgsRYqFR87qfrRsSCABLKlA6qcM0bZzNpPh
	iQML2COj4C8J+6g6h7fNiDwF0+hdEzXQIIN4Em8ELnXR2cAY1Gfu6i/TGE9Zybsslbw=
X-Gm-Gg: ASbGnctXB420tXhI131pHFkYHuo/vpZiKRxKBgLLWzQwJWFyJNJ5xyg5PaShI/MZWJ1
	otiM6KL+I+zW0GfrgAT3gMM41O1hVwsQ4XG/MVvFBCe0hvqHPrcSSjOD8eoLPDa7F/EoU3wxrs/
	qF6Hi9+evs1LxViIJjOK80EUrraEkodNEf21BzC3VBrj4hEpCml+vAPOYnGfCNNap+0rO1FZ533
	Z53WzQHe5+HY7hvntZ372oXSziLkHOa4p0Me8nRljHlb6uYJJmq0kkoduMLynjmyFmqHYT2rr0O
	o+6ynCAL5/40Xn+W4Epv2VY2eptDUBrLw81G9S/6soPvzTwuEDYPb52egIpDMM3JuQOccdtygUx
	MC6SjLh0fUHqLQ+jDAAl9d3WR2Q1IfQrg/mwNsa5CCSS+VI2IcA8B1PaLyiIi9C5NTmifECkn0A
	LzuZ/euceD5SENKszypCFkbvdHGcD5+Dv5jUSzfPpPTPMJ3q0s4sL3fjzwMc21W2jfz2Pir+js2
	+M9BNHpyR5YY+P3TQ==
X-Google-Smtp-Source: AGHT+IFqBK5iMM31s+FqHmn8pdAdCSPYUkP2man/XA08raYdv8kc6CVKrxPoKXomFKoeJQioPCeg+g==
X-Received: by 2002:a05:690e:4289:20b0:640:d23d:3753 with SMTP id 956f58d0204a3-641e75e6195mr5932504d50.38.1763249675514;
        Sat, 15 Nov 2025 15:34:35 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:35 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	chrisl@kernel.org
Subject: [PATCH v6 08/20] liveupdate: luo_flb: Introduce File-Lifecycle-Bound global state
Date: Sat, 15 Nov 2025 18:33:54 -0500
Message-ID: <20251115233409.768044-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a mechanism for managing global kernel state whose lifecycle
is tied to the preservation of one or more files. This is necessary for
subsystems where multiple preserved file descriptors depend on a single,
shared underlying resource.

An example is HugeTLB, where multiple file descriptors such as memfd and
guest_memfd may rely on the state of a single HugeTLB subsystem.
Preserving this state for each individual file would be redundant and
incorrect. The state should be preserved only once when the first file
is preserved, and restored/finished only once the last file is handled.

This patch introduces File-Lifecycle-Bound (FLB) objects to solve this
problem. An FLB is a global, reference-counted object with a defined set
of operations:

- A file handler (struct liveupdate_file_handler) declares a dependency
  on one or more FLBs via a new registration function,
  liveupdate_register_flb().
- When the first file depending on an FLB is preserved, the FLB's
  .preserve() callback is invoked to save the shared global state. The
  reference count is then incremented for each subsequent file.
- Conversely, when the last file is unpreserved (before reboot) or
  finished (after reboot), the FLB's .unpreserve() or .finish() callback
  is invoked to clean up the global resource.

The implementation includes:

- A new set of ABI definitions (luo_flb_ser, luo_flb_head_ser) and a
  corresponding FDT node (luo-flb) to serialize the state of all active
  FLBs and pass them via Kexec Handover.
- Core logic in luo_flb.c to manage FLB registration, reference
  counting, and the invocation of lifecycle callbacks.
- An API (liveupdate_flb_*_locked/*_unlock) for other kernel subsystems
  to safely access the live object managed by an FLB, both before and
  after the live update.

This framework provides the necessary infrastructure for more complex
subsystems like IOMMU, VFIO, and KVM to integrate with the Live Update
Orchestrator.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h         | 116 +++++
 include/linux/liveupdate/abi/luo.h |  76 ++++
 kernel/liveupdate/Makefile         |   1 +
 kernel/liveupdate/luo_core.c       |   7 +-
 kernel/liveupdate/luo_file.c       |   8 +
 kernel/liveupdate/luo_flb.c        | 658 +++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h   |   7 +
 7 files changed, 872 insertions(+), 1 deletion(-)
 create mode 100644 kernel/liveupdate/luo_flb.c

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 4a5d4dd9905a..36a831ae3ead 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -14,6 +14,7 @@
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_file_handler;
+struct liveupdate_flb;
 struct liveupdate_session;
 struct file;
 
@@ -81,6 +82,7 @@ struct liveupdate_file_ops {
  *                      associated with individual &struct file instances.
  * @list:               Used for linking this handler instance into a global
  *                      list of registered file handlers.
+ * @flb_list:           A list of FLB dependencies.
  *
  * Modules that want to support live update for specific file types should
  * register an instance of this structure. LUO uses this registration to
@@ -91,6 +93,80 @@ struct liveupdate_file_handler {
 	const struct liveupdate_file_ops *ops;
 	const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
 	struct list_head list;
+	struct list_head flb_list;
+};
+
+/**
+ * struct liveupdate_flb_op_args - Arguments for FLB operation callbacks.
+ * @flb:       The global FLB instance for which this call is performed.
+ * @data:      For .preserve():    [OUT] The callback sets this field.
+ *             For .unpreserve():  [IN]  The handle from .preserve().
+ *             For .retrieve():    [IN]  The handle from .preserve().
+ * @obj:       For .preserve():    [OUT] Sets this to the live object.
+ *             For .retrieve():    [OUT] Sets this to the live object.
+ *             For .finish():      [IN]  The live object from .retrieve().
+ *
+ * This structure bundles all parameters for the FLB operation callbacks.
+ */
+struct liveupdate_flb_op_args {
+	struct liveupdate_flb *flb;
+	u64 data;
+	void *obj;
+};
+
+/**
+ * struct liveupdate_flb_ops - Callbacks for global File-Lifecycle-Bound data.
+ * @preserve:        Called when the first file using this FLB is preserved.
+ *                   The callback must save its state and return a single,
+ *                   self-contained u64 handle by setting the 'argp->data'
+ *                   field and 'argp->obj'.
+ * @unpreserve:      Called when the last file using this FLB is unpreserved
+ *                   (aborted before reboot). Receives the handle via
+ *                   'argp->data' and live object via 'argp->obj'.
+ * @retrieve:        Called on-demand in the new kernel, the first time a
+ *                   component requests access to the shared object. It receives
+ *                   the preserved handle via 'argp->data' and must reconstruct
+ *                   the live object, returning it by setting the 'argp->obj'
+ *                   field.
+ * @finish:          Called in the new kernel when the last file using this FLB
+ *                   is finished. Receives the live object via 'argp->obj' for
+ *                   cleanup.
+ * @owner:           Module reference
+ *
+ * Operations that manage global shared data with file bound lifecycle,
+ * triggered by the first file that uses it and concluded by the last file that
+ * uses it, across all sessions.
+ */
+struct liveupdate_flb_ops {
+	int (*preserve)(struct liveupdate_flb_op_args *argp);
+	void (*unpreserve)(struct liveupdate_flb_op_args *argp);
+	int (*retrieve)(struct liveupdate_flb_op_args *argp);
+	void (*finish)(struct liveupdate_flb_op_args *argp);
+	struct module *owner;
+};
+
+/**
+ * struct liveupdate_flb - A global definition for a shared data object.
+ * @ops:         Callback functions
+ * @compatible:  The compatibility string (e.g., "iommu-core-v1"
+ *               that uniquely identifies the FLB type this handler
+ *               supports. This is matched against the compatible string
+ *               associated with individual &struct liveupdate_flb
+ *               instances.
+ * @list:        A global list of registered FLBs.
+ * @internal:    Internal state, set in liveupdate_init_flb().
+ *
+ * This struct is the "template" that a driver registers to define a shared,
+ * file-lifecycle-bound object. The actual runtime state (the live object,
+ * refcount, etc.) is managed internally by the LUO core.
+ * Use liveupdate_init_flb() to initialize this struct before using it in
+ * other functions.
+ */
+struct liveupdate_flb {
+	const struct liveupdate_flb_ops *ops;
+	const char compatible[LIVEUPDATE_FLB_COMPAT_LENGTH];
+	struct list_head list;
+	void *internal;
 };
 
 #ifdef CONFIG_LIVEUPDATE
@@ -111,6 +187,17 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
 
+/* Before using FLB for the first time it should be initialized */
+int liveupdate_init_flb(struct liveupdate_flb *flb);
+
+int liveupdate_register_flb(struct liveupdate_file_handler *h,
+			    struct liveupdate_flb *flb);
+
+int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj);
+int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
@@ -140,5 +227,34 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline int liveupdate_init_flb(struct liveupdate_flb *flb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_register_flb(struct liveupdate_file_handler *h,
+					  struct liveupdate_flb *flb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb,
+						 void **objp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb,
+						  void *obj) { }
+
+static inline int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb,
+						 void **objp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb,
+						  void *obj) { }
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
index 3a596ca1907b..85596ce68c16 100644
--- a/include/linux/liveupdate/abi/luo.h
+++ b/include/linux/liveupdate/abi/luo.h
@@ -33,6 +33,11 @@
  *             compatible = "luo-session-v1";
  *             luo-session-header = <phys_addr_of_session_header_ser>;
  *         };
+ *
+ *         luo-flb {
+ *             compatible = "luo-flb-v1";
+ *             luo-flb-header = <phys_addr_of_flb_header_ser>;
+ *         };
  *     };
  *
  * Main LUO Node (/):
@@ -52,6 +57,17 @@
  *     is the header for a contiguous block of memory containing an array of
  *     `struct luo_session_ser`, one for each preserved session.
  *
+ * File-Lifecycle-Bound Node (luo-flb):
+ *   This node describes all preserved global objects whose lifecycle is bound
+ *   to that of the preserved files (e.g., shared IOMMU state).
+ *
+ *   - compatible: "luo-flb-v1"
+ *     Identifies the FLB ABI version.
+ *   - luo-flb-header: u64
+ *     The physical address of a `struct luo_flb_header_ser`. This structure is
+ *     the header for a contiguous block of memory containing an array of
+ *     `struct luo_flb_ser`, one for each preserved global object.
+ *
  * Serialization Structures:
  *   The FDT properties point to memory regions containing arrays of simple,
  *   `__packed` structures. These structures contain the actual preserved state.
@@ -70,6 +86,16 @@
  *     Metadata for a single preserved file. Contains the `compatible` string to
  *     find the correct handler in the new kernel, a user-provided `token` for
  *     identification, and an opaque `data` handle for the handler to use.
+ *
+ *   - struct luo_flb_header_ser:
+ *     Header for the FLB array. Contains the total page count of the
+ *     preserved memory block and the number of `struct luo_flb_ser` entries
+ *     that follow.
+ *
+ *   - struct luo_flb_ser:
+ *     Metadata for a single preserved global object. Contains its `name`
+ *     (compatible string), an opaque `data` handle, and the `count`
+ *     number of files depending on it.
  */
 
 #ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
@@ -154,4 +180,54 @@ struct luo_file_ser {
 	u64 token;
 } __packed;
 
+/* The max size is set so it can be reliably used during in serialization */
+#define LIVEUPDATE_FLB_COMPAT_LENGTH	48
+
+#define LUO_FDT_FLB_NODE_NAME	"luo-flb"
+#define LUO_FDT_FLB_COMPATIBLE	"luo-flb-v1"
+#define LUO_FDT_FLB_HEADER	"luo-flb-header"
+
+/**
+ * struct luo_flb_header_ser - Header for the serialized FLB data block.
+ * @pgcnt: The total number of pages occupied by the entire preserved memory
+ *         region, including this header and the subsequent array of
+ *         &struct luo_flb_ser entries.
+ * @count: The number of &struct luo_flb_ser entries that follow this header
+ *         in the memory block.
+ *
+ * This structure is located at the physical address specified by the
+ * `LUO_FDT_FLB_HEADER` FDT property. It provides the new kernel with the
+ * necessary information to find and iterate over the array of preserved
+ * File-Lifecycle-Bound objects and to manage the underlying memory.
+ *
+ * If this structure is modified, LUO_FDT_FLB_COMPATIBLE must be updated.
+ */
+struct luo_flb_header_ser {
+	u64 pgcnt;
+	u64 count;
+} __packed;
+
+/**
+ * struct luo_flb_ser - Represents the serialized state of a single FLB object.
+ * @name:    The unique compatibility string of the FLB object, used to find the
+ *           corresponding &struct liveupdate_flb handler in the new kernel.
+ * @data:    The opaque u64 handle returned by the FLB's .preserve() operation
+ *           in the old kernel. This handle encapsulates the entire state needed
+ *           for restoration.
+ * @count:   The reference count at the time of serialization; i.e., the number
+ *           of preserved files that depended on this FLB. This is used by the
+ *           new kernel to correctly manage the FLB's lifecycle.
+ *
+ * An array of these structures is created in a preserved memory region and
+ * passed to the new kernel. Each entry allows the LUO core to restore one
+ * global, shared object.
+ *
+ * If this structure is modified, LUO_FDT_FLB_COMPATIBLE must be updated.
+ */
+struct luo_flb_ser {
+	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
+	u64 data;
+	u64 count;
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index c2252a2ad7bd..8d5a8354ad5a 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -3,6 +3,7 @@
 luo-y :=								\
 		luo_core.o						\
 		luo_file.o						\
+		luo_flb.o						\
 		luo_ioctl.o						\
 		luo_session.o
 
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 653cdca5e25d..7c3932b6f96f 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -122,7 +122,9 @@ static int __init luo_early_startup(void)
 	if (err)
 		return err;
 
-	return 0;
+	err = luo_flb_setup_incoming(luo_global.fdt_in);
+
+	return err;
 }
 
 static int __init liveupdate_early_init(void)
@@ -159,6 +161,7 @@ static int __init luo_fdt_setup(void)
 	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
 	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
 	err |= luo_session_setup_outgoing(fdt_out);
+	err |= luo_flb_setup_outgoing(fdt_out);
 	err |= fdt_end_node(fdt_out);
 	err |= fdt_finish(fdt_out);
 	if (err)
@@ -220,6 +223,8 @@ int liveupdate_reboot(void)
 	if (err)
 		return err;
 
+	luo_flb_serialize();
+
 	err = kho_finalize();
 	if (err) {
 		pr_err("kho_finalize failed %d\n", err);
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index dae27a69a09f..3d3bd84cb281 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -282,6 +282,10 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 	if (err)
 		goto exit_err;
 
+	err = luo_flb_file_preserve(fh);
+	if (err)
+		goto exit_err;
+
 	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
 	if (!luo_file) {
 		err = -ENOMEM;
@@ -301,6 +305,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 	if (err) {
 		mutex_destroy(&luo_file->mutex);
 		kfree(luo_file);
+		luo_flb_file_unpreserve(fh);
 		goto exit_err;
 	} else {
 		luo_file->serialized_data = args.serialized_data;
@@ -352,6 +357,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		luo_file->fh->ops->unpreserve(&args);
+		luo_flb_file_unpreserve(luo_file->fh);
 
 		list_del(&luo_file->list);
 		session->count--;
@@ -624,6 +630,7 @@ static void luo_file_finish_one(struct luo_session *session,
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieved = luo_file->retrieved;
+	luo_flb_file_finish(luo_file->fh);
 
 	luo_file->fh->ops->finish(&args);
 }
@@ -815,6 +822,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 		return -EAGAIN;
 
 	INIT_LIST_HEAD(&fh->list);
+	INIT_LIST_HEAD(&fh->flb_list);
 	list_add_tail(&fh->list, &luo_file_handler_list);
 
 	return 0;
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
new file mode 100644
index 000000000000..47fcd3d74eb5
--- /dev/null
+++ b/kernel/liveupdate/luo_flb.c
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: LUO File Lifecycle Bound Global Data
+ *
+ * File-Lifecycle-Bound (FLB) objects provide a mechanism for managing global
+ * state that is shared across multiple live-updatable files. The lifecycle of
+ * this shared state is tied to the preservation of the files that depend on it.
+ *
+ * An FLB represents a global resource, such as the IOMMU core state, that is
+ * required by multiple file descriptors (e.g., all VFIO fds).
+ *
+ * The preservation of the FLB's state is triggered when the *first* file
+ * depending on it is preserved. The cleanup of this state (unpreserve or
+ * finish) is triggered when the *last* file depending on it is unpreserved or
+ * finished.
+ *
+ * Handler Dependency: A file handler declares its dependency on one or more
+ * FLBs by registering them via liveupdate_register_flb().
+ *
+ * Callback Model: Each FLB is defined by a set of operations
+ * (&struct liveupdate_flb_ops) that LUO invokes at key points:
+ *
+ *     - .preserve(): Called for the first file. Saves global state.
+ *     - .unpreserve(): Called for the last file (if aborted pre-reboot).
+ *     - .retrieve(): Called on-demand in the new kernel to restore the state.
+ *     - .finish(): Called for the last file in the new kernel for cleanup.
+ *
+ * This reference-counted approach ensures that shared state is saved exactly
+ * once and restored exactly once, regardless of how many files depend on it,
+ * and that its lifecycle is correctly managed across the kexec transition.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/liveupdate.h>
+#include <linux/liveupdate/abi/luo.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+#include "luo_internal.h"
+
+#define LUO_FLB_PGCNT		1ul
+#define LUO_FLB_MAX		(((LUO_FLB_PGCNT << PAGE_SHIFT) -	\
+		sizeof(struct luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
+
+struct luo_flb_header {
+	struct luo_flb_header_ser *header_ser;
+	struct luo_flb_ser *ser;
+	bool active;
+};
+
+struct luo_flb_global {
+	struct luo_flb_header incoming;
+	struct luo_flb_header outgoing;
+	struct list_head list;
+	long count;
+};
+
+static struct luo_flb_global luo_flb_global = {
+	.list = LIST_HEAD_INIT(luo_flb_global.list),
+};
+
+/*
+ * struct luo_flb_link - Links an FLB definition to a file handler's internal
+ * list of dependencies.
+ * @flb:  A pointer to the registered &struct liveupdate_flb definition.
+ * @list: The list_head for linking.
+ */
+struct luo_flb_link {
+	struct liveupdate_flb *flb;
+	struct list_head list;
+};
+
+/*
+ * struct luo_flb_state - Holds the runtime state for one FLB lifecycle path.
+ * @count: The number of preserved files currently depending on this FLB.
+ *         This is used to trigger the preserve/unpreserve/finish ops on the
+ *         first/last file.
+ * @data:  The opaque u64 handle returned by .preserve() or passed to
+ *         .retrieve().
+ * @obj:   The live kernel object returned by .preserve() or .retrieve().
+ * @lock:  A mutex that protects all fields within this structure, providing
+ *         the synchronization service for the FLB's ops.
+ */
+struct luo_flb_state {
+	long count;
+	u64 data;
+	void *obj;
+	struct mutex lock;
+};
+
+/*
+ * struct luo_flb_internal - Keep separate incoming and outgoing states.
+ * @outgoing:    The runtime state for the pre-reboot (preserve/unpreserve)
+ *               lifecycle.
+ * @incoming:    The runtime state for the post-reboot (retrieve/finish)
+ *               lifecycle.
+ */
+struct luo_flb_internal {
+	struct luo_flb_state outgoing;
+	struct luo_flb_state incoming;
+};
+
+static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	scoped_guard(mutex, &internal->outgoing.lock) {
+		if (!internal->outgoing.count) {
+			struct liveupdate_flb_op_args args = {0};
+			int err;
+
+			args.flb = flb;
+			err = flb->ops->preserve(&args);
+			if (err)
+				return err;
+			internal->outgoing.data = args.data;
+			internal->outgoing.obj = args.obj;
+		}
+		internal->outgoing.count++;
+	}
+
+	return 0;
+}
+
+static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	scoped_guard(mutex, &internal->outgoing.lock) {
+		internal->outgoing.count--;
+		if (!internal->outgoing.count) {
+			struct liveupdate_flb_op_args args = {0};
+
+			args.flb = flb;
+			args.data = internal->outgoing.data;
+			args.obj = internal->outgoing.obj;
+
+			if (flb->ops->unpreserve)
+				flb->ops->unpreserve(&args);
+
+			internal->outgoing.data = 0;
+			internal->outgoing.obj = NULL;
+		}
+	}
+}
+
+static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_header *fh = &luo_flb_global.incoming;
+	struct luo_flb_internal *internal = flb->internal;
+	struct liveupdate_flb_op_args args = {0};
+	bool found = false;
+	int err;
+
+	guard(mutex)(&internal->incoming.lock);
+
+	if (internal->incoming.obj)
+		return 0;
+
+	if (!fh->active)
+		return -ENODATA;
+
+	for (int i = 0; i < fh->header_ser->count; i++) {
+		if (!strcmp(fh->ser[i].name, flb->compatible)) {
+			internal->incoming.data = fh->ser[i].data;
+			internal->incoming.count = fh->ser[i].count;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	args.flb = flb;
+	args.data = internal->incoming.data;
+
+	err = flb->ops->retrieve(&args);
+	if (err)
+		return err;
+
+	internal->incoming.obj = args.obj;
+
+	if (WARN_ON_ONCE(!internal->incoming.obj))
+		return -EIO;
+
+	return 0;
+}
+
+static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_internal *internal = flb->internal;
+	u64 count;
+
+	scoped_guard(mutex, &internal->incoming.lock)
+		count = --internal->incoming.count;
+
+	if (!count) {
+		struct liveupdate_flb_op_args args = {0};
+
+		if (!internal->incoming.obj) {
+			int err = luo_flb_retrieve_one(flb);
+
+			if (WARN_ON(err))
+				return;
+		}
+
+		scoped_guard(mutex, &internal->incoming.lock) {
+			args.flb = flb;
+			args.obj = internal->incoming.obj;
+			flb->ops->finish(&args);
+
+			internal->incoming.data = 0;
+			internal->incoming.obj = NULL;
+		}
+	}
+}
+
+/**
+ * luo_flb_file_preserve - Notifies FLBs that a file is about to be preserved.
+ * @h: The file handler for the preserved file.
+ *
+ * This function iterates through all FLBs associated with the given file
+ * handler. It increments the reference count for each FLB. If the count becomes
+ * 1, it triggers the FLB's .preserve() callback to save the global state.
+ *
+ * This operation is atomic. If any FLB's .preserve() op fails, it will roll
+ * back by calling .unpreserve() on any FLBs that were successfully preserved
+ * during this call.
+ *
+ * Context: Called from luo_preserve_file()
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int luo_flb_file_preserve(struct liveupdate_file_handler *h)
+{
+	struct luo_flb_link *iter;
+	int err = 0;
+
+	list_for_each_entry(iter, &h->flb_list, list) {
+		err = luo_flb_file_preserve_one(iter->flb);
+		if (err)
+			goto exit_err;
+	}
+
+	return 0;
+
+exit_err:
+	list_for_each_entry_continue_reverse(iter, &h->flb_list, list)
+		luo_flb_file_unpreserve_one(iter->flb);
+
+	return err;
+}
+
+/**
+ * luo_flb_file_unpreserve - Notifies FLBs that a dependent file was unpreserved.
+ * @h: The file handler for the unpreserved file.
+ *
+ * This function iterates through all FLBs associated with the given file
+ * handler, in reverse order of registration. It decrements the reference count
+ * for each FLB. If the count becomes 0, it triggers the FLB's .unpreserve()
+ * callback to clean up the global state.
+ *
+ * Context: Called when a preserved file is being cleaned up before reboot
+ *          (e.g., from luo_file_unpreserve_files()).
+ */
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *h)
+{
+	struct luo_flb_link *iter;
+
+	list_for_each_entry_reverse(iter, &h->flb_list, list)
+		luo_flb_file_unpreserve_one(iter->flb);
+}
+
+/**
+ * luo_flb_file_finish - Notifies FLBs that a dependent file has been finished.
+ * @h: The file handler for the finished file.
+ *
+ * This function iterates through all FLBs associated with the given file
+ * handler, in reverse order of registration. It decrements the incoming
+ * reference count for each FLB. If the count becomes 0, it triggers the FLB's
+ * .finish() callback for final cleanup in the new kernel.
+ *
+ * Context: Called from luo_file_finish() for each file being finished.
+ */
+void luo_flb_file_finish(struct liveupdate_file_handler *h)
+{
+	struct luo_flb_link *iter;
+
+	list_for_each_entry_reverse(iter, &h->flb_list, list)
+		luo_flb_file_finish_one(iter->flb);
+}
+
+/**
+ * liveupdate_init_flb - Initializes a liveupdate FLB structure.
+ * @flb: The &struct liveupdate_flb to initialize.
+ *
+ * This function must be called to prepare an FLB structure before it can be
+ * used with liveupdate_register_flb() or any other LUO functions.
+ *
+ * Context: Typically called once from a subsystem's module init function for
+ *          each global FLB object that the module defines.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails, and -EOPNOTSUPP
+ * when live update is disabled or not configured.
+ */
+int liveupdate_init_flb(struct liveupdate_flb *flb)
+{
+	struct luo_flb_internal *internal;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	internal = kzalloc(sizeof(*internal), GFP_KERNEL | __GFP_ZERO);
+	if (!internal)
+		return -ENOMEM;
+
+	mutex_init(&internal->incoming.lock);
+	mutex_init(&internal->outgoing.lock);
+
+	flb->internal = internal;
+	INIT_LIST_HEAD(&flb->list);
+
+	return 0;
+}
+
+/**
+ * liveupdate_register_flb - Associate an FLB with a file handler and register it globally.
+ * @h:   The file handler that will now depend on the FLB.
+ * @flb: The File-Lifecycle-Bound object to associate.
+ *
+ * Establishes a dependency, informing the LUO core that whenever a file of
+ * type @h is preserved, the state of @flb must also be managed.
+ *
+ * On the first registration of a given @flb object, it is added to a global
+ * registry. This function checks for duplicate registrations, both for a
+ * specific handler and globally, and ensures the total number of unique
+ * FLBs does not exceed the system limit.
+ *
+ * Context: Typically called from a subsystem's module init function after
+ *          both the handler and the FLB have been defined and initialized.
+ * Return: 0 on success. Returns a negative errno on failure:
+ *         -EINVAL if arguments are NULL or not initialized.
+ *         -ENOMEM on memory allocation failure.
+ *         -EEXIST if this FLB is already registered with this handler.
+ *         -ENOSPC if the maximum number of global FLBs has been reached.
+ *         -EOPNOTSUPP if live update is disabled or not configured.
+ */
+int liveupdate_register_flb(struct liveupdate_file_handler *h,
+			    struct liveupdate_flb *flb)
+{
+	struct luo_flb_internal *internal = flb->internal;
+	struct luo_flb_link *link __free(kfree) = NULL;
+	static DEFINE_MUTEX(register_flb_lock);
+	struct liveupdate_flb *gflb;
+	struct luo_flb_link *iter;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	if (WARN_ON(!h || !flb || !internal))
+		return -EINVAL;
+
+	if (WARN_ON(!flb->ops->preserve || !flb->ops->unpreserve ||
+		    !flb->ops->retrieve || !flb->ops->finish)) {
+		return -EINVAL;
+	}
+
+	/*
+	 * Once session/files have been deserialized, FLBs cannot be registered,
+	 * it is too late. Deserialization uses file handlers, and FLB registers
+	 * to file handlers.
+	 */
+	if (WARN_ON(luo_session_is_deserialized()))
+		return -EBUSY;
+
+	/*
+	 * File handler must already be registered, as it is initializes the
+	 * flb_list
+	 */
+	if (WARN_ON(list_empty(&h->list)))
+		return -EINVAL;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	guard(mutex)(&register_flb_lock);
+
+	/* Check that this FLB is not already linked to this file handler */
+	list_for_each_entry(iter, &h->flb_list, list) {
+		if (iter->flb == flb)
+			return -EEXIST;
+	}
+
+	/* Is this FLB linked to global list ? */
+	if (list_empty(&flb->list)) {
+		if (luo_flb_global.count == LUO_FLB_MAX)
+			return -ENOSPC;
+
+		/* Check that compatible string is unique in global list */
+		list_for_each_entry(gflb, &luo_flb_global.list, list) {
+			if (!strcmp(gflb->compatible, flb->compatible))
+				return -EEXIST;
+		}
+
+		if (!try_module_get(flb->ops->owner))
+			return -EAGAIN;
+
+		list_add_tail(&flb->list, &luo_flb_global.list);
+		luo_flb_global.count++;
+	}
+
+	/* Finally, link the FLB to the file handler */
+	link->flb = flb;
+	list_add_tail(&no_free_ptr(link)->list, &h->flb_list);
+
+	return 0;
+}
+
+/**
+ * liveupdate_flb_incoming_locked - Lock and retrieve the incoming FLB object.
+ * @flb:  The FLB definition.
+ * @objp: Output parameter; will be populated with the live shared object.
+ *
+ * Acquires the FLB's internal lock and returns a pointer to its shared live
+ * object for the incoming (post-reboot) path.
+ *
+ * If this is the first time the object is requested in the new kernel, this
+ * function will trigger the FLB's .retrieve() callback to reconstruct the
+ * object from its preserved state. Subsequent calls will return the same
+ * cached object.
+ *
+ * The caller MUST call liveupdate_flb_incoming_unlock() to release the lock.
+ *
+ * Return: 0 on success, or a negative errno on failure. -ENODATA means no
+ * incoming FLB data, -ENOENT means specific flb not found in the incoming
+ * data, and -EOPNOTSUPP when live update is disabled or not configured.
+ */
+int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	if (WARN_ON(!internal))
+		return -EINVAL;
+
+	if (!internal->incoming.obj) {
+		int err = luo_flb_retrieve_one(flb);
+
+		if (err)
+			return err;
+	}
+
+	mutex_lock(&internal->incoming.lock);
+	*objp = internal->incoming.obj;
+
+	return 0;
+}
+
+/**
+ * liveupdate_flb_incoming_unlock - Unlock an incoming FLB object.
+ * @flb: The FLB definition.
+ * @obj: The object that was returned by the _locked call (used for validation).
+ *
+ * Releases the internal lock acquired by liveupdate_flb_incoming_locked().
+ */
+void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	lockdep_assert_held(&internal->incoming.lock);
+	internal->incoming.obj = obj;
+	mutex_unlock(&internal->incoming.lock);
+}
+
+/**
+ * liveupdate_flb_outgoing_locked - Lock and retrieve the outgoing FLB object.
+ * @flb:  The FLB definition.
+ * @objp: Output parameter; will be populated with the live shared object.
+ *
+ * Acquires the FLB's internal lock and returns a pointer to its shared live
+ * object for the outgoing (pre-reboot) path.
+ *
+ * This function assumes the object has already been created by the FLB's
+ * .preserve() callback, which is triggered when the first dependent file
+ * is preserved.
+ *
+ * The caller MUST call liveupdate_flb_outgoing_unlock() to release the lock.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	if (WARN_ON(!internal))
+		return -EINVAL;
+
+	mutex_lock(&internal->outgoing.lock);
+
+	/* The object must exist if any file is being preserved */
+	if (WARN_ON_ONCE(!internal->outgoing.obj)) {
+		mutex_unlock(&internal->outgoing.lock);
+		return -ENOENT;
+	}
+
+	*objp = internal->outgoing.obj;
+
+	return 0;
+}
+
+/**
+ * liveupdate_flb_outgoing_unlock - Unlock an outgoing FLB object.
+ * @flb: The FLB definition.
+ * @obj: The object that was returned by the _locked call (used for validation).
+ *
+ * Releases the internal lock acquired by liveupdate_flb_outgoing_locked().
+ */
+void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj)
+{
+	struct luo_flb_internal *internal = flb->internal;
+
+	lockdep_assert_held(&internal->outgoing.lock);
+	internal->outgoing.obj = obj;
+	mutex_unlock(&internal->outgoing.lock);
+}
+
+int __init luo_flb_setup_outgoing(void *fdt_out)
+{
+	struct luo_flb_header_ser *header_ser;
+	u64 header_ser_pa;
+	int err;
+
+	header_ser = kho_alloc_preserve(LUO_FLB_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(header_ser))
+		return PTR_ERR(header_ser);
+
+	header_ser_pa = virt_to_phys(header_ser);
+
+	err = fdt_begin_node(fdt_out, LUO_FDT_FLB_NODE_NAME);
+	err |= fdt_property_string(fdt_out, "compatible",
+				   LUO_FDT_FLB_COMPATIBLE);
+	err |= fdt_property(fdt_out, LUO_FDT_FLB_HEADER, &header_ser_pa,
+			    sizeof(header_ser_pa));
+	err |= fdt_end_node(fdt_out);
+
+	if (err)
+		goto err_unpreserve;
+
+	header_ser->pgcnt = LUO_FLB_PGCNT;
+	luo_flb_global.outgoing.header_ser = header_ser;
+	luo_flb_global.outgoing.ser = (void *)(header_ser + 1);
+	luo_flb_global.outgoing.active = true;
+
+	return 0;
+
+err_unpreserve:
+	kho_unpreserve_free(header_ser);
+
+	return err;
+}
+
+int __init luo_flb_setup_incoming(void *fdt_in)
+{
+	struct luo_flb_header_ser *header_ser;
+	int err, header_size, offset;
+	const void *ptr;
+	u64 header_ser_pa;
+
+	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_FLB_NODE_NAME);
+	if (offset < 0) {
+		pr_err("Unable to get FLB node [%s]\n", LUO_FDT_FLB_NODE_NAME);
+
+		return -ENOENT;
+	}
+
+	err = fdt_node_check_compatible(fdt_in, offset,
+					LUO_FDT_FLB_COMPATIBLE);
+	if (err) {
+		pr_err("FLB node is incompatible with '%s' [%d]\n",
+		       LUO_FDT_FLB_COMPATIBLE, err);
+
+		return -EINVAL;
+	}
+
+	header_size = 0;
+	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_FLB_HEADER, &header_size);
+	if (!ptr || header_size != sizeof(u64)) {
+		pr_err("Unable to get FLB header property '%s' [%d]\n",
+		       LUO_FDT_FLB_HEADER, header_size);
+
+		return -EINVAL;
+	}
+
+	header_ser_pa = get_unaligned((u64 *)ptr);
+	header_ser = phys_to_virt(header_ser_pa);
+
+	luo_flb_global.incoming.header_ser = header_ser;
+	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
+	luo_flb_global.incoming.active = true;
+
+	return 0;
+}
+
+/**
+ * luo_flb_serialize - Serializes all active FLB objects for KHO.
+ *
+ * This function is called from the reboot path. It iterates through all
+ * registered File-Lifecycle-Bound (FLB) objects. For each FLB that has been
+ * preserved (i.e., its reference count is greater than zero), it writes its
+ * metadata into the memory region designated for Kexec Handover.
+ *
+ * The serialized data includes the FLB's compatibility string, its opaque
+ * data handle, and the final reference count. This allows the new kernel to
+ * find the appropriate handler and reconstruct the FLB's state.
+ *
+ * Context: Called from liveupdate_reboot() just before kho_finalize().
+ */
+void luo_flb_serialize(void)
+{
+	struct luo_flb_header *fh = &luo_flb_global.outgoing;
+	struct liveupdate_flb *flb;
+	int i = 0;
+
+	list_for_each_entry(flb, &luo_flb_global.list, list) {
+		struct luo_flb_internal *internal = flb->internal;
+
+		if (internal->outgoing.count > 0) {
+			strscpy(fh->ser[i].name, flb->compatible,
+				sizeof(fh->ser[i].name));
+			fh->ser[i].data = internal->outgoing.data;
+			fh->ser[i].count = internal->outgoing.count;
+			i++;
+		}
+	}
+
+	fh->header_ser->count = i;
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 1a36f2383123..389fb102775f 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,4 +79,11 @@ int luo_retrieve_file(struct luo_session *session, u64 token,
 int luo_file_finish(struct luo_session *session);
 int luo_file_deserialize(struct luo_session *session);
 
+int luo_flb_file_preserve(struct liveupdate_file_handler *h);
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *h);
+void luo_flb_file_finish(struct liveupdate_file_handler *h);
+int __init luo_flb_setup_outgoing(void *fdt);
+int __init luo_flb_setup_incoming(void *fdt);
+void luo_flb_serialize(void);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.52.0.rc1.455.g30608eb744-goog


