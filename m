Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707C45ABF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 20:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhKWTFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhKWTFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:05:05 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E829C061574;
        Tue, 23 Nov 2021 11:01:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l7so209543lja.2;
        Tue, 23 Nov 2021 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RCD0mCHgUsXd21gJ9lQMsMrznp+ePQnNJ26N5gX32mE=;
        b=pcfaLKAcHsgfCZGfRmBPjX9bmQtTyuJvuD5fmVdiK10Rb2+0ZmhPl+3Hs91JS1CcqK
         NCQSrj6bgi95VwCP0jPyA/9V2PRRBJzje1Uf4kMG9df2FAcgeLLo0ySJSvST5SPHDxTH
         neSZ14ZinZDnHz6eZmiIHcEruuDBUnTqGgU4ScVTqZwMLUgKJkgwtHaau2t+724He8W8
         8H6ysaxwifWy/TchX8caUkoIzXsxErTU7kPYpRj29She8qEuWgIknqbmOYLlvSZtgM1Z
         QVOvTex8b3dBa87Af1z+9B83TEagQFdjl+CZstCBSrMUJQoLcR1guBdDipHzgzSHb5iw
         06/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCD0mCHgUsXd21gJ9lQMsMrznp+ePQnNJ26N5gX32mE=;
        b=VTdp2h7757WGlNF408eZyv6mxIY/p7Ip+EMXqqNxKxY/HOM2BjG5oiYJr/CTJcbTfL
         jfWzwm55H/3CkEhqGar/s/NaMdyOSoKNny8rZydqzRhZqQCxmoxu9HlzEKOyNFJP2Jrt
         YF09HcOpsv38rpuPngGxV1xnLhyox4r+MCsM7XhehZ0JC09G/kxSqswpbTiIQCIWJS/i
         tbXqBSkWISUFHQGVmG02u55JqT433W4TKssGhaj45jiaJwz5O6uuGRlOJGUn60YJGvEk
         Qau0+WAqer+3lRccRCYm8P/mds5ymMKeoh3EacUqovrjbakrqDHT5jCHBU3qtl8eT+PH
         /3iA==
X-Gm-Message-State: AOAM530SnhGq6mkselgwHZ5+OvBFs9QUNAHcr8rnbjnDWgOlafOXJDTI
        MwL45y81f4eaniKbzqvy6z8=
X-Google-Smtp-Source: ABdhPJxbGKZF0vJWLBMeD4nYcA36cstWxSQ6/K7ov4ip4XOIk78N9rr1uC0a/DRznRTxz8yGPobrJQ==
X-Received: by 2002:a2e:a451:: with SMTP id v17mr8019011ljn.85.1637694114023;
        Tue, 23 Nov 2021 11:01:54 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id s15sm1376039ljj.14.2021.11.23.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:01:53 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Nov 2021 20:01:50 +0100
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ06nna7RirAI+vJ@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122153233.9924-3-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Dave Chinner has mentioned that some of the xfs code would benefit from
> kvmalloc support for __GFP_NOFAIL because they have allocations that
> cannot fail and they do not fit into a single page.
> 
> The large part of the vmalloc implementation already complies with the
> given gfp flags so there is no work for those to be done. The area
> and page table allocations are an exception to that. Implement a retry
> loop for those.
> 
> Add a short sleep before retrying. 1 jiffy is a completely random
> timeout. Ideally the retry would wait for an explicit event - e.g.
> a change to the vmalloc space change if the failure was caused by
> the space fragmentation or depletion. But there are multiple different
> reasons to retry and this could become much more complex. Keep the retry
> simple for now and just sleep to prevent from hogging CPUs.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 17ca7001de1f..b6aed4f94a85 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2844,6 +2844,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * more permissive.
>  	 */
>  	if (!order) {
> +		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> +
>  		while (nr_allocated < nr_pages) {
>  			unsigned int nr, nr_pages_request;
>  
> @@ -2861,12 +2863,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 * but mempolcy want to alloc memory by interleaving.
>  			 */
>  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> -				nr = alloc_pages_bulk_array_mempolicy(gfp,
> +				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
>  			else
> -				nr = alloc_pages_bulk_array_node(gfp, nid,
> +				nr = alloc_pages_bulk_array_node(bulk_gfp, nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
> @@ -2921,6 +2923,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  {
>  	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>  	const gfp_t orig_gfp_mask = gfp_mask;
> +	bool nofail = gfp_mask & __GFP_NOFAIL;
>  	unsigned long addr = (unsigned long)area->addr;
>  	unsigned long size = get_vm_area_size(area);
>  	unsigned long array_size;
> @@ -2978,8 +2981,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		flags = memalloc_noio_save();
>  
> -	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> +	do {
> +		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
>  			page_shift);
> +		if (nofail && (ret < 0))
> +			schedule_timeout_uninterruptible(1);
> +	} while (nofail && (ret < 0));
>  
>  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		memalloc_nofs_restore(flags);
> @@ -3074,9 +3081,14 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  				  VM_UNINITIALIZED | vm_flags, start, end, node,
>  				  gfp_mask, caller);
>  	if (!area) {
> +		bool nofail = gfp_mask & __GFP_NOFAIL;
>  		warn_alloc(gfp_mask, NULL,
> -			"vmalloc error: size %lu, vm_struct allocation failed",
> -			real_size);
> +			"vmalloc error: size %lu, vm_struct allocation failed%s",
> +			real_size, (nofail) ? ". Retrying." : "");
> +		if (nofail) {
> +			schedule_timeout_uninterruptible(1);
> +			goto again;
> +		}
>  		goto fail;
>  	}
>  
> -- 
> 2.30.2
> 
I have raised two concerns in our previous discussion about this change,
well that is sad...

--
Vlad Rezki
