Return-Path: <linux-fsdevel+bounces-33337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2449B78BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10789285D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0B19993C;
	Thu, 31 Oct 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKbHW0rV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TLt1D345"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDD198E83;
	Thu, 31 Oct 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370929; cv=none; b=LC6yqUNriMMqUcRbIrertu9cojfjpzXx4R3+oMR+uRqXdd9sfMi4ICV8rZsj2uxSraaVRM18h4E1uWlWX/nrGwrA+fRotJzU7TOLIAM+likRdKpoyMgnYeYkiAIExzTqhQ+EKjsgBF9l7/I6cqVARNBoaDxuCmYgwYGdRMGZP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370929; c=relaxed/simple;
	bh=HGfYcbWzyY/pphTro6/s6a+Kh+oae02HLrDhGMTUe4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5rzc8nLJnk0tryJv6YNtFWtUUesqxoarSgL7ixQ1U8ch1ARxgBnWI2q/eX8VIqtgTN84X5Li3hSWOqgSWq98j5zhKTJG7w4QCfudADGMLe2gh4MO/O3THl1tcBEW2IrRertStEjrkXf4Xrz4YzujNSnxqSY7zue01KT3PbCCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKbHW0rV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TLt1D345; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730370925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBPHRJ37/z1B53qNd6uBe1APGZjWPgW1reRRNqIUu/4=;
	b=bKbHW0rVMi8RCIkVGzUpoDjf9iS5/VswyqW0KMK3cgemvAhIXknUVzbFicW3dRGfdfEIMa
	vFLd/2n6A5lAZKAAzaD3kUq2GbxbJvX6orpz1LVCzZHKUubDM0EIs3Iz0e4yte5cRwZcXi
	jcTY/VAGwFbVWkZrL55F0OvAYEVeuVOH4AJC/SxMYkfijsY7vgEWG4C610TEfmZQEnWJBT
	zAFCXgoSW76EtgqvTvp1cH0RnK8Ojrq4ulIQIxJ9GSsf0tjOibsZfW3CFeaWh+0h+yfpgm
	gCfAABNhAjvIb29dBcqBdu3GnXdamybTjSmY0JzwKwegKJ5S0zdjwgAOAxoN9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730370925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBPHRJ37/z1B53qNd6uBe1APGZjWPgW1reRRNqIUu/4=;
	b=TLt1D345qYuyG6x5hkvMwOQmO/yYwc+NFGn0mEetJMcpkFBq1K14mR7VLbIfNAKZpKZDzi
	adIbCVnaBBv2J6AQ==
To: 'Guanjun' <guanjun@linux.alibaba.com>, corbet@lwn.net, axboe@kernel.dk,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu, peterz@infradead.org, akpm@linux-foundation.org,
 paulmck@kernel.org, thuth@redhat.com, rostedt@goodmis.org, bp@alien8.de,
 xiongwei.song@windriver.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
Cc: guanjun@linux.alibaba.com
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
In-Reply-To: <20241031074618.3585491-2-guanjun@linux.alibaba.com>
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com>
Date: Thu, 31 Oct 2024 11:35:25 +0100
Message-ID: <87v7x8woeq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 15:46, guanjun@linux.alibaba.com wrote:
>  #ifdef CONFIG_SMP
>  
> +static unsigned int __read_mostly managed_irqs_per_node;
> +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_aligned_in_smp = {
> +	[0 ... MAX_NUMNODES-1] = {CPU_BITS_ALL}
> +};
>  
> +static void __group_prepare_affinity(struct cpumask *premask,
> +				     cpumask_var_t *node_to_cpumask)
> +{
> +	nodemask_t nodemsk = NODE_MASK_NONE;
> +	unsigned int ncpus, n;
> +
> +	get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
> +
> +	for_each_node_mask(n, nodemsk) {
> +		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], premask);
> +		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], node_to_cpumask[n]);

How is this managed_irqs_cpumsk array protected against concurrency?

> +		ncpus = cpumask_weight(&managed_irqs_cpumsk[n]);
> +		if (ncpus < managed_irqs_per_node) {
> +			/* Reset node n to current node cpumask */
> +			cpumask_copy(&managed_irqs_cpumsk[n], node_to_cpumask[n]);

This whole logic is incomprehensible and aside of the concurrency
problem it's broken when CPUs are made present at run-time because these
cpu masks are static and represent the stale state of the last
invocation.

Given the limitations of the x86 vector space, which is not going away
anytime soon, there are only two options IMO to handle such a scenario.

   1) Tell the nvme/block layer to disable queue affinity management

   2) Restrict the devices and queues to the nodes they sit on

Thanks,

        tglx

