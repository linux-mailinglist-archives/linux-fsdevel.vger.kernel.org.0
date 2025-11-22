Return-Path: <linux-fsdevel+bounces-69503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0EC7D951
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC754E197D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7162D3EC7;
	Sat, 22 Nov 2025 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UvF9Ga2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194652EB856
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850286; cv=none; b=HPOZr/QHCASwo60tjXgNZBqG9Xt5HmU1VNQpGgarLnPXdmlxevHUosWXUxhxpk8cJ8mu36JaXCh+Iki0TjMPBRSo5g9Xv1d0rdbzGeHglLnsmG98lqPztKnyZ5oEb8JDiUbdzBjB4Iq/5hBUZWg3x03caKSbS8ZdLOkGyfIrtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850286; c=relaxed/simple;
	bh=l7lKW7DaGzZAp2GvmYc9Wma/ghnFqf3j0aNhK2onjcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5mnxNZVhoCfDqnAFic1xRfx7p8fTARPLlLKIlhInecaKWHrXCmMX80SfoM7YSx/bbbSyR5HOxATnwi5zf4euT8nxEwSd6i3h4ssjzmRbUw8uf9QM50xveEba3uYY1xiAXzYo5nbhSG6qLbwA2N3M1fXtktBNDWpUp/UtOmJf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UvF9Ga2y; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7866375e943so25113617b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850279; x=1764455079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejaHDjieDr/pDzy+upfATTsYn5XdzeNqJKeKiiB3q/I=;
        b=UvF9Ga2yQz100beXkHJFU8H0xHEvjxRcGb1KjagcR08ZhX/fPhebJ3tRwRBk+xB9Iv
         xRvIgs90n73qylvZ9hujvlaOxkrrPccdZ1Weux/EwhN7Y1PuGhSgCnaapR0VPyvgY/2T
         CItOGbAmvRIgrkannHGrE8f62ppa2bEkEz+mxpI6FnX1PBJUJN+6Q+hxYabmx/ZeLkND
         eAH1jHmI+D+jt4ruVeDzq60Fh3sd7lbYej0hd/ZztFo6imPwhV7tLHUoHQn4z/umvrnE
         wvvi+TMVBADD9O/73gppt5SMjUUYSKXZJhvMIk0ExwliuCGOhraL4TnSjCk9KVsnGVzg
         LbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850279; x=1764455079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejaHDjieDr/pDzy+upfATTsYn5XdzeNqJKeKiiB3q/I=;
        b=sejffoh2LQv27YZEGebUYbID+hXnHu+pM6WsYMC8dMjDWrOVbSweWUJVPGq6rbyuWy
         i6xXjabl6RmkyEviqexUrzUq0U8o263KCY2WzvozLUFQneh6EnxTqgbsm0bvNTpKq6zW
         cVkG4VuyNfZqWTCXAzs0xDXmeChVmienBiAEAYoKAiXfnt7RWaVsVdznWb20knrlTcg7
         Ybsoq1+C7F/IpQ+DYEI6bvzGu4s/v6ACntGxqm0anyuxqyxUSoEm3BqD0C6kkHWwRTaU
         8KEAG0+s/4UszVvt0o969aHL2QoOD2iXVgXTUYEw0u8LV2tOf+OzgBx45LzLTYi+nPpx
         rU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjEN9ALzPPR8a0+/z0BWhUvLi5YU0yM3h4kWcoyLfRWdOcvEquFX1XuQ2hv1RlTOAnB7ljnD8XOXOFvUb8@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNJgbTvUfdPhwRIvrqXl8tIqNeBQ+crNwGajTnO5do5aWftCj
	rXjb5AhAZZOIhRaJsw57tEHu6iG5MEno2Zrm44KH8W5kvTnU2dfsJSeX2EczjiD2lP8=
X-Gm-Gg: ASbGncvkl0gfFTmAhhb8AsDB6mTCjBpuj8TKTMhvUH+mr1mIRoLqhD2QvEv4aJYFD6d
	JpayfVj/U+zejYKE+34ETfTO2lDcIPZcIPaL79560JHiOYYaCrJKDA6PDDA3R5L2r6J6xRJI4ZQ
	eQcCmVnyQo7INtNU/g2GbtJPRAz5XTkrRsfqv7bhTm4Xt14d7RHviMe7GUUhCfocxq380khYxQn
	dNty7PxC3CHkk6jIVFsjBpi2a+2++cCBL30AZG/xrCju5zkMu6mNO7aKkzf0v2Iffp564nZ610t
	pqc5/yS0hPTRsE5Fv8G5QLM04Bbke0IX4DKm0ZaXMnxyJBkb3D9XCKwraS2HzddZJDXHhv1QOaE
	dAXRL8vI56Sp9d6Nm27oohSS2tLpsr1mmZz+tvkEMEmkEPM/R2oISoftKYN8KBX+WDf3CwJnLBb
	gb8CcjbVuF2Ry4JK0crVGa4TpGU//UomOdQkywAejFB0MLyTY2GJ08xxT9vpN4HeXnQI1aQIPeD
	3UfHYM=
X-Google-Smtp-Source: AGHT+IHaO2M7rzXS9aV6uHz8pg9B2XKFY+NkqugdpRPdeDAsg/9VEMgnKluajVBx51kFvPB+f80XFA==
X-Received: by 2002:a05:690c:6a06:b0:787:e9bc:fa85 with SMTP id 00721157ae682-78a8b5780demr56833317b3.68.1763850278474;
        Sat, 22 Nov 2025 14:24:38 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:38 -0800 (PST)
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
Subject: [PATCH v7 21/22] liveupdate: luo_flb: Introduce File-Lifecycle-Bound global state
Date: Sat, 22 Nov 2025 17:23:48 -0500
Message-ID: <20251122222351.1059049-22-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
 Documentation/core-api/liveupdate.rst |  11 +
 include/linux/kho/abi/luo.h           |  76 +++
 include/linux/liveupdate.h            | 150 ++++++
 kernel/liveupdate/Makefile            |   1 +
 kernel/liveupdate/luo_core.c          |   7 +-
 kernel/liveupdate/luo_file.c          |  21 +-
 kernel/liveupdate/luo_flb.c           | 701 ++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h      |   7 +
 8 files changed, 972 insertions(+), 2 deletions(-)
 create mode 100644 kernel/liveupdate/luo_flb.c

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index b776b625c60f..6d9f8b0363f6 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -18,6 +18,11 @@ LUO Preserving File Descriptors
 .. kernel-doc:: kernel/liveupdate/luo_file.c
    :doc: LUO File Descriptors
 
+LUO File Lifecycle Bound Global Data
+====================================
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :doc: LUO File Lifecycle Bound Global Data
+
 Live Update Orchestrator ABI
 ============================
 .. kernel-doc:: include/linux/kho/abi/luo.h
@@ -39,6 +44,9 @@ Public API
 .. kernel-doc:: kernel/liveupdate/luo_core.c
    :export:
 
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :export:
+
 .. kernel-doc:: kernel/liveupdate/luo_file.c
    :export:
 
@@ -47,6 +55,9 @@ Internal API
 .. kernel-doc:: kernel/liveupdate/luo_core.c
    :internal:
 
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :internal:
+
 .. kernel-doc:: kernel/liveupdate/luo_session.c
    :internal:
 
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index fc143f243871..ea21ad1535bf 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
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
 
 #ifndef _LINUX_KHO_ABI_LUO_H
@@ -159,4 +185,54 @@ struct luo_session_ser {
 	struct luo_file_set_ser file_set_ser;
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
 #endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index c9503d2cda7b..31d58455d6ba 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -11,10 +11,12 @@
 #include <linux/compiler.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_file_handler;
+struct liveupdate_flb;
 struct liveupdate_session;
 struct file;
 
@@ -102,6 +104,114 @@ struct liveupdate_file_handler {
 	 * registered file handlers.
 	 */
 	struct list_head __private list;
+	/* A list of FLB dependencies. */
+	struct list_head __private flb_list;
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
+/*
+ * struct luo_flb_private_state - Private FLB state structures.
+ * @count: The number of preserved files currently depending on this FLB.
+ *         This is used to trigger the preserve/unpreserve/finish ops on the
+ *         first/last file.
+ * @data:  The opaque u64 handle returned by .preserve() or passed to
+ *         .retrieve().
+ * @obj:   The live kernel object returned by .preserve() or .retrieve().
+ * @lock:  A mutex that protects all fields within this structure, providing
+ *         the synchronization service for the FLB's ops.
+ */
+struct luo_flb_private_state {
+	long count;
+	u64 data;
+	void *obj;
+	struct mutex lock;
+};
+
+/*
+ * struct luo_flb_private - Keep separate incoming and outgoing states.
+ * @list:        A global list of registered FLBs.
+ * @outgoing:    The runtime state for the pre-reboot
+ *               (preserve/unpreserve) lifecycle.
+ * @incoming:    The runtime state for the post-reboot (retrieve/finish)
+ *               lifecycle.
+ * @users:       With how many File-Handlers this FLB is registered.
+ * @initialized: true when private fields have been initialized.
+ */
+struct luo_flb_private {
+	struct list_head list;
+	struct luo_flb_private_state outgoing;
+	struct luo_flb_private_state incoming;
+	int users;
+	bool initialized;
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
+ *
+ * This struct is the "template" that a driver registers to define a shared,
+ * file-lifecycle-bound object. The actual runtime state (the live object,
+ * refcount, etc.) is managed privately by the LUO core.
+ */
+struct liveupdate_flb {
+	const struct liveupdate_flb_ops *ops;
+	const char compatible[LIVEUPDATE_FLB_COMPAT_LENGTH];
+
+	/* private: */
+	struct luo_flb_private __private private;
 };
 
 #ifdef CONFIG_LIVEUPDATE
@@ -123,6 +233,16 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
 
+int liveupdate_register_flb(struct liveupdate_file_handler *fh,
+			    struct liveupdate_flb *flb);
+int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
+			      struct liveupdate_flb *flb);
+
+int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj);
+int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
@@ -157,5 +277,35 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline int liveupdate_register_flb(struct liveupdate_file_handler *fh,
+					  struct liveupdate_flb *flb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
+					    struct liveupdate_flb *flb)
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
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index 7cad2eece32d..d2f779cbe279 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -3,6 +3,7 @@
 luo-y :=								\
 		luo_core.o						\
 		luo_file.o						\
+		luo_flb.o						\
 		luo_session.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index bc90954252a3..d839be582aff 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -127,7 +127,9 @@ static int __init luo_early_startup(void)
 	if (err)
 		return err;
 
-	return 0;
+	err = luo_flb_setup_incoming(luo_global.fdt_in);
+
+	return err;
 }
 
 static int __init liveupdate_early_init(void)
@@ -164,6 +166,7 @@ static int __init luo_fdt_setup(void)
 	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
 	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
 	err |= luo_session_setup_outgoing(fdt_out);
+	err |= luo_flb_setup_outgoing(fdt_out);
 	err |= fdt_end_node(fdt_out);
 	err |= fdt_finish(fdt_out);
 	if (err)
@@ -225,6 +228,8 @@ int liveupdate_reboot(void)
 	if (err)
 		return err;
 
+	luo_flb_serialize();
+
 	err = kho_finalize();
 	if (err) {
 		pr_err("kho_finalize failed %d\n", err);
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 670649932de4..ecaa93bbcb12 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -286,6 +286,10 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (err)
 		goto err_files_mem;
 
+	err = luo_flb_file_preserve(fh);
+	if (err)
+		goto err_files_mem;
+
 	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
 	if (!luo_file) {
 		err = -ENOMEM;
@@ -315,6 +319,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 err_kfree:
 	mutex_destroy(&luo_file->mutex);
 	kfree(luo_file);
+	luo_flb_file_unpreserve(fh);
 err_files_mem:
 	fput(file);
 	luo_free_files_mem(file_set);
@@ -356,6 +361,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
+		luo_flb_file_unpreserve(luo_file->fh);
 
 		list_del(&luo_file->list);
 		file_set->count--;
@@ -633,6 +639,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieved = luo_file->retrieved;
+	luo_flb_file_finish(luo_file->fh);
 
 	luo_file->fh->ops->finish(&args);
 }
@@ -856,6 +863,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 		goto err_resume;
 	}
 
+	INIT_LIST_HEAD(&ACCESS_PRIVATE(fh, flb_list));
 	INIT_LIST_HEAD(&ACCESS_PRIVATE(fh, list));
 	list_add_tail(&ACCESS_PRIVATE(fh, list), &luo_file_handler_list);
 	luo_session_resume();
@@ -876,25 +884,36 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
  *
  * It ensures safe removal by checking that:
  * No live update session is currently in progress.
+ * No FLB registered with this file handler.
  *
  * If the unregistration fails, the internal test state is reverted.
  *
  * Return: 0 Success. -EOPNOTSUPP when live update is not enabled. -EBUSY A live
- * update is in progress, can't quiesce live update.
+ * update is in progress, can't quiesce live update or FLB is registred with
+ * this file handler.
  */
 int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 {
+	int err = -EBUSY;
+
 	if (!liveupdate_enabled())
 		return -EOPNOTSUPP;
 
 	if (!luo_session_quiesce())
 		return -EBUSY;
 
+	if (!list_empty(&ACCESS_PRIVATE(fh, flb_list)))
+		goto err_resume;
+
 	list_del(&ACCESS_PRIVATE(fh, list));
 	module_put(fh->ops->owner);
 	luo_session_resume();
 
 	return 0;
+
+err_resume:
+	luo_session_resume();
+	return err;
 }
 
 /**
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
new file mode 100644
index 000000000000..bbae99d973df
--- /dev/null
+++ b/kernel/liveupdate/luo_flb.c
@@ -0,0 +1,701 @@
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
+#include <linux/kho/abi/luo.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/liveupdate.h>
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
+/* luo_flb_get_private - Access private field, and if needed initialize it. */
+static struct luo_flb_private *luo_flb_get_private(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = &ACCESS_PRIVATE(flb, private);
+
+	if (!private->initialized) {
+		mutex_init(&private->incoming.lock);
+		mutex_init(&private->outgoing.lock);
+		INIT_LIST_HEAD(&private->list);
+		private->users = 0;
+		private->initialized = true;
+	}
+
+	return private;
+}
+
+static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+
+	scoped_guard(mutex, &private->outgoing.lock) {
+		if (!private->outgoing.count) {
+			struct liveupdate_flb_op_args args = {0};
+			int err;
+
+			args.flb = flb;
+			err = flb->ops->preserve(&args);
+			if (err)
+				return err;
+			private->outgoing.data = args.data;
+			private->outgoing.obj = args.obj;
+		}
+		private->outgoing.count++;
+	}
+
+	return 0;
+}
+
+static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+
+	scoped_guard(mutex, &private->outgoing.lock) {
+		private->outgoing.count--;
+		if (!private->outgoing.count) {
+			struct liveupdate_flb_op_args args = {0};
+
+			args.flb = flb;
+			args.data = private->outgoing.data;
+			args.obj = private->outgoing.obj;
+
+			if (flb->ops->unpreserve)
+				flb->ops->unpreserve(&args);
+
+			private->outgoing.data = 0;
+			private->outgoing.obj = NULL;
+		}
+	}
+}
+
+static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct luo_flb_header *fh = &luo_flb_global.incoming;
+	struct liveupdate_flb_op_args args = {0};
+	bool found = false;
+	int err;
+
+	guard(mutex)(&private->incoming.lock);
+
+	if (private->incoming.obj)
+		return 0;
+
+	if (!fh->active)
+		return -ENODATA;
+
+	for (int i = 0; i < fh->header_ser->count; i++) {
+		if (!strcmp(fh->ser[i].name, flb->compatible)) {
+			private->incoming.data = fh->ser[i].data;
+			private->incoming.count = fh->ser[i].count;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	args.flb = flb;
+	args.data = private->incoming.data;
+
+	err = flb->ops->retrieve(&args);
+	if (err)
+		return err;
+
+	private->incoming.obj = args.obj;
+
+	if (WARN_ON_ONCE(!private->incoming.obj))
+		return -EIO;
+
+	return 0;
+}
+
+static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	u64 count;
+
+	scoped_guard(mutex, &private->incoming.lock)
+		count = --private->incoming.count;
+
+	if (!count) {
+		struct liveupdate_flb_op_args args = {0};
+
+		if (!private->incoming.obj) {
+			int err = luo_flb_retrieve_one(flb);
+
+			if (WARN_ON(err))
+				return;
+		}
+
+		scoped_guard(mutex, &private->incoming.lock) {
+			args.flb = flb;
+			args.obj = private->incoming.obj;
+			flb->ops->finish(&args);
+
+			private->incoming.data = 0;
+			private->incoming.obj = NULL;
+		}
+	}
+}
+
+/**
+ * luo_flb_file_preserve - Notifies FLBs that a file is about to be preserved.
+ * @fh: The file handler for the preserved file.
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
+int luo_flb_file_preserve(struct liveupdate_file_handler *fh)
+{
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *iter;
+	int err = 0;
+
+	list_for_each_entry(iter, flb_list, list) {
+		err = luo_flb_file_preserve_one(iter->flb);
+		if (err)
+			goto exit_err;
+	}
+
+	return 0;
+
+exit_err:
+	list_for_each_entry_continue_reverse(iter, flb_list, list)
+		luo_flb_file_unpreserve_one(iter->flb);
+
+	return err;
+}
+
+/**
+ * luo_flb_file_unpreserve - Notifies FLBs that a dependent file was unpreserved.
+ * @fh: The file handler for the unpreserved file.
+ *
+ * This function iterates through all FLBs associated with the given file
+ * handler, in reverse order of registration. It decrements the reference count
+ * for each FLB. If the count becomes 0, it triggers the FLB's .unpreserve()
+ * callback to clean up the global state.
+ *
+ * Context: Called when a preserved file is being cleaned up before reboot
+ *          (e.g., from luo_file_unpreserve_files()).
+ */
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
+{
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *iter;
+
+	list_for_each_entry_reverse(iter, flb_list, list)
+		luo_flb_file_unpreserve_one(iter->flb);
+}
+
+/**
+ * luo_flb_file_finish - Notifies FLBs that a dependent file has been finished.
+ * @fh: The file handler for the finished file.
+ *
+ * This function iterates through all FLBs associated with the given file
+ * handler, in reverse order of registration. It decrements the incoming
+ * reference count for each FLB. If the count becomes 0, it triggers the FLB's
+ * .finish() callback for final cleanup in the new kernel.
+ *
+ * Context: Called from luo_file_finish() for each file being finished.
+ */
+void luo_flb_file_finish(struct liveupdate_file_handler *fh)
+{
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *iter;
+
+	list_for_each_entry_reverse(iter, flb_list, list)
+		luo_flb_file_finish_one(iter->flb);
+}
+
+/**
+ * liveupdate_register_flb - Associate an FLB with a file handler and register it globally.
+ * @fh:   The file handler that will now depend on the FLB.
+ * @flb:  The File-Lifecycle-Bound object to associate.
+ *
+ * Establishes a dependency, informing the LUO core that whenever a file of
+ * type @fh is preserved, the state of @flb must also be managed.
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
+int liveupdate_register_flb(struct liveupdate_file_handler *fh,
+			    struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *link __free(kfree) = NULL;
+	struct liveupdate_flb *gflb;
+	struct luo_flb_link *iter;
+	int err;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	if (WARN_ON(!flb->ops->preserve || !flb->ops->unpreserve ||
+		    !flb->ops->retrieve || !flb->ops->finish)) {
+		return -EINVAL;
+	}
+
+	/*
+	 * File handler must already be registered, as it initializes the
+	 * flb_list
+	 */
+	if (WARN_ON(list_empty(&ACCESS_PRIVATE(fh, list))))
+		return -EINVAL;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	/*
+	 * Ensure the system is quiescent (no active sessions).
+	 * This acts as a global lock for registration: no other thread can
+	 * be in this section, and no sessions can be creating/using FDs.
+	 */
+	if (!luo_session_quiesce())
+		return -EBUSY;
+
+	/* Check that this FLB is not already linked to this file handler */
+	err = -EEXIST;
+	list_for_each_entry(iter, flb_list, list) {
+		if (iter->flb == flb)
+			goto err_resume;
+	}
+
+	/*
+	 * If this FLB is not linked to global list it's the first time the FLB
+	 * is registered
+	 */
+	if (!private->users) {
+		if (WARN_ON(!list_empty(&private->list))) {
+			err = -EINVAL;
+			goto err_resume;
+		}
+
+		if (luo_flb_global.count == LUO_FLB_MAX) {
+			err = -ENOSPC;
+			goto err_resume;
+		}
+
+		/* Check that compatible string is unique in global list */
+		luo_list_for_each_private(gflb, &luo_flb_global.list, private.list) {
+			if (!strcmp(gflb->compatible, flb->compatible))
+				goto err_resume;
+		}
+
+		if (!try_module_get(flb->ops->owner)) {
+			err = -EAGAIN;
+			goto err_resume;
+		}
+
+		list_add_tail(&private->list, &luo_flb_global.list);
+		luo_flb_global.count++;
+	}
+
+	/* Finally, link the FLB to the file handler */
+	private->users++;
+	link->flb = flb;
+	list_add_tail(&no_free_ptr(link)->list, flb_list);
+	luo_session_resume();
+
+	return 0;
+
+err_resume:
+	luo_session_resume();
+	return err;
+}
+
+/**
+ * liveupdate_unregister_flb - Remove an FLB dependency from a file handler.
+ * @fh:   The file handler that is currently depending on the FLB.
+ * @flb:  The File-Lifecycle-Bound object to remove.
+ *
+ * Removes the association between the specified file handler and the FLB
+ * previously established by liveupdate_register_flb().
+ *
+ * This function manages the global lifecycle of the FLB. It decrements the
+ * FLB's usage count. If this was the last file handler referencing this FLB,
+ * the FLB is removed from the global registry and the reference to its
+ * owner module (acquired during registration) is released.
+ *
+ * Context: This function ensures the session is quiesced (no active FDs
+ *          being created) during the update. It is typically called from a
+ *          subsystem's module exit function.
+ * Return: 0 on success.
+ *         -EOPNOTSUPP if live update is disabled.
+ *         -EBUSY if the live update session is active and cannot be quiesced.
+ *         -ENOENT if the FLB was not found in the file handler's list.
+ */
+int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
+			      struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *iter;
+	int err = -ENOENT;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	/*
+	 * Ensure the system is quiescent (no active sessions).
+	 * This acts as a global lock for unregistration.
+	 */
+	if (!luo_session_quiesce())
+		return -EBUSY;
+
+	/* Find and remove the link from the file handler's list */
+	list_for_each_entry(iter, flb_list, list) {
+		if (iter->flb == flb) {
+			list_del(&iter->list);
+			kfree(iter);
+			err = 0;
+			break;
+		}
+	}
+
+	if (err)
+		goto err_resume;
+
+	private->users--;
+	/*
+	 * If this is the last file-handler with which we are registred, remove
+	 * from the global list, and relese module reference.
+	 */
+	if (!private->users) {
+		list_del_init(&private->list);
+		luo_flb_global.count--;
+		module_put(flb->ops->owner);
+	}
+
+	luo_session_resume();
+
+	return 0;
+
+err_resume:
+	luo_session_resume();
+	return err;
+}
+
+static int luo_flb_locked(struct liveupdate_flb *flb, bool incoming,
+			  void **objp)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct luo_flb_private_state *state;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	if (incoming) {
+		state = &private->incoming;
+		if (!state->obj) {
+			int err = luo_flb_retrieve_one(flb);
+
+			if (err)
+				return err;
+		}
+	} else {
+		state = &private->outgoing;
+
+		/* Sanity check that object exists */
+		if (WARN_ON_ONCE(!state->obj))
+			return -ENOENT;
+	}
+
+	mutex_lock(&state->lock);
+	*objp = state->obj;
+
+	return 0;
+}
+
+static void luo_flb_unlock(struct liveupdate_flb *flb, bool incoming,
+			   void *obj)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct luo_flb_private_state *state;
+
+	state = incoming ? &private->incoming : &private->outgoing;
+
+	lockdep_assert_held(&state->lock);
+	state->obj = obj;
+	mutex_unlock(&state->lock);
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
+	return luo_flb_locked(flb, true, objp);
+}
+
+/**
+ * liveupdate_flb_incoming_unlock - Unlock an incoming FLB object.
+ * @flb: The FLB definition.
+ * @obj: The object that was returned by the _locked call
+ *
+ * Releases the internal lock acquired by liveupdate_flb_incoming_locked().
+ */
+void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj)
+{
+	luo_flb_unlock(flb, true, obj);
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
+	return luo_flb_locked(flb, false, objp);
+}
+
+/**
+ * liveupdate_flb_outgoing_unlock - Unlock an outgoing FLB object.
+ * @flb: The FLB definition.
+ * @obj: The object that was returned by the _locked call
+ *
+ * Releases the internal lock acquired by liveupdate_flb_outgoing_locked().
+ */
+void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj)
+{
+	luo_flb_unlock(flb, false, obj);
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
+	struct liveupdate_flb *gflb;
+	int i = 0;
+
+	luo_list_for_each_private(gflb, &luo_flb_global.list, private.list) {
+		struct luo_flb_private *private = luo_flb_get_private(gflb);
+
+		if (private->outgoing.count > 0) {
+			strscpy(fh->ser[i].name, gflb->compatible,
+				sizeof(fh->ser[i].name));
+			fh->ser[i].data = private->outgoing.data;
+			fh->ser[i].count = private->outgoing.count;
+			i++;
+		}
+	}
+
+	fh->header_ser->count = i;
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 734469464664..fa9d2a77c394 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -123,4 +123,11 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 void luo_file_set_init(struct luo_file_set *file_set);
 void luo_file_set_destroy(struct luo_file_set *file_set);
 
+int luo_flb_file_preserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_finish(struct liveupdate_file_handler *fh);
+int __init luo_flb_setup_outgoing(void *fdt);
+int __init luo_flb_setup_incoming(void *fdt);
+void luo_flb_serialize(void);
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.52.0.rc2.455.g230fcf2819-goog


