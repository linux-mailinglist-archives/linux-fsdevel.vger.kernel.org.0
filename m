Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81B76A124
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGaTXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGaTXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A21BCF
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690831351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XHpXZQfPdcBCB40xD4cQo5HE4yndD5B/+tRyE4teEw=;
        b=VQAdpjcAeN6YItaZAm5NoKnli4N0JB5kcuBz2IoiPSgZMfTyRC5UGRMsfMbwWOTCAf6cyM
        8KRWfa3VpYcar5nlCIwpXKhLQ9AT8VBnqqxWeHuOfhoqkszqdiGAbD/6EtlAGMYnRjycLM
        34NJ0iFZkGis9Gx7uWbOEf8lLCYQ4sM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-qhir4dBUNZyhVXSCtQlDNA-1; Mon, 31 Jul 2023 15:22:29 -0400
X-MC-Unique: qhir4dBUNZyhVXSCtQlDNA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe19cf2796so14278375e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831348; x=1691436148;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XHpXZQfPdcBCB40xD4cQo5HE4yndD5B/+tRyE4teEw=;
        b=haDRffDhZYmaebsauwuij5Rg3P0Z64pg6ecppe0zeZmyPFgI3wfN9F6aEzWswJZfky
         UCeQMLERQJEC1kEKUB2QGQiHHH18Gxm13FI4glc0IShvmFSlVOAilhAEY0lyfhvVfAvv
         i0CZts7yu2MwAnhCe5wljOMAIyb6kL48ZVB+1Cc1tjG/RNnUDEpph/F5RKiL14xRC6/E
         TQ4FTwojc5RThkiGll8JFy8+c3Dcq+cknFVKTVXOjgUnGtD0+MDE1OoHKLSuJIXfmz+e
         WmknMU8PGb9Ue5LLI+J4UKnr4KVDYIYHFfBvv+RuLmiCYdBEm2Xav9uZ6xwPPsY6/BT4
         JHwg==
X-Gm-Message-State: ABy/qLZw/2qdH9XqKMmYs99+Y/0VLvbdTtCIv+z0zGEuIwOnoYj00zfY
        cfnLVPsryvbQ82YpXl5iyhheRVaF2iYuq4+dGb5pbcB44VuuC2xjqAEoZIYSkSwN5Hp9alhAmTW
        vlGObjV72mVmB6zcmsjRXWq7x/Q==
X-Received: by 2002:a5d:5389:0:b0:313:ea59:7ded with SMTP id d9-20020a5d5389000000b00313ea597dedmr527977wrv.24.1690831348687;
        Mon, 31 Jul 2023 12:22:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3VWK9O6PVe8wtmdproWt76/+jiswldybLURzUXx9vkkftywxOeU5n+v/yJOUJccBkcxNCsQ==
X-Received: by 2002:a5d:5389:0:b0:313:ea59:7ded with SMTP id d9-20020a5d5389000000b00313ea597dedmr527965wrv.24.1690831348285;
        Mon, 31 Jul 2023 12:22:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b003145559a691sm13875824wrs.41.2023.07.31.12.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:22:27 -0700 (PDT)
Message-ID: <9a26ce23-9ac7-b111-b700-db0905203c73@redhat.com>
Date:   Mon, 31 Jul 2023 21:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com> <ZMfc9+/44kViqjeN@x1n>
 <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
 <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
 <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.07.23 21:07, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 12:00, David Hildenbrand <david@redhat.com> wrote:
>>
>> So in the "!writable" case, we would always call
>> get_user_pages_unlocked() and never honor NUMA faults.
> 
> Ok, so kvm doesn't just use the fast version. Oh well. It was an idea..

Certainly an interesting one, thanks for thinking about possible 
alternatives! Unfortunately, KVM is an advanced GUP user to managed 
secondary MMUs.

I'll get the FOLL_HONOR_NUMA_FAULT patches ready tomorrow and we can 
discuss if that looks better.

(btw, the whole reasoning about "HW would refuse to use these pages" was 
exactly the whole reason I went into the FOLL_FORCE direction ... but 
it's really better to make FOLL_FORCE deal with VMA protection only)

-- 
Cheers,

David / dhildenb

