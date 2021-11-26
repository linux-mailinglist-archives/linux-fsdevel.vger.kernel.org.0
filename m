Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716DE45F074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbhKZPSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:18:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54416 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349756AbhKZPQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:16:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29E2C1FD37;
        Fri, 26 Nov 2021 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637939613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJOhYnFu/ijkoWQOT2VWDCkLUQNOUwrPYFHaaC4YjWY=;
        b=HHSU1HT7X9C90Xzb9P7/jxGsY6mIMnZdke3/iAFWp9kJ/P1aFgIBivMe8iyYRWBPfenirK
        uCnXuzO34JjfKWGnlv3sD09Ghmybbp1tULxKDHWJYfgW+ExxK5JDJ+/tGgDh0fv+VZQd2t
        YroNbfonwGMJd6bVnxv7OWtz9MKliKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637939613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJOhYnFu/ijkoWQOT2VWDCkLUQNOUwrPYFHaaC4YjWY=;
        b=voHB17S1KLtEg5ZcmQgYw0WnKhqNNqFK2iR+mKLUAxny+ghvcE1ainaSnrdtYiMElMnM8a
        sbp+1g4znMEADnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E839313C5C;
        Fri, 26 Nov 2021 15:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fiz4N5z5oGFGZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 15:13:32 +0000
Message-ID: <78775967-03dc-8d0a-a994-e07ce673b765@suse.cz>
Date:   Fri, 26 Nov 2021 16:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/4] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
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
 <20211122153233.9924-2-mhocko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211122153233.9924-2-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/21 16:32, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> vmalloc historically hasn't supported GFP_NO{FS,IO} requests because
> page table allocations do not support externally provided gfp mask
> and performed GFP_KERNEL like allocations.
> 
> Since few years we have scope (memalloc_no{fs,io}_{save,restore}) APIs
> to enforce NOFS and NOIO constrains implicitly to all allocators within
> the scope. There was a hope that those scopes would be defined on a
> higher level when the reclaim recursion boundary starts/stops (e.g. when
> a lock required during the memory reclaim is required etc.). It seems
> that not all NOFS/NOIO users have adopted this approach and instead
> they have taken a workaround approach to wrap a single [k]vmalloc
> allocation by a scope API.
> 
> These workarounds do not serve the purpose of a better reclaim recursion
> documentation and reduction of explicit GFP_NO{FS,IO} usege so let's
> just provide them with the semantic they are asking for without a need
> for workarounds.
> 
> Add support for GFP_NOFS and GFP_NOIO to vmalloc directly. All internal
> allocations already comply with the given gfp_mask. The only current
> exception is vmap_pages_range which maps kernel page tables. Infer the
> proper scope API based on the given gfp mask.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmalloc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..17ca7001de1f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2926,6 +2926,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned long array_size;
>  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>  	unsigned int page_order;
> +	unsigned int flags;
> +	int ret;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
>  	gfp_mask |= __GFP_NOWARN;
> @@ -2967,8 +2969,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		goto fail;
>  	}
>  
> -	if (vmap_pages_range(addr, addr + size, prot, area->pages,
> -			page_shift) < 0) {
> +	/*
> +	 * page tables allocations ignore external gfp mask, enforce it
> +	 * by the scope API
> +	 */
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +		flags = memalloc_nofs_save();
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +		flags = memalloc_noio_save();
> +
> +	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> +			page_shift);
> +
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +		memalloc_nofs_restore(flags);
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +		memalloc_noio_restore(flags);
> +
> +	if (ret < 0) {
>  		warn_alloc(orig_gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to map pages",
>  			area->nr_pages * PAGE_SIZE);
> 

