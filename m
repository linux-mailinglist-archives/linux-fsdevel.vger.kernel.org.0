Return-Path: <linux-fsdevel+bounces-19477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E648C5E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 01:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F2B210AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCED182C97;
	Tue, 14 May 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfRCS1xE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9yUGQPaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C12181D1B;
	Tue, 14 May 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727885; cv=none; b=MdPWXNRNxWRVXBm9LUL7ehRcsZz22Qxoygg41byuukxEkJy5J7FOotUY1+u8pRyWFdtYCEBE4brCKn6oQkxch+4+BBBvNv25S9ZP7G2w8GCBqGhNWY8no49xpoKWHoF6Fv2ZLKj/U56reN0uFZ5dcpWnyNarXixF7IN9h6vXH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727885; c=relaxed/simple;
	bh=gCqjA9RatKnkSLjN8bz5VWEWDMhZs/6qSocvM+g3FVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gN8IJk1y3FKZhYZ9d2WLhXETmQGnoIJYupby92sVg8mnPalh9sb3IuyFoj9SsiaJF/ZKI+zRCj0HHJUdn5XMYFjg8oEvFtD3SRyt8u4U5XJIT+ASKCG7kRdiLeMOS0QammJBzF01jvyfap9Epn4D9YW7gd86DP5Qr47a48MQBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfRCS1xE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9yUGQPaf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715727881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFDv0vTXoc2NMBBi7ioc7QN0hBYwdSMxX3SrQtikH04=;
	b=VfRCS1xEuVn0TC+V8CPKMMpTg3JuFGmi1jBVjByv6MhGaNzBh4z6C7kA+3FARjJ5etqwvK
	fQFirRS8V04Wmofl8iONlOluxowpu2mA9JNjAhhaBJFL6p4lhi/vcHRfT/XaaZj3itFEA4
	z+kNwnn7Nz5Y9g3APngnjKsXEib0+hJbKOr3iD2sXaVoWfPuO8a2+6wcafJvW+qe/B+1tL
	o2Havzb+6ZWtr5Z96r7wLQOZNJkNj8/PCkKccvigrqIBHljgUsqLIM8PduSQVSkV4bi+1l
	Uwig64GlLyIGqppecTYAtaiwl1kJoTmL38MAcZ55SieyQknnd1VcNYvTR8ooGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715727881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFDv0vTXoc2NMBBi7ioc7QN0hBYwdSMxX3SrQtikH04=;
	b=9yUGQPaf3z81Jk03mDqBPEV01Un1HjiWGSXjawU0tNT7Ltp0VCHiBBhc/2hgLDnJ7ogT/F
	Rnt3aFPXMmAugjAQ==
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jiwei Sun
 <sunjw10@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 2/2] genirq/proc: Refine percpu kstat_irqs access logic
In-Reply-To: <20240513120548.14046-3-ahuang12@lenovo.com>
References: <20240513120548.14046-1-ahuang12@lenovo.com>
 <20240513120548.14046-3-ahuang12@lenovo.com>
Date: Wed, 15 May 2024 01:04:41 +0200
Message-ID: <87h6f0knau.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 13 2024 at 20:05, Adrian Huang wrote:
> @@ -461,7 +461,7 @@ int show_interrupts(struct seq_file *p, void *v)
>  {
>  	static int prec;
>  
> -	unsigned long flags, any_count = 0;
> +	unsigned long flags, print_irq = 1;

What's wrong with making print_irq boolean?

>  	int i = *(loff_t *) v, j;
>  	struct irqaction *action;
>  	struct irq_desc *desc;
> @@ -488,18 +488,28 @@ int show_interrupts(struct seq_file *p, void *v)
>  	if (!desc || irq_settings_is_hidden(desc))
>  		goto outsparse;
>  
> -	if (desc->kstat_irqs) {
> -		for_each_online_cpu(j)
> -			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
> +	if ((!desc->action || irq_desc_is_chained(desc)) && desc->kstat_irqs) {

The condition is wrong. Look how the old code evaluated any_count.

> +		print_irq = 0;
> +		for_each_online_cpu(j) {
> +			if (data_race(*per_cpu_ptr(desc->kstat_irqs, j))) {
> +				print_irq = 1;
> +				break;
> +			}
> +		}

Aside of that this code is just fundamentally wrong in several aspects:

  1) Interrupts which have no action are completely uninteresting as
     there is no real information attached, i.e. it shows that there
     were interrupts on some CPUs, but there is zero information from
     which device they originated.

     Especially with sparse interrupts enabled they are usually gone
     shortly after the last action was removed.

  2) Chained interrupts do not have a count at all as they completely
     evade the core kernel entry points.

So all of this can be avoided and the whole nonsense can be reduced to:

	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
        	goto outsparse;

which in turn allows to convert this:

> -	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", desc->kstat_irqs ?
> -					*per_cpu_ptr(desc->kstat_irqs, j) : 0);

into an unconditional:

	for_each_online_cpu(j)
		seq_printf(p, "%10u ", *per_cpu_ptr(desc->kstat_irqs, j));

Thanks,

        tglx

