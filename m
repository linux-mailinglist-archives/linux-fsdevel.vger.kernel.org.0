Return-Path: <linux-fsdevel+bounces-6504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F8818C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DF28768C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1191DA51;
	Tue, 19 Dec 2023 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJt4o73u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1E1D54D;
	Tue, 19 Dec 2023 16:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1049C433C9;
	Tue, 19 Dec 2023 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703003806;
	bh=6ZE1ZWL+Q3XfV/BNZf6ItPtOJDRd9vjSskX9Wb4d1fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJt4o73uXCVxhYQStzPU9GZ1T2dfQ3ZN7KI957oAJIJPYoUaDpj3yIVuBPHCTXnIK
	 /Xc0owDprCquptYak5XeHWW5j9cpk/0QRoflm4AZoma9e/TvdY4Mhawi32F2agDak1
	 SATdmuFIaoFQxTgdHuWoJn7bjvx5FQ9DkHQUu3a/1Ts2gipvDwU5/Hz0HItXRA6VSI
	 X7hfa1jGH03H5jt7d9Vb/1i9+FWl1iiDZELXcWM5f8UsFwIP5M3EXc51MofTvlu8e1
	 Dkt8tYS5avfmmKFJ3H1BMDE90ip0gGZ7M+9Cs5U34IIsUcTrBEoDPylFilgDsADnW7
	 GT0VdOq+XCj/Q==
Date: Tue, 19 Dec 2023 09:36:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 15/50] kernel/numa.c: Move logging out of numa.h
Message-ID: <20231219163644.GA345795@dev-arch.thelio-3990X>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216032651.3553101-5-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:26:14PM -0500, Kent Overstreet wrote:
> Moving these stub functions to a .c file means we can kill a sched.h
> dependency on printk.h.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/numa.h | 18 +++++-------------
>  kernel/Makefile      |  1 +
>  kernel/numa.c        | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 13 deletions(-)
>  create mode 100644 kernel/numa.c
> 
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index a904861de800..aeab3d9f57ae 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -22,34 +22,26 @@
>  #endif
>  
>  #ifdef CONFIG_NUMA
> -#include <linux/printk.h>
>  #include <asm/sparsemem.h>
>  
>  /* Generic implementation available */
>  int numa_nearest_node(int node, unsigned int state);
>  
>  #ifndef memory_add_physaddr_to_nid
> -static inline int memory_add_physaddr_to_nid(u64 start)
> -{
> -	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
> -			start);
> -	return 0;
> -}
> +int memory_add_physaddr_to_nid(u64 start);
>  #endif
> +
>  #ifndef phys_to_target_node
> -static inline int phys_to_target_node(u64 start)
> -{
> -	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> -			start);
> -	return 0;
> -}
> +int phys_to_target_node(u64 start);
>  #endif
> +
>  #ifndef numa_fill_memblks
>  static inline int __init numa_fill_memblks(u64 start, u64 end)
>  {
>  	return NUMA_NO_MEMBLK;
>  }
>  #endif
> +
>  #else /* !CONFIG_NUMA */
>  static inline int numa_nearest_node(int node, unsigned int state)
>  {
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3947122d618b..ce105a5558fc 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -114,6 +114,7 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
>  obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
>  obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
>  obj-$(CONFIG_CFI_CLANG) += cfi.o
> +obj-$(CONFIG_NUMA) += numa.o
>  
>  obj-$(CONFIG_PERF_EVENTS) += events/
>  
> diff --git a/kernel/numa.c b/kernel/numa.c
> new file mode 100644
> index 000000000000..c24c72f45989
> --- /dev/null
> +++ b/kernel/numa.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/printk.h>
> +#include <linux/numa.h>
> +
> +/* Stub functions: */
> +
> +#ifndef memory_add_physaddr_to_nid
> +int memory_add_physaddr_to_nid(u64 start)
> +{
> +	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
> +			start);
> +	return 0;
> +}
> +#endif
> +
> +#ifndef phys_to_target_node
> +int phys_to_target_node(u64 start)
> +{
> +	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> +			start);
> +	return 0;
> +}
> +#endif
> -- 
> 2.43.0
> 

These need EXPORT_SYMBOL_GPL() now like the architecture specific
implementations because they are no longer inlined. My arm64 builds fail
with:

  ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/acpi/nfit/nfit.ko] undefined!
  ERROR: modpost: "phys_to_target_node" [drivers/acpi/nfit/nfit.ko] undefined!
  ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/virtio/virtio_mem.ko] undefined!
  ERROR: modpost: "phys_to_target_node" [drivers/dax/dax_cxl.ko] undefined!
  ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/dax/dax_cxl.ko] undefined!
  ERROR: modpost: "phys_to_target_node" [drivers/cxl/cxl_acpi.ko] undefined!
  ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_pmem.ko] undefined!
  ERROR: modpost: "phys_to_target_node" [drivers/cxl/cxl_pmem.ko] undefined!
  ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/hv/hv_balloon.ko] undefined!

Cheers,
Nathan

