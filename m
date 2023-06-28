Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C97407B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1Bjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjF1Bjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:39:43 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 18:39:41 PDT
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999010FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 18:39:41 -0700 (PDT)
Message-ID: <9db7b307-11c7-2770-786d-5727d771aaa9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687915993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C2/e9OXN1uWKWIpZoEkIk0l2No59LPS3LVXKbpNiKw=;
        b=np7oTgs6/QoAHAGzSbaUg+u/r13kffSUylCb3S7Sc4I/DmYNP5QxmisSgAqx3ATWRIxzwO
        EiGMlqhXcn1T8qCzcm+tjJ/dC/RVkWbOUd5ZakaqNF9U4fKo7dd69z7Vt6LTh7XVhjY0+m
        gKPDEMWgY/N4L502LCeMvhppiEXvQp4=
Date:   Wed, 28 Jun 2023 09:33:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 09/12] ext4: Ensure ext4_mb_prefetch_fini() is called
 for all prefetched BGs
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <05e648ae04ec5b754207032823e9c1de9a54f87a.1685449706.git.ojaswin@linux.ibm.com>
 <c3173405-713d-d2eb-bd9c-af8b8c747533@linux.dev>
 <ZJqG+rEl9DATNRIX@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <ZJqG+rEl9DATNRIX@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
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

Hi Ojaswin,

On 6/27/23 14:51, Ojaswin Mujoo wrote:
> On Tue, Jun 06, 2023 at 10:00:57PM +0800, Guoqing Jiang wrote:
>> Hello,
>>
>> On 5/30/23 20:33, Ojaswin Mujoo wrote:
>>> Before this patch, the call stack in ext4_run_li_request is as follows:
>>>
>>>     /*
>>>      * nr = no. of BGs we want to fetch (=s_mb_prefetch)
>>>      * prefetch_ios = no. of BGs not uptodate after
>>>      * 		    ext4_read_block_bitmap_nowait()
>>>      */
>>>     next_group = ext4_mb_prefetch(sb, group, nr, prefetch_ios);
>>>     ext4_mb_prefetch_fini(sb, next_group prefetch_ios);
>>>
>>> ext4_mb_prefetch_fini() will only try to initialize buddies for BGs in
>>> range [next_group - prefetch_ios, next_group). This is incorrect since
>>> sometimes (prefetch_ios < nr), which causes ext4_mb_prefetch_fini() to
>>> incorrectly ignore some of the BGs that might need initialization. This
>>> issue is more notable now with the previous patch enabling "fetching" of
>>> BLOCK_UNINIT BGs which are marked buffer_uptodate by default.
>>>
>>> Fix this by passing nr to ext4_mb_prefetch_fini() instead of
>>> prefetch_ios so that it considers the right range of groups.
>> Thanks for the series.
>>
>>> Similarly, make sure we don't pass nr=0 to ext4_mb_prefetch_fini() in
>>> ext4_mb_regular_allocator() since we might have prefetched BLOCK_UNINIT
>>> groups that would need buddy initialization.
>> Seems ext4_mb_prefetch_fini can't be called by ext4_mb_regular_allocator
>> if nr is 0.
> Hi Guoqing,
>
> Sorry I was on vacation so didn't get a chance to reply to this sooner.
> Let me explain what I meant by that statement in the commit message.
>
> So basically, the prefetch_ios output argument is incremented whenever
> ext4_mb_prefetch() reads a block group with !buffer_uptodate(bh).
> However, for BLOCK_UNINIT BGs the buffer is marked uptodate after
> initialization and hence prefetch_ios is not incremented when such BGs
> are prefetched.
>
> This leads to nr becoming 0 due to the following line (removed in this patch):
>
> 				if (prefetch_ios == curr_ios)
> 					nr = 0;
>
> hence ext4_mb_prefetch_fini() would never pre initialise the corresponding
> buddy structures. Instead, these structures would then get initialized
> probably at a later point during the slower allocation criterias. The
> motivation of making sure the BLOCK_UNINIT BGs' buddies are pre
> initialized is so the faster allocation criterias can utilize the data
> to make better decisions.

Got it, appreciate for the detailed explanation!

Thanks,
Guoqing
