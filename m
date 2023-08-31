Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC378E9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjHaJuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjHaJup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:50:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31127CED
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 02:50:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0efe0c4acso512735ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693475442; x=1694080242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hWsSdZV+d/r/C3M//CWRHenhxuyH6PXWTZ8m4C2T5w=;
        b=gHLJlTJpawFYBzTZ7tx7DkJuNUea9eTp8w41ep08ZwitelrtlYKZzRd/m1wBVNEPF7
         zULIdVLEII/m0ElUXkX0r3+2w5vE4zWAdJDdjpDaF2e9dMwcdIzjNc4PvzeKI1zU8Pv6
         oiM6F/oOtYdqB5rAW+BzQJqFascIo7Uix0Qs5IpVJ+YlSzCfQaaRVlUP0dioLKbkXR2i
         sqlZcuu7qrg2SBYf9QQshGG2wIYpBQPogvQGCQJJ7ShdQzyrj+enrIFe3+aem8+t21pS
         eFwl2WD7JpFMG1DXYzFd4e2Nc7nF1ZSgp864wCSAboYS1zsxHDzSrpywZwtwSJJJG5ki
         BTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693475442; x=1694080242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWsSdZV+d/r/C3M//CWRHenhxuyH6PXWTZ8m4C2T5w=;
        b=Q4/Jn5f3fL8RHqQmO4UknIeDMdLX2vD7Tn/TcmGAf6++t/GV6sb299UvRG7xu9779s
         iSaMBe0jNZB2sZSjQzR2ccP46dckhLPamyNAhMQP8bOjn5y25Cw6Et3IAxwlFRIIHjZc
         nLXkph3w+rOQpwQPnq3L8rGbmzNa/PYXqmt44g/P86h0MGnIVgplvGy933CWk341RwMr
         h5yjEcOIYZB2eLXKH4iz+bl76f2JqAzZcjrX96OzT7bd+ffEDUrraDTF1AOgnNQ+9deo
         BrcWeA8BTSHGOGZhrMf3mFKu9JP0MGIfYU7S2R3C+tGrmrCh9yOrNHBwfvDMYktk3EzN
         E+gA==
X-Gm-Message-State: AOJu0YyGguNWaOoJfccjGOb+DwOnDSA9N2f7+DMepHixXRqEG9mctPXo
        clsgcpQf0Ad9tLhGhRGCDZaQXA==
X-Google-Smtp-Source: AGHT+IEnkrf0TI+aDPgBrUJ4hvYx5ldH5fkSZ7zbguENseaBUxfSfJnXVG+gK4GUU5F65oVTA/ERUg==
X-Received: by 2002:a17:903:22cd:b0:1c2:c60:8388 with SMTP id y13-20020a17090322cd00b001c20c608388mr4731256plg.6.1693475442668;
        Thu, 31 Aug 2023 02:50:42 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b001bbb1eec92esm893971plb.281.2023.08.31.02.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 02:50:42 -0700 (PDT)
Message-ID: <414e5087-921f-4f80-06cc-b7b894fd3794@bytedance.com>
Date:   Thu, 31 Aug 2023 17:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/4] cleanups for lockless slab shrink
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        joel@joelfernandes.org, christian.koenig@amd.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org
References: <20230824033539.34570-1-zhengqi.arch@bytedance.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230824033539.34570-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/24 11:35, Qi Zheng wrote:
> Hi all,
> 
> This series is some cleanups split from the previous patchset[1], I dropped the
> [PATCH v2 5/5] which is more related to the main lockless patch.
> 
> This series is based on the next-20230823.
> 
> Comments and suggestions are welcome.
> 
> [1]. https://lore.kernel.org/lkml/20230807110936.21819-1-zhengqi.arch@bytedance.com/
> 
> Thanks,
> Qi
> 
> Changlog in part 1 v2 -> part 1 v3:
>   - drop [PATCH v2 5/5]
>   - collect Acked-by
>   - rebase onto the next-20230823

Hi Andrew,

Can this cleanup series be merged? This part is relatively independent
and has Reviewed-bys and Acked-by.

Thanks,
Qi

> 
> Changlog in part 1 v1 -> part 1 v2:
>   - fix compilation warning in [PATCH 1/5]
>   - rename synchronize_shrinkers() to ttm_pool_synchronize_shrinkers()
>     (pointed by Christian König)
>   - collect Reviewed-by
> 
> Changlog in v4 -> part 1 v1:
>   - split from the previous large patchset
>   - fix comment format in [PATCH v4 01/48] (pointed by Muchun Song)
>   - change to use kzalloc_node() and fix typo in [PATCH v4 44/48]
>     (pointed by Dave Chinner)
>   - collect Reviewed-bys
>   - rebase onto the next-20230815
> 
> Qi Zheng (4):
>    mm: move some shrinker-related function declarations to mm/internal.h
>    mm: vmscan: move shrinker-related code into a separate file
>    mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
>    drm/ttm: introduce pool_shrink_rwsem
> 
>   drivers/gpu/drm/ttm/ttm_pool.c |  17 +-
>   include/linux/shrinker.h       |  20 -
>   mm/Makefile                    |   4 +-
>   mm/internal.h                  |  28 ++
>   mm/shrinker.c                  | 694 ++++++++++++++++++++++++++++++++
>   mm/shrinker_debug.c            |  18 +-
>   mm/vmscan.c                    | 701 ---------------------------------
>   7 files changed, 743 insertions(+), 739 deletions(-)
>   create mode 100644 mm/shrinker.c
> 
