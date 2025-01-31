Return-Path: <linux-fsdevel+bounces-40481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00623A23B40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9EB188A0A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4C18CC1D;
	Fri, 31 Jan 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sC9ryRzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B216A956
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738315324; cv=none; b=p4MJZ2a6KXY8yqGnITEQj3R4cPhX7jaNERjZFvCZLQuEAgvusp5eP560gBsnGw/jCY+xZqGFOm4EQlxd6xrof1Ci5Ge+HVRUckQGsgmJ+XJvA/sjyMUoZO5k+GTvtxR5qhYrebQQfqTXThdSkSBCNDyGDrzGbuPPk4jaO5JxJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738315324; c=relaxed/simple;
	bh=gSCWE33P5OLet6Ugwm1e3TOG/wa7Iypf9tttdEtnhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMt2oYWJGOZuFI3w8Kh6G/VHmixB/NoNA9F8aaYPPbvOwxyDPMdf4pt3Wde41mlUWwHf3sbNpclHmx/OR66M32ZJd4Z0lP5K+3H8do/Hk/2hnNM9Gf87fWYPmCVbseLtO2Hjz5tFEoZoehjHZOpK+boW96DJ6ooi+/121Idyyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sC9ryRzj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 31 Jan 2025 01:21:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738315314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nao/21fKq7dfZvtGOLf2zDrQLZAuXxCXxgWG8ruJc+s=;
	b=sC9ryRzjcNGw4dvAk/4RewObnXn4/1bJAa2tNszv23PQQA0cTYr8BAyEkvtDcQB1P1pegR
	fd9wpRKdfEgf5ffSTJazsKkG4eLs78EyTUmjPGWq6+rwlPE6NL93wfoe6p/gYS3lWMWBx3
	SX7hCZ5u8sqWv7SRqU7bYZus3MWUkwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: David Hildenbrand <david@redhat.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
Message-ID: <lrl2fbxfow736xfk3mfxm5eenv56h2by242vr7zbikhighbfwf@unwst5phncpp>
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
 <CAPTztWbVjObmLc9=WXPx6fAfuVT3B7+gts7gQmGseWjS37atvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbVjObmLc9=WXPx6fAfuVT3B7+gts7gQmGseWjS37atvg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 11:39:29AM -0800, Frank van der Linden wrote:
> On Wed, Jan 29, 2025 at 8:10 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > Hi,
> >
> > ___GFP_MOVABLE allocations are supposed to be movable -> migratable: the
> > page allocator can place them on
> > MIGRATE_CMA/ZONE_MOVABLE/MIGRATE_MOVABLE areas: areas where the
> > expectation is that allocations can be migrated (somewhat reliably) to
> > different memory areas on demand.
> >
> > Mechanisms that turn such allocations unmigratable, such as long-term
> > page pinning (FOLL_LONGTERM), migrate these allocations at least out of
> > MIGRATE_CMA/ZONE_MOVABLE areas first.
> >
> > Ideally, we'd only perform this migration if really required (e.g.,
> > long-term pinning), and rather "fix" other cases to not turn allocations
> > unmigratable.
> >
> > However, we have some rather obscure cases that can turn migratable
> > allocations effectively unmigratable for a long/indeterminate time,
> > possibly controlled by unprivileged user space.
> >
> > Possible effects include:
> > * CMA allocations failing
> > * Memory hotunplug not making progress
> > * Memory compaction not working as expected
> >
> > Some cases I can fix myself [1], others are harder to tackle.
> >
> > As one example, in context of FUSE we recently discovered that folios
> > that are under writeback cannot be migrated, and user space in control
> > of when writeback will end. Something similar can happen ->readahead()
> > where user space is in charge of supplying page content. Networking
> > filesystems in general seem to be prone to this as well.
> >
> > As another example, failing to split large folios can prevent migration
> > if memory is fragmented. XFS (IOMAP in general) refuses to split folios
> > that are dirty [3]. Splitting of folios and page migration have a lot in
> > common.
> >
> > This session is to collect cases that are known to be problematic, and
> > to start discussing possible approaches to make some of these
> > un-migratable allocations migratable, or alternative strategies to deal
> > with this.
> >
> >
> > [1] https://lkml.kernel.org/r/20250129115411.2077152-1-david@redhat.com
> > [2]
> > https://lkml.kernel.org/r/CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com
> > [3]
> > https://lkml.kernel.org/r/4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
> >
> 
> We have run in to the same issues (especially the writeback one), so a
> definite +1 on this topic from me.

Can you share a bit more on what issues you ran into with writeback
folios causing fragmentation or making memory unmovable for arbitrarily
long time? 

