Return-Path: <linux-fsdevel+bounces-28280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC124968E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0EBB20805
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8819CC22;
	Mon,  2 Sep 2024 19:08:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF11A3A98;
	Mon,  2 Sep 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304095; cv=none; b=p3vzszjm99V5wnn340YmXygAiQK4QLMWgBOjregPDbujI4YIj6N0Xd+LcvRA3AdJGb9aamsFiIBCpjOR4api/fq1A4mVi2jp1vtjC7Z/aQ3MqpGQkTdFiOmYuon47mz7PwinmAcMmbsvEXI+KZFwD+D/byLeZHqTAxVFb63u6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304095; c=relaxed/simple;
	bh=gVEYgyHdEpAGYFOHD7x27yBSQkNSfiEEw/kpvT4OFcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfjRwXz2vVNzvxeNAk8D2uB1Jpq9/sV9Sy4qulH+l+M2RkS0kOY4xMmRmP5rR0jH1NL7wWhyRyMUqKKpwfuMpYjVJ9ZfF5LurXu4akO0Sdi4AMw4ccUclKYI4tI7XgRAlxatSHgHkrcBIycYmXKUykR7A7ft4kRVzRwcRWcQPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCD8C4CEC2;
	Mon,  2 Sep 2024 19:08:10 +0000 (UTC)
Date: Mon, 2 Sep 2024 20:08:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <ZtYNGBrcE-j35fpw@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827113803.GB4318@willie-the-truck>

On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > +{
> > > > > > +	if (!system_supports_poe())
> > > > > > +		return;
> > > > > > +
> > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > 
> > > > > nit: typo "chaning".
> > > > > 
> > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > context of a new thread using a stale value for POR_EL0?
> > > > 
> > > > Not just prevent faults but enforce the permissions from the new
> > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > here, we can't tell.
[...]
> > > So what do we actually gain by having the uaccess routines honour this?
> > 
> > I guess where it matters is more like not accidentally faulting because
> > the previous thread had more restrictive permissions.
> 
> That's what I wondered initially, but won't the fault handler retry in
> that case?

Yes, it will retry and this should be fine (I assume you are only
talking about the dropping ISB in the context switch).

For the case of running with a more permissive stale POR_EL0, arguably it's
slightly more predictable for the user but, OTOH, some syscalls like
readv() could be routed through GUP with no checks. As with MTE, we
don't guarantee uaccesses honour the user permissions.

That said, at some point we should sanitise this path anyway and have a
single ISB at the end. In the meantime, I'm fine with dropping the ISB
here.

-- 
Catalin

