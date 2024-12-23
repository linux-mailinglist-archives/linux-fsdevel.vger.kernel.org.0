Return-Path: <linux-fsdevel+bounces-38079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139D9FB6E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B01628CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BD1C1F0F;
	Mon, 23 Dec 2024 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sE9Fyiwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE81BBBDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734992084; cv=none; b=Wrh2awUyRUMVaJh81Th5tZP+4qYkoGEiTGK2BtYiGj6oge3jdXCGPTr+7342GoewUIY+8Rwz/S7C0h2Dt8iKDh7+PgwidGj3+wJhSKJTad9MV/Si+hp3KzfzSd//HgD+QSnKkH2NP9PFUNp89hEXE3aN40TtxUnzqzRZFNTR/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734992084; c=relaxed/simple;
	bh=rdXB+Ya/JTPcwltHXPSbAf32ZXDthDu/9s7fjzAKnvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADcgfa4gckWkKnt+8HiOlG1fV2Vgmixjmjsc4/FeurV87TEz5OL0+b9EmXrBtvxw2oAw8VohoGaUZTwv2bNwfXytCA83Vr6vMvFSjoaguCQiBM2+HnYXDSfGszp42lpqtxZqUGEC6lszrFyjUJhvW3vvswNF2cl71SeVxz6+H4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sE9Fyiwa; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Dec 2024 14:14:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734992079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=posGoIiTrb7ucPQNY8cmkzaKpk3ZsGKrSg1es33VyUE=;
	b=sE9FyiwaaqnsmEPf0qT8iRkoFlvIRCJeKcTFrNauOs+yGORf/x0YPsuMGz5uTxuUyyhEW8
	c9oVJdNV3AhZFahbZAefgriZ+Im4NfIp86eXIahN0gTkmufhsesOIJWmBgBLPnwT4LatFk
	XEwOvl4kXc5mpxI+3M0mAn7QqTcH+N4=
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
Message-ID: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
References: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
[...]
> 
> Yes, so I can see fuse
> 
> (1) Breaking memory reclaim (memory cannot get freed up)
> 
> (2) Breaking page migration (memory cannot be migrated)
> 
> Due to (1) we might experience bigger memory pressure in the system I guess.
> A handful of these pages don't really hurt, I have no idea how bad having
> many of these pages can be. But yes, inherently we cannot throw away the
> data as long as it is dirty without causing harm. (maybe we could move it to
> some other cache, like swap/zswap; but that smells like a big and
> complicated project)
> 
> Due to (2) we turn pages that are supposed to be movable possibly for a long
> time unmovable. Even a *single* such page will mean that CMA allocations /
> memory unplug can start failing.
> 
> We have similar situations with page pinning. With things like O_DIRECT, our
> assumption/experience so far is that it will only take a couple of seconds
> max, and retry loops are sufficient to handle it. That's why only long-term
> pinning ("indeterminate", e.g., vfio) migrate these pages out of
> ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
> 
> 
> The biggest concern I have is that timeouts, while likely reasonable it many
> scenarios, might not be desirable even for some sane workloads, and the
> default in all system will be "no timeout", letting the clueless admin of
> each and every system out there that might support fuse to make a decision.
> 
> I might have misunderstood something, in which case I am very sorry, but we
> also don't want CMA allocations to start failing simply because a network
> connection is down for a couple of minutes such that a fuse daemon cannot
> make progress.
> 

I think you have valid concerns but these are not new and not unique to
fuse. Any filesystem with a potential arbitrary stall can have similar
issues. The arbitrary stall can be caused due to network issues or some
faultly local storage.

Regarding the reclaim, I wouldn't say fuse or similar filesystem are
breaking memory reclaim as the kernel has mechanism to throttle the
threads dirtying the file memory to reduce the chance of situations
where most of memory becomes unreclaimable due to being dirty.

Please note that such filesystems are mostly used in environments like
data center or hyperscalar and usually have more advanced mechanisms to
handle and avoid situations like long delays. For such environment
network unavailability is a larger issue than some cma allocation
failure. My point is: let's not assume the disastrous situaion is normal
and overcomplicate the solution.


