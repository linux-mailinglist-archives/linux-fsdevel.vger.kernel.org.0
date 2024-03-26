Return-Path: <linux-fsdevel+bounces-15280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADD88B9F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 06:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103701C2DC46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723212AAC9;
	Tue, 26 Mar 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACd+WhCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDE446BA;
	Tue, 26 Mar 2024 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432184; cv=none; b=c5serInLsy7cm79a9joU1lW3vzkxGf+xLFt2K/GLLEMP/Y0e/38u6w2rZ2l5hGy2qG/Ol6nKciOxlPVxYaBVPvlj/LEjylqHRLU2q3nJtUXEm3iN432QuOtf16Ar1TRiS86bBOzyHkkaZ+hkv80UXlNW4ALZ0p624JPwwAKJ81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432184; c=relaxed/simple;
	bh=p/gg9KAgQm2GHyb3MW5nLJXzf2/0LAbSene85/boffI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3Pn4MxX6KnTZ4uk9HjdbJ2eZocY5zumOCNajiVcX8bVMQ23pV2whXM2sOHfECtlxsSshXv4/C32Wxy6q9NlF0PSiZY+3UkFezBvBfKNbTQuTdtha8CgkrrW5K3BOL2835SIXnkleRkwON8nqzUlXm5YzK+Xfa7yYmJ/OLR2x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACd+WhCt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711432182; x=1742968182;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=p/gg9KAgQm2GHyb3MW5nLJXzf2/0LAbSene85/boffI=;
  b=ACd+WhCtkXRbSWvjB0Zd3qXZx3gPF3VZ9J33xFDmaoiXKqrw7LnfVejC
   jXS33+9pThcM04vLAHFhTDgEwOUqoJdq+Waw56igaBOFQ2hm9rHeaxeBD
   huefjFovKUNEzcW8OFvBSGpPVUGX0XvSI5wvF7yUJgogfotpjEz7n0kW1
   MjT3+UXKFkD/uKWq+rgjeaT2S9vT4x0nG+TGnHAgCI6JnT2BGQvDtazKo
   SgWgddx77UflunHSEWoKBv5F711nQ692VTB2h18XK74fc2+HUHoPWuA9Y
   W7jPBhJnuVKOPYe0vQTBRPoGgDgoQmFnZV27+ipQ54o3anoKHy/EpOWGZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6676534"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6676534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 22:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16243888"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 22:49:39 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org,  david@redhat.com,  hughd@google.com,
  osandov@fb.com,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: swapfile: fix SSD detection with swapfile on btrfs
In-Reply-To: <20240322164956.422815-1-hannes@cmpxchg.org> (Johannes Weiner's
	message of "Fri, 22 Mar 2024 12:42:21 -0400")
References: <20240322164956.422815-1-hannes@cmpxchg.org>
Date: Tue, 26 Mar 2024 13:47:45 +0800
Message-ID: <87plvho872.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Johannes,

Johannes Weiner <hannes@cmpxchg.org> writes:

> +static struct swap_cluster_info *setup_clusters(struct swap_info_struct *p,
> +						unsigned char *swap_map)
> +{
> +	unsigned long nr_clusters = DIV_ROUND_UP(p->max, SWAPFILE_CLUSTER);
> +	unsigned long col = p->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
> +	struct swap_cluster_info *cluster_info;
> +	unsigned long i, j, k, idx;
> +	int cpu, err = -ENOMEM;
> +
> +	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
>  	if (!cluster_info)
> -		return nr_extents;
> +		goto err;
> +
> +	for (i = 0; i < nr_clusters; i++)
> +		spin_lock_init(&cluster_info[i].lock);
>  
> +	p->cluster_next_cpu = alloc_percpu(unsigned int);
> +	if (!p->cluster_next_cpu)
> +		goto err_free;
> +
> +	/* Random start position to help with wear leveling */
> +	for_each_possible_cpu(cpu)
> +		per_cpu(*p->cluster_next_cpu, cpu) =
> +			get_random_u32_inclusive(1, p->highest_bit);
> +
> +	p->percpu_cluster = alloc_percpu(struct percpu_cluster);
> +	if (!p->percpu_cluster)
> +		goto err_free;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct percpu_cluster *cluster;
> +
> +		cluster = per_cpu_ptr(p->percpu_cluster, cpu);
> +		cluster_set_null(&cluster->index);
> +	}
> +
> +	/*
> +	 * Mark unusable pages as unavailable. The clusters aren't
> +	 * marked free yet, so no list operations are involved yet.
> +	 */
> +	for (i = 0; i < round_up(p->max, SWAPFILE_CLUSTER); i++)
> +		if (i >= p->max || swap_map[i] == SWAP_MAP_BAD)
> +			inc_cluster_info_page(p, cluster_info, i);

If p->max is large, it seems better to use an loop like below?

 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
                /* check i and inc_cluster_info_page() */
        }

in most cases, swap_header->info.nr_badpages should be much smaller than
p->max.

> +
> +	cluster_list_init(&p->free_clusters);
> +	cluster_list_init(&p->discard_clusters);
>  
>  	/*
>  	 * Reduce false cache line sharing between cluster_info and
> @@ -2994,7 +3019,13 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>  					      idx);
>  		}
>  	}
> -	return nr_extents;
> +
> +	return cluster_info;
> +
> +err_free:
> +	kvfree(cluster_info);
> +err:
> +	return ERR_PTR(err);
>  }
>  

[snip]

--
Best Regards,
Huang, Ying

