Return-Path: <linux-fsdevel+bounces-23897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE039348A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FBDB21684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD587580D;
	Thu, 18 Jul 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nES1GApa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E819E;
	Thu, 18 Jul 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287068; cv=none; b=F8F2TS31ho7OqQclFQ+PxEuB+RLVRNi+fjWkvma2jnETOX+FZ81jn4cPvvBP+V7+0jk0vjOWjFlIiH0/0lgt8PxJrcXYotRvi1vFtM+mj+t0tpb1kZsdSdEFleYwFm8JL/aTEUGjhPo71iXFjmcd7adKI9c5y4EGN+hTr40rqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287068; c=relaxed/simple;
	bh=6geIF7vYh23EULIWqeZnsJ4uWp50DaQE9puxPgPkEPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igRabNQbF7hV+gH6wCu5MVczMLivKHduaUlasNradXdSPC6v7+6+ydx+et+Vt7dx3tb9vLjdAH99Wy7+Ed08k1eamH4pQpCn1hpLtRDPCpHcRlJFOPdiVo/XbzndWtHKsSL1p4kRJClGPaX+hj7WhnRnAK4JC6FZ0k5TNMcpzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nES1GApa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1211CC116B1;
	Thu, 18 Jul 2024 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721287067;
	bh=6geIF7vYh23EULIWqeZnsJ4uWp50DaQE9puxPgPkEPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nES1GApabH95lkwjPEerwfUV3d3HaWGeswuGNZvyXJaxVH+NDrSiEbHzElzDI/4/d
	 OZV2a4VOE6KG0p/LyojZ8XoIMwDqTRwSdQluY6axPMDs97aN9c37U97HFJiiuJvyR3
	 /GVKsoI1iJwjwO2xMOUBtF6AWodp4iyX6k6QSE66GTDKzg+crb9kt58cknByoeKkrn
	 LMFa0ZuKrUZIGOXNef3kt07LKZCwlg8MebpXNGkDS9HP/w2s0Ym6Ng3675jBPWSOvm
	 Wsy5kvel9o6w0HtxAyZoRE7Bo9dbtw3vEykC09U4DY95haJ6MbyKtUfSfFBdVrCm2A
	 WGYhicI76sgxQ==
Message-ID: <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
Date: Thu, 18 Jul 2024 09:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Michal Hocko <mhocko@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/24 12:38 AM, Qu Wenruo wrote:
> 在 2024/7/18 01:44, Michal Hocko 写道:
>> On Wed 17-07-24 17:55:23, Vlastimil Babka (SUSE) wrote:
>>> Hi,
>>>
>>> you should have Ccd people according to get_maintainers script to get a
>>> reply faster. Let me Cc the MEMCG section.
>>>
>>> On 7/10/24 3:07 AM, Qu Wenruo wrote:
>>>> Recently I'm hitting soft lockup if adding an order 2 folio to a
>>>> filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
>>>> charge code, and I guess that's exactly what __GFP_NOFAIL is expected to
>>>> do, wait indefinitely until the request can be met.
>>>
>>> Seems like a bug to me, as the charging of __GFP_NOFAIL in
>>> try_charge_memcg() should proceed to the force: part AFAICS and just go over
>>> the limit.
>>>
>>> I was suspecting mem_cgroup_oom() a bit earlier return true, causing the
>>> retry loop, due to GFP_NOFS. But it seems out_of_memory() should be
>>> specifically proceeding for GFP_NOFS if it's memcg oom. But I might be
>>> missing something else. Anyway we should know what exactly is going first.
>>
>> Correct. memcg oom code will invoke the memcg OOM killer for NOFS
>> requests. See out_of_memory
>>
>>          /*
>>           * The OOM killer does not compensate for IO-less reclaim.
>>           * But mem_cgroup_oom() has to invoke the OOM killer even
>>           * if it is a GFP_NOFS allocation.
>>           */
>>          if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
>>                  return true;
>>
>> That means that there will be a victim killed, charges reclaimed and
>> forward progress made. If there is no victim then the charging path will
>> bail out and overcharge.
>>
>> Also the reclaim should have cond_rescheds in the reclaim path. If that
>> is not sufficient it should be fixed rather than workaround.
> 
> Another question is, I only see this hang with larger folio (order 2 vs
> the old order 0) when adding to the same address space.
> 
> Does the folio order has anything related to the problem or just a
> higher order makes it more possible?

I didn't spot anything in the memcg charge path that would depend on the
order directly, hm. Also what kernel version was showing these soft lockups?

> And finally, even without the hang problem, does it make any sense to
> skip all the possible memcg charge completely, either to reduce latency
> or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?

Is it common to even use the filemap code for such metadata that can't be
really mapped to userspace? How does it even interact with reclaim, do they
become part of the page cache and are scanned by reclaim together with data
that is mapped? How are the lru decisions handled if there are no references
for PTE access bits. Or can they be even reclaimed, or because there may
e.g. other open inodes pinning this metadata, the reclaim is impossible?

(sorry if the questions seem noob, I'm not that much familiar with the page
cache side of mm)

> Thanks,
> Qu


