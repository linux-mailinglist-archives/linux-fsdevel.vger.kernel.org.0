Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374A6E0C55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMLT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDMLTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A8618F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681384747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuDaODPg28/lbKls3iVZv9/j3tAy7pEuJB1+NArX0sI=;
        b=eKTNUWpXgFdbRwhSqXj38iiLWbqiaHlFT5Cco8u2hmNtv/JvbeSajUT62VumMac60zkMkR
        XBgWTrUrb/ZTRoJTEGJ1GdKee2oe4gC4+gbgkKd+RERuCvCuYcp6zudUXUALJm2YqUHNrE
        2eQPsfsqnz4ecqG7tB8N52JVGp7RyW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-tED2Tj6HONWcZjJ5iFd7Rw-1; Thu, 13 Apr 2023 07:19:05 -0400
X-MC-Unique: tED2Tj6HONWcZjJ5iFd7Rw-1
Received: by mail-wm1-f70.google.com with SMTP id j34-20020a05600c1c2200b003f0ad53c14eso341931wms.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384744; x=1683976744;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuDaODPg28/lbKls3iVZv9/j3tAy7pEuJB1+NArX0sI=;
        b=Ff2WOerY2YMCuJC7YgQBQ3TU893e2ICrZYczVGDRST0dfv5SYNFJ/LOVAFnrb+pE/W
         rwHK5Ik0SfygC41TWO1OXe9amQj0Y0otGNG5RM+lHxlayjJG518qYUmr+VlEUzzQMEIC
         dyLiDtALS2jHWZDS1zslXwL/lkN9SXpKep7z2lFLbZGMUr1vwrGMVu2c84yGkxJYsS4g
         CifRYQAo4azfQo1QtH3gZ1/q6GJlhwzFm85iSW7milNdCotgh7THp4Meouq2WLTh2yLr
         XYLtMjkdfZo4+xNlZSJDLn4cCl+pBrZc0KEi49D5clnr8iC0ea5y+DOLLAU0eMx2Rp+w
         K1Qw==
X-Gm-Message-State: AAQBX9fc1MeD/Oi1h3dLD/iOr2LRA3HaJxIk0ZZHRzfofqHLHbV9ebLC
        7lDHIJrqixwMzsGvohP2ebm5p2vvgBxoEau6jZfxwPK2EcUsb6xN5XRtBFUHiqLXj8gwJSmrlis
        M9d5nKQA7IYqYc/IrOlyIZjB91g==
X-Received: by 2002:a7b:ca4c:0:b0:3f0:7147:2ecd with SMTP id m12-20020a7bca4c000000b003f071472ecdmr1571283wml.7.1681384744360;
        Thu, 13 Apr 2023 04:19:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLB2veUASI4/m+qmmFnnoaJ0DjGho2eJAioBtjyEBuvdQ48H1Q2Wt23LlVt3082GLF+6fzbQ==
X-Received: by 2002:a7b:ca4c:0:b0:3f0:7147:2ecd with SMTP id m12-20020a7bca4c000000b003f071472ecdmr1571251wml.7.1681384743997;
        Thu, 13 Apr 2023 04:19:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003ee9c8cc631sm5196264wmb.23.2023.04.13.04.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:19:03 -0700 (PDT)
Message-ID: <bb42720b-dec9-a62b-50a2-422ddd6a1920@redhat.com>
Date:   Thu, 13 Apr 2023 13:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 2/3] mm: vmscan: move set_task_reclaim_state() near
 flush_reclaim_state()
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-3-yosryahmed@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413104034.1086717-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.04.23 12:40, Yosry Ahmed wrote:
> Move set_task_reclaim_state() near flush_reclaim_state() so that all
> helpers manipulating reclaim_state are in close proximity.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Hm, it's rather a simple helper to set the reclaim_state for a task, not 
to modify it.

No strong opinion, but I'd just leave it as it.

-- 
Thanks,

David / dhildenb

