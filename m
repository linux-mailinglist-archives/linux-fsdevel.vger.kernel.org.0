Return-Path: <linux-fsdevel+bounces-33439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433E9B8BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33104282050
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F161531F0;
	Fri,  1 Nov 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJKLmiem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1281E495;
	Fri,  1 Nov 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444769; cv=none; b=T+OmvXR3JM2zY0rrtkVH9pxIXrfeW+Ek8OWE0MYtjl7zAFGb5rX5HQvWYQVOkT5GZrf5lUGe/T+pmL7NlthZ7EKcVZRwl4f3TCz3+FGY5pMxwZsNxjzg2BOjI5fQrSErfV0MKlfSLxgI3dJ4HlkgT80QM+mCDF28B2Tj0JeY1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444769; c=relaxed/simple;
	bh=ZvZeBAnC9kYknUDCBX/xc2CDVq0IkqW7BT2/xp+xC7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EE/oSvhv+LRQsFxupOHkHG8Oj3mlKcFfHoNAI8KpfcetsrX4bCP674jrXzuv4TjTeWXulnoUtv6AE6Cb3NMw5JgEr1zQ1aYdEAa3KnWyXHqEROeUBM7wTXJmYECatL14YbtxL1IdTsCIZo3KqOac5ZTvUMAH73R0R4H6MqCV7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJKLmiem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC26C4CECD;
	Fri,  1 Nov 2024 07:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730444768;
	bh=ZvZeBAnC9kYknUDCBX/xc2CDVq0IkqW7BT2/xp+xC7c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vJKLmiemKA7iqYmXQ81GxW51cKMwjrvpGMvZJ7mpPlWM2L8bsH7Af92qlOlhacgY5
	 GxRWALUCbFjAn6wtm+9c0N2EINFFLG8wZ2x9/+P+ecGuz6pFKlkJ+C/sMpV/6aCkkn
	 rXBffDnS9EeQyCTF6FbFjimym0xpQqDCiwBkhO2sCkyqnBsplxuPcEVn1rEGnL2Y8M
	 KIZkNJeIRd5tSqlmOvHM1szrts7eJjDnfn+vaC8/t/PVXLWeyZ3jly+v01mtmL6nn9
	 P3jzrSJ2TW90qP7v4K+Rkui2+Q2Mf9ZFkA0aIZBLX2paHkx8RS35Nw8N1ABD/0km/d
	 iRyVHTkxplelg==
Message-ID: <0f5c1192-090b-4c00-a951-9613289057df@kernel.org>
Date: Fri, 1 Nov 2024 08:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
To: 'Guanjun' <guanjun@linux.alibaba.com>, corbet@lwn.net, axboe@kernel.dk,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu, tglx@linutronix.de, peterz@infradead.org,
 akpm@linux-foundation.org, paulmck@kernel.org, thuth@redhat.com,
 rostedt@goodmis.org, bp@alien8.de, xiongwei.song@windriver.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20241031074618.3585491-2-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 31. 10. 24, 8:46, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Commit c410abbbacb9 (genirq/affinity: Add is_managed to struct irq_affinity_desc)
> introduced is_managed bit to struct irq_affinity_desc. Due to queue interrupts
> treated as managed interrupts, in scenarios where a large number of
> devices are present (using massive msix queue interrupts), an excessive number
> of IRQ matrix bits (about num_online_cpus() * nvecs) are reserved during
> interrupt allocation. This sequently leads to the situation where interrupts
> for some devices cannot be properly allocated.
> 
> Support for limiting the number of managed interrupts on every node per allocation.
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  9 +++
>   block/blk-mq-cpumap.c                         |  2 +-
>   drivers/virtio/virtio_vdpa.c                  |  2 +-
>   fs/fuse/virtio_fs.c                           |  2 +-
>   include/linux/group_cpus.h                    |  2 +-
>   kernel/irq/affinity.c                         | 11 ++--
>   lib/group_cpus.c                              | 55 ++++++++++++++++++-
>   7 files changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9b61097a6448..ac80f35d04c9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3238,6 +3238,15 @@
>   			different yeeloong laptops.
>   			Example: machtype=lemote-yeeloong-2f-7inch
>   
> +	managed_irqs_per_node=
> +			[KNL,SMP] Support for limiting the number of managed
> +			interrupts on every node to prevent the case that
> +			interrupts cannot be properly allocated where a large
> +			number of devices are present. The default number is 0,
> +			that means no limit to the number of managed irqs.
> +			Format: integer between 0 and num_possible_cpus() / num_possible_nodes()
> +			Default: 0

Kernel parameters suck. Esp. here you have to guess to even properly 
boot. Could this be auto-tuned instead?

> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -11,6 +11,30 @@
>   
>   #ifdef CONFIG_SMP
>   
> +static unsigned int __read_mostly managed_irqs_per_node;
> +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_aligned_in_smp = {

This is quite excessive. On SUSE configs, this is 8192 cpu bits * 1024 
nodes = 1 M. For everyone. You have to allocate this dynamically 
instead. See e.g. setup_node_to_cpumask_map().

> +	[0 ... MAX_NUMNODES-1] = {CPU_BITS_ALL}
> +};
> +
> +static int __init irq_managed_setup(char *str)
> +{
> +	int ret;
> +
> +	ret = kstrtouint(str, 10, &managed_irqs_per_node);
> +	if (ret < 0) {
> +		pr_warn("managed_irqs_per_node= cannot parse, ignored\n");

could not be parsed

> +		return 0;
> +	}
> +
> +	if (managed_irqs_per_node * num_possible_nodes() > num_possible_cpus()) {
> +		managed_irqs_per_node = num_possible_cpus() / num_possible_nodes();
> +		pr_warn("managed_irqs_per_node= cannot be larger than %u\n",
> +			managed_irqs_per_node);
> +	}
> +	return 1;
> +}
> +__setup("managed_irqs_per_node=", irq_managed_setup);
> +
>   static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>   				unsigned int cpus_per_grp)
>   {
...
> @@ -332,6 +380,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>   /**
>    * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>    * @numgrps: number of groups
> + * @is_managed: if these groups managed by kernel

are managed by the kernel

>    *
>    * Return: cpumask array if successful, NULL otherwise. And each element
>    * includes CPUs assigned to this group

thanks,
-- 
js
suse labs


