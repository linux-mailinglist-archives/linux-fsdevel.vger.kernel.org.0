Return-Path: <linux-fsdevel+bounces-69697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8903FC816A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8963AAF0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A678314A97;
	Mon, 24 Nov 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD8hl6p4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E61459F6;
	Mon, 24 Nov 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999261; cv=none; b=qVN2kFvjUMVg1vMIUBYHz7sAfZKQhkKp4PVVFZk4+eqVC1gABqYj89bkc4GJYtyZ98MV2lDoSLhzi0U5zEv1PKjVZLipDAH8JnyYTONRuCpZxLPE63sQH+utKbd1e+l8Q0Mv5kHpT4ThUrU1BIQuIZRhMxzSuOerO8q2Tz/wsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999261; c=relaxed/simple;
	bh=5ty/fBZCjmHJEhbLI4jansFNLKgSe6N+QAK7tw6dIws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHOasfamo2EUWV0BP15T3KrOgFTXqeMEmaQOOJdjxmBMvHoZ5JP7TJC5A82Mul5vz1I2Fn8yWLOS3cNE6yUGTPeYx2/VZV4sG0NwSsfWjpYaOrRcshdeZM5VwHiDk0UNy68cZPMxRGGEJ6uf434H0GjrlJrd+IBX00JvJMHL2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD8hl6p4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B471C116C6;
	Mon, 24 Nov 2025 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763999261;
	bh=5ty/fBZCjmHJEhbLI4jansFNLKgSe6N+QAK7tw6dIws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tD8hl6p4EdIqmbNvRouc9XEPitGGBST3KvBxD9jDy3whnYM/8QW8jb+Z1nUb0dBUt
	 5txNckatOwxXFdgnCm4EXk8hgAz9RdybMIan+uPcYKEf3DNBs0QOm/vWqK2wOVIxKc
	 iAcEwkSnrL5xCFc02dOxaSgBKxQcXCfBt+/iZx+ZddYEWvHeSKW0IpvM2fBg9DbQTC
	 gStB8ufMnWYeUMHKdCmRrvMJVJwntRtlqTLx+0RqidnqmWgxlELS0z8LVMJRgIThg0
	 cKmOgnls7csGca0V2+bOouvFPuSz4MqRat8hOBZYImbUCLwn1xC1SvwzzeEJfeWiSg
	 wUgLSJnMWqP9A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
Subject: Re: [PATCH v7 06/22] liveupdate: luo_file: implement file systems
 callbacks
In-Reply-To: <mafs0tsyjxwoa.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	24 Nov 2025 16:44:21 +0100")
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
	<20251122222351.1059049-7-pasha.tatashin@soleen.com>
	<mafs0tsyjxwoa.fsf@kernel.org>
Date: Mon, 24 Nov 2025 16:47:31 +0100
Message-ID: <mafs0pl97xwj0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

Sorry, I accidentally sent this without trimming the context first.

Below is the version with the relevant bits:

 On Sat, Nov 22 2025, Pasha Tatashin wrote:

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
>  include/linux/kho/abi/luo.h      |  39 +-
>  include/linux/liveupdate.h       |  98 ++++
>  kernel/liveupdate/Makefile       |   1 +
>  kernel/liveupdate/luo_file.c     | 882 +++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h |  38 ++
>  5 files changed, 1057 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_file.c
>
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index a2d2940eca6b..fc143f243871 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
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
>  #ifndef _LINUX_KHO_ABI_LUO_H
> @@ -82,13 +87,43 @@
>  #define LUO_FDT_COMPATIBLE	"luo-v1"
>  #define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
>  
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
> +/**
> + * struct luo_file_set_ser - Represents the serialized metadata for file set
> + * @files:   The physical address of a contiguous memory block that holds
> + *           the serialized state of files (array of luo_file_ser) in this file
> + *           set.
> + * @count:   The total number of files that were part of this session during
> + *           serialization. Used for iteration and validation during
> + *           restoration.
> + */
> +struct luo_file_set_ser {
> +	u64 files;
> +	u64 count;
> +} __packed;

 The change to using file_set looks a lot nicer than what the previous
 version was doing!

> +
>  /*
>   * LUO FDT session node
>   * LUO_FDT_SESSION_HEADER:  is a u64 physical address of struct
>   *                          luo_session_header_ser
>   */
>  #define LUO_FDT_SESSION_NODE_NAME	"luo-session"
> -#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v1"
> +#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v2"
>  #define LUO_FDT_SESSION_HEADER		"luo-session-header"
>  
>  /**
[...]
> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +	struct liveupdate_file_handler *fh;
> +	struct luo_file *luo_file;
> +	struct file *file;
> +	int err;
> +
> +	if (luo_token_is_used(file_set, token))
> +		return -EEXIST;
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	err = luo_alloc_files_mem(file_set);
> +	if (err)
> +		goto  err_files_mem;

 Nit:                ^^ two spaces here.

> +
> +	if (file_set->count == LUO_FILE_MAX) {
> +		err = -ENOSPC;
> +		goto err_files_mem;
> +	}
> +
> +	err = -ENOENT;
> +	luo_list_for_each_private(fh, &luo_file_handler_list, list) {
> +		if (fh->ops->can_preserve(fh, file)) {
> +			err = 0;
> +			break;
> +		}
> +	}
> +
[...]
> +int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> +{
> +	struct liveupdate_file_handler *fh_iter;
> +	int err;
> +
> +	if (!liveupdate_enabled())
> +		return -EOPNOTSUPP;
> +
> +	/* Sanity check that all required callbacks are set */
> +	if (!fh->ops->preserve || !fh->ops->unpreserve ||
> +	    !fh->ops->retrieve || !fh->ops->finish) {

 You are still missing a check for can_preserve() here. It is a mandatory
 callback and luo_preserve_file() calls it without checking for NULL.

 With these and Mike's comments addressed,

 Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> +		return -EINVAL;
> +	}
> +
[...]

-- 
Regards,
Pratyush Yadav

