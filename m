Return-Path: <linux-fsdevel+bounces-34106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563209C276B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026C3B22195
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7E1E2308;
	Fri,  8 Nov 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VIIWeH0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD9233D8C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104204; cv=none; b=KBqNdwAQQ3ZZgLgGCxG4IeHwXUE+fU+QvEM9k6A+bn+WisoSrNw8VsnyyoT8LWRWXQPQqNpzzYbd82MzQD1hrFLiGmP//m0RrpqN1PBf6HHSFGF3ZEd/ijtSBEtezSEhOILWlc5iQMb9CJ8rChjUgcuGesh4D2RqtVSXw9LHRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104204; c=relaxed/simple;
	bh=LBFRP0JTwnEVW/d1WLLBguyx3oRPTDU4IKgBerldAS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1z+GA4q+EoZDMW39NdCLi35yhPSvVA5BsQPbk4bPhqteXddkRjE14f8kfa7pETLT/siHjukyD7gMMEiFQ28f87TB4t8MtLP1TXuB+SLnVbyABuvdtmFNBXI7nzEa4FNSwnOPPkMUz9cFCLqPLpax2vMBUtha88M9KImkgQ9GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VIIWeH0W; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 14:16:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731104199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EQA/u/di435J031cHsPSCZ6GchrgeL10rcf6y5Zp9M=;
	b=VIIWeH0Wu/ekCsmbps6oNjcWt4r3MtQaHkG38/ef4l7uLU3NwLLG2yqtcMMzaK2by1Ya8o
	bZZGXV/ZCLDag9mCqvKqK+7ZLfTEV3cmcmM5w73fQ/mncMdfryZSqr91OvrlvV0ddA/L7b
	g+5rn3hx4He0lfBxz6P6jniKIQrOTao=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
Message-ID: <2ecmqokellladmioa5rvw57lqbz3ouevx5q5weyydjius3cu2s@vl3siu2b3gs6>
References: <20241108173309.71619-1-sj@kernel.org>
 <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
 <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com>
 <ubpkgutgkm2te7tu3dyvjxxkcmhelawd24lyaqnxrbvzgj7psl@zli7u63w4qgu>
 <CAJnrk1Y-BRg6qyQoUvZW7mUfydp+cM1Rxtd_v0UaKOLuL9OUUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y-BRg6qyQoUvZW7mUfydp+cM1Rxtd_v0UaKOLuL9OUUQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 01:42:15PM -0800, Joanne Koong wrote:
> On Fri, Nov 8, 2024 at 1:27 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Nov 08, 2024 at 08:00:25PM +0100, David Hildenbrand wrote:
> > > On 08.11.24 19:56, David Hildenbrand wrote:
> > > > On 08.11.24 18:33, SeongJae Park wrote:
> > > > > + David Hildenbrand
> > > > >
> > > > > On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > > In offline_pages(), do_migrate_range() may potentially retry forever if
> > > > > > the migration fails. Add a return value for do_migrate_range(), and
> > > > > > allow offline_page() to try migrating pages 5 times before erroring
> > > > > > out, similar to how migration failures in __alloc_contig_migrate_range()
> > > > > > is handled.
> > > > >
> > > > > I'm curious if this could cause unexpected behavioral differences to memory
> > > > > hotplugging users, and how '5' is chosen.  Could you please enlighten me?
> > > > >
> > > >
> > > > I'm wondering how much more often I'll have to nack such a patch. :)
> > >
> > > A more recent discussion: https://lore.kernel.org/linux-mm/52161997-15aa-4093-a573-3bfd8da14ff1@fujitsu.com/T/#mdda39b2956a11c46f8da8796f9612ac007edbdab
> > >
> > > Long story short: this is expected and documented
> >
> > Thanks David for the background.
> >
> > Joanne, simply drop this patch. It is not required for your series.
> 
> Awesome, I'm happy to drop this patch.
> 
> Just curious though - don't we need this in order to mitigate the
> scenario where if an unprivileged fuse server never completes
> writeback, we don't run into this infinite loop? Or is it that memory
> hotplugging is always initiated from userspace so if it does run into
> an infinite loop (like also in that thread David linked), userspace is
> responsible for sending a signal to terminate it?

I think irrespective of the source of the hotplug, the current behavior
of infinite retries in some cases is documented and kind of expected, so
no need to fix it. (Though I don't know all the source of hotplug.)



