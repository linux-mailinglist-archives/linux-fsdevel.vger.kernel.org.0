Return-Path: <linux-fsdevel+bounces-38280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5EE9FEA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171FC161931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2B1990DE;
	Mon, 30 Dec 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kubpX0jz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5C173
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735589055; cv=none; b=oam63mLdDyG3PBD5uYLzCuTgGC6ymDnvTaSUfQp6cGUFg9OS1eSZEe4ln0P5nhgkt57TRkJoYVuItyjKfGGZlJWFV26SuRWPVgkftH6E9JwQJEz5NufpjJVCyvnbASiQaPj+MqBilHWBzBawU38vyC3HSQNybbunTX0bmRNjLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735589055; c=relaxed/simple;
	bh=mAFEi0ngcyyfy2O+EJTK7Kye54LVRbWkUP7kBF4sSUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbK+cdc3SrIeJ+S0Oe2D60hKOHtKdZBZpl50qgNqEDEOo2NXzKBOn3UuKjABtQbtkyq7ArfnnP+Szy55tW6LR6oOoWXz9h4Efs/kI7rmF9A/PDnABkEFnj2TAYxRfIv8M9KCYh2E3S/qfC0Lqjk3s0i/JoEhI0PTGbPW0qgFJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kubpX0jz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Dec 2024 12:04:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735589047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EO1Yi3HcLyfpgCw0VDXNfnE46zeiYYc/QyQcLhmjIQ=;
	b=kubpX0jzPig1X4Rk5l+eT3miiVNear2eJFMJkj37Doj9uiV2E9fHSIQXFfExW7F0UlEugo
	/90k/ZGzB9Aa7g4nlO0CEufkVIKxCJdozakae0m+rgN569xZ4HCvwRhM8m630qucx6YS4x
	6JSH88H32bqo19zHzwv+imdC9fG+nmY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <xucuoi4ywape4ftgzgahqqgzk6xhvotzdu67crq37ccmyl53oa@oiq354b6sfu7>
References: <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 30, 2024 at 10:38:16AM -0800, Joanne Koong wrote:
> On Mon, Dec 30, 2024 at 2:16 AM David Hildenbrand <david@redhat.com> wrote:

Thanks David for the response.

> >
> > >> BTW, I just looked at NFS out of interest, in particular
> > >> nfs_page_async_flush(), and I spot some logic about re-dirtying pages +
> > >> canceling writeback. IIUC, there are default timeouts for UDP and TCP,
> > >> whereby the TCP default one seems to be around 60s (* retrans?), and the
> > >> privileged user that mounts it can set higher ones. I guess one could run
> > >> into similar writeback issues?
> > >
> >
> > Hi,
> >
> > sorry for the late reply.
> >
> > > Yes, I think so.
> > >
> > >>
> > >> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
> > >
> > > I feel like INDETERMINATE in the name is the main cause of confusion.
> >
> > We are adding logic that says "unconditionally, never wait on writeback
> > for these folios, not even any sync migration". That's the main problem
> > I have.
> >
> > Your explanation below is helpful. Because ...
> >
> > > So, let me explain why it is required (but later I will tell you how it
> > > can be avoided). The FUSE thread which is actively handling writeback of
> > > a given folio can cause memory allocation either through syscall or page
> > > fault. That memory allocation can trigger global reclaim synchronously
> > > and in cgroup-v1, that FUSE thread can wait on the writeback on the same
> > > folio whose writeback it is supposed to end and cauing a deadlock. So,
> > > AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
> >  > > The in-kernel fs avoid this situation through the use of GFP_NOFS
> > > allocations. The userspace fs can also use a similar approach which is
> > > prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have been
> > > told that it is hard to use as it is per-thread flag and has to be set
> > > for all the threads handling writeback which can be error prone if the
> > > threadpool is dynamic. Second it is very coarse such that all the
> > > allocations from those threads (e.g. page faults) become NOFS which
> > > makes userspace very unreliable on highly utilized machine as NOFS can
> > > not reclaim potentially a lot of memory and can not trigger oom-kill.
> > >
> >
> > ... now I understand that we want to prevent a deadlock in one specific
> > scenario only?
> >
> > What sounds plausible for me is:
> >
> > a) Make this only affect the actual deadlock path: sync migration
> >     during compaction. Communicate it either using some "context"
> >     information or with a new MIGRATE_SYNC_COMPACTION.
> > b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
> >      that very deadlock problem.
> > c) Leave all others sync migration users alone for now
> 
> The deadlock path is separate from sync migration. The deadlock arises
> from a corner case where cgroupv1 reclaim waits on a folio under
> writeback where that writeback itself is blocked on reclaim.
> 

Joanne, let's drop the patch to migrate.c completely and let's rename
the flag to something like what David is suggesting and only handle in
the reclaim path.

> >
> > Would that prevent the deadlock? Even *better* would be to to be able to
> > ask the fs if starting writeback on a specific folio could deadlock.
> > Because in most cases, as I understand, we'll  not actually run into the
> > deadlock and would just want to wait for writeback to just complete
> > (esp. compaction).
> >
> > (I still think having folios under writeback for a long time might be a
> > problem, but that's indeed something to sort out separately in the
> > future, because I suspect NFS has similar issues. We'd want to "wait
> > with timeout" and e.g., cancel writeback during memory
> > offlining/alloc_cma ...)

Thanks David and yes let's handle the folios under writeback issue
separately.

> 
> I'm looking back at some of the discussions in v2 [1] and I'm still
> not clear on how memory fragmentation for non-movable pages differs
> from memory fragmentation from movable pages and whether one is worse
> than the other.

I think the fragmentation due to movable pages becoming unmovable is
worse as that situation is unexpected and the kernel can waste a lot of
CPU to defrag the block containing those folios. For non-movable blocks,
the kernel will not even try to defrag. Now we can have a situation
where almost all memory is backed by non-movable blocks and higher order
allocations start failing even when there is enough free memory. For
such situations either system needs to be restarted (or workloads
restarted if they are cause of high non-movable memory) or the admin
needs to setup ZONE_MOVABLE where non-movable allocations don't go.

> Currently fuse uses movable temp pages (allocated with
> gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
> issue where a buggy/malicious server may never complete writeback.

So, these temp pages are not an issue for fragmenting the movable blocks
but if there is no limit on temp pages, the whole system can become
non-movable (there is a case where movable blocks on non-ZONE_MOVABLE
can be converted into non-movable blocks under low memory). ZONE_MOVABLE
will avoid such scenario but tuning the right size of ZONE_MOVABLE is
not easy.

> This has the same effect of fragmenting memory and has a worse memory
> cost to the system in terms of memory used. With not having temp pages
> though, now in this scenario, pages allocated in a movable page block
> can't be compacted and that memory is fragmented. My (basic and maybe
> incorrect) understanding is that memory gets allocated through a buddy
> allocator and moveable vs nonmovable pages get allocated to
> corresponding blocks that match their type, but there's no other
> difference otherwise. Is this understanding correct? Or is there some
> substantial difference between fragmentation for movable vs nonmovable
> blocks?

The main difference is the fallback of high order allocation which can
trigger compaction or background compaction through kcompactd. The
kernel will only try to defrag the movable blocks.


