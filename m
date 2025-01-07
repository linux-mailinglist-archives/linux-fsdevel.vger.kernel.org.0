Return-Path: <linux-fsdevel+bounces-38597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18FA048E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE73A5557
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2618C900;
	Tue,  7 Jan 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F42TyEdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3753AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273286; cv=none; b=aDz26J8tJa69hiOamj0vxNVsBqIeRfYe05FbvCp9h1BP0avQFO0mz+UZgcujFkMCL4xTrmD002wZy1z8CvtfoLrTNojFvXlSosxrlaH/l6ourWjymaF0lLrPW48nrsr0TpvjuX5tTc6OLAarCho2M5ypoZpNLdMpy0FeJCwVRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273286; c=relaxed/simple;
	bh=UEjZcVWnfS2uXxtqUyVgvGvg6PJIgM9A46dNuLcwf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe7z2kUTYgyipD88B6ZMw7L92esrxUHYy3vUZjlNU5F70jWEzVdFNUX2riXAc3Zg4SpwAOXtUBRD5B5Bu7CYYGvidzsYAEj3hc9XbdUiNkuzBB3hGqlBaesHZTrwstcp8FpBTn9chOqZas5wm8B136sfLixGzLEiav2N28UsBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F42TyEdB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Jan 2025 10:07:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736273278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlTBV59tQI4p6soTuVdHSsi53ggiM94qcxAUVClW1FI=;
	b=F42TyEdBzh/W4f1dY/234muoLagcd0O75lKfy7Oq+0AHaJlb6XC2xNKtL57w2JFI+AMzWq
	i+5lvm2vi+gcJ1SMdDqYzR8DZXCn/8Y0vuLbCrtPZdSlzuz4UmLOQemEoCfBScdtRMwSpH
	lhGEiwRFT/PhywZhju361Hd/xBLhn6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
References: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
> On 06.01.25 19:17, Shakeel Butt wrote:
> > On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> > > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
> > > > In any case, having movable pages be turned unmovable due to persistent
> > > > writaback is something that must be fixed, not worked around. Likely a
> > > > good topic for LSF/MM.
> > > 
> > > Yes, this seems a good cross fs-mm topic.
> > > 
> > > So the issue discussed here is that movable pages used for fuse
> > > page-cache cause a problems when memory needs to be compacted. The
> > > problem is either that
> > > 
> > >   - the page is skipped, leaving the physical memory block unmovable
> > > 
> > >   - the compaction is blocked for an unbounded time
> > > 
> > > While the new AS_WRITEBACK_INDETERMINATE could potentially make things
> > > worse, the same thing happens on readahead, since the new page can be
> > > locked for an indeterminate amount of time, which can also block
> > > compaction, right?
> 
> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is these
> pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must not be
> unmovable pages ever*. Not triggered by an untrusted source, not triggered
> by an trusted source.
> 
> It's a violation of core-mm principles.

The "must not be unmovable pages ever" is a very strong statement and we
are violating it today and will keep violating it in future. Any
page/folio under lock or writeback or have reference taken or have been
isolated from their LRU is unmovable (most of the time for small period
of time). These operations are being done all over the place in kernel.
Miklos gave an example of readahead. The per-CPU LRU caches are another
case where folios can get stuck for long period of time. Reclaim and
compaction can isolate a lot of folios that they need to have
too_many_isolated() checks. So, "must not be unmovable pages ever" is
impractical.

The point is that, yes we should aim to improve things but in iterations
and "must not be unmovable pages ever" is not something we can achieve
in one step. Though I doubt that state is practically achievable and to
me something like a bound (time or amount) on the transient unmovable
folios is more practical.

