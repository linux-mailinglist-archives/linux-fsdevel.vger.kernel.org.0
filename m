Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A1780B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbjHRLyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbjHRLyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:54:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACE2701
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:53:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc63ef9959so6610335ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692359638; x=1692964438;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWUAu55Okzaxxflb8/jmAhx5gyfvmuNdSd8uGCqH/Zw=;
        b=eq248EH06v7v4m/+8bSuN+oJAZuyVZ5P3IhvOfLa0gH7Ftb4Z9KOJPje0UAQJX5er3
         OhtWSQ0AU0VFJKU4fmVprsd/oJUo2QPwIqoQioP3mBhb4FfKfQ01RO5dO9nKWy2SI/MP
         uTVk259CT4/3xUyvWB4kB2IWgaSxWKXb9L+hjscXInyvbpHmDBPmpl9M7xDVwBcTenEw
         Ld10dgJhTAcBMt8SxxJddrMcsX7zxwXVGO8YCYY4siCBLxOEN7kItKjMnnr1ePIcPKvP
         DAa5MKiQQhtw09iC3rbTHJK2e7KNkDZEtI44JZndbkamNp61O7+cGrXXASEv5pxu3x33
         qjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692359638; x=1692964438;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWUAu55Okzaxxflb8/jmAhx5gyfvmuNdSd8uGCqH/Zw=;
        b=fJKylycv2ZHFa7STsm3wSgaZQfma1DGq5IElDE1KkaOPywQLY4rZWswKZ/8TFvyjMM
         1eylb/Qx2A5C9QP1Q+1kd1CybH76JUzajtkpvubbR5tdFjzEL3KVqElKliNTgX75wIvu
         1/LoIRthyM7On76RO4SdPJ6h6SRA4Iw0yZnGU3A7D5bX3D/6DTW4rbCwGIV7vEAZf36i
         FMlelaQkn4TEIt3oTg3ExzcGtwblwLgne4zHOk92PunOJOcRiei2eM0aqqq9N/kQOiEY
         epRB3gWlCJYhXgpsVBfjAOphNX8nB1RIpOT8uILmpn+5/4ulLr9a46ASSSRJ3MVuGNK+
         U8LQ==
X-Gm-Message-State: AOJu0YxqgI4LfJ4qr7+b3Im5mYy8T+QZh7IMsxr+eSBrCwmO1z0yvSz6
        7QrVXV9E9UsLxsoOn0PFv8YqWQ==
X-Google-Smtp-Source: AGHT+IEoDhL7JPYYvqyUCrTfrN7Sp8X7zYiAiDB+7WTz2PRk2dwjF8tQdyEs8B7UpMHhLGp3Zs9ccw==
X-Received: by 2002:a17:90b:3003:b0:269:33cb:e061 with SMTP id hg3-20020a17090b300300b0026933cbe061mr2118476pjb.24.1692359638052;
        Fri, 18 Aug 2023 04:53:58 -0700 (PDT)
Received: from [10.254.252.111] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a598b00b00267b38f5e13sm1336696pji.2.2023.08.18.04.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 04:53:57 -0700 (PDT)
Message-ID: <6b6d7ef1-75e4-68a3-1662-82ee19334567@bytedance.com>
Date:   Fri, 18 Aug 2023 19:53:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, willy@infradead.org,
        michael.christie@oracle.com, surenb@google.com, npiggin@gmail.com,
        corbet@lwn.net, mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
 <20230726160354.konsgq6hidj7gr5u@revolver>
 <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
 <20230731162714.4x3lzymuyvu2mter@revolver>
 <3f4e73cc-1a98-95a8-9ab2-47797d236585@bytedance.com>
 <20230816183029.5rpkbgp2umebrjh5@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230816183029.5rpkbgp2umebrjh5@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/8/17 02:30, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:42]:
>>
>>
> ...
> 
>>>>>> +/**
>>>>>> + * __mt_dup(): Duplicate a maple tree
>>>>>> + * @mt: The source maple tree
>>>>>> + * @new: The new maple tree
>>>>>> + * @gfp: The GFP_FLAGS to use for allocations
>>>>>> + *
>>>>>> + * This function duplicates a maple tree using a faster method than traversing
>>>>>> + * the source tree and inserting entries into the new tree one by one. The user
>>>>>> + * needs to lock the source tree manually. Before calling this function, @new
>>>>>> + * must be an empty tree or an uninitialized tree. If @mt uses an external lock,
>>>>>> + * we may also need to manually set @new's external lock using
>>>>>> + * mt_set_external_lock().
>>>>>> + *
>>>>>> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
>>>>>> + */
>>>>>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
>>>>>
>>>>> We use mas_ for things that won't handle the locking and pass in a maple
>>>>> state.  Considering the leaves need to be altered once this is returned,
>>>>> I would expect passing in a maple state should be feasible?
>>>> But we don't really need mas here. What do you think the state of mas
>>>> should be when this function returns? Make it point to the first entry,
>>>> or the last entry?
>>>
>>> I would write it to point to the first element so that the call to
>>> replace the first element can just do that without an extra walk and
>>> document the maple state end point.
>> Unfortunately, this does not seem to be convenient. Users usually use
>> mas_for_each() to replace elements. If we set mas to the first element,
>> the first call to mas_find() in mas_for_each() will get the next
>> element.
> 
> This sounds like the need for another iterator specifically for
> duplicating.
> 
>>
>> There may also be other scenarios where the user does not necessarily
>> have to replace every element.
> 
> Do you mean a limit or elements that need to be skipped?  We could have
> a limit on the iteration.
> 
>>
>> Finally, getting the first element in __mt_dup() requires an additional
>> check to check whether the first element has already been recorded. Such
>> a check will be performed at each leaf node, which is unnecessary
>> overhead.
>>
>> Of course, the first reason is the main reason, which prevents us from
>> using mas_for_each(). So I don't want to record the first element.
> 
> 
> I don't like the interface because it can easily be misunderstood and
> used incorrectly.  I don't know how to make a cleaner interface, but
> I've gone through a few thoughts:
> 
> The first was hide _all of it_ in a new iterator:
> mas_dup_each(old, new, old_entry) {
> 	if (don't_dup(old_entry)) {
> 		mas_erase(new);
> 		continue;
> 	}
> 
> 	mas_dup_insert(new, new_entry);
> }
> 
> This iterator would check if mas_is_start(old) and dup the tree in that
> event.  Leave the both new trees pointing to the first element and set
> old_entry.  I don't know how to handle the failure in duplicating the
> tree in this case - I guess we could return old_entry = NULL and check
> if mas_is_err(old) after the loop.  Do you see a problem with this?
This interface looks OK. But handling the failure case is tricky.
> 
> 
> The second idea was an init of the old tree.  This is closest to what you
> have:
> 
> if (mas_dup_init(old, new))
> 	goto -ENOMEM;
> 
> mas_dup_each(old, new) {
> 	if (don't_dup(old_entry)) {
> 		mas_erase(new);
> 		continue;
> 	}
> 
> 	mas_dup_insert(new, new_entry);
> }
I think this interface could be better.
> 
> This would duplicate the tree at the start and leave both pointing at
> the first element so that mas_dup_each() could start on that element.
> Each subsequent call would go to the next element in both maple states.
Every element of the new tree is the same as the old tree, and we don't
need to maintain the mas of the old tree. It is enough to maintain the
mas of the new tree when traversing.

> It sounds like you don't want this for performance reasons?  Although
I mean I don't want to record the first element during duplicating. But
we can get the first element after the duplicate completes. This can
also still be within the implementation of the interface.

> looking at mas_find() today, I think this could still work since we are
> checking the maple state for a lot.
Yes, mas_find() does a whole bunch of checks.
> 
> Both ideas could be even faster than what you have if we handle the
> special cases of mas_is_none()/mas_is_ptr() in a smarter way because we
> don't need to be as worried about the entry point of the maple state as
> much as we do with mas_find()/mas_for_each().  I mean, is it possible to
> get to a mas_is_none() or mas_is_ptr() on duplicating a tree?  How do we
> handle these users?
The check for mas_is_none() or mas_is_ptr() in mas_find() is really not
worth it if we hold the lock. There doesn't seem to be a good way around
mas_is_ptr() since it needs to enter the loop once. mas_is_none() can be
solved because it does not enter the loop, we can use it as a condition
to enter the loop.

Without using mas_find() to avoid the check inside, I have to figure out
how I can handle mas_is_ptr() properly.
> 
> Both ideas still suffer from someone saying "Gee, that {insert function
> name here} is used in the forking code, so I can totally use that in my
> code because that's how it work!"  and find out it works for the limited
> testing they do.  Then it fails later and the emails start flying.
> 
> 
> I almost think we should do something like this on insert:
> 
> void mas_dup_insert(old, new, new_entry) {
> 	WARN_ON_ONCE(old == new);
> 	WARN_ON_ONCE(old->index != new->index);
> 	WARN_ON_ONCE(old->last != new->last);
> 	...
> }
Maintaining old mas doesn't feel worth it. If this we have to traverse
the old tree one more time.
> 
> This would at least _require_ someone to have two maple states and
> hopefully think twice on using it where it should not be used.
> 
> The bottom line is that this code is close to what we need to make
> forking better, but I fear the misuse of the interface.
> 
> Something else to think about:
> In the work items for the Maple Tree, there is a plan to have an enum to
> specify the type of write that is going to happen.  The idea was for
> mas_preallocate() to set this type of write so we can just go right to
> the correct function.  We could use that here and set the maple state
> write type to a direct replacement.
This can be the next step. We can do without it for now.
> 
> Thanks,
> Liam
> 
