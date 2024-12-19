Return-Path: <linux-fsdevel+bounces-37842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDB9F820E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322AE1605D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2119995D;
	Thu, 19 Dec 2024 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTRBcy9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5773C30
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629850; cv=none; b=PZa6wu8wMK1ChLioQj9XO/Vh6YSFGRP+qHVlSQV+x4GMpFSA5a8hYzlKVw8+VpbJDUUjZ6dglWNQeopEgY8CpNPE6trtSGwZWUAyqfgaP5EXYobce9CRZjnq2C4xczBXEydRu3TC3gEuqx70F5OoHI+KFFBjxnQgEXP1K7oxUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629850; c=relaxed/simple;
	bh=F791L0Fmm/odq5b4UjPLbEQyppVVAp7alGE3rYSaJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CytpRJdGWzex6w8ycqgliP61i9de+Zv/isHWJE7AIp3M5L4JyqFd2wSRks818O++/pFjhJfxZ5/VL5CIxnOstR8KQ16Vqvye8PQGx+/QmikUpTMBaSTi3AWuIUO8cjIdt7g7L59TJvCs+0HWJcZ0C9/vj0369EAqCsaS0FKPHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTRBcy9P; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 09:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734629846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez9lQ0zUpSZUQnMmCVi1G57IlRWrWw6LTcl8bwl1GfQ=;
	b=fTRBcy9PF31ktvOR3VGccK6aHxK2a4u5zfvB0ONMeTAqr2Agp0aq9UwpaEEeyMoIdaB0uC
	mIJd/EQvEKg4sSGzdJobv/zbD1R8zX6Jv9J4BWmXjgCArNgLwyo/wKOXEDnSRfOIwEN2mm
	1f0p/Oa/Kzia+4887i0SYWEDzLvCNgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
References: <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 06:30:34PM +0100, Bernd Schubert wrote:
> 
> 
> On 12/19/24 18:26, David Hildenbrand wrote:
> > On 19.12.24 18:14, Shakeel Butt wrote:
> >> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
> >>> On 19.12.24 17:40, Shakeel Butt wrote:
> >>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> >>>> [...]
> >>>>>>
> >>>>>> If you check the code just above this patch, this
> >>>>>> mapping_writeback_indeterminate() check only happen for pages under
> >>>>>> writeback which is a temp state. Anyways, fuse folios should not be
> >>>>>> unmovable for their lifetime but only while under writeback which is
> >>>>>> same for all fs.
> >>>>>
> >>>>> But there, writeback is expected to be a temporary thing, not
> >>>>> possibly:
> >>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> >>>>>
> >>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> >>>>> guarantees, and unfortunately, it sounds like this is the case
> >>>>> here, unless
> >>>>> I am missing something important.
> >>>>>
> >>>>
> >>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> >>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
> >>>> like anyother fs, should handle writeback pages appropriately. These
> >>>> additional checks and skips are for (I think) untrusted fuse servers.
> >>>
> >>> Can unprivileged user space provoke this case?
> >>
> >> Let's ask Joanne and other fuse folks about the above question.
> >>
> >> Let's say unprivileged user space can start a untrusted fuse server,
> >> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
> >> and memcg limits) and trigger the writeback. To cause pain (through
> >> fragmentation), it is not clearing the writeback state. Is this the
> >> scenario you are envisioning?
> > 
> > Yes, for example causing harm on a shared host (containers, ...).
> > 
> > If it cannot happen, we should make it very clear in documentation and
> > patch descriptions that it can only cause harm with privileged user
> > space, and that this harm can make things like CMA allocations, memory
> > onplug, ... fail, which is rather bad and against concepts like
> > ZONE_MOVABLE/MIGRATE_CMA.
> > 
> > Although I wonder what would happen if the privileged user space daemon
> > crashes  (e.g., OOM killer?) and simply no longer replies to any messages.
> > 
> 
> The request is canceled then - that should clear the page/folio state
> 
> 
> I start to wonder if we should introduce really short fuse request
> timeouts and just repeat requests when things have cleared up. At least
> for write-back requests (in the sense that fuse-over-network might
> be slow or interrupted for some time).
> 
> 

Thanks Bernd for the response. Can you tell a bit more about the request
timeouts? Basically does it impact/clear the page/folio state as well?

