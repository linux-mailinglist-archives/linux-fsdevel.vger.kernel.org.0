Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9943728E2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjFICuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 22:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjFICuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:50:23 -0400
Received: from out-37.mta1.migadu.com (out-37.mta1.migadu.com [IPv6:2001:41d0:203:375::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F230F1
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 19:50:22 -0700 (PDT)
Message-ID: <51cbf269-daff-d7b8-653f-7ba388475ab8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686279019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91kh3tFTkOaJY25bw6pXpjQkW2Fhj7YHRJnvq6DamMc=;
        b=erezWzubfqiZyyNGaggPMzlGAh3FNfUsfyDunUTfYykraWAIkxCErvgXdbuVdw1qzSe8qq
        EamnuObDnVO4mFAHRfhGBw6GuXs8e2NxsBEBTllWy9ubHmkTZapeoixstE8icZjHe5r2uO
        lfmT682R9NhjDHhUHvZ6z1e7CXr5/FU=
Date:   Fri, 9 Jun 2023 10:50:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kirill Tkhai <tkhai@ya.ru>, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D> <ZH6K0McWBeCjaf16@dread.disaster.area>
 <20230608163622.GA1435580@mit.edu> <ZIJhou1d55d4H1s0@dread.disaster.area>
 <20230608172722.d32733db433d385daa6c11a0@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230608172722.d32733db433d385daa6c11a0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/9 08:27, Andrew Morton wrote:
> On Fri, 9 Jun 2023 09:17:54 +1000 Dave Chinner <david@fromorbit.com> wrote:
> 
>>> Given that we're at -rc5 now, and the file system folks didn't get
>>> consulted until fairly late in the progress, and the fact that this
>>> may cause use-after-free problems that could lead to security issues,
>>> perhaps we shoould consider reverting the SRCU changeover now, and try
>>> again for the next merge window?
>>
>> Yes, please, because I think we can fix this in a much better way
>> and make things a whole lot simpler at the same time.
> 
> Qi Zheng, if agreeable could you please prepare and send reverts of
> 475733dda5a ("mm: vmscan: add shrinker_srcu_generation") and of
> f95bdb700bc6bb74 ("mm: vmscan: make global slab shrink lockless")?

OK. After reading the proposal suggested by Dave, I think it is more
feasible. I will revert the previous changes ASAP, and then try to
implement Dave's proposal.

Thanks,
Qi

> 
> Thanks.
