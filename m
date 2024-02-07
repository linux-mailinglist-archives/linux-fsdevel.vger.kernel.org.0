Return-Path: <linux-fsdevel+bounces-10622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37A84CDE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500E91C260B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7A17FBC3;
	Wed,  7 Feb 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f6DkeyLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4787F7F5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319345; cv=none; b=kXQvWIkygwYI+kgrkq3RVMd2EofEyD7h4dG1G1Nv7ORmdT0uX+G6T0t+GnmP7ddTHROvWcwZjQxZa1H9AqhcHFLiVOlMLmHy8ChvTX/lwC0CB4iS2xrQT0VcFfhRoKoEmegrdqN4UkF222N9QTTXkzcty/vJTsEV/wmu4czsgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319345; c=relaxed/simple;
	bh=y2+ixwCrJlL98/rFoHOQ2dy/0y39rOCotwOZnAyaaIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1gZ6sq7Xtrx6TL3UeY2a/54oPnA2lGmZ05Aq10RSwtKQduPiwIPAzS9M9JyEpeFZrzcBv9EdrUNDmCXMHOQhzDwOAfgiq8U30P9LwTi0EIi/vciurSUjToCDljTvqFQAZ8snZq4nTK4N9rRoBgstHjZbDtb/OdQgoR6I3CfULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f6DkeyLK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a1896b45eso270254eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707319343; x=1707924143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXuoUtlFYAMq0mxsqrcVmWz5P/ig/5TnpdupOSgG5vo=;
        b=f6DkeyLK2SE7BY4ELpEH/lbJtejO7choEGk9PkV+HMD+YUK+TUSRjC3XEpxidw5oGK
         CNIZcBqlceqBJoGagLYbGxV9cU/ueHWYNSqkEbrFiPN84bD3fckBm2yFUQboG1dFD4JM
         Ro0vZs+kLeXdUCm7q/LJWDz+43LqQWDwMhxQOPQ3CCSS8+w53Ktb+Vr4DaMH9CGc7fk7
         LWJyoBzUyqYsQuFrF5voyt2NiRhwBCdzJysALwB6QrpLna6ctEtLpcE2yxXZhuVz+OQz
         GFNs45RTa2rr21dlbTvmWU+a+byCUMVgR1fYLUhCLsNHEfkvIjYENMjmQYb4U0eYgFFP
         068Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319343; x=1707924143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXuoUtlFYAMq0mxsqrcVmWz5P/ig/5TnpdupOSgG5vo=;
        b=RDbAAKBFJ/3b2nohxmuTaM0QZQyNVQoUtvqxJPqAafEa9owTHQkUEaPtt/NrIdvRAD
         mfJ+dIud7h/ewmNGEAGPqiqJzAbPwiX9cy9i7PrKqQeAH3beycmYJMwzb7T/5UqfdQZl
         XuO3tOh8YcNNuShIGA45Tf5DbhtLMz7dc5hNOzHSCjaFLu7X6U7hi8nByBKCXBGTZfuV
         skQ2wvk/nqOlSmJ+bxGpwdm773CaKulaYlFs+GUUDokb6tqY00p7Bsa7ZgCaGRQv43zd
         n1yjIJNCd0cyzNfu6xoVCHNJd1bLVkrBWZSD+eg6Mt18cPTv1WbkQuiLwHD/Yg7k5uN7
         xKdg==
X-Gm-Message-State: AOJu0YxyE9Nf1guBUQUPZiK4cfmCHAVYJWSr7mqKskRD4g0XOj/tn/Jd
	elRqF1zXQcin1+oal09vF7vbJXI1i8+UEeFmu6n4RLsAE+gYU+aaSLLHOWfQzII=
X-Google-Smtp-Source: AGHT+IEU9d6tiASyetFtinfn76+eYul26J1pERlMLisD1fypSRV2TkE+6QjH/VPGxqwfr8LcAXvuow==
X-Received: by 2002:a4a:6c44:0:b0:59a:e669:a37c with SMTP id u4-20020a4a6c44000000b0059ae669a37cmr4640190oof.1.1707319342629;
        Wed, 07 Feb 2024 07:22:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlZUQlzB5nEGYzlfQNjBmy6WGyBIFOav0ILKGadYFljPZ2+oGD8Twtia/0iJf6U9tFIdLqhHXVahOG/XmoUubZJMeEM4rpVPpvZ0FStTNoXfsDkHIXZMeXUzGkuW4a/PztUH6CmF0X1Bbc1WYwb06iSmm6d9F4StU6fcWish9bCZSRmHUtE8R7uIYWrzNa9gzQGKvLkgNZMz0HqbU4bJbpYr81DgfQdWezcwzyUcAgnqAt2Q1YMlLehKQqDyLWGWbhzABh/f6k7SKlXXHFXCEc+pPvIof+SHSyIUht14U8WbRPGH4EzuiTHc9If8tkJJM07AmzYBSXqZCtp0IBWQkdq/kZdK430lMKxOMvTvHFJ/fHM9EHk8eApsESQ08rJx5oMxyjhwwU/7mVZx8Dq80XBtLo4831p9M1sIEU8y/VSynG962PfZWiwyMEfnlPwpfYoKN9RiyP3LRbH9iNX14tn4MwMzvMTzA9ifpOK7SvuCeQ/s8VUYy5LAElj/YwwSUw4meZ3+l0xN8XKzk+5yZdHmNShWVBNIZthCZOI182evPfkmLFq1gW8vT1rMJ1P6JJVSb2mNthFexHaWKalNIzNCENO4mgF5b5xaVvhG0nLWjdxHCozKQQ+eOeukMiNvmgslukCZUHnL7EZrV6SFEbYuxFKOkVfzSmf8gMW9rcFW7d
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k5-20020a4a3105000000b0059cf1cddca5sm253713ooa.34.2024.02.07.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:22:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjkj-008bE7-0x;
	Wed, 07 Feb 2024 11:22:21 -0400
Date: Wed, 7 Feb 2024 11:22:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240207152221.GK31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205174238.GC31743@ziepe.ca>
 <8e4cc7fd4c7cb14a8942e15a676e5b95e6f44b43.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e4cc7fd4c7cb14a8942e15a676e5b95e6f44b43.camel@amazon.com>

On Wed, Feb 07, 2024 at 02:45:42PM +0000, Gowans, James wrote:
> Hi Jason,
> 
> Thanks for this great feedback on the approach - it's exactly the sort
> of thing we were looking for.
> 
> On Mon, 2024-02-05 at 13:42 -0400, Jason Gunthorpe wrote:
> > 
> > On Mon, Feb 05, 2024 at 12:01:45PM +0000, James Gowans wrote:
> > 
> > > The main aspect we’re looking for feedback/opinions on here is the concept of
> > > putting all persistent state in a single filesystem: combining guest RAM and
> > > IOMMU pgtables in one store. Also, the question of a hard separation between
> > > persistent memory and ephemeral memory, compared to allowing arbitrary pages to
> > > be persisted. Pkernfs does it via a hard separation defined at boot time, other
> > > approaches could make the carving out of persistent pages dynamic.
> > 
> > I think if you are going to attempt something like this then the end
> > result must bring things back to having the same data structures fully
> > restored.
> > 
> > It is fine that the pkernfs holds some persistant memory that
> > guarentees the IOMMU can remain programmed and the VM pages can become
> > fixed across the kexec
> > 
> > But once the VMM starts to restore it self we need to get back to the
> > original configuration:
> >  - A mmap that points to the VM's physical pages
> >  - An iommufd IOAS that points to the above mmap
> >  - An iommufd HWPT that represents that same mapping
> >  - An iommu_domain programmed into HW that the HWPT
> 
> (A quick note on iommufd vs VFIO: I'll still keep referring to VFIO for
> now because that's what I know, but will explore iommufd more and reply
> in more detail about iommufd in the other email thread.)
> 
> How much of this do you think should be done automatically, vs how much
> should userspace need to drive? With this RFC userspace basically re-
> drives everything, including re-injecting the file containing the
> persistent page tables into the IOMMU domain via VFIO.

My guess is that fully automatically is hard/impossible as there is
lots and lots of related state that has to come back. Like how do you
get all the internal iommufs IOAS related datastructures
automatically. Seems way too hard.

Feels simpler to have userspace redo whatever setup was needed to get
back to the right spot.

> Part of the reason is simplicity, to avoid having auto-deserialise code
> paths in the drivers and modules. Another part of the reason so that
> userspace can get FD handles on the resources. Typically FDs are
> returned by doing actions like creating VFIO containers. If we make all
> that automatic then there needs to be some other mechanism for auto-
> restored resources to present themselves to userspace so that userspace
> can discover and pick them up again.

Right, there is lots of state all over the place that would hard to
just re-materialize.

> Can you expand on what you mean by "A mmap that points to the VM's
> physical pages?" Are you suggesting that the QEMU process automatically
> gets something appearing in it's address space? Part of the live update
> process involves potentially changing the userspace binaries: doing
> kexec and booting a new system is an opportunity to boot new versions of
> the userspace binary. So we shouldn't try to preserve too much of
> userspace state; it's better to let it re-create internal data
> structures do fresh mmaps.

I expect the basic flow would be like:

 Starting kernel
   - run the VMM
   - Allocate VM memory in the pkernfs
   - mmap that VM memory
   - Attach the VM memory to KVM
   - Attach the VM memory mmap to IOMMUFD
   - Operate the VM

 Suspending the kernel
   - Stop touching iommufd
   - Freeze changes to the IOMMU, and move its working memory to pkernfs
   - Exit the kernel

 New kernel
   - Recover the frozen IOMMU back to partially running, like crash
     dump. Continue to use some of the working memory in the pkernfs
   - run the new VMM. Some IOMMU_DOMAIN_PKERNFS thing to represent
     this state
   - mmap the VM memory
   - Get KVM going again
   - Attach the new VMM's VM memory mmap to IOMMUFD
   - Replace the iommu partial configuration with a full configuration
   - Free the pkernfs iommu related memory

> What I'm really asking is: do you have a specific suggestion about how
> these persistent resources should present themselves to userspace and
> how userspace can discover them and pick them up?

The only tricky bit in the above is having VFIO know it should leave
the iommu and PCI device state alone when the VFIO cdev is first
opened. Otherwise everything else is straightforward.

Presumably vfio would know it inherited a pkernfs blob and would do
the right stuff. May be some uAPI fussing there to handshake that
properly

Once VFIO knows this it can operate iommufd to conserve the
IOMMU_DOMAIN_PKERNFS as well.

> > Ie you can't just reboot and leave the IOMMU hanging out in some
> > undefined land - especially in latest kernels!
>
> Not too sure what you mean by "undefined land" - the idea is that the
> IOMMU keeps doing what it was going until userspace comes along re-

In terms of how the iommu subystems understands what the iommu is
doing. The iommu subsystem now forces the iommu into defined states as
part of its startup and you need an explicit defined state which means
"continuing to use the pkernfs saved state" which the iommu driver
deliberately enters.

> creates the handles to the IOMMU at which point it can do modifications
> like change mappings or tear the domain down. This is what deferred
> attached gives us, I believe, and why I had to change it to be
> enabled.

VFIO doesn't trigger deferred attach at all, that patch made no sense.

> > For vt-d you need to retain the entire root table and all the required
> > context entries too, The restarting iommu needs to understand that it
> > has to "restore" a temporary iommu_domain from the pkernfs.
> > You can later reconstitute a proper iommu_domain from the VMM and
> > atomic switch.
> 
> Why does it need to go via a temporary domain? 

Because that is the software model we have now. You must be explicit
not in some lalal undefined land of "i don't know WTF is going on but
if I squint this is doing some special thing!" That concept is dead in
the iommu subsystem, you must be explicit.

If the iommu is translating through special page tables stored in a
pkernfs then you need a IOMMU_DOMAIN_PKERNFS to represent that
behavior.

> > So, I'm surprised to see this approach where things just live forever
> > in the kernfs, I don't see how "restore" is going to work very well
> > like this.
> 
> Can you expand on why the suggested restore path will be problematic? In
> summary the idea is to re-create all of the "ephemeral" data structures
> by re-doing ioctls like MAP_DMA, but keeping the persistent IOMMU
> root/context tables pointed at the original persistent page tables. The
> ephemeral data structures are re-created in userspace but the persistent
> page tables left alone. This is of course dependent on userspace re-
> creating things *correctly* - it can easily do the wrong thing. Perhaps
> this is the issue? Or is there a problem even if userspace is sane.

Because how do you regain control of the iommu in a fully configured
way with all the right pin counts and so forth? It seems impossible
like this, all that information is washed away during the kexec.

It seems easier if the pkernfs version of the iommu configuration is
temporary and very special. The normal working mode is just exactly as
today.

> > I would think that a save/restore mentalitity would make more
> > sense. For instance you could make a special iommu_domain that is fixed
> > and lives in the pkernfs. The operation would be to copy from the live
> > iommu_domain to the fixed one and then replace the iommu HW to the
> > fixed one.
> > 
> > In the post-kexec world the iommu would recreate that special domain
> > and point the iommu at it. (copying the root and context descriptions
> > out of the pkernfs). Then somehow that would get into iommufd and VFIO
> > so that it could take over that special mapping during its startup.
> 
> The save and restore model is super interesting - I'm keen to discuss
> this as an alternative. You're suggesting that IOMMU driver have a
> serialise phase just before kexec where it dumps everything into
> persistent memory and then after kexec pulls it back into ephemeral
> memory. That's probably do-able, but it may increase the critical
> section latency of live update (every millisecond counts!) 

Suspending preperation can be done before stopping the vCPUs. You have
to commit to freezing the iommu which only means things like memory
hotplug can't progress. So it isn't critical path

Same on resume, you can resum kvm and the vCPUs and leave the IOMMU in
its suspended state while you work on returning it to normal
operation. Again only memory hotplug becomes blocked so it isn't
critical path.

> and I'm also not too sure what that buys compared to always working
> with persistent memory and just always being in a state where
> persistent data is always being used and can be picked up as-is.

You don't mess up the entire driver and all of its memory management,
and end up with a problem where you can't actually properly restore it
anyhow :)

> However, the idea of a serialise and deserialise operation is relevant
> to a possible alternative to this RFC. My colleague Alex Graf is working
> on a framework called Kexec Hand Over (KHO):
> https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/#r
> That allows drivers/modules to mark arbitrary memory pages as persistent
> (ie: not allocatable by next kernel) and to pass over some serialised
> state across kexec.
> An alternative to IOMMU domain persistence could be to use KHO to mark
> the IOMMU root, context and domain page table pages as persistent via
> KHO.

IMHO it doesn't matter how you get the memory across the kexec, you
still have to answer all these questions about how does the new kernel
actually keep working with this inherited data, and how does it
transform the inherited data into operating data that is properly
situated in the kernel data structures.

You can't just startup iommufd and point it at a set of io page tables
that something else populated. It is fundamentally wrong and would
lead to corrupting the mm's pin counts.

> > > * Needing to drive and re-hydrate the IOMMU page tables by defining an IOMMU file.
> > > Really we should move the abstraction one level up and make the whole VFIO
> > > container persistent via a pkernfs file. That way you’d "just" re-open the VFIO
> > > container file and all of the DMA mappings inside VFIO would already be set up.
> > 
> > I doubt this.. It probably needs to be much finer grained actually,
> > otherwise you are going to be serializing everything. Somehow I think
> > you are better to serialize a minimum and try to reconstruct
> > everything else in userspace. Like conserving iommufd IDs would be a
> > huge PITA.
> > 
> > There are also going to be lots of security questions here, like we
> > can't just let userspace feed in any garbage and violate vfio and
> > iommu invariants.
> 
> Right! This is definitely one of the big gaps at the moment: this
> approach requires that VFIO has the same state re-driven into it from
> userspace so that the persistent and ephemeral data match. If userspace
> does something dodgy, well, it may cause problems. :-)
> That's exactly why I thought we should move the abstraction up to a
> level that doesn't depend on userspace re-driving data. It sounds like
> you were suggesting similar in the first part of your comment, but I
> didn't fully understand how you'd like to see it presented to userspace.

I'd think you end up with some scenario where the pkernfs data has to
be trusted and sealed somehow before vfio would understand it. Ie you
have to feed it into vfio/etc via kexec only.

From a security perspective it does seem horribly wrong to expose such
sensitive data in a filesystem API where there are API surfaces that
would let userspace manipulate it.

At least from the iommu/vfio perspective:

The trusted data should originate inside a signed kernel only.

The signed kernel should prevent userspace from reading or writing it

The next kernel should trust that the prior kernel put the correct
data in there. There should be no option for the next kernel userspace
to read or write the data.

The next kernel can automatically affiliate things with the trusted
inherited data that it knows was passed from the prior signed kernel.
eg autocreate a IOMMU_DOMAIN_PKERNFS, tweak VFIO, etc.

I understand the appeal of making a pkernfs to hold the VM's memory
pages, but it doesn't seem so secure for kernel internal data
strucures..

Jason

