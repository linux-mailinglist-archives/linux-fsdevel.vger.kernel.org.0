Return-Path: <linux-fsdevel+bounces-38911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE12A09C6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B9162E73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4521576E;
	Fri, 10 Jan 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQMhq6Gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1962215049
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540916; cv=none; b=q8YYvH1g/l5Ad5+JB+M+DhXEveJG9B99rh/Po/6dUu8TnAq44bAxWaBcjC7KB/WINk/Gix4qNzgvQh4KAkdxLAmohntCvJE5/8MHQByuA8Vj+8l4RvsMlyuaYqD76Yd2Xsm2X1fT8ZypOxWOnP0pRn3NCjCjDlVk6yYM/wO/G6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540916; c=relaxed/simple;
	bh=Ptzj1/3QIqtF0Doe2VkJY82nu9Rzq5AEXnndywJrJOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNifp1dg6SEiFQKlIDJ/zTDKP6UwjIFym7cvdnGWGkDRNHwYZH/lKdyDVIu2wXUBKQaI09T0vUvMGN7aLwhKVqtq5mL30aKdFnxhilIDqjTHop51ckus/Xg5eMtrrEtneaciOIMREpBxnrrTTp8631F/G9X7jLPY0mOu8tRspa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQMhq6Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B065C4CED6;
	Fri, 10 Jan 2025 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736540916;
	bh=Ptzj1/3QIqtF0Doe2VkJY82nu9Rzq5AEXnndywJrJOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GQMhq6GpEVk0Rxm3fVXMgPbBh/TZaU2sIYGyAL41+L68ak3n/2+g+BCq0shQv55iA
	 P69exTSH/Lg4WSG7oX3yhS6qG3Ms/n9EEzS+MnAjYlBPVmrTQk2U/VTCf23E9DOs88
	 5rBuB/8X7y5ItWVPX35fmWSsRvqBXVEjCMUUCFtCVfFfjHQg5fa9DlX94SVVqPMMTr
	 L9OCCNsT5ixOBVtrP97Hu+qj5P9m1Qau9D7Su8cYwdc0om3+YX0zgR+2MMP8M3qV8L
	 JG5RS3pYN6j0QMGcwvl6UqSPEblFXtBI2S94K5HhtMGXrF1g0BF0YTnCwSa8uqdeIK
	 pDW+4SXBS9gVw==
Message-ID: <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
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
Date: Fri, 10 Jan 2025 15:28:33 -0500
In-Reply-To: <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
References: 
	<h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
	 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
	 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
	 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
	 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
	 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
	 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
	 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
	 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
	 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
	 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
	 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
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

On Thu, 2025-01-09 at 12:22 +0100, David Hildenbrand wrote:
> On 07.01.25 19:07, Shakeel Butt wrote:
> > On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
> > > On 06.01.25 19:17, Shakeel Butt wrote:
> > > > On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> > > > > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com>=
 wrote:
> > > > > > In any case, having movable pages be turned unmovable due to pe=
rsistent
> > > > > > writaback is something that must be fixed, not worked around. L=
ikely a
> > > > > > good topic for LSF/MM.
> > > > >=20
> > > > > Yes, this seems a good cross fs-mm topic.
> > > > >=20
> > > > > So the issue discussed here is that movable pages used for fuse
> > > > > page-cache cause a problems when memory needs to be compacted. Th=
e
> > > > > problem is either that
> > > > >=20
> > > > >    - the page is skipped, leaving the physical memory block unmov=
able
> > > > >=20
> > > > >    - the compaction is blocked for an unbounded time
> > > > >=20
> > > > > While the new AS_WRITEBACK_INDETERMINATE could potentially make t=
hings
> > > > > worse, the same thing happens on readahead, since the new page ca=
n be
> > > > > locked for an indeterminate amount of time, which can also block
> > > > > compaction, right?
> > >=20
> > > Yes, as memory hotplug + virtio-mem maintainer my bigger concern is t=
hese
> > > pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must =
not be
> > > unmovable pages ever*. Not triggered by an untrusted source, not trig=
gered
> > > by an trusted source.
> > >=20
> > > It's a violation of core-mm principles.
> >=20
> > The "must not be unmovable pages ever" is a very strong statement and w=
e
> > are violating it today and will keep violating it in future. Any
> > page/folio under lock or writeback or have reference taken or have been
> > isolated from their LRU is unmovable (most of the time for small period
> > of time).
>=20
> ^ this: "small period of time" is what I meant.
>=20
> Most of these things are known to not be problematic: retrying a couple=
=20
> of times makes it work, that's why migration keeps retrying.
>=20
> Again, as an example, we allow short-term O_DIRECT but disallow=20
> long-term page pinning. I think there were concerns at some point if=20
> O_DIRECT might also be problematic (I/O might take a while), but so far=
=20
> it was not a problem in practice that would make CMA allocations easily=
=20
> fail.
>=20
> vmsplice() is a known problem, because it behaves like O_DIRECT but=20
> actually triggers long-term pinning; IIRC David Howells has this on his=
=20
> todo list to fix. [I recall that seccomp disallows vmsplice by default=
=20
> right now]
>=20
> These operations are being done all over the place in kernel.
> > Miklos gave an example of readahead.=20
>=20
> I assume you mean "unmovable for a short time", correct, or can you=20
> point me at that specific example; I think I missed that.
>=20
> > The per-CPU LRU caches are another
> > case where folios can get stuck for long period of time.
>=20
> Which is why memory offlining disables the lru cache. See=20
> lru_cache_disable(). Other users that care about that drain the LRU on=
=20
> all cpus.
>=20
> > Reclaim and
> > compaction can isolate a lot of folios that they need to have
> > too_many_isolated() checks. So, "must not be unmovable pages ever" is
> > impractical.
>=20
> "must only be short-term unmovable", better?
>=20

Still a little ambiguous.

How short is "short-term"? Are we talking milliseconds or minutes?

Imposing a hard timeout on writeback requests to unprivileged FUSE
servers might give us a better guarantee of forward-progress, but it
would probably have to be on the order of at least a minute or so to be
workable.

> >=20
> > The point is that, yes we should aim to improve things but in iteration=
s
> > and "must not be unmovable pages ever" is not something we can achieve
> > in one step.
>=20
> I agree with the "improve things in iterations", but as
> AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I think we=
=20
> are making things worse.
>=20
> And as this discussion has been going on for too long, to summarize my=
=20
> point: there exist conditions where pages are short-term unmovable, and=
=20
> possibly some to be fixed that turn pages long-term unmovable (e.g.,=20
> vmsplice); that does not mean that we can freely add new conditions that=
=20
> turn movable pages unmovable long-term or even forever.
>=20
> Again, this might be a good LSF/MM topic. If I would have the capacity I=
=20
> would suggest a topic around which things are know to cause pages to be=
=20
> short-term or long-term unmovable/unsplittable, and which can be=20
> handled, which not. Maybe I'll find the time to propose that as a topic.
>=20


This does sound like great LSF/MM fodder! I predict that this session
will run long! ;)
--=20
Jeff Layton <jlayton@kernel.org>

