Return-Path: <linux-fsdevel+bounces-59402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61AB386B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499AC366796
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F92D0606;
	Wed, 27 Aug 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6v+GpFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7C25392C;
	Wed, 27 Aug 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308881; cv=none; b=LBMpPf9flt80NW8hVtOxSYFXOh7ysUeU/hYNU2oFRyt64rd42cIAsden5dMePzwDiiRolz9sZftshZdU+P6AP2ZaqO+IDeaubUZFVhUH+SHUioUFGaSvMuCfapVGB7aDMcnjLqp9Sav3TSbp92/Fc220ZlKx855tK+F/jQafeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308881; c=relaxed/simple;
	bh=/hHoYvlbaeWmt9yGXT8TP2XYUsiA//N6BuAAiOClRwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmECQG7wVfooIqMrqVQ4ZbYSKvoD3QRdk8KhG9ausL6J6OqktzaAbV7jSfbkerNojzkT0lKb9Mv/2Dl7eHG4nhLHcB+wNc/92V1BIBS6aUJG+IWbaKKnmF+MErn3LLTkV9ublBBJcL28FvvbNWIf6tO33NiyuYXUX1wH1a+2Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6v+GpFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC4AC4CEF0;
	Wed, 27 Aug 2025 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756308880;
	bh=/hHoYvlbaeWmt9yGXT8TP2XYUsiA//N6BuAAiOClRwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e6v+GpFxja9vW9YNrveOO418XZOPc4iSrQvWmcZAoH6Mc4PKvw7UBBQ60MGplx8OJ
	 aoiC9hnqMNugU0Xj0H2VpaLaqrXLxVMtj8qdu7PogapUHHlTYMMod3aNgdyrNzrJN5
	 jmtfsaPmnSptrjABNdhm5J1zvmRLRd8pCh/OOhD0fxETxQeHxFSOe/nlKZg2fj+ZoT
	 KD7gSbtqY7kjdvRsSJUwACMaSJ2HmJZxOU9clnPNVBzB4RssvVAWJHfsVm2f/lcqsn
	 wrDmCM6GjAFmlZobcWtXrgwFnEWMrVvQ5xDd1fvmkcjujpbQ9twhauEaGtD+wOX4CF
	 q2OX9DZbgo5fQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 17/30] liveupdate: luo_files: luo_ioctl: Unregister
 all FDs on device close
In-Reply-To: <20250807014442.3829950-18-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-18-pasha.tatashin@soleen.com>
Date: Wed, 27 Aug 2025 17:34:29 +0200
Message-ID: <mafs07byoye0q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Thu, Aug 07 2025, Pasha Tatashin wrote:

> Currently, a file descriptor registered for preservation via the remains
> globally registered with LUO until it is explicitly unregistered. This
> creates a potential for resource leaks into the next kernel if the
> userspace agent crashes or exits without proper cleanup before a live
> update is fully initiated.
>
> This patch ties the lifetime of FD preservation requests to the lifetime
> of the open file descriptor for /dev/liveupdate, creating an implicit
> "session".
>
> When the /dev/liveupdate file descriptor is closed (either explicitly
> via close() or implicitly on process exit/crash), the .release
> handler, luo_release(), is now called. This handler invokes the new
> function luo_unregister_all_files(), which iterates through all FDs
> that were preserved through that session and unregisters them.

Why special case files here? Shouldn't you undo all the serialization
done for all the subsystems?

Anyway, this is buggy. I found this when testing the memfd patches. If
you preserve a memfd and close the /dev/liveupdate FD before reboot,
luo_unregister_all_files() calls the cancel callback, which calls
kho_unpreserve_folio(). But kho_unpreserve_folio() fails because KHO is
still in finalized state. This doesn't happen when cancelling explicitly
because luo_cancel() calls kho_abort().

I think you should just make the release go through the cancel flow,
since the operation is essentially a cancel anyway. There are subtle
differences here though, since the release might be called before
prepare, so we need to be careful of that.


>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_files.c    | 19 +++++++++++++++++++
>  kernel/liveupdate/luo_internal.h |  1 +
>  kernel/liveupdate/luo_ioctl.c    |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
> index 33577c9e9a64..63f8b086b785 100644
> --- a/kernel/liveupdate/luo_files.c
> +++ b/kernel/liveupdate/luo_files.c
> @@ -721,6 +721,25 @@ int luo_unregister_file(u64 token)
>  	return ret;
>  }
>  
> +/**
> + * luo_unregister_all_files - Unpreserve all currently registered files.
> + *
> + * Iterates through all file descriptors currently registered for preservation
> + * and unregisters them, freeing all associated resources. This is typically
> + * called when LUO agent exits.
> + */
> +void luo_unregister_all_files(void)
> +{
> +	struct luo_file *luo_file;
> +	unsigned long token;
> +
> +	luo_state_read_enter();
> +	xa_for_each(&luo_files_xa_out, token, luo_file)
> +		__luo_unregister_file(token);
> +	luo_state_read_exit();
> +	WARN_ON_ONCE(atomic64_read(&luo_files_count) != 0);
> +}
> +
>  /**
>   * luo_retrieve_file - Find a registered file instance by its token.
>   * @token: The unique token of the file instance to retrieve.
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 5692196fd425..189e032d7738 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -37,5 +37,6 @@ void luo_do_subsystems_cancel_calls(void);
>  int luo_retrieve_file(u64 token, struct file **filep);
>  int luo_register_file(u64 token, int fd);
>  int luo_unregister_file(u64 token);
> +void luo_unregister_all_files(void);
>  
>  #endif /* _LINUX_LUO_INTERNAL_H */
> diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
> index 6f61569c94e8..7ca33d1c868f 100644
> --- a/kernel/liveupdate/luo_ioctl.c
> +++ b/kernel/liveupdate/luo_ioctl.c
> @@ -137,6 +137,7 @@ static int luo_open(struct inode *inodep, struct file *filep)
>  
>  static int luo_release(struct inode *inodep, struct file *filep)
>  {
> +	luo_unregister_all_files();
>  	atomic_set(&luo_device_in_use, 0);
>  
>  	return 0;

-- 
Regards,
Pratyush Yadav

