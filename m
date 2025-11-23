Return-Path: <linux-fsdevel+bounces-69514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC995C7E1B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BA413417EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F71DFDB8;
	Sun, 23 Nov 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjeiOOmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7E2116F4;
	Sun, 23 Nov 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763907433; cv=none; b=furI0jQ96tNCyUm1tsPGasqQ4RVpNLjhO37MleG461ubGH8tIuFVhK6ZdB2BWq8XL9hPjGc4md/Rkmz/+2XqgvWNXwhqcLvJTLlosBJyGxWYjkro291cY6rx/u8FeAuohPdC0VBV6SddkkBo4c/uI8BAXIMszFRwrulnox84DpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763907433; c=relaxed/simple;
	bh=hlZPMSOQ4z0z/SegnqaJGdOFl8OKu7ej64VHNnxKfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohtnC6LPjiyA0Se2Dak8g+BLi3aNjEg5iO/1VTK0bJMWYAGXJL8TtHHyHUZFFpfc3vhKADTnAbPCSbp5ttbJG+svToaoLpomOzjOmrQhUGm+46SQUhXAmIbFPwcGaDfb/IutNDC4bChxJvveDbm0NRmqk7jxodXqMK4fCoqT6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjeiOOmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2161C113D0;
	Sun, 23 Nov 2025 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763907432;
	bh=hlZPMSOQ4z0z/SegnqaJGdOFl8OKu7ej64VHNnxKfOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjeiOOmGhl+vYDAP5F3PqObgaBOeH09evuz0Mon8ZYyijzYcypbmuTWlbd8UfY7Li
	 JZxMGVMZgNCugT4C58X01ElFJQ7xeyDEkELKARcivirljBnNMlKQRg+eo4HP87DheV
	 d6gwf1Hyzc/jM57nVWZpS0YtC9d8uBqv/keFn2kFLpgIdX+rHTQkJLC5OLqVPJwWW5
	 tFw+JC6n5hxX0w6FpLsk3sxbPfnJ/lP2jbAlrVoDP26ZyJahCDcEO0mYRVCOKUo16l
	 NAzmmdLtATyY2laWAECozqHTeL9Y16n+A4yLTqSpw5/pbcWrbU1j2Epmj8i6sOVzfL
	 rWZi7jYZsMMMA==
Date: Sun, 23 Nov 2025 16:16:48 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aSMXUKMhroThYrlU@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com>
 <aSLvo0uXLOaE2JW6@kernel.org>
 <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>

On Sun, Nov 23, 2025 at 07:03:19AM -0500, Pasha Tatashin wrote:
> On Sun, Nov 23, 2025 at 6:27 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Nov 22, 2025 at 05:23:29PM -0500, Pasha Tatashin wrote:
> > > Integrate the LUO with the KHO framework to enable passing LUO state
> > > across a kexec reboot.
> > >
> > > This patch implements the lifecycle integration with KHO:
> > >
> > > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> > >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> > >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> > >    track the update count.
> > >
> > > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> > >    allocates a new FDT for the next kernel, populates it with the basic
> > >    header (compatible string and incremented update number), and
> > >    registers it with KHO (`kho_add_subtree`).
> > >
> > > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invoke
> > >    `kho_finalize()`. This ensures that all memory segments marked for
> > >    preservation are properly serialized before the kexec jump.
> > >
> > > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  include/linux/kho/abi/luo.h      |  54 +++++++++++
> > >  kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
> > >  kernel/liveupdate/luo_internal.h |  22 +++++
> > >  3 files changed, 229 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/linux/kho/abi/luo.h
> > >  create mode 100644 kernel/liveupdate/luo_internal.h
> > >
> > > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> > > new file mode 100644
> > > index 000000000000..8523b3ff82d1
> > > --- /dev/null
> > > +++ b/include/linux/kho/abi/luo.h
> > > @@ -0,0 +1,54 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (c) 2025, Google LLC.
> > > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > > + */
> > > +
> > > +/**
> > > + * DOC: Live Update Orchestrator ABI
> > > + *
> > > + * This header defines the stable Application Binary Interface used by the
> > > + * Live Update Orchestrator to pass state from a pre-update kernel to a
> > > + * post-update kernel. The ABI is built upon the Kexec HandOver framework
> > > + * and uses a Flattened Device Tree to describe the preserved data.
> > > + *
> > > + * This interface is a contract. Any modification to the FDT structure, node
> > > + * properties, compatible strings, or the layout of the `__packed` serialization
> > > + * structures defined here constitutes a breaking change. Such changes require
> > > + * incrementing the version number in the relevant `_COMPATIBLE` string to
> > > + * prevent a new kernel from misinterpreting data from an old kernel.
> >
> > From v6 thread:
> >
> > > > I'd add a sentence that stresses that ABI changes are possible as long they
> > > > include changes to the FDT version.
> > > > This is indeed implied by the last paragraph, but I think it's worth
> > > > spelling it explicitly.
> > > >
> > > > Another thing that I think this should mention is that compatibility is
> > > > only guaranteed for the kernels that use the same ABI version.
> > >
> > > Sure, I will add both.
> >
> > Looks like it fell between the cracks :/
> 
> Hm, when I was updating the patches, I included the first part, and
> then re-read the content, and I think it covers all points:
> 
> 1. Changes are possible
> This interface is a contract. Any modification to the FDT structure, node
>  * properties, compatible strings, or the layout of the `__packed` serialization
>  * structures defined here constitutes a breaking change. Such changes require
>  * incrementing the version number in the relevant `_COMPATIBLE` string
> 
> So, change as long as you update versioning number
> 
> 2. Breaking if version is different:
> to prevent a new kernel from misinterpreting data from an old kernel.
> 
> So, the next kernel can interpret only if the version is the same.
> 
> Which point do you think is not covered?

As I said, it's covered, but it's implied. I'd prefer these stated
explicitly.

> > > +static int __init liveupdate_early_init(void)
> > > +{
> > > +     int err;
> > > +
> > > +     err = luo_early_startup();
> > > +     if (err) {
> > > +             luo_global.enabled = false;
> > > +             luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> > > +                              ERR_PTR(err));
> >
> > What's wrong with a plain panic()?
> 
> Jason suggested using the luo_restore_fail() function instead of
> inserting panic() right in code somewhere in LUOv3 or earlier. It
> helps avoid sprinkling panics in different places, and also in case if
> we add the maintenance mode that we have discussed in LUOv6, we could
> update this function as a place where that mode would be switched on.

I'd agree if we were to have a bunch of panic()s sprinkled in the code.
With a single one it's easier to parse panic() than lookup what
luo_restore_fail() means.
 
> > > +     }
> > > +
> > > +     return err;
> > > +}
> > > +early_initcall(liveupdate_early_init);
> > > +
> >
> > ...
> >
> > >  int liveupdate_reboot(void)
> > >  {
> > > -     return 0;
> > > +     int err;
> > > +
> > > +     if (!liveupdate_enabled())
> > > +             return 0;
> > > +
> > > +     err = kho_finalize();
> > > +     if (err) {
> > > +             pr_err("kho_finalize failed %d\n", err);
> >
> > Nit: why not %pe?
> 
> I believe, before my last clean-up of KHO it could return FDT error in
> addition to standard errno; but anyways, this code is going to be
> removed soon with stateless KHO, keeping err instead of %pe is fine (I
> can change this if I update this patch).

Nah, %d is ok.
 
> > > +             /*
> > > +              * kho_finalize() may return libfdt errors, to aboid passing to
> > > +              * userspace unknown errors, change this to EAGAIN.
> > > +              */
> > > +             err = -EAGAIN;
> > > +     }
> > > +
> > > +     return err;
> > >  }
> > >
> > >  /**
> > > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> > > new file mode 100644
> > > index 000000000000..8612687b2000
> > > --- /dev/null
> > > +++ b/kernel/liveupdate/luo_internal.h
> > > @@ -0,0 +1,22 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (c) 2025, Google LLC.
> > > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > > + */
> > > +
> > > +#ifndef _LINUX_LUO_INTERNAL_H
> > > +#define _LINUX_LUO_INTERNAL_H
> > > +
> > > +#include <linux/liveupdate.h>
> > > +
> > > +/*
> > > + * Handles a deserialization failure: devices and memory is in unpredictable
> > > + * state.
> > > + *
> > > + * Continuing the boot process after a failure is dangerous because it could
> > > + * lead to leaks of private data.
> > > + */
> > > +#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
> >
> > Let's add this when we have more than a single callsite.
> > Just use panic() in liveupdate_early_init() and add the comment there.
> 
> https://lore.kernel.org/all/CA+CK2bBEX6C6v63DrK-Fx2sE7fvLTZM=HX0y_j4aVDYcfrCXOg@mail.gmail.com/
> 
> This is the reason I added this function. I like the current approach.

v2 had way more than a single panic(), then it made sense
 
> Pasha

-- 
Sincerely yours,
Mike.

