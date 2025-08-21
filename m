Return-Path: <linux-fsdevel+bounces-58698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D34B3092E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047341CE5405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07C2E173F;
	Thu, 21 Aug 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5PI+cn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C842E0916
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815148; cv=none; b=HXde5QTx5kKUJF/ub3BJnmsyN4C6nY1+BYhmVhQv2p/ogJ0M/zXpBc0/CvOxSx/kqcDnftXUfrYKULSTKLccdSosuVKRYYTZsl8IY7w6XT7gp6+/Nq5WnOYAEvmIi/Y+ciB1zyTtPSPIOslqcacY3DKXoPyAtacbDzcX2ycf+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815148; c=relaxed/simple;
	bh=ZTnMa5o0Amfk/bGrq/w6uEQq6RJYm2T4rt9xu4U0kLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRtSrCN0DMa/BhVoQ5e3HD6llQmHAcHKuxFLsq4+3et0Bq+qfrcrDh+c0KLOa28FhIVjKbwqdGqXky+AJc6uoyHwb6q6YTqMgLHz8h3HVKgeK8IU6h4pw7j/mAPpwjKbhel0zH/wZpx46M3qfout8S8OGGYbzfowP2CIG8cbFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5PI+cn1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 15:25:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755815133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxGwaneklEuoMgdpuTZgMXLt8KwC3lX/BurqK3SzmgQ=;
	b=A5PI+cn1DU9QLvz2iLs8e7hbKx5Tu80+L3JyEkBLiwMXENfZDbmMKIUR7U3/BcGTymVzpF
	i7IKbkQUN9fZryt8R4lKD+3aA2vUbSthhaFICBXDkNDbwwhL+vJrhudaRREzYcJ5Drv5v7
	UD9So2ZuJwcfvQ+FZ0dcxI5UNWsUOEk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, 
	willy@infradead.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v4 1/3] mm/filemap: add AS_KERNEL_FILE
Message-ID: <kagqatguxrcxsb7ka3vq5xfm2vbjly7ixletkxwbyyq2uisnly@frthso35okfd>
References: <cover.1755812945.git.boris@bur.io>
 <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 02:55:35PM -0700, Boris Burkov wrote:
> Btrfs currently tracks its metadata pages in the page cache, using a
> fake inode (fs_info->btree_inode) with offsets corresponding to where
> the metadata is stored in the filesystem's full logical address space.
> 
> A consequence of this is that when btrfs uses filemap_add_folio(), this
> usage is charged to the cgroup of whichever task happens to be running
> at the time. These folios don't belong to any particular user cgroup, so
> I don't think it makes much sense for them to be charged in that way.
> Some negative consequences as a result:
> - A task can be holding some important btrfs locks, then need to lookup
>   some metadata and go into reclaim, extending the duration it holds
>   that lock for, and unfairly pushing its own reclaim pain onto other
>   cgroups.
> - If that cgroup goes into reclaim, it might reclaim these folios a
>   different non-reclaiming cgroup might need soon. This is naturally
>   offset by LRU reclaim, but still.
> 
> We have two options for how to manage such file pages:
> 1. charge them to the root cgroup.
> 2. don't charge them to any cgroup at all.
> 
> 2. breaks the invariant that every mapped page has a cgroup. This is
> workable, but unnecessarily risky. Therefore, go with 1.
> 
> A very similar proposal to use the root cgroup was previously made by
> Qu, where he eventually proposed the idea of setting it per
> address_space. This makes good sense for the btrfs use case, as the
> behavior should apply to all use of the address_space, not select
> allocations. I.e., if someone adds another filemap_add_folio() call
> using btrfs's btree_inode, we would almost certainly want to account
> that to the root cgroup as well.
> 
> Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

