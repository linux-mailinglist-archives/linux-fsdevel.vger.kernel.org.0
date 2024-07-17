Return-Path: <linux-fsdevel+bounces-23863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3193400F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79D2282110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AA181B99;
	Wed, 17 Jul 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqHERqXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F01E526;
	Wed, 17 Jul 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231734; cv=none; b=EYzOqiOsH6LCPKLmxjV9PMHv5BQsXMVmI+m30aEeArBE9mIa56BFTwn31nKYb5otA7iRz78gqEZh62Z3kctvnueW/EwmxrCmn9N1JTErYwf2I78eseVAUHF9r6eNHL+snubrMkX1S2Krt7k/oSsOlPaM72VWBasfVLRZbmYPyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231734; c=relaxed/simple;
	bh=KGYzxcxkej2/t7nvEAu723VbQGmVlxb+q+JmXx84L0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QoZRGIhsq3RjSXaDFw4urjWWmIiJkktbriRdgwwv2yoK6UCPPUk8qX3Lj2hcoC8z+Ck2OUZAoIw2wCGTejUK7BvLh8XnZMCmI261neqFSyccYkTxT0t+UlMPPMHc5yYPGMrIA/TVX+YFTJ43pHQistiVFMtATj+TeVFVBpetEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqHERqXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDC2C2BD10;
	Wed, 17 Jul 2024 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721231733;
	bh=KGYzxcxkej2/t7nvEAu723VbQGmVlxb+q+JmXx84L0U=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=gqHERqXNb5QWjzvIjmYjQKpI72SZinvWN19JsgmBepXKXLISAv4luEhMgLWW5LOzu
	 gDvg90TjWLgvNeK6sHUB10Em4XlX0H/qJdEu2LGbxak1kO4o1WT53mjTcRXm2s8nOJ
	 fxhOeGINjz6CXFkqcUECzFdUPQvsnSi2xBWyAYc9crIWAX28LmH0hNnLMb62nwG2Nc
	 6ZsXLFrSbd8gBG17weZZ4s7aKWPZdRLiUmrGuorku5bBC2lRxIZfeAFsfsqL/hFLEb
	 Sz9Hfd+mqx3Z7WYnkjjdLwRcniTTIeKJ+5uRF6qfaYmauJBTZj4RhWStuWxxyoY7ok
	 apj2pWy/+le5A==
Message-ID: <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
Date: Wed, 17 Jul 2024 17:55:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1720572937.git.wqu@suse.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>
In-Reply-To: <cover.1720572937.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

you should have Ccd people according to get_maintainers script to get a
reply faster. Let me Cc the MEMCG section.

On 7/10/24 3:07 AM, Qu Wenruo wrote:
> Recently I'm hitting soft lockup if adding an order 2 folio to a
> filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
> charge code, and I guess that's exactly what __GFP_NOFAIL is expected to
> do, wait indefinitely until the request can be met.

Seems like a bug to me, as the charging of __GFP_NOFAIL in
try_charge_memcg() should proceed to the force: part AFAICS and just go over
the limit.

I was suspecting mem_cgroup_oom() a bit earlier return true, causing the
retry loop, due to GFP_NOFS. But it seems out_of_memory() should be
specifically proceeding for GFP_NOFS if it's memcg oom. But I might be
missing something else. Anyway we should know what exactly is going first.

> On the other hand, if we do not use __GFP_NOFAIL, we can be limited by
> memcg at a lot of critical location, and lead to unnecessary transaction
> abort just due to memcg limit.
> 
> However for that specific btrfs call site, there is really no need charge
> the memcg, as that address space belongs to btree inode, which is not
> accessible to any end user, and that btree inode is a shared pool for
> all metadata of a btrfs.
> 
> So this patchset introduces a new address space flag, AS_NO_MEMCG, so
> that folios added to that address space will not trigger any memcg
> charge.
> 
> This would be the basis for future btrfs changes, like removing
> __GFP_NOFAIL completely and larger metadata folios.
> 
> Qu Wenruo (2):
>   mm: make lru_gen_eviction() to handle folios without memcg info
>   mm: allow certain address space to be not accounted by memcg
> 
>  fs/btrfs/disk-io.c      |  1 +
>  include/linux/pagemap.h |  1 +
>  mm/filemap.c            | 12 +++++++++---
>  mm/workingset.c         |  2 +-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> 


