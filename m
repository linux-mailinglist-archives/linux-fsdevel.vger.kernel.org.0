Return-Path: <linux-fsdevel+bounces-35640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBF9D6A76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEC161903
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDC14B942;
	Sat, 23 Nov 2024 17:03:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC5182C5;
	Sat, 23 Nov 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381380; cv=none; b=GjwiPsb1GZ+VbcsIAkUfY5tiWUeM7rRPwkJa1tO6Iu5VoFffcs6bUByRxYSSHpNWUZqvhztKAYwF2RIQwNnDokXh/+aB4gK2n+scAA2Nx2ECmO7QIyy2rSsAlOKlZpI5LVOj3W3EVjmp5ElozSIabr64YZR+MCbAs4QTHFTmp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381380; c=relaxed/simple;
	bh=qYV6ojSzaiLvDcHiuvU53HQJ0j3I4z89aMoHzcBSAFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erQI+aDmjXgn+9xfVl4DU093nNVywbtzRH2hwV1QHvUuAmkDkG78gcBlAqLzt/1eLgHyjCz0fjOepqL+WMkPUimkQOwEJfx2SQWH6aj6FZ8IT2pZz0hj81CwqXZZCKuEjhG1iI8vtlMAm0tJR3rJu3UTU5bz5HldSEZhHZ3l4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4ANH1ekl027103;
	Sat, 23 Nov 2024 11:01:40 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4ANH1bR9027102;
	Sat, 23 Nov 2024 11:01:37 -0600
Date: Sat, 23 Nov 2024 11:01:37 -0600
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
Message-ID: <20241123170137.GA26831@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com> <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com> <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com> <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com> <20241119122706.GA19220@wind.enjellic.com> <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com> <20241120165425.GA1723@wind.enjellic.com> <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com> <20241121160259.GA9933@wind.enjellic.com> <d0b61238-735b-478c-9e18-c94e4dde4d88@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b61238-735b-478c-9e18-c94e4dde4d88@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 23 Nov 2024 11:01:40 -0600 (CST)

On Thu, Nov 21, 2024 at 10:11:16AM -0800, Casey Schaufler wrote:

Good morning, I hope the weekend is going well for everyone.

> On 11/21/2024 8:02 AM, Dr. Greg wrote:
> > On Thu, Nov 21, 2024 at 08:28:05AM +0000, Song Liu wrote:
> >
> >> Hi Dr. Greg,
> >>
> >> Thanks for your input!
> > Good morning, I hope everyone's day is going well.
> >
> >>> On Nov 20, 2024, at 8:54???AM, Dr. Greg <greg@enjellic.com> wrote:
> >>>
> >>> On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:
> >> [...]
> >>
> >>>>> 2.) Implement key/value mapping for inode specific storage.
> >>>>>
> >>>>> The key would be a sub-system specific numeric value that returns a
> >>>>> pointer the sub-system uses to manage its inode specific memory for a
> >>>>> particular inode.
> >>>>>
> >>>>> A participating sub-system in turn uses its identifier to register an
> >>>>> inode specific pointer for its sub-system.
> >>>>>
> >>>>> This strategy loses O(1) lookup complexity but reduces total memory
> >>>>> consumption and only imposes memory costs for inodes when a sub-system
> >>>>> desires to use inode specific storage.

> >>>> SELinux and Smack use an inode blob for every inode. The performance
> >>>> regression boggles the mind. Not to mention the additional
> >>>> complexity of managing the memory.

> >>> I guess we would have to measure the performance impacts to understand
> >>> their level of mind boggliness.
> >>>
> >>> My first thought is that we hear a huge amount of fanfare about BPF
> >>> being a game changer for tracing and network monitoring.  Given
> >>> current networking speeds, if its ability to manage storage needed for
> >>> it purposes are truely abysmal the industry wouldn't be finding the
> >>> technology useful.
> >>>
> >>> Beyond that.
> >>>
> >>> As I noted above, the LSM could be an independent subscriber.  The
> >>> pointer to register would come from the the kmem_cache allocator as it
> >>> does now, so that cost is idempotent with the current implementation.
> >>> The pointer registration would also be a single instance cost.
> >>>
> >>> So the primary cost differential over the common arena model will be
> >>> the complexity costs associated with lookups in a red/black tree, if
> >>> we used the old IMA integrity cache as an example implementation.
> >>>
> >>> As I noted above, these per inode local storage structures are complex
> >>> in of themselves, including lists and locks.  If touching an inode
> >>> involves locking and walking lists and the like it would seem that
> >>> those performance impacts would quickly swamp an r/b lookup cost.

> >> bpf local storage is designed to be an arena like solution that
> >> works for multiple bpf maps (and we don't know how many of maps we
> >> need ahead of time). Therefore, we may end up doing what you
> >> suggested earlier: every LSM should use bpf inode storage. ;) I am
> >> only 90% kidding.

> > I will let you thrash that out with the LSM folks, we have enough on
> > our hands just with TSEM.... :-)
> >
> > I think the most important issue in all of this is to get solid
> > performance measurements and let those speak to how we move forward.
> >
> > As LSM authors ourself, we don't see an off-putting reason to not have
> > a common arena storage architecture that builds on what the LSM is
> > doing.  If sub-systems with sparse usage would agree that they need to
> > restrict themselves to a single pointer slot in the arena, it would
> > seem that memory consumption, in this day and age, would be tolerable.
> >
> > See below for another idea.

> >>>>> Approach 2 requires the introduction of generic infrastructure that
> >>>>> allows an inode's key/value mappings to be located, presumably based
> >>>>> on the inode's pointer value.  We could probably just resurrect the
> >>>>> old IMA iint code for this purpose.
> >>>>>
> >>>>> In the end it comes down to a rather standard trade-off in this
> >>>>> business, memory vs. execution cost.
> >>>>>
> >>>>> We would posit that option 2 is the only viable scheme if the design
> >>>>> metric is overall good for the Linux kernel eco-system.

> >>>> No. Really, no. You need look no further than secmarks to understand
> >>>> how a key based blob allocation scheme leads to tears. Keys are fine
> >>>> in the case where use of data is sparse. They have no place when data
> >>>> use is the norm.

> >>> Then it would seem that we need to get everyone to agree that we can
> >>> get by with using two pointers in struct inode.  One for uses best
> >>> served by common arena allocation and one for a key/pointer mapping,
> >>> and then convert the sub-systems accordingly.
> >>>
> >>> Or alternately, getting everyone to agree that allocating a mininum of
> >>> eight additional bytes for every subscriber to private inode data
> >>> isn't the end of the world, even if use of the resource is sparse.

> >> Christian suggested we can use an inode_addon structure, which is 
> >> similar to this idea. It won't work well in all contexts, though. 
> >> So it is not as good as other bpf local storage (task, sock,
> >> cgroup). 

> > Here is another thought in all of this.
> >
> > I've mentioned the old IMA integrity inode cache a couple of times in
> > this thread.  The most peacable path forward may be to look at
> > generalizing that architecture so that a sub-system that wanted inode
> > local storage could request that an inode local storage cache manager
> > be implemented for it.
> >
> > That infrastructure was based on a red/black tree that used the inode
> > pointer as a key to locate a pointer to a structure that contained
> > local information for the inode.  That takes away the need to embed
> > something in the inode structure proper.
> >
> > Since insertion and lookup times have complexity functions that scale
> > with tree height it would seem to be a good fit for sparse utilization
> > scenarios.
> >
> > An extra optimization that may be possible would be to maintain an
> > indicator flag tied the filesystem superblock that would provide a
> > simple binary answer as to whether any local inode cache managers have
> > been registered for inodes on a filesystem.  That would allow the
> > lookup to be completely skipped with a simple conditional test.
> >
> > If the infrastructure was generalized to request and release cache
> > managers it would be suitable for systems, implemented as modules,
> > that have a need for local inode storage.

> Do you think that over the past 20 years no one has thought of this?
> We're working to make the LSM infrastructure cleaner and more
> robust.  Adding the burden of memory management to each LSM is a
> horrible idea.

No, I cannot ascribe to the notion that I, personally, know what
everyone has thought about in the last 20 years.

I do know, personally, that very talented individuals who are involved
with large security sensitive operations question the trajectory of
the LSM.  That, however, is a debate for another venue.

For the lore record and everyone reading along at home, you
misinterpreted or did not read closely my e-mail.

We were not proposing adding memory management to each LSM, we were
suggesting to Song Liu that generalizing, what was the old IMA inode
integrity infrastructure, may be a path forward for sub-systems that
need inode local storage, particularly systems that have sparse
occupancy requirements.

Everyone has their britches in a knicker about performance.

Note that we called out a possible optimization for this architecture
so that there would be no need to even hit the r/b tree if a
filesystem had no sub-systems that had requested sparse inode local
storage for that filesystem.

> > It also offers the ability for implementation independence, which is
> > always a good thing in the Linux community.

> Generality for the sake of generality is seriously overrated.
> File systems have to be done so as to fit into the VFS infrastructure,
> network protocols have to work with sockets without impacting the
> performance of others and so forth.

We were not advocating generality for the sake of generality, we were
suggesting a generalized architecture, that does not require expansion
of struct inode, because Christian has publically indicated there is
no appetite by the VFS maintainers for consuming additional space in
struct inode for infrastructure requiring local inode storage.

You talk about cooperation, yet you object to any consideration that
the LSM should participate in a shared arena environment where
sub-systems wanting local inode storage could just request a block in
a common arena.  The LSM, in this case, is just like a filesystem
since it is a consumer of infrastructure supplied by the VFS and
should thus cooperate with other consumers of VFS infrastructure.

If people go back and read our last paragraph you replied to we were
not speaking to the advantages of generality, we were speaking to the
advantage of independent implementations that did unnecessarily cross
sub-system lines.  Casual observation of Linux development, and this
thread, would suggest the importance of that.

I need to get a bunch of firewood under cover so I will leave things
at that.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

