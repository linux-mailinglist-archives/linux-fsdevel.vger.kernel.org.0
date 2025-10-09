Return-Path: <linux-fsdevel+bounces-63622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA8BC715B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 03:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49EBA4EE7C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 01:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661E202976;
	Thu,  9 Oct 2025 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QW2Xq7fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6091EF36B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972046; cv=none; b=k54V04+fBxWpcBCj5/of2TlCNEbcgwmsTMwzO8+h41OUEbMY68RjdpIGMXiAOitzSoJuX1rD8VE1Oa7bITuV7MdSzEdbMZyD84u991QtsGiVeW3zQ/yLw4Lhn3u+7K3vLrVEmbjYJ3M9Rh0zRGPNxs5BKdr6o/UzgZTxlO4WwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972046; c=relaxed/simple;
	bh=fCWniQpVEHektq92KuVAxruTIAsTPnp+MkQmRRm57Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QB7jj+9/lO2xqSsbFcqNF8NtlpVVZniavHg+FLjl0VLdi1LK2K054aVmlzK3xSzVMzF6WM8jq8j5deif2mb/dJd/HB/MZL7I0/fNUEDpfIYrnDT0TbFEDiDwxsL9GbJreIg7UlnLG3hJkH7J4NRolzW1F7SRFT9oWXpVNvMx6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QW2Xq7fb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759972039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VBPwGyoeD8uP185Gv+2G5xRNeY5xlzR+XoG36QLrYY=;
	b=QW2Xq7fb/0R8eSRnkRtiWsJZ71xUtS6VNS3PESNmVdcnpqsCZzuAjKaee6Nev31bfcYbFc
	I6A01Up3Gl//GX2irEKLkdDHDTXBESO0d6dXHrZMgfmBIgIR3stAsDlmWpY9ivV3ZBpK9J
	12HYXF03sV4fbLu0WH0H0gXW3v6xTBk=
Date: Wed, 8 Oct 2025 18:07:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
To: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
 jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
 yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
 chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
 jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
 dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org,
 rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org,
 zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20250807014442.3829950-20-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/25 6:44 PM, Pasha Tatashin wrote:
> Introduce a sysfs interface for the Live Update Orchestrator
> under /sys/kernel/liveupdate/. This interface provides a way for
> userspace tools and scripts to monitor the current state of the LUO
> state machine.
> 
> The main feature is a read-only file, state, which displays the
> current LUO state as a string ("normal", "prepared", "frozen",
> "updated"). The interface uses sysfs_notify to allow userspace
> listeners (e.g., via poll) to be efficiently notified of state changes.
> 
> ABI documentation for this new sysfs interface is added in
> Documentation/ABI/testing/sysfs-kernel-liveupdate.
> 
> This read-only sysfs interface complements the main ioctl interface
> provided by /dev/liveupdate, which handles LUO control operations and
> resource management.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   .../ABI/testing/sysfs-kernel-liveupdate       | 51 ++++++++++
>   kernel/liveupdate/Kconfig                     | 18 ++++
>   kernel/liveupdate/Makefile                    |  1 +
>   kernel/liveupdate/luo_core.c                  |  1 +
>   kernel/liveupdate/luo_internal.h              |  6 ++
>   kernel/liveupdate/luo_sysfs.c                 | 92 +++++++++++++++++++
>   6 files changed, 169 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
>   create mode 100644 kernel/liveupdate/luo_sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> new file mode 100644
> index 000000000000..bb85cbae4943
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> @@ -0,0 +1,51 @@
> +What:		/sys/kernel/liveupdate/
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	pasha.tatashin@soleen.com
> +Description:	Directory containing interfaces to query the live
> +		update orchestrator. Live update is the ability to reboot the
> +		host kernel (e.g., via kexec, without a full power cycle) while
> +		keeping specifically designated devices operational ("alive")
> +		across the transition. After the new kernel boots, these devices
> +		can be re-attached to their original workloads (e.g., virtual
> +		machines) with their state preserved. This is particularly
> +		useful, for example, for quick hypervisor updates without
> +		terminating running virtual machines.
> +
> +
> +What:		/sys/kernel/liveupdate/state
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	pasha.tatashin@soleen.com
> +Description:	Read-only file that displays the current state of the live
> +		update orchestrator as a string. Possible values are:
> +
> +		"normal"	No live update operation is in progress. This is
> +				the default operational state.
> +
> +		"prepared"	The live update preparation phase has completed
> +				successfully (e.g., triggered via the
> +				/dev/liveupdate event). Kernel subsystems have
> +				been notified via the %LIVEUPDATE_PREPARE
> +				event/callback and should have initiated state
> +				saving. User workloads (e.g., VMs) are generally
> +				still running, but some operations (like device
> +				unbinding or new DMA mappings) might be
> +				restricted. The system is ready for the reboot
> +				trigger.
> +
> +		"frozen"	The final reboot notification has been sent
> +				(e.g., triggered via the 'reboot()' syscall),
> +				corresponding to the %LIVEUPDATE_REBOOT kernel
> +				event. Subsystems have had their final chance to
> +				save state. User workloads must be suspended.
> +				The system is about to execute the reboot into
> +				the new kernel (imminent kexec). This state
> +				corresponds to the "blackout window".
> +
> +		"updated"	The system has successfully rebooted into the
> +				new kernel via live update. Restoration of
> +				preserved resources can now occur (typically via
> +				ioctl commands). The system is awaiting the
> +				final 'finish' signal after user space completes
> +				restoration tasks.
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index f6b0bde188d9..75a17ca8a592 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -29,6 +29,24 @@ config LIVEUPDATE
>   
>   	  If unsure, say N.
>   
> +config LIVEUPDATE_SYSFS_API
> +	bool "Live Update sysfs monitoring interface"
> +	depends on SYSFS
> +	depends on LIVEUPDATE
> +	help
> +	  Enable a sysfs interface for the Live Update Orchestrator
> +	  at /sys/kernel/liveupdate/.
> +
> +	  This allows monitoring the LUO state ('normal', 'prepared',
> +	  'frozen', 'updated') via the read-only 'state' file.
> +
> +	  This interface complements the primary /dev/liveupdate ioctl
> +	  interface, which handles the full update process.
> +	  This sysfs API may be useful for scripting, or userspace monitoring
> +	  needed to coordinate application restarts and minimize downtime.
> +
> +	  If unsure, say N.
> +
>   config KEXEC_HANDOVER
>   	bool "kexec handover"
>   	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index c67fa2797796..47f5d0378a75 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
>   obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
>   
>   obj-$(CONFIG_LIVEUPDATE)		+= luo.o
> +obj-$(CONFIG_LIVEUPDATE_SYSFS_API)	+= luo_sysfs.o
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 64d53b31d6d8..bd07ee859112 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -100,6 +100,7 @@ static inline bool is_current_luo_state(enum liveupdate_state expected_state)
>   static void __luo_set_state(enum liveupdate_state state)
>   {
>   	WRITE_ONCE(luo_state, state);
> +	luo_sysfs_notify();
>   }
>   
>   static inline void luo_set_state(enum liveupdate_state state)
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 01bd0d3b023b..9091ed04c606 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -47,4 +47,10 @@ int luo_file_freeze(u64 token);
>   int luo_file_cancel(u64 token);
>   int luo_file_finish(u64 token);
>   
> +#ifdef CONFIG_LIVEUPDATE_SYSFS_API
> +void luo_sysfs_notify(void);
> +#else
> +static inline void luo_sysfs_notify(void) {}
> +#endif
> +
>   #endif /* _LINUX_LUO_INTERNAL_H */
> diff --git a/kernel/liveupdate/luo_sysfs.c b/kernel/liveupdate/luo_sysfs.c
> new file mode 100644
> index 000000000000..935946bb741b
> --- /dev/null
> +++ b/kernel/liveupdate/luo_sysfs.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: LUO sysfs interface
> + *
> + * Provides a sysfs interface at ``/sys/kernel/liveupdate/`` for monitoring LUO
> + * state.  Live update allows rebooting the kernel (via kexec) while preserving
> + * designated device state for attached workloads (e.g., VMs), useful for
> + * minimizing downtime during hypervisor updates.
> + *
> + * /sys/kernel/liveupdate/state
> + * ----------------------------
> + * - Permissions:  Read-only
> + * - Description:  Displays the current LUO state string.
> + * - Valid States:
> + *     @normal
> + *       Idle state.
> + *     @prepared
> + *       Preparation phase complete (triggered via '/dev/liveupdate'). Resources
> + *       checked, state saving initiated via %LIVEUPDATE_PREPARE event.
> + *       Workloads mostly running but may be restricted. Ready forreboot
> + *       trigger.
> + *     @frozen
> + *       Final reboot notification sent (triggered via 'reboot'). Corresponds to
> + *       %LIVEUPDATE_REBOOT event. Final state saving. Workloads must be
> + *       suspended. System about to kexec ("blackout window").
> + *     @updated
> + *       New kernel booted via live update. Awaiting 'finish' signal.
> + *
> + * Userspace Interaction & Blackout Window Reduction
> + * -------------------------------------------------
> + * Userspace monitors the ``state`` file to coordinate actions:
> + *   - Suspend workloads before @frozen state is entered.
> + *   - Initiate resource restoration upon entering @updated state.
> + *   - Resume workloads after restoration, minimizing downtime.
> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/liveupdate.h>
> +#include <linux/sysfs.h>
> +#include "luo_internal.h"
> +
> +static bool luo_sysfs_initialized;
> +
> +#define LUO_DIR_NAME	"liveupdate"
> +
> +void luo_sysfs_notify(void)
> +{
> +	if (luo_sysfs_initialized)
> +		sysfs_notify(kernel_kobj, LUO_DIR_NAME, "state");
> +}
> +
> +/* Show the current live update state */
> +static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", luo_current_state_str());

Because the window of kernel live update is short, it is difficult to 
statistics how many times the kernel is live updated.

Is it possible to add a variable to statistics the times that the kernel 
is live updated?

For example, define a global variable of type atomic_t or u64 in the 
core module:

#include <linux/atomic.h>

static atomic_t klu_counter = ATOMIC_INIT(0);


Every time a live update completes successfully, increment the counter:

atomic_inc(&klu_counter);

Then exporting this value through /proc or /sys so that user space can 
check it:

static ssize_t klu_counter_show(struct kobject *kobj, struct 
kobj_attribute *attr, char *buf)
{
     return sprintf(buf, "%d\n", atomic_read(&klu_counter));
}

Yanjun.Zhu


> +}
> +
> +static struct kobj_attribute state_attribute = __ATTR_RO(state);
> +
> +static struct attribute *luo_attrs[] = {
> +	&state_attribute.attr,
> +	NULL
> +};
> +
> +static struct attribute_group luo_attr_group = {
> +	.attrs = luo_attrs,
> +	.name = LUO_DIR_NAME,
> +};
> +
> +static int __init luo_init(void)
> +{
> +	int ret;
> +
> +	ret = sysfs_create_group(kernel_kobj, &luo_attr_group);
> +	if (ret) {
> +		pr_err("Failed to create group\n");
> +		return ret;
> +	}
> +
> +	luo_sysfs_initialized = true;
> +	pr_info("Initialized\n");
> +
> +	return 0;
> +}
> +subsys_initcall(luo_init);


