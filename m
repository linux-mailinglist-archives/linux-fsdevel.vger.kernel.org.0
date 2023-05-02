Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB56F464C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjEBOp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBOp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 10:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB310E6
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683038709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmfp1uOHfPwbBl+JqKPBUsZRmSRNfYpuSbCFI1y1Krs=;
        b=LPNTL8z49Yo0GbfSuboRw9ymfY6mpYmjRpOs97JuzKsG1RyVXfsD7L9ydQ2iHX/TkGrnIt
        lWYxaPFeaKFDkPRBCtKVZcvIzl32UfuvS30jBBO6VBqF+vbo7P2BIGEPC+8rJgHm4IgJAH
        L+cD0FzU9KGiElAZ7IwX6/1Y3ybYaNU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145--wpejwZDNBKOfdZiTnoVJg-1; Tue, 02 May 2023 10:45:07 -0400
X-MC-Unique: -wpejwZDNBKOfdZiTnoVJg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f479aeddc4so2446423f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 07:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683038706; x=1685630706;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmfp1uOHfPwbBl+JqKPBUsZRmSRNfYpuSbCFI1y1Krs=;
        b=kuNLZXAwTh2Gxrb5Uoofi/5I462dxtlMcs0xmO1nawJZMkhnMn/fSkWFczl74XewI7
         mto80F+Ne4PIbLGEU8CWXem5IdpMwkbop2tU/PfOTK+j1NgwXI4KcHF5+uPc5QVVxmnu
         OnpyXPcZuPgYozk4ppI3UbTee7YzaUNV/8U19XOZnO9iT6xyVx4UC5WflABaAV1rpli8
         WA86INda6IZZ6iGSJWpjNVdi7mqdoXuNWKOmAd0TE1JD8Zodad3AH5PBk/M2v3F5h7sV
         0f83t3KDJzYv6m+JGmbkQOdHMLaQzB7sU5PzFAUFElUqK98IW/ogWjAfmJey+mrfOXdj
         Wthw==
X-Gm-Message-State: AC+VfDxqyvnPuKXurhl5Rh+aSjja1UiSRjc18UPVbXSGhkVMdOSbe0j/
        ub0MfXjptIzDsPjbm6gDJKlaEfi5kiEjMwx7MqPuu+bO9hCtLgMiJg2egRPlzKYP6ikzYcfk6Iy
        FiJCeJTDArMgqDPc/FA7O+TsWKT+wThmqOQ==
X-Received: by 2002:a5d:4d0b:0:b0:306:2aac:4b84 with SMTP id z11-20020a5d4d0b000000b003062aac4b84mr5558784wrt.30.1683038706082;
        Tue, 02 May 2023 07:45:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FmPSYsICeYdI3SjPAAR5svhA8LjCk8FRH773XKQRr/KAQPQa/z4ZMR1Bpqbf598bBVgLHNA==
X-Received: by 2002:a5d:4d0b:0:b0:306:2aac:4b84 with SMTP id z11-20020a5d4d0b000000b003062aac4b84mr5558761wrt.30.1683038705749;
        Tue, 02 May 2023 07:45:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4410000000b002fb0c5a0458sm31160407wrq.91.2023.05.02.07.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 07:45:05 -0700 (PDT)
Message-ID: <2bca2e69-6108-5595-3f5e-fbac3a93bab5@redhat.com>
Date:   Tue, 2 May 2023 16:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20230428124140.30166-1-jack@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.04.23 14:41, Jan Kara wrote:
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
> This was the non-controversial part of my series [1] dealing with pinned pages
> in filesystems. It is already a win as it avoids crashes in the filesystem and
> we can drop workarounds for this in ext4. Can we merge it please?
> 
> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..401a379ea99a 100644
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
> +		 * pinning process as that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +
>   		mapping = folio_mapping(folio);
>   		if (folio_test_dirty(folio)) {
>   			/*

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

