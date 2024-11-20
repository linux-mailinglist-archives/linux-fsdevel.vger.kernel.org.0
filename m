Return-Path: <linux-fsdevel+bounces-35346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F49D40C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84341B32A25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8661A7265;
	Wed, 20 Nov 2024 16:55:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD1150994;
	Wed, 20 Nov 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121727; cv=none; b=lCZpJ6+oU1IOgeZqNW9LIfbqJyuxEHFqvlHf4AgZrXzlnPlyhmx47DL1STLgvFeuTmt3Z0dgTqI+u12ur9DrvnvUcwV2OwcV3ja0aHbnDWFd38DhNirz65qhK56xjrg6/hMaQbWpFbSJ8MZBzhnctcR3D7jm+hNBqRhtFp+WdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121727; c=relaxed/simple;
	bh=VX+3BK6Bok/eIK8oDpdMei+evdB4wKdIEyIm/oeGrWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF1oAodZwBziPuoKL0R4CwZWE5o9wjNg4PJq7uoqUUCmt9VFYG1Y6f4CIZ4HHLwgMaTn58/hc8uk1DCmwdgds7izCYpoR0tD+eYpPQZkSvhOQ7wq1ukD7OYk+sXTpFjR3FRXyGhnhW96gwGkjL6IO0Cc9Rpi/fnsas+3mn2GBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4AKGsQ9j001857;
	Wed, 20 Nov 2024 10:54:26 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4AKGsPi8001856;
	Wed, 20 Nov 2024 10:54:25 -0600
Date: Wed, 20 Nov 2024 10:54:25 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <songliubraving@meta.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Message-ID: <20241120165425.GA1723@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com> <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com> <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com> <20241114163641.GA8697@wind.enjellic.com> <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com> <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com> <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com> <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com> <20241119122706.GA19220@wind.enjellic.com> <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 20 Nov 2024 10:54:26 -0600 (CST)

On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:

Good morning, I hope the day is goning well for everyone.

> On 11/19/2024 4:27 AM, Dr. Greg wrote:
> > On Sun, Nov 17, 2024 at 10:59:18PM +0000, Song Liu wrote:
> >
> >> Hi Christian, James and Jan, 
> > Good morning, I hope the day is starting well for everyone.
> >
> >>> On Nov 14, 2024, at 1:49???PM, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> >> [...]
> >>
> >>>> We can address this with something like following:
> >>>>
> >>>> #ifdef CONFIG_SECURITY
> >>>>         void                    *i_security;
> >>>> #elif CONFIG_BPF_SYSCALL
> >>>>         struct bpf_local_storage __rcu *i_bpf_storage;
> >>>> #endif
> >>>>
> >>>> This will help catch all misuse of the i_bpf_storage at compile
> >>>> time, as i_bpf_storage doesn't exist with CONFIG_SECURITY=y. 
> >>>>
> >>>> Does this make sense?
> >>> Got to say I'm with Casey here, this will generate horrible and failure
> >>> prone code.
> >>>
> >>> Since effectively you're making i_security always present anyway,
> >>> simply do that and also pull the allocation code out of security.c in a
> >>> way that it's always available?  That way you don't have to special
> >>> case the code depending on whether CONFIG_SECURITY is defined. 
> >>> Effectively this would give everyone a generic way to attach some
> >>> memory area to an inode.  I know it's more complex than this because
> >>> there are LSM hooks that run from security_inode_alloc() but if you can
> >>> make it work generically, I'm sure everyone will benefit.
> >> On a second thought, I think making i_security generic is not 
> >> the right solution for "BPF inode storage in tracing use cases". 
> >>
> >> This is because i_security serves a very specific use case: it 
> >> points to a piece of memory whose size is calculated at system 
> >> boot time. If some of the supported LSMs is not enabled by the 
> >> lsm= kernel arg, the kernel will not allocate memory in 
> >> i_security for them. The only way to change lsm= is to reboot 
> >> the system. BPF LSM programs can be disabled at the boot time, 
> >> which fits well in i_security. However, BPF tracing programs 
> >> cannot be disabled at boot time (even we change the code to 
> >> make it possible, we are not likely to disable BPF tracing). 
> >> IOW, as long as CONFIG_BPF_SYSCALL is enabled, we expect some 
> >> BPF tracing programs to load at some point of time, and these 
> >> programs may use BPF inode storage. 
> >>
> >> Therefore, with CONFIG_BPF_SYSCALL enabled, some extra memory 
> >> always will be attached to i_security (maybe under a different 
> >> name, say, i_generic) of every inode. In this case, we should 
> >> really add i_bpf_storage directly to the inode, because another 
> >> pointer jump via i_generic gives nothing but overhead. 
> >>
> >> Does this make sense? Or did I misunderstand the suggestion?
> > There is a colloquialism that seems relevant here: "Pick your poison".
> >
> > In the greater interests of the kernel, it seems that a generic
> > mechanism for attaching per inode information is the only realistic
> > path forward, unless Christian changes his position on expanding
> > the size of struct inode.
> >
> > There are two pathways forward.
> >
> > 1.) Attach a constant size 'blob' of storage to each inode.
> >
> > This is a similar approach to what the LSM uses where each blob is
> > sized as follows:
> >
> > S = U * sizeof(void *)
> >
> > Where U is the number of sub-systems that have a desire to use inode
> > specific storage.

> I can't tell for sure, but it looks like you don't understand how
> LSM i_security blobs are used. It is *not* the case that each LSM
> gets a pointer in the i_security blob. Each LSM that wants storage
> tells the infrastructure at initialization time how much space it
> wants in the blob. That can be a pointer, but usually it's a struct
> with flags, pointers and even lists.

I can state unequivocably for everyone's benefit, that as a team, we
have an intimate understanding of how LSM i_security blobs are used.

It was 0500 in the morning when I wrote the reply and I had personally
been working for 22 hours straight, so my apologies for being
imprecise.

I should not have specified sizeof(void *), I should have written
sizeof(allocation), for lack of a better syntax.

Also for the record, in a universal allocation scheme, when I say
sub-system I mean any implementation that would make use of per inode
information.  So the LSM, bpf tracing et.al., could all be considered
sub-systems that would register at boot time for a section of the
arena.

> > Each sub-system uses it's pointer slot to manage any additional
> > storage that it desires to attach to the inode.

> Again, an LSM may choose to do it that way, but most don't.  SELinux
> and Smack need data on every inode. It makes much more sense to put
> it directly in the blob than to allocate a separate chunk for every
> inode.

See my correction above.

> > This has the obvious advantage of O(1) cost complexity for any
> > sub-system that wants to access its inode specific storage.
> >
> > The disadvantage, as you note, is that it wastes memory if a
> > sub-system does not elect to attach per inode information, for example
> > the tracing infrastructure.

> To be clear, that disadvantage only comes up if the sub-system uses
> inode data on an occasional basis. If it never uses inode data there
> is no need to have a pointer to it.

I think we all agree on that, therein lies the rub with a common arena
architecture, which is why I indicated in my earlier e-mail that this
comes down to engineering trade-off decisions.

That is why there would be a probable assumption that such sub-systems
would only request a pointer per arena slot and use that to reference
a dynamically allocated structure.  If, as a group, we are really
concerned about inode memory consumption the assumption would be that
the maintainers would have to whine about sparse consumers requesting
a structure sized allocation rather than a pointer sized allocation.

> > This disadvantage is parried by the fact that it reduces the size of
> > the inode proper by 24 bytes (4 pointers down to 1) and allows future
> > extensibility without colliding with the interests and desires of the
> > VFS maintainers.

> You're adding a level of indirection. Even I would object based on
> the performance impact.

I'm not sure that a thorough and complete analysis of the costs
associated with a sub-system touching inode local storage would
support the notion of a tangible performance hit.

The pointer in an arena slot would presumably be a pointer to a data
structure that a sub-system allocates at inode creation time.  After
computing the arena slot address in classic style (i_arena + offset)
the sub-system uses the pointer at that location to dereference
its structure elements or to find subordinate members in its arena.

If we take SMACK as an example, the smack inode contains three
pointers and a scalar.  So, if there is a need to access storage behind
one of those pointers, there is an additional indirection hit.

The three pointers are each to a structure (smack_known) that has
three list pointers and a mutex lock inside of it.

The SeLinux inode has a back pointer to the sponsoring inode, a list
head, a spinlock and some scalars.

So there is lots of potential indirection and locking going on with
access to inode local storage.

To extend further, for everyone thinking about this from an
engineering perspective.

A common arena model where everyone asks for a structure sized blob is
inherently cache pessimal.  Unless you are the first blob in the arena
you are going to need to hit another cache-line in order to start the
indirection process for your structure.

A pointer based arena architecture would allow up to eight sub-systems
to get their inode storage pointer for the cost of a single cache-line
fetch.

Let me offer another line of thinking on this drawn from the
discussion above.

A further optimization in the single pointer arena model is for the
LSM to place a pointer to a standard LSM sized memory blob in its
pointer slot on behalf of all the individual LSM's.  All of the
individual participating LSM's take that pointer and do the offset
calculation into the LSM arena for that inode as they normally would.

So there would seem to be a lot of engineering issues to consider that
are beyond the simple predicate that indirection is bad.

See, I do understand how the LSM arena model works.

> > 2.) Implement key/value mapping for inode specific storage.
> >
> > The key would be a sub-system specific numeric value that returns a
> > pointer the sub-system uses to manage its inode specific memory for a
> > particular inode.
> >
> > A participating sub-system in turn uses its identifier to register an
> > inode specific pointer for its sub-system.
> >
> > This strategy loses O(1) lookup complexity but reduces total memory
> > consumption and only imposes memory costs for inodes when a sub-system
> > desires to use inode specific storage.

> SELinux and Smack use an inode blob for every inode. The performance
> regression boggles the mind. Not to mention the additional
> complexity of managing the memory.

I guess we would have to measure the performance impacts to understand
their level of mind boggliness.

My first thought is that we hear a huge amount of fanfare about BPF
being a game changer for tracing and network monitoring.  Given
current networking speeds, if its ability to manage storage needed for
it purposes are truely abysmal the industry wouldn't be finding the
technology useful.

Beyond that.

As I noted above, the LSM could be an independent subscriber.  The
pointer to register would come from the the kmem_cache allocator as it
does now, so that cost is idempotent with the current implementation.
The pointer registration would also be a single instance cost.

So the primary cost differential over the common arena model will be
the complexity costs associated with lookups in a red/black tree, if
we used the old IMA integrity cache as an example implementation.

As I noted above, these per inode local storage structures are complex
in of themselves, including lists and locks.  If touching an inode
involves locking and walking lists and the like it would seem that
those performance impacts would quickly swamp an r/b lookup cost.

> > Approach 2 requires the introduction of generic infrastructure that
> > allows an inode's key/value mappings to be located, presumably based
> > on the inode's pointer value.  We could probably just resurrect the
> > old IMA iint code for this purpose.
> >
> > In the end it comes down to a rather standard trade-off in this
> > business, memory vs. execution cost.
> >
> > We would posit that option 2 is the only viable scheme if the design
> > metric is overall good for the Linux kernel eco-system.

> No. Really, no. You need look no further than secmarks to understand
> how a key based blob allocation scheme leads to tears. Keys are fine
> in the case where use of data is sparse. They have no place when data
> use is the norm.

Then it would seem that we need to get everyone to agree that we can
get by with using two pointers in struct inode.  One for uses best
served by common arena allocation and one for a key/pointer mapping,
and then convert the sub-systems accordingly.

Or alternately, getting everyone to agree that allocating a mininum of
eight additional bytes for every subscriber to private inode data
isn't the end of the world, even if use of the resource is sparse.

Of course, experience would suggest, that getting everyone in this
community to agree on something is roughly akin to throwing a hand
grenade into a chicken coop with an expectation that all of the
chickens will fly out in a uniform flock formation.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

