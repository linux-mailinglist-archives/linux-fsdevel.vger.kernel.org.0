Return-Path: <linux-fsdevel+bounces-33400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334AB9B898C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9FA1F2284E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627B13D897;
	Fri,  1 Nov 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cGhmaTsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50113CABC;
	Fri,  1 Nov 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430208; cv=none; b=VjI4CYzzuCDY3Eha3grPHEjSmoulR1xTRb5P8pkU7Sk5NBTgVFZPaY3zG7rZEMHr7Gm7pqxdFOE/p+N9ttGkQAPGDgVJQRvppX9KQkdmJoWDaYvWVeBDKOduxm6lamhOJgJXlqAxI0XnY5hn6dS0D+Lr29afGPy4LV8PKsQ4vsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430208; c=relaxed/simple;
	bh=y8yW7zcDDjfMePg5zhO73d5G3dBGBJ+0ZlV2Vk5qn0o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VFQ0RTdc212GQKBEsNrvdqe4FwsZP317OZxSsbSQOWYieWJCCoHkU8slCfAxMgaFohsWoV6TJZq1V4XI5/YcDIglKofxh+JtdDj/sfzOUROjl1frNAP4vR8rlX5PhrGAFYFosOUBH0I9N7lHzRduRX1pgRFt8psNRfyzPg5LmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cGhmaTsb; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730430201; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=lHTFluFn91Zgm50b/7m57y+ytTEX564G7atSqw12Uyc=;
	b=cGhmaTsb8/XMusaCd7fl8mpaoKg3/Lh/ZeUojnSnkfvmilMgHf8/rV+IV0BDL4RCjphDNiLoE0ex7OtqQnnOtswIEmGmGCJiV9A0NP8aO2/XhQXhlzSUdJwjrzYxOvnVDOry3t6eSlbLSDtLLDAb44vyfUsgEe7bF89lP7bYis0=
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WIKwQpa_1730430199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 11:03:20 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
From: mapicccy <guanjun@linux.alibaba.com>
In-Reply-To: <87v7x8woeq.ffs@tglx>
Date: Fri, 1 Nov 2024 11:03:08 +0800
Cc: corbet@lwn.net,
 axboe@kernel.dk,
 mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 vgoyal@redhat.com,
 stefanha@redhat.com,
 miklos@szeredi.hu,
 peterz@infradead.org,
 akpm@linux-foundation.org,
 paulmck@kernel.org,
 thuth@redhat.com,
 rostedt@goodmis.org,
 bp@alien8.de,
 xiongwei.song@windriver.com,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9847EC49-8F55-486A-985D-C3EDD168762D@linux.alibaba.com>
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com> <87v7x8woeq.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> 2024=E5=B9=B410=E6=9C=8831=E6=97=A5 18:35=EF=BC=8CThomas Gleixner =
<tglx@linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Oct 31 2024 at 15:46, guanjun@linux.alibaba.com wrote:
>> #ifdef CONFIG_SMP
>>=20
>> +static unsigned int __read_mostly managed_irqs_per_node;
>> +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] =
__cacheline_aligned_in_smp =3D {
>> +	[0 ... MAX_NUMNODES-1] =3D {CPU_BITS_ALL}
>> +};
>>=20
>> +static void __group_prepare_affinity(struct cpumask *premask,
>> +				     cpumask_var_t *node_to_cpumask)
>> +{
>> +	nodemask_t nodemsk =3D NODE_MASK_NONE;
>> +	unsigned int ncpus, n;
>> +
>> +	get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
>> +
>> +	for_each_node_mask(n, nodemsk) {
>> +		cpumask_and(&managed_irqs_cpumsk[n], =
&managed_irqs_cpumsk[n], premask);
>> +		cpumask_and(&managed_irqs_cpumsk[n], =
&managed_irqs_cpumsk[n], node_to_cpumask[n]);
>=20
> How is this managed_irqs_cpumsk array protected against concurrency?

My intention was to allocate up to `managed_irq_per_node` cpu bits from =
`managed_irqs_cpumask[n]`,
even if another task modifies some of the bits in the =
`managed_irqs_cpumask[n]` at the same time.

>=20
>> +		ncpus =3D cpumask_weight(&managed_irqs_cpumsk[n]);
>> +		if (ncpus < managed_irqs_per_node) {
>> +			/* Reset node n to current node cpumask */
>> +			cpumask_copy(&managed_irqs_cpumsk[n], =
node_to_cpumask[n]);
>=20
> This whole logic is incomprehensible and aside of the concurrency
> problem it's broken when CPUs are made present at run-time because =
these
> cpu masks are static and represent the stale state of the last
> invocation.

Sorry, I realize there is indeed a logic issue here (caused by =
developing on 5.10 LTS and rebase to the latest linux-next).

>=20
> Given the limitations of the x86 vector space, which is not going away
> anytime soon, there are only two options IMO to handle such a =
scenario.
>=20
>   1) Tell the nvme/block layer to disable queue affinity management
>=20
>   2) Restrict the devices and queues to the nodes they sit on

I have tried fixing this issue through nvme driver, but later discovered =
that the same issue exists with virtio net.
Therefore, I want to address this with a more general solution.

Thanks,
Guanjun

>=20
> Thanks,
>=20
>        tglx


