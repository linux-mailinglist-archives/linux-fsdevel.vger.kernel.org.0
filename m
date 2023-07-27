Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BAA76605B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 01:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjG0XtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 19:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjG0Xs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395133A8B;
        Thu, 27 Jul 2023 16:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C1461EFF;
        Thu, 27 Jul 2023 23:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FDC433C7;
        Thu, 27 Jul 2023 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690501724;
        bh=Ttxo2VAoV3s10tVDpG1rs4f+uNBtPiAAdsRn7qEPqAI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ak6ozI5MGJ+V/aaPZbipUbe6ZARep0hinqcaIFmiUbGlXqA4l6qqKubv3sXd24Wis
         E3nRqNpMPjywrGRezhx8kIl9BfOcFGOjuYtEl0wjzGKmd2W/r6L34Y8Q/Asia9+Ai+
         N65piXMA54Y1i5SwziMjZGbgl+PlpLxLOgApRck3LvpJfpGiaZrCds1yq/RX5+TIOO
         TcyhaMq04sGg4mmvI/xNg53Zl5ogRkSJoPUjgXBUN2wkW+R/Z24fG4Bcn7szmrfhkb
         1Y0rUs2KyI/CXZncywoQIP9j5+uNlee3CVuHYo0iSwOTdXpuIWfOUm7reRjWTqpcd1
         EASuIvTp5UKtQ==
Message-ID: <217f3a7e-7681-0da6-aaa7-252a1451f7ba@kernel.org>
Date:   Fri, 28 Jul 2023 08:48:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
 <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
 <ZML22YJi5vPBDEDj@dread.disaster.area>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZML22YJi5vPBDEDj@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/23 07:59, Dave Chinner wrote:
> On Thu, Jul 27, 2023 at 07:20:46PM +0900, Damien Le Moal wrote:
>> On 7/27/23 17:55, Qi Zheng wrote:
>>>>>           goto err;
>>>>>       }
>>>>>   +    zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
>>>>> +    zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
>>>>> +    zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
>>>>> +    zmd->mblk_shrinker->private_data = zmd;
>>>>> +
>>>>> +    shrinker_register(zmd->mblk_shrinker);
>>>>
>>>> I fail to see how this new shrinker API is better... Why isn't there a
>>>> shrinker_alloc_and_register() function ? That would avoid adding all this code
>>>> all over the place as the new API call would be very similar to the current
>>>> shrinker_register() call with static allocation.
>>>
>>> In some registration scenarios, memory needs to be allocated in advance.
>>> So we continue to use the previous prealloc/register_prepared()
>>> algorithm. The shrinker_alloc_and_register() is just a helper function
>>> that combines the two, and this increases the number of APIs that
>>> shrinker exposes to the outside, so I choose not to add this helper.
>>
>> And that results in more code in many places instead of less code + a simple
>> inline helper in the shrinker header file...
> 
> It's not just a "simple helper" - it's a function that has to take 6
> or 7 parameters with a return value that must be checked and
> handled.
> 
> This was done in the first versions of the patch set - the amount of
> code in each caller does not go down and, IMO, was much harder to
> read and determine "this is obviously correct" that what we have
> now.
> 
>> So not adding that super simple
>> helper is not exactly the best choice in my opinion.
> 
> Each to their own - I much prefer the existing style/API over having
> to go look up a helper function every time I want to check some
> random shrinker has been set up correctly....

OK. All fair points.


-- 
Damien Le Moal
Western Digital Research

