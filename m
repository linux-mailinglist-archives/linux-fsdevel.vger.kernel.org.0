Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665E745F0E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378079AbhKZPov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:44:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353766AbhKZPmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:42:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6061FC9E;
        Fri, 26 Nov 2021 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637941176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhyEhqHtTuj99AdPufyfoXzSQOWQVOHXskivTH5sMcI=;
        b=qyIZyaRgWdYi+c71/vcCA3uIzOXt3wQ5+W9eO45pW/dXfMvHqoUXeUVrRrdPKhMvCWL0Oo
        KqQHkWms93mb+LdmcGAv4GZXYp4uBwc5DWG26i0cXfz2Pp158BqOh+wR1IDtGsMCpmKpzI
        CQ9WkHmDyQRuZzDKnURVfuN+3zYOO80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637941176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhyEhqHtTuj99AdPufyfoXzSQOWQVOHXskivTH5sMcI=;
        b=VCI0g9wWkVurTo0/wdcmn+HhlZytA0tm318QA+bVR+1cbaqBeGRU7REudRmR71D9LKM5si
        E7yfzopF4N00y8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0405313C65;
        Fri, 26 Nov 2021 15:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cpCQO7f/oGF4cQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 15:39:35 +0000
Message-ID: <e98a7a8e-3365-c27f-d267-982ddc94f948@suse.cz>
Date:   Fri, 26 Nov 2021 16:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/4] mm/vmalloc: be more explicit about supported gfp
 flags.
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
 <20211122153233.9924-4-mhocko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211122153233.9924-4-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/21 16:32, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> b7d90e7a5ea8 ("mm/vmalloc: be more explicit about supported gfp flags")
> has been merged prematurely without the rest of the series and without
> addressed review feedback from Neil. Fix that up now. Only wording is
> changed slightly.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmalloc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b6aed4f94a85..b1c115ec13be 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3021,12 +3021,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   *
>   * Allocate enough pages to cover @size from the page level
>   * allocator with @gfp_mask flags. Please note that the full set of gfp
> - * flags are not supported. GFP_KERNEL would be a preferred allocation mode
> - * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
> - * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
> - * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
> - * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
> - * __GFP_NOWARN can be used to suppress error messages about failures.
> + * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> + * supported.
> + * Zone modifiers are not supported. From the reclaim modifiers
> + * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> + * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> + * __GFP_RETRY_MAYFAIL are not supported).
> + *
> + * __GFP_NOWARN can be used to suppress failures messages.
>   *
>   * Map them into contiguous kernel virtual space, using a pagetable
>   * protection of @prot.
> 

