Return-Path: <linux-fsdevel+bounces-68060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FAC52807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97733BA3A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314F33970F;
	Wed, 12 Nov 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuXf8Iy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FA32D44F;
	Wed, 12 Nov 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953929; cv=none; b=ZqvvPlt7FukgaAW20BAZAbkfKcPyXwL/77/mxFXCxsa2OUufuXFYZwjSEW/XRnUwMluCJUgL1PgyIw/B3Wu0kv8f83W3wVT07wK6eXqt008paEH4zVzI7+XsuqMLSmoEs+n78OdV1yRg8BnTPxg5U9eoJg++bAyZon6o6f1yVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953929; c=relaxed/simple;
	bh=0L4I5YakZvITlyeB7zaJSYGUCZoIKpW33DPBC2WOOhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftgPwbIIG7GgB6oe1Vybvf50eNlCapkhD/6Zy12KJhm+1Rl6U5TmY1vfkph1LIIXjqpcCEuqrHqwz3FPZXvsY41PH8sjKBGNm6SOc5kFL6zeHsmxIGLyWDmMZNZMa8PeeW6+uVa3We3rYubXobtiC43UyJKo0s4Y+8NH+gdtuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuXf8Iy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16109C16AAE;
	Wed, 12 Nov 2025 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762953928;
	bh=0L4I5YakZvITlyeB7zaJSYGUCZoIKpW33DPBC2WOOhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuXf8Iy+r0eY2kUE7hNwEY3/woXsoN7mLLb0NujdRDnGnxWsUwW61gwcXje3J84z4
	 B3/yjjUcJLgZz+Z63i2LjQpS2xfQ308sv9sRWCv/JMCr+xz6rxzPHlAb+EIGZDMMcl
	 +4BJ5OyXy1HSzx36sq+0a/dYIJuQqqf03VW94U30S6eWt3+ZrvU9aDMFk2zcRDN8iX
	 sLbX+QhHTEbyi6hp2/eWg7aUEYD/KYgV1FvYa5w1MO3SBpUSY2kF0rFvNKOhzSjCjU
	 MFbxZY4wDY5r7NZTXeppRfA1WRwj4O7n5KTZrdrUJEUF2x466Y0AkWfrUxTDXAc225
	 gY47Gsfbb3eQQ==
Date: Wed, 12 Nov 2025 15:25:03 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aRSKrxfAb_GG_2Mw@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
 <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
 <aROZi043lxtegqWE@kernel.org>
 <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>

Hi Pasha,

On Tue, Nov 11, 2025 at 03:57:39PM -0500, Pasha Tatashin wrote:
> Hi Mike,
> 
> Thank you for review, my comments below:
> 
> > > This is why this call is placed first in reboot(), before any
> > > irreversible reboot notifiers or shutdown callbacks are performed. If
> > > an allocation problem occurs in KHO, the error is simply reported back
> > > to userspace, and the live update update is safely aborted.

The call to liveupdate_reboot() is just before kernel_kexec(). Why we don't
move it there?

And all the liveupdate_reboot() does if kho_finalize() fails it's massaging
the error value before returning it to userspace. Why kernel_kexec() can't
do the same?

> > This is fine. But what I don't like is that we can't use kho without
> > liveupdate. We are making debugfs optional, we have a way to call
> 
> Yes you can: you can disable liveupdate (i.e. not supply liveupdate=1
> via kernel parameter) and use KHO the old way: drive it from the
> userspace. However, if liveupdate is enabled, liveupdate becomes the
> driver of KHO as unfortunately KHO has these weird states at the
> moment.

The "weird state" is the point where KHO builds its FDT. Replacing the
current memory tracker with one that does not require serialization won't
change it. We still need a way to tell KHO that "there won't be new nodes
in FDT, pack it".
 
> > kho_finalize() on the reboot path and it does not seem an issue to do it
> > even without liveupdate. But then we force kho_finalize() into
> > liveupdate_reboot() allowing weird configurations where kho is there but
> > it's unusable.
> 
> What do you mean KHO is there but unusable, we should not have such a state...

If you compile a kernel with KEXEC_HANDOVER=y, KEXEC_HANDOVER_DEBUGFS=n and
LIVEUPDATE=n and boot with kho=1 there is nothing to trigger
kho_finalize().
 
> > What I'd like to see is that we can finalize KHO on kexec reboot path even
> > when liveupdate is not compiled and until then the patch that makes KHO
> > debugfs optional should not go further IMO.
> >
> > Another thing I didn't check in this series yet is how finalization driven
> > from debugfs interacts with liveupdate internal handling?
> 
> I think what we can do is the following:
> - Remove "Kconfig: make debugfs optional" from this series, and
> instead make that change as part of stateless KHO work.
> - This will ensure that when liveupdate=0 always KHO finalize is fully
> support the old way.
> - When liveupdate=1 always disable KHO debugfs "finalize" API, and
> allow liveupdate to drive it automatically. It would add another
> liveupdate_enable() check to KHO, and is going to be removed as part
> of stateless KHO work.

KHO should not call into liveupdate. That's layering violation.
And "stateless KHO" does not really make it stateless, it only removes the
memory serialization from kho_finalize(), but it's still required to pack
the FDT.

I think we should allow kho finalization in some form from kernel_kexec().

When kho=1 and liveupdate=0, it will actually create the FDT if there was
no previous trigger from debugfs or it will continue with FDT created by
explicit request via debugfs.

When liveupdate=1, liveupdate_reboot() may call a function that actually
finalizes the state to allow safe rollback (although in the current patches
it does not seem necessary). And then kho_finalize() called from
kernel_kexec() will just continue with the state created by
liveupdate_reboot().  If we already finalized the kho state via debugfs,
liveupdate_reboot() can either error out or reset that state.

> Pasha
> 

-- 
Sincerely yours,
Mike.

