Return-Path: <linux-fsdevel+bounces-43754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B551A5D515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183AB189C014
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 04:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832E1DB356;
	Wed, 12 Mar 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XEwUyIMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03B4431;
	Wed, 12 Mar 2025 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741753270; cv=none; b=XAwUHktlrYAv4/6CAM8gh7vOdPI01MNvR5tZmKsqHc6onxLXpzVNVSR6L3bTS/XsXG4VU5QGHBikQjxAkPKBVQqYKtAKnW96U8rBlffpyMyQnado4rx+Qhw8vvZIgtoi0VwJFt7XTgy9pmc8BVmzKIRGLXRNs9AoUYcXY2LIE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741753270; c=relaxed/simple;
	bh=EJpdB3K7Aqx8sUGEayv5OStg/0y5kyWQ/JNPv5NMGMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1GFYf1457pRT+E642w8hIJBrnhsimB9sBAgFAbw+IFSxS8TX0yIYQM5dX2Wk8fkfCwJqxOgpArFJsNlyd42qgBOtIqvcLxGSwJOvJmtnwgNeVTBJp7CIktYtN8JqkTAFr7zpBxlh2ijEWA6IUlmH9krnBpZrwqdpyH9mYsHOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XEwUyIMD; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 21:20:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741753256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDVW5paXvofauniZLpqYiGX3ZDGr6k7FCnVsxIQYmDI=;
	b=XEwUyIMDWawoG5pdblTStI90HquR/rc4o2V0eGwG0KkonQod7nUPqLyItShqetqdquXcQh
	/yNdl28wY6m6OKfmu15G0wheicZLL/xdftO1L8QhhRgbxANOz3ePyhU5QqTYAF2M9I/7F7
	NOKfvHIcb5lldr/IXRtr3hANfUg4T5w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	jerrin.shaji-george@broadcom.com, bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, david@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, sstabellini@kernel.org, 
	oleksandr_tyshchenko@epam.com, akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev, 
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Message-ID: <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-2-npache@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 06:06:56PM -0600, Nico Pache wrote:
> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> expose it through /proc/meminfo and other memory reporting interfaces.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  fs/proc/meminfo.c      | 2 ++
>  include/linux/mmzone.h | 1 +
>  mm/memcontrol.c        | 1 +
>  mm/show_mem.c          | 4 +++-
>  mm/vmstat.c            | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 8ba9b1472390..83be312159c9 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "Unaccepted:     ",
>  		    global_zone_page_state(NR_UNACCEPTED));
>  #endif
> +	show_val_kb(m, "Balloon:        ",
> +		    global_node_page_state(NR_BALLOON_PAGES));
>  
>  	hugetlb_report_meminfo(m);
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9540b41894da..71d3ff19267a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -223,6 +223,7 @@ enum node_stat_item {
>  #ifdef CONFIG_HUGETLB_PAGE
>  	NR_HUGETLB,
>  #endif
> +	NR_BALLOON_PAGES,
>  	NR_VM_NODE_STAT_ITEMS
>  };
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4de6acb9b8ec..182b44646bfa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1377,6 +1377,7 @@ static const struct memory_stat memory_stats[] = {
>  #ifdef CONFIG_HUGETLB_PAGE
>  	{ "hugetlb",			NR_HUGETLB			},
>  #endif
> +	{ "nr_balloon_pages",		NR_BALLOON_PAGES		},

Please remove the above counter from memcontrol.c as I don't think this
memory is accounted towards memcg.

