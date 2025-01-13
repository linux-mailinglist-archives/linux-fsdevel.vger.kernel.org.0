Return-Path: <linux-fsdevel+bounces-39090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFCA0C3F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 22:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC893A5ACF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85F1DACAA;
	Mon, 13 Jan 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjYV0XVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE21C1AAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804669; cv=none; b=hElp4NzA7XYI/SCWq2d2XzNIHOr08FLncztbQICXxsvR2y9+xnp7QLpEHPL2LPTgbmiQCdgnbrPaOu+csnwthw5G/AbTf/Urb9OhrmzVn7QihSGBR1yTgQwgfP/SDVB/E75O1uCG6KqVBmu8hWdV/qmCMrEMYu6ST+hmOHRG/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804669; c=relaxed/simple;
	bh=5J4FIZHJNtdwTF6zwzfIgKGrq/YLgfdmKM3PSrrX3Es=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqxRW37EEXuIjHDXgVuj8v7ZwD1nLh/2zoI0id0crEfWzrLEk9hJNMXsPz/MN5CPNPZ4SXn9r3ObuKnSWVOARFMrAq0YnoDE/gBTGpTzlSIGMOvEFvRWmV3Imx6xmbU08W7BJnANB1aPLY/2ga2Y3xAWDu0yBgY0MkAFys12lYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjYV0XVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7834DC4CED6;
	Mon, 13 Jan 2025 21:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736804668;
	bh=5J4FIZHJNtdwTF6zwzfIgKGrq/YLgfdmKM3PSrrX3Es=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SjYV0XVJ9ygFqF8YCCw5Rtm96Ciknj6cXG/E9o4mfQ77Qe5sYbSJtcE0Oe5KO8rza
	 3/+TVVjsWsqhX8DszlFEdn6SQ2GfP3m8U5jN0D5neIEETu+jATTAq+RAUnmM4wqMfc
	 bs6Kpz9E1RSz6Lo0xWjASSuq+PBRlycBfa84JRqCk15GSZELFm5omAgo6y1ITNLPM0
	 qecyYBZu0u+f5/nktHyBFD/R+3TNUhSpkAvPu8nkEQNna+V4aZ8T6V1t9fD83xwBPA
	 owWqSH2obDzD3quB3x5rMGiUgut8fU3ZOhxzJzWR2QvsDlto7M/3aLuN1c6hRtMWUo
	 oLxhforL+oHRA==
Message-ID: <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under
 writeback with AS_WRITEBACK_INDETERMINATE mappings
From: Jeff Layton <jlayton@kernel.org>
To: David Hildenbrand <david@redhat.com>, Shakeel Butt
 <shakeel.butt@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong
 <joannelkoong@gmail.com>,  Bernd Schubert <bernd.schubert@fastmail.fm>, Zi
 Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, Oscar Salvador	
 <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Date: Mon, 13 Jan 2025 16:44:26 -0500
In-Reply-To: <2848b566-3cae-4e89-916c-241508054402@redhat.com>
References: 
	<hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
	 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
	 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
	 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
	 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
	 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
	 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
	 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
	 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
	 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
	 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
	 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 16:27 +0100, David Hildenbrand wrote:
> On 10.01.25 23:00, Shakeel Butt wrote:
> > On Fri, Jan 10, 2025 at 10:13:17PM +0100, David Hildenbrand wrote:
> > > On 10.01.25 21:28, Jeff Layton wrote:
> > > > On Thu, 2025-01-09 at 12:22 +0100, David Hildenbrand wrote:
> > > > > On 07.01.25 19:07, Shakeel Butt wrote:
> > > > > > On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wro=
te:
> > > > > > > On 06.01.25 19:17, Shakeel Butt wrote:
> > > > > > > > On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wr=
ote:
> > > > > > > > > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@red=
hat.com> wrote:
> > > > > > > > > > In any case, having movable pages be turned unmovable d=
ue to persistent
> > > > > > > > > > writaback is something that must be fixed, not worked a=
round. Likely a
> > > > > > > > > > good topic for LSF/MM.
> > > > > > > > >=20
> > > > > > > > > Yes, this seems a good cross fs-mm topic.
> > > > > > > > >=20
> > > > > > > > > So the issue discussed here is that movable pages used fo=
r fuse
> > > > > > > > > page-cache cause a problems when memory needs to be compa=
cted. The
> > > > > > > > > problem is either that
> > > > > > > > >=20
> > > > > > > > >      - the page is skipped, leaving the physical memory b=
lock unmovable
> > > > > > > > >=20
> > > > > > > > >      - the compaction is blocked for an unbounded time
> > > > > > > > >=20
> > > > > > > > > While the new AS_WRITEBACK_INDETERMINATE could potentiall=
y make things
> > > > > > > > > worse, the same thing happens on readahead, since the new=
 page can be
> > > > > > > > > locked for an indeterminate amount of time, which can als=
o block
> > > > > > > > > compaction, right?
> > > > > > >=20
> > > > > > > Yes, as memory hotplug + virtio-mem maintainer my bigger conc=
ern is these
> > > > > > > pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where ther=
e *must not be
> > > > > > > unmovable pages ever*. Not triggered by an untrusted source, =
not triggered
> > > > > > > by an trusted source.
> > > > > > >=20
> > > > > > > It's a violation of core-mm principles.
> > > > > >=20
> > > > > > The "must not be unmovable pages ever" is a very strong stateme=
nt and we
> > > > > > are violating it today and will keep violating it in future. An=
y
> > > > > > page/folio under lock or writeback or have reference taken or h=
ave been
> > > > > > isolated from their LRU is unmovable (most of the time for smal=
l period
> > > > > > of time).
> > > > >=20
> > > > > ^ this: "small period of time" is what I meant.
> > > > >=20
> > > > > Most of these things are known to not be problematic: retrying a =
couple
> > > > > of times makes it work, that's why migration keeps retrying.
> > > > >=20
> > > > > Again, as an example, we allow short-term O_DIRECT but disallow
> > > > > long-term page pinning. I think there were concerns at some point=
 if
> > > > > O_DIRECT might also be problematic (I/O might take a while), but =
so far
> > > > > it was not a problem in practice that would make CMA allocations =
easily
> > > > > fail.
> > > > >=20
> > > > > vmsplice() is a known problem, because it behaves like O_DIRECT b=
ut
> > > > > actually triggers long-term pinning; IIRC David Howells has this =
on his
> > > > > todo list to fix. [I recall that seccomp disallows vmsplice by de=
fault
> > > > > right now]
> > > > >=20
> > > > > These operations are being done all over the place in kernel.
> > > > > > Miklos gave an example of readahead.
> > > > >=20
> > > > > I assume you mean "unmovable for a short time", correct, or can y=
ou
> > > > > point me at that specific example; I think I missed that.
> >=20
> > Please see https://lore.kernel.org/all/CAJfpegthP2enc9o1hV-izyAG9nHcD_t=
T8dKFxxzhdQws6pcyhQ@mail.gmail.com/
> >=20
> > > > >=20
> > > > > > The per-CPU LRU caches are another
> > > > > > case where folios can get stuck for long period of time.
> > > > >=20
> > > > > Which is why memory offlining disables the lru cache. See
> > > > > lru_cache_disable(). Other users that care about that drain the L=
RU on
> > > > > all cpus.
> > > > >=20
> > > > > > Reclaim and
> > > > > > compaction can isolate a lot of folios that they need to have
> > > > > > too_many_isolated() checks. So, "must not be unmovable pages ev=
er" is
> > > > > > impractical.
> > > > >=20
> > > > > "must only be short-term unmovable", better?
> >=20
> > Yes and you have clarified further below of the actual amount.
> >=20
> > > > >=20
> > > >=20
> > > > Still a little ambiguous.
> > > >=20
> > > > How short is "short-term"? Are we talking milliseconds or minutes?
> > >=20
> > > Usually a couple of seconds, max. For memory offlining, slightly long=
er
> > > times are acceptable; other things (in particular compaction or CMA
> > > allocations) will give up much faster.
> > >=20
> > > >=20
> > > > Imposing a hard timeout on writeback requests to unprivileged FUSE
> > > > servers might give us a better guarantee of forward-progress, but i=
t
> > > > would probably have to be on the order of at least a minute or so t=
o be
> > > > workable.
> > >=20
> > > Yes, and that might already be a bit too much, especially if stuck on
> > > waiting for folio writeback ... so ideally we could find a way to mig=
rate
> > > these folios that are under writeback and it's not your ordinary disk=
 driver
> > > that responds rather quickly.
> > >=20
> > > Right now we do it via these temp pages, and I can see how that's
> > > undesirable.
> > >=20
> > > For NFS etc. we probably never ran into this, because it's all used i=
n
> > > fairly well managed environments and, well, I assume NFS easily outda=
tes CMA
> > > and ZONE_MOVABLE :)
> > >=20
> > > > > > >=20
> > > > > > The point is that, yes we should aim to improve things but in i=
terations
> > > > > > and "must not be unmovable pages ever" is not something we can =
achieve
> > > > > > in one step.
> > > > >=20
> > > > > I agree with the "improve things in iterations", but as
> > > > > AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I t=
hink we
> > > > > are making things worse.
> >=20
> > AS_WRITEBACK_INDETERMINATE is really a bad name we picked as it is stil=
l
> > causing confusion. It is a simple flag to avoid deadlock in the reclaim
> > code path and does not say anything about movability.
> >=20
> > > > >=20
> > > > > And as this discussion has been going on for too long, to summari=
ze my
> > > > > point: there exist conditions where pages are short-term unmovabl=
e, and
> > > > > possibly some to be fixed that turn pages long-term unmovable (e.=
g.,
> > > > > vmsplice); that does not mean that we can freely add new conditio=
ns that
> > > > > turn movable pages unmovable long-term or even forever.
> > > > >=20
> > > > > Again, this might be a good LSF/MM topic. If I would have the cap=
acity I
> > > > > would suggest a topic around which things are know to cause pages=
 to be
> > > > > short-term or long-term unmovable/unsplittable, and which can be
> > > > > handled, which not. Maybe I'll find the time to propose that as a=
 topic.
> > > > >=20
> > > >=20
> > > >=20
> > > > This does sound like great LSF/MM fodder! I predict that this sessi=
on
> > > > will run long! ;)
> > >=20
> > > Heh, fully agreed! :)
> >=20
> > I would like more targeted topic and for that I want us to at least
> > agree where we are disagring. Let me write down two statements and
> > please tell me where you disagree:
>=20
> I think we're mostly in agreement!
>=20
> >=20
> > 1. For a normal running FUSE server (without tmp pages), the lifetime o=
f
> > writeback state of fuse folios falls under "short-term unmovable" bucke=
t
> > as it does not differ in anyway from anyother filesystems handling
> > writeback folios.
>=20
> That's the expectation, yes. As long as the FUSE server is able to make=
=20
> progress, the expectation is that it's just like NFS etc. If it isn't=20
> able to make progress (i.e., crash), the expectation is that everything=
=20
> will get cleaned up either way.
>=20
> I wonder if there could be valid scenario where the FUSE server is no=20
> longer able to make progress (ignoring network outages), or the progress=
=20
> might start being extremely slow such that it becomes a problem. In=20
> contrast to in-kernel FSs, one can do some fancy stuff with fuse where=
=20
> writing a page could possibly consume a lot of memory in user-space.=20
> Likely, in this case we might just blame it on the admin that agreed to=
=20
> running this (trusted) fuse server.
>=20
> >=20
> > 2. For a buggy or untrusted FUSE server (without tmp pages), the
> > lifetime of writeback state of fuse folios can be arbitrarily long and
> > we need some mechanism to limit it.
>=20
> Yes.
>=20
>=20
> Especially in 1), we really want to wait for writeback to finish, just=
=20
> like for any other filesystem. For 2), we want a way so writeback will=
=20
> not get stuck for a long time, but are able to make progress and migrate=
=20
> these pages.
>=20

What if we were to allow the kernel to kill off an unprivileged FUSE
server that was "misbehaving" [1], clean any dirty pagecache pages that
it has, and set writeback errors on the corresponding FUSE inodes [2]?
We'd still need a rather long timeout (on the order of at least a
minute or so, by default).

Would that be enough to assuage concerns about unprivileged servers
pinning pages indefinitely? Buggy servers are still a problem, but
there's not much we can do about that.

There are a lot of details we'd have to sort out, so I'm also
interested in whether anyone (Miklos? Bernd?) would find this basic
approach objectionable.

[1]: for some definition of misbehavior. Probably a writeback
timeout=C2=A0of some sort but maybe there would be other criteria too.

[2]: or maybe just make them eligible to be cleaned without talking to
the server, should the VM wish it.
--=20
Jeff Layton <jlayton@kernel.org>

