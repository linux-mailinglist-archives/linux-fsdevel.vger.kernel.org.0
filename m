Return-Path: <linux-fsdevel+bounces-67727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 882FBC48519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 343D734A0B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E62BF017;
	Mon, 10 Nov 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOEmXq56"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B362BE655;
	Mon, 10 Nov 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795662; cv=none; b=V4ZrB+9wQ15j9Z+0bTL1bcK0dUXDvomC+//2knJdr8To7ONn6WM1E0OaNfPtzgX/gU6NjpfoaNbNO7zcOXwswYnilwFA8upF+chQVKoK0XllzzW2JMJ2xbF/lp8V0unDzz2fqgbFfhjObsz/FhEm5paHdhu9/mWZ+Sqv5w6Uuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795662; c=relaxed/simple;
	bh=HHttyIN4ZrA3AcpdgGnhsSW/6Bj+qI781YjC1EPK/3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFc9R22hTA5XJgsVF+VscnkdrnyKNS/SNpY4J6hSAnEwFxBCS7xXKarVWilOAk4e8Z++RP7imb19F/Ex5rzB4Jtty6OmOUgnmMAqz8qnaCV3Y8LaaZMG8HKvJFM0RIToSqRq+fQMXkQcDZGM5h9PBJaenThrs9HrR0z3TTATIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOEmXq56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473ABC4CEFB;
	Mon, 10 Nov 2025 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762795661;
	bh=HHttyIN4ZrA3AcpdgGnhsSW/6Bj+qI781YjC1EPK/3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kOEmXq56QEOhYKVDYg3pmTTbZaQ3owW/HDKwcBuDdC82JmIqyrI0H+yxc99FUcDUL
	 fwXU81C3GkaANePQ13/nt1UtzHQ8MyPYe22/hw6izEBVPomnOaNifH0nL2YjIuoVqz
	 bFDQnk/vsnnCJkXC34jzPZvxkem36m07cBLE0RclncJ9pC8+XMc/avvKcXYiGT+kXB
	 IxJB+zIQ1WdF4EG+YSFYbws5XOV+2UNYGXQCOLRsjYTSDn6n0KjUr0PPbAlCviICtC
	 SXhBCSgF6rWyM5byi12R1vmT5TvXzSZLCbZ+DnAFyM+S/lRmxXR0TspGUHGzkxmBaW
	 qPOuJVi+O+KYQ==
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
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
Subject: Re: [PATCH v5 08/22] liveupdate: luo_file: implement file systems
 callbacks
In-Reply-To: <20251107210526.257742-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 7 Nov 2025 16:03:06 -0500")
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
	<20251107210526.257742-9-pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 18:27:31 +0100
Message-ID: <mafs0ms4tajcs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

Caught a small bug during some of my testing.

On Fri, Nov 07 2025, Pasha Tatashin wrote:

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
[...]
> +int luo_preserve_file(struct luo_session *session, u64 token, int fd)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +	struct liveupdate_file_handler *fh;
> +	struct luo_file *luo_file;
> +	struct file *file;
> +	int err = -ENOENT;
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

err gets set to 0 here...

> +	if (err)
> +		goto  exit_err;
> +
> +	if (session->count == LUO_FILE_MAX) {
> +		err = -ENOSPC;
> +		goto exit_err;
> +	}
> +
> +	list_for_each_entry(fh, &luo_file_handler_list, list) {
> +		if (fh->ops->can_preserve(fh, file)) {
> +			err = 0;
> +			break;
> +		}
> +	}

... say no file handler can preserve this file ...

> +
> +	/* err is still -ENOENT if no handler was found */
> +	if (err)

... err is not ENOENT, but 0. So this function does not error but, but
goes ahead with fh == luo_file_handler_list (since end of list). This
causes an out-of-bounds access. It eventually causes a kernel fault and
panic.

You should drop the ENOENT at initialization time and set it right
before list_for_each_entry().

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
> +	}
> +
> +	return 0;
> +
> +exit_err:
> +	fput(file);
> +	luo_session_free_files_mem(session);
> +
> +	return err;
> +}
[...]

-- 
Regards,
Pratyush Yadav

