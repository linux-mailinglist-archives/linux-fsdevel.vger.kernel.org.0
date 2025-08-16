Return-Path: <linux-fsdevel+bounces-58066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3FB28965
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31E51CE34FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 00:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C725776;
	Sat, 16 Aug 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scrT/Tl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9CBA4A
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305367; cv=none; b=Kp94ey2r+aOQlXBiEpYbIKPTBJVZkqYEmBEQrkzwQPRVLk9nmLzb7adtGknNucGKqCb1Q2RiXqhEZOpFd7PTw4CDr8zu1BB5GMSTksI+bKNRG7TxPwNjQzOm4redX62l4pXU5ES+bXx+QWakX+UhCXnixVGO25cYy3jFFPIXhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305367; c=relaxed/simple;
	bh=EkL1vGc0AYdOmL9ZD6zyO7LLWvOmMC1sxDETv8jAyGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSLNUkevOQiHF7vu2YiqRJs2+5G6QP/oYJDHL7UGjdzyHkq56R1n60kjvDXNvkDORQZSIOa0s7T2q8bfj2eNSfaPtOGCJhjRzevzTV9FkSNBcebnlalmHu5mA2MvWATr0mpPPA7+fQMLcVby8yHfZoI36Xfp+ySOeRw8My3zqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scrT/Tl6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 17:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755305353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12vBt6pvl2+GG2p3H0QKahJtZuQMrZF6zbce7Pu/ysk=;
	b=scrT/Tl6kq2/8qsHIu672v4EAg2jieacJyrIn2ZS7JZ/+DIn8+Fzc+R/iCY+CPNT2AaLhP
	8pySf8eWL+30PYXncarpQDaboAq4PG8bxHcibDP2qk2tC3qegkFd2iMq+VDXvu0G+RpSbj
	MImgIvi4ut8bHDyFCHpLUG5MVYH3ugk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, willy@infradead.org
Subject: Re: [PATCH v2 2/3] mm: add vmstat for cgroup uncharged pages
Message-ID: <ztt2lhdpzfb3ddvgtqqwzuvdmlz4i5l6ijnwizyky4tv62dncz@taho2tjmqjkc>
References: <cover.1755300815.git.boris@bur.io>
 <a0b3856a4f86bcd684c715469c8a1cb2000bcbe2.1755300815.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b3856a4f86bcd684c715469c8a1cb2000bcbe2.1755300815.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 04:40:32PM -0700, Boris Burkov wrote:
> Uncharged pages are tricky to track by their essential "uncharged"
> nature. To maintain good accounting, introduce a vmstat counter tracking
> all uncharged pages. Since this is only meaningful when cgroups are
> configured, only expose the counter when CONFIG_MEMCG is set.
> 
> Confirmed that these work as expected at a high level by mounting a
> btrfs using AS_UNCHARGED for metadata pages, and seeing the counter rise
> with fs usage then go back to a minimal level after drop_caches and
> finally down to 0 after unmounting the fs.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  include/linux/mmzone.h |  3 +++
>  mm/filemap.c           | 17 +++++++++++++++++
>  mm/vmstat.c            |  3 +++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0c5da9141983..f6d885c97e99 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -245,6 +245,9 @@ enum node_stat_item {
>  	NR_HUGETLB,
>  #endif
>  	NR_BALLOON_PAGES,
> +#ifdef CONFIG_MEMCG
> +	NR_UNCHARGED_FILE_PAGES,
> +#endif
>  	NR_VM_NODE_STAT_ITEMS
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6046e7f27709..cd5af44a838c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -146,6 +146,19 @@ static void page_cache_delete(struct address_space *mapping,
>  	mapping->nrpages -= nr;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
> +{
> +	long nr = folio_nr_pages(folio) * sign;
> +
> +	lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);

Since we expect to add this metric to memory.stat, I think we should use
mod_node_page_state() instead here.

With that you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


