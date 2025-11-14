Return-Path: <linux-fsdevel+bounces-68486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA8C5D2E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF27B358D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962C23278D;
	Fri, 14 Nov 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVR2Lep5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD568634F;
	Fri, 14 Nov 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124606; cv=none; b=jbpOsj/Lj2PJefda9uoeU6Sdh5GS0v+i5HBA58VIfwphOZg8DtzVbhrv61HqZDmqnCQ4212w5PPw5KYEIFqi0R1W5QnJSJu6k1DYD2lEnY5YFbjp5U3UylaUzL45eAG1DHSf3ecdcsr1JXxPAR2X6owWzEMqZGWh/LjPRDEiOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124606; c=relaxed/simple;
	bh=blf06EBd4Il5EPBqGpATsHHBdXDhfZrS9r70MdnngYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmGDmeaaNy8kSwCVXe8CqayS3unl+JynEdMBxm2dGmkeRh88XYWZGhvQoJf3vX3srUhjQxjZsBV+G3x1dQtE+mnjGnqOzBVNL8OmKT5h1XiUQiyIZaQtALGNbFaTQfz/Ms1ugj6wryOx3Q/a/bS/N4b1ew1DTYXLL6nVO9kVrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVR2Lep5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6514C4CEF8;
	Fri, 14 Nov 2025 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763124605;
	bh=blf06EBd4Il5EPBqGpATsHHBdXDhfZrS9r70MdnngYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVR2Lep5cGk4WxkH1Ljs/nilJt5VaG/PTryiaK9YMylqpCXS9pHbfYd12P/vh52CL
	 ckomSAEuHYcnRgpaswursnIWwblM4GyKthx+qrZ48wguQjJJsZ049pM5phEfQ1kubb
	 eXthtToBZRwrXccI0pbMmqjYsnI0vdZatoulX2eirFIpfyy7VjRR8xPpVSVpACpCuu
	 qxUZOia++3VLXFGRNWyFody+f7v9ApYANj7FJ1KoLVnsYFVmsEK1vQ3DL0ONPm9YLu
	 vOoOnNbneZ3s1ZD08Ow8tAiYbTF64ylWlotxK7rbz+Y4E9Ufg3y1WzXpckYF0yaaaG
	 +83pl9yI/pgNA==
Date: Fri, 14 Nov 2025 14:49:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v5 06/22] liveupdate: luo_session: add sessions support
Message-ID: <aRclYgHYXQFJ2Fpn@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-7-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:04PM -0500, Pasha Tatashin wrote:
> Introduce concept of "Live Update Sessions" within the LUO framework.
> LUO sessions provide a mechanism to group and manage `struct file *`
> instances (representing file descriptors) that need to be preserved
> across a kexec-based live update.
> 
> Each session is identified by a unique name and acts as a container
> for file objects whose state is critical to a userspace workload, such
> as a virtual machine or a high-performance database, aiming to maintain
> their functionality across a kernel transition.
> 
> This groundwork establishes the framework for preserving file-backed
> state across kernel updates, with the actual file data preservation
> mechanisms to be implemented in subsequent patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate/abi/luo.h |  81 ++++++
>  include/uapi/linux/liveupdate.h    |   3 +
>  kernel/liveupdate/Makefile         |   3 +-
>  kernel/liveupdate/luo_core.c       |   9 +
>  kernel/liveupdate/luo_internal.h   |  39 +++
>  kernel/liveupdate/luo_session.c    | 405 +++++++++++++++++++++++++++++
>  6 files changed, 539 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_session.c
> 
> diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
> index 9483a294287f..37b9fecef3f7 100644
> --- a/include/linux/liveupdate/abi/luo.h
> +++ b/include/linux/liveupdate/abi/luo.h
> @@ -28,6 +28,11 @@
>   *     / {
>   *         compatible = "luo-v1";
>   *         liveupdate-number = <...>;
> + *
> + *         luo-session {
> + *             compatible = "luo-session-v1";
> + *             luo-session-head = <phys_addr_of_session_head_ser>;
> + *         };
>   *     };
>   *
>   * Main LUO Node (/):
> @@ -36,11 +41,37 @@
>   *     Identifies the overall LUO ABI version.
>   *   - liveupdate-number: u64
>   *     A counter tracking the number of successful live updates performed.
> + *
> + * Session Node (luo-session):
> + *   This node describes all preserved user-space sessions.
> + *
> + *   - compatible: "luo-session-v1"
> + *     Identifies the session ABI version.
> + *   - luo-session-head: u64
> + *     The physical address of a `struct luo_session_head_ser`. This structure is
> + *     the header for a contiguous block of memory containing an array of
> + *     `struct luo_session_ser`, one for each preserved session.
> + *
> + * Serialization Structures:
> + *   The FDT properties point to memory regions containing arrays of simple,
> + *   `__packed` structures. These structures contain the actual preserved state.
> + *
> + *   - struct luo_session_head_ser:
> + *     Header for the session array. Contains the total page count of the
> + *     preserved memory block and the number of `struct luo_session_ser`
> + *     entries that follow.
> + *
> + *   - struct luo_session_ser:
> + *     Metadata for a single session, including its name and a physical pointer
> + *     to another preserved memory block containing an array of
> + *     `struct luo_file_ser` for all files in that session.
>   */
>  
>  #ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
>  #define _LINUX_LIVEUPDATE_ABI_LUO_H
>  
> +#include <uapi/linux/liveupdate.h>
> +
>  /*
>   * The LUO FDT hooks all LUO state for sessions, fds, etc.
>   * In the root it allso carries "liveupdate-number" 64-bit property that
> @@ -51,4 +82,54 @@
>  #define LUO_FDT_COMPATIBLE	"luo-v1"
>  #define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
>  
> +/*
> + * LUO FDT session node
> + * LUO_FDT_SESSION_HEAD:  is a u64 physical address of struct
> + *                        luo_session_head_ser
> + */
> +#define LUO_FDT_SESSION_NODE_NAME	"luo-session"
> +#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v1"
> +#define LUO_FDT_SESSION_HEAD		"luo-session-head"
> +
> +/**
> + * struct luo_session_head_ser - Header for the serialized session data block.
> + * @pgcnt: The total size, in pages, of the entire preserved memory block
> + *         that this header describes.
> + * @count: The number of 'struct luo_session_ser' entries that immediately
> + *         follow this header in the memory block.
> + *
> + * This structure is located at the beginning of a contiguous block of
> + * physical memory preserved across the kexec. It provides the necessary
> + * metadata to interpret the array of session entries that follow.
> + */
> +struct luo_session_head_ser {
> +	u64 pgcnt;
> +	u64 count;
> +} __packed;
> +
> +/**
> + * struct luo_session_ser - Represents the serialized metadata for a LUO session.
> + * @name:    The unique name of the session, copied from the `luo_session`
> + *           structure.
> + * @files:   The physical address of a contiguous memory block that holds
> + *           the serialized state of files.
> + * @pgcnt:   The number of pages occupied by the `files` memory block.
> + * @count:   The total number of files that were part of this session during
> + *           serialization. Used for iteration and validation during
> + *           restoration.
> + *
> + * This structure is used to package session-specific metadata for transfer
> + * between kernels via Kexec Handover. An array of these structures (one per
> + * session) is created and passed to the new kernel, allowing it to reconstruct
> + * the session context.
> + *
> + * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
> + */
> +struct luo_session_ser {
> +	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +	u64 files;
> +	u64 pgcnt;
> +	u64 count;
> +} __packed;
> +
>  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index df34c1642c4d..d2ef2f7e0dbd 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -43,4 +43,7 @@
>  /* The ioctl type, documented in ioctl-number.rst */
>  #define LIVEUPDATE_IOCTL_TYPE		0xBA
>  
> +/* The maximum length of session name including null termination */
> +#define LIVEUPDATE_SESSION_NAME_LENGTH 56

Out of curiosity, why 56? :)

> +
>  #endif /* _UAPI_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index 413722002b7a..83285e7ad726 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -2,7 +2,8 @@
>  
>  luo-y :=								\
>  		luo_core.o						\
> -		luo_ioctl.o
> +		luo_ioctl.o						\
> +		luo_session.o
>  
>  obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index c1bd236bccb0..83257ab93ebb 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -116,6 +116,10 @@ static int __init luo_early_startup(void)
>  	pr_info("Retrieved live update data, liveupdate number: %lld\n",
>  		luo_global.liveupdate_num);
>  
> +	err = luo_session_setup_incoming(luo_global.fdt_in);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  }
>  
> @@ -149,6 +153,7 @@ static int __init luo_fdt_setup(void)
>  	err |= fdt_begin_node(fdt_out, "");
>  	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
>  	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
> +	err |= luo_session_setup_outgoing(fdt_out);
>  	err |= fdt_end_node(fdt_out);
>  	err |= fdt_finish(fdt_out);
>  	if (err)
> @@ -202,6 +207,10 @@ int liveupdate_reboot(void)
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> +	err = luo_session_serialize();
> +	if (err)
> +		return err;
> +
>  	err = kho_finalize();
>  	if (err) {
>  		pr_err("kho_finalize failed %d\n", err);
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 29f47a69be0b..b4f2d1443c76 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -14,4 +14,43 @@ void *luo_alloc_preserve(size_t size);
>  void luo_free_unpreserve(void *mem, size_t size);
>  void luo_free_restore(void *mem, size_t size);
>  
> +/**
> + * struct luo_session - Represents an active or incoming Live Update session.
> + * @name:       A unique name for this session, used for identification and
> + *              retrieval.
> + * @files_list: An ordered list of files associated with this session, it is
> + *              ordered by preservation time.
> + * @ser:        Pointer to the serialized data for this session.
> + * @count:      A counter tracking the number of files currently stored in the
> + *              @files_xa for this session.

		   ^@files_list

> + * @list:       A list_head member used to link this session into a global list
> + *              of either outgoing (to be preserved) or incoming (restored from
> + *              previous kernel) sessions.
> + * @retrieved:  A boolean flag indicating whether this session has been
> + *              retrieved by a consumer in the new kernel.
> + * @mutex:      Session lock, protects files_list, and count.
> + * @files:      The physically contiguous memory block that holds the serialized
> + *              state of files.
> + * @pgcnt:      The number of pages files occupy.

                                      ^ @files

> + */
> +struct luo_session {
> +	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +	struct list_head files_list;
> +	struct luo_session_ser *ser;
> +	long count;
> +	struct list_head list;
> +	bool retrieved;
> +	struct mutex mutex;
> +	struct luo_file_ser *files;
> +	u64 pgcnt;
> +};
> +
> +int luo_session_create(const char *name, struct file **filep);
> +int luo_session_retrieve(const char *name, struct file **filep);
> +int __init luo_session_setup_outgoing(void *fdt);
> +int __init luo_session_setup_incoming(void *fdt);
> +int luo_session_serialize(void);
> +int luo_session_deserialize(void);

The last four deal with all the sessions, maybe use plural in the function
names.

> +bool luo_session_is_deserialized(void);
> +
>  #endif /* _LINUX_LUO_INTERNAL_H */
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> new file mode 100644
> index 000000000000..a3513118aa74
> --- /dev/null
> +++ b/kernel/liveupdate/luo_session.c
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: LUO Sessions
> + *
> + * LUO Sessions provide the core mechanism for grouping and managing `struct
> + * file *` instances that need to be preserved across a kexec-based live
> + * update. Each session acts as a named container for a set of file objects,
> + * allowing a userspace agent to manage the lifecycle of resources critical to a
> + * workload.
> + *
> + * Core Concepts:
> + *
> + * - Named Containers: Sessions are identified by a unique, user-provided name,
> + *   which is used for both creation in the current kernel and retrieval in the
> + *   next kernel.
> + *
> + * - Userspace Interface: Session management is driven from userspace via
> + *   ioctls on /dev/liveupdate.
> + *
> + * - Serialization: Session metadata is preserved using the KHO framework. When
> + *   a live update is triggered via kexec, an array of `struct luo_session_ser`
> + *   is populated and placed in a preserved memory region. An FDT node is also
> + *   created, containing the count of sessions and the physical address of this
> + *   array.
> + *
> + * Session Lifecycle:
> + *
> + * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
> + *     new, empty session and receives a file descriptor for it.
> + *
> + * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
> + *     made, `luo_session_serialize()` is called. It iterates through all
> + *     active sessions and writes their metadata into a memory area preserved
> + *     by KHO.
> + *
> + * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
> + *     runs, reading the serialized data and creating a list of `struct
> + *     luo_session` objects representing the preserved sessions.
> + *
> + * 4.  Retrieval: A userspace agent in the new kernel can then call
> + *     `luo_session_retrieve()` with a session name to get a new file
> + *     descriptor and access the preserved state.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/libfdt.h>
> +#include <linux/liveupdate.h>
> +#include <linux/liveupdate/abi/luo.h>
> +#include <uapi/linux/liveupdate.h>
> +#include "luo_internal.h"
> +
> +/* 16 4K pages, give space for 819 sessions */
> +#define LUO_SESSION_PGCNT	16ul
> +#define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
> +		sizeof(struct luo_session_head_ser)) /			\
> +		sizeof(struct luo_session_ser))
> +
> +/**
> + * struct luo_session_head - Head struct for managing LUO sessions.

Head of what? ;-)
Maybe luo_session_list? Or even luo_sessions?

> + * @count:    The number of sessions currently tracked in the @list.
> + * @list:     The head of the linked list of `struct luo_session` instances.
> + * @rwsem:    A read-write semaphore providing synchronized access to the
> + *            session list and other fields in this structure.
> + * @head_ser: The head data of serialization array.

	            ^ header?

> + * @ser:      The serialized session data (an array of
> + *            `struct luo_session_ser`).
> + * @active:   Set to true when first initialized. If previous kernel did not
> + *            send session data, active stays false for incoming.
> + */
> +struct luo_session_head {
> +	long count;
> +	struct list_head list;
> +	struct rw_semaphore rwsem;
> +	struct luo_session_head_ser *head_ser;
> +	struct luo_session_ser *ser;
> +	bool active;
> +};
> +
> +/**
> + * struct luo_session_global - Global container for managing LUO sessions.
> + * @incoming:     The sessions passed from the previous kernel.
> + * @outgoing:     The sessions that are going to be passed to the next kernel.
> + * @deserialized: The sessions have been deserialized once /dev/liveupdate
> + *                has been opened.
> + */
> +struct luo_session_global {
> +	struct luo_session_head incoming;
> +	struct luo_session_head outgoing;
> +	bool deserialized;
> +} luo_session_global;

Should be static. And frankly, I don't think grouping two global variables
into a struct gains much.

static struct luo_sessions luo_sessions_incoming;
static struct luo_sessions luo_sessions_outgoing;

reads clearer to me.

> +
> +static struct luo_session *luo_session_alloc(const char *name)
> +{
> +	struct luo_session *session = kzalloc(sizeof(*session), GFP_KERNEL);
> +
> +	if (!session)
> +		return NULL;
> +
> +	strscpy(session->name, name, sizeof(session->name));
> +	INIT_LIST_HEAD(&session->files_list);
> +	session->count = 0;

I'd move this after mutex_init(), a bit more readable IMHO.

> +	INIT_LIST_HEAD(&session->list);
> +	mutex_init(&session->mutex);
> +
> +	return session;
> +}
> +
> +static void luo_session_free(struct luo_session *session)
> +{
> +	WARN_ON(session->count);
> +	WARN_ON(!list_empty(&session->files_list));
> +	mutex_destroy(&session->mutex);
> +	kfree(session);
> +}
> +
> +static int luo_session_insert(struct luo_session_head *sh,
> +			      struct luo_session *session)
> +{
> +	struct luo_session *it;
> +
> +	guard(rwsem_write)(&sh->rwsem);
> +
> +	/*
> +	 * For outgoing we should make sure there is room in serialization array
> +	 * for new session.
> +	 */
> +	if (sh == &luo_session_global.outgoing) {
> +		if (sh->count == LUO_SESSION_MAX)
> +			return -ENOMEM;
> +	}

Not a big deal, but this could be outside the guard().

> +
> +	/*
> +	 * For small number of sessions this loop won't hurt performance
> +	 * but if we ever start using a lot of sessions, this might
> +	 * become a bottle neck during deserialization time, as it would
> +	 * cause O(n*n) complexity.
> +	 */

The loop is always O(n*n) in the worst case, no matter how many sessions
there are ;-)

> +	list_for_each_entry(it, &sh->list, list) {
> +		if (!strncmp(it->name, session->name, sizeof(it->name)))
> +			return -EEXIST;
> +	}
> +	list_add_tail(&session->list, &sh->list);
> +	sh->count++;
> +
> +	return 0;
> +}
> +
> +static void luo_session_remove(struct luo_session_head *sh,
> +			       struct luo_session *session)
> +{
> +	guard(rwsem_write)(&sh->rwsem);
> +	list_del(&session->list);
> +	sh->count--;
> +}
> +
> +static int luo_session_release(struct inode *inodep, struct file *filep)
> +{
> +	struct luo_session *session = filep->private_data;
> +	struct luo_session_head *sh;
> +
> +	/* If retrieved is set, it means this session is from incoming list */
> +	if (session->retrieved)
> +		sh = &luo_session_global.incoming;
> +	else
> +		sh = &luo_session_global.outgoing;

Maybe just add a backpointer to the list to struct luo_session?

> +
> +	luo_session_remove(sh, session);
> +	luo_session_free(session);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations luo_session_fops = {
> +	.owner = THIS_MODULE,
> +	.release = luo_session_release,
> +};
> +
> +/* Create a "struct file" for session */
> +static int luo_session_getfile(struct luo_session *session, struct file **filep)
> +{
> +	char name_buf[128];
> +	struct file *file;
> +
> +	guard(mutex)(&session->mutex);
> +	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> +	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	*filep = file;
> +
> +	return 0;
> +}
> +
> +int luo_session_create(const char *name, struct file **filep)
> +{
> +	struct luo_session *session;
> +	int err;
> +
> +	session = luo_session_alloc(name);
> +	if (!session)
> +		return -ENOMEM;
> +
> +	err = luo_session_insert(&luo_session_global.outgoing, session);
> +	if (err) {
> +		luo_session_free(session);
> +		return err;

Please goto err_free

> +	}
> +
> +	err = luo_session_getfile(session, filep);
> +	if (err) {
> +		luo_session_remove(&luo_session_global.outgoing, session);
> +		luo_session_free(session);

and goto err_remove

> +	}
> +
> +	return err;
> +}
> +
> +int luo_session_retrieve(const char *name, struct file **filep)
> +{
> +	struct luo_session_head *sh = &luo_session_global.incoming;
> +	struct luo_session *session = NULL;
> +	struct luo_session *it;
> +	int err;
> +
> +	scoped_guard(rwsem_read, &sh->rwsem) {
> +		list_for_each_entry(it, &sh->list, list) {
> +			if (!strncmp(it->name, name, sizeof(it->name))) {
> +				session = it;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (!session)
> +		return -ENOENT;
> +
> +	scoped_guard(mutex, &session->mutex) {
> +		if (session->retrieved)
> +			return -EINVAL;
> +	}
> +
> +	err = luo_session_getfile(session, filep);
> +	if (!err) {
> +		scoped_guard(mutex, &session->mutex)
> +			session->retrieved = true;
> +	}
> +
> +	return err;
> +}
> +
> +int __init luo_session_setup_outgoing(void *fdt_out)
> +{
> +	struct luo_session_head_ser *head_ser;
> +	u64 head_ser_pa;
> +	int err;
> +
> +	head_ser = luo_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
> +	if (IS_ERR(head_ser))
> +		return PTR_ERR(head_ser);
> +	head_ser_pa = __pa(head_ser);

virt_to_phys please

> +
> +	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
> +	err |= fdt_property_string(fdt_out, "compatible",
> +				   LUO_FDT_SESSION_COMPATIBLE);
> +	err |= fdt_property(fdt_out, LUO_FDT_SESSION_HEAD, &head_ser_pa,
> +			    sizeof(head_ser_pa));
> +	err |= fdt_end_node(fdt_out);
> +
> +	if (err)
> +		goto err_unpreserve;
> +
> +	head_ser->pgcnt = LUO_SESSION_PGCNT;
> +	INIT_LIST_HEAD(&luo_session_global.outgoing.list);
> +	init_rwsem(&luo_session_global.outgoing.rwsem);
> +	luo_session_global.outgoing.head_ser = head_ser;
> +	luo_session_global.outgoing.ser = (void *)(head_ser + 1);
> +	luo_session_global.outgoing.active = true;
> +
> +	return 0;
> +
> +err_unpreserve:
> +	luo_free_unpreserve(head_ser, LUO_SESSION_PGCNT << PAGE_SHIFT);
> +	return err;
> +}
> +
> +int __init luo_session_setup_incoming(void *fdt_in)
> +{
> +	struct luo_session_head_ser *head_ser;
> +	int err, head_size, offset;
> +	const void *ptr;
> +	u64 head_ser_pa;
> +
> +	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_SESSION_NODE_NAME);
> +	if (offset < 0) {
> +		pr_err("Unable to get session node: [%s]\n",
> +		       LUO_FDT_SESSION_NODE_NAME);
> +		return -EINVAL;
> +	}
> +
> +	err = fdt_node_check_compatible(fdt_in, offset,
> +					LUO_FDT_SESSION_COMPATIBLE);
> +	if (err) {
> +		pr_err("Session node incompatibale [%s]\n",
> +		       LUO_FDT_SESSION_COMPATIBLE);
> +		return -EINVAL;
> +	}
> +
> +	head_size = 0;
> +	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_SESSION_HEAD, &head_size);
> +	if (!ptr || head_size != sizeof(u64)) {
> +		pr_err("Unable to get session head '%s' [%d]\n",
> +		       LUO_FDT_SESSION_HEAD, head_size);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(&head_ser_pa, ptr, sizeof(u64));
> +	head_ser = __va(head_ser_pa);
> +
> +	luo_session_global.incoming.head_ser = head_ser;
> +	luo_session_global.incoming.ser = (void *)(head_ser + 1);
> +	INIT_LIST_HEAD(&luo_session_global.incoming.list);
> +	init_rwsem(&luo_session_global.incoming.rwsem);
> +	luo_session_global.incoming.active = true;
> +
> +	return 0;
> +}
> +
> +bool luo_session_is_deserialized(void)
> +{
> +	return luo_session_global.deserialized;
> +}
> +
> +int luo_session_deserialize(void)
> +{
> +	struct luo_session_head *sh = &luo_session_global.incoming;
> +
> +	if (luo_session_is_deserialized())
> +		return 0;
> +
> +	luo_session_global.deserialized = true;

Shouldn't this be set after deserialization succeeded?

> +	if (!sh->active) {
> +		INIT_LIST_HEAD(&sh->list);
> +		init_rwsem(&sh->rwsem);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < sh->head_ser->count; i++) {
> +		struct luo_session *session;
> +
> +		session = luo_session_alloc(sh->ser[i].name);
> +		if (!session) {
> +			pr_warn("Failed to allocate session [%s] during deserialization\n",
> +				sh->ser[i].name);
> +			return -ENOMEM;
> +		}
> +
> +		if (luo_session_insert(sh, session)) {
> +			pr_warn("Failed to insert session due to name conflict [%s]\n",
> +				session->name);
> +			return -EEXIST;

Need to free allocated sessions if an insert fails.

> +		}
> +
> +		session->count = sh->ser[i].count;
> +		session->files = __va(sh->ser[i].files);
> +		session->pgcnt = sh->ser[i].pgcnt;
> +	}
> +
> +	luo_free_restore(sh->head_ser, sh->head_ser->pgcnt << PAGE_SHIFT);
> +	sh->head_ser = NULL;
> +	sh->ser = NULL;
> +
> +	return 0;
> +}
> +
> +int luo_session_serialize(void)
> +{
> +	struct luo_session_head *sh = &luo_session_global.outgoing;
> +	struct luo_session *session;
> +	int i = 0;
> +
> +	guard(rwsem_write)(&sh->rwsem);
> +	list_for_each_entry(session, &sh->list, list) {
> +		strscpy(sh->ser[i].name, session->name,
> +			sizeof(sh->ser[i].name));
> +		sh->ser[i].count = session->count;
> +		sh->ser[i].files = __pa(session->files);
> +		sh->ser[i].pgcnt = session->pgcnt;
> +		i++;
> +	}
> +	sh->head_ser->count = sh->count;
> +
> +	return 0;
> +}
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
> 

-- 
Sincerely yours,
Mike.

