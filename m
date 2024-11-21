Return-Path: <linux-fsdevel+bounces-35462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C359D505A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C4628346F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC119E971;
	Thu, 21 Nov 2024 16:04:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392F55C29;
	Thu, 21 Nov 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205043; cv=none; b=KYcZNrwTfkPnVkWKUoY9o0fJLSfujUYqapEQOkaBp5n2kV7kzZLtBUhER1efkwd6zsgRP/SZwv42uizJfkU32am/rxgXdHBalLhlL+ulsJ1/4sLhsgND4L0OYbsi9Iraos87vobM+gSqnvMBIWPtC3pdhCk7oyZfeNwyxVLD2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205043; c=relaxed/simple;
	bh=hysRP7nV2W65xic8G5nFrdP9jHXY2FnLQvuPVR4M7ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQnfg+CzDmRC846rbHJaOLBbQjhoW0FL6h0biURgQxJuwlj8zc37l/713Z+SrcsaeJkqYYDsTSKRe/Yq8juJ+R/u3GT8u5QaFIbx5MkB/yOAJ/P5hChSr8m7pmbuFpZpDllXRwwMyYM6XHcimxxiZ/dyWv0+h7nNwioQJwc6VhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4ALG31wD010258;
	Thu, 21 Nov 2024 10:03:01 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4ALG2xqo010256;
	Thu, 21 Nov 2024 10:02:59 -0600
Date: Thu, 21 Nov 2024 10:02:59 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Song Liu <songliubraving@meta.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
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
Message-ID: <20241121160259.GA9933@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com> <20241114163641.GA8697@wind.enjellic.com> <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com> <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com> <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com> <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com> <20241119122706.GA19220@wind.enjellic.com> <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com> <20241120165425.GA1723@wind.enjellic.com> <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 21 Nov 2024 10:03:01 -0600 (CST)

On Thu, Nov 21, 2024 at 08:28:05AM +0000, Song Liu wrote:

> Hi Dr. Greg,
> 
> Thanks for your input!

Good morning, I hope everyone's day is going well.

> > On Nov 20, 2024, at 8:54???AM, Dr. Greg <greg@enjellic.com> wrote:
> > 
> > On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:
> 
> [...]
> 
> > 
> >>> 2.) Implement key/value mapping for inode specific storage.
> >>> 
> >>> The key would be a sub-system specific numeric value that returns a
> >>> pointer the sub-system uses to manage its inode specific memory for a
> >>> particular inode.
> >>> 
> >>> A participating sub-system in turn uses its identifier to register an
> >>> inode specific pointer for its sub-system.
> >>> 
> >>> This strategy loses O(1) lookup complexity but reduces total memory
> >>> consumption and only imposes memory costs for inodes when a sub-system
> >>> desires to use inode specific storage.
> > 
> >> SELinux and Smack use an inode blob for every inode. The performance
> >> regression boggles the mind. Not to mention the additional
> >> complexity of managing the memory.
> > 
> > I guess we would have to measure the performance impacts to understand
> > their level of mind boggliness.
> > 
> > My first thought is that we hear a huge amount of fanfare about BPF
> > being a game changer for tracing and network monitoring.  Given
> > current networking speeds, if its ability to manage storage needed for
> > it purposes are truely abysmal the industry wouldn't be finding the
> > technology useful.
> > 
> > Beyond that.
> > 
> > As I noted above, the LSM could be an independent subscriber.  The
> > pointer to register would come from the the kmem_cache allocator as it
> > does now, so that cost is idempotent with the current implementation.
> > The pointer registration would also be a single instance cost.
> > 
> > So the primary cost differential over the common arena model will be
> > the complexity costs associated with lookups in a red/black tree, if
> > we used the old IMA integrity cache as an example implementation.
> > 
> > As I noted above, these per inode local storage structures are complex
> > in of themselves, including lists and locks.  If touching an inode
> > involves locking and walking lists and the like it would seem that
> > those performance impacts would quickly swamp an r/b lookup cost.

> bpf local storage is designed to be an arena like solution that
> works for multiple bpf maps (and we don't know how many of maps we
> need ahead of time). Therefore, we may end up doing what you
> suggested earlier: every LSM should use bpf inode storage. ;) I am
> only 90% kidding.

I will let you thrash that out with the LSM folks, we have enough on
our hands just with TSEM.... :-)

I think the most important issue in all of this is to get solid
performance measurements and let those speak to how we move forward.

As LSM authors ourself, we don't see an off-putting reason to not have
a common arena storage architecture that builds on what the LSM is
doing.  If sub-systems with sparse usage would agree that they need to
restrict themselves to a single pointer slot in the arena, it would
seem that memory consumption, in this day and age, would be tolerable.

See below for another idea.

> >>> Approach 2 requires the introduction of generic infrastructure that
> >>> allows an inode's key/value mappings to be located, presumably based
> >>> on the inode's pointer value.  We could probably just resurrect the
> >>> old IMA iint code for this purpose.
> >>> 
> >>> In the end it comes down to a rather standard trade-off in this
> >>> business, memory vs. execution cost.
> >>> 
> >>> We would posit that option 2 is the only viable scheme if the design
> >>> metric is overall good for the Linux kernel eco-system.
> > 
> >> No. Really, no. You need look no further than secmarks to understand
> >> how a key based blob allocation scheme leads to tears. Keys are fine
> >> in the case where use of data is sparse. They have no place when data
> >> use is the norm.
> > 
> > Then it would seem that we need to get everyone to agree that we can
> > get by with using two pointers in struct inode.  One for uses best
> > served by common arena allocation and one for a key/pointer mapping,
> > and then convert the sub-systems accordingly.
> > 
> > Or alternately, getting everyone to agree that allocating a mininum of
> > eight additional bytes for every subscriber to private inode data
> > isn't the end of the world, even if use of the resource is sparse.

> Christian suggested we can use an inode_addon structure, which is 
> similar to this idea. It won't work well in all contexts, though. 
> So it is not as good as other bpf local storage (task, sock,
> cgroup). 

Here is another thought in all of this.

I've mentioned the old IMA integrity inode cache a couple of times in
this thread.  The most peacable path forward may be to look at
generalizing that architecture so that a sub-system that wanted inode
local storage could request that an inode local storage cache manager
be implemented for it.

That infrastructure was based on a red/black tree that used the inode
pointer as a key to locate a pointer to a structure that contained
local information for the inode.  That takes away the need to embed
something in the inode structure proper.

Since insertion and lookup times have complexity functions that scale
with tree height it would seem to be a good fit for sparse utilization
scenarios.

An extra optimization that may be possible would be to maintain an
indicator flag tied the filesystem superblock that would provide a
simple binary answer as to whether any local inode cache managers have
been registered for inodes on a filesystem.  That would allow the
lookup to be completely skipped with a simple conditional test.

If the infrastructure was generalized to request and release cache
managers it would be suitable for systems, implemented as modules,
that have a need for local inode storage.

It also offers the ability for implementation independence, which is
always a good thing in the Linux community.

> Thanks,
> Song

Have a good day.

> > Of course, experience would suggest, that getting everyone in this
> > community to agree on something is roughly akin to throwing a hand
> > grenade into a chicken coop with an expectation that all of the
> > chickens will fly out in a uniform flock formation.
> > 
> > As always,
> > Dr. Greg
> > 
> > The Quixote Project - Flailing at the Travails of Cybersecurity
> >              https://github.com/Quixote-Project
> 
> 

