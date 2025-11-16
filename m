Return-Path: <linux-fsdevel+bounces-68612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E67C614F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 13:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371FE3B7605
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB32D948D;
	Sun, 16 Nov 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVUG98NP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7E2D839C;
	Sun, 16 Nov 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763297108; cv=none; b=HJDwM9WE5a9+LabI5rZD7yUJWqv0brwbionl7zNsWdH5FHGPpCn3x/+GVuGGbw1auuH5ZRa09hcn+Cio5KguIQ8kaD06Az5UTPbsGjak2bGa192CWmCjkr4HEdiNhTDB2Vbt/fvd7+3CUc4tHDIiq1pycGuRdPngj5++l4L6wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763297108; c=relaxed/simple;
	bh=FQsIjcze7ny/ihNObILffVz/RZYjdBBVaFrGEHeRaGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEVsikUHbBRDsQy6JRe9X7xqZUJKZycvLJ9haradj6CpZJuDEQHpUqiB0ZLyV+/CaO3tI6nhCXJS7CkhQkPE7hOpXhSsFRZjVRorHJFRWt+aTR38FCYcjUqMpmGrclb3qJQofU+LWKfj0MjX+drrOzFFDaFPaBIQaMxyuHukyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVUG98NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D04C4CEFB;
	Sun, 16 Nov 2025 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763297105;
	bh=FQsIjcze7ny/ihNObILffVz/RZYjdBBVaFrGEHeRaGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVUG98NPrWa2ycrlOR5G9KSRrMXg0exikuWmvqW0pl+wMf5e6gUAXY2/KvUstqKbO
	 wtvi6wt5qqNulwDxLfUPo4BMaCUGq+z2zIwgVh+TRMdnydwcON8f6GBmTRx0l/zAAg
	 UFDQbW14bn1sS9UftJi+0NltKYWS1bKPrnq9qoOJTMZ0Z3VswFK+5dDsP3cbs6/If3
	 8KPX2wVrR9h7PlZ0VaxG1ow8eQ7qydDhweuVniORdwFwo4ZGBBVTuQ9zdf9U7kqGhc
	 yuxWfZY4ycdPogoX/C/ajzJCOuv/BCJBlXjgiUQuQz9ZAps4c3lpYndqioxuKypmq7
	 mnOM8YWPrG9ag==
Date: Sun, 16 Nov 2025 14:44:41 +0200
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
Subject: Re: [PATCH v6 03/20] kexec: call liveupdate_reboot() before kexec
Message-ID: <aRnHOeL8Es3-9dQ6@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-4-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:49PM -0500, Pasha Tatashin wrote:
> Modify the kernel_kexec() to call liveupdate_reboot().
> 
> This ensures that the Live Update Orchestrator is notified just
> before the kernel executes the kexec jump. The liveupdate_reboot()
> function triggers the final freeze event, allowing participating
> FDs perform last-minute check or state saving within the blackout
> window.
> 
> If liveupdate_reboot() returns an error (indicating a failure during
> LUO finalization), the kexec operation is aborted to prevent proceeding
> with an inconsistent state. An error is returned to user.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a8890dd03a1d..3122235c225b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> +#include <linux/liveupdate.h>
>  #include <linux/highmem.h>
>  #include <linux/syscalls.h>
>  #include <linux/reboot.h>
> @@ -1145,6 +1146,10 @@ int kernel_kexec(void)
>  		goto Unlock;
>  	}
>  
> +	error = liveupdate_reboot();
> +	if (error)
> +		goto Unlock;
> +
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (kexec_image->preserve_context) {
>  		/*
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

