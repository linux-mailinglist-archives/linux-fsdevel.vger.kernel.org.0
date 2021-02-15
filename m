Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC1831B46C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 04:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhBODcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 22:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhBODcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 22:32:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE69C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 19:31:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so3389908pfk.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 19:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uGee1Sqxh09dV8vkHRwclJsUep7f7elSEGwb7r92uZM=;
        b=pMZRPm8cdpq3GcVV5SDtobk8F9OheAbYTKyEDYitF0QmZDXfi6oU6zRwlv7eiGgBSh
         Me4X3zKbVocZrB3i/SGkbl4ifvBbJfeEG+/cysE+N+ocenj34bP296YwAdyyBCJeUtz9
         8CGClmncU+4n6MpMkRt/xV68du7s2u2YHrpxuJR356NX5mXg9vdkFZflEqM4hxGoabEm
         avmuBPR65AYEnOW0v7Ey50/DMN0AgGqX3HctU4YwsIs+hk322EnJ8lMjfpY86wlpk7A3
         WU44ZJ4HCcigJKK/WVj7IWR8ALIs3RNE8BXb+FWZ5ODyjkGd6bdCnvyxl3UT2KgS/0gW
         RtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGee1Sqxh09dV8vkHRwclJsUep7f7elSEGwb7r92uZM=;
        b=D6vzsyWX5qvxgsfJekVvUd/Zq6l4ZAIMR65+E82DeHoTJA9my5i8yZ9x6+nWDWs0UV
         cGre0mjLKv+6BjrehUlbvM5RvV4ca/o7PaHVbOMnFS05s5l6UJw2w6OrFkMTmzNgO91r
         1/841YEzr5g+45J+p6MtqJaednNl7n94n9VMbIarErPfZGCQDW9/oUC/fpRr+F8tmxTL
         02Igl2pYnD08lfpJeI6t/eiulcVtyoETf5gknJ9a8zHWzXm6DHNJ61tWBtvMq+w380TH
         1WPJeCJ09TI7X6M5VAPDr7ZROwZ/teb0jQBVIGPjVJyhnInJ+l3BXC4V/65TBG0LzCab
         aWSg==
X-Gm-Message-State: AOAM533TrLUxTwjnqhRHvyfbNp4puJXV76dCzqmpx85nRKX+YQtZQm/X
        f7UEq1gHI0aYoWBkZ8i3q7/5uB5k3PoY4Q==
X-Google-Smtp-Source: ABdhPJxQGBImz1c71eRCcr+c0r2VMSqsNlE1XnUx5xnHp69PpA4EkU/fNFi0Ej5WharSBU3FFAaaLA==
X-Received: by 2002:a62:3852:0:b029:1da:7238:1cb1 with SMTP id f79-20020a6238520000b02901da72381cb1mr13722320pfa.11.1613359889195;
        Sun, 14 Feb 2021 19:31:29 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y73sm16687963pfb.17.2021.02.14.19.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 19:31:28 -0800 (PST)
Subject: Re: [PATCH RFC] namei: don't drop link paths acquired under
 LOOKUP_RCU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
 <YClKQlivsPPcbyCd@zeniv-ca.linux.org.uk>
 <YClSik4Ilvh1vF64@zeniv-ca.linux.org.uk>
 <0699912b-84ae-39d5-6b2e-8cb04eaa3939@kernel.dk>
 <YCmq75pc0bHInDGP@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b364ddb-cf9a-bf32-d426-053ff3aa6385@kernel.dk>
Date:   Sun, 14 Feb 2021 20:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCmq75pc0bHInDGP@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/21 3:57 PM, Al Viro wrote:
> On Sun, Feb 14, 2021 at 09:45:39AM -0700, Jens Axboe wrote:
> 
>>>> +out3:
>>>> +	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
>>>>  out2:
>>>>  	nd->path.mnt = NULL;
>>>>  out1:
>>>
>>> Alternatively, we could use the fact that legitimize_links() is not
>>> called anywhere other than these two places and have LOOKUP_CACHED
>>> checked there.  As in
>>
>> Both fix the issue for me, just tested them. The second one seems
>> cleaner to me, would probably be nice to have a comment on that in
>> either the two callers or at least in legitimize_links() though.
> 
> Hmm...  Do you have anything on top of that branch?  If you do, there's
> no way to avoid leaving bisect hazard; if not, I'd rather fold a fix
> into the broken commit...

I do, that's basically the base of that series, -rc6 + that branch. So
I'd prefer if you just apply the fixup, which I do think is pretty low
risk even if it is a potential bisection pain point. But not really
a huge one, in this case.

That said, if you do want to rebase it, I can rebase mine. That's not
the end of the world either.

-- 
Jens Axboe

