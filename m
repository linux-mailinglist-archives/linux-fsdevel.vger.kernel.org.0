Return-Path: <linux-fsdevel+bounces-68760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A346C659D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0644E6369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF030F55F;
	Mon, 17 Nov 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Niy0HV4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81330B536
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401899; cv=none; b=PudWkEcDnm91DWFYIZ2LDRVhKnXY9v3vgm5uDz77qpeQD85BU2Ay8qATnTYd8WNd/6Ip/NGhBpYbchV/B/DUQakZ7Ua7Wq+dA2S63j5v/PDoVzKX5OVLEf5ePYVag4Ty1EJD3aV1jEK/rB4rzFHhYGsqOV6eAN/lgJj0PUV3hDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401899; c=relaxed/simple;
	bh=8DF+4C/KHKIZb8YvQ+azF37Prrek2thf+7UUIFGkAe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gODIxll1YTVenGEkXfZCfn5fq8hyeyTo2zPrRsd6sBREL1sGosZNVIOEPUww/djdh7y0Gi2oaunEI0KjE/4RxNNgsL6t7w/PVz29/yHekDDVhqmYT2Gt7YU+oefceNew8ML1hIU3eHegoAUE+nJifi3pjbGg6dnWhDynrEX5mLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Niy0HV4Y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so7945178a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763401895; x=1764006695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ5u5zAQrZvxKOnHLYhQ+3zTTB6OZn55imjBt83jNzg=;
        b=Niy0HV4YPvGgDsvrhM9ZVDwam6LpooWRWF5dNjTvrzVoYn6mVfOPwoBFoKyNzeQsam
         CU9VnPqFH/w5Ztmx7yEa7CtPDrWEBHPmLiNHAcKihS9h69RzrdJgGH5Y15nzAyh0PEMi
         ryLLZqon+7Ez/bmnxrEV2KsNtdW52iK5AAcQ+hek7r2Gi5tFuBTgEpaRM2+GwkkKJInT
         YgAqJcGcXIRaPJ00hL/48RxQV24ZlFppXqc1ZOFmbTkApCjsEvOw3JJCPBT0QJP5ho8x
         /dBwiJ5XErfSyYn+LJsWCWl28BFENizanjmspKPDBsJrXfQX7zhaz347q6wH64B4nrLa
         zV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401895; x=1764006695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ5u5zAQrZvxKOnHLYhQ+3zTTB6OZn55imjBt83jNzg=;
        b=wqtEWdOwkFNq2BWm0JYw/dn3+ApB6NeTxARE/Z5LIFT+v0ytEHqC5OoqQ4EU27coRv
         HWDuzC68pWGTW4wl1MQwSA5k1F+2OjlMDWWgF97D7BMUnh930k8IvsgEhC7FgV+w72ub
         rcfzWfQSlcSl3jCepfKgS9v4OgdKbr7sqUcMcoeDa6LQrSNk4Vr2EMDi/AjWaZvHuZT/
         0gwyw//YTcs4HxwXtxhEuIt9GIiBvPG2y393rSsvHXOQc+7lm6zLx3dKtXE8oSwjoVJy
         O7TlcLFP30GpbS56+JINKPmhAN2RyQkRQcQ5ehyFhUKjfbZ8s1gycLj+/Cemt4OS5mor
         F1nA==
X-Forwarded-Encrypted: i=1; AJvYcCW5PbyfAYfS3LLujswx247ijIcsih0dkNh3/wF6wPt+JPA/O+fH4dfeEo0JfNnTA0bohGj2cO/d9wwrcBFR@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJWXlT5n7CU0IOGJaqtTnlFOw2r41Y9aN8uYVhDQ6WixYfZf9
	9jbhLsfsno1WqOIb0wMc3Avt3eQa+iSBQr/L7we704/tF15tTmHPWJk2W8sl6d+U5ScyyUmNAWm
	tQM0dBMVO6pWWpEL2OS6U/zIW5YPJZj0EDhOgpzS4/A==
X-Gm-Gg: ASbGncsjb+3qq3s7g8qngadyPhcs3Bhx7PiDYOUgYBiz0mlBGOEV+twzsV+O0m0C/o2
	E4DhUe+D+oK6stv4UPbGV4605MrxY6t+Te8yUGa6QyiURpMsxreWtne1NaVstG+lQXVNkxDOJFS
	nSuPDflcOBd4ZsBGGDYAAR8cKwsLn05TmDDkVP9RbG1leSkqOFaOLxpwjt8qkekaWJswK8S9L78
	CYmx2vg1x5Y3FFK4gvyYjA3XphirHgtBztBmluFB9AWh0QgKRPsKpCPQ+UBjR/MfdTnWiIjhP+H
	c10=
X-Google-Smtp-Source: AGHT+IHWKPa8RlLwj37PNA19J6e01ZNweNYiCZnTEjR6fxpGB2x0/5L6XwywYOkv+w/5tLrlphKOMI4YXyOK0pqPXE4=
X-Received: by 2002:a05:6402:2711:b0:63b:f0b3:76cf with SMTP id
 4fb4d7f45d1cf-64350deef9cmr12478640a12.2.1763401894290; Mon, 17 Nov 2025
 09:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com> <aRoU1DSgVmplHr3E@kernel.org>
In-Reply-To: <aRoU1DSgVmplHr3E@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 12:50:56 -0500
X-Gm-Features: AWmQ_bnrA20HpXkHheTuEF5iGf_SPSz31rhUNAkUQn-Pm49ZR_gpF80LLM_gB3g
Message-ID: <CA+CK2bBFS754hdPfNAkMp_PqNpOB2nY02OkWbhRdoUiZ+ah=jw@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems callbacks
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +struct liveupdate_file_handler;
> > +struct liveupdate_session;
>
> Why struct liveupdate_session is a part of public LUO API?

It is an obscure version of private "struct luo_session", in order to
give subsystem access to:
liveupdate_get_file_incoming(s, token, filep)
liveupdate_get_token_outgoing(s, file, tokenp)

For example, if your FD depends on another FD within a session, you
can check if another FD is already preserved via
liveupdate_get_token_outgoing(), and during retrieval time you can
retrieve the "struct file" for your dependency.

> > +struct file;
> > +
> > +/**
> > + * struct liveupdate_file_op_args - Arguments for file operation callbacks.
> > + * @handler:          The file handler being called.
> > + * @session:          The session this file belongs to.
> > + * @retrieved:        The retrieve status for the 'can_finish / finish'
> > + *                    operation.
> > + * @file:             The file object. For retrieve: [OUT] The callback sets
> > + *                    this to the new file. For other ops: [IN] The caller sets
> > + *                    this to the file being operated on.
> > + * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
> > + *                    this field.
> > + *
> > + * This structure bundles all parameters for the file operation callbacks.
> > + * The 'data' and 'file' fields are used for both input and output.
> > + */
> > +struct liveupdate_file_op_args {
> > +     struct liveupdate_file_handler *handler;
> > +     struct liveupdate_session *session;
> > +     bool retrieved;
> > +     struct file *file;
> > +     u64 serialized_data;
> > +};
> > +
> > +/**
> > + * struct liveupdate_file_ops - Callbacks for live-updatable files.
> > + * @can_preserve: Required. Lightweight check to see if this handler is
> > + *                compatible with the given file.
> > + * @preserve:     Required. Performs state-saving for the file.
> > + * @unpreserve:   Required. Cleans up any resources allocated by @preserve.
> > + * @freeze:       Optional. Final actions just before kernel transition.
> > + * @unfreeze:     Optional. Undo freeze operations.
> > + * @retrieve:     Required. Restores the file in the new kernel.
> > + * @can_finish:   Optional. Check if this FD can finish, i.e. all restoration
> > + *                pre-requirements for this FD are satisfied. Called prior to
> > + *                finish, in order to do successful finish calls for all
> > + *                resources in the session.
> > + * @finish:       Required. Final cleanup in the new kernel.
> > + * @owner:        Module reference
> > + *
> > + * All operations (except can_preserve) receive a pointer to a
> > + * 'struct liveupdate_file_op_args' containing the necessary context.
> > + */
> > +struct liveupdate_file_ops {
> > +     bool (*can_preserve)(struct liveupdate_file_handler *handler,
> > +                          struct file *file);
> > +     int (*preserve)(struct liveupdate_file_op_args *args);
> > +     void (*unpreserve)(struct liveupdate_file_op_args *args);
> > +     int (*freeze)(struct liveupdate_file_op_args *args);
> > +     void (*unfreeze)(struct liveupdate_file_op_args *args);
> > +     int (*retrieve)(struct liveupdate_file_op_args *args);
> > +     bool (*can_finish)(struct liveupdate_file_op_args *args);
> > +     void (*finish)(struct liveupdate_file_op_args *args);
> > +     struct module *owner;
> > +};
> > +
> > +/**
> > + * struct liveupdate_file_handler - Represents a handler for a live-updatable file type.
> > + * @ops:                Callback functions
> > + * @compatible:         The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
> > + *                      that uniquely identifies the file type this handler
> > + *                      supports. This is matched against the compatible string
> > + *                      associated with individual &struct file instances.
> > + * @list:               Used for linking this handler instance into a global
> > + *                      list of registered file handlers.
> > + *
> > + * Modules that want to support live update for specific file types should
> > + * register an instance of this structure. LUO uses this registration to
> > + * determine if a given file can be preserved and to find the appropriate
> > + * operations to manage its state across the update.
> > + */
> > +struct liveupdate_file_handler {
> > +     const struct liveupdate_file_ops *ops;
> > +     const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
> > +     struct list_head list;
>
> Did you consider using __private and ACCESS_PRIVATE() for the ->list
> member here and in other structures visible outside kernel/liveupdate?

I hadn't considered it, but that is a great suggestion. I will update
the headers to use __private/ACCESS_PRIVATE().


> >
> > +/* The max size is set so it can be reliably used during in serialization */
>
> I failed to parse this comment.

Me too, I removed it. :-)

> > + *   - can_preserve(): A lightweight check to determine if the handler is
> > + *     compatible with a given 'struct file'.
> > + *   - preserve(): The heavyweight operation that saves the file's state and
> > + *     returns an opaque u64 handle, happens while vcpus are still running.
>
>                                                      ^ VCPUs

Done

>
> This narrows the description to VM-only usecase and in general ->preserve()
> may happen after VCPUs are suspended, although it's neither intended nor
> desirable. LUO does not control the sequencing so we can't claim here
> anything about VCPUs.

Agreed. While keeping VCPUs running is the target behavior for the
hypervisor use case to minimize downtime, the framework itself is
agnostic to the workload type and sequencing. Re-wrote:

 *   - preserve(): The heavyweight operation that saves the file's state and
 *     returns an opaque u64 handle. This is typically performed while the
 *     workload is still active to minimize the downtime during the
 *     actual reboot transition.

> > + *   - unpreserve(): Cleans up any resources allocated by .preserve(), called
> > + *     if the preservation process is aborted before the reboot (i.e. session is
> > + *     closed).
> > + *   - freeze(): A final pre-reboot opportunity to prepare the state for kexec.
> > + *     We are already in reboot syscall, and therefore userspace cannot mutate
> > + *     the file anymore.
> > + *   - unfreeze(): Undoes the actions of .freeze(), called if the live update
> > + *     is aborted after the freeze phase.
> > + *   - retrieve(): Reconstructs the file in the new kernel from the preserved
> > + *     handle.
> > + *   - finish(): Performs final check and cleanup in the new kernel. After
> > + *     succesul finish call, LUO gives up ownership to this file.
> > + *
> > + * File Preservation Lifecycle happy path:
> > + *
> > + * 1. Preserve (Normal Operation): A userspace agent preserves files one by one
> > + *    via an ioctl. For each file, luo_preserve_file() finds a compatible
> > + *    handler, calls its .preserve() op, and creates an internal &struct
>
>                                       ^ method or operation

Done

>
> > + *    luo_file to track the live state.
> > + *
> > + * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is called.
> > + *    It iterates through all preserved files, calls their respective .freeze()
> > + *    ops, and serializes their final metadata (compatible string, token, and
>
>         ^ method or operation
>
> > + *    data handle) into a contiguous memory block for KHO.
> > + *
> > + * 3. Deserialize (New Kernel - Early Boot): After kexec, luo_file_deserialize()
>
> From the code it seems that description runs on the fist open of
> /dev/liveupdated, what do I miss?

Updated:
 * 3. Deserialize: After kexec, luo_file_deserialize() runs when session gets
 *    deserialized (which is when /dev/liveupdate is first opened). It reads the
 *    serialized data from the KHO memory region and reconstructs the in-memory
 *    list of &struct luo_file instances for the new kernel, linking them to
 *    their corresponding handlers.

>
> > + *    runs. It reads the serialized data from the KHO memory region and
> > + *    reconstructs the in-memory list of &struct luo_file instances for the new
> > + *    kernel, linking them to their corresponding handlers.
> > + *
> > + * 4. Retrieve (New Kernel - Userspace Ready): The userspace agent can now
> > + *    restore file descriptors by providing a token. luo_retrieve_file()
> > + *    searches for the matching token, calls the handler's .retrieve() op to
> > + *    re-create the 'struct file', and returns a new FD. Files can be
> > + *    retrieved in ANY order.
> > + *
> > + * 5. Finish (New Kernel - Cleanup): Once a session retrival is complete,
> > + *    luo_file_finish() is called. It iterates through all files,
> > + *    invokes their .finish() ops for final cleanup, and releases all
>
>                                 ^ method

Done

>
> > + *    associated kernel resources.
> > + *
> > + * File Preservation Lifecycle unhappy paths:
> > + *
> > + * 1. Abort Before Reboot: If the userspace agent aborts the live update
> > + *    process before calling reboot (e.g., by closing the session file
> > + *    descriptor), the session's release handler calls
> > + *    luo_file_unpreserve_files(). This invokes the .unpreserve() callback on
> > + *    all preserved files, ensuring all allocated resources are cleaned up and
> > + *    returning the system to a clean state.
> > + *
> > + * 2. Freeze Failure: During the reboot() syscall, if any handler's .freeze()
> > + *    op fails, the .unfreeze() op is invoked on all previously *successful*
> > + *    freezes to roll back their state. The reboot() syscall then returns an
> > + *    error to userspace, canceling the live update.
> > + *
> > + * 3. Finish Failure: In the new kernel, if a handler's .finish() op fails,
> > + *    the luo_file_finish() operation is aborted. LUO retains ownership of
> > + *    all files within that session, including those that were not yet
> > + *    processed. The userspace agent can attempt to call the finish operation
> > + *    again later. If the issue cannot be resolved, these resources will be held
> > + *    by LUO until the next live update cycle, at which point they will be
> > + *    discarded.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <linux/kexec_handover.h>
> > +#include <linux/liveupdate.h>
> > +#include <linux/liveupdate/abi/luo.h>
> > +#include <linux/module.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include "luo_internal.h"
> > +
> > +static LIST_HEAD(luo_file_handler_list);
> > +
> > +/* 2 4K pages, give space for 128 files per session */
> > +#define LUO_FILE_PGCNT               2ul
> > +#define LUO_FILE_MAX                                                 \
> > +     ((LUO_FILE_PGCNT << PAGE_SHIFT) / sizeof(struct luo_file_ser))
> > +
> > +/**
> > + * struct luo_file - Represents a single preserved file instance.
> > + * @fh:            Pointer to the &struct liveupdate_file_handler that manages
> > + *                 this type of file.
> > + * @file:          Pointer to the kernel's &struct file that is being preserved.
> > + *                 This is NULL in the new kernel until the file is successfully
> > + *                 retrieved.
> > + * @serialized_data: The opaque u64 handle to the serialized state of the file.
> > + *                 This handle is passed back to the handler's .freeze(),
> > + *                 .retrieve(), and .finish() callbacks, allowing it to track
> > + *                 and update its serialized state across phases.
> > + * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
> > + *                 successfully called retrieve() on this file. This prevents
> > + *                 multiple retrieval attempts.
> > + * @mutex:         A mutex that protects the fields of this specific instance
> > + *                 (e.g., @retrieved, @file), ensuring that operations like
> > + *                 retrieving or finishing a file are atomic.
> > + * @list:          The list_head linking this instance into its parent
> > + *                 session's list of preserved files.
> > + * @token:         The user-provided unique token used to identify this file.
> > + *
> > + * This structure is the core in-kernel representation of a single file being
> > + * managed through a live update. An instance is created by luo_preserve_file()
> > + * to link a 'struct file' to its corresponding handler, a user-provided token,
> > + * and the serialized state handle returned by the handler's .preserve()
> > + * operation.
> > + *
> > + * These instances are tracked in a per-session list. The @serialized_data
> > + * field, which holds a handle to the file's serialized state, may be updated
> > + * during the .freeze() callback before being serialized for the next kernel.
> > + * After reboot, these structures are recreated by luo_file_deserialize() and
> > + * are finally cleaned up by luo_file_finish().
> > + */
> > +struct luo_file {
> > +     struct liveupdate_file_handler *fh;
> > +     struct file *file;
> > +     u64 serialized_data;
> > +     bool retrieved;
> > +     struct mutex mutex;
> > +     struct list_head list;
> > +     u64 token;
> > +};
> > +
> > +static int luo_session_alloc_files_mem(struct luo_session *session)
>
> It seems like this belongs to luo_session.c

It belongs here, but the name is wrong, so I renamed the alloc/free functions.

> > +{
> > +     size_t size;
> > +     void *mem;
> > +
> > +     if (session->files)
> > +             return 0;
> > +
> > +     WARN_ON_ONCE(session->count);
> > +
> > +     size = LUO_FILE_PGCNT << PAGE_SHIFT;
> > +     mem = kho_alloc_preserve(size);
> > +     if (IS_ERR(mem))
> > +             return PTR_ERR(mem);
> > +
> > +     session->files = mem;
> > +     session->pgcnt = LUO_FILE_PGCNT;
> > +
> > +     return 0;
> > +}
> > +
> > +static void luo_session_free_files_mem(struct luo_session *session)
> > +{
>
> Ditto

done.


>
> > +     /* If session has files, no need to free preservation memory */
> > +     if (session->count)
> > +             return;
> > +
> > +     if (!session->files)
> > +             return;
> > +
> > +     kho_unpreserve_free(session->files);
> > +     session->files = NULL;
> > +     session->pgcnt = 0;
> > +}
> > +
> > +static bool luo_token_is_used(struct luo_session *session, u64 token)
> > +{
> > +     struct luo_file *iter;
> > +
> > +     list_for_each_entry(iter, &session->files_list, list) {
>
> And here again I'm not very fond of dereferencing session objects in
> luo_file.

luo_file only access session->files_* fields, that are both allocated
and freed in luo_files, and iterated inside luo_file.

>
> > +             if (iter->token == token)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/**
> > + * luo_preserve_file - Initiate the preservation of a file descriptor.
> > + * @session: The session to which the preserved file will be added.
> > + * @token:   A unique, user-provided identifier for the file.
> > + * @fd:      The file descriptor to be preserved.
> > + *
> > + * This function orchestrates the first phase of preserving a file. Upon entry,
> > + * it takes a reference to the 'struct file' via fget(), effectively making LUO
> > + * a co-owner of the file. This reference is held until the file is either
> > + * unpreserved or successfully finished in the next kernel, preventing the file
> > + * from being prematurely destroyed.
> > + *
> > + * This function orchestrates the first phase of preserving a file. It performs
> > + * the following steps:
> > + *
> > + * 1. Validates that the @token is not already in use within the session.
> > + * 2. Ensures the session's memory for files serialization is allocated
> > + *    (allocates if needed).
> > + * 3. Iterates through registered handlers, calling can_preserve() to find one
> > + *    compatible with the given @fd.
> > + * 4. Calls the handler's .preserve() operation, which saves the file's state
> > + *    and returns an opaque private data handle.
> > + * 5. Adds the new instance to the session's internal list.
> > + *
> > + * On success, LUO takes a reference to the 'struct file' and considers it
> > + * under its management until it is unpreserved or finished.
> > + *
> > + * In case of any failure, all intermediate allocations (file reference, memory
> > + * for the 'luo_file' struct, etc.) are cleaned up before returning an error.
> > + *
> > + * Context: Can be called from an ioctl handler during normal system operation.
> > + * Return: 0 on success. Returns a negative errno on failure:
> > + *         -EEXIST if the token is already used.
> > + *         -EBADF if the file descriptor is invalid.
> > + *         -ENOSPC if the session is full.
> > + *         -ENOENT if no compatible handler is found.
> > + *         -ENOMEM on memory allocation failure.
> > + *         Other erros might be returned by .preserve().
> > + */
> > +int luo_preserve_file(struct luo_session *session, u64 token, int fd)
> > +{
> > +     struct liveupdate_file_op_args args = {0};
> > +     struct liveupdate_file_handler *fh;
> > +     struct luo_file *luo_file;
> > +     struct file *file;
> > +     int err;
> > +
> > +     lockdep_assert_held(&session->mutex);
> > +
> > +     if (luo_token_is_used(session, token))
> > +             return -EEXIST;
> > +
> > +     file = fget(fd);
> > +     if (!file)
> > +             return -EBADF;
> > +
> > +     err = luo_session_alloc_files_mem(session);
> > +     if (err)
> > +             goto  exit_err;
> > +
> > +     if (session->count == LUO_FILE_MAX) {
> > +             err = -ENOSPC;
> > +             goto exit_err;
> > +     }
>
> I believe session can be prepared and vailidated by the caller.

Size of luo_files, and other file count related limitations all belong
luo_file.c

>
> > +
> > +     err = -ENOENT;
> > +     list_for_each_entry(fh, &luo_file_handler_list, list) {
> > +             if (fh->ops->can_preserve(fh, file)) {
> > +                     err = 0;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     /* err is still -ENOENT if no handler was found */
> > +     if (err)
> > +             goto exit_err;
> > +
> > +     luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > +     if (!luo_file) {
> > +             err = -ENOMEM;
> > +             goto exit_err;
> > +     }
> > +
> > +     luo_file->file = file;
> > +     luo_file->fh = fh;
> > +     luo_file->token = token;
> > +     luo_file->retrieved = false;
> > +     mutex_init(&luo_file->mutex);
> > +
> > +     args.handler = fh;
> > +     args.session = (struct liveupdate_session *)session;
>
> Isn't args.session already struct liveupdate_session *?

This casts (struct luo_session *) to obscure public (struct
liveupdate_session *).

>
> > +     args.file = file;
> > +     err = fh->ops->preserve(&args);
> > +     if (err) {
> > +             mutex_destroy(&luo_file->mutex);
> > +             kfree(luo_file);
> > +             goto exit_err;
> > +     } else {
> > +             luo_file->serialized_data = args.serialized_data;
> > +             list_add_tail(&luo_file->list, &session->files_list);
> > +             session->count++;
>
> I'd use luo_session_add_file(struct luo_file *luo_file) or return luo_file
> by reference to the caller.
> Than the lockdep_assert_held() can go away as well.

Let's keep this, I do not think, there is any architectural win from
disallowing luo_file from insert itself directly into a session, both
a part of luo_*
luo_session does not manage anything files related: no
serialization/deserialization, no allocations/free, no
insertion/removal.

>
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_err:
> > +     fput(file);
> > +     luo_session_free_files_mem(session);
>
> The error handling in this function is a mess. Pasha, please, please, use
> goto consistently.

How is this a mess? There is a single exit_err destination, no
exception, no early returns except at the very top of the function
where we do early returns before fget() which makes total sense.

Do you want to add a separate destination for
luo_session_free_files_mem() ? But that is not necessary, in many
places it is considered totally reasonable for free(NULL) to work
correctly...

> > +
> > +     return err;
> > +}
> > +
> > +/**
> > + * luo_file_unpreserve_files - Unpreserves all files from a session.
> > + * @session: The session to be cleaned up.
> > + *
> > + * This function serves as the primary cleanup path for a session. It is
> > + * invoked when the userspace agent closes the session's file descriptor.
> > + *
> > + * For each file, it performs the following cleanup actions:
> > + *   1. Calls the handler's .unpreserve() callback to allow the handler to
> > + *      release any resources it allocated.
> > + *   2. Removes the file from the session's internal tracking list.
> > + *   3. Releases the reference to the 'struct file' that was taken by
> > + *      luo_preserve_file() via fput(), returning ownership.
> > + *   4. Frees the memory associated with the internal 'struct luo_file'.
> > + *
> > + * After all individual files are unpreserved, it frees the contiguous memory
> > + * block that was allocated to hold their serialization data.
> > + */
> > +void luo_file_unpreserve_files(struct luo_session *session)
> > +{
> > +     struct luo_file *luo_file;
> > +
> > +     lockdep_assert_held(&session->mutex);
> > +
> > +     while (!list_empty(&session->files_list)) {
>
> I think the loop should be in luo_session.c and luo_files.c should
> implement luo_file_unpreserve(struct luo_file *luo_file)
>
> The same applies to other functions below that do something with all files
> in the session. In my view luo_session should iterate through
> luo_session.files_list and call luo_file methods for each luo_file object.

Let's not do that, files within a session related operations belong to
file, sessions within LUO related operations belong to luo_session

> > +int luo_file_freeze(struct luo_session *session)
> > +{
> > +     struct luo_file_ser *file_ser = session->files;
> > +     struct luo_file *luo_file;
> > +     int err;
> > +     int i;
> > +
> > +     lockdep_assert_held(&session->mutex);
> > +
> > +     if (!session->count)
> > +             return 0;
> > +
> > +     if (WARN_ON(!file_ser))
> > +             return -EINVAL;
> > +
> > +     i = 0;
> > +     list_for_each_entry(luo_file, &session->files_list, list) {
> > +             err = luo_file_freeze_one(session, luo_file);
> > +             if (err < 0) {
> > +                     pr_warn("Freeze failed for session[%s] token[%#0llx] handler[%s] err[%pe]\n",
> > +                             session->name, luo_file->token,
> > +                             luo_file->fh->compatible, ERR_PTR(err));
> > +                     goto exit_err;
> > +             }
> > +
> > +             strscpy(file_ser[i].compatible, luo_file->fh->compatible,
> > +                     sizeof(file_ser[i].compatible));
> > +             file_ser[i].data = luo_file->serialized_data;
> > +             file_ser[i].token = luo_file->token;
> > +             i++;
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_err:
> > +     __luo_file_unfreeze(session, luo_file);
>
> Maybe move frozen files to a local list, call __luo_file_unfreeze() with
> that list and than splice it back to session.files_list?

IMO, it would add unnecessary complications. session is locked,
session->files_list is all under our control, no need to add
complications with private list.

> > +             luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > +             if (!luo_file)
> > +                     return -ENOMEM;
>
> Shouldn't we free files allocated on the previous iterations?

No, for the same reason explained in luo_session.c :-)

>
> > +
> > +             luo_file->fh = fh;
> > +             luo_file->file = NULL;
> > +             luo_file->serialized_data = file_ser[i].data;
> > +             luo_file->token = file_ser[i].token;
> > +             luo_file->retrieved = false;
> > +             mutex_init(&luo_file->mutex);
> > +             list_add_tail(&luo_file->list, &session->files_list);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * liveupdate_register_file_handler - Register a file handler with LUO.
> > + * @fh: Pointer to a caller-allocated &struct liveupdate_file_handler.
> > + * The caller must initialize this structure, including a unique
> > + * 'compatible' string and a valid 'fh' callbacks. This function adds the
> > + * handler to the global list of supported file handlers.
> > + *
> > + * Context: Typically called during module initialization for file types that
> > + * support live update preservation.
> > + *
> > + * Return: 0 on success. Negative errno on failure.
> > + */
> > +int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> > +{
> > +     static DEFINE_MUTEX(register_file_handler_lock);
> > +     struct liveupdate_file_handler *fh_iter;
> > +
> > +     if (!liveupdate_enabled())
> > +             return -EOPNOTSUPP;
> > +
> > +     /*
> > +      * Once sessions have been deserialized, file handlers cannot be
> > +      * registered, it is too late.
> > +      */
> > +     if (WARN_ON(luo_session_is_deserialized()))
> > +             return -EBUSY;
> > +
> > +     /* Sanity check that all required callbacks are set */
> > +     if (!fh->ops->preserve || !fh->ops->unpreserve ||
> > +         !fh->ops->retrieve || !fh->ops->finish) {
> > +             return -EINVAL;
> > +     }
> > +
> > +     guard(mutex)(&register_file_handler_lock);
> > +     list_for_each_entry(fh_iter, &luo_file_handler_list, list) {
> > +             if (!strcmp(fh_iter->compatible, fh->compatible)) {
> > +                     pr_err("File handler registration failed: Compatible string '%s' already registered.\n",
> > +                            fh->compatible);
> > +                     return -EEXIST;
> > +             }
> > +     }
> > +
> > +     if (!try_module_get(fh->ops->owner))
> > +             return -EAGAIN;
> > +
> > +     INIT_LIST_HEAD(&fh->list);
> > +     list_add_tail(&fh->list, &luo_file_handler_list);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> > + * @s:      The outgoing liveupdate session.
> > + * @file:   The file object to search for.
> > + * @tokenp: Output parameter for the found token.
> > + *
> > + * Searches the list of preserved files in an outgoing session for a matching
> > + * file object. If found, the corresponding user-provided token is returned.
> > + *
> > + * This function is intended for in-kernel callers that need to correlate a
> > + * file with its liveupdate token.
> > + *
> > + * Context: Can be called from any context that can acquire the session mutex.
> > + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
> > + */
> > +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> > +                               struct file *file, u64 *tokenp)
> > +{
>
> This function is apparently unused.
>
> > +     struct luo_session *session = (struct luo_session *)s;
> > +     struct luo_file *luo_file;
> > +     int err = -ENOENT;
> > +
> > +     list_for_each_entry(luo_file, &session->files_list, list) {
> > +             if (luo_file->file == file) {
> > +                     if (tokenp)
> > +                             *tokenp = luo_file->token;
> > +                     err = 0;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +/**
> > + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
> > + * @s:      The incoming liveupdate session (restored from the previous kernel).
> > + * @token:  The unique token identifying the file to retrieve.
> > + * @filep:  On success, this will be populated with a pointer to the retrieved
> > + *          'struct file'.
> > + *
> > + * Provides a kernel-internal API for other subsystems to retrieve their
> > + * preserved files after a live update. This function is a simple wrapper
> > + * around luo_retrieve_file(), allowing callers to find a file by its token.
> > + *
> > + * The operation is idempotent; subsequent calls for the same token will return
> > + * a pointer to the same 'struct file' object.
> > + *
> > + * The caller receives a pointer to the file with a reference incremented. The
> > + * file's lifetime is managed by LUO and any userspace file
> > + * descriptors. If the caller needs to hold a reference to the file beyond the
> > + * immediate scope, it must call get_file() itself.
> > + *
> > + * Context: Can be called from any context in the new kernel that has a handle
> > + *          to a restored session.
> > + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> > + *         found, or any other negative errno on failure.
> > + */
> > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> > +                              struct file **filep)
> > +{
>
> Ditto.

These two functions are part of the public API allowing dependency
tracking for vfio->iommu->memfd during preservation.

>
> > +     struct luo_session *session = (struct luo_session *)s;
> > +
> > +     return luo_retrieve_file(session, token, filep);
> > +}
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> > index 5185ad37a8c1..1a36f2383123 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -70,4 +70,13 @@ int luo_session_serialize(void);
> >  int luo_session_deserialize(void);
> >  bool luo_session_is_deserialized(void);
> >
> > +int luo_preserve_file(struct luo_session *session, u64 token, int fd);
> > +void luo_file_unpreserve_files(struct luo_session *session);
> > +int luo_file_freeze(struct luo_session *session);
> > +void luo_file_unfreeze(struct luo_session *session);
> > +int luo_retrieve_file(struct luo_session *session, u64 token,
> > +                   struct file **filep);
> > +int luo_file_finish(struct luo_session *session);
> > +int luo_file_deserialize(struct luo_session *session);
> > +
> >  #endif /* _LINUX_LUO_INTERNAL_H */
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> --
> Sincerely yours,
> Mike.

