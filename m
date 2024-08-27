Return-Path: <linux-fsdevel+bounces-27357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE39608E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CEB22984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A81A00E2;
	Tue, 27 Aug 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpf8ddOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105019DF82;
	Tue, 27 Aug 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758692; cv=none; b=oM4eFY4LzYaZo3rV+QQ80B747RGKwi4anxxF3luzC7p34h5ljWIEoAT8dlLJnotQnSa/WEHgWwVGUKsnkyQvt0+p72K4HkRxqdiSpHkRHPxBIgX5Dv6eNBocTpVvQxL9WUnQtfdYGTAUOb4nNhVkPLWd6MXOgCxTbOkfCCJUv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758692; c=relaxed/simple;
	bh=2+A2bF7Lj9wuQUwEpvgzmZKK3imkhu2KCOi7wnoixak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXgsdoAQlp21dyu9f+5tkWlLgTSMZNQFo44ol2/4f603pF7RxVPIB/me551QVnyez/9XLLlXuKN3c+ztjfNbniDqt4/NltYPVRq+FWxw5FLYA7IbdDkqbOHMvBAw3qWRKD+TvssFlu1aiMeUATbLe6+viHBO1eRTzUdVz2Scx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpf8ddOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A82C582AB;
	Tue, 27 Aug 2024 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758692;
	bh=2+A2bF7Lj9wuQUwEpvgzmZKK3imkhu2KCOi7wnoixak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gpf8ddOXDK2vLQMMp3FzmG/a/m/kr0GXzqv0V69de1kGXjsWZZVM5il9nZ3rJgJ/C
	 HhCk9FpXwrs24xGKZufPQ6AVtvbP5tMYwDBYGmyjXUFSAs0/qqunKiRjR5cHaGfdBj
	 NELnVGfuXrKZce7YLlJBXHfzEBMziXjXhbc2oCx/U/canba16aHthF+qGabnfRBtoM
	 BP6yHu6nKpM6xKRbubnCGD2Di4NReNtwAwTcMpZZI8xnW+1KjwLJ14ftgHU2j0y4CR
	 5qpdVZJYRS0/PkwK6KW2GK7c8ijyUvbxdWydqc2U6Yg0gjukfhNJnDfFkqe+yURXpL
	 dMagJjNp/hQXA==
Date: Tue, 27 Aug 2024 12:38:04 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20240827113803.GB4318@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsjXtE7Kg0LQwNAL@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > +{
> > > > > +	if (!system_supports_poe())
> > > > > +		return;
> > > > > +
> > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > 
> > > > nit: typo "chaning".
> > > > 
> > > > But more substantially, is this just to prevent spurious faults in the
> > > > context of a new thread using a stale value for POR_EL0?
> > > 
> > > Not just prevent faults but enforce the permissions from the new
> > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > here, we can't tell.
> > 
> > Hmm, I wondered if that was the case. It's a bit weird though, because:
> > 
> >   - There's a window between switch_mm() and switch_to() where you might
> >     reasonably expect to be able to execute uaccess routines
> 
> I don't think we can have any uaccess between these two switches (a
> uaccess could fault, that's a pretty weird state between these two).
> 
> >   - kthread_use_mm() doesn't/can't look at this at all
> 
> No, but a kthread would have it's own, most permissive, POR_EL0.
> 
> >   - GUP obviously doesn't care
> > 
> > So what do we actually gain by having the uaccess routines honour this?
> 
> I guess where it matters is more like not accidentally faulting because
> the previous thread had more restrictive permissions.

That's what I wondered initially, but won't the fault handler retry in
that case?

Will

