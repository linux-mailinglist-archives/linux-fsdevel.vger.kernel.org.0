Return-Path: <linux-fsdevel+bounces-68616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D45C61A72
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 19:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8144A4EB395
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25F3101A2;
	Sun, 16 Nov 2025 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYsIRMFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649D284B58;
	Sun, 16 Nov 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763316973; cv=none; b=nt7JKxvyJGsL7cqoWRVxjlS8aKKI/b6JwLCGBaXDR357A+unhMPJT4dT7Fui+tui8qnyDfcHGJZPX6gV5fz1ULMsHpgF73A4iT8pl9ohlPdw8dXTXwtkaEl9EqbOsFsagknVHIAgsnv7y8WxXV2MvPB4a/3tpL0Vo77UxuxknS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763316973; c=relaxed/simple;
	bh=QdlF0QxKr4p5syrv6dsth+SobQ3XuxtEoELHdC9qHpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br0xagUxABx9LzMPdR3mE3SjjtXZe1fpm0j5KifpPEIVV8EyNFbsH9zNYXiFKHbaewq/ddQRHYV0QMyjyn4n555NnRbMA+CawLkherP2I8UKAnTw7WAxV4q/Y/+C00UxH950VlLcRA7H/5rCKS3QnLAHOPYtjln8aCv2mXQqw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYsIRMFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F7C116D0;
	Sun, 16 Nov 2025 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763316973;
	bh=QdlF0QxKr4p5syrv6dsth+SobQ3XuxtEoELHdC9qHpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYsIRMFLiidsD1j305+taTZ+NyZEvNqsjWLnfSGavOOh3UYoJikNsn/pWKu7lfWTZ
	 sl/ms/nGyaAP6Bop7nB/9L6OAWrNHcCWfR/jcxVULtfgeLxasVaR6SGT3qO7q5k95p
	 TgZbDke7v59WManyPHHUj0koJRCVUBpQ+tJ3B5ZL8wkN/eDN+YqDgH+3iQ+nEIsrjY
	 y6IzZqiVxfY4ysaODqP3kxVCntiYglJZGm4eb+7+zhVfEz6tzB19VknJldXOFKA8jz
	 7RF2UfQreFpc1EW8g4FaMEdpZOo0S36ge69/ESgGFympLZqxlc+Opkq7X7bCZHWWnP
	 Bgiq0X1/D+XtA==
Date: Sun, 16 Nov 2025 20:15:48 +0200
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
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
Message-ID: <aRoU1DSgVmplHr3E@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251115233409.768044-7-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:52PM -0500, Pasha Tatashin wrote:
> This patch implements the core mechanism for managing preserved
> files throughout the live update lifecycle. It provides the logic to
> invoke the file handler callbacks (preserve, unpreserve, freeze,
> unfreeze, retrieve, and finish) at the appropriate stages.
> 
> During the reboot phase, luo_file_freeze() serializes the final
> metadata for each file (handler compatible string, token, and data
> handle) into a memory region preserved by KHO. In the new kernel,
> luo_file_deserialize() reconstructs the in-memory file list from this
> data, preparing the session for retrieval.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate.h         | 109 ++++
>  include/linux/liveupdate/abi/luo.h |  22 +
>  kernel/liveupdate/Makefile         |   1 +
>  kernel/liveupdate/luo_file.c       | 887 +++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h   |   9 +
>  5 files changed, 1028 insertions(+)
>  create mode 100644 kernel/liveupdate/luo_file.c
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 730b76625fec..4a5d4dd9905a 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -10,6 +10,88 @@
>  #include <linux/bug.h>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/liveupdate/abi/luo.h>
> +#include <uapi/linux/liveupdate.h>
> +
> +struct liveupdate_file_handler;
> +struct liveupdate_session;

Why struct liveupdate_session is a part of public LUO API?

> +struct file;
> +
> +/**
> + * struct liveupdate_file_op_args - Arguments for file operation callbacks.
> + * @handler:          The file handler being called.
> + * @session:          The session this file belongs to.
> + * @retrieved:        The retrieve status for the 'can_finish / finish'
> + *                    operation.
> + * @file:             The file object. For retrieve: [OUT] The callback sets
> + *                    this to the new file. For other ops: [IN] The caller sets
> + *                    this to the file being operated on.
> + * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
> + *                    this field.
> + *
> + * This structure bundles all parameters for the file operation callbacks.
> + * The 'data' and 'file' fields are used for both input and output.
> + */
> +struct liveupdate_file_op_args {
> +	struct liveupdate_file_handler *handler;
> +	struct liveupdate_session *session;
> +	bool retrieved;
> +	struct file *file;
> +	u64 serialized_data;
> +};
> +
> +/**
> + * struct liveupdate_file_ops - Callbacks for live-updatable files.
> + * @can_preserve: Required. Lightweight check to see if this handler is
> + *                compatible with the given file.
> + * @preserve:     Required. Performs state-saving for the file.
> + * @unpreserve:   Required. Cleans up any resources allocated by @preserve.
> + * @freeze:       Optional. Final actions just before kernel transition.
> + * @unfreeze:     Optional. Undo freeze operations.
> + * @retrieve:     Required. Restores the file in the new kernel.
> + * @can_finish:   Optional. Check if this FD can finish, i.e. all restoration
> + *                pre-requirements for this FD are satisfied. Called prior to
> + *                finish, in order to do successful finish calls for all
> + *                resources in the session.
> + * @finish:       Required. Final cleanup in the new kernel.
> + * @owner:        Module reference
> + *
> + * All operations (except can_preserve) receive a pointer to a
> + * 'struct liveupdate_file_op_args' containing the necessary context.
> + */
> +struct liveupdate_file_ops {
> +	bool (*can_preserve)(struct liveupdate_file_handler *handler,
> +			     struct file *file);
> +	int (*preserve)(struct liveupdate_file_op_args *args);
> +	void (*unpreserve)(struct liveupdate_file_op_args *args);
> +	int (*freeze)(struct liveupdate_file_op_args *args);
> +	void (*unfreeze)(struct liveupdate_file_op_args *args);
> +	int (*retrieve)(struct liveupdate_file_op_args *args);
> +	bool (*can_finish)(struct liveupdate_file_op_args *args);
> +	void (*finish)(struct liveupdate_file_op_args *args);
> +	struct module *owner;
> +};
> +
> +/**
> + * struct liveupdate_file_handler - Represents a handler for a live-updatable file type.
> + * @ops:                Callback functions
> + * @compatible:         The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
> + *                      that uniquely identifies the file type this handler
> + *                      supports. This is matched against the compatible string
> + *                      associated with individual &struct file instances.
> + * @list:               Used for linking this handler instance into a global
> + *                      list of registered file handlers.
> + *
> + * Modules that want to support live update for specific file types should
> + * register an instance of this structure. LUO uses this registration to
> + * determine if a given file can be preserved and to find the appropriate
> + * operations to manage its state across the update.
> + */
> +struct liveupdate_file_handler {
> +	const struct liveupdate_file_ops *ops;
> +	const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
> +	struct list_head list;

Did you consider using __private and ACCESS_PRIVATE() for the ->list
member here and in other structures visible outside kernel/liveupdate?

> +};
>  
>  #ifdef CONFIG_LIVEUPDATE
>  
> @@ -19,6 +101,16 @@ bool liveupdate_enabled(void);
>  /* Called during kexec to tell LUO that entered into reboot */
>  int liveupdate_reboot(void);
>  
> +int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
> +
> +/* kernel can internally retrieve files */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep);
> +
> +/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp);
> +
>  #else /* CONFIG_LIVEUPDATE */
>  
>  static inline bool liveupdate_enabled(void)
> @@ -31,5 +123,22 @@ static inline int liveupdate_reboot(void)
>  	return 0;
>  }
>  
> +static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *h)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
> +					       u64 token, struct file **filep)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +						struct file *file, u64 *tokenp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_LIVEUPDATE */
>  #endif /* _LINUX_LIVEUPDATE_H */
> diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
> index 03a177ae232e..3a596ca1907b 100644
> --- a/include/linux/liveupdate/abi/luo.h
> +++ b/include/linux/liveupdate/abi/luo.h
> @@ -65,6 +65,11 @@
>   *     Metadata for a single session, including its name and a physical pointer
>   *     to another preserved memory block containing an array of
>   *     `struct luo_file_ser` for all files in that session.
> + *
> + *   - struct luo_file_ser:
> + *     Metadata for a single preserved file. Contains the `compatible` string to
> + *     find the correct handler in the new kernel, a user-provided `token` for
> + *     identification, and an opaque `data` handle for the handler to use.
>   */
>  
>  #ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
> @@ -132,4 +137,21 @@ struct luo_session_ser {
>  	u64 count;
>  } __packed;
>  
> +/* The max size is set so it can be reliably used during in serialization */

I failed to parse this comment.

> +#define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
> +
> +/**
> + * struct luo_file_ser - Represents the serialized preserves files.
> + * @compatible:  File handler compatible string.
> + * @data:        Private data
> + * @token:       User provided token for this file
> + *
> + * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
> + */
> +struct luo_file_ser {
> +	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
> +	u64 data;
> +	u64 token;
> +} __packed;
> +
>  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index 83285e7ad726..c2252a2ad7bd 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -2,6 +2,7 @@
>  
>  luo-y :=								\
>  		luo_core.o						\
> +		luo_file.o						\
>  		luo_ioctl.o						\
>  		luo_session.o
>  
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> new file mode 100644
> index 000000000000..dae27a69a09f
> --- /dev/null
> +++ b/kernel/liveupdate/luo_file.c
> @@ -0,0 +1,887 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: LUO File Descriptors
> + *
> + * LUO provides the infrastructure to preserve specific, stateful file
> + * descriptors across a kexec-based live update. The primary goal is to allow
> + * workloads, such as virtual machines using vfio, memfd, or iommufd, to
> + * retain access to their essential resources without interruption.
> + *
> + * The framework is built around a callback-based handler model and a well-
> + * defined lifecycle for each preserved file.
> + *
> + * Handler Registration:
> + * Kernel modules responsible for a specific file type (e.g., memfd, vfio)
> + * register a &struct liveupdate_file_handler. This handler provides a set of
> + * callbacks that LUO invokes at different stages of the update process, most
> + * notably:
> + *
> + *   - can_preserve(): A lightweight check to determine if the handler is
> + *     compatible with a given 'struct file'.
> + *   - preserve(): The heavyweight operation that saves the file's state and
> + *     returns an opaque u64 handle, happens while vcpus are still running.

                                                     ^ VCPUs

This narrows the description to VM-only usecase and in general ->preserve()
may happen after VCPUs are suspended, although it's neither intended nor
desirable. LUO does not control the sequencing so we can't claim here
anything about VCPUs.

> + *     LUO becomes the owner of this file until session is closed or file is
> + *     finished.

"file is finished" reads too vague to me.

> + *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
> + *     if the preservation process is aborted before the reboot (i.e. session is
> + *     closed).
> + *   - freeze(): A final pre-reboot opportunity to prepare the state for kexec.
> + *     We are already in reboot syscall, and therefore userspace cannot mutate
> + *     the file anymore.
> + *   - unfreeze(): Undoes the actions of .freeze(), called if the live update
> + *     is aborted after the freeze phase.
> + *   - retrieve(): Reconstructs the file in the new kernel from the preserved
> + *     handle.
> + *   - finish(): Performs final check and cleanup in the new kernel. After
> + *     succesul finish call, LUO gives up ownership to this file.
> + *
> + * File Preservation Lifecycle happy path:
> + *
> + * 1. Preserve (Normal Operation): A userspace agent preserves files one by one
> + *    via an ioctl. For each file, luo_preserve_file() finds a compatible
> + *    handler, calls its .preserve() op, and creates an internal &struct

                                      ^ method or operation

> + *    luo_file to track the live state.
> + *
> + * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
> + *    It iterates through all preserved files, calls their respective .freeze()
> + *    ops, and serializes their final metadata (compatible string, token, and

	^ method or operation

> + *    data handle) into a contiguous memory block for KHO.
> + *
> + * 3. Deserialize (New Kernel - Early Boot): After kexec, luo_file_deserialize()

From the code it seems that description runs on the fist open of
/dev/liveupdated, what do I miss?

> + *    runs. It reads the serialized data from the KHO memory region and
> + *    reconstructs the in-memory list of &struct luo_file instances for the new
> + *    kernel, linking them to their corresponding handlers.
> + *
> + * 4. Retrieve (New Kernel - Userspace Ready): The userspace agent can now
> + *    restore file descriptors by providing a token. luo_retrieve_file()
> + *    searches for the matching token, calls the handler's .retrieve() op to
> + *    re-create the 'struct file', and returns a new FD. Files can be
> + *    retrieved in ANY order.
> + *
> + * 5. Finish (New Kernel - Cleanup): Once a session retrival is complete,
> + *    luo_file_finish() is called. It iterates through all files,
> + *    invokes their .finish() ops for final cleanup, and releases all

                                ^ method

> + *    associated kernel resources.
> + *
> + * File Preservation Lifecycle unhappy paths:
> + *
> + * 1. Abort Before Reboot: If the userspace agent aborts the live update
> + *    process before calling reboot (e.g., by closing the session file
> + *    descriptor), the session's release handler calls
> + *    luo_file_unpreserve_files(). This invokes the .unpreserve() callback on
> + *    all preserved files, ensuring all allocated resources are cleaned up and
> + *    returning the system to a clean state.
> + *
> + * 2. Freeze Failure: During the reboot() syscall, if any handler's .freeze()
> + *    op fails, the .unfreeze() op is invoked on all previously *successful*
> + *    freezes to roll back their state. The reboot() syscall then returns an
> + *    error to userspace, canceling the live update.
> + *
> + * 3. Finish Failure: In the new kernel, if a handler's .finish() op fails,
> + *    the luo_file_finish() operation is aborted. LUO retains ownership of
> + *    all files within that session, including those that were not yet
> + *    processed. The userspace agent can attempt to call the finish operation
> + *    again later. If the issue cannot be resolved, these resources will be held
> + *    by LUO until the next live update cycle, at which point they will be
> + *    discarded.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/liveupdate/abi/luo.h>
> +#include <linux/module.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "luo_internal.h"
> +
> +static LIST_HEAD(luo_file_handler_list);
> +
> +/* 2 4K pages, give space for 128 files per session */
> +#define LUO_FILE_PGCNT		2ul
> +#define LUO_FILE_MAX							\
> +	((LUO_FILE_PGCNT << PAGE_SHIFT) / sizeof(struct luo_file_ser))
> +
> +/**
> + * struct luo_file - Represents a single preserved file instance.
> + * @fh:            Pointer to the &struct liveupdate_file_handler that manages
> + *                 this type of file.
> + * @file:          Pointer to the kernel's &struct file that is being preserved.
> + *                 This is NULL in the new kernel until the file is successfully
> + *                 retrieved.
> + * @serialized_data: The opaque u64 handle to the serialized state of the file.
> + *                 This handle is passed back to the handler's .freeze(),
> + *                 .retrieve(), and .finish() callbacks, allowing it to track
> + *                 and update its serialized state across phases.
> + * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
> + *                 successfully called retrieve() on this file. This prevents
> + *                 multiple retrieval attempts.
> + * @mutex:         A mutex that protects the fields of this specific instance
> + *                 (e.g., @retrieved, @file), ensuring that operations like
> + *                 retrieving or finishing a file are atomic.
> + * @list:          The list_head linking this instance into its parent
> + *                 session's list of preserved files.
> + * @token:         The user-provided unique token used to identify this file.
> + *
> + * This structure is the core in-kernel representation of a single file being
> + * managed through a live update. An instance is created by luo_preserve_file()
> + * to link a 'struct file' to its corresponding handler, a user-provided token,
> + * and the serialized state handle returned by the handler's .preserve()
> + * operation.
> + *
> + * These instances are tracked in a per-session list. The @serialized_data
> + * field, which holds a handle to the file's serialized state, may be updated
> + * during the .freeze() callback before being serialized for the next kernel.
> + * After reboot, these structures are recreated by luo_file_deserialize() and
> + * are finally cleaned up by luo_file_finish().
> + */
> +struct luo_file {
> +	struct liveupdate_file_handler *fh;
> +	struct file *file;
> +	u64 serialized_data;
> +	bool retrieved;
> +	struct mutex mutex;
> +	struct list_head list;
> +	u64 token;
> +};
> +
> +static int luo_session_alloc_files_mem(struct luo_session *session)

It seems like this belongs to luo_session.c

> +{
> +	size_t size;
> +	void *mem;
> +
> +	if (session->files)
> +		return 0;
> +
> +	WARN_ON_ONCE(session->count);
> +
> +	size = LUO_FILE_PGCNT << PAGE_SHIFT;
> +	mem = kho_alloc_preserve(size);
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
> +
> +	session->files = mem;
> +	session->pgcnt = LUO_FILE_PGCNT;
> +
> +	return 0;
> +}
> +
> +static void luo_session_free_files_mem(struct luo_session *session)
> +{

Ditto

> +	/* If session has files, no need to free preservation memory */
> +	if (session->count)
> +		return;
> +
> +	if (!session->files)
> +		return;
> +
> +	kho_unpreserve_free(session->files);
> +	session->files = NULL;
> +	session->pgcnt = 0;
> +}
> +
> +static bool luo_token_is_used(struct luo_session *session, u64 token)
> +{
> +	struct luo_file *iter;
> +
> +	list_for_each_entry(iter, &session->files_list, list) {

And here again I'm not very fond of dereferencing session objects in
luo_file.

> +		if (iter->token == token)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * luo_preserve_file - Initiate the preservation of a file descriptor.
> + * @session: The session to which the preserved file will be added.
> + * @token:   A unique, user-provided identifier for the file.
> + * @fd:      The file descriptor to be preserved.
> + *
> + * This function orchestrates the first phase of preserving a file. Upon entry,
> + * it takes a reference to the 'struct file' via fget(), effectively making LUO
> + * a co-owner of the file. This reference is held until the file is either
> + * unpreserved or successfully finished in the next kernel, preventing the file
> + * from being prematurely destroyed.
> + *
> + * This function orchestrates the first phase of preserving a file. It performs
> + * the following steps:
> + *
> + * 1. Validates that the @token is not already in use within the session.
> + * 2. Ensures the session's memory for files serialization is allocated
> + *    (allocates if needed).
> + * 3. Iterates through registered handlers, calling can_preserve() to find one
> + *    compatible with the given @fd.
> + * 4. Calls the handler's .preserve() operation, which saves the file's state
> + *    and returns an opaque private data handle.
> + * 5. Adds the new instance to the session's internal list.
> + *
> + * On success, LUO takes a reference to the 'struct file' and considers it
> + * under its management until it is unpreserved or finished.
> + *
> + * In case of any failure, all intermediate allocations (file reference, memory
> + * for the 'luo_file' struct, etc.) are cleaned up before returning an error.
> + *
> + * Context: Can be called from an ioctl handler during normal system operation.
> + * Return: 0 on success. Returns a negative errno on failure:
> + *         -EEXIST if the token is already used.
> + *         -EBADF if the file descriptor is invalid.
> + *         -ENOSPC if the session is full.
> + *         -ENOENT if no compatible handler is found.
> + *         -ENOMEM on memory allocation failure.
> + *         Other erros might be returned by .preserve().
> + */
> +int luo_preserve_file(struct luo_session *session, u64 token, int fd)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +	struct liveupdate_file_handler *fh;
> +	struct luo_file *luo_file;
> +	struct file *file;
> +	int err;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (luo_token_is_used(session, token))
> +		return -EEXIST;
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	err = luo_session_alloc_files_mem(session);
> +	if (err)
> +		goto  exit_err;
> +
> +	if (session->count == LUO_FILE_MAX) {
> +		err = -ENOSPC;
> +		goto exit_err;
> +	}

I believe session can be prepared and vailidated by the caller.

> +
> +	err = -ENOENT;
> +	list_for_each_entry(fh, &luo_file_handler_list, list) {
> +		if (fh->ops->can_preserve(fh, file)) {
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	/* err is still -ENOENT if no handler was found */
> +	if (err)
> +		goto exit_err;
> +
> +	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> +	if (!luo_file) {
> +		err = -ENOMEM;
> +		goto exit_err;
> +	}
> +
> +	luo_file->file = file;
> +	luo_file->fh = fh;
> +	luo_file->token = token;
> +	luo_file->retrieved = false;
> +	mutex_init(&luo_file->mutex);
> +
> +	args.handler = fh;
> +	args.session = (struct liveupdate_session *)session;

Isn't args.session already struct liveupdate_session *?

> +	args.file = file;
> +	err = fh->ops->preserve(&args);
> +	if (err) {
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +		goto exit_err;
> +	} else {
> +		luo_file->serialized_data = args.serialized_data;
> +		list_add_tail(&luo_file->list, &session->files_list);
> +		session->count++;

I'd use luo_session_add_file(struct luo_file *luo_file) or return luo_file
by reference to the caller.
Than the lockdep_assert_held() can go away as well.

> +	}
> +
> +	return 0;
> +
> +exit_err:
> +	fput(file);
> +	luo_session_free_files_mem(session);

The error handling in this function is a mess. Pasha, please, please, use
goto consistently.

> +
> +	return err;
> +}
> +
> +/**
> + * luo_file_unpreserve_files - Unpreserves all files from a session.
> + * @session: The session to be cleaned up.
> + *
> + * This function serves as the primary cleanup path for a session. It is
> + * invoked when the userspace agent closes the session's file descriptor.
> + *
> + * For each file, it performs the following cleanup actions:
> + *   1. Calls the handler's .unpreserve() callback to allow the handler to
> + *      release any resources it allocated.
> + *   2. Removes the file from the session's internal tracking list.
> + *   3. Releases the reference to the 'struct file' that was taken by
> + *      luo_preserve_file() via fput(), returning ownership.
> + *   4. Frees the memory associated with the internal 'struct luo_file'.
> + *
> + * After all individual files are unpreserved, it frees the contiguous memory
> + * block that was allocated to hold their serialization data.
> + */
> +void luo_file_unpreserve_files(struct luo_session *session)
> +{
> +	struct luo_file *luo_file;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	while (!list_empty(&session->files_list)) {

I think the loop should be in luo_session.c and luo_files.c should
implement luo_file_unpreserve(struct luo_file *luo_file)

The same applies to other functions below that do something with all files
in the session. In my view luo_session should iterate through
luo_session.files_list and call luo_file methods for each luo_file object.

> +		struct liveupdate_file_op_args args = {0};
> +
> +		luo_file = list_last_entry(&session->files_list,
> +					   struct luo_file, list);
> +
> +		args.handler = luo_file->fh;
> +		args.session = (struct liveupdate_session *)session;
> +		args.file = luo_file->file;
> +		args.serialized_data = luo_file->serialized_data;
> +		luo_file->fh->ops->unpreserve(&args);
> +
> +		list_del(&luo_file->list);
> +		session->count--;
> +
> +		fput(luo_file->file);
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +
> +	luo_session_free_files_mem(session);
> +}
> +
> +static int luo_file_freeze_one(struct luo_session *session,
> +			       struct luo_file *luo_file)
> +{
> +	int err = 0;
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->freeze) {
> +		struct liveupdate_file_op_args args = {0};
> +
> +		args.handler = luo_file->fh;
> +		args.session = (struct liveupdate_session *)session;
> +		args.file = luo_file->file;
> +		args.serialized_data = luo_file->serialized_data;
> +
> +		err = luo_file->fh->ops->freeze(&args);
> +		if (!err)
> +			luo_file->serialized_data = args.serialized_data;
> +	}
> +
> +	return err;
> +}
> +
> +static void luo_file_unfreeze_one(struct luo_session *session,
> +				  struct luo_file *luo_file)
> +{
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->unfreeze) {
> +		struct liveupdate_file_op_args args = {0};
> +
> +		args.handler = luo_file->fh;
> +		args.session = (struct liveupdate_session *)session;
> +		args.file = luo_file->file;
> +		args.serialized_data = luo_file->serialized_data;
> +
> +		luo_file->fh->ops->unfreeze(&args);
> +	}
> +
> +	luo_file->serialized_data = 0;
> +}
> +
> +static void __luo_file_unfreeze(struct luo_session *session,
> +				struct luo_file *failed_entry)
> +{
> +	struct list_head *files_list = &session->files_list;
> +	struct luo_file *luo_file;
> +
> +	list_for_each_entry(luo_file, files_list, list) {
> +		if (luo_file == failed_entry)
> +			break;
> +
> +		luo_file_unfreeze_one(session, luo_file);
> +	}
> +
> +	memset(session->files, 0, session->pgcnt << PAGE_SHIFT);
> +}
> +
> +/**
> + * luo_file_freeze - Freezes all preserved files and serializes their metadata.
> + * @session: The session whose files are to be frozen.
> + *
> + * This function is called from the reboot() syscall path, just before the
> + * kernel transitions to the new image via kexec. Its purpose is to perform the
> + * final preparation and serialization of all preserved files in the session.
> + *
> + * It iterates through each preserved file in FIFO order (the order of
> + * preservation) and performs two main actions:
> + *
> + * 1. Freezes the File: It calls the handler's .freeze() callback for each
> + *    file. This gives the handler a final opportunity to quiesce the device or
> + *    prepare its state for the upcoming reboot. The handler may update its
> + *    private data handle during this step.
> + *
> + * 2. Serializes Metadata: After a successful freeze, it copies the final file
> + *    metadata—the handler's compatible string, the user token, and the final
> + *    private data handle—into the pre-allocated contiguous memory buffer
> + *    (session->files) that will be handed over to the next kernel via KHO.
> + *
> + * Error Handling (Rollback):
> + * This function is atomic. If any handler's .freeze() operation fails, the
> + * entire live update is aborted. The __luo_file_unfreeze() helper is
> + * immediately called to invoke the .unfreeze() op on all files that were
> + * successfully frozen before the point of failure, rolling them back to a
> + * running state. The function then returns an error, causing the reboot()
> + * syscall to fail.
> + *
> + * Context: Called only from the liveupdate_reboot() path.
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int luo_file_freeze(struct luo_session *session)
> +{
> +	struct luo_file_ser *file_ser = session->files;
> +	struct luo_file *luo_file;
> +	int err;
> +	int i;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->count)
> +		return 0;
> +
> +	if (WARN_ON(!file_ser))
> +		return -EINVAL;
> +
> +	i = 0;
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		err = luo_file_freeze_one(session, luo_file);
> +		if (err < 0) {
> +			pr_warn("Freeze failed for session[%s] token[%#0llx] handler[%s] err[%pe]\n",
> +				session->name, luo_file->token,
> +				luo_file->fh->compatible, ERR_PTR(err));
> +			goto exit_err;
> +		}
> +
> +		strscpy(file_ser[i].compatible, luo_file->fh->compatible,
> +			sizeof(file_ser[i].compatible));
> +		file_ser[i].data = luo_file->serialized_data;
> +		file_ser[i].token = luo_file->token;
> +		i++;
> +	}
> +
> +	return 0;
> +
> +exit_err:
> +	__luo_file_unfreeze(session, luo_file);

Maybe move frozen files to a local list, call __luo_file_unfreeze() with
that list and than splice it back to session.files_list?

> +
> +	return err;
> +}
> +
> +/**
> + * luo_file_unfreeze - Unfreezes all files in a session.
> + * @session: The session whose files are to be unfrozen.
> + *
> + * This function rolls back the state of all files in a session after the freeze
> + * phase has begun but must be aborted. It is the counterpart to
> + * luo_file_freeze().
> + *
> + * It invokes the __luo_file_unfreeze() helper with a NULL argument, which
> + * signals the helper to iterate through all files in the session  and call
> + * their respective .unfreeze() handler callbacks.
> + *
> + * Context: This is called when the live update is aborted during
> + *          the reboot() syscall, after luo_file_freeze() has been called.
> + */
> +void luo_file_unfreeze(struct luo_session *session)
> +{
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->count)
> +		return;
> +
> +	__luo_file_unfreeze(session, NULL);
> +}
> +
> +/**
> + * luo_retrieve_file - Restores a preserved file from a session by its token.
> + * @session: The session from which to retrieve the file.
> + * @token:   The unique token identifying the file to be restored.
> + * @filep:   Output parameter; on success, this is populated with a pointer
> + *           to the newly retrieved 'struct file'.
> + *
> + * This function is the primary mechanism for recreating a file in the new
> + * kernel after a live update. It searches the session's list of deserialized
> + * files for an entry matching the provided @token.
> + *
> + * The operation is idempotent: if a file has already been successfully
> + * retrieved, this function will simply return a pointer to the existing
> + * 'struct file' and report success without re-executing the retrieve
> + * operation. This is handled by checking the 'retrieved' flag under a lock.
> + *
> + * File retrieval can happen in any order; it is not bound by the order of
> + * preservation.
> + *
> + * Context: Can be called from an ioctl or other in-kernel code in the new
> + *          kernel.
> + * Return: 0 on success. Returns a negative errno on failure:
> + *         -ENOENT if no file with the matching token is found.
> + *         Any error code returned by the handler's .retrieve() op.
> + */
> +int luo_retrieve_file(struct luo_session *session, u64 token,
> +		      struct file **filep)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +	struct luo_file *luo_file;
> +	int err;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (list_empty(&session->files_list))
> +		return -ENOENT;
> +
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		if (luo_file->token == token)
> +			break;
> +	}
> +
> +	if (luo_file->token != token)
> +		return -ENOENT;
> +
> +	guard(mutex)(&luo_file->mutex);
> +	if (luo_file->retrieved) {
> +		/*
> +		 * Someone is asking for this file again, so get a reference
> +		 * for them.
> +		 */
> +		get_file(luo_file->file);
> +		*filep = luo_file->file;
> +		return 0;
> +	}
> +
> +	args.handler = luo_file->fh;
> +	args.session = (struct liveupdate_session *)session;
> +	args.serialized_data = luo_file->serialized_data;
> +	err = luo_file->fh->ops->retrieve(&args);
> +	if (!err) {
> +		luo_file->file = args.file;
> +
> +		/* Get reference so we can keep this file in LUO until finish */
> +		get_file(luo_file->file);
> +		*filep = luo_file->file;
> +		luo_file->retrieved = true;
> +	}
> +
> +	return err;
> +}
> +
> +static int luo_file_can_finish_one(struct luo_session *session,
> +				   struct luo_file *luo_file)
> +{
> +	bool can_finish = true;
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	if (luo_file->fh->ops->can_finish) {
> +		struct liveupdate_file_op_args args = {0};
> +
> +		args.handler = luo_file->fh;
> +		args.session = (struct liveupdate_session *)session;
> +		args.file = luo_file->file;
> +		args.serialized_data = luo_file->serialized_data;
> +		args.retrieved = luo_file->retrieved;
> +		can_finish = luo_file->fh->ops->can_finish(&args);
> +	}
> +
> +	return can_finish ? 0 : -EBUSY;
> +}
> +
> +static void luo_file_finish_one(struct luo_session *session,
> +				struct luo_file *luo_file)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +
> +	guard(mutex)(&luo_file->mutex);
> +
> +	args.handler = luo_file->fh;
> +	args.session = (struct liveupdate_session *)session;
> +	args.file = luo_file->file;
> +	args.serialized_data = luo_file->serialized_data;
> +	args.retrieved = luo_file->retrieved;
> +
> +	luo_file->fh->ops->finish(&args);
> +}
> +
> +/**
> + * luo_file_finish - Completes the lifecycle for all files in a session.
> + * @session: The session to be finalized.
> + *
> + * This function orchestrates the final teardown of a live update session in the
> + * new kernel. It should be called after all necessary files have been
> + * retrieved and the userspace agent is ready to release the preserved state.
> + *
> + * The function iterates through all tracked files. For each file, it performs
> + * the following sequence of cleanup actions:
> + *
> + * 1. If file is not yet retrieved, retrieves it, and calls can_finish() on
> + *    every file in the session. If all can_finish return true, continue to
> + *    finish.
> + * 2. Calls the handler's .finish() callback (via luo_file_finish_one) to
> + *    allow for final resource cleanup within the handler.
> + * 3. Releases LUO's ownership reference on the 'struct file' via fput(). This
> + *    is the counterpart to the get_file() call in luo_retrieve_file().
> + * 4. Removes the 'struct luo_file' from the session's internal list.
> + * 5. Frees the memory for the 'struct luo_file' instance itself.
> + *
> + * After successfully finishing all individual files, it frees the
> + * contiguous memory block that was used to transfer the serialized metadata
> + * from the previous kernel.
> + *
> + * Error Handling (Atomic Failure):
> + * This operation is atomic. If any handler's .can_finish() op fails, the entire
> + * function aborts immediately and returns an error.
> + *
> + * Context: Can be called from an ioctl handler in the new kernel.
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int luo_file_finish(struct luo_session *session)
> +{
> +	struct list_head *files_list = &session->files_list;
> +	struct luo_file *luo_file;
> +	int err;
> +
> +	if (!session->count)
> +		return 0;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	list_for_each_entry(luo_file, files_list, list) {
> +		err = luo_file_can_finish_one(session, luo_file);
> +		if (err)
> +			return err;
> +	}
> +
> +	while (!list_empty(&session->files_list)) {
> +		luo_file = list_last_entry(&session->files_list,
> +					   struct luo_file, list);
> +
> +		luo_file_finish_one(session, luo_file);
> +
> +		if (luo_file->file)
> +			fput(luo_file->file);
> +		list_del(&luo_file->list);
> +		session->count--;
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +
> +	if (session->files) {
> +		kho_restore_free(session->files);
> +		session->files = NULL;
> +		session->pgcnt = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
> + * @session: The incoming session containing the serialized file data from KHO.
> + *
> + * This function is called during the early boot process of the new kernel. It
> + * takes the raw, contiguous memory block of 'struct luo_file_ser' entries,
> + * provided by the previous kernel, and transforms it back into a live,
> + * in-memory linked list of 'struct luo_file' instances.
> + *
> + * For each serialized entry, it performs the following steps:
> + *   1. Reads the 'compatible' string.
> + *   2. Searches the global list of registered file handlers for one that
> + *      matches the compatible string.
> + *   3. Allocates a new 'struct luo_file'.
> + *   4. Populates the new structure with the deserialized data (token, private
> + *      data handle) and links it to the found handler. The 'file' pointer is
> + *      initialized to NULL, as the file has not been retrieved yet.
> + *   5. Adds the new 'struct luo_file' to the session's files_list.
> + *
> + * This prepares the session for userspace, which can later call
> + * luo_retrieve_file() to restore the actual file descriptors.
> + *
> + * Context: Called from session deserialization.
> + */
> +int luo_file_deserialize(struct luo_session *session)
> +{
> +	struct luo_file_ser *file_ser;
> +	u64 i;
> +
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!session->files)
> +		return 0;
> +
> +	file_ser = session->files;
> +	for (i = 0; i < session->count; i++) {
> +		struct liveupdate_file_handler *fh;
> +		bool handler_found = false;
> +		struct luo_file *luo_file;
> +
> +		list_for_each_entry(fh, &luo_file_handler_list, list) {
> +			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
> +				handler_found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!handler_found) {
> +			pr_warn("No registered handler for compatible '%s'\n",
> +				file_ser[i].compatible);
> +			return -ENOENT;
> +		}
> +
> +		luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> +		if (!luo_file)
> +			return -ENOMEM;

Shouldn't we free files allocated on the previous iterations?

> +
> +		luo_file->fh = fh;
> +		luo_file->file = NULL;
> +		luo_file->serialized_data = file_ser[i].data;
> +		luo_file->token = file_ser[i].token;
> +		luo_file->retrieved = false;
> +		mutex_init(&luo_file->mutex);
> +		list_add_tail(&luo_file->list, &session->files_list);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_register_file_handler - Register a file handler with LUO.
> + * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
> + * The caller must initialize this structure, including a unique
> + * 'compatible' string and a valid 'fh' callbacks. This function adds the
> + * handler to the global list of supported file handlers.
> + *
> + * Context: Typically called during module initialization for file types that
> + * support live update preservation.
> + *
> + * Return: 0 on success. Negative errno on failure.
> + */
> +int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> +{
> +	static DEFINE_MUTEX(register_file_handler_lock);
> +	struct liveupdate_file_handler *fh_iter;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Once sessions have been deserialized, file handlers cannot be
> +	 * registered, it is too late.
> +	 */
> +	if (WARN_ON(luo_session_is_deserialized()))
> +		return -EBUSY;
> +
> +	/* Sanity check that all required callbacks are set */
> +	if (!fh->ops->preserve || !fh->ops->unpreserve ||
> +	    !fh->ops->retrieve || !fh->ops->finish) {
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&register_file_handler_lock);
> +	list_for_each_entry(fh_iter, &luo_file_handler_list, list) {
> +		if (!strcmp(fh_iter->compatible, fh->compatible)) {
> +			pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
> +			       fh->compatible);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	if (!try_module_get(fh->ops->owner))
> +		return -EAGAIN;
> +
> +	INIT_LIST_HEAD(&fh->list);
> +	list_add_tail(&fh->list, &luo_file_handler_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> + * @s:      The outgoing liveupdate session.
> + * @file:   The file object to search for.
> + * @tokenp: Output parameter for the found token.
> + *
> + * Searches the list of preserved files in an outgoing session for a matching
> + * file object. If found, the corresponding user-provided token is returned.
> + *
> + * This function is intended for in-kernel callers that need to correlate a
> + * file with its liveupdate token.
> + *
> + * Context: Can be called from any context that can acquire the session mutex.
> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{

This function is apparently unused.

> +	struct luo_session *session = (struct luo_session *)s;
> +	struct luo_file *luo_file;
> +	int err = -ENOENT;
> +
> +	list_for_each_entry(luo_file, &session->files_list, list) {
> +		if (luo_file->file == file) {
> +			if (tokenp)
> +				*tokenp = luo_file->token;
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
> + * @s:      The incoming liveupdate session (restored from the previous kernel).
> + * @token:  The unique token identifying the file to retrieve.
> + * @filep:  On success, this will be populated with a pointer to the retrieved
> + *          'struct file'.
> + *
> + * Provides a kernel-internal API for other subsystems to retrieve their
> + * preserved files after a live update. This function is a simple wrapper
> + * around luo_retrieve_file(), allowing callers to find a file by its token.
> + *
> + * The operation is idempotent; subsequent calls for the same token will return
> + * a pointer to the same 'struct file' object.
> + *
> + * The caller receives a pointer to the file with a reference incremented. The
> + * file's lifetime is managed by LUO and any userspace file
> + * descriptors. If the caller needs to hold a reference to the file beyond the
> + * immediate scope, it must call get_file() itself.
> + *
> + * Context: Can be called from any context in the new kernel that has a handle
> + *          to a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{

Ditto.

> +	struct luo_session *session = (struct luo_session *)s;
> +
> +	return luo_retrieve_file(session, token, filep);
> +}
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 5185ad37a8c1..1a36f2383123 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -70,4 +70,13 @@ int luo_session_serialize(void);
>  int luo_session_deserialize(void);
>  bool luo_session_is_deserialized(void);
>  
> +int luo_preserve_file(struct luo_session *session, u64 token, int fd);
> +void luo_file_unpreserve_files(struct luo_session *session);
> +int luo_file_freeze(struct luo_session *session);
> +void luo_file_unfreeze(struct luo_session *session);
> +int luo_retrieve_file(struct luo_session *session, u64 token,
> +		      struct file **filep);
> +int luo_file_finish(struct luo_session *session);
> +int luo_file_deserialize(struct luo_session *session);
> +
>  #endif /* _LINUX_LUO_INTERNAL_H */
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

