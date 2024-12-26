Return-Path: <linux-fsdevel+bounces-38144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EB9FCD8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636FB1605E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF414D6F6;
	Thu, 26 Dec 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKa5fYN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721D1487F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735244025; cv=none; b=AuX4Zrhr4sd4QcJ8cupGAh4kfX88PgE5AoP60NAXFjpQgKNKMZDrGZmbDdl+cAvQtv/gl/iedrD76J8q4Zzm+DVxGXOnU0PYKSA/XvA3PWO5dd2Rb8ddtg5IY06ZrqHcDMCfkd0LQY5fy6M+n0PGdqh0qC+67iJn9ls7WK6MoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735244025; c=relaxed/simple;
	bh=9ScLo8zAdZcfB8Va4rhFHSzbbijKduiUuATonmMpMzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUT5k9Py0Odsvm5VeQtpYG9ngvSH+bKee7E4wNK4oGLiI7zhiTR+HHoZGspqT8VnEn21iHZShZGW2Y2TrJXs8DEUg1JDSyb36Z/2EJf1uesuNklpIIt/CNnmS50gDavK5fPowKkRBHZjAe0T/2Z6aB60S4WfXSqvAkkRzpPTp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rKa5fYN8; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Dec 2024 12:13:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735244021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jDU6jGbZ1YZto3bGPgf17bh0IrAa0am6oSu/fSXsJY=;
	b=rKa5fYN8f9rLOGty2/F/o38SmG9bjWuLlpWHf2wELyMMui6ycoiBf5xVy2xpV01YxSRHKE
	+oJodTzsiyvFsfoqBuiaF2ZszqFiKXsMkPR/T9SETrlFY6pabGyY45W1aIvn7GTvj/hBmY
	KGYAPl7XlP56pwCf8HSVXZo2x5/O+fQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
References: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 24, 2024 at 01:37:49PM +0100, David Hildenbrand wrote:
> On 23.12.24 23:14, Shakeel Butt wrote:
> > On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
> > [...]
> > > 
> > > Yes, so I can see fuse
> > > 
> > > (1) Breaking memory reclaim (memory cannot get freed up)
> > > 
> > > (2) Breaking page migration (memory cannot be migrated)
> > > 
> > > Due to (1) we might experience bigger memory pressure in the system I guess.
> > > A handful of these pages don't really hurt, I have no idea how bad having
> > > many of these pages can be. But yes, inherently we cannot throw away the
> > > data as long as it is dirty without causing harm. (maybe we could move it to
> > > some other cache, like swap/zswap; but that smells like a big and
> > > complicated project)
> > > 
> > > Due to (2) we turn pages that are supposed to be movable possibly for a long
> > > time unmovable. Even a *single* such page will mean that CMA allocations /
> > > memory unplug can start failing.
> > > 
> > > We have similar situations with page pinning. With things like O_DIRECT, our
> > > assumption/experience so far is that it will only take a couple of seconds
> > > max, and retry loops are sufficient to handle it. That's why only long-term
> > > pinning ("indeterminate", e.g., vfio) migrate these pages out of
> > > ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
> > > 
> > > 
> > > The biggest concern I have is that timeouts, while likely reasonable it many
> > > scenarios, might not be desirable even for some sane workloads, and the
> > > default in all system will be "no timeout", letting the clueless admin of
> > > each and every system out there that might support fuse to make a decision.
> > > 
> > > I might have misunderstood something, in which case I am very sorry, but we
> > > also don't want CMA allocations to start failing simply because a network
> > > connection is down for a couple of minutes such that a fuse daemon cannot
> > > make progress.
> > > 
> > 
> > I think you have valid concerns but these are not new and not unique to
> > fuse. Any filesystem with a potential arbitrary stall can have similar
> > issues. The arbitrary stall can be caused due to network issues or some
> > faultly local storage.
> 
> What concerns me more is that this is can be triggered by even unprivileged
> user space, and that there is no default protection as far as I understood,
> because timeouts cannot be set universally to a sane defaults.
> 
> Again, please correct me if I got that wrong.
> 

Let's route this question to FUSE folks. More specifically: can an
unprivileged process create a mount point backed by itself, create a
lot of dirty (bound by cgroup) and writeback pages on it and let the
writeback pages in that state forever?

> 
> BTW, I just looked at NFS out of interest, in particular
> nfs_page_async_flush(), and I spot some logic about re-dirtying pages +
> canceling writeback. IIUC, there are default timeouts for UDP and TCP,
> whereby the TCP default one seems to be around 60s (* retrans?), and the
> privileged user that mounts it can set higher ones. I guess one could run
> into similar writeback issues?

Yes, I think so.

> 
> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?

I feel like INDETERMINATE in the name is the main cause of confusion.
So, let me explain why it is required (but later I will tell you how it
can be avoided). The FUSE thread which is actively handling writeback of
a given folio can cause memory allocation either through syscall or page
fault. That memory allocation can trigger global reclaim synchronously
and in cgroup-v1, that FUSE thread can wait on the writeback on the same
folio whose writeback it is supposed to end and cauing a deadlock. So,
AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.

The in-kernel fs avoid this situation through the use of GFP_NOFS
allocations. The userspace fs can also use a similar approach which is
prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have been
told that it is hard to use as it is per-thread flag and has to be set
for all the threads handling writeback which can be error prone if the
threadpool is dynamic. Second it is very coarse such that all the
allocations from those threads (e.g. page faults) become NOFS which
makes userspace very unreliable on highly utilized machine as NOFS can
not reclaim potentially a lot of memory and can not trigger oom-kill.

> Not
> sure if I grasped all details about NFS and writeback and when it would
> redirty+end writeback, and if there is some other handling in there.
> 
[...]
> > 
> > Please note that such filesystems are mostly used in environments like
> > data center or hyperscalar and usually have more advanced mechanisms to
> > handle and avoid situations like long delays. For such environment
> > network unavailability is a larger issue than some cma allocation
> > failure. My point is: let's not assume the disastrous situaion is normal
> > and overcomplicate the solution.
> 
> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be used
> for movable allocations.
> 
> Mechanisms that possible turn these folios unmovable for a
> long/indeterminate time must either fail or migrate these folios out of
> these regions, otherwise we start violating the very semantics why
> ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
> 
> Yes, there are corner cases where we cannot guarantee movability (e.g., OOM
> when allocating a migration destination), but these are not cases that can
> be triggered by (unprivileged) user space easily.
> 
> That's why FOLL_LONGTERM pinning does exactly that: even if user space would
> promise that this is really only "short-term", we will treat it as "possibly
> forever", because it's under user-space control.
> 
> 
> Instead of having more subsystems violate these semantics because
> "performance" ... I would hope we would do better. Maybe it's an issue for
> NFS as well ("at least" only for privileged user space)? In which case,
> again, I would hope we would do better.
> 
> 
> Anyhow, I'm hoping there will be more feedback from other MM folks, but
> likely right now a lot of people are out (just like I should ;) ).
> 
> If I end up being the only one with these concerns, then likely people can
> feel free to ignore them. ;)

I agree we should do better but IMHO it should be an iterative process.
I think your concerns are valid, so let's push the discussion towards
resolving those concerns. I think the concerns can be resolved by better
handling of lifetime of folios under writeback. The amount of such
folios is already handled through existing dirty throttling mechanism.

We should start with a baseline i.e. distribution of lifetime of folios
under writeback for traditional storage devices (spinning disk and SSDs)
as we don't want an unrealistic goal for ourself. I think this data will
drive the appropriate timeout values (if we decide timeout based
approach is the right one).

At the moment we have timeout based approach to limit the lifetime of
folios under writeback. Any other ideas?

