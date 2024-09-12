Return-Path: <linux-fsdevel+bounces-29150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A739766F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3792B285C41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680A1A0BC5;
	Thu, 12 Sep 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTtjO0Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB6149E03;
	Thu, 12 Sep 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138227; cv=none; b=aDzamoUhqs/cPDPfZWzdLnhKyo9IHiPLwMZSzvrcoqWgEdB7u6r+p7kgXiyNQXc9gQk8XAjHqz/0lE/XtQYmAq/lLZobNflWd/aLPPxqDYb4eEI5uZ/r6zGvYygoq2Ic3Mfe5nCdGTXbZrzrbL5uiVkqP6nuCvgnz4hAZn/F/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138227; c=relaxed/simple;
	bh=qZoGoOh6X8sZEkgedzpNuHuqZxsxfBCZB2KTDdNYKss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC7oUUQLO0yN6rabuuGVqgwkBeQ+yI5kcua1lvSeUMznzXu6HN5m1xBn5QtO6K0E80lYzWY1uI3IIlSVu+KIOYNtHW/GSJfwfe6zchwXUkdla4YI2xzRFOsZioMMDIiuyBHuCVwZrMZxgiTqJ4R36xcybvBLECPll07JPcZ+xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTtjO0Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F63C4CEC3;
	Thu, 12 Sep 2024 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726138226;
	bh=qZoGoOh6X8sZEkgedzpNuHuqZxsxfBCZB2KTDdNYKss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTtjO0Cfd7tkU1BMgFiga+fsrzZ9RZLla49qSZtD6IB+wb//kcv1pcCBoGV6o4I4m
	 G1wXKo0/D/uODveW0Dj266lXbV6cEBbn8DzNEx7nGus4bUNZK5XKZHYZE/cxZmjguq
	 h9sjj8h+uq8aq6VA2If3DNsj8fEoZ/PZYgilsV1hwIpsBp5q7mQ597FhFm9pCzPsmV
	 WhFLRH7P9gQzrwbFzg4HfakU6ZdPiILkcPais1me+xmBZfigLQXauBvJZx0GqSMgHK
	 M80cWMxsBzCWfU/+AfeLZt9ASKvx0eEt/Pjpfh74bKbs6F0WFUlIRAy7BMaYsMh8C/
	 HJW6qTM5+QJSg==
Date: Thu, 12 Sep 2024 11:50:18 +0100
From: Will Deacon <will@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <20240912105017.GA22788@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <425b8f8c-b6b5-422a-b5f4-41dd2d1ae3bb@arm.com>
 <6c8ad091-a56b-41ba-b403-2e3c2e578100@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8ad091-a56b-41ba-b403-2e3c2e578100@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Dave,

On Wed, Sep 11, 2024 at 08:33:54AM -0700, Dave Hansen wrote:
> On 9/11/24 08:01, Kevin Brodsky wrote:
> > On 22/08/2024 17:10, Joey Gouly wrote:
> >> @@ -371,6 +382,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >>  		if (system_supports_tpidr2())
> >>  			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
> >>  
> >> +		if (system_supports_poe())
> >> +			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > Here we are only reloading POR_EL0's value if the target is a user
> > thread. However, as this series stands, POR_EL0 is also relevant to
> > kthreads, because any uaccess or GUP done from a kthread will also be
> > checked against POR_EL0. This is especially important in cases like the
> > io_uring kthread, which accesses the memory of the user process that
> > spawned it. To prevent such a kthread from inheriting a stale value of
> > POR_EL0, it seems that we should reload POR_EL0's value in all cases
> > (user and kernel thread).
> 
> The problem with this is trying to figure out which POR_EL0 to use.  The
> kthread could have been spawned ages ago and might not have a POR_EL0
> which is very different from the current value of any of the threads in
> the process right now.
> 
> There's also no great way for a kthread to reach out and grab an updated
> value.  It's all completely inherently racy.
> 
> > Other approaches could also be considered (e.g. resetting POR_EL0 to
> > unrestricted when creating a kthread), see my reply on v4 [1].
> 
> I kinda think this is the only way to go.  It's the only sensible,
> predictable way.  I _think_ it's what x86 will end up doing with PKRU,
> but there's been enough churn there that I'd need to go double check
> what happens in practice.

I agree.

> Either way, it would be nice to get an io_uring test in here that
> actually spawns kthreads:
> 
> 	tools/testing/selftests/mm/protection_keys.c

It would be good to update Documentation/core-api/protection-keys.rst
as well, since the example with read() raises more questions than it
answers!

Kevin, Joey -- I've got this series queued in arm64 as-is, so perhaps
you could send some patches on top so we can iron this out in time for
6.12? I'll also be at LPC next week if you're about.

Cheers,

Will

