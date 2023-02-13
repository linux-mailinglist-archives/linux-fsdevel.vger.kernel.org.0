Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8825694047
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBMJC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBMJC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D3E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 01:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676278900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXJ41y77DLzQTdnZ8caltqbUlHQTGjYtUH+qH6yTvzI=;
        b=JVIxgVVsnuOUjwPu6XQkSdEdK2ukSvvPDPuJ7XOJNgjzY7DGeNISGLcIeDO8cidyLLyzPf
        9nOqEyQZ19Afj6E7azcfpp6LxSAUG+ueXvsuxCM+mLlY/Jr/BTbfUCpl7RBgbMjC6iG4m/
        UXrzB1bK5ACuk5ZcEc4YF85z03HlJ4c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-flSUfYLRPCuztmaGLEa7Lw-1; Mon, 13 Feb 2023 04:01:38 -0500
X-MC-Unique: flSUfYLRPCuztmaGLEa7Lw-1
Received: by mail-wr1-f71.google.com with SMTP id p6-20020adf9d86000000b002c5400f5c76so1847977wre.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 01:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXJ41y77DLzQTdnZ8caltqbUlHQTGjYtUH+qH6yTvzI=;
        b=aye8RwI+Kl6E+bTWow8uNN2ScSG1tY9Pp1XSnG/XrAHq6DcLJV9VTbbizz9Ogu0lV5
         a9fCSsbQVNnL48gjAE3tt4zTfgh0UKJF560zS9MY+4q3CZ4HsetoKQGFxTjzdfzk4giE
         r+N0pgcV094y64rm2DSKOgWrDO37Ndm80zzx0sFDo2QYdvr5DFTrLeVI3X8AWH1Jrp4c
         wEHcs5KozQZFDpH8Q+HXQz2k/+L6cl9hgy85GioIFCAXsandno27hPRCkLSxSBuYB6Js
         Q5s6G3JERKUBurbmLoJGGwO857YZteoVnLPcaVZKpmDrMeKIyCbWcgTumGe9qSPH0Mfj
         KQRQ==
X-Gm-Message-State: AO0yUKXwOODdVey1sGar7FksnL86GwbwnBC0k8So8L1yNPjoGDVW56aX
        1C53hBgNlHBUAmfGQ8Za340zVhbiXZlnMdwbShjWFyy3tCRzK0ywsqOu1DtPJGi3Od3naapMvvp
        kHKHQT+9LfEVDonF8gsX5fN8bAjxRjOcoSw==
X-Received: by 2002:a5d:4392:0:b0:2c5:5e9a:57fa with SMTP id i18-20020a5d4392000000b002c55e9a57famr742933wrq.24.1676278897264;
        Mon, 13 Feb 2023 01:01:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9VtyM+sAOgTcH0wT4b+Em90/RexKPCJfzXesUugyTxY8knA758KLy3q0oLiK1S+Hc1W5aLFg==
X-Received: by 2002:a5d:4392:0:b0:2c5:5e9a:57fa with SMTP id i18-20020a5d4392000000b002c55e9a57famr742914wrq.24.1676278897013;
        Mon, 13 Feb 2023 01:01:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id s11-20020adfdb0b000000b002c3e1e1dcd7sm10016563wri.104.2023.02.13.01.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:01:36 -0800 (PST)
Message-ID: <df6e150f-9d5c-6f68-f234-3e1ef419f464@redhat.com>
Date:   Mon, 13 Feb 2023 10:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
In-Reply-To: <20230209123206.3548-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.02.23 13:31, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   mm/vmscan.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..ab3911a8b116 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			}
>   		}
>   
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process is that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +
>   		mapping = folio_mapping(folio);
>   		if (folio_test_dirty(folio)) {
>   			/*

At this point, we made sure that the folio is completely unmapped. 
However, we specify "TTU_BATCH_FLUSH", so rmap code might defer a TLB 
flush and consequently defer an IPI sync.

I remember that this check here is fine regarding GUP-fast: even if 
concurrent GUP-fast pins the page after our check here, it should 
observe the changed PTE and unpin it again.


Checking after unmapping makes sense: we reduce the likelyhood of false 
positives when a file-backed page is mapped many times (>= 1024). OTOH, 
we might unmap pinned pages because we cannot really detect it early.

For anon pages, we have an early (racy) check, which turned out "ok" in 
practice, because we don't frequently have that many anon pages that are 
shared by that many processes. I assume we don't want something similar 
for pagecache pages, because having a single page mapped by many 
processes can happen easily and would prevent reclaim.

I once had a patch lying around that documented for the existing 
folio_maybe_dma_pinned() for anon pages exactly that (racy+false 
positives with many mappings).


Long story short, I assume this change is fine.

-- 
Thanks,

David / dhildenb

