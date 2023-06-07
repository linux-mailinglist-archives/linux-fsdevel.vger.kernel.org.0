Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7311672523A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbjFGCwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 22:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFGCvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:51:46 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6019BD
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 19:51:45 -0700 (PDT)
Message-ID: <4176ef18-0125-dee8-f78a-837cb7a5c639@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686106303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c03LqnPvSpFUegRcW9e1g0apz1BXSwwD0DXfsq/bGJ0=;
        b=FdUailL3WmNCtharci/DkkvAqyb8ew/poMMvuuMcNtImmZNAvkAMqM4ZKG8RPbZJ/+x7re
        R42sgBM53ZiTB0JgaH3YgE762t9Pt8YLVn6ljcYFmsyR+cPrQ04xDXSF30AyERnpgQgDce
        meBiZ8Jq7Ora+NndQDhxtKZMnNxEvRc=
Date:   Wed, 7 Jun 2023 10:51:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] mm: Make unregistration of super_block shrinker
 more faster
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, Kirill Tkhai <tkhai@ya.ru>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <ZH5ig590WleaH1Ed@dread.disaster.area>
 <ef1b0ecd-5a03-4256-2a7a-3e22b755aa53@ya.ru>
 <ZH+s+XOI2HlLTDzs@dread.disaster.area>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ZH+s+XOI2HlLTDzs@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/7 06:02, Dave Chinner wrote:
> On Wed, Jun 07, 2023 at 12:06:03AM +0300, Kirill Tkhai wrote:
>> On 06.06.2023 01:32, Dave Chinner wrote:
>>> On Mon, Jun 05, 2023 at 10:02:46PM +0300, Kirill Tkhai wrote:
>>>> This patch set introduces a new scheme of shrinker unregistration. It allows to split
>>>> the unregistration in two parts: fast and slow. This allows to hide slow part from
>>>> a user, so user-visible unregistration becomes fast.
>>>>
>>>> This fixes the -88.8% regression of stress-ng.ramfs.ops_per_sec noticed
>>>> by kernel test robot:
>>>>
>>>> https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
>>>>
>>>> ---
>>>>
>>>> Kirill Tkhai (2):
>>>>        mm: Split unregister_shrinker() in fast and slow part
>>>>        fs: Use delayed shrinker unregistration
>>>
>>> Did you test any filesystem other than ramfs?
>>>
>>> Filesystems more complex than ramfs have internal shrinkers, and so
>>> they will still be running the slow synchronize_srcu() - potentially
>>> multiple times! - in every unmount. Both XFS and ext4 have 3
>>> internal shrinker instances per mount, so they will still call
>>> synchronize_srcu() at least 3 times per unmount after this change.
>>>
>>> What about any other subsystem that runs a shrinker - do they have
>>> context depedent shrinker instances that get frequently created and
>>> destroyed? They'll need the same treatment.
>>
>> Of course, all of shrinkers should be fixed. This patch set just aims to describe
>> the idea more wider, because I'm not sure most people read replys to kernel robot reports.

Thank you, Kirill.

>>
>> This is my suggestion of way to go. Probably, Qi is right person to ask whether
>> we're going to extend this and to maintain f95bdb700bc6 in tree.
>>
>> There is not much time. Unfortunately, kernel test robot reported this significantly late.
> 
> And that's why it should be reverted rather than trying to rush to
> try to fix it.
> 
> I'm kind of tired of finding out about mm reclaim regressions only
> when I see patches making naive and/or broken changes to subsystem
> shrinker implementations without any real clue about what they are
> doing.  If people/subsystems who maintain shrinker implementations
> were cc'd on the changes to the shrinker implementation, this would
> have all been resolved before merging occurred....
> 
> Lockless shrinker lists need a heap of supporting changes to be done
> first so that they aren't reliant on synchronise_srcu() *at all*. If
> the code was properly designed in the first place (i.e. dynamic
> shrinker structures freed via call_rcu()), we wouldn't be in rushing
> to fix weird regressions right now.
> 
> Can we please revert this and start again with a properly throught
> out and reveiwed design?

I have no idea on whether to revert this, I follow the final decision of
the community.

 From my personal point of view, I think it is worth sacrificing the
speed of unregistration alone compared to the benefits it brings
(lockless shrink, etc).

Of course, it would be better if there is a more perfect solution.
If you have a better idea, it might be better to post the code first for
discussion. Otherwise, I am afraid that if we just revert it, the
problem of shrinker_rwsem will continue for many years.

And hi Dave, I know you're mad that I didn't cc you in the original
patch. Sorry again. How about splitting shrinker-related codes into
the separate files? Then we can add a MAINTAINERS entry to it and add
linux-fsdevel@vger.kernel.org to this entry? So that future people
will not miss to cc fs folks.

Qi.

> 
> -Dave.
