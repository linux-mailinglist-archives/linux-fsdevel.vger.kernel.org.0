Return-Path: <linux-fsdevel+bounces-68693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88618C63409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B734128BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF832939C;
	Mon, 17 Nov 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrIcBjkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C3328B63;
	Mon, 17 Nov 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372383; cv=none; b=k/jOcj1kRq++sWF2V1Z0lK/xLWx9+jbpAHFg9UDRO5z6JTmH07WZ3/x+oQpYzlEil+UiPBJURnHkd6M8tWh35JRROFtQ+NkiCrepK/XhjoR1XbPMuACYDbT3CiL/Kl7I0A6oMYCR+83hb6ggIpuwpYyr+/lu8NE+TZPnFHLBY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372383; c=relaxed/simple;
	bh=MueF4AgwT93dApePMMTWoYsPIe8Jukq3D2A3XYfg2mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1h5zKFHThgFfRKi9dj43VbFheRC31THwMHDwTkwae7UDqArbtvHHuGUsHmx0hSWgMgZQ6puQ2Vw8uLewcokyzBWqKYbsBAub1T9eOKhBBC5ZQNNvvLHEqkS5fodw11UL0X+7h8XvR9Lr0lQpvTcqfxmkDVP0vnOUtEpqssVbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrIcBjkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41A8C4CEF5;
	Mon, 17 Nov 2025 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372383;
	bh=MueF4AgwT93dApePMMTWoYsPIe8Jukq3D2A3XYfg2mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrIcBjknGsBFyF62JCtHoJY3dAG2Ln2SAikRzI11A3XlsD6lsGRXvqSfFwWWtK3MF
	 jVeMd4xHNYU5FQYXyJTBawhoCDnBoHVZRnk3ONkOYPQcc14xghwDicmJdEbRv54HL2
	 hfDuxsODEfXAHlUf7l4qhxUXT7kbgUjKA6zjub9wZXXbozuCBWjVEsAUfsBrfVOkuI
	 dtvXTg9fEj57GfoAafCoeA3Rw1iQRf0AQ/4Hk9pqGraPC8FG5JB75HvFNTSMcRA+sK
	 qYrEdZyA5gn0XRsdpf9P6AMOQZ/BD3eZzSCZcaRkP9WcPE8lOrU/w8NIKCtdsjzTID
	 wzcGaQDTnfO+A==
Date: Mon, 17 Nov 2025 11:39:17 +0200
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
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
Message-ID: <aRrtRfJaaIHw5DZN@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-9-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:54PM -0500, Pasha Tatashin wrote:
> Introduce a mechanism for managing global kernel state whose lifecycle
> is tied to the preservation of one or more files. This is necessary for
> subsystems where multiple preserved file descriptors depend on a single,
> shared underlying resource.
> 
> An example is HugeTLB, where multiple file descriptors such as memfd and
> guest_memfd may rely on the state of a single HugeTLB subsystem.
> Preserving this state for each individual file would be redundant and
> incorrect. The state should be preserved only once when the first file
> is preserved, and restored/finished only once the last file is handled.
> 
> This patch introduces File-Lifecycle-Bound (FLB) objects to solve this
> problem. An FLB is a global, reference-counted object with a defined set
> of operations:
> 
> - A file handler (struct liveupdate_file_handler) declares a dependency
>   on one or more FLBs via a new registration function,
>   liveupdate_register_flb().
> - When the first file depending on an FLB is preserved, the FLB's
>   .preserve() callback is invoked to save the shared global state. The
>   reference count is then incremented for each subsequent file.
> - Conversely, when the last file is unpreserved (before reboot) or
>   finished (after reboot), the FLB's .unpreserve() or .finish() callback
>   is invoked to clean up the global resource.
> 
> The implementation includes:
> 
> - A new set of ABI definitions (luo_flb_ser, luo_flb_head_ser) and a
>   corresponding FDT node (luo-flb) to serialize the state of all active
>   FLBs and pass them via Kexec Handover.
> - Core logic in luo_flb.c to manage FLB registration, reference
>   counting, and the invocation of lifecycle callbacks.
> - An API (liveupdate_flb_*_locked/*_unlock) for other kernel subsystems
>   to safely access the live object managed by an FLB, both before and
>   after the live update.
> 
> This framework provides the necessary infrastructure for more complex
> subsystems like IOMMU, VFIO, and KVM to integrate with the Live Update
> Orchestrator.

The concept makes sense to me, but it's hard to review the implementation
without an actual user.
 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate.h         | 116 +++++
>  include/linux/liveupdate/abi/luo.h |  76 ++++
>  kernel/liveupdate/Makefile         |   1 +
>  kernel/liveupdate/luo_core.c       |   7 +-
>  kernel/liveupdate/luo_file.c       |   8 +
>  kernel/liveupdate/luo_flb.c        | 658 +++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h   |   7 +
>  7 files changed, 872 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_flb.c
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 4a5d4dd9905a..36a831ae3ead 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -14,6 +14,7 @@
>  #include <uapi/linux/liveupdate.h>
>  
>  struct liveupdate_file_handler;
> +struct liveupdate_flb;
>  struct liveupdate_session;
>  struct file;
>  
> @@ -81,6 +82,7 @@ struct liveupdate_file_ops {
>   *                      associated with individual &struct file instances.
>   * @list:               Used for linking this handler instance into a global
>   *                      list of registered file handlers.
> + * @flb_list:           A list of FLB dependencies.
>   *
>   * Modules that want to support live update for specific file types should
>   * register an instance of this structure. LUO uses this registration to
> @@ -91,6 +93,80 @@ struct liveupdate_file_handler {
>  	const struct liveupdate_file_ops *ops;
>  	const char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
>  	struct list_head list;
> +	struct list_head flb_list;
> +};
> +
> +/**
> + * struct liveupdate_flb_op_args - Arguments for FLB operation callbacks.
> + * @flb:       The global FLB instance for which this call is performed.
> + * @data:      For .preserve():    [OUT] The callback sets this field.
> + *             For .unpreserve():  [IN]  The handle from .preserve().
> + *             For .retrieve():    [IN]  The handle from .preserve().
> + * @obj:       For .preserve():    [OUT] Sets this to the live object.
> + *             For .retrieve():    [OUT] Sets this to the live object.
> + *             For .finish():      [IN]  The live object from .retrieve().
> + *
> + * This structure bundles all parameters for the FLB operation callbacks.
> + */
> +struct liveupdate_flb_op_args {
> +	struct liveupdate_flb *flb;
> +	u64 data;
> +	void *obj;
> +};
> +
> +/**
> + * struct liveupdate_flb_ops - Callbacks for global File-Lifecycle-Bound data.
> + * @preserve:        Called when the first file using this FLB is preserved.
> + *                   The callback must save its state and return a single,
> + *                   self-contained u64 handle by setting the 'argp->data'
> + *                   field and 'argp->obj'.
> + * @unpreserve:      Called when the last file using this FLB is unpreserved
> + *                   (aborted before reboot). Receives the handle via
> + *                   'argp->data' and live object via 'argp->obj'.
> + * @retrieve:        Called on-demand in the new kernel, the first time a
> + *                   component requests access to the shared object. It receives
> + *                   the preserved handle via 'argp->data' and must reconstruct
> + *                   the live object, returning it by setting the 'argp->obj'
> + *                   field.
> + * @finish:          Called in the new kernel when the last file using this FLB
> + *                   is finished. Receives the live object via 'argp->obj' for
> + *                   cleanup.
> + * @owner:           Module reference
> + *
> + * Operations that manage global shared data with file bound lifecycle,
> + * triggered by the first file that uses it and concluded by the last file that
> + * uses it, across all sessions.
> + */
> +struct liveupdate_flb_ops {
> +	int (*preserve)(struct liveupdate_flb_op_args *argp);
> +	void (*unpreserve)(struct liveupdate_flb_op_args *argp);
> +	int (*retrieve)(struct liveupdate_flb_op_args *argp);
> +	void (*finish)(struct liveupdate_flb_op_args *argp);
> +	struct module *owner;
> +};
> +
> +/**
> + * struct liveupdate_flb - A global definition for a shared data object.
> + * @ops:         Callback functions
> + * @compatible:  The compatibility string (e.g., "iommu-core-v1"
> + *               that uniquely identifies the FLB type this handler
> + *               supports. This is matched against the compatible string
> + *               associated with individual &struct liveupdate_flb
> + *               instances.
> + * @list:        A global list of registered FLBs.
> + * @internal:    Internal state, set in liveupdate_init_flb().
> + *
> + * This struct is the "template" that a driver registers to define a shared,
> + * file-lifecycle-bound object. The actual runtime state (the live object,
> + * refcount, etc.) is managed internally by the LUO core.
> + * Use liveupdate_init_flb() to initialize this struct before using it in
> + * other functions.
> + */
> +struct liveupdate_flb {
> +	const struct liveupdate_flb_ops *ops;
> +	const char compatible[LIVEUPDATE_FLB_COMPAT_LENGTH];
> +	struct list_head list;
> +	void *internal;

Can't list be a part of internal?
And don't we usually call this .private rather than .internal?

>  };
>  
>  #ifdef CONFIG_LIVEUPDATE
> @@ -111,6 +187,17 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>  int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>  				  struct file *file, u64 *tokenp);
>  
> +/* Before using FLB for the first time it should be initialized */
> +int liveupdate_init_flb(struct liveupdate_flb *flb);
> +
> +int liveupdate_register_flb(struct liveupdate_file_handler *h,
> +			    struct liveupdate_flb *flb);

While these are obvious ...

> +
> +int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp);
> +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj);
> +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp);
> +void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj);
> +

... it's not very clear what these APIs are for and how they are going to be
used.

>  #else /* CONFIG_LIVEUPDATE */
  
...

> +int liveupdate_register_flb(struct liveupdate_file_handler *h,
> +			    struct liveupdate_flb *flb)
> +{
> +	struct luo_flb_internal *internal = flb->internal;
> +	struct luo_flb_link *link __free(kfree) = NULL;
> +	static DEFINE_MUTEX(register_flb_lock);
> +	struct liveupdate_flb *gflb;
> +	struct luo_flb_link *iter;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (WARN_ON(!h || !flb || !internal))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!flb->ops->preserve || !flb->ops->unpreserve ||
> +		    !flb->ops->retrieve || !flb->ops->finish)) {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Once session/files have been deserialized, FLBs cannot be registered,
> +	 * it is too late. Deserialization uses file handlers, and FLB registers
> +	 * to file handlers.
> +	 */
> +	if (WARN_ON(luo_session_is_deserialized()))
> +		return -EBUSY;
> +
> +	/*
> +	 * File handler must already be registered, as it is initializes the
> +	 * flb_list
> +	 */
> +	if (WARN_ON(list_empty(&h->list)))
> +		return -EINVAL;
> +
> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&register_flb_lock);
> +
> +	/* Check that this FLB is not already linked to this file handler */
> +	list_for_each_entry(iter, &h->flb_list, list) {
> +		if (iter->flb == flb)
> +			return -EEXIST;
> +	}
> +
> +	/* Is this FLB linked to global list ? */

Maybe:

	/*
	 * If this FLB is not linked to global list it's first time the FLB
	 * is registered
	 */

> +	if (list_empty(&flb->list)) {
> +		if (luo_flb_global.count == LUO_FLB_MAX)
> +			return -ENOSPC;
> +
> +		/* Check that compatible string is unique in global list */
> +		list_for_each_entry(gflb, &luo_flb_global.list, list) {
> +			if (!strcmp(gflb->compatible, flb->compatible))
> +				return -EEXIST;
> +		}
> +
> +		if (!try_module_get(flb->ops->owner))
> +			return -EAGAIN;
> +
> +		list_add_tail(&flb->list, &luo_flb_global.list);
> +		luo_flb_global.count++;
> +	}
> +
> +	/* Finally, link the FLB to the file handler */
> +	link->flb = flb;
> +	list_add_tail(&no_free_ptr(link)->list, &h->flb_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_flb_incoming_locked - Lock and retrieve the incoming FLB object.
> + * @flb:  The FLB definition.
> + * @objp: Output parameter; will be populated with the live shared object.
> + *
> + * Acquires the FLB's internal lock and returns a pointer to its shared live
> + * object for the incoming (post-reboot) path.
> + *
> + * If this is the first time the object is requested in the new kernel, this
> + * function will trigger the FLB's .retrieve() callback to reconstruct the
> + * object from its preserved state. Subsequent calls will return the same
> + * cached object.
> + *
> + * The caller MUST call liveupdate_flb_incoming_unlock() to release the lock.
> + *
> + * Return: 0 on success, or a negative errno on failure. -ENODATA means no
> + * incoming FLB data, -ENOENT means specific flb not found in the incoming
> + * data, and -EOPNOTSUPP when live update is disabled or not configured.
> + */
> +int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp)
> +{
> +	struct luo_flb_internal *internal = flb->internal;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (WARN_ON(!internal))
> +		return -EINVAL;
> +
> +	if (!internal->incoming.obj) {
> +		int err = luo_flb_retrieve_one(flb);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	mutex_lock(&internal->incoming.lock);
> +	*objp = internal->incoming.obj;
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_flb_incoming_unlock - Unlock an incoming FLB object.
> + * @flb: The FLB definition.
> + * @obj: The object that was returned by the _locked call (used for validation).
> + *
> + * Releases the internal lock acquired by liveupdate_flb_incoming_locked().
> + */
> +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj)
> +{
> +	struct luo_flb_internal *internal = flb->internal;
> +
> +	lockdep_assert_held(&internal->incoming.lock);
> +	internal->incoming.obj = obj;

The comment says obj is for validation and here it's assigned to flb.
Something is off here :)

> +	mutex_unlock(&internal->incoming.lock);
> +}
> +
> +/**
> + * liveupdate_flb_outgoing_locked - Lock and retrieve the outgoing FLB object.
> + * @flb:  The FLB definition.
> + * @objp: Output parameter; will be populated with the live shared object.
> + *
> + * Acquires the FLB's internal lock and returns a pointer to its shared live
> + * object for the outgoing (pre-reboot) path.
> + *
> + * This function assumes the object has already been created by the FLB's
> + * .preserve() callback, which is triggered when the first dependent file
> + * is preserved.
> + *
> + * The caller MUST call liveupdate_flb_outgoing_unlock() to release the lock.
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp)
> +{
> +	struct luo_flb_internal *internal = flb->internal;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (WARN_ON(!internal))
> +		return -EINVAL;
> +
> +	mutex_lock(&internal->outgoing.lock);
> +
> +	/* The object must exist if any file is being preserved */
> +	if (WARN_ON_ONCE(!internal->outgoing.obj)) {
> +		mutex_unlock(&internal->outgoing.lock);
> +		return -ENOENT;
> +	}

_incoming_locked() and outgoing_locked() are nearly identical, it seems we
can have the common part in a 
static liveupdate_flb_locked(struct luo_flb_state *state).

liveupdate_flb_incoming_locked() will be oneline wrapper and
liveupdate_flb_outgoing_locked() will have this WARN_ON if obj is NULL.

> +
> +	*objp = internal->outgoing.obj;
> +
> +	return 0;
> +}
> +
> +/**
> + * liveupdate_flb_outgoing_unlock - Unlock an outgoing FLB object.
> + * @flb: The FLB definition.
> + * @obj: The object that was returned by the _locked call (used for validation).
> + *
> + * Releases the internal lock acquired by liveupdate_flb_outgoing_locked().
> + */
> +void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj)
> +{
> +	struct luo_flb_internal *internal = flb->internal;
> +
> +	lockdep_assert_held(&internal->outgoing.lock);
> +	internal->outgoing.obj = obj;

So it is assignment or validation? ;-)

This one is a copy of liveupdate_flb_incoming_unlock(), 

> +	mutex_unlock(&internal->outgoing.lock);
> +}
> +

-- 
Sincerely yours,
Mike.

