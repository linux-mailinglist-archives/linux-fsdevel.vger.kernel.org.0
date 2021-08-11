Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421773E8F16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhHKKyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:54:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53296 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHKKya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:54:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08B25221AB;
        Wed, 11 Aug 2021 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628679246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hv1T/hKNTE5d+nxwafHGQund8yaFQUJNQ0XZ3C5Zyew=;
        b=iQOx39CqLJK+SgrFRASjmJYMXVBiEfDNNCMKiUUDReNTOCEmAwg+IaLD/VZIp4aNOAbESv
        /5u0JPXXtkcM/vsgTcpzCwgtquzkcaLEE9pzamA8x82GTiDndne+ODLpBf9W3B9cz8f1t7
        i7fWuilC//2Qj9CeUQKpoiHJ8b2yXgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628679246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hv1T/hKNTE5d+nxwafHGQund8yaFQUJNQ0XZ3C5Zyew=;
        b=LKWKi2se9J/Klv+89EjxNlk7E2kGuS/TtKPdzHERlei0VBO4cNqB7Wi+l8rDIg9uIk2Cj8
        HXSmQQr10iPPMECA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DA314131F5;
        Wed, 11 Aug 2021 10:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gddsNE2sE2HjFQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:54:05 +0000
Subject: Re: [PATCH v14 040/138] mm/memcg: Convert mem_cgroup_charge() to take
 a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-41-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <40a868bf-61dc-1832-4799-ff85018ebcec@suse.cz>
Date:   Wed, 11 Aug 2021 12:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-41-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert all callers of mem_cgroup_charge() to call page_folio() on the
> page they're currently passing in.  Many of them will be converted to
> use folios themselves soon.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Acked-by: Vlastimil Babka <vbabka@suse.cz>


> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c2ffad021e09..03283d97b62a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6681,10 +6681,9 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  			atomic_long_read(&parent->memory.children_low_usage)));
>  }
>  
> -static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> +static int __mem_cgroup_charge(struct folio *folio, struct mem_cgroup *memcg,
>  			       gfp_t gfp)

The git/next version also renames this function to charge_memcg(), why? The new
name doesn't look that internal as the old one. I don't have a strong opinion
but CCing memcg maintainers who might.

>  {
> -	struct folio *folio = page_folio(page);
>  	unsigned int nr_pages = folio_nr_pages(folio);
>  	int ret;
>  
> @@ -6697,27 +6696,27 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, page_to_nid(page));
> +	memcg_check_events(memcg, folio_nid(folio));
>  	local_irq_enable();
>  out:
>  	return ret;
>  }
>  
