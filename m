Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149996F474B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEBPeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEBPeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0568CC
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683041606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dT+K03eQi7c1x2xfzzp4iUSB6JFNwkIzH/kA6EXfQGY=;
        b=fbAB6pi0Ept0gTMaTq5C91YUjrd00Lk1FC331Zydf1Q9GlbUFSd/hiqS178ne3WWNzks1W
        8XFlG8/Bx71m2ZX1GkRG2n/hDFGnYM3RodFT4w+peGoZboy2q2+h8EtYt7NaxWATouOKDh
        yz42goTQrDm2sSAv0WpKTZvXw0jilOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-rLwvIA4pMR6edr99REgXgg-1; Tue, 02 May 2023 11:33:25 -0400
X-MC-Unique: rLwvIA4pMR6edr99REgXgg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30479b764f9so1085795f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 08:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041604; x=1685633604;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT+K03eQi7c1x2xfzzp4iUSB6JFNwkIzH/kA6EXfQGY=;
        b=hJh+jko73cUxkx7pSOBtTpl0FpesJWSmgxgT6Uw4uZRvON1krxnkIuQe/OuJTuNFrv
         /jLZEmnCYWAUUYrcMCtmgHo7lh2A+irRZEDVUgA/Y1JwcWGWMQDJo8swArsxpr/FZZgA
         f1p2hfFhIpvFhgFrumbGYND1119V5wVvavTTCdYWwngm0Jk1HYqu6QzR92mWNesqzg5H
         e61pd77+l5DneLz8s2urn7/A4cwt8tU/PEzZbSEpCT0hJI7D+FzaZWScCMH1/6j3uNDH
         60kwoA/+XVTbdSd6Ave+pJ3hcTwq3h9UuTGb2NQapzL2v5IDcpFKZMxXVFTB5VFUcdsW
         fylg==
X-Gm-Message-State: AC+VfDxQsGUy3KVBnKArrYL8BqkXlh9/UH59s4ykI+TZPmo3wJ49irml
        PnBEvtWAptApQqYu6IvtBAC7j5KWTSZsREEgr7PZU3r92x/nV3JEY/PAQt8CE200i6antl7OI8l
        QhS6YEEKTNYdu5nmDl2I9aXgolQ==
X-Received: by 2002:adf:e103:0:b0:2f7:8779:3bc3 with SMTP id t3-20020adfe103000000b002f787793bc3mr11950264wrz.11.1683041604578;
        Tue, 02 May 2023 08:33:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZgmzreRBKwZlbSPmgVLMe5+ajvHiiEV9HEnvP2dAIKDMaIrIKrq4iutGEBtifgyOuAtjWCg==
X-Received: by 2002:adf:e103:0:b0:2f7:8779:3bc3 with SMTP id t3-20020adfe103000000b002f787793bc3mr11950253wrz.11.1683041604224;
        Tue, 02 May 2023 08:33:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003f188f608b9sm36875696wmq.8.2023.05.02.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:33:23 -0700 (PDT)
Message-ID: <8dba1912-4120-cb3d-6e10-5fc18459e2ac@redhat.com>
Date:   Tue, 2 May 2023 17:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20230428124140.30166-1-jack@suse.cz> <ZFErn2Hl3mWiIudD@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
In-Reply-To: <ZFErn2Hl3mWiIudD@x1n>
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

On 02.05.23 17:26, Peter Xu wrote:
> On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
>> If the page is pinned, there's no point in trying to reclaim it.
>> Furthermore if the page is from the page cache we don't want to reclaim
>> fs-private data from the page because the pinning process may be writing
>> to the page at any time and reclaiming fs private info on a dirty page
>> can upset the filesystem (see link below).
>>
>> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>   mm/vmscan.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> This was the non-controversial part of my series [1] dealing with pinned pages
>> in filesystems. It is already a win as it avoids crashes in the filesystem and
>> we can drop workarounds for this in ext4. Can we merge it please?
>>
>> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index bf3eedf0209c..401a379ea99a 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   			}
>>   		}
>>   
>> +		/*
>> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
>> +		 * No point in trying to reclaim folio if it is pinned.
>> +		 * Furthermore we don't want to reclaim underlying fs metadata
>> +		 * if the folio is pinned and thus potentially modified by the
>> +		 * pinning process as that may upset the filesystem.
>> +		 */
>> +		if (folio_maybe_dma_pinned(folio))
>> +			goto activate_locked;
>> +
>>   		mapping = folio_mapping(folio);
>>   		if (folio_test_dirty(folio)) {
>>   			/*
>> -- 
>> 2.35.3
>>
>>
> 
> IIUC we have similar handling for anon (feb889fb40fafc).  Should we merge
> the two sites and just move the check earlier?  Thanks,
> 

feb889fb40fafc introduced a best-effort check that is racy, as the page 
is still mapped (can still get pinned). Further, we get false positives 
most only if a page is shared very often (1024 times), which happens 
rarely with anon pages. Now that we handle COW+pinning correctly using 
PageAnonExclusive, that check only optimizes for the "already pinned" 
case. But it's not required for correctness anymore (so it can be racy).

Here, however, we want more precision, and not false positives simply 
because a page is mapped many times (which can happen easily) or can 
still get pinned while mapped.
-- 
Thanks,

David / dhildenb

