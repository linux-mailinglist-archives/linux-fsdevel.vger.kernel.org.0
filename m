Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CDB45F0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbhKZPho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:37:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44450 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354667AbhKZPfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:35:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEE362191A;
        Fri, 26 Nov 2021 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637940746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OPGGG/iKy2NLyQ5ovfbpVS9DeN3FCw/U9mCaWyfW0Y=;
        b=awh5HL8S8Ggxp5+RF2rsxFt+zZepTctjNHS7/tsWg+xjm9qpg3VAcaPxkfT8v3zQ1d/LGn
        Jw/ByaZJ+0mB0/zCPT5CstBZtcwhXKaMTbpYMXcswlc/prbA08ix3sqnjc+crHYXvUlHzD
        yIBHOQu6TLnkT/vObhVpF0hFV8bUHL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637940746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OPGGG/iKy2NLyQ5ovfbpVS9DeN3FCw/U9mCaWyfW0Y=;
        b=ADwz39vvqUlJq5Ls4//kyWbe1lO+hcj+6R+kSIAxk3CrEHCUPrH1jhrDHqOOPQLMKP7Mal
        StfEUYeBIBfaQEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACDA513C65;
        Fri, 26 Nov 2021 15:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6nlfKQr+oGHfbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 15:32:26 +0000
Message-ID: <a71a3135-b7ee-bb28-4ccc-ccab9a055b9b@suse.cz>
Date:   Fri, 26 Nov 2021 16:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211122153233.9924-3-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/21 16:32, Michal Hocko wrote:
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

Kind of ugly to have the same condition twice here, but no hard feelings.

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
> 

