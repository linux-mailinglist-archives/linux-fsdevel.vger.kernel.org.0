Return-Path: <linux-fsdevel+bounces-38469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABFFA02FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AB03A2313
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAF1DF96C;
	Mon,  6 Jan 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBwJU8gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AE1DEFE0
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187437; cv=none; b=dDZq+shUzoruQ8hhklIJgZrqIPc37WXnNUjpdudnhbsYVR30TyhVyhdD39CEU3pqYZgkNq2RLZl0ZFvW150Bb8dgYP48qXxNlHjDPDil2/Zyqx6qTkA4uyMDcaeNdm8i/EU1TsTzE2oUdm8jsyylw9ge0TMQpquTZke85tvrZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187437; c=relaxed/simple;
	bh=g9dc5Lu6Gld/K+YCW8s4GBM6yhtqFCgaxrIVQbpfXcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNyUzOJk+4ZHZAVgQDF43boGe3Asz6qR781SarYv1gF+K5+dniw5z1Z7vP+LN2VLvJTGB9YW2me+7l9i+03xoxNvvWGzNvTV1XkYrO1BOgO4S6ORm1vToOlVDoklhRJWd4U2k1PoLPbee2VLOLxh9d6GvhqzmiabIz6bDmQsXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBwJU8gy; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Jan 2025 10:17:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736187431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW004tH/9lu/RWW+ZuOYddiYj4MOyI5Pw6bzV4PD2YQ=;
	b=BBwJU8gynqj/rS5kpofAbb+oBBDrQSiG+mwSfq6x4akKzSWe/0rqX1Y40alPj44gtCO2JM
	K21Dyn3kCLfxX3HypXXrnQ/OYrqRDbW49GXFH5v3AsrzQVbtyI9XADzjop93EQS0qtFyW1
	qzKU/qFJEHNNlW1nOBSDUuDEZDVd3jM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Hildenbrand <david@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
> > In any case, having movable pages be turned unmovable due to persistent
> > writaback is something that must be fixed, not worked around. Likely a
> > good topic for LSF/MM.
> 
> Yes, this seems a good cross fs-mm topic.
> 
> So the issue discussed here is that movable pages used for fuse
> page-cache cause a problems when memory needs to be compacted. The
> problem is either that
> 
>  - the page is skipped, leaving the physical memory block unmovable
> 
>  - the compaction is blocked for an unbounded time
> 
> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
> worse, the same thing happens on readahead, since the new page can be
> locked for an indeterminate amount of time, which can also block
> compaction, right?

Yes locked pages are unmovable. How much of these locked pages/folios
can be caused by untrusted fuse server?

> 
> What about explicitly opting fuse cache pages out of compaction by
> allocating them form ZONE_UNMOVABLE?

This can be done but it will change the memory condition of the
users/workloads/systems where page cache is the majority of the memory
(i.e. majority of memory will be unmovable) and when such systems are
overcommitted, weird corner cases will arise (failing high order
allocations, long term fragmentation etc). In addition the memory
behind CXL will become unusable for fuse folios.

IMHO the transient unmovable state of fuse folios due to writeback is
not an issue if we can show that untrusted fuse server can not cause
unlimited folios under writeback for arbitrary long time.

