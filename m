Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731D86E0C4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjDMLRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjDMLR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0967A26A
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681384587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNSaV+uzNwUaTHzuGiSzLbWwlIcvuOBgoNlGeWAI1UU=;
        b=d7M1oBTE/7SGCLVpg1IYcdzfGKqdVvi19Ntqvf6vrI+FFWgnHeQ1+jsyUq9YDZ8tfNJzJr
        umkclcdgjEifo2Jso5bSzetgEQTZZ5sbPCWBvmCYL/pJy4ZP6uy64kV39Ih04P/UfN/ZhV
        JxWLPhonmQDYxAN81t1/6VEVdcumV3k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-xv-pf8CzNR6x44G2l9-j4A-1; Thu, 13 Apr 2023 07:16:26 -0400
X-MC-Unique: xv-pf8CzNR6x44G2l9-j4A-1
Received: by mail-wm1-f71.google.com with SMTP id f14-20020a05600c154e00b003f0a04fd5b6so1949693wmg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384585; x=1683976585;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNSaV+uzNwUaTHzuGiSzLbWwlIcvuOBgoNlGeWAI1UU=;
        b=kheMGtNMXegBYlVxbihmwsiRJJmOGuNmr9TYHjsXphMGMU5KnUIVgXOYRQe5rn+bDz
         M3xl8LMmu+uYvI6yjINyKu5i/meROrtAP8bLE9t1vFNb7RQnpaNwoKkxXkX4OlWmGYYb
         c9TIO2hDaJY6bp8PXTal9JbGkg73veWA941XmCqAffqWcN/EffLmA5REGvyvTSf4tbS+
         zLSkCd3d8Zbe49M38dH8y0+Sa2+GYN4T05ELNh/Awq5pR4cn49/2BOoHwZxq+N1f3Vu8
         1jtdYZJm5Tx85Xq4rlhp7MQN0jb22N4VzuYmS+UAKiOCIdSUzjIHv7x2n14z6jEiD4D4
         LU4g==
X-Gm-Message-State: AAQBX9cUoEf19Fvfp1VncXpU3uDWFAdwbW/VvimFn4iTKT58+nqPTffS
        Vu/EfRJdycU00lTqHOGiYzsCZpJENfmOUR1SEiHCQEJNyiAGCwGBvodvLvAMJv3pE50OTS2EfrC
        wHDhgotsI4STcC1RsBlpB6sCeOQ==
X-Received: by 2002:a05:600c:253:b0:3ee:2b04:e028 with SMTP id 19-20020a05600c025300b003ee2b04e028mr1540237wmj.14.1681384585003;
        Thu, 13 Apr 2023 04:16:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y56+uVeHEpQ7DYhvS2HpddDR7vO9wV6HUHDfsZtsRnbxqsJQPF2RWE55xND5m+Q/fCnqGAWg==
X-Received: by 2002:a05:600c:253:b0:3ee:2b04:e028 with SMTP id 19-20020a05600c025300b003ee2b04e028mr1540223wmj.14.1681384584652;
        Thu, 13 Apr 2023 04:16:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6287000000b002e463bd49e3sm1064660wru.66.2023.04.13.04.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:16:24 -0700 (PDT)
Message-ID: <0340c57b-dcec-42ba-eb6e-dd5599722ea4@redhat.com>
Date:   Thu, 13 Apr 2023 13:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg
 reclaim
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
 <20230413104034.1086717-2-yosryahmed@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413104034.1086717-2-yosryahmed@google.com>
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
> We keep track of different types of reclaimed pages through
> reclaim_state->reclaimed_slab, and we add them to the reported number
> of reclaimed pages.  For non-memcg reclaim, this makes sense. For memcg
> reclaim, we have no clue if those pages are charged to the memcg under
> reclaim.
> 
> Slab pages are shared by different memcgs, so a freed slab page may have
> only been partially charged to the memcg under reclaim.  The same goes for
> clean file pages from pruned inodes (on highmem systems) or xfs buffer
> pages, there is no simple way to currently link them to the memcg under
> reclaim.
> 
> Stop reporting those freed pages as reclaimed pages during memcg reclaim.
> This should make the return value of writing to memory.reclaim, and may
> help reduce unnecessary reclaim retries during memcg charging.  Writing to
> memory.reclaim on the root memcg is considered as cgroup_reclaim(), but
> for this case we want to include any freed pages, so use the
> global_reclaim() check instead of !cgroup_reclaim().
> 
> Generally, this should make the return value of
> try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
> freed a slab page that was mostly charged to the memcg under reclaim),
> the return value of try_to_free_mem_cgroup_pages() can be underestimated,
> but this should be fine. The freed pages will be uncharged anyway, and we
> can charge the memcg the next time around as we usually do memcg reclaim
> in a retry loop.
> 
> Fixes: f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages")
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

LGTM, hopefully the underestimation won't result in a real issue.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

