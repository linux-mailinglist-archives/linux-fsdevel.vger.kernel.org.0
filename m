Return-Path: <linux-fsdevel+bounces-69505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010FC7D99B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC96534B6E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DD28688E;
	Sat, 22 Nov 2025 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s2dGQ6DE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AC245031;
	Sat, 22 Nov 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763851461; cv=none; b=oTfmRZ2xQVmDXdYFT0VOhVFqZQ+F2R3FBYxgW+lospiJcz9NnqlBZU5en/KQ03hbNxoGoCGAc2qrVGOzW69keMegqk49hTwJlGkAoyIIoXWcAc+g4NxqgZshHR/onG2z98ckyDbaWgCERALHlmMuF/2IfNT48U9QL13NNENs8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763851461; c=relaxed/simple;
	bh=hJwjdfJhZDls/fpQAIb7F6NM5qWBQkx0zC/nuK9psAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sOA+h+54iSE7KKzTC9CuGmks0mtOv0xslfmew1+L4MQYlJVfFyNknl9Zdf0I9IKsnqPAbFr/jq5tAiXYqFxr3OSIsz7wxXHiQVjGWw4IIR3VsXd0Xfxt3jqiVr3TtKKtcpnx7gpZvkyvWPWbhVFt9szO3okZJizQjZJt9qFu7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s2dGQ6DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1DDC4CEF5;
	Sat, 22 Nov 2025 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763851461;
	bh=hJwjdfJhZDls/fpQAIb7F6NM5qWBQkx0zC/nuK9psAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2dGQ6DE0zuBiGtbwh5pZTWdtn/g8ccv0UIsfQjmivylxsX7hd88hr6c4raRiQk9a
	 VooIaAtfTgqT1mAL0WYS8epT69bjqRj47bTrCgPaxIjGVHa5EPHdBseFxARhuEeTwc
	 mAO2J3Elu0evZmRyvmOTgobJ39lZuw16SGziNqJ8=
Date: Sat, 22 Nov 2025 14:44:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, tj@kernel.org, yoann.congal@smile.fr,
 mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
 axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
 vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com,
 david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org,
 anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
 bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com,
 hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 00/22] Live Update Orchestrator
Message-Id: <20251122144418.c7af984c28587cb6091fc2b6@linux-foundation.org>
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Nov 2025 17:23:27 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> This series introduces the Live Update Orchestrator, a kernel subsystem
> designed to facilitate live kernel updates using a kexec-based reboot.
>
> ...
>

I udpated mm.git's mm-unstable branch to this version.

> Changelog since v6 [7]
> - Collected Reviewed-by tags from Mike Rapoport,
>   Pratyush Yadav, and Zhu Yanjun. Addressed all outstanding comments.
> - Moved ABI headers from include/linux/liveupdate/abi/ to
>   include/linux/kho/abi/ to align with other future users of KHO and KHO
>   itself.
> - Separated internal APIs to allow kernel subsystems to preserve file
>   objects programmatically.
> - Introduced struct luo_file_set to manage groups of preserved files,
>   decoupling this logic from the luo_session structure. This simplifies
>   internal management and serialization.
> - Implemented luo_session_quiesce() and luo_session_resume() mechanisms.
>   These ensure that file handlers and FLBs can be safely unregistered
>   (liveupdate_unregister_file_handler, liveupdate_unregister_flb) by
>   preventing new operations while unregistration is in progress.
> - Added a comprehensive test orchestration framework. This includes a
>   custom init process (init.c) and scripts (luo_test.sh, run.sh) to
>   automate kexec testing within QEMU environments across x86_64 and
>   arm64.
>  

Below is how this v7 series altered mm.git.


 Documentation/core-api/liveupdate.rst                  |    4 
 Documentation/mm/memfd_preservation.rst                |    4 
 Documentation/userspace-api/liveupdate.rst             |    2 
 MAINTAINERS                                            |    1 
 include/linux/kho/abi/luo.h                            |  243 +++++
 include/linux/kho/abi/memfd.h                          |   77 +
 include/linux/liveupdate.h                             |   92 +-
 include/linux/liveupdate/abi/luo.h                     |  238 -----
 include/linux/liveupdate/abi/memfd.h                   |   88 -
 include/linux/shmem_fs.h                               |    2 
 include/uapi/linux/liveupdate.h                        |    4 
 kernel/liveupdate/Makefile                             |    1 
 kernel/liveupdate/luo_core.c                           |  216 ++++
 kernel/liveupdate/luo_file.c                           |  447 +++++-----
 kernel/liveupdate/luo_flb.c                            |  425 +++++----
 kernel/liveupdate/luo_internal.h                       |   98 +-
 kernel/liveupdate/luo_ioctl.c                          |  223 ----
 kernel/liveupdate/luo_session.c                        |  187 ++--
 lib/tests/liveupdate.c                                 |   31 
 mm/memfd_luo.c                                         |  402 ++------
 mm/shmem.c                                             |   11 
 tools/testing/selftests/liveupdate/.gitignore          |   12 
 tools/testing/selftests/liveupdate/Makefile            |   52 -
 tools/testing/selftests/liveupdate/config              |    6 
 tools/testing/selftests/liveupdate/init.c              |  174 +++
 tools/testing/selftests/liveupdate/luo_kexec_simple.c  |   33 
 tools/testing/selftests/liveupdate/luo_multi_session.c |   36 
 tools/testing/selftests/liveupdate/luo_test.sh         |  296 ++++++
 tools/testing/selftests/liveupdate/luo_test_utils.c    |   98 ++
 tools/testing/selftests/liveupdate/luo_test_utils.h    |   11 
 tools/testing/selftests/liveupdate/run.sh              |   68 +
 31 files changed, 2138 insertions(+), 1444 deletions(-)

--- a/Documentation/core-api/liveupdate.rst~b
+++ a/Documentation/core-api/liveupdate.rst
@@ -25,7 +25,7 @@ LUO File Lifecycle Bound Global Data
 
 Live Update Orchestrator ABI
 ============================
-.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+.. kernel-doc:: include/linux/kho/abi/luo.h
    :doc: Live Update Orchestrator ABI
 
 The following types of file descriptors can be preserved
@@ -39,7 +39,7 @@ Public API
 ==========
 .. kernel-doc:: include/linux/liveupdate.h
 
-.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+.. kernel-doc:: include/linux/kho/abi/luo.h
 
 .. kernel-doc:: kernel/liveupdate/luo_core.c
    :export:
--- a/Documentation/mm/memfd_preservation.rst~b
+++ a/Documentation/mm/memfd_preservation.rst
@@ -10,10 +10,10 @@ Memfd Preservation via LUO
 Memfd Preservation ABI
 ======================
 
-.. kernel-doc:: include/linux/liveupdate/abi/memfd.h
+.. kernel-doc:: include/linux/kho/abi/memfd.h
    :doc: DOC: memfd Live Update ABI
 
-.. kernel-doc:: include/linux/liveupdate/abi/memfd.h
+.. kernel-doc:: include/linux/kho/abi/memfd.h
    :internal:
 
 See Also
--- a/Documentation/userspace-api/liveupdate.rst~b
+++ a/Documentation/userspace-api/liveupdate.rst
@@ -7,7 +7,7 @@ Live Update uAPI
 
 ioctl interface
 ===============
-.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+.. kernel-doc:: kernel/liveupdate/luo_core.c
    :doc: LUO ioctl Interface
 
 ioctl uAPI
diff --git a/include/linux/kho/abi/luo.h a/include/linux/kho/abi/luo.h
new file mode 100644
--- /dev/null
+++ a/include/linux/kho/abi/luo.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Live Update Orchestrator ABI
+ *
+ * This header defines the stable Application Binary Interface used by the
+ * Live Update Orchestrator to pass state from a pre-update kernel to a
+ * post-update kernel. The ABI is built upon the Kexec HandOver framework
+ * and uses a Flattened Device Tree to describe the preserved data.
+ *
+ * This interface is a contract. Any modification to the FDT structure, node
+ * properties, compatible strings, or the layout of the `__packed` serialization
+ * structures defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the relevant `_COMPATIBLE` string to
+ * prevent a new kernel from misinterpreting data from an old kernel.
+ *
+ * FDT Structure Overview:
+ *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
+ *   This entry contains an FDT with the following layout:
+ *
+ *   .. code-block:: none
+ *
+ *     / {
+ *         compatible = "luo-v1";
+ *         liveupdate-number = <...>;
+ *
+ *         luo-session {
+ *             compatible = "luo-session-v1";
+ *             luo-session-header = <phys_addr_of_session_header_ser>;
+ *         };
+ *
+ *         luo-flb {
+ *             compatible = "luo-flb-v1";
+ *             luo-flb-header = <phys_addr_of_flb_header_ser>;
+ *         };
+ *     };
+ *
+ * Main LUO Node (/):
+ *
+ *   - compatible: "luo-v1"
+ *     Identifies the overall LUO ABI version.
+ *   - liveupdate-number: u64
+ *     A counter tracking the number of successful live updates performed.
+ *
+ * Session Node (luo-session):
+ *   This node describes all preserved user-space sessions.
+ *
+ *   - compatible: "luo-session-v1"
+ *     Identifies the session ABI version.
+ *   - luo-session-header: u64
+ *     The physical address of a `struct luo_session_header_ser`. This structure
+ *     is the header for a contiguous block of memory containing an array of
+ *     `struct luo_session_ser`, one for each preserved session.
+ *
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
+ * Serialization Structures:
+ *   The FDT properties point to memory regions containing arrays of simple,
+ *   `__packed` structures. These structures contain the actual preserved state.
+ *
+ *   - struct luo_session_header_ser:
+ *     Header for the session array. Contains the total page count of the
+ *     preserved memory block and the number of `struct luo_session_ser`
+ *     entries that follow.
+ *
+ *   - struct luo_session_ser:
+ *     Metadata for a single session, including its name and a physical pointer
+ *     to another preserved memory block containing an array of
+ *     `struct luo_file_ser` for all files in that session.
+ *
+ *   - struct luo_file_ser:
+ *     Metadata for a single preserved file. Contains the `compatible` string to
+ *     find the correct handler in the new kernel, a user-provided `token` for
+ *     identification, and an opaque `data` handle for the handler to use.
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
+ */
+
+#ifndef _LINUX_KHO_ABI_LUO_H
+#define _LINUX_KHO_ABI_LUO_H
+
+#include <uapi/linux/liveupdate.h>
+
+/*
+ * The LUO FDT hooks all LUO state for sessions, fds, etc.
+ * In the root it also carries "liveupdate-number" 64-bit property that
+ * corresponds to the number of live-updates performed on this machine.
+ */
+#define LUO_FDT_SIZE		PAGE_SIZE
+#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
+#define LUO_FDT_COMPATIBLE	"luo-v1"
+#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
+
+#define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
+
+/**
+ * struct luo_file_ser - Represents the serialized preserves files.
+ * @compatible:  File handler compatible string.
+ * @data:        Private data
+ * @token:       User provided token for this file
+ *
+ * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
+ */
+struct luo_file_ser {
+	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
+	u64 data;
+	u64 token;
+} __packed;
+
+/**
+ * struct luo_file_set_ser - Represents the serialized metadata for file set
+ * @files:   The physical address of a contiguous memory block that holds
+ *           the serialized state of files (array of luo_file_ser) in this file
+ *           set.
+ * @count:   The total number of files that were part of this session during
+ *           serialization. Used for iteration and validation during
+ *           restoration.
+ */
+struct luo_file_set_ser {
+	u64 files;
+	u64 count;
+} __packed;
+
+/*
+ * LUO FDT session node
+ * LUO_FDT_SESSION_HEADER:  is a u64 physical address of struct
+ *                          luo_session_header_ser
+ */
+#define LUO_FDT_SESSION_NODE_NAME	"luo-session"
+#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v2"
+#define LUO_FDT_SESSION_HEADER		"luo-session-header"
+
+/**
+ * struct luo_session_header_ser - Header for the serialized session data block.
+ * @count: The number of `struct luo_session_ser` entries that immediately
+ *         follow this header in the memory block.
+ *
+ * This structure is located at the beginning of a contiguous block of
+ * physical memory preserved across the kexec. It provides the necessary
+ * metadata to interpret the array of session entries that follow.
+ *
+ * If this structure is modified, `LUO_FDT_SESSION_COMPATIBLE` must be updated.
+ */
+struct luo_session_header_ser {
+	u64 count;
+} __packed;
+
+/**
+ * struct luo_session_ser - Represents the serialized metadata for a LUO session.
+ * @name:         The unique name of the session, provided by the userspace at
+ *                the time of session creation.
+ * @file_set_ser: Serialized files belonging to this session,
+ *
+ * This structure is used to package session-specific metadata for transfer
+ * between kernels via Kexec Handover. An array of these structures (one per
+ * session) is created and passed to the new kernel, allowing it to reconstruct
+ * the session context.
+ *
+ * If this structure is modified, `LUO_FDT_SESSION_COMPATIBLE` must be updated.
+ */
+struct luo_session_ser {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	struct luo_file_set_ser file_set_ser;
+} __packed;
+
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
+/* Kernel Live Update Test ABI */
+#ifdef CONFIG_LIVEUPDATE_TEST
+#define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
+#endif
+
+#endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/include/linux/kho/abi/memfd.h a/include/linux/kho/abi/memfd.h
new file mode 100644
--- /dev/null
+++ a/include/linux/kho/abi/memfd.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#ifndef _LINUX_KHO_ABI_MEMFD_H
+#define _LINUX_KHO_ABI_MEMFD_H
+
+#include <linux/types.h>
+#include <linux/kexec_handover.h>
+
+/**
+ * DOC: memfd Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of a memfd across a
+ * kexec reboot using the LUO.
+ *
+ * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * which is handed over to the next kernel via the KHO mechanism.
+ *
+ * This interface is a contract. Any modification to the structure layout
+ * constitutes a breaking change. Such changes require incrementing the
+ * version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ */
+
+/**
+ * MEMFD_LUO_FOLIO_DIRTY - The folio is dirty.
+ *
+ * This flag indicates the folio contains data from user. A non-dirty folio is
+ * one that was allocated (say using fallocate(2)) but not written to.
+ */
+#define MEMFD_LUO_FOLIO_DIRTY		BIT(0)
+
+/**
+ * MEMFD_LUO_FOLIO_UPTODATE - The folio is up-to-date.
+ *
+ * An up-to-date folio has been zeroed out. shmem zeroes out folios on first
+ * use. This flag tracks which folios need zeroing.
+ */
+#define MEMFD_LUO_FOLIO_UPTODATE	BIT(1)
+
+/**
+ * struct memfd_luo_folio_ser - Serialized state of a single folio.
+ * @pfn:       The page frame number of the folio.
+ * @flags:     Flags to describe the state of the folio.
+ * @index:     The page offset (pgoff_t) of the folio within the original file.
+ */
+struct memfd_luo_folio_ser {
+	u64 pfn:52;
+	u64 flags:12;
+	u64 index;
+} __packed;
+
+/**
+ * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * @pos:       The file's current position (f_pos).
+ * @size:      The total size of the file in bytes (i_size).
+ * @nr_folios: Number of folios in the folios array.
+ * @folios:    KHO vmalloc descriptor pointing to the array of
+ *             struct memfd_luo_folio_ser.
+ */
+struct memfd_luo_ser {
+	u64 pos;
+	u64 size;
+	u64 nr_folios;
+	struct kho_vmalloc folios;
+} __packed;
+
+/* The compatibility string for memfd file handler */
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
+
+#endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/include/linux/liveupdate/abi/luo.h a/include/linux/liveupdate/abi/luo.h
deleted file mode 100644
--- a/include/linux/liveupdate/abi/luo.h
+++ /dev/null
@@ -1,238 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * Copyright (c) 2025, Google LLC.
- * Pasha Tatashin <pasha.tatashin@soleen.com>
- */
-
-/**
- * DOC: Live Update Orchestrator ABI
- *
- * This header defines the stable Application Binary Interface used by the
- * Live Update Orchestrator to pass state from a pre-update kernel to a
- * post-update kernel. The ABI is built upon the Kexec HandOver framework
- * and uses a Flattened Device Tree to describe the preserved data.
- *
- * This interface is a contract. Any modification to the FDT structure, node
- * properties, compatible strings, or the layout of the `__packed` serialization
- * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the relevant `_COMPATIBLE` string to
- * prevent a new kernel from misinterpreting data from an old kernel.
- *
- * FDT Structure Overview:
- *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
- *   This entry contains an FDT with the following layout:
- *
- *   .. code-block:: none
- *
- *     / {
- *         compatible = "luo-v1";
- *         liveupdate-number = <...>;
- *
- *         luo-session {
- *             compatible = "luo-session-v1";
- *             luo-session-header = <phys_addr_of_session_header_ser>;
- *         };
- *
- *         luo-flb {
- *             compatible = "luo-flb-v1";
- *             luo-flb-header = <phys_addr_of_flb_header_ser>;
- *         };
- *     };
- *
- * Main LUO Node (/):
- *
- *   - compatible: "luo-v1"
- *     Identifies the overall LUO ABI version.
- *   - liveupdate-number: u64
- *     A counter tracking the number of successful live updates performed.
- *
- * Session Node (luo-session):
- *   This node describes all preserved user-space sessions.
- *
- *   - compatible: "luo-session-v1"
- *     Identifies the session ABI version.
- *   - luo-session-header: u64
- *     The physical address of a `struct luo_session_header_ser`. This structure
- *     is the header for a contiguous block of memory containing an array of
- *     `struct luo_session_ser`, one for each preserved session.
- *
- * File-Lifecycle-Bound Node (luo-flb):
- *   This node describes all preserved global objects whose lifecycle is bound
- *   to that of the preserved files (e.g., shared IOMMU state).
- *
- *   - compatible: "luo-flb-v1"
- *     Identifies the FLB ABI version.
- *   - luo-flb-header: u64
- *     The physical address of a `struct luo_flb_header_ser`. This structure is
- *     the header for a contiguous block of memory containing an array of
- *     `struct luo_flb_ser`, one for each preserved global object.
- *
- * Serialization Structures:
- *   The FDT properties point to memory regions containing arrays of simple,
- *   `__packed` structures. These structures contain the actual preserved state.
- *
- *   - struct luo_session_header_ser:
- *     Header for the session array. Contains the total page count of the
- *     preserved memory block and the number of `struct luo_session_ser`
- *     entries that follow.
- *
- *   - struct luo_session_ser:
- *     Metadata for a single session, including its name and a physical pointer
- *     to another preserved memory block containing an array of
- *     `struct luo_file_ser` for all files in that session.
- *
- *   - struct luo_file_ser:
- *     Metadata for a single preserved file. Contains the `compatible` string to
- *     find the correct handler in the new kernel, a user-provided `token` for
- *     identification, and an opaque `data` handle for the handler to use.
- *
- *   - struct luo_flb_header_ser:
- *     Header for the FLB array. Contains the total page count of the
- *     preserved memory block and the number of `struct luo_flb_ser` entries
- *     that follow.
- *
- *   - struct luo_flb_ser:
- *     Metadata for a single preserved global object. Contains its `name`
- *     (compatible string), an opaque `data` handle, and the `count`
- *     number of files depending on it.
- */
-
-#ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
-#define _LINUX_LIVEUPDATE_ABI_LUO_H
-
-#include <uapi/linux/liveupdate.h>
-
-/*
- * The LUO FDT hooks all LUO state for sessions, fds, etc.
- * In the root it also carries "liveupdate-number" 64-bit property that
- * corresponds to the number of live-updates performed on this machine.
- */
-#define LUO_FDT_SIZE		PAGE_SIZE
-#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
-#define LUO_FDT_COMPATIBLE	"luo-v1"
-#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
-
-/*
- * LUO FDT session node
- * LUO_FDT_SESSION_HEADER:  is a u64 physical address of struct
- *                          luo_session_header_ser
- */
-#define LUO_FDT_SESSION_NODE_NAME	"luo-session"
-#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v1"
-#define LUO_FDT_SESSION_HEADER		"luo-session-header"
-
-/**
- * struct luo_session_header_ser - Header for the serialized session data block.
- * @pgcnt: The total size, in pages, of the entire preserved memory block
- *         that this header describes.
- * @count: The number of 'struct luo_session_ser' entries that immediately
- *         follow this header in the memory block.
- *
- * This structure is located at the beginning of a contiguous block of
- * physical memory preserved across the kexec. It provides the necessary
- * metadata to interpret the array of session entries that follow.
- */
-struct luo_session_header_ser {
-	u64 pgcnt;
-	u64 count;
-} __packed;
-
-/**
- * struct luo_session_ser - Represents the serialized metadata for a LUO session.
- * @name:    The unique name of the session, copied from the `luo_session`
- *           structure.
- * @files:   The physical address of a contiguous memory block that holds
- *           the serialized state of files.
- * @pgcnt:   The number of pages occupied by the `files` memory block.
- * @count:   The total number of files that were part of this session during
- *           serialization. Used for iteration and validation during
- *           restoration.
- *
- * This structure is used to package session-specific metadata for transfer
- * between kernels via Kexec Handover. An array of these structures (one per
- * session) is created and passed to the new kernel, allowing it to reconstruct
- * the session context.
- *
- * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
- */
-struct luo_session_ser {
-	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	u64 files;
-	u64 pgcnt;
-	u64 count;
-} __packed;
-
-/* The max size is set so it can be reliably used during in serialization */
-#define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
-
-/**
- * struct luo_file_ser - Represents the serialized preserves files.
- * @compatible:  File handler compatible string.
- * @data:        Private data
- * @token:       User provided token for this file
- *
- * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
- */
-struct luo_file_ser {
-	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
-	u64 data;
-	u64 token;
-} __packed;
-
-/* The max size is set so it can be reliably used during in serialization */
-#define LIVEUPDATE_FLB_COMPAT_LENGTH	48
-
-#define LUO_FDT_FLB_NODE_NAME	"luo-flb"
-#define LUO_FDT_FLB_COMPATIBLE	"luo-flb-v1"
-#define LUO_FDT_FLB_HEADER	"luo-flb-header"
-
-/**
- * struct luo_flb_header_ser - Header for the serialized FLB data block.
- * @pgcnt: The total number of pages occupied by the entire preserved memory
- *         region, including this header and the subsequent array of
- *         &struct luo_flb_ser entries.
- * @count: The number of &struct luo_flb_ser entries that follow this header
- *         in the memory block.
- *
- * This structure is located at the physical address specified by the
- * `LUO_FDT_FLB_HEADER` FDT property. It provides the new kernel with the
- * necessary information to find and iterate over the array of preserved
- * File-Lifecycle-Bound objects and to manage the underlying memory.
- *
- * If this structure is modified, LUO_FDT_FLB_COMPATIBLE must be updated.
- */
-struct luo_flb_header_ser {
-	u64 pgcnt;
-	u64 count;
-} __packed;
-
-/**
- * struct luo_flb_ser - Represents the serialized state of a single FLB object.
- * @name:    The unique compatibility string of the FLB object, used to find the
- *           corresponding &struct liveupdate_flb handler in the new kernel.
- * @data:    The opaque u64 handle returned by the FLB's .preserve() operation
- *           in the old kernel. This handle encapsulates the entire state needed
- *           for restoration.
- * @count:   The reference count at the time of serialization; i.e., the number
- *           of preserved files that depended on this FLB. This is used by the
- *           new kernel to correctly manage the FLB's lifecycle.
- *
- * An array of these structures is created in a preserved memory region and
- * passed to the new kernel. Each entry allows the LUO core to restore one
- * global, shared object.
- *
- * If this structure is modified, LUO_FDT_FLB_COMPATIBLE must be updated.
- */
-struct luo_flb_ser {
-	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
-	u64 data;
-	u64 count;
-} __packed;
-
-/* Kernel Live Update Test ABI */
-#ifdef CONFIG_LIVEUPDATE_TEST
-#define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
-#endif
-
-#endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
diff --git a/include/linux/liveupdate/abi/memfd.h a/include/linux/liveupdate/abi/memfd.h
deleted file mode 100644
--- a/include/linux/liveupdate/abi/memfd.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * Copyright (c) 2025, Google LLC.
- * Pasha Tatashin <pasha.tatashin@soleen.com>
- *
- * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
- * Pratyush Yadav <ptyadav@amazon.de>
- */
-
-#ifndef _LINUX_LIVEUPDATE_ABI_MEMFD_H
-#define _LINUX_LIVEUPDATE_ABI_MEMFD_H
-
-/**
- * DOC: memfd Live Update ABI
- *
- * This header defines the ABI for preserving the state of a memfd across a
- * kexec reboot using the LUO.
- *
- * The state is serialized into a Flattened Device Tree which is then handed
- * over to the next kernel via the KHO mechanism. The FDT is passed as the
- * opaque `data` handle in the file handler callbacks.
- *
- * This interface is a contract. Any modification to the FDT structure,
- * node properties, compatible string, or the layout of the serialization
- * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the MEMFD_LUO_FH_COMPATIBLE string.
- *
- * FDT Structure Overview:
- *   The memfd state is contained within a single FDT with the following layout:
- *
- *   .. code-block:: none
- *
- *     / {
- *         pos = <...>;
- *         size = <...>;
- *         nr_folios = <...>;
- *         folios = < ... binary data ... >;
- *     };
- *
- *   Node Properties:
- *     - pos: u64
- *       The file's current position (f_pos).
- *     - size: u64
- *       The total size of the file in bytes (i_size).
- *     - nr_folios: u64
- *       Number of folios in folios array. Only present when size > 0.
- *     - folios: struct kho_vmalloc
- *       KHO vmalloc preservation for an array of &struct memfd_luo_folio_ser,
- *       one for each preserved folio from the original file's mapping. Only
- *       present when size > 0.
- */
-
-/**
- * struct memfd_luo_folio_ser - Serialized state of a single folio.
- * @foliodesc: A packed 64-bit value containing both the PFN and status flags of
- *             the preserved folio. The upper 52 bits store the PFN, and the
- *             lower 12 bits are reserved for flags (e.g., dirty, uptodate).
- * @index:     The page offset (pgoff_t) of the folio within the original file's
- *             address space. This is used to correctly position the folio
- *             during restoration.
- *
- * This structure represents the minimal information required to restore a
- * single folio in the new kernel. An array of these structs forms the binary
- * data for the "folios" property in the handover FDT.
- */
-struct memfd_luo_folio_ser {
-	u64 foliodesc;
-	u64 index;
-};
-
-/* The strings used for memfd KHO FDT sub-tree. */
-
-/* 64-bit pos value for the preserved memfd */
-#define MEMFD_FDT_POS		"pos"
-
-/* 64-bit size value of the preserved memfd */
-#define MEMFD_FDT_SIZE		"size"
-
-#define MEMFD_FDT_FOLIOS	"folios"
-
-/* Number of folios in the folios array. */
-#define MEMFD_FDT_NR_FOLIOS	"nr_folios"
-
-/* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
-
-#endif /* _LINUX_LIVEUPDATE_ABI_MEMFD_H */
--- a/include/linux/liveupdate.h~b
+++ a/include/linux/liveupdate.h
@@ -8,9 +8,11 @@
 #define _LINUX_LIVEUPDATE_H
 
 #include <linux/bug.h>
-#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/list.h>
-#include <linux/liveupdate/abi/luo.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_file_handler;
@@ -85,9 +87,6 @@ struct liveupdate_file_ops {
  *                      that uniquely identifies the file type this handler
  *                      supports. This is matched against the compatible string
  *                      associated with individual &struct file instances.
- * @list:               Used for linking this handler instance into a global
- *                      list of registered file handlers.
- * @flb_list:           A list of FLB dependencies.
  *
  * Modules that want to support live update for specific file types should
  * register an instance of this structure. LUO uses this registration to
@@ -97,8 +96,16 @@ struct liveupdate_file_ops {
 struct liveupdate_file_handler {
 	const struct liveupdate_file_ops *ops;
 	const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
-	struct list_head list;
-	struct list_head flb_list;
+
+	/* private: */
+
+	/*
+	 * Used for linking this handler instance into a global list of
+	 * registered file handlers.
+	 */
+	struct list_head __private list;
+	/* A list of FLB dependencies. */
+	struct list_head __private flb_list;
 };
 
 /**
@@ -150,6 +157,42 @@ struct liveupdate_flb_ops {
 	struct module *owner;
 };
 
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
 /**
  * struct liveupdate_flb - A global definition for a shared data object.
  * @ops:         Callback functions
@@ -158,20 +201,17 @@ struct liveupdate_flb_ops {
  *               supports. This is matched against the compatible string
  *               associated with individual &struct liveupdate_flb
  *               instances.
- * @list:        A global list of registered FLBs.
- * @internal:    Internal state, set in liveupdate_init_flb().
  *
  * This struct is the "template" that a driver registers to define a shared,
  * file-lifecycle-bound object. The actual runtime state (the live object,
- * refcount, etc.) is managed internally by the LUO core.
- * Use liveupdate_init_flb() to initialize this struct before using it in
- * other functions.
+ * refcount, etc.) is managed privately by the LUO core.
  */
 struct liveupdate_flb {
 	const struct liveupdate_flb_ops *ops;
 	const char compatible[LIVEUPDATE_FLB_COMPAT_LENGTH];
-	struct list_head list;
-	void *internal;
+
+	/* private: */
+	struct luo_flb_private __private private;
 };
 
 #ifdef CONFIG_LIVEUPDATE
@@ -182,7 +222,8 @@ bool liveupdate_enabled(void);
 /* Called during kexec to tell LUO that entered into reboot */
 int liveupdate_reboot(void);
 
-int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
+int liveupdate_register_file_handler(struct liveupdate_file_handler *fh);
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh);
 
 /* kernel can internally retrieve files */
 int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
@@ -192,11 +233,10 @@ int liveupdate_get_file_incoming(struct
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
 
-/* Before using FLB for the first time it should be initialized */
-int liveupdate_init_flb(struct liveupdate_flb *flb);
-
-int liveupdate_register_flb(struct liveupdate_file_handler *h,
+int liveupdate_register_flb(struct liveupdate_file_handler *fh,
 			    struct liveupdate_flb *flb);
+int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
+			      struct liveupdate_flb *flb);
 
 int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp);
 void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj);
@@ -215,7 +255,12 @@ static inline int liveupdate_reboot(void
 	return 0;
 }
 
-static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *h)
+static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 {
 	return -EOPNOTSUPP;
 }
@@ -232,13 +277,14 @@ static inline int liveupdate_get_token_o
 	return -EOPNOTSUPP;
 }
 
-static inline int liveupdate_init_flb(struct liveupdate_flb *flb)
+static inline int liveupdate_register_flb(struct liveupdate_file_handler *fh,
+					  struct liveupdate_flb *flb)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int liveupdate_register_flb(struct liveupdate_file_handler *h,
-					  struct liveupdate_flb *flb)
+static inline int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
+					    struct liveupdate_flb *flb)
 {
 	return -EOPNOTSUPP;
 }
--- a/include/linux/shmem_fs.h~b
+++ a/include/linux/shmem_fs.h
@@ -201,7 +201,7 @@ static inline bool shmem_file(struct fil
 }
 
 /* Must be called with inode lock taken exclusive. */
-static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)
+static inline void shmem_freeze(struct inode *inode, bool freeze)
 {
 	if (freeze)
 		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
--- a/include/uapi/linux/liveupdate.h~b
+++ a/include/uapi/linux/liveupdate.h
@@ -67,7 +67,7 @@ enum {
  * @fd:		Output; The new file descriptor for the created session.
  * @name:	Input; A null-terminated string for the session name, max
  *		length %LIVEUPDATE_SESSION_NAME_LENGTH including termination
- *		char.
+ *		character.
  *
  * Creates a new live update session for managing preserved resources.
  * This ioctl can only be called on the main /dev/liveupdate device.
@@ -155,7 +155,7 @@ struct liveupdate_session_preserve_fd {
 
 /**
  * struct liveupdate_session_retrieve_fd - ioctl(LIVEUPDATE_SESSION_RETRIEVE_FD)
- * @size:  Input; sizeof(struct liveupdate_session_RETRIEVE_fd)
+ * @size:  Input; sizeof(struct liveupdate_session_retrieve_fd)
  * @fd:    Output; The new file descriptor representing the fully restored
  *         kernel resource.
  * @token: Input; An opaque, token that was used to preserve the resource.
--- a/kernel/liveupdate/luo_core.c~b
+++ a/kernel/liveupdate/luo_core.c
@@ -16,9 +16,8 @@
  *
  * While the primary use case driving this work is supporting live updates of
  * the Linux kernel when it is used as a hypervisor in cloud environments, the
- * LUO framework itself is designed to be workload-agnostic. Much like Kernel
- * Live Patching, which applies security fixes regardless of the workload,
- * Live Update facilitates a full kernel version upgrade for any type of system.
+ * LUO framework itself is designed to be workload-agnostic. Live Update
+ * facilitates a full kernel version upgrade for any type of system.
  *
  * For example, a non-hypervisor system running an in-memory cache like
  * memcached with many gigabytes of data can use LUO. The userspace service
@@ -42,17 +41,23 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/kobject.h>
 #include <linux/libfdt.h>
 #include <linux/liveupdate.h>
-#include <linux/liveupdate/abi/luo.h>
+#include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
-
 #include "kexec_handover_internal.h"
 #include "luo_internal.h"
 
@@ -133,9 +138,9 @@ static int __init liveupdate_early_init(
 
 	err = luo_early_startup();
 	if (err) {
-		pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
-		       ERR_PTR(err));
 		luo_global.enabled = false;
+		luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
+				 ERR_PTR(err));
 	}
 
 	return err;
@@ -250,3 +255,200 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+
+/**
+ * DOC: LUO ioctl Interface
+ *
+ * The IOCTL user-space control interface for the LUO subsystem.
+ * It registers a character device, typically found at ``/dev/liveupdate``,
+ * which allows a userspace agent to manage the LUO state machine and its
+ * associated resources, such as preservable file descriptors.
+ *
+ * To ensure that the state machine is controlled by a single entity, access
+ * to this device is exclusive: only one process is permitted to have
+ * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
+ * fail with -EBUSY until the first process closes its file descriptor.
+ * This singleton model simplifies state management by preventing conflicting
+ * commands from multiple userspace agents.
+ */
+
+struct luo_device_state {
+	struct miscdevice miscdev;
+	atomic_t in_use;
+};
+
+static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_create(argp->name, &file);
+	if (err)
+		goto err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		goto err_put_file;
+
+	fd_install(argp->fd, file);
+
+	return 0;
+
+err_put_file:
+	fput(file);
+err_put_fd:
+	put_unused_fd(argp->fd);
+
+	return err;
+}
+
+static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
+{
+	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	struct file *file;
+	int err;
+
+	argp->fd = get_unused_fd_flags(O_CLOEXEC);
+	if (argp->fd < 0)
+		return argp->fd;
+
+	err = luo_session_retrieve(argp->name, &file);
+	if (err < 0)
+		goto err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	if (err)
+		goto err_put_file;
+
+	fd_install(argp->fd, file);
+
+	return 0;
+
+err_put_file:
+	fput(file);
+err_put_fd:
+	put_unused_fd(argp->fd);
+
+	return err;
+}
+
+static int luo_open(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+
+	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
+		return -EBUSY;
+
+	/* Always return -EIO to user if deserialization fail */
+	if (luo_session_deserialize()) {
+		atomic_set(&ldev->in_use, 0);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int luo_release(struct inode *inodep, struct file *filep)
+{
+	struct luo_device_state *ldev = container_of(filep->private_data,
+						     struct luo_device_state,
+						     miscdev);
+	atomic_set(&ldev->in_use, 0);
+
+	return 0;
+}
+
+union ucmd_buffer {
+	struct liveupdate_ioctl_create_session create;
+	struct liveupdate_ioctl_retrieve_session retrieve;
+};
+
+struct luo_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct luo_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_BASE] = {                            \
+		.size = sizeof(_struct) +                                      \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
+					  sizeof(_struct)),                    \
+		.min_size = offsetofend(_struct, _last),                       \
+		.ioctl_num = _ioctl,                                           \
+		.execute = _fn,                                                \
+	}
+
+static const struct luo_ioctl_op luo_ioctl_ops[] = {
+	IOCTL_OP(LIVEUPDATE_IOCTL_CREATE_SESSION, luo_ioctl_create_session,
+		 struct liveupdate_ioctl_create_session, name),
+	IOCTL_OP(LIVEUPDATE_IOCTL_RETRIEVE_SESSION, luo_ioctl_retrieve_session,
+		 struct liveupdate_ioctl_retrieve_session, name),
+};
+
+static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	const struct luo_ioctl_op *op;
+	struct luo_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int err;
+
+	nr = _IOC_NR(cmd);
+	if (nr < LIVEUPDATE_CMD_BASE ||
+	    (nr - LIVEUPDATE_CMD_BASE) >= ARRAY_SIZE(luo_ioctl_ops)) {
+		return -EINVAL;
+	}
+
+	ucmd.ubuffer = (void __user *)arg;
+	err = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (err)
+		return err;
+
+	op = &luo_ioctl_ops[nr - LIVEUPDATE_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ucmd.cmd = &buf;
+	err = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (err)
+		return err;
+
+	return op->execute(&ucmd);
+}
+
+static const struct file_operations luo_fops = {
+	.owner		= THIS_MODULE,
+	.open		= luo_open,
+	.release	= luo_release,
+	.unlocked_ioctl	= luo_ioctl,
+};
+
+static struct luo_device_state luo_dev = {
+	.miscdev = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name  = "liveupdate",
+		.fops  = &luo_fops,
+	},
+	.in_use = ATOMIC_INIT(0),
+};
+
+static int __init liveupdate_ioctl_init(void)
+{
+	if (!liveupdate_enabled())
+		return 0;
+
+	return misc_register(&luo_dev.miscdev);
+}
+late_initcall(liveupdate_ioctl_init);
--- a/kernel/liveupdate/luo_file.c~b
+++ a/kernel/liveupdate/luo_file.c
@@ -25,9 +25,9 @@
  *   - can_preserve(): A lightweight check to determine if the handler is
  *     compatible with a given 'struct file'.
  *   - preserve(): The heavyweight operation that saves the file's state and
- *     returns an opaque u64 handle, happens while vcpus are still running.
- *     LUO becomes the owner of this file until session is closed or file is
- *     finished.
+ *     returns an opaque u64 handle. This is typically performed while the
+ *     workload is still active to minimize the downtime during the
+ *     actual reboot transition.
  *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
  *     if the preservation process is aborted before the reboot (i.e. session is
  *     closed).
@@ -45,18 +45,19 @@
  *
  * 1. Preserve (Normal Operation): A userspace agent preserves files one by one
  *    via an ioctl. For each file, luo_preserve_file() finds a compatible
- *    handler, calls its .preserve() op, and creates an internal &struct
+ *    handler, calls its .preserve() operation, and creates an internal &struct
  *    luo_file to track the live state.
  *
  * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
  *    It iterates through all preserved files, calls their respective .freeze()
- *    ops, and serializes their final metadata (compatible string, token, and
- *    data handle) into a contiguous memory block for KHO.
+ *    operation, and serializes their final metadata (compatible string, token,
+ *    and data handle) into a contiguous memory block for KHO.
  *
- * 3. Deserialize (New Kernel - Early Boot): After kexec, luo_file_deserialize()
- *    runs. It reads the serialized data from the KHO memory region and
- *    reconstructs the in-memory list of &struct luo_file instances for the new
- *    kernel, linking them to their corresponding handlers.
+ * 3. Deserialize: After kexec, luo_file_deserialize() runs when session gets
+ *    deserialized (which is when /dev/liveupdate is first opened). It reads the
+ *    serialized data from the KHO memory region and reconstructs the in-memory
+ *    list of &struct luo_file instances for the new kernel, linking them to
+ *    their corresponding handlers.
  *
  * 4. Retrieve (New Kernel - Userspace Ready): The userspace agent can now
  *    restore file descriptors by providing a token. luo_retrieve_file()
@@ -65,9 +66,9 @@
  *    retrieved in ANY order.
  *
  * 5. Finish (New Kernel - Cleanup): Once a session retrival is complete,
- *    luo_file_finish() is called. It iterates through all files,
- *    invokes their .finish() ops for final cleanup, and releases all
- *    associated kernel resources.
+ *    luo_file_finish() is called. It iterates through all files, invokes their
+ *    .finish() operations for final cleanup, and releases all associated kernel
+ *    resources.
  *
  * File Preservation Lifecycle unhappy paths:
  *
@@ -95,13 +96,15 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cleanup.h>
+#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/io.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/liveupdate.h>
-#include <linux/liveupdate/abi/luo.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -110,7 +113,7 @@
 
 static LIST_HEAD(luo_file_handler_list);
 
-/* 2 4K pages, give space for 128 files per session */
+/* 2 4K pages, give space for 128 files per file_set */
 #define LUO_FILE_PGCNT		2ul
 #define LUO_FILE_MAX							\
 	((LUO_FILE_PGCNT << PAGE_SHIFT) / sizeof(struct luo_file_ser))
@@ -137,7 +140,7 @@ static LIST_HEAD(luo_file_handler_list);
  *                 (e.g., @retrieved, @file), ensuring that operations like
  *                 retrieving or finishing a file are atomic.
  * @list:          The list_head linking this instance into its parent
- *                 session's list of preserved files.
+ *                 file_set's list of preserved files.
  * @token:         The user-provided unique token used to identify this file.
  *
  * This structure is the core in-kernel representation of a single file being
@@ -146,7 +149,7 @@ static LIST_HEAD(luo_file_handler_list);
  * and the serialized state handle returned by the handler's .preserve()
  * operation.
  *
- * These instances are tracked in a per-session list. The @serialized_data
+ * These instances are tracked in a per-file_set list. The @serialized_data
  * field, which holds a handle to the file's serialized state, may be updated
  * during the .freeze() callback before being serialized for the next kernel.
  * After reboot, these structures are recreated by luo_file_deserialize() and
@@ -163,46 +166,44 @@ struct luo_file {
 	u64 token;
 };
 
-static int luo_session_alloc_files_mem(struct luo_session *session)
+static int luo_alloc_files_mem(struct luo_file_set *file_set)
 {
 	size_t size;
 	void *mem;
 
-	if (session->files)
+	if (file_set->files)
 		return 0;
 
-	WARN_ON_ONCE(session->count);
+	WARN_ON_ONCE(file_set->count);
 
 	size = LUO_FILE_PGCNT << PAGE_SHIFT;
 	mem = kho_alloc_preserve(size);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-	session->files = mem;
-	session->pgcnt = LUO_FILE_PGCNT;
+	file_set->files = mem;
 
 	return 0;
 }
 
-static void luo_session_free_files_mem(struct luo_session *session)
+static void luo_free_files_mem(struct luo_file_set *file_set)
 {
-	/* If session has files, no need to free preservation memory */
-	if (session->count)
+	/* If file_set has files, no need to free preservation memory */
+	if (file_set->count)
 		return;
 
-	if (!session->files)
+	if (!file_set->files)
 		return;
 
-	kho_unpreserve_free(session->files);
-	session->files = NULL;
-	session->pgcnt = 0;
+	kho_unpreserve_free(file_set->files);
+	file_set->files = NULL;
 }
 
-static bool luo_token_is_used(struct luo_session *session, u64 token)
+static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
 {
 	struct luo_file *iter;
 
-	list_for_each_entry(iter, &session->files_list, list) {
+	list_for_each_entry(iter, &file_set->files_list, list) {
 		if (iter->token == token)
 			return true;
 	}
@@ -212,9 +213,9 @@ static bool luo_token_is_used(struct luo
 
 /**
  * luo_preserve_file - Initiate the preservation of a file descriptor.
- * @session: The session to which the preserved file will be added.
- * @token:   A unique, user-provided identifier for the file.
- * @fd:      The file descriptor to be preserved.
+ * @file_set: The file_set to which the preserved file will be added.
+ * @token:    A unique, user-provided identifier for the file.
+ * @fd:       The file descriptor to be preserved.
  *
  * This function orchestrates the first phase of preserving a file. Upon entry,
  * it takes a reference to the 'struct file' via fget(), effectively making LUO
@@ -225,14 +226,14 @@ static bool luo_token_is_used(struct luo
  * This function orchestrates the first phase of preserving a file. It performs
  * the following steps:
  *
- * 1. Validates that the @token is not already in use within the session.
- * 2. Ensures the session's memory for files serialization is allocated
+ * 1. Validates that the @token is not already in use within the file_set.
+ * 2. Ensures the file_set's memory for files serialization is allocated
  *    (allocates if needed).
  * 3. Iterates through registered handlers, calling can_preserve() to find one
  *    compatible with the given @fd.
  * 4. Calls the handler's .preserve() operation, which saves the file's state
  *    and returns an opaque private data handle.
- * 5. Adds the new instance to the session's internal list.
+ * 5. Adds the new instance to the file_set's internal list.
  *
  * On success, LUO takes a reference to the 'struct file' and considers it
  * under its management until it is unpreserved or finished.
@@ -244,12 +245,12 @@ static bool luo_token_is_used(struct luo
  * Return: 0 on success. Returns a negative errno on failure:
  *         -EEXIST if the token is already used.
  *         -EBADF if the file descriptor is invalid.
- *         -ENOSPC if the session is full.
+ *         -ENOSPC if the file_set is full.
  *         -ENOENT if no compatible handler is found.
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_session *session, u64 token, int fd)
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
@@ -257,26 +258,24 @@ int luo_preserve_file(struct luo_session
 	struct file *file;
 	int err;
 
-	lockdep_assert_held(&session->mutex);
-
-	if (luo_token_is_used(session, token))
+	if (luo_token_is_used(file_set, token))
 		return -EEXIST;
 
 	file = fget(fd);
 	if (!file)
 		return -EBADF;
 
-	err = luo_session_alloc_files_mem(session);
+	err = luo_alloc_files_mem(file_set);
 	if (err)
-		goto  exit_err;
+		goto  err_files_mem;
 
-	if (session->count == LUO_FILE_MAX) {
+	if (file_set->count == LUO_FILE_MAX) {
 		err = -ENOSPC;
-		goto exit_err;
+		goto err_files_mem;
 	}
 
 	err = -ENOENT;
-	list_for_each_entry(fh, &luo_file_handler_list, list) {
+	luo_list_for_each_private(fh, &luo_file_handler_list, list) {
 		if (fh->ops->can_preserve(fh, file)) {
 			err = 0;
 			break;
@@ -285,16 +284,16 @@ int luo_preserve_file(struct luo_session
 
 	/* err is still -ENOENT if no handler was found */
 	if (err)
-		goto exit_err;
+		goto err_files_mem;
 
 	err = luo_flb_file_preserve(fh);
 	if (err)
-		goto exit_err;
+		goto err_files_mem;
 
 	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
 	if (!luo_file) {
 		err = -ENOMEM;
-		goto exit_err;
+		goto err_files_mem;
 	}
 
 	luo_file->file = file;
@@ -304,41 +303,41 @@ int luo_preserve_file(struct luo_session
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
-	args.session = (struct liveupdate_session *)session;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = file;
 	err = fh->ops->preserve(&args);
-	if (err) {
-		mutex_destroy(&luo_file->mutex);
-		kfree(luo_file);
-		luo_flb_file_unpreserve(fh);
-		goto exit_err;
-	} else {
-		luo_file->serialized_data = args.serialized_data;
-		luo_file->private_data = args.private_data;
-		list_add_tail(&luo_file->list, &session->files_list);
-		session->count++;
-	}
+	if (err)
+		goto err_kfree;
+
+	luo_file->serialized_data = args.serialized_data;
+	luo_file->private_data = args.private_data;
+	list_add_tail(&luo_file->list, &file_set->files_list);
+	file_set->count++;
 
 	return 0;
 
-exit_err:
+err_kfree:
+	mutex_destroy(&luo_file->mutex);
+	kfree(luo_file);
+	luo_flb_file_unpreserve(fh);
+err_files_mem:
 	fput(file);
-	luo_session_free_files_mem(session);
+	luo_free_files_mem(file_set);
 
 	return err;
 }
 
 /**
- * luo_file_unpreserve_files - Unpreserves all files from a session.
- * @session: The session to be cleaned up.
+ * luo_file_unpreserve_files - Unpreserves all files from a file_set.
+ * @file_set: The files to be cleaned up.
  *
- * This function serves as the primary cleanup path for a session. It is
- * invoked when the userspace agent closes the session's file descriptor.
+ * This function serves as the primary cleanup path for a file_set. It is
+ * invoked when the userspace agent closes the file_set's file descriptor.
  *
  * For each file, it performs the following cleanup actions:
  *   1. Calls the handler's .unpreserve() callback to allow the handler to
  *      release any resources it allocated.
- *   2. Removes the file from the session's internal tracking list.
+ *   2. Removes the file from the file_set's internal tracking list.
  *   3. Releases the reference to the 'struct file' that was taken by
  *      luo_preserve_file() via fput(), returning ownership.
  *   4. Frees the memory associated with the internal 'struct luo_file'.
@@ -346,20 +345,18 @@ exit_err:
  * After all individual files are unpreserved, it frees the contiguous memory
  * block that was allocated to hold their serialization data.
  */
-void luo_file_unpreserve_files(struct luo_session *session)
+void luo_file_unpreserve_files(struct luo_file_set *file_set)
 {
 	struct luo_file *luo_file;
 
-	lockdep_assert_held(&session->mutex);
-
-	while (!list_empty(&session->files_list)) {
+	while (!list_empty(&file_set->files_list)) {
 		struct liveupdate_file_op_args args = {0};
 
-		luo_file = list_last_entry(&session->files_list,
+		luo_file = list_last_entry(&file_set->files_list,
 					   struct luo_file, list);
 
 		args.handler = luo_file->fh;
-		args.session = (struct liveupdate_session *)session;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -367,17 +364,17 @@ void luo_file_unpreserve_files(struct lu
 		luo_flb_file_unpreserve(luo_file->fh);
 
 		list_del(&luo_file->list);
-		session->count--;
+		file_set->count--;
 
 		fput(luo_file->file);
 		mutex_destroy(&luo_file->mutex);
 		kfree(luo_file);
 	}
 
-	luo_session_free_files_mem(session);
+	luo_free_files_mem(file_set);
 }
 
-static int luo_file_freeze_one(struct luo_session *session,
+static int luo_file_freeze_one(struct luo_file_set *file_set,
 			       struct luo_file *luo_file)
 {
 	int err = 0;
@@ -388,7 +385,7 @@ static int luo_file_freeze_one(struct lu
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
-		args.session = (struct liveupdate_session *)session;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -401,7 +398,7 @@ static int luo_file_freeze_one(struct lu
 	return err;
 }
 
-static void luo_file_unfreeze_one(struct luo_session *session,
+static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 				  struct luo_file *luo_file)
 {
 	guard(mutex)(&luo_file->mutex);
@@ -410,7 +407,7 @@ static void luo_file_unfreeze_one(struct
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
-		args.session = (struct liveupdate_session *)session;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -421,29 +418,30 @@ static void luo_file_unfreeze_one(struct
 	luo_file->serialized_data = 0;
 }
 
-static void __luo_file_unfreeze(struct luo_session *session,
+static void __luo_file_unfreeze(struct luo_file_set *file_set,
 				struct luo_file *failed_entry)
 {
-	struct list_head *files_list = &session->files_list;
+	struct list_head *files_list = &file_set->files_list;
 	struct luo_file *luo_file;
 
 	list_for_each_entry(luo_file, files_list, list) {
 		if (luo_file == failed_entry)
 			break;
 
-		luo_file_unfreeze_one(session, luo_file);
+		luo_file_unfreeze_one(file_set, luo_file);
 	}
 
-	memset(session->files, 0, session->pgcnt << PAGE_SHIFT);
+	memset(file_set->files, 0, LUO_FILE_PGCNT << PAGE_SHIFT);
 }
 
 /**
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
- * @session: The session whose files are to be frozen.
+ * @file_set:     The file_set whose files are to be frozen.
+ * @file_set_ser: Where to put the serialized file_set.
  *
  * This function is called from the reboot() syscall path, just before the
  * kernel transitions to the new image via kexec. Its purpose is to perform the
- * final preparation and serialization of all preserved files in the session.
+ * final preparation and serialization of all preserved files in the file_set.
  *
  * It iterates through each preserved file in FIFO order (the order of
  * preservation) and performs two main actions:
@@ -456,7 +454,7 @@ static void __luo_file_unfreeze(struct l
  * 2. Serializes Metadata: After a successful freeze, it copies the final file
  *    metadata—the handler's compatible string, the user token, and the final
  *    private data handle—into the pre-allocated contiguous memory buffer
- *    (session->files) that will be handed over to the next kernel via KHO.
+ *    (file_set->files) that will be handed over to the next kernel via KHO.
  *
  * Error Handling (Rollback):
  * This function is atomic. If any handler's .freeze() operation fails, the
@@ -469,29 +467,28 @@ static void __luo_file_unfreeze(struct l
  * Context: Called only from the liveupdate_reboot() path.
  * Return: 0 on success, or a negative errno on failure.
  */
-int luo_file_freeze(struct luo_session *session)
+int luo_file_freeze(struct luo_file_set *file_set,
+		    struct luo_file_set_ser *file_set_ser)
 {
-	struct luo_file_ser *file_ser = session->files;
+	struct luo_file_ser *file_ser = file_set->files;
 	struct luo_file *luo_file;
 	int err;
 	int i;
 
-	lockdep_assert_held(&session->mutex);
-
-	if (!session->count)
+	if (!file_set->count)
 		return 0;
 
 	if (WARN_ON(!file_ser))
 		return -EINVAL;
 
 	i = 0;
-	list_for_each_entry(luo_file, &session->files_list, list) {
-		err = luo_file_freeze_one(session, luo_file);
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
+		err = luo_file_freeze_one(file_set, luo_file);
 		if (err < 0) {
-			pr_warn("Freeze failed for session[%s] token[%#0llx] handler[%s] err[%pe]\n",
-				session->name, luo_file->token,
-				luo_file->fh->compatible, ERR_PTR(err));
-			goto exit_err;
+			pr_warn("Freeze failed for token[%#0llx] handler[%s] err[%pe]\n",
+				luo_file->token, luo_file->fh->compatible,
+				ERR_PTR(err));
+			goto err_unfreeze;
 		}
 
 		strscpy(file_ser[i].compatible, luo_file->fh->compatible,
@@ -501,48 +498,53 @@ int luo_file_freeze(struct luo_session *
 		i++;
 	}
 
+	file_set_ser->count = file_set->count;
+	if (file_set->files)
+		file_set_ser->files = virt_to_phys(file_set->files);
+
 	return 0;
 
-exit_err:
-	__luo_file_unfreeze(session, luo_file);
+err_unfreeze:
+	__luo_file_unfreeze(file_set, luo_file);
 
 	return err;
 }
 
 /**
- * luo_file_unfreeze - Unfreezes all files in a session.
- * @session: The session whose files are to be unfrozen.
+ * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
+ * @file_set:     The file_set whose files are to be unfrozen.
+ * @file_set_ser: Serialized file_set.
  *
- * This function rolls back the state of all files in a session after the freeze
- * phase has begun but must be aborted. It is the counterpart to
+ * This function rolls back the state of all files in a file_set after the
+ * freeze phase has begun but must be aborted. It is the counterpart to
  * luo_file_freeze().
  *
  * It invokes the __luo_file_unfreeze() helper with a NULL argument, which
- * signals the helper to iterate through all files in the session  and call
+ * signals the helper to iterate through all files in the file_set and call
  * their respective .unfreeze() handler callbacks.
  *
  * Context: This is called when the live update is aborted during
  *          the reboot() syscall, after luo_file_freeze() has been called.
  */
-void luo_file_unfreeze(struct luo_session *session)
+void luo_file_unfreeze(struct luo_file_set *file_set,
+		       struct luo_file_set_ser *file_set_ser)
 {
-	lockdep_assert_held(&session->mutex);
-
-	if (!session->count)
+	if (!file_set->count)
 		return;
 
-	__luo_file_unfreeze(session, NULL);
+	__luo_file_unfreeze(file_set, NULL);
+	memset(file_set_ser, 0, sizeof(*file_set_ser));
 }
 
 /**
- * luo_retrieve_file - Restores a preserved file from a session by its token.
- * @session: The session from which to retrieve the file.
- * @token:   The unique token identifying the file to be restored.
- * @filep:   Output parameter; on success, this is populated with a pointer
- *           to the newly retrieved 'struct file'.
+ * luo_retrieve_file - Restores a preserved file from a file_set by its token.
+ * @file_set: The file_set from which to retrieve the file.
+ * @token:    The unique token identifying the file to be restored.
+ * @filep:    Output parameter; on success, this is populated with a pointer
+ *            to the newly retrieved 'struct file'.
  *
  * This function is the primary mechanism for recreating a file in the new
- * kernel after a live update. It searches the session's list of deserialized
+ * kernel after a live update. It searches the file_set's list of deserialized
  * files for an entry matching the provided @token.
  *
  * The operation is idempotent: if a file has already been successfully
@@ -559,19 +561,17 @@ void luo_file_unfreeze(struct luo_sessio
  *         -ENOENT if no file with the matching token is found.
  *         Any error code returned by the handler's .retrieve() op.
  */
-int luo_retrieve_file(struct luo_session *session, u64 token,
+int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct luo_file *luo_file;
 	int err;
 
-	lockdep_assert_held(&session->mutex);
-
-	if (list_empty(&session->files_list))
+	if (list_empty(&file_set->files_list))
 		return -ENOENT;
 
-	list_for_each_entry(luo_file, &session->files_list, list) {
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
 		if (luo_file->token == token)
 			break;
 	}
@@ -591,7 +591,7 @@ int luo_retrieve_file(struct luo_session
 	}
 
 	args.handler = luo_file->fh;
-	args.session = (struct liveupdate_session *)session;
+	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
 	if (!err) {
@@ -606,7 +606,7 @@ int luo_retrieve_file(struct luo_session
 	return err;
 }
 
-static int luo_file_can_finish_one(struct luo_session *session,
+static int luo_file_can_finish_one(struct luo_file_set *file_set,
 				   struct luo_file *luo_file)
 {
 	bool can_finish = true;
@@ -617,7 +617,7 @@ static int luo_file_can_finish_one(struc
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
-		args.session = (struct liveupdate_session *)session;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.retrieved = luo_file->retrieved;
@@ -627,7 +627,7 @@ static int luo_file_can_finish_one(struc
 	return can_finish ? 0 : -EBUSY;
 }
 
-static void luo_file_finish_one(struct luo_session *session,
+static void luo_file_finish_one(struct luo_file_set *file_set,
 				struct luo_file *luo_file)
 {
 	struct liveupdate_file_op_args args = {0};
@@ -635,7 +635,7 @@ static void luo_file_finish_one(struct l
 	guard(mutex)(&luo_file->mutex);
 
 	args.handler = luo_file->fh;
-	args.session = (struct liveupdate_session *)session;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieved = luo_file->retrieved;
@@ -645,24 +645,24 @@ static void luo_file_finish_one(struct l
 }
 
 /**
- * luo_file_finish - Completes the lifecycle for all files in a session.
- * @session: The session to be finalized.
+ * luo_file_finish - Completes the lifecycle for all files in a file_set.
+ * @file_set: The file_set to be finalized.
  *
- * This function orchestrates the final teardown of a live update session in the
- * new kernel. It should be called after all necessary files have been
+ * This function orchestrates the final teardown of a live update file_set in
+ * the new kernel. It should be called after all necessary files have been
  * retrieved and the userspace agent is ready to release the preserved state.
  *
  * The function iterates through all tracked files. For each file, it performs
  * the following sequence of cleanup actions:
  *
  * 1. If file is not yet retrieved, retrieves it, and calls can_finish() on
- *    every file in the session. If all can_finish return true, continue to
+ *    every file in the file_set. If all can_finish return true, continue to
  *    finish.
  * 2. Calls the handler's .finish() callback (via luo_file_finish_one) to
  *    allow for final resource cleanup within the handler.
  * 3. Releases LUO's ownership reference on the 'struct file' via fput(). This
  *    is the counterpart to the get_file() call in luo_retrieve_file().
- * 4. Removes the 'struct luo_file' from the session's internal list.
+ * 4. Removes the 'struct luo_file' from the file_set's internal list.
  * 5. Frees the memory for the 'struct luo_file' instance itself.
  *
  * After successfully finishing all individual files, it frees the
@@ -676,41 +676,38 @@ static void luo_file_finish_one(struct l
  * Context: Can be called from an ioctl handler in the new kernel.
  * Return: 0 on success, or a negative errno on failure.
  */
-int luo_file_finish(struct luo_session *session)
+int luo_file_finish(struct luo_file_set *file_set)
 {
-	struct list_head *files_list = &session->files_list;
+	struct list_head *files_list = &file_set->files_list;
 	struct luo_file *luo_file;
 	int err;
 
-	if (!session->count)
+	if (!file_set->count)
 		return 0;
 
-	lockdep_assert_held(&session->mutex);
-
 	list_for_each_entry(luo_file, files_list, list) {
-		err = luo_file_can_finish_one(session, luo_file);
+		err = luo_file_can_finish_one(file_set, luo_file);
 		if (err)
 			return err;
 	}
 
-	while (!list_empty(&session->files_list)) {
-		luo_file = list_last_entry(&session->files_list,
+	while (!list_empty(&file_set->files_list)) {
+		luo_file = list_last_entry(&file_set->files_list,
 					   struct luo_file, list);
 
-		luo_file_finish_one(session, luo_file);
+		luo_file_finish_one(file_set, luo_file);
 
 		if (luo_file->file)
 			fput(luo_file->file);
 		list_del(&luo_file->list);
-		session->count--;
+		file_set->count--;
 		mutex_destroy(&luo_file->mutex);
 		kfree(luo_file);
 	}
 
-	if (session->files) {
-		kho_restore_free(session->files);
-		session->files = NULL;
-		session->pgcnt = 0;
+	if (file_set->files) {
+		kho_restore_free(file_set->files);
+		file_set->files = NULL;
 	}
 
 	return 0;
@@ -718,7 +715,8 @@ int luo_file_finish(struct luo_session *
 
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
- * @session: The incoming session containing the serialized file data from KHO.
+ * @file_set:     The incoming file_set to fill with deserialized data.
+ * @file_set_ser: Serialized KHO file_set data from the previous kernel.
  *
  * This function is called during the early boot process of the new kernel. It
  * takes the raw, contiguous memory block of 'struct luo_file_ser' entries,
@@ -733,30 +731,49 @@ int luo_file_finish(struct luo_session *
  *   4. Populates the new structure with the deserialized data (token, private
  *      data handle) and links it to the found handler. The 'file' pointer is
  *      initialized to NULL, as the file has not been retrieved yet.
- *   5. Adds the new 'struct luo_file' to the session's files_list.
+ *   5. Adds the new 'struct luo_file' to the file_set's files_list.
  *
- * This prepares the session for userspace, which can later call
+ * This prepares the file_set for userspace, which can later call
  * luo_retrieve_file() to restore the actual file descriptors.
  *
  * Context: Called from session deserialization.
  */
-int luo_file_deserialize(struct luo_session *session)
+int luo_file_deserialize(struct luo_file_set *file_set,
+			 struct luo_file_set_ser *file_set_ser)
 {
 	struct luo_file_ser *file_ser;
 	u64 i;
 
-	lockdep_assert_held(&session->mutex);
-
-	if (!session->files)
+	if (!file_set_ser->files) {
+		WARN_ON(file_set_ser->count);
 		return 0;
+	}
+
+	file_set->count = file_set_ser->count;
+	file_set->files = phys_to_virt(file_set_ser->files);
 
-	file_ser = session->files;
-	for (i = 0; i < session->count; i++) {
+	/*
+	 * Note on error handling:
+	 *
+	 * If deserialization fails (e.g., allocation failure or corrupt data),
+	 * we intentionally skip cleanup of files that were already restored.
+	 *
+	 * A partial failure leaves the preserved state inconsistent.
+	 * Implementing a safe "undo" to unwind complex dependencies (sessions,
+	 * files, hardware state) is error-prone and provides little value, as
+	 * the system is effectively in a broken state.
+	 *
+	 * We treat these resources as leaked. The expected recovery path is for
+	 * userspace to detect the failure and trigger a reboot, which will
+	 * reliably reset devices and reclaim memory.
+	 */
+	file_ser = file_set->files;
+	for (i = 0; i < file_set->count; i++) {
 		struct liveupdate_file_handler *fh;
 		bool handler_found = false;
 		struct luo_file *luo_file;
 
-		list_for_each_entry(fh, &luo_file_handler_list, list) {
+		luo_list_for_each_private(fh, &luo_file_handler_list, list) {
 			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
 				handler_found = true;
 				break;
@@ -779,12 +796,23 @@ int luo_file_deserialize(struct luo_sess
 		luo_file->token = file_ser[i].token;
 		luo_file->retrieved = false;
 		mutex_init(&luo_file->mutex);
-		list_add_tail(&luo_file->list, &session->files_list);
+		list_add_tail(&luo_file->list, &file_set->files_list);
 	}
 
 	return 0;
 }
 
+void luo_file_set_init(struct luo_file_set *file_set)
+{
+	INIT_LIST_HEAD(&file_set->files_list);
+}
+
+void luo_file_set_destroy(struct luo_file_set *file_set)
+{
+	WARN_ON(file_set->count);
+	WARN_ON(!list_empty(&file_set->files_list));
+}
+
 /**
  * liveupdate_register_file_handler - Register a file handler with LUO.
  * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
@@ -799,44 +827,99 @@ int luo_file_deserialize(struct luo_sess
  */
 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 {
-	static DEFINE_MUTEX(register_file_handler_lock);
 	struct liveupdate_file_handler *fh_iter;
+	int err;
 
 	if (!liveupdate_enabled())
 		return -EOPNOTSUPP;
 
-	/*
-	 * Once sessions have been deserialized, file handlers cannot be
-	 * registered, it is too late.
-	 */
-	if (WARN_ON(luo_session_is_deserialized()))
-		return -EBUSY;
-
 	/* Sanity check that all required callbacks are set */
 	if (!fh->ops->preserve || !fh->ops->unpreserve ||
 	    !fh->ops->retrieve || !fh->ops->finish) {
 		return -EINVAL;
 	}
 
-	guard(mutex)(&register_file_handler_lock);
-	list_for_each_entry(fh_iter, &luo_file_handler_list, list) {
+	/*
+	 * Ensure the system is quiescent (no active sessions).
+	 * This prevents registering new handlers while sessions are active or
+	 * while deserialization is in progress.
+	 */
+	if (!luo_session_quiesce())
+		return -EBUSY;
+
+	/* Check for duplicate compatible strings */
+	luo_list_for_each_private(fh_iter, &luo_file_handler_list, list) {
 		if (!strcmp(fh_iter->compatible, fh->compatible)) {
 			pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
 			       fh->compatible);
-			return -EEXIST;
+			err = -EEXIST;
+			goto err_resume;
 		}
 	}
 
-	if (!try_module_get(fh->ops->owner))
-		return -EAGAIN;
+	/* Pin the module implementing the handler */
+	if (!try_module_get(fh->ops->owner)) {
+		err = -EAGAIN;
+		goto err_resume;
+	}
 
-	INIT_LIST_HEAD(&fh->list);
-	INIT_LIST_HEAD(&fh->flb_list);
-	list_add_tail(&fh->list, &luo_file_handler_list);
+	INIT_LIST_HEAD(&ACCESS_PRIVATE(fh, flb_list));
+	INIT_LIST_HEAD(&ACCESS_PRIVATE(fh, list));
+	list_add_tail(&ACCESS_PRIVATE(fh, list), &luo_file_handler_list);
+	luo_session_resume();
 
 	liveupdate_test_register(fh);
 
 	return 0;
+
+err_resume:
+	luo_session_resume();
+	return err;
+}
+
+/**
+ * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
+ * @fh: The file handler to unregister
+ *
+ * Unregisters the file handler from the liveupdate core. This function
+ * reverses the operations of liveupdate_register_file_handler().
+ *
+ * It ensures safe removal by checking that:
+ * No live update session is currently in progress.
+ * No FLB registered with this file handler.
+ *
+ * If the unregistration fails, the internal test state is reverted.
+ *
+ * Return: 0 Success. -EOPNOTSUPP when live update is not enabled. -EBUSY A live
+ * update is in progress, can't quiesce live update or FLB is registred with
+ * this file handler.
+ */
+int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
+{
+	int err = -EBUSY;
+
+	if (!liveupdate_enabled())
+		return -EOPNOTSUPP;
+
+	liveupdate_test_unregister(fh);
+
+	if (!luo_session_quiesce())
+		goto err_register;
+
+	if (!list_empty(&ACCESS_PRIVATE(fh, flb_list)))
+		goto err_resume;
+
+	list_del(&ACCESS_PRIVATE(fh, list));
+	module_put(fh->ops->owner);
+	luo_session_resume();
+
+	return 0;
+
+err_resume:
+	luo_session_resume();
+err_register:
+	liveupdate_test_register(fh);
+	return err;
 }
 
 /**
@@ -857,11 +940,11 @@ int liveupdate_register_file_handler(str
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp)
 {
-	struct luo_session *session = (struct luo_session *)s;
+	struct luo_file_set *file_set = luo_file_set_from_session(s);
 	struct luo_file *luo_file;
 	int err = -ENOENT;
 
-	list_for_each_entry(luo_file, &session->files_list, list) {
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
 		if (luo_file->file == file) {
 			if (tokenp)
 				*tokenp = luo_file->token;
@@ -887,10 +970,10 @@ int liveupdate_get_token_outgoing(struct
  * The operation is idempotent; subsequent calls for the same token will return
  * a pointer to the same 'struct file' object.
  *
- * The caller receives a pointer to the file with a reference incremented. The
- * file's lifetime is managed by LUO and any userspace file
- * descriptors. If the caller needs to hold a reference to the file beyond the
- * immediate scope, it must call get_file() itself.
+ * The caller receives a new reference to the file and must call fput() when it
+ * is no longer needed. The file's lifetime is managed by LUO and any userspace
+ * file descriptors. If the caller needs to hold a reference to the file beyond
+ * the immediate scope, it must call get_file() itself.
  *
  * Context: Can be called from any context in the new kernel that has a handle
  *          to a restored session.
@@ -900,7 +983,5 @@ int liveupdate_get_token_outgoing(struct
 int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 				 struct file **filep)
 {
-	struct luo_session *session = (struct luo_session *)s;
-
-	return luo_retrieve_file(session, token, filep);
+	return luo_retrieve_file(luo_file_set_from_session(s), token, filep);
 }
--- a/kernel/liveupdate/luo_flb.c~b
+++ a/kernel/liveupdate/luo_flb.c
@@ -43,10 +43,10 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
-#include <linux/liveupdate/abi/luo.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -85,42 +85,28 @@ struct luo_flb_link {
 	struct list_head list;
 };
 
-/*
- * struct luo_flb_state - Holds the runtime state for one FLB lifecycle path.
- * @count: The number of preserved files currently depending on this FLB.
- *         This is used to trigger the preserve/unpreserve/finish ops on the
- *         first/last file.
- * @data:  The opaque u64 handle returned by .preserve() or passed to
- *         .retrieve().
- * @obj:   The live kernel object returned by .preserve() or .retrieve().
- * @lock:  A mutex that protects all fields within this structure, providing
- *         the synchronization service for the FLB's ops.
- */
-struct luo_flb_state {
-	long count;
-	u64 data;
-	void *obj;
-	struct mutex lock;
-};
+/* luo_flb_get_private - Access private field, and if needed initialize it. */
+static struct luo_flb_private *luo_flb_get_private(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = &ACCESS_PRIVATE(flb, private);
 
-/*
- * struct luo_flb_internal - Keep separate incoming and outgoing states.
- * @outgoing:    The runtime state for the pre-reboot (preserve/unpreserve)
- *               lifecycle.
- * @incoming:    The runtime state for the post-reboot (retrieve/finish)
- *               lifecycle.
- */
-struct luo_flb_internal {
-	struct luo_flb_state outgoing;
-	struct luo_flb_state incoming;
-};
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
 
 static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
 {
-	struct luo_flb_internal *internal = flb->internal;
+	struct luo_flb_private *private = luo_flb_get_private(flb);
 
-	scoped_guard(mutex, &internal->outgoing.lock) {
-		if (!internal->outgoing.count) {
+	scoped_guard(mutex, &private->outgoing.lock) {
+		if (!private->outgoing.count) {
 			struct liveupdate_flb_op_args args = {0};
 			int err;
 
@@ -128,10 +114,10 @@ static int luo_flb_file_preserve_one(str
 			err = flb->ops->preserve(&args);
 			if (err)
 				return err;
-			internal->outgoing.data = args.data;
-			internal->outgoing.obj = args.obj;
+			private->outgoing.data = args.data;
+			private->outgoing.obj = args.obj;
 		}
-		internal->outgoing.count++;
+		private->outgoing.count++;
 	}
 
 	return 0;
@@ -139,37 +125,37 @@ static int luo_flb_file_preserve_one(str
 
 static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
 {
-	struct luo_flb_internal *internal = flb->internal;
+	struct luo_flb_private *private = luo_flb_get_private(flb);
 
-	scoped_guard(mutex, &internal->outgoing.lock) {
-		internal->outgoing.count--;
-		if (!internal->outgoing.count) {
+	scoped_guard(mutex, &private->outgoing.lock) {
+		private->outgoing.count--;
+		if (!private->outgoing.count) {
 			struct liveupdate_flb_op_args args = {0};
 
 			args.flb = flb;
-			args.data = internal->outgoing.data;
-			args.obj = internal->outgoing.obj;
+			args.data = private->outgoing.data;
+			args.obj = private->outgoing.obj;
 
 			if (flb->ops->unpreserve)
 				flb->ops->unpreserve(&args);
 
-			internal->outgoing.data = 0;
-			internal->outgoing.obj = NULL;
+			private->outgoing.data = 0;
+			private->outgoing.obj = NULL;
 		}
 	}
 }
 
 static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 {
+	struct luo_flb_private *private = luo_flb_get_private(flb);
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
-	struct luo_flb_internal *internal = flb->internal;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
 	int err;
 
-	guard(mutex)(&internal->incoming.lock);
+	guard(mutex)(&private->incoming.lock);
 
-	if (internal->incoming.obj)
+	if (private->incoming.obj)
 		return 0;
 
 	if (!fh->active)
@@ -177,8 +163,8 @@ static int luo_flb_retrieve_one(struct l
 
 	for (int i = 0; i < fh->header_ser->count; i++) {
 		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			internal->incoming.data = fh->ser[i].data;
-			internal->incoming.count = fh->ser[i].count;
+			private->incoming.data = fh->ser[i].data;
+			private->incoming.count = fh->ser[i].count;
 			found = true;
 			break;
 		}
@@ -188,15 +174,15 @@ static int luo_flb_retrieve_one(struct l
 		return -ENOENT;
 
 	args.flb = flb;
-	args.data = internal->incoming.data;
+	args.data = private->incoming.data;
 
 	err = flb->ops->retrieve(&args);
 	if (err)
 		return err;
 
-	internal->incoming.obj = args.obj;
+	private->incoming.obj = args.obj;
 
-	if (WARN_ON_ONCE(!internal->incoming.obj))
+	if (WARN_ON_ONCE(!private->incoming.obj))
 		return -EIO;
 
 	return 0;
@@ -204,36 +190,36 @@ static int luo_flb_retrieve_one(struct l
 
 static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 {
-	struct luo_flb_internal *internal = flb->internal;
+	struct luo_flb_private *private = luo_flb_get_private(flb);
 	u64 count;
 
-	scoped_guard(mutex, &internal->incoming.lock)
-		count = --internal->incoming.count;
+	scoped_guard(mutex, &private->incoming.lock)
+		count = --private->incoming.count;
 
 	if (!count) {
 		struct liveupdate_flb_op_args args = {0};
 
-		if (!internal->incoming.obj) {
+		if (!private->incoming.obj) {
 			int err = luo_flb_retrieve_one(flb);
 
 			if (WARN_ON(err))
 				return;
 		}
 
-		scoped_guard(mutex, &internal->incoming.lock) {
+		scoped_guard(mutex, &private->incoming.lock) {
 			args.flb = flb;
-			args.obj = internal->incoming.obj;
+			args.obj = private->incoming.obj;
 			flb->ops->finish(&args);
 
-			internal->incoming.data = 0;
-			internal->incoming.obj = NULL;
+			private->incoming.data = 0;
+			private->incoming.obj = NULL;
 		}
 	}
 }
 
 /**
  * luo_flb_file_preserve - Notifies FLBs that a file is about to be preserved.
- * @h: The file handler for the preserved file.
+ * @fh: The file handler for the preserved file.
  *
  * This function iterates through all FLBs associated with the given file
  * handler. It increments the reference count for each FLB. If the count becomes
@@ -246,12 +232,13 @@ static void luo_flb_file_finish_one(stru
  * Context: Called from luo_preserve_file()
  * Return: 0 on success, or a negative errno on failure.
  */
-int luo_flb_file_preserve(struct liveupdate_file_handler *h)
+int luo_flb_file_preserve(struct liveupdate_file_handler *fh)
 {
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
 	struct luo_flb_link *iter;
 	int err = 0;
 
-	list_for_each_entry(iter, &h->flb_list, list) {
+	list_for_each_entry(iter, flb_list, list) {
 		err = luo_flb_file_preserve_one(iter->flb);
 		if (err)
 			goto exit_err;
@@ -260,7 +247,7 @@ int luo_flb_file_preserve(struct liveupd
 	return 0;
 
 exit_err:
-	list_for_each_entry_continue_reverse(iter, &h->flb_list, list)
+	list_for_each_entry_continue_reverse(iter, flb_list, list)
 		luo_flb_file_unpreserve_one(iter->flb);
 
 	return err;
@@ -268,7 +255,7 @@ exit_err:
 
 /**
  * luo_flb_file_unpreserve - Notifies FLBs that a dependent file was unpreserved.
- * @h: The file handler for the unpreserved file.
+ * @fh: The file handler for the unpreserved file.
  *
  * This function iterates through all FLBs associated with the given file
  * handler, in reverse order of registration. It decrements the reference count
@@ -278,17 +265,18 @@ exit_err:
  * Context: Called when a preserved file is being cleaned up before reboot
  *          (e.g., from luo_file_unpreserve_files()).
  */
-void luo_flb_file_unpreserve(struct liveupdate_file_handler *h)
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
 {
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
 	struct luo_flb_link *iter;
 
-	list_for_each_entry_reverse(iter, &h->flb_list, list)
+	list_for_each_entry_reverse(iter, flb_list, list)
 		luo_flb_file_unpreserve_one(iter->flb);
 }
 
 /**
  * luo_flb_file_finish - Notifies FLBs that a dependent file has been finished.
- * @h: The file handler for the finished file.
+ * @fh: The file handler for the finished file.
  *
  * This function iterates through all FLBs associated with the given file
  * handler, in reverse order of registration. It decrements the incoming
@@ -297,54 +285,22 @@ void luo_flb_file_unpreserve(struct live
  *
  * Context: Called from luo_file_finish() for each file being finished.
  */
-void luo_flb_file_finish(struct liveupdate_file_handler *h)
+void luo_flb_file_finish(struct liveupdate_file_handler *fh)
 {
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
 	struct luo_flb_link *iter;
 
-	list_for_each_entry_reverse(iter, &h->flb_list, list)
+	list_for_each_entry_reverse(iter, flb_list, list)
 		luo_flb_file_finish_one(iter->flb);
 }
 
 /**
- * liveupdate_init_flb - Initializes a liveupdate FLB structure.
- * @flb: The &struct liveupdate_flb to initialize.
- *
- * This function must be called to prepare an FLB structure before it can be
- * used with liveupdate_register_flb() or any other LUO functions.
- *
- * Context: Typically called once from a subsystem's module init function for
- *          each global FLB object that the module defines.
- *
- * Return: 0 on success, or -ENOMEM if memory allocation fails, and -EOPNOTSUPP
- * when live update is disabled or not configured.
- */
-int liveupdate_init_flb(struct liveupdate_flb *flb)
-{
-	struct luo_flb_internal *internal;
-
-	if (!liveupdate_enabled())
-		return -EOPNOTSUPP;
-
-	internal = kzalloc(sizeof(*internal), GFP_KERNEL | __GFP_ZERO);
-	if (!internal)
-		return -ENOMEM;
-
-	mutex_init(&internal->incoming.lock);
-	mutex_init(&internal->outgoing.lock);
-
-	flb->internal = internal;
-	INIT_LIST_HEAD(&flb->list);
-
-	return 0;
-}
-
-/**
  * liveupdate_register_flb - Associate an FLB with a file handler and register it globally.
- * @h:   The file handler that will now depend on the FLB.
- * @flb: The File-Lifecycle-Bound object to associate.
+ * @fh:   The file handler that will now depend on the FLB.
+ * @flb:  The File-Lifecycle-Bound object to associate.
  *
  * Establishes a dependency, informing the LUO core that whenever a file of
- * type @h is preserved, the state of @flb must also be managed.
+ * type @fh is preserved, the state of @flb must also be managed.
  *
  * On the first registration of a given @flb object, it is added to a global
  * registry. This function checks for duplicate registrations, both for a
@@ -360,76 +316,207 @@ int liveupdate_init_flb(struct liveupdat
  *         -ENOSPC if the maximum number of global FLBs has been reached.
  *         -EOPNOTSUPP if live update is disabled or not configured.
  */
-int liveupdate_register_flb(struct liveupdate_file_handler *h,
+int liveupdate_register_flb(struct liveupdate_file_handler *fh,
 			    struct liveupdate_flb *flb)
 {
-	struct luo_flb_internal *internal = flb->internal;
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
 	struct luo_flb_link *link __free(kfree) = NULL;
-	static DEFINE_MUTEX(register_flb_lock);
 	struct liveupdate_flb *gflb;
 	struct luo_flb_link *iter;
+	int err;
 
 	if (!liveupdate_enabled())
 		return -EOPNOTSUPP;
 
-	if (WARN_ON(!h || !flb || !internal))
-		return -EINVAL;
-
 	if (WARN_ON(!flb->ops->preserve || !flb->ops->unpreserve ||
 		    !flb->ops->retrieve || !flb->ops->finish)) {
 		return -EINVAL;
 	}
 
 	/*
-	 * Once session/files have been deserialized, FLBs cannot be registered,
-	 * it is too late. Deserialization uses file handlers, and FLB registers
-	 * to file handlers.
-	 */
-	if (WARN_ON(luo_session_is_deserialized()))
-		return -EBUSY;
-
-	/*
-	 * File handler must already be registered, as it is initializes the
+	 * File handler must already be registered, as it initializes the
 	 * flb_list
 	 */
-	if (WARN_ON(list_empty(&h->list)))
+	if (WARN_ON(list_empty(&ACCESS_PRIVATE(fh, list))))
 		return -EINVAL;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
-	guard(mutex)(&register_flb_lock);
+	/*
+	 * Ensure the system is quiescent (no active sessions).
+	 * This acts as a global lock for registration: no other thread can
+	 * be in this section, and no sessions can be creating/using FDs.
+	 */
+	if (!luo_session_quiesce())
+		return -EBUSY;
 
 	/* Check that this FLB is not already linked to this file handler */
-	list_for_each_entry(iter, &h->flb_list, list) {
+	err = -EEXIST;
+	list_for_each_entry(iter, flb_list, list) {
 		if (iter->flb == flb)
-			return -EEXIST;
+			goto err_resume;
 	}
 
-	/* Is this FLB linked to global list ? */
-	if (list_empty(&flb->list)) {
-		if (luo_flb_global.count == LUO_FLB_MAX)
-			return -ENOSPC;
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
 
 		/* Check that compatible string is unique in global list */
-		list_for_each_entry(gflb, &luo_flb_global.list, list) {
+		luo_list_for_each_private(gflb, &luo_flb_global.list, private.list) {
 			if (!strcmp(gflb->compatible, flb->compatible))
-				return -EEXIST;
+				goto err_resume;
 		}
 
-		if (!try_module_get(flb->ops->owner))
-			return -EAGAIN;
+		if (!try_module_get(flb->ops->owner)) {
+			err = -EAGAIN;
+			goto err_resume;
+		}
 
-		list_add_tail(&flb->list, &luo_flb_global.list);
+		list_add_tail(&private->list, &luo_flb_global.list);
 		luo_flb_global.count++;
 	}
 
 	/* Finally, link the FLB to the file handler */
+	private->users++;
 	link->flb = flb;
-	list_add_tail(&no_free_ptr(link)->list, &h->flb_list);
+	list_add_tail(&no_free_ptr(link)->list, flb_list);
+	luo_session_resume();
 
 	return 0;
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
 }
 
 /**
@@ -453,41 +540,19 @@ int liveupdate_register_flb(struct liveu
  */
 int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp)
 {
-	struct luo_flb_internal *internal = flb->internal;
-
-	if (!liveupdate_enabled())
-		return -EOPNOTSUPP;
-
-	if (WARN_ON(!internal))
-		return -EINVAL;
-
-	if (!internal->incoming.obj) {
-		int err = luo_flb_retrieve_one(flb);
-
-		if (err)
-			return err;
-	}
-
-	mutex_lock(&internal->incoming.lock);
-	*objp = internal->incoming.obj;
-
-	return 0;
+	return luo_flb_locked(flb, true, objp);
 }
 
 /**
  * liveupdate_flb_incoming_unlock - Unlock an incoming FLB object.
  * @flb: The FLB definition.
- * @obj: The object that was returned by the _locked call (used for validation).
+ * @obj: The object that was returned by the _locked call
  *
  * Releases the internal lock acquired by liveupdate_flb_incoming_locked().
  */
 void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj)
 {
-	struct luo_flb_internal *internal = flb->internal;
-
-	lockdep_assert_held(&internal->incoming.lock);
-	internal->incoming.obj = obj;
-	mutex_unlock(&internal->incoming.lock);
+	luo_flb_unlock(flb, true, obj);
 }
 
 /**
@@ -508,41 +573,19 @@ void liveupdate_flb_incoming_unlock(stru
  */
 int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp)
 {
-	struct luo_flb_internal *internal = flb->internal;
-
-	if (!liveupdate_enabled())
-		return -EOPNOTSUPP;
-
-	if (WARN_ON(!internal))
-		return -EINVAL;
-
-	mutex_lock(&internal->outgoing.lock);
-
-	/* The object must exist if any file is being preserved */
-	if (WARN_ON_ONCE(!internal->outgoing.obj)) {
-		mutex_unlock(&internal->outgoing.lock);
-		return -ENOENT;
-	}
-
-	*objp = internal->outgoing.obj;
-
-	return 0;
+	return luo_flb_locked(flb, false, objp);
 }
 
 /**
  * liveupdate_flb_outgoing_unlock - Unlock an outgoing FLB object.
  * @flb: The FLB definition.
- * @obj: The object that was returned by the _locked call (used for validation).
+ * @obj: The object that was returned by the _locked call
  *
  * Releases the internal lock acquired by liveupdate_flb_outgoing_locked().
  */
 void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj)
 {
-	struct luo_flb_internal *internal = flb->internal;
-
-	lockdep_assert_held(&internal->outgoing.lock);
-	internal->outgoing.obj = obj;
-	mutex_unlock(&internal->outgoing.lock);
+	luo_flb_unlock(flb, false, obj);
 }
 
 int __init luo_flb_setup_outgoing(void *fdt_out)
@@ -639,17 +682,17 @@ int __init luo_flb_setup_incoming(void *
 void luo_flb_serialize(void)
 {
 	struct luo_flb_header *fh = &luo_flb_global.outgoing;
-	struct liveupdate_flb *flb;
+	struct liveupdate_flb *gflb;
 	int i = 0;
 
-	list_for_each_entry(flb, &luo_flb_global.list, list) {
-		struct luo_flb_internal *internal = flb->internal;
+	luo_list_for_each_private(gflb, &luo_flb_global.list, private.list) {
+		struct luo_flb_private *private = luo_flb_get_private(gflb);
 
-		if (internal->outgoing.count > 0) {
-			strscpy(fh->ser[i].name, flb->compatible,
+		if (private->outgoing.count > 0) {
+			strscpy(fh->ser[i].name, gflb->compatible,
 				sizeof(fh->ser[i].name));
-			fh->ser[i].data = internal->outgoing.data;
-			fh->ser[i].count = internal->outgoing.count;
+			fh->ser[i].data = private->outgoing.data;
+			fh->ser[i].count = private->outgoing.count;
 			i++;
 		}
 	}
--- a/kernel/liveupdate/luo_internal.h~b
+++ a/kernel/liveupdate/luo_internal.h
@@ -31,65 +31,111 @@ static inline int luo_ucmd_respond(struc
 	return 0;
 }
 
+/*
+ * Handles a deserialization failure: devices and memory is in unpredictable
+ * state.
+ *
+ * Continuing the boot process after a failure is dangerous because it could
+ * lead to leaks of private data.
+ */
+#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
+
+/* Mimics list_for_each_entry() but for private list head entries */
+#define luo_list_for_each_private(pos, head, member)				\
+	for (struct list_head *__iter = (head)->next;				\
+	     __iter != (head) &&						\
+	     ({ pos = container_of(__iter, typeof(*(pos)), member); 1; });	\
+	     __iter = __iter->next)
+
 /**
- * struct luo_session - Represents an active or incoming Live Update session.
- * @name:       A unique name for this session, used for identification and
- *              retrieval.
+ * struct luo_file_set - A set of files that belong to the same sessions.
  * @files_list: An ordered list of files associated with this session, it is
  *              ordered by preservation time.
- * @ser:        Pointer to the serialized data for this session.
+ * @files:      The physically contiguous memory block that holds the serialized
+ *              state of files.
  * @count:      A counter tracking the number of files currently stored in the
  *              @files_list for this session.
+ */
+struct luo_file_set {
+	struct list_head files_list;
+	struct luo_file_ser *files;
+	long count;
+};
+
+/**
+ * struct luo_session - Represents an active or incoming Live Update session.
+ * @name:       A unique name for this session, used for identification and
+ *              retrieval.
+ * @ser:        Pointer to the serialized data for this session.
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
  * @retrieved:  A boolean flag indicating whether this session has been
  *              retrieved by a consumer in the new kernel.
- * @mutex:      Session lock, protects files_list, and count.
- * @files:      The physically contiguous memory block that holds the serialized
- *              state of files.
- * @pgcnt:      The number of pages @files occupy.
+ * @file_set:   A set of files that belong to this session.
+ * @mutex:      protects fields in the luo_session.
  */
 struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct list_head files_list;
 	struct luo_session_ser *ser;
-	long count;
 	struct list_head list;
 	bool retrieved;
+	struct luo_file_set file_set;
 	struct mutex mutex;
-	struct luo_file_ser *files;
-	u64 pgcnt;
 };
 
+static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
+{
+	struct luo_session *session;
+
+	session = container_of(file_set, struct luo_session, file_set);
+
+	return (struct liveupdate_session *)session;
+}
+
+static inline struct luo_file_set *luo_file_set_from_session(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	return &session->file_set;
+}
+
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
 int __init luo_session_setup_outgoing(void *fdt);
 int __init luo_session_setup_incoming(void *fdt);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
-bool luo_session_is_deserialized(void);
+bool luo_session_quiesce(void);
+void luo_session_resume(void);
 
-int luo_preserve_file(struct luo_session *session, u64 token, int fd);
-void luo_file_unpreserve_files(struct luo_session *session);
-int luo_file_freeze(struct luo_session *session);
-void luo_file_unfreeze(struct luo_session *session);
-int luo_retrieve_file(struct luo_session *session, u64 token,
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+void luo_file_unpreserve_files(struct luo_file_set *file_set);
+int luo_file_freeze(struct luo_file_set *file_set,
+		    struct luo_file_set_ser *file_set_ser);
+void luo_file_unfreeze(struct luo_file_set *file_set,
+		       struct luo_file_set_ser *file_set_ser);
+int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
-int luo_file_finish(struct luo_session *session);
-int luo_file_deserialize(struct luo_session *session);
-
-int luo_flb_file_preserve(struct liveupdate_file_handler *h);
-void luo_flb_file_unpreserve(struct liveupdate_file_handler *h);
-void luo_flb_file_finish(struct liveupdate_file_handler *h);
+int luo_file_finish(struct luo_file_set *file_set);
+int luo_file_deserialize(struct luo_file_set *file_set,
+			 struct luo_file_set_ser *file_set_ser);
+void luo_file_set_init(struct luo_file_set *file_set);
+void luo_file_set_destroy(struct luo_file_set *file_set);
+
+int luo_flb_file_preserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
 void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
-void liveupdate_test_register(struct liveupdate_file_handler *h);
+void liveupdate_test_register(struct liveupdate_file_handler *fh);
+void liveupdate_test_unregister(struct liveupdate_file_handler *fh);
 #else
-static inline void liveupdate_test_register(struct liveupdate_file_handler *h) { }
+static inline void liveupdate_test_register(struct liveupdate_file_handler *fh) { }
+static inline void liveupdate_test_unregister(struct liveupdate_file_handler *fh) { }
 #endif
 
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_ioctl.c a/kernel/liveupdate/luo_ioctl.c
deleted file mode 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ /dev/null
@@ -1,223 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright (c) 2025, Google LLC.
- * Pasha Tatashin <pasha.tatashin@soleen.com>
- */
-
-/**
- * DOC: LUO ioctl Interface
- *
- * The IOCTL user-space control interface for the LUO subsystem.
- * It registers a character device, typically found at ``/dev/liveupdate``,
- * which allows a userspace agent to manage the LUO state machine and its
- * associated resources, such as preservable file descriptors.
- *
- * To ensure that the state machine is controlled by a single entity, access
- * to this device is exclusive: only one process is permitted to have
- * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
- * fail with -EBUSY until the first process closes its file descriptor.
- * This singleton model simplifies state management by preventing conflicting
- * commands from multiple userspace agents.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/atomic.h>
-#include <linux/errno.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/liveupdate.h>
-#include <linux/miscdevice.h>
-#include <uapi/linux/liveupdate.h>
-#include "luo_internal.h"
-
-struct luo_device_state {
-	struct miscdevice miscdev;
-	atomic_t in_use;
-};
-
-static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
-{
-	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
-	struct file *file;
-	int err;
-
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
-
-	err = luo_session_create(argp->name, &file);
-	if (err)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
-
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
-
-	return err;
-}
-
-static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
-{
-	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
-	struct file *file;
-	int err;
-
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
-
-	err = luo_session_retrieve(argp->name, &file);
-	if (err < 0)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
-
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
-
-	return err;
-}
-
-static int luo_open(struct inode *inodep, struct file *filep)
-{
-	struct luo_device_state *ldev = container_of(filep->private_data,
-						     struct luo_device_state,
-						     miscdev);
-
-	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
-		return -EBUSY;
-
-	luo_session_deserialize();
-
-	return 0;
-}
-
-static int luo_release(struct inode *inodep, struct file *filep)
-{
-	struct luo_device_state *ldev = container_of(filep->private_data,
-						     struct luo_device_state,
-						     miscdev);
-	atomic_set(&ldev->in_use, 0);
-
-	return 0;
-}
-
-union ucmd_buffer {
-	struct liveupdate_ioctl_create_session create;
-	struct liveupdate_ioctl_retrieve_session retrieve;
-};
-
-struct luo_ioctl_op {
-	unsigned int size;
-	unsigned int min_size;
-	unsigned int ioctl_num;
-	int (*execute)(struct luo_ucmd *ucmd);
-};
-
-#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
-	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_BASE] = {                            \
-		.size = sizeof(_struct) +                                      \
-			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
-					  sizeof(_struct)),                    \
-		.min_size = offsetofend(_struct, _last),                       \
-		.ioctl_num = _ioctl,                                           \
-		.execute = _fn,                                                \
-	}
-
-static const struct luo_ioctl_op luo_ioctl_ops[] = {
-	IOCTL_OP(LIVEUPDATE_IOCTL_CREATE_SESSION, luo_ioctl_create_session,
-		 struct liveupdate_ioctl_create_session, name),
-	IOCTL_OP(LIVEUPDATE_IOCTL_RETRIEVE_SESSION, luo_ioctl_retrieve_session,
-		 struct liveupdate_ioctl_retrieve_session, name),
-};
-
-static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
-{
-	const struct luo_ioctl_op *op;
-	struct luo_ucmd ucmd = {};
-	union ucmd_buffer buf;
-	unsigned int nr;
-	int err;
-
-	nr = _IOC_NR(cmd);
-	if (nr < LIVEUPDATE_CMD_BASE ||
-	    (nr - LIVEUPDATE_CMD_BASE) >= ARRAY_SIZE(luo_ioctl_ops)) {
-		return -EINVAL;
-	}
-
-	ucmd.ubuffer = (void __user *)arg;
-	err = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
-	if (err)
-		return err;
-
-	op = &luo_ioctl_ops[nr - LIVEUPDATE_CMD_BASE];
-	if (op->ioctl_num != cmd)
-		return -ENOIOCTLCMD;
-	if (ucmd.user_size < op->min_size)
-		return -EINVAL;
-
-	ucmd.cmd = &buf;
-	err = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
-				    ucmd.user_size);
-	if (err)
-		return err;
-
-	return op->execute(&ucmd);
-}
-
-static const struct file_operations luo_fops = {
-	.owner		= THIS_MODULE,
-	.open		= luo_open,
-	.release	= luo_release,
-	.unlocked_ioctl	= luo_ioctl,
-};
-
-static struct luo_device_state luo_dev = {
-	.miscdev = {
-		.minor = MISC_DYNAMIC_MINOR,
-		.name  = "liveupdate",
-		.fops  = &luo_fops,
-	},
-	.in_use = ATOMIC_INIT(0),
-};
-
-static int __init liveupdate_ioctl_init(void)
-{
-	if (!liveupdate_enabled())
-		return 0;
-
-	return misc_register(&luo_dev.miscdev);
-}
-module_init(liveupdate_ioctl_init);
-
-static void __exit liveupdate_exit(void)
-{
-	misc_deregister(&luo_dev.miscdev);
-}
-module_exit(liveupdate_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Pasha Tatashin");
-MODULE_DESCRIPTION("Live Update Orchestrator");
-MODULE_VERSION("0.1");
--- a/kernel/liveupdate/luo_session.c~b
+++ a/kernel/liveupdate/luo_session.c
@@ -58,17 +58,18 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
-#include <linux/liveupdate/abi/luo.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
-/* 16 4K pages, give space for 819 sessions */
+/* 16 4K pages, give space for 744 sessions */
 #define LUO_SESSION_PGCNT	16ul
 #define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
 		sizeof(struct luo_session_header_ser)) /		\
@@ -99,16 +100,22 @@ struct luo_session_header {
  * struct luo_session_global - Global container for managing LUO sessions.
  * @incoming:     The sessions passed from the previous kernel.
  * @outgoing:     The sessions that are going to be passed to the next kernel.
- * @deserialized: The sessions have been deserialized once /dev/liveupdate
- *                has been opened.
  */
 struct luo_session_global {
 	struct luo_session_header incoming;
 	struct luo_session_header outgoing;
-	bool deserialized;
 };
 
-static struct luo_session_global luo_session_global;
+static struct luo_session_global luo_session_global = {
+	.incoming = {
+		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
+		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+	},
+	.outgoing = {
+		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
+		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+	},
+};
 
 static struct luo_session *luo_session_alloc(const char *name)
 {
@@ -118,18 +125,17 @@ static struct luo_session *luo_session_a
 		return ERR_PTR(-ENOMEM);
 
 	strscpy(session->name, name, sizeof(session->name));
-	INIT_LIST_HEAD(&session->files_list);
+	INIT_LIST_HEAD(&session->file_set.files_list);
+	luo_file_set_init(&session->file_set);
 	INIT_LIST_HEAD(&session->list);
 	mutex_init(&session->mutex);
-	session->count = 0;
 
 	return session;
 }
 
 static void luo_session_free(struct luo_session *session)
 {
-	WARN_ON(session->count);
-	WARN_ON(!list_empty(&session->files_list));
+	luo_file_set_destroy(&session->file_set);
 	mutex_destroy(&session->mutex);
 	kfree(session);
 }
@@ -177,50 +183,48 @@ static void luo_session_remove(struct lu
 static int luo_session_finish_one(struct luo_session *session)
 {
 	guard(mutex)(&session->mutex);
-	return luo_file_finish(session);
+	return luo_file_finish(&session->file_set);
 }
 
-static void luo_session_unfreeze_one(struct luo_session *session)
+static void luo_session_unfreeze_one(struct luo_session *session,
+				     struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(session);
+	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
 }
 
-static int luo_session_freeze_one(struct luo_session *session)
+static int luo_session_freeze_one(struct luo_session *session,
+				  struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	return luo_file_freeze(session);
+	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
 {
 	struct luo_session *session = filep->private_data;
 	struct luo_session_header *sh;
-	int err = 0;
 
 	/* If retrieved is set, it means this session is from incoming list */
 	if (session->retrieved) {
-		sh = &luo_session_global.incoming;
+		int err = luo_session_finish_one(session);
 
-		err = luo_session_finish_one(session);
 		if (err) {
 			pr_warn("Unable to finish session [%s] on release\n",
 				session->name);
-		} else {
-			luo_session_remove(sh, session);
-			luo_session_free(session);
+			return err;
 		}
-
+		sh = &luo_session_global.incoming;
 	} else {
-		sh = &luo_session_global.outgoing;
-
 		scoped_guard(mutex, &session->mutex)
-			luo_file_unpreserve_files(session);
-		luo_session_remove(sh, session);
-		luo_session_free(session);
+			luo_file_unpreserve_files(&session->file_set);
+		sh = &luo_session_global.outgoing;
 	}
 
-	return err;
+	luo_session_remove(sh, session);
+	luo_session_free(session);
+
+	return 0;
 }
 
 static int luo_session_preserve_fd(struct luo_session *session,
@@ -230,7 +234,7 @@ static int luo_session_preserve_fd(struc
 	int err;
 
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(session, argp->token, argp->fd);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
 
@@ -253,7 +257,7 @@ static int luo_session_retrieve_fd(struc
 		return argp->fd;
 
 	guard(mutex)(&session->mutex);
-	err = luo_retrieve_file(session, argp->token, &file);
+	err = luo_retrieve_file(&session->file_set, argp->token, &file);
 	if (err < 0)
 		goto  err_put_fd;
 
@@ -365,7 +369,7 @@ static int luo_session_getfile(struct lu
 	char name_buf[128];
 	struct file *file;
 
-	guard(mutex)(&session->mutex);
+	lockdep_assert_held(&session->mutex);
 	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
 	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
 	if (IS_ERR(file))
@@ -389,7 +393,8 @@ int luo_session_create(const char *name,
 	if (err)
 		goto err_free;
 
-	err = luo_session_getfile(session, filep);
+	scoped_guard(mutex, &session->mutex)
+		err = luo_session_getfile(session, filep);
 	if (err)
 		goto err_remove;
 
@@ -422,16 +427,13 @@ int luo_session_retrieve(const char *nam
 	if (!session)
 		return -ENOENT;
 
-	scoped_guard(mutex, &session->mutex) {
-		if (session->retrieved)
-			return -EINVAL;
-	}
+	guard(mutex)(&session->mutex);
+	if (session->retrieved)
+		return -EINVAL;
 
 	err = luo_session_getfile(session, filep);
-	if (!err) {
-		scoped_guard(mutex, &session->mutex)
-			session->retrieved = true;
-	}
+	if (!err)
+		session->retrieved = true;
 
 	return err;
 }
@@ -439,12 +441,14 @@ int luo_session_retrieve(const char *nam
 int __init luo_session_setup_outgoing(void *fdt_out)
 {
 	struct luo_session_header_ser *header_ser;
+	void *outgoing_buffer;
 	u64 header_ser_pa;
 	int err;
 
-	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
+	outgoing_buffer = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(outgoing_buffer))
 		return PTR_ERR(header_ser);
+	header_ser = outgoing_buffer;
 	header_ser_pa = virt_to_phys(header_ser);
 
 	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
@@ -457,9 +461,6 @@ int __init luo_session_setup_outgoing(vo
 	if (err)
 		goto err_unpreserve;
 
-	header_ser->pgcnt = LUO_SESSION_PGCNT;
-	INIT_LIST_HEAD(&luo_session_global.outgoing.list);
-	init_rwsem(&luo_session_global.outgoing.rwsem);
 	luo_session_global.outgoing.header_ser = header_ser;
 	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
 	luo_session_global.outgoing.active = true;
@@ -506,33 +507,40 @@ int __init luo_session_setup_incoming(vo
 
 	luo_session_global.incoming.header_ser = header_ser;
 	luo_session_global.incoming.ser = (void *)(header_ser + 1);
-	INIT_LIST_HEAD(&luo_session_global.incoming.list);
-	init_rwsem(&luo_session_global.incoming.rwsem);
 	luo_session_global.incoming.active = true;
 
 	return 0;
 }
 
-bool luo_session_is_deserialized(void)
-{
-	return luo_session_global.deserialized;
-}
-
 int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
-	int err;
+	static bool is_deserialized;
+	static int err;
 
-	if (luo_session_is_deserialized())
-		return 0;
+	/* If has been deserialized, always return the same error code */
+	if (is_deserialized)
+		return err;
 
-	luo_session_global.deserialized = true;
-	if (!sh->active) {
-		INIT_LIST_HEAD(&sh->list);
-		init_rwsem(&sh->rwsem);
+	is_deserialized = true;
+	if (!sh->active)
 		return 0;
-	}
 
+	/*
+	 * Note on error handling:
+	 *
+	 * If deserialization fails (e.g., allocation failure or corrupt data),
+	 * we intentionally skip cleanup of sessions that were already restored.
+	 *
+	 * A partial failure leaves the preserved state inconsistent.
+	 * Implementing a safe "undo" to unwind complex dependencies (sessions,
+	 * files, hardware state) is error-prone and provides little value, as
+	 * the system is effectively in a broken state.
+	 *
+	 * We treat these resources as leaked. The expected recovery path is for
+	 * userspace to detect the failure and trigger a reboot, which will
+	 * reliably reset devices and reclaim memory.
+	 */
 	for (int i = 0; i < sh->header_ser->count; i++) {
 		struct luo_session *session;
 
@@ -551,11 +559,10 @@ int luo_session_deserialize(void)
 			return err;
 		}
 
-		session->count = sh->ser[i].count;
-		session->files = sh->ser[i].files ? phys_to_virt(sh->ser[i].files) : 0;
-		session->pgcnt = sh->ser[i].pgcnt;
-		scoped_guard(mutex, &session->mutex)
-			luo_file_deserialize(session);
+		scoped_guard(mutex, &session->mutex) {
+			luo_file_deserialize(&session->file_set,
+					     &sh->ser[i].file_set_ser);
+		}
 	}
 
 	kho_restore_free(sh->header_ser);
@@ -574,15 +581,12 @@ int luo_session_serialize(void)
 
 	guard(rwsem_write)(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
-		err = luo_session_freeze_one(session);
+		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
 			goto err_undo;
 
 		strscpy(sh->ser[i].name, session->name,
 			sizeof(sh->ser[i].name));
-		sh->ser[i].count = session->count;
-		sh->ser[i].files = session->files ? virt_to_phys(session->files) : 0;
-		sh->ser[i].pgcnt = session->pgcnt;
 		i++;
 	}
 	sh->header_ser->count = sh->count;
@@ -591,10 +595,51 @@ int luo_session_serialize(void)
 
 err_undo:
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		luo_session_unfreeze_one(session);
 		i--;
-		memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
+		luo_session_unfreeze_one(session, &sh->ser[i]);
+		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
 
 	return err;
 }
+
+/**
+ * luo_session_quiesce - Ensure no active sessions exist and lock session lists.
+ *
+ * Acquires exclusive write locks on both incoming and outgoing session lists.
+ * It then validates no sessions exist in either list.
+ *
+ * This mechanism is used during file handler un/registration to ensure that no
+ * sessions are currently using the handler, and no new sessions can be created
+ * while un/registration is in progress.
+ *
+ * Return:
+ * true  - System is quiescent (0 sessions) and locked.
+ * false - Active sessions exist. The locks are released internally.
+ */
+bool luo_session_quiesce(void)
+{
+	down_write(&luo_session_global.incoming.rwsem);
+	down_write(&luo_session_global.outgoing.rwsem);
+
+	if (luo_session_global.incoming.count ||
+	    luo_session_global.outgoing.count) {
+		up_write(&luo_session_global.outgoing.rwsem);
+		up_write(&luo_session_global.incoming.rwsem);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * luo_session_resume - Unlock session lists and resume normal activity.
+ *
+ * Releases the exclusive locks acquired by a successful call to
+ * luo_session_quiesce().
+ */
+void luo_session_resume(void)
+{
+	up_write(&luo_session_global.outgoing.rwsem);
+	up_write(&luo_session_global.incoming.rwsem);
+}
--- a/kernel/liveupdate/Makefile~b
+++ a/kernel/liveupdate/Makefile
@@ -4,7 +4,6 @@ luo-y :=								\
 		luo_core.o						\
 		luo_file.o						\
 		luo_flb.o						\
-		luo_ioctl.o						\
 		luo_session.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
--- a/lib/tests/liveupdate.c~b
+++ a/lib/tests/liveupdate.c
@@ -100,8 +100,6 @@ static void liveupdate_test_init(void)
 		void *obj;
 		int err;
 
-		liveupdate_init_flb(flb);
-
 		err = liveupdate_flb_incoming_locked(flb, &obj);
 		if (!err) {
 			liveupdate_flb_incoming_unlock(flb, obj);
@@ -113,7 +111,7 @@ static void liveupdate_test_init(void)
 	initialized = true;
 }
 
-void liveupdate_test_register(struct liveupdate_file_handler *h)
+void liveupdate_test_register(struct liveupdate_file_handler *fh)
 {
 	int err, i;
 
@@ -122,20 +120,39 @@ void liveupdate_test_register(struct liv
 	for (i = 0; i < TEST_NFLBS; i++) {
 		struct liveupdate_flb *flb = &test_flbs[i];
 
-		err = liveupdate_register_flb(h, flb);
-		if (err)
+		err = liveupdate_register_flb(fh, flb);
+		if (err) {
 			pr_err("Failed to register %s %pe\n",
 			       flb->compatible, ERR_PTR(err));
+		}
 	}
 
-	err = liveupdate_register_flb(h, &test_flbs[0]);
+	err = liveupdate_register_flb(fh, &test_flbs[0]);
 	if (!err || err != -EEXIST) {
 		pr_err("Failed: %s should be already registered, but got err: %pe\n",
 		       test_flbs[0].compatible, ERR_PTR(err));
 	}
 
 	pr_info("Registered %d FLBs with file handler: [%s]\n",
-		TEST_NFLBS, h->compatible);
+		TEST_NFLBS, fh->compatible);
+}
+
+void liveupdate_test_unregister(struct liveupdate_file_handler *fh)
+{
+	int err, i;
+
+	for (i = 0; i < TEST_NFLBS; i++) {
+		struct liveupdate_flb *flb = &test_flbs[i];
+
+		err = liveupdate_unregister_flb(fh, flb);
+		if (err) {
+			pr_err("Failed to unregister %s %pe\n",
+			       flb->compatible, ERR_PTR(err));
+		}
+	}
+
+	pr_info("Unregistered %d FLBs from file handler: [%s]\n",
+		TEST_NFLBS, fh->compatible);
 }
 
 MODULE_LICENSE("GPL");
--- a/MAINTAINERS~b
+++ a/MAINTAINERS
@@ -14472,6 +14472,7 @@ F:	tools/testing/selftests/livepatch/
 
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Mike Rapoport <rppt@kernel.org>
 R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
--- a/mm/memfd_luo.c~b
+++ a/mm/memfd_luo.c
@@ -74,33 +74,19 @@
 #include <linux/file.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
-#include <linux/libfdt.h>
+#include <linux/kho/abi/memfd.h>
 #include <linux/liveupdate.h>
-#include <linux/liveupdate/abi/memfd.h>
 #include <linux/shmem_fs.h>
 #include <linux/vmalloc.h>
 #include "internal.h"
 
-#define PRESERVED_PFN_MASK		GENMASK(63, 12)
-#define PRESERVED_PFN_SHIFT		12
-#define PRESERVED_FLAG_DIRTY		BIT(0)
-#define PRESERVED_FLAG_UPTODATE		BIT(1)
-
-#define PRESERVED_FOLIO_PFN(desc)	(((desc) & PRESERVED_PFN_MASK) >> PRESERVED_PFN_SHIFT)
-#define PRESERVED_FOLIO_FLAGS(desc)	((desc) & ~PRESERVED_PFN_MASK)
-#define PRESERVED_FOLIO_MKDESC(pfn, flags) (((pfn) << PRESERVED_PFN_SHIFT) | (flags))
-
-struct memfd_luo_private {
-	struct memfd_luo_folio_ser *pfolios;
-	u64 nr_folios;
-};
-
-static struct memfd_luo_folio_ser *memfd_luo_preserve_folios(struct file *file, void *fdt,
-							     u64 *nr_foliosp)
+static int memfd_luo_preserve_folios(struct file *file,
+				     struct kho_vmalloc *kho_vmalloc,
+				     struct memfd_luo_folio_ser **out_folios_ser,
+				     u64 *nr_foliosp)
 {
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *pfolios;
-	struct kho_vmalloc *kho_vmalloc;
+	struct memfd_luo_folio_ser *folios_ser;
 	unsigned int max_folios;
 	long i, size, nr_pinned;
 	struct folio **folios;
@@ -115,7 +101,9 @@ static struct memfd_luo_folio_ser *memfd
 	 */
 	if (!size) {
 		*nr_foliosp = 0;
-		return NULL;
+		*out_folios_ser = NULL;
+		memset(kho_vmalloc, 0, sizeof(*kho_vmalloc));
+		return 0;
 	}
 
 	/*
@@ -125,7 +113,7 @@ static struct memfd_luo_folio_ser *memfd
 	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
 	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);
 	if (!folios)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/*
 	 * Pin the folios so they don't move around behind our back. This also
@@ -148,294 +136,179 @@ static struct memfd_luo_folio_ser *memfd
 	}
 	nr_folios = nr_pinned;
 
-	err = fdt_property(fdt, MEMFD_FDT_NR_FOLIOS, &nr_folios, sizeof(nr_folios));
-	if (err)
-		goto err_unpin;
-
-	err = fdt_property_placeholder(fdt, MEMFD_FDT_FOLIOS, sizeof(*kho_vmalloc),
-				       (void **)&kho_vmalloc);
-	if (err) {
-		pr_err("Failed to reserve '%s' property in FDT: %s\n",
-		       MEMFD_FDT_FOLIOS, fdt_strerror(err));
-		err = -ENOMEM;
-		goto err_unpin;
-	}
-
-	pfolios = vcalloc(nr_folios, sizeof(*pfolios));
-	if (!pfolios) {
+	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
+	if (!folios_ser) {
 		err = -ENOMEM;
 		goto err_unpin;
 	}
 
 	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio = folios[i];
 		unsigned int flags = 0;
-		unsigned long pfn;
 
 		err = kho_preserve_folio(folio);
 		if (err)
 			goto err_unpreserve;
 
-		pfn = folio_pfn(folio);
 		if (folio_test_dirty(folio))
-			flags |= PRESERVED_FLAG_DIRTY;
+			flags |= MEMFD_LUO_FOLIO_DIRTY;
 		if (folio_test_uptodate(folio))
-			flags |= PRESERVED_FLAG_UPTODATE;
+			flags |= MEMFD_LUO_FOLIO_UPTODATE;
 
-		pfolio->foliodesc = PRESERVED_FOLIO_MKDESC(pfn, flags);
+		pfolio->pfn = folio_pfn(folio);
+		pfolio->flags = flags;
 		pfolio->index = folio->index;
 	}
 
-	err = kho_preserve_vmalloc(pfolios, kho_vmalloc);
+	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
 	if (err)
 		goto err_unpreserve;
 
 	kvfree(folios);
 	*nr_foliosp = nr_folios;
-	return pfolios;
+	*out_folios_ser = folios_ser;
+
+	/*
+	 * Note: folios_ser is purposely not freed here. It is preserved
+	 * memory (via KHO). In the 'unpreserve' path, we use the vmap pointer
+	 * that is passed via private_data.
+	 */
+	return 0;
 
 err_unpreserve:
-	i--;
-	for (; i >= 0; i--)
+	for (i = i - 1; i >= 0; i--)
 		kho_unpreserve_folio(folios[i]);
-	vfree(pfolios);
+	vfree(folios_ser);
 err_unpin:
 	unpin_folios(folios, nr_folios);
 err_free_folios:
 	kvfree(folios);
-	return ERR_PTR(err);
+
+	return err;
 }
 
-static void memfd_luo_unpreserve_folios(void *fdt, struct memfd_luo_folio_ser *pfolios,
+static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
+					struct memfd_luo_folio_ser *folios_ser,
 					u64 nr_folios)
 {
-	struct kho_vmalloc *kho_vmalloc;
 	long i;
 
 	if (!nr_folios)
 		return;
 
-	kho_vmalloc = (struct kho_vmalloc *)fdt_getprop(fdt, 0, MEMFD_FDT_FOLIOS, NULL);
-	/* The FDT was created by this kernel so expect it to be sane. */
-	WARN_ON_ONCE(!kho_vmalloc);
 	kho_unpreserve_vmalloc(kho_vmalloc);
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio;
 
-		if (!pfolio->foliodesc)
+		if (!pfolio->pfn)
 			continue;
 
-		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		folio = pfn_folio(pfolio->pfn);
 
 		kho_unpreserve_folio(folio);
 		unpin_folio(folio);
 	}
 
-	vfree(pfolios);
-}
-
-static struct memfd_luo_folio_ser *memfd_luo_fdt_folios(const void *fdt, u64 *nr_folios)
-{
-	const struct kho_vmalloc *kho_vmalloc;
-	struct memfd_luo_folio_ser *pfolios;
-	const u64 *nr;
-	int len;
-
-	nr = fdt_getprop(fdt, 0, MEMFD_FDT_NR_FOLIOS, &len);
-	if (!nr || len != sizeof(*nr)) {
-		pr_err("invalid '%s' property\n", MEMFD_FDT_NR_FOLIOS);
-		return NULL;
-	}
-
-	kho_vmalloc = fdt_getprop(fdt, 0, MEMFD_FDT_FOLIOS, &len);
-	if (!kho_vmalloc || len != sizeof(*kho_vmalloc)) {
-		pr_err("invalid '%s' property\n", MEMFD_FDT_FOLIOS);
-		return NULL;
-	}
-
-	pfolios = kho_restore_vmalloc(kho_vmalloc);
-	if (!pfolios)
-		return NULL;
-
-	*nr_folios = *nr;
-	return pfolios;
-}
-
-static void *memfd_luo_create_fdt(void)
-{
-	struct folio *fdt_folio;
-	int err = 0;
-	void *fdt;
-
-	/*
-	 * The FDT only contains a couple of properties and a kho_vmalloc
-	 * object. One page should be enough for that.
-	 */
-	fdt_folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
-	if (!fdt_folio)
-		return NULL;
-
-	fdt = folio_address(fdt_folio);
-
-	err |= fdt_create(fdt, folio_size(fdt_folio));
-	err |= fdt_finish_reservemap(fdt);
-	err |= fdt_begin_node(fdt, "");
-	if (err)
-		goto free;
-
-	return fdt;
-
-free:
-	folio_put(fdt_folio);
-	return NULL;
-}
-
-static int memfd_luo_finish_fdt(void *fdt)
-{
-	int err;
-
-	err = fdt_end_node(fdt);
-	if (err)
-		return err;
-
-	return fdt_finish(fdt);
+	vfree(folios_ser);
 }
 
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *pfolios;
-	struct memfd_luo_private *private;
-	u64 pos, nr_folios;
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
+	u64 nr_folios;
 	int err = 0;
-	void *fdt;
-	long size;
-
-	private = kmalloc(sizeof(*private), GFP_KERNEL);
-	if (!private)
-		return -ENOMEM;
 
 	inode_lock(inode);
-	shmem_i_mapping_freeze(inode, true);
+	shmem_freeze(inode, true);
 
-	size = i_size_read(inode);
-
-	fdt = memfd_luo_create_fdt();
-	if (!fdt) {
-		err = -ENOMEM;
+	/* Allocate the main serialization structure in preserved memory */
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser)) {
+		err = PTR_ERR(ser);
 		goto err_unlock;
 	}
 
-	pos = args->file->f_pos;
-	err = fdt_property(fdt, MEMFD_FDT_POS, &pos, sizeof(pos));
-	if (err)
-		goto err_free_fdt;
-
-	err = fdt_property(fdt, MEMFD_FDT_SIZE, &size, sizeof(size));
-	if (err)
-		goto err_free_fdt;
-
-	pfolios = memfd_luo_preserve_folios(args->file, fdt, &nr_folios);
-	if (IS_ERR(pfolios)) {
-		err = PTR_ERR(pfolios);
-		goto err_free_fdt;
-	}
-
-	err = memfd_luo_finish_fdt(fdt);
-	if (err)
-		goto err_unpreserve_folios;
+	ser->pos = args->file->f_pos;
+	ser->size = i_size_read(inode);
 
-	err = kho_preserve_folio(virt_to_folio(fdt));
+	err = memfd_luo_preserve_folios(args->file, &ser->folios,
+					&folios_ser, &nr_folios);
 	if (err)
-		goto err_unpreserve_folios;
+		goto err_free_ser;
 
+	ser->nr_folios = nr_folios;
 	inode_unlock(inode);
 
-	private->pfolios = pfolios;
-	private->nr_folios = nr_folios;
-	args->private_data = private;
-	args->serialized_data = virt_to_phys(fdt);
+	args->private_data = folios_ser;
+	args->serialized_data = virt_to_phys(ser);
+
 	return 0;
 
-err_unpreserve_folios:
-	memfd_luo_unpreserve_folios(fdt, pfolios, nr_folios);
-err_free_fdt:
-	folio_put(virt_to_folio(fdt));
+err_free_ser:
+	kho_unpreserve_free(ser);
 err_unlock:
-	shmem_i_mapping_freeze(inode, false);
+	shmem_freeze(inode, false);
 	inode_unlock(inode);
-	kfree(private);
 	return err;
 }
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
-	u64 pos = args->file->f_pos;
-	void *fdt;
-	int err;
+	struct memfd_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
-	fdt = phys_to_virt(args->serialized_data);
+	ser = phys_to_virt(args->serialized_data);
 
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
 	 * same.
 	 */
-	err = fdt_setprop(fdt, 0, "pos", &pos, sizeof(pos));
-	if (err)
-		return err;
+	ser->pos = args->file->f_pos;
 
 	return 0;
 }
 
 static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_private *private = args->private_data;
 	struct inode *inode = file_inode(args->file);
-	struct folio *fdt_folio;
-	void *fdt;
+	struct memfd_luo_ser *ser;
 
-	if (WARN_ON_ONCE(!args->serialized_data || !args->private_data))
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
 
 	inode_lock(inode);
-	shmem_i_mapping_freeze(inode, false);
+	shmem_freeze(inode, false);
 
-	fdt = phys_to_virt(args->serialized_data);
-	fdt_folio = virt_to_folio(fdt);
+	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(fdt, private->pfolios, private->nr_folios);
+	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
+				    ser->nr_folios);
 
-	kho_unpreserve_folio(fdt_folio);
-	folio_put(fdt_folio);
+	kho_unpreserve_free(ser);
 	inode_unlock(inode);
-	kfree(private);
-}
-
-static struct folio *memfd_luo_get_fdt(u64 data)
-{
-	return kho_restore_folio((phys_addr_t)data);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *pfolios,
-				     long nr_folios)
+static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+				     u64 nr_folios)
 {
-	unsigned int i;
+	u64 i;
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio;
 		phys_addr_t phys;
 
-		if (!pfolio->foliodesc)
+		if (!pfolio->pfn)
 			continue;
 
-		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		phys = PFN_PHYS(pfolio->pfn);
 		folio = kho_restore_folio(phys);
 		if (!folio) {
 			pr_warn_ratelimited("Unable to restore folio at physical address: %llx\n",
@@ -449,66 +322,49 @@ static void memfd_luo_discard_folios(con
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
-	const struct memfd_luo_folio_ser *pfolios;
-	struct folio *fdt_folio;
-	const void *fdt;
-	u64 nr_folios;
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
 
 	if (args->retrieved)
 		return;
 
-	fdt_folio = memfd_luo_get_fdt(args->serialized_data);
-	if (!fdt_folio) {
-		pr_err("failed to restore memfd FDT\n");
+	ser = phys_to_virt(args->serialized_data);
+	if (!ser)
 		return;
-	}
 
-	fdt = folio_address(fdt_folio);
+	if (ser->nr_folios) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (!folios_ser)
+			goto out;
 
-	pfolios = memfd_luo_fdt_folios(fdt, &nr_folios);
-	if (!pfolios)
-		goto out;
-
-	memfd_luo_discard_folios(pfolios, nr_folios);
-	vfree(pfolios);
+		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
+		vfree(folios_ser);
+	}
 
 out:
-	folio_put(fdt_folio);
+	kho_restore_free(ser);
 }
 
-static int memfd_luo_retrieve_folios(struct file *file, const void *fdt)
+static int memfd_luo_retrieve_folios(struct file *file,
+				     struct memfd_luo_folio_ser *folios_ser,
+				     u64 nr_folios)
 {
-	const struct memfd_luo_folio_ser *pfolios;
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping;
+	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
-	u64 nr_folios;
 	long i = 0;
 	int err;
 
-	/* Careful: folios don't exist in FDT on zero-size files. */
-	if (!inode->i_size)
-		return 0;
-
-	pfolios = memfd_luo_fdt_folios(fdt, &nr_folios);
-	if (!pfolios) {
-		pr_err("failed to fetch preserved folio list\n");
-		return -EINVAL;
-	}
-
-	inode = file->f_inode;
-	mapping = inode->i_mapping;
-
 	for (; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		phys_addr_t phys;
 		u64 index;
 		int flags;
 
-		if (!pfolio->foliodesc)
+		if (!pfolio->pfn)
 			continue;
 
-		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		phys = PFN_PHYS(pfolio->pfn);
 		folio = kho_restore_folio(phys);
 		if (!folio) {
 			pr_err("Unable to restore folio at physical address: %llx\n",
@@ -516,7 +372,7 @@ static int memfd_luo_retrieve_folios(str
 			goto put_folios;
 		}
 		index = pfolio->index;
-		flags = PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
+		flags = pfolio->flags;
 
 		/* Set up the folio for insertion. */
 		__folio_set_locked(folio);
@@ -537,9 +393,9 @@ static int memfd_luo_retrieve_folios(str
 			goto unlock_folio;
 		}
 
-		if (flags & PRESERVED_FLAG_UPTODATE)
+		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
 			folio_mark_uptodate(folio);
-		if (flags & PRESERVED_FLAG_DIRTY)
+		if (flags & MEMFD_LUO_FOLIO_DIRTY)
 			folio_mark_dirty(folio);
 
 		err = shmem_inode_acct_blocks(inode, 1);
@@ -555,7 +411,6 @@ static int memfd_luo_retrieve_folios(str
 		folio_put(folio);
 	}
 
-	vfree(pfolios);
 	return 0;
 
 unlock_folio:
@@ -568,69 +423,59 @@ put_folios:
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
 	for (; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 
-		folio = kho_restore_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		folio = kho_restore_folio(pfolio->pfn);
 		if (folio)
 			folio_put(folio);
 	}
 
-	vfree(pfolios);
 	return err;
 }
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct folio *fdt_folio;
-	const u64 *pos, *size;
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
 	struct file *file;
-	int len, ret = 0;
-	const void *fdt;
+	int err;
 
-	fdt_folio = memfd_luo_get_fdt(args->serialized_data);
-	if (!fdt_folio)
-		return -ENOENT;
-
-	fdt = page_to_virt(folio_page(fdt_folio, 0));
-
-	size = fdt_getprop(fdt, 0, "size", &len);
-	if (!size || len != sizeof(u64)) {
-		pr_err("invalid 'size' property\n");
-		ret = -EINVAL;
-		goto put_fdt;
-	}
-
-	pos = fdt_getprop(fdt, 0, "pos", &len);
-	if (!pos || len != sizeof(u64)) {
-		pr_err("invalid 'pos' property\n");
-		ret = -EINVAL;
-		goto put_fdt;
-	}
+	ser = phys_to_virt(args->serialized_data);
+	if (!ser)
+		return -EINVAL;
 
 	file = shmem_file_setup("", 0, VM_NORESERVE);
 
 	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		pr_err("failed to setup file: %d\n", ret);
-		goto put_fdt;
+		pr_err("failed to setup file: %pe\n", file);
+		return PTR_ERR(file);
 	}
 
-	vfs_setpos(file, *pos, MAX_LFS_FILESIZE);
-	file->f_inode->i_size = *size;
+	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
+	file->f_inode->i_size = ser->size;
 
-	ret = memfd_luo_retrieve_folios(file, fdt);
-	if (ret)
-		goto put_file;
+	if (ser->nr_folios) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (!folios_ser) {
+			err = -EINVAL;
+			goto put_file;
+		}
+
+		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
+		vfree(folios_ser);
+		if (err)
+			goto put_file;
+	}
 
 	args->file = file;
-	folio_put(fdt_folio);
+	kho_restore_free(ser);
+
 	return 0;
 
 put_file:
 	fput(file);
-put_fdt:
-	folio_put(fdt_folio);
-	return ret;
+
+	return err;
 }
 
 static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
@@ -661,7 +506,8 @@ static int __init memfd_luo_init(void)
 	int err = liveupdate_register_file_handler(&memfd_luo_handler);
 
 	if (err && err != -EOPNOTSUPP) {
-		pr_err("Could not register luo filesystem handler: %pe\n", ERR_PTR(err));
+		pr_err("Could not register luo filesystem handler: %pe\n",
+		       ERR_PTR(err));
 
 		return err;
 	}
--- a/mm/shmem.c~b
+++ a/mm/shmem.c
@@ -1310,10 +1310,13 @@ static int shmem_setattr(struct mnt_idma
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
-		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
-		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
-			return -EPERM;
+		if (newsize != oldsize) {
+			if (info->flags & SHMEM_F_MAPPING_FROZEN)
+				return -EPERM;
+			if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+			    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
+				return -EPERM;
+		}
 
 		if (newsize != oldsize) {
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
--- a/tools/testing/selftests/liveupdate/config~b
+++ a/tools/testing/selftests/liveupdate/config
@@ -1,5 +1,11 @@
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_KEXEC_FILE=y
 CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
 CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_KEXEC_HANDOVER_DEBUG=y
 CONFIG_LIVEUPDATE=y
+CONFIG_LIVEUPDATE_TEST=y
+CONFIG_MEMFD_CREATE=y
+CONFIG_TMPFS=y
+CONFIG_SHMEM=y
--- a/tools/testing/selftests/liveupdate/.gitignore~b
+++ a/tools/testing/selftests/liveupdate/.gitignore
@@ -1,3 +1,9 @@
-/liveupdate
-/luo_kexec_simple
-/luo_multi_session
+# SPDX-License-Identifier: GPL-2.0-only
+*
+!/**/
+!*.c
+!*.h
+!*.sh
+!.gitignore
+!config
+!Makefile
diff --git a/tools/testing/selftests/liveupdate/init.c a/tools/testing/selftests/liveupdate/init.c
new file mode 100644
--- /dev/null
+++ a/tools/testing/selftests/liveupdate/init.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <fcntl.h>
+#include <linux/kexec.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/reboot.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define COMMAND_LINE_SIZE 2048
+#define KERNEL_IMAGE "/kernel"
+#define INITRD_IMAGE "/initrd.img"
+#define TEST_BINARY "/test_binary"
+
+static int mount_filesystems(void)
+{
+	if (mount("devtmpfs", "/dev", "devtmpfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Warning: Failed to mount devtmpfs\n");
+		return -1;
+	}
+
+	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount debugfs\n");
+		return -1;
+	}
+
+	if (mount("proc", "/proc", "proc", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount proc\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static long kexec_file_load(int kernel_fd, int initrd_fd,
+			    unsigned long cmdline_len, const char *cmdline,
+			    unsigned long flags)
+{
+	return syscall(__NR_kexec_file_load, kernel_fd, initrd_fd, cmdline_len,
+		       cmdline, flags);
+}
+
+static int kexec_load(void)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+	int kernel_fd, initrd_fd, err;
+	ssize_t len;
+	int fd;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "INIT: Failed to read /proc/cmdline\n");
+
+		return -1;
+	}
+
+	len = read(fd, cmdline, sizeof(cmdline) - 1);
+	close(fd);
+	if (len < 0)
+		return -1;
+
+	cmdline[len] = 0;
+	if (len > 0 && cmdline[len - 1] == '\n')
+		cmdline[len - 1] = 0;
+
+	strncat(cmdline, " luo_stage=2", sizeof(cmdline) - strlen(cmdline) - 1);
+
+	kernel_fd = open(KERNEL_IMAGE, O_RDONLY);
+	if (kernel_fd < 0) {
+		fprintf(stderr, "INIT: Failed to open kernel image\n");
+		return -1;
+	}
+
+	initrd_fd = open(INITRD_IMAGE, O_RDONLY);
+	if (initrd_fd < 0) {
+		fprintf(stderr, "INIT: Failed to open initrd image\n");
+		close(kernel_fd);
+		return -1;
+	}
+
+	err = kexec_file_load(kernel_fd, initrd_fd, strlen(cmdline) + 1,
+			      cmdline, 0);
+
+	close(initrd_fd);
+	close(kernel_fd);
+
+	return err ? : 0;
+}
+
+static int run_test(int stage)
+{
+	char stage_arg[32];
+	int status;
+	pid_t pid;
+
+	snprintf(stage_arg, sizeof(stage_arg), "--stage=%d", stage);
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		static const char *const argv[] = {TEST_BINARY, stage_arg, NULL};
+
+		execve(TEST_BINARY, argv, NULL);
+		fprintf(stderr, "INIT: execve failed\n");
+		_exit(1);
+	}
+
+	waitpid(pid, &status, 0);
+
+	return (WIFEXITED(status) && WEXITSTATUS(status) == 0) ? 0 : -1;
+}
+
+static int is_stage_2(void)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+	ssize_t len;
+	int fd;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, cmdline, sizeof(cmdline) - 1);
+	close(fd);
+
+	if (len < 0)
+		return 0;
+
+	cmdline[len] = 0;
+
+	return !!strstr(cmdline, "luo_stage=2");
+}
+
+int main(int argc, char *argv[])
+{
+	int current_stage;
+
+	if (mount_filesystems())
+		goto err_reboot;
+
+	current_stage = is_stage_2() ? 2 : 1;
+
+	printf("INIT: Starting Stage %d\n", current_stage);
+
+	if (current_stage == 1 && kexec_load()) {
+		fprintf(stderr, "INIT: Failed to load kexec kernel\n");
+		goto err_reboot;
+	}
+
+	if (run_test(current_stage)) {
+		fprintf(stderr, "INIT: Test binary returned failure\n");
+		goto err_reboot;
+	}
+
+	printf("INIT: Stage %d completed successfully.\n", current_stage);
+	reboot(current_stage == 1 ? RB_KEXEC : RB_AUTOBOOT);
+
+	return 0;
+
+err_reboot:
+	reboot(RB_AUTOBOOT);
+
+	return -1;
+}
--- a/tools/testing/selftests/liveupdate/luo_kexec_simple.c~b
+++ a/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -10,8 +10,6 @@
 
 #include "luo_test_utils.h"
 
-/* Test-specific constants are now defined locally */
-#define KEXEC_SCRIPT "./do_kexec.sh"
 #define TEST_SESSION_NAME "test-session"
 #define TEST_MEMFD_TOKEN 0x1A
 #define TEST_MEMFD_DATA "hello kexec world"
@@ -42,10 +40,8 @@ static void run_stage_1(int luo_fd)
 			  TEST_MEMFD_TOKEN);
 	}
 
-	ksft_print_msg("[STAGE 1] Executing kexec...\n");
-	if (system(KEXEC_SCRIPT) != 0)
-		fail_exit("kexec script failed");
-	exit(EXIT_FAILURE);
+	close(luo_fd);
+	daemonize_and_wait();
 }
 
 /* Stage 2: Executed after the kexec reboot. */
@@ -88,27 +84,6 @@ static void run_stage_2(int luo_fd, int
 
 int main(int argc, char *argv[])
 {
-	int luo_fd;
-	int state_session_fd;
-
-	luo_fd = luo_open_device();
-	if (luo_fd < 0)
-		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
-			       LUO_DEVICE);
-
-	/*
-	 * Determine the stage by attempting to retrieve the state session.
-	 * If it doesn't exist (ENOENT), we are in Stage 1 (pre-kexec).
-	 */
-	state_session_fd = luo_retrieve_session(luo_fd, STATE_SESSION_NAME);
-	if (state_session_fd == -ENOENT) {
-		run_stage_1(luo_fd);
-	} else if (state_session_fd >= 0) {
-		/* We got a valid handle, pass it directly to stage 2 */
-		run_stage_2(luo_fd, state_session_fd);
-	} else {
-		fail_exit("Failed to check for state session");
-	}
-
-	close(luo_fd);
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
 }
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c~b
+++ a/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -11,8 +11,6 @@
 
 #include "luo_test_utils.h"
 
-#define KEXEC_SCRIPT "./do_kexec.sh"
-
 #define SESSION_EMPTY_1 "multi-test-empty-1"
 #define SESSION_EMPTY_2 "multi-test-empty-2"
 #define SESSION_FILES_1 "multi-test-files-1"
@@ -75,12 +73,8 @@ static void run_stage_1(int luo_fd)
 			  MFD3_TOKEN);
 	}
 
-	ksft_print_msg("[STAGE 1] Executing kexec...\n");
-
-	if (system(KEXEC_SCRIPT) != 0)
-		fail_exit("kexec script failed");
-
-	exit(EXIT_FAILURE);
+	close(luo_fd);
+	daemonize_and_wait();
 }
 
 /* Stage 2: Executed after the kexec reboot. */
@@ -163,28 +157,6 @@ static void run_stage_2(int luo_fd, int
 
 int main(int argc, char *argv[])
 {
-	int luo_fd;
-	int state_session_fd;
-
-	luo_fd = luo_open_device();
-	if (luo_fd < 0)
-		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
-			       LUO_DEVICE);
-
-	/*
-	 * Determine the stage by attempting to retrieve the state session.
-	 * If it doesn't exist (ENOENT), we are in Stage 1 (pre-kexec).
-	 */
-	state_session_fd = luo_retrieve_session(luo_fd, STATE_SESSION_NAME);
-	if (state_session_fd == -ENOENT) {
-		run_stage_1(luo_fd);
-	} else if (state_session_fd >= 0) {
-		/* We got a valid handle, pass it directly to stage 2 */
-		run_stage_2(luo_fd, state_session_fd);
-	} else {
-		fail_exit("Failed to check for state session");
-	}
-
-	close(luo_fd);
-	return 0;
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
 }
diff --git a/tools/testing/selftests/liveupdate/luo_test.sh a/tools/testing/selftests/liveupdate/luo_test.sh
new file mode 100755
--- /dev/null
+++ a/tools/testing/selftests/liveupdate/luo_test.sh
@@ -0,0 +1,296 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -ue
+
+CROSS_COMPILE="${CROSS_COMPILE:-""}"
+
+test_dir=$(realpath "$(dirname "$0")")
+kernel_dir=$(realpath "$test_dir/../../../..")
+
+workspace_dir=""
+headers_dir=""
+initrd=""
+KEEP_WORKSPACE=0
+
+source "$test_dir/../kselftest/ktap_helpers.sh"
+
+function get_arch_conf() {
+	local arch=$1
+	if [[ "$arch" == "arm64" ]]; then
+		QEMU_CMD="qemu-system-aarch64 -M virt -cpu max"
+		KERNEL_IMAGE="Image"
+		KERNEL_CMDLINE="console=ttyAMA0"
+	elif [[ "$arch" == "x86" ]]; then
+		QEMU_CMD="qemu-system-x86_64"
+		KERNEL_IMAGE="bzImage"
+		KERNEL_CMDLINE="console=ttyS0"
+	else
+		echo "Unsupported architecture: $arch"
+		exit 1
+	fi
+}
+
+function usage() {
+	cat <<EOF
+$0 [-d build_dir] [-j jobs] [-t target_arch] [-T test_name] [-w workspace_dir] [-k] [-h]
+Options:
+	-d)	path to the kernel build directory (default: .luo_test_build.<arch>)
+	-j)	number of jobs for compilation
+	-t)	run test for target_arch (aarch64, x86_64)
+	-T)	test name to run (default: luo_kexec_simple)
+	-w)	custom workspace directory (default: creates temp dir)
+	-k)	keep workspace directory after successful test
+	-h)	display this help
+EOF
+}
+
+function cleanup() {
+	local exit_code=$?
+
+	if [ -z "$workspace_dir" ]; then
+		ktap_finished
+		return
+	fi
+
+	if [ $exit_code -ne 0 ]; then
+		echo "# Test failed (exit code $exit_code)."
+		echo "# Workspace preserved at: $workspace_dir"
+	elif [ "$KEEP_WORKSPACE" -eq 1 ]; then
+		echo "# Workspace preserved (user request) at: $workspace_dir"
+	else
+		rm -fr "$workspace_dir"
+	fi
+	ktap_finished
+}
+trap cleanup EXIT
+
+function skip() {
+	local msg=${1:-""}
+	ktap_test_skip "$msg"
+	exit "$KSFT_SKIP"
+}
+
+function fail() {
+	local msg=${1:-""}
+	ktap_test_fail "$msg"
+	exit "$KSFT_FAIL"
+}
+
+function detect_cross_compile() {
+	local target=$1
+	local host=$(uname -m)
+
+	if [ -n "$CROSS_COMPILE" ]; then
+		return
+	fi
+
+	[[ "$host" == "arm64" ]] && host="aarch64"
+	[[ "$target" == "arm64" ]] && target="aarch64"
+
+	if [[ "$host" == "$target" ]]; then
+		CROSS_COMPILE=""
+		return
+	fi
+
+	local candidate=""
+	case "$target" in
+		aarch64) candidate="aarch64-linux-gnu-" ;;
+		x86_64)  candidate="x86_64-linux-gnu-" ;;
+		*)       skip "Auto-detection for target '$target' not supported. Please set CROSS_COMPILE manually." ;;
+	esac
+
+	if command -v "${candidate}gcc" &> /dev/null; then
+		CROSS_COMPILE="$candidate"
+	else
+		skip "Compiler '${candidate}gcc' not found. Please install it (e.g., 'apt install gcc-aarch64-linux-gnu') or set CROSS_COMPILE."
+	fi
+}
+
+function build_kernel() {
+	local build_dir=$1
+	local make_cmd=$2
+	local kimage=$3
+	local target_arch=$4
+
+	local kconfig="$build_dir/.config"
+	local common_conf="$test_dir/config"
+	local arch_conf="$test_dir/config.$target_arch"
+
+	echo "# Building kernel in: $build_dir"
+	$make_cmd defconfig
+
+	local fragments=""
+	if [[ -f "$common_conf" ]]; then
+		fragments="$fragments $common_conf"
+	fi
+
+	if [[ -f "$arch_conf" ]]; then
+		fragments="$fragments $arch_conf"
+	fi
+
+	if [[ -n "$fragments" ]]; then
+		"$kernel_dir/scripts/kconfig/merge_config.sh" \
+			-Q -m -O "$build_dir" "$kconfig" $fragments >> /dev/null
+	fi
+
+	$make_cmd olddefconfig
+	$make_cmd "$kimage"
+	$make_cmd headers_install INSTALL_HDR_PATH="$headers_dir"
+}
+
+function mkinitrd() {
+	local build_dir=$1
+	local kernel_path=$2
+	local test_name=$3
+
+	# 1. Compile the test binary and the init process
+	"$CROSS_COMPILE"gcc -static -O2 \
+		-I "$headers_dir/include" \
+		-I "$test_dir" \
+		-o "$workspace_dir/test_binary" \
+		"$test_dir/$test_name.c" "$test_dir/luo_test_utils.c"
+
+	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib		\
+			-fno-asynchronous-unwind-tables -fno-ident	\
+			-fno-stack-protector				\
+			-I "$headers_dir/include"			\
+			-I "$kernel_dir/tools/include/nolibc"		\
+			-o "$workspace_dir/init" "$test_dir/init.c"
+
+	cat > "$workspace_dir/cpio_list_inner" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $workspace_dir/init 0755 0 0
+file /test_binary $workspace_dir/test_binary 0755 0 0
+EOF
+
+	# Generate inner_initrd.cpio
+	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list_inner" > "$workspace_dir/inner_initrd.cpio"
+
+	cat > "$workspace_dir/cpio_list" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $workspace_dir/init 0755 0 0
+file /kernel $kernel_path 0644 0 0
+file /test_binary $workspace_dir/test_binary 0755 0 0
+file /initrd.img $workspace_dir/inner_initrd.cpio 0644 0 0
+EOF
+
+	# Generate the final initrd
+	"$build_dir/usr/gen_init_cpio" "$workspace_dir/cpio_list" > "$initrd"
+	local size=$(du -h "$initrd" | cut -f1)
+}
+
+function run_qemu() {
+	local qemu_cmd=$1
+	local cmdline=$2
+	local kernel_path=$3
+	local serial="$workspace_dir/qemu.serial"
+
+	local accel="-accel tcg"
+	local host_machine=$(uname -m)
+
+	[[ "$host_machine" == "arm64" ]] && host_machine="aarch64"
+	[[ "$host_machine" == "x86_64" ]] && host_machine="x86_64"
+
+	if [[ "$qemu_cmd" == *"$host_machine"* ]]; then
+		if [ -w /dev/kvm ]; then
+			accel="-accel kvm"
+		fi
+	fi
+
+	cmdline="$cmdline liveupdate=on panic=-1"
+
+	echo "# Serial Log: $serial"
+	timeout 30s $qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults	\
+		  $accel							\
+		  -serial file:"$serial"					\
+		  -append "$cmdline"						\
+		  -kernel "$kernel_path"					\
+		  -initrd "$initrd"
+
+	local ret=$?
+
+	if [ $ret -eq 124 ]; then
+		fail "QEMU timed out"
+	fi
+
+	grep "TEST PASSED" "$serial" &> /dev/null || fail "Liveupdate failed. Check $serial for details."
+}
+
+function target_to_arch() {
+	local target=$1
+	case $target in
+	     aarch64) echo "arm64" ;;
+	     x86_64) echo "x86" ;;
+	     *) skip "architecture $target is not supported"
+	esac
+}
+
+function main() {
+	local build_dir=""
+	local jobs=$(nproc)
+	local target="$(uname -m)"
+	local test_name="luo_kexec_simple"
+	local workspace_arg=""
+
+	set -o errtrace
+	trap skip ERR
+
+	while getopts 'hd:j:t:T:w:k' opt; do
+		case $opt in
+		d) build_dir="$OPTARG" ;;
+		j) jobs="$OPTARG" ;;
+		t) target="$OPTARG" ;;
+		T) test_name="$OPTARG" ;;
+		w) workspace_arg="$OPTARG" ;;
+		k) KEEP_WORKSPACE=1 ;;
+		h) usage; exit 0 ;;
+		*) echo "Unknown argument $opt"; usage; exit 1 ;;
+		esac
+	done
+
+	ktap_print_header
+	ktap_set_plan 1
+
+	if [ -n "$workspace_arg" ]; then
+		workspace_dir="$(realpath -m "$workspace_arg")"
+		mkdir -p "$workspace_dir"
+	else
+		workspace_dir=$(mktemp -d /tmp/luo-test.XXXXXXXX)
+	fi
+
+	echo "# Workspace created at: $workspace_dir"
+	headers_dir="$workspace_dir/usr"
+	initrd="$workspace_dir/initrd.cpio"
+
+	detect_cross_compile "$target"
+
+	local arch=$(target_to_arch "$target")
+
+	if [ -z "$build_dir" ]; then
+		build_dir="$kernel_dir/.luo_test_build.$arch"
+	fi
+
+	mkdir -p "$build_dir"
+	build_dir=$(realpath "$build_dir")
+	get_arch_conf "$arch"
+
+	local make_cmd="make -s ARCH=$arch CROSS_COMPILE=$CROSS_COMPILE -j$jobs"
+	local make_cmd_build="$make_cmd -C $kernel_dir O=$build_dir"
+
+	build_kernel "$build_dir" "$make_cmd_build" "$KERNEL_IMAGE" "$target"
+
+	local final_kernel="$build_dir/arch/$arch/boot/$KERNEL_IMAGE"
+	mkinitrd "$build_dir" "$final_kernel" "$test_name"
+
+	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$final_kernel"
+	ktap_test_pass "$test_name succeeded"
+}
+
+main "$@"
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c~b
+++ a/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -10,11 +10,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <getopt.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <errno.h>
 #include <stdarg.h>
 
@@ -166,3 +169,98 @@ void restore_and_read_stage(int state_se
 
 	close(mfd);
 }
+
+void daemonize_and_wait(void)
+{
+	pid_t pid;
+
+	ksft_print_msg("[STAGE 1] Forking persistent child to hold sessions...\n");
+
+	pid = fork();
+	if (pid < 0)
+		fail_exit("fork failed");
+
+	if (pid > 0) {
+		ksft_print_msg("[STAGE 1] Child PID: %d. Resources are pinned.\n", pid);
+		ksft_print_msg("[STAGE 1] You may now perform kexec reboot.\n");
+		exit(EXIT_SUCCESS);
+	}
+
+	/* Detach from terminal so closing the window doesn't kill us */
+	if (setsid() < 0)
+		fail_exit("setsid failed");
+
+	close(STDIN_FILENO);
+	close(STDOUT_FILENO);
+	close(STDERR_FILENO);
+
+	/* Change dir to root to avoid locking filesystems */
+	if (chdir("/") < 0)
+		exit(EXIT_FAILURE);
+
+	while (1)
+		sleep(60);
+}
+
+static int parse_stage_args(int argc, char *argv[])
+{
+	static struct option long_options[] = {
+		{"stage", required_argument, 0, 's'},
+		{0, 0, 0, 0}
+	};
+	int option_index = 0;
+	int stage = 1;
+	int opt;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "s:", long_options, &option_index)) != -1) {
+		switch (opt) {
+		case 's':
+			stage = atoi(optarg);
+			if (stage != 1 && stage != 2)
+				fail_exit("Invalid stage argument");
+			break;
+		default:
+			fail_exit("Unknown argument");
+		}
+	}
+	return stage;
+}
+
+int luo_test(int argc, char *argv[],
+	     const char *state_session_name,
+	     luo_test_stage1_fn stage1,
+	     luo_test_stage2_fn stage2)
+{
+	int target_stage = parse_stage_args(argc, argv);
+	int luo_fd = luo_open_device();
+	int state_session_fd;
+	int detected_stage;
+
+	if (luo_fd < 0) {
+		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
+			       LUO_DEVICE);
+	}
+
+	state_session_fd = luo_retrieve_session(luo_fd, state_session_name);
+	if (state_session_fd == -ENOENT)
+		detected_stage = 1;
+	else if (state_session_fd >= 0)
+		detected_stage = 2;
+	else
+		fail_exit("Failed to check for state session");
+
+	if (target_stage != detected_stage) {
+		ksft_exit_fail_msg("Stage mismatch Requested --stage %d, but system is in stage %d.\n"
+				   "(State session %s: %s)\n",
+				   target_stage, detected_stage, state_session_name,
+				   (detected_stage == 2) ? "EXISTS" : "MISSING");
+	}
+
+	if (target_stage == 1)
+		stage1(luo_fd);
+	else
+		stage2(luo_fd, state_session_fd);
+
+	return 0;
+}
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h~b
+++ a/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -21,19 +21,24 @@
 	ksft_exit_fail_msg("[%s:%d] " fmt " (errno: %s)\n",	\
 			   __func__, __LINE__, ##__VA_ARGS__, strerror(errno))
 
-/* Generic LUO and session management helpers */
 int luo_open_device(void);
 int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
-/* Generic file preservation and restoration helpers */
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
-/* Kexec state-tracking helpers */
 void create_state_file(int luo_fd, const char *session_name, int token,
 		       int next_stage);
 void restore_and_read_stage(int state_session_fd, int token, int *stage);
 
+void daemonize_and_wait(void);
+
+typedef void (*luo_test_stage1_fn)(int luo_fd);
+typedef void (*luo_test_stage2_fn)(int luo_fd, int state_session_fd);
+
+int luo_test(int argc, char *argv[], const char *state_session_name,
+	     luo_test_stage1_fn stage1, luo_test_stage2_fn stage2);
+
 #endif /* LUO_TEST_UTILS_H */
--- a/tools/testing/selftests/liveupdate/Makefile~b
+++ a/tools/testing/selftests/liveupdate/Makefile
@@ -1,40 +1,34 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-KHDR_INCLUDES ?= -I../../../../usr/include
-CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += $(KHDR_INCLUDES)
-LDFLAGS += -static
-OUTPUT ?= .
+LIB_C += luo_test_utils.c
 
-# --- Test Configuration (Edit this section when adding new tests) ---
-LUO_SHARED_SRCS := luo_test_utils.c
-LUO_SHARED_HDRS += luo_test_utils.h
+TEST_GEN_PROGS += liveupdate
 
-LUO_MANUAL_TESTS += luo_kexec_simple
-LUO_MANUAL_TESTS += luo_multi_session
+TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
+TEST_GEN_PROGS_EXTENDED += luo_multi_session
 
 TEST_FILES += do_kexec.sh
 
-TEST_GEN_PROGS += liveupdate
+include ../lib.mk
 
-# --- Automatic Rule Generation (Do not edit below) ---
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += -MD
 
-TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
+LIB_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIB_C))
+TEST_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TEST_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 
-# Define the full list of sources for each manual test.
-$(foreach test,$(LUO_MANUAL_TESTS), \
-	$(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
-
-# This loop automatically generates an explicit build rule for each manual test.
-# It includes dependencies on the shared headers and makes the output
-# executable.
-# Note the use of '$$' to escape automatic variables for the 'eval' command.
-$(foreach test,$(LUO_MANUAL_TESTS), \
-	$(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
-		$(call msg,LINK,,$$@) ; \
-		$(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
-		$(Q)chmod +x $$@ \
-	) \
-)
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIB_O))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(TEST_O))
+-include $(TEST_DEP_FILES)
 
-include ../lib.mk
+$(LIB_O): $(OUTPUT)/%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: %.o $(LIB_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIB_O) $(LDLIBS) -o $@
+
+EXTRA_CLEAN += $(LIB_O)
+EXTRA_CLEAN += $(TEST_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
diff --git a/tools/testing/selftests/liveupdate/run.sh a/tools/testing/selftests/liveupdate/run.sh
new file mode 100755
--- /dev/null
+++ a/tools/testing/selftests/liveupdate/run.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+OUTPUT_DIR="results_$(date +%Y%m%d_%H%M%S)"
+SCRIPT_DIR=$(dirname "$(realpath "$0")")
+TEST_RUNNER="$SCRIPT_DIR/luo_test.sh"
+
+TARGETS=("x86_64" "aarch64")
+
+GREEN='\033[0;32m'
+RED='\033[0;31m'
+YELLOW='\033[1;33m'
+NC='\033[0m'
+
+PASSED=()
+FAILED=()
+SKIPPED=()
+
+mkdir -p "$OUTPUT_DIR"
+
+TEST_NAMES=()
+while IFS= read -r file; do
+    TEST_NAMES+=("$(basename "$file" .c)")
+done < <(find "$SCRIPT_DIR" -maxdepth 1 -name "luo_*.c" ! -name "luo_test_utils.c")
+
+if [ ${#TEST_NAMES[@]} -eq 0 ]; then
+    echo "No tests found in $SCRIPT_DIR"
+    exit 1
+fi
+
+for arch in "${TARGETS[@]}"; do
+    for test_name in "${TEST_NAMES[@]}"; do
+        log_file="$OUTPUT_DIR/${arch}_${test_name}.log"
+        echo -n "  -> $arch $test_name ... "
+
+        if "$TEST_RUNNER" -t "$arch" -T "$test_name" > "$log_file" 2>&1; then
+            echo -e "${GREEN}PASS${NC}"
+            PASSED+=("${arch}:${test_name}")
+        else
+            exit_code=$?
+            if [ $exit_code -eq 4 ]; then
+                echo -e "${YELLOW}SKIP${NC}"
+                SKIPPED+=("${arch}:${test_name}")
+            else
+                echo -e "${RED}FAIL${NC}"
+                FAILED+=("${arch}:${test_name}")
+            fi
+        fi
+    done
+    echo ""
+done
+
+echo "========================================="
+echo "             TEST SUMMARY                "
+echo "========================================="
+echo -e "PASSED: ${GREEN}${#PASSED[@]}${NC}"
+echo -e "FAILED: ${RED}${#FAILED[@]}${NC}"
+for fail in "${FAILED[@]}"; do
+    echo -e "  - $fail"
+done
+echo -e "SKIPPED: ${YELLOW}${#SKIPPED[@]}${NC}"
+echo "Logs: $OUTPUT_DIR"
+
+if [ ${#FAILED[@]} -eq 0 ]; then
+    exit 0
+else
+    exit 1
+fi
_


