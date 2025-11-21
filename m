Return-Path: <linux-fsdevel+bounces-69383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392CEC7ADDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB58B3A1DF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D82BF3CC;
	Fri, 21 Nov 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm1SpMw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1513238C0F;
	Fri, 21 Nov 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742785; cv=none; b=RQ2akdUBcFiLtyv58YGkimFYCFECIrSFG7rULdOyaQn/7RabXRcFV4KeXTrGIKBJsTjL9jWIRjhm8ejoxTBrXMhyz6fwiUuLMn12NB0IMvB5hj5N7sFjd69f/lyQf9K8tQFtamA6wSTCrt8azzzP8++Sy2HYOtswaNtw4fBpwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742785; c=relaxed/simple;
	bh=EnuteN5J9YttfHD5PxJfkcAGy9x3+mjN5oTZTsrJRc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZiznOzlwrOBltIjWCk+FgA/QTHd72tVttuiLkbUuBUDYQxwtHFPOQ59H5ZmyF+Y4rpeewgOZI/UGN/9zbHXwD1HM9e2NLe7KheMYsJvJ0Dd8Z9lBypngW5oCjThcd+2x4IwHLF0WDePUwUXrpLETpHNVPAxex+zNc11jyZh8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm1SpMw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98423C4CEF1;
	Fri, 21 Nov 2025 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742785;
	bh=EnuteN5J9YttfHD5PxJfkcAGy9x3+mjN5oTZTsrJRc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jm1SpMw0uwR92glh2ACwsFKTfDLGr7/AYBZAfrYhstCZSQsBZTAdJRvKtfGt7/hwm
	 vjNb2OoVl52n1Q2mzUK8yq/ei6+qCG9dAg4TKysjLBmNm7dCLUwal0ZuzaKL6XDhiz
	 lTyD3RG3V2enine1j0EKVl7RdikW/s2lKpGVEZ+iQM1iiZ3vveJn3mUISWIpZ8GGJR
	 Z0rtSrsfsWYbWl1aT3sQNcFdUdV/SF7qoqRuKmSjXX2MuFb3Iq6GMS6h8HPIrp05R8
	 kOh2W1/40gdDHBO2h2U3+Hy7y/6DQgRs1qAlr1SLdH3A5vOEefYO88A+/A0S2RdJbg
	 CfmbdJOX4xlug==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
In-Reply-To: <20251115233409.768044-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 15 Nov 2025 18:33:50 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-5-pasha.tatashin@soleen.com>
Date: Fri, 21 Nov 2025 17:32:55 +0100
Message-ID: <mafs08qfz1h3c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 15 2025, Pasha Tatashin wrote:

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
[...]
>  
>  #ifndef _LINUX_LIVEUPDATE_ABI_LUO_H
>  #define _LINUX_LIVEUPDATE_ABI_LUO_H
>  
> +#include <uapi/linux/liveupdate.h>
> +
>  /*
>   * The LUO FDT hooks all LUO state for sessions, fds, etc.
> - * In the root it allso carries "liveupdate-number" 64-bit property that
> + * In the root it also carries "liveupdate-number" 64-bit property that

Nit: This needs a bit of patch massaging. Patch 2 added the typo, and
this patch fixes it. It would be better to just update patch 2.

>   * corresponds to the number of live-updates performed on this machine.
>   */
>  #define LUO_FDT_SIZE		PAGE_SIZE
> @@ -51,4 +82,54 @@
>  #define LUO_FDT_COMPATIBLE	"luo-v1"
>  #define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
>  
> +/*
> + * LUO FDT session node
> + * LUO_FDT_SESSION_HEADER:  is a u64 physical address of struct
> + *                          luo_session_header_ser
> + */
> +#define LUO_FDT_SESSION_NODE_NAME	"luo-session"
> +#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v1"
> +#define LUO_FDT_SESSION_HEADER		"luo-session-header"
> +
> +/**
> + * struct luo_session_header_ser - Header for the serialized session data block.
> + * @pgcnt: The total size, in pages, of the entire preserved memory block
> + *         that this header describes.
> + * @count: The number of 'struct luo_session_ser' entries that immediately
> + *         follow this header in the memory block.
> + *
> + * This structure is located at the beginning of a contiguous block of
> + * physical memory preserved across the kexec. It provides the necessary
> + * metadata to interpret the array of session entries that follow.
> + */
> +struct luo_session_header_ser {
> +	u64 pgcnt;

Why do you need pgcnt here? Can't the size be inferred from count? And
since you use contiguous memory block, the folio will know its page
count anyway, right? The less we have in the ABI the better IMO.

Same for other structures below.

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
[...]
> +/* Create a "struct file" for session */
> +static int luo_session_getfile(struct luo_session *session, struct file **filep)
> +{
> +	char name_buf[128];
> +	struct file *file;
> +
> +	guard(mutex)(&session->mutex);
> +	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> +	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);

Nit: You can return the file directly and get rid of filep.

> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	*filep = file;
> +
> +	return 0;
> +}
[...]
> +int __init luo_session_setup_outgoing(void *fdt_out)
> +{
> +	struct luo_session_header_ser *header_ser;
> +	u64 header_ser_pa;
> +	int err;
> +
> +	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);

Nit: The naming is a bit confusing here. At first glance I thought this
was just allocating the header, but it allocates the whole session
serialization buffer.

> +	if (IS_ERR(header_ser))
> +		return PTR_ERR(header_ser);
> +	header_ser_pa = virt_to_phys(header_ser);
> +
> +	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
> +	err |= fdt_property_string(fdt_out, "compatible",
> +				   LUO_FDT_SESSION_COMPATIBLE);
> +	err |= fdt_property(fdt_out, LUO_FDT_SESSION_HEADER, &header_ser_pa,
> +			    sizeof(header_ser_pa));
> +	err |= fdt_end_node(fdt_out);
> +
> +	if (err)
> +		goto err_unpreserve;
> +
> +	header_ser->pgcnt = LUO_SESSION_PGCNT;
> +	INIT_LIST_HEAD(&luo_session_global.outgoing.list);
> +	init_rwsem(&luo_session_global.outgoing.rwsem);
> +	luo_session_global.outgoing.header_ser = header_ser;
> +	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
> +	luo_session_global.outgoing.active = true;
> +
> +	return 0;
> +
> +err_unpreserve:
> +	kho_unpreserve_free(header_ser);
> +	return err;
> +}
[...]
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

Nit: it would be a bit simpler if LUO init always initialized this. And
then luo_session_setup_incoming() can fill the list if it has any data.
Slight reduction in code duplication and mental load.

> +		return 0;
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
[...]

-- 
Regards,
Pratyush Yadav

