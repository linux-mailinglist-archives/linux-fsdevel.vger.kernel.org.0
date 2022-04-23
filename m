Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6930C50C9B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiDWLwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiDWLwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:52:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981681F6E5A;
        Sat, 23 Apr 2022 04:49:17 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23NBmTfj015009;
        Sat, 23 Apr 2022 20:48:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 23 Apr 2022 20:48:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23NBmSiS015000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Apr 2022 20:48:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8a6659ba-13ba-b9be-08c8-f02f106d55fb@I-love.SAKURA.ne.jp>
Date:   Sat, 23 Apr 2022 20:48:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, rostedt@goodmis.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz> <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan> <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan> <YmNVjiVv0fKXYjIF@carbon>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YmNVjiVv0fKXYjIF@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/23 10:25, Roman Gushchin wrote:
>>> I agree. However the OOM killer _has_ to make the progress even in such rare
>>> circumstances.
>>
>> Oh, and the concern is allocator recursion? Yeah, that's a good point.
> 
> Yes, but not the only problem.
> 
>>
>> Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
>> or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
>> generate the report on slabs, since we're taking the slab mutex there.
> 
> And this is another problem: grabbing _any_ locks from the oom context is asking
> for trouble: you can potentially enter the oom path doing any allocation, so
> now you have to check that no allocations are ever made holding this lock.
> And I'm not aware of any reasonable way to test it, so most likely it ends up
> introducing some very subtle bags, which will be triggered once a year.
> 

You can't allocate memory nor hold locks from OOM context. Since oom_lock mutex
serializes OOM reporting, you could use statically pre-allocated buffer for holding
one line of output. Correlating whole report will be done by the userspace program
with the aid of CONFIG_PRINTK_CALLER=y.
