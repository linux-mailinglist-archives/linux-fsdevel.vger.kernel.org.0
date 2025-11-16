Return-Path: <linux-fsdevel+bounces-68614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88AC618EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 18:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D0E4EBBCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDD30CD91;
	Sun, 16 Nov 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FULWZXYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAC2F5B;
	Sun, 16 Nov 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763312783; cv=none; b=QFi5oX9og4T/TqwMhdFIKuca8DTjIJXwSjpYm5hB9uafWDyUi69OCzZAlKr7H2cZ5MtbSWHzxFbQOF5HzS2K+VtpmaOh3eSqYUS29nu3Rh0zkG6guZHDum8nR2rhtRo5NHnkrUOHO3aYazC8v95alxQWBmCcfCybEJJwToird/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763312783; c=relaxed/simple;
	bh=sE5PAkx03kSWVxfn6P/KcKgNoFqgW26StGDSttnoICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGlIo3c42t9dXropnhcRjEV/WTPNNAuYxe8S91/bapQ8D6dbC5b+nKpe+SyG1WsqeSr6WxQMBShtiAOn0vZ5G94okvJyjgiEwRBSXrwKnfjA+2hMKWURGMHxf8sDiLp/BGM8BCHpYuEcSmuFf6PXkWYsiU8+G42o7auliy7Wyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FULWZXYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8822C4CEFB;
	Sun, 16 Nov 2025 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763312783;
	bh=sE5PAkx03kSWVxfn6P/KcKgNoFqgW26StGDSttnoICA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FULWZXYEYNfsWVuphzDEmuHpZCY7ou6y7Z8MsRuLjfoJVtckvvtAsAIwpYVhm6PR4
	 nJGXcMRZ9wnTVfBToQ6bQgbDhSmeahEcv8PJpTfmJ/ajABcYPPJLJjTvzOnPhwakFC
	 2UsHX2XgerJB5RoR3lRx8r2krOXsIbuoOGq4cChptjXfzXbB+Mtc3AF3RtKZnIXFUw
	 +RJKlQbSHDF7u+k47gqrdq50JXRjaE/K54OKknbiCOHrR4MB00n9ur7qCJ/H01t9sv
	 78sKtPik2J136oJlb9SguRGKwaoeB8RpY2vgEd8LgIgtdMn1Ln2y6jOOe6HiC+lo5w
	 jMu29QI/z5xEQ==
Date: Sun, 16 Nov 2025 19:05:58 +0200
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
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
Message-ID: <aRoEduya5EO8Xc1b@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-5-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:50PM -0500, Pasha Tatashin wrote:
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
>  include/linux/liveupdate/abi/luo.h |  83 +++++-
>  include/uapi/linux/liveupdate.h    |   3 +
>  kernel/liveupdate/Makefile         |   3 +-
>  kernel/liveupdate/luo_core.c       |  10 +
>  kernel/liveupdate/luo_internal.h   |  52 ++++
>  kernel/liveupdate/luo_session.c    | 421 +++++++++++++++++++++++++++++
>  6 files changed, 570 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/liveupdate/luo_internal.h
>  create mode 100644 kernel/liveupdate/luo_session.c

...

> +/**
> + * struct luo_session_ser - Represents the serialized metadata for a LUO session.
> + * @name:    The unique name of the session, copied from the `luo_session`
> + *           structure.

I'd phase it as

		The unique name of the session provided by the userspace at
		the time of session creation.

> + * @files:   The physical address of a contiguous memory block that holds
> + *           the serialized state of files.

Maybe add                                    ^ in this session?

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

This comment applies to the luo_session_header_ser description as well.

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

You decided not to bump it to 64 in the end? ;-)

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

...

> +int luo_session_retrieve(const char *name, struct file **filep)
> +{
> +	struct luo_session_header *sh = &luo_session_global.incoming;
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

Retaking the mutex here seems a bit odd. 
Do we really have to lock session->mutex in luo_session_getfile()?

> +	}
> +
> +	return err;
> +}

...

> +int __init luo_session_setup_incoming(void *fdt_in)
> +{
> +	struct luo_session_header_ser *header_ser;
> +	int err, header_size, offset;
> +	u64 header_ser_pa;
> +	const void *ptr;
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
> +		pr_err("Session node incompatible [%s]\n",
> +		       LUO_FDT_SESSION_COMPATIBLE);
> +		return -EINVAL;
> +	}
> +
> +	header_size = 0;
> +	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_SESSION_HEADER, &header_size);
> +	if (!ptr || header_size != sizeof(u64)) {
> +		pr_err("Unable to get session header '%s' [%d]\n",
> +		       LUO_FDT_SESSION_HEADER, header_size);
> +		return -EINVAL;
> +	}
> +
> +	header_ser_pa = get_unaligned((u64 *)ptr);
> +	header_ser = phys_to_virt(header_ser_pa);
> +
> +	luo_session_global.incoming.header_ser = header_ser;
> +	luo_session_global.incoming.ser = (void *)(header_ser + 1);
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
> +	struct luo_session_header *sh = &luo_session_global.incoming;
> +	int err;
> +
> +	if (luo_session_is_deserialized())
> +		return 0;
> +
> +	luo_session_global.deserialized = true;
> +	if (!sh->active) {
> +		INIT_LIST_HEAD(&sh->list);
> +		init_rwsem(&sh->rwsem);
> +		return 0;

How this can happen? luo_session_deserialize() is supposed to be called
from ioctl and luo_session_global.incoming should be set up way earlier.

And, why don't we initialize ->list and ->rwsem statically?

> +	}
> +
> +	for (int i = 0; i < sh->header_ser->count; i++) {
> +		struct luo_session *session;
> +
> +		session = luo_session_alloc(sh->ser[i].name);
> +		if (IS_ERR(session)) {
> +			pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
> +				sh->ser[i].name, session);
> +			return PTR_ERR(session);
> +		}

The allocated sessions still need to be freed if an insert fails ;-)

> +
> +		err = luo_session_insert(sh, session); 
> +		if (err) {
> +			luo_session_free(session);
> +			pr_warn("Failed to insert session [%s] %pe\n",
> +				session->name, ERR_PTR(err));
> +			return err;
> +		}
> +
> +		session->count = sh->ser[i].count;
> +		session->files = sh->ser[i].files ? phys_to_virt(sh->ser[i].files) : 0;
> +		session->pgcnt = sh->ser[i].pgcnt;
> +	}
> +
> +	kho_restore_free(sh->header_ser);
> +	sh->header_ser = NULL;
> +	sh->ser = NULL;
> +
> +	return 0;
> +}

-- 
Sincerely yours,
Mike.

