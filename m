Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AF3FB243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhH3INR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhH3INQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:13:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649EC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 01:12:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c8so16997836lfi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=37NPYMAcAJ2zN2cJYUDeD0UMO7gOVKhQ3wSJbKTk4Y4=;
        b=GCDOzcNzVhs4IQ7426ZVN03J0Ko2sEjG9cQEZGeMHf7zHH0uTul5FY+dMxWAJAq77p
         j+8i+7QJbELQPKI4PT+dLeghPh3S68CXIvvm52+XXL80drAEs96e4nX4qMjOTIzgJVC8
         cARoPXDw1opzv8Bt2MuT5eD6UsHeTs6ZLJSBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=37NPYMAcAJ2zN2cJYUDeD0UMO7gOVKhQ3wSJbKTk4Y4=;
        b=lEFlfl5FVLEZV6f4fi8Myl6G/FAHTLcD4nc5f/VgWYbMp3Omtay0J/xidrAbO9fDRa
         ivHkLkTeMGhKrE8VrW7iBFWCw6rXUz0RyPYYb72dU09kOterkdB/xJ3ZGGBJcbB9PuKA
         Gq2Za1Av7V6LiZVtAUDIQnzYllpCzUvlS3z7iZLqxUXvwcHV3TujP6EBUapikJ/v+qrr
         OpFUSYSl7rRC8RGbdeowgGgeKpjjonoF54/8UvTWofEVY298QXxQV+So1zA68gDlwYsJ
         U7KO4ABW62JWpDgIAXnXi5ayHKz7Sw+KhoMbSQli/w7pHX3Irr+s6QkgHdU8/+/m/edT
         Zj/A==
X-Gm-Message-State: AOAM530Mv7Nojv1u8EdC2w+m9vTLLv3JpNULoWQ5zRzJDNJCbYUNsNdv
        FB8K316kJ445bnLx29cc9COnsw==
X-Google-Smtp-Source: ABdhPJyqK6pQ4ZHjxX58026zqbgeQvpstiUZ8XlEC+qgCUJQtVIYIg6u5NRiRukkzgIJZHyRGY3uhA==
X-Received: by 2002:a05:6512:1686:: with SMTP id bu6mr16774526lfb.168.1630311141001;
        Mon, 30 Aug 2021 01:12:21 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e4sm676505lfc.141.2021.08.30.01.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 01:12:20 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org, eb@emlix.com,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
 <YSmVl+DEPrU6oUR4@casper.infradead.org> <202108272228.7D36F0373@keescook>
 <CAJuCfpEWc+eTLYp_Xf9exMJCO_cFtvBUzi39+WbcSKZBXHe3SQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f7117620-28ba-cfa5-b2c6-21812f15e4d6@rasmusvillemoes.dk>
Date:   Mon, 30 Aug 2021 10:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEWc+eTLYp_Xf9exMJCO_cFtvBUzi39+WbcSKZBXHe3SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/08/2021 23.47, Suren Baghdasaryan wrote:
> On Fri, Aug 27, 2021 at 10:52 PM Kees Cook <keescook@chromium.org> wrote:
>>
>>>> +   case PR_SET_VMA_ANON_NAME:
>>>> +           name = strndup_user((const char __user *)arg,
>>>> +                               ANON_VMA_NAME_MAX_LEN);
>>>> +
>>>> +           if (IS_ERR(name))
>>>> +                   return PTR_ERR(name);
>>>> +
>>>> +           for (pch = name; *pch != '\0'; pch++) {
>>>> +                   if (!isprint(*pch)) {
>>>> +                           kfree(name);
>>>> +                           return -EINVAL;
>>>
>>> I think isprint() is too weak a check.  For example, I would suggest
>>> forbidding the following characters: ':', ']', '[', ' '.  Perhaps

Indeed. There's also the issue that the kernel's ctype actually
implements some almost-but-not-quite latin1, so (some) chars above 0x7f
would also pass isprint() - while everybody today expects utf-8, so the
ability to put almost arbitrary sequences of chars with the high bit set
could certainly confuse some parsers. IOW, don't use isprint() at all,
just explicitly check for the byte values that we and up agreeing to
allow/forbid.

>>> isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
>>> be opposed to some punctuation characters, but let's avoid creating
>>> confusion.  Do you happen to know which characters are actually in use
>>> today?
>>
>> There's some sense in refusing [, ], and :, but removing " " seems
>> unhelpful for reasonable descriptors. As long as weird stuff is escaped,
>> I think it's fine. Any parser can just extract with m|\[anon:(.*)\]$|
> 
> I see no issue in forbidding '[' and ']' but whitespace and ':' are
> currently used by Android. Would forbidding or escaping '[' and ']' be
> enough?

how about allowing [0x20, 0x7e] except [0x5b, 0x5d], i.e. all printable
(including space) ascii characters, except [ \ ] - the brackets as
already discussed, and backslash because then there's nobody who can get
confused about whether there's some (and then which?) escaping mechanism
in play - "\n" is simply never going to appear. Simple rules, easy to
implement, easy to explain in a man page.

>>
>> For example, just escape it here instead of refusing to take it. Something
>> like:
>>
>>         name = strndup_user((const char __user *)arg,
>>                             ANON_VMA_NAME_MAX_LEN);
>>         escaped = kasprintf(GFP_KERNEL, "%pE", name);

I would not go down that road. First, it makes it much harder to explain
the rules for what are allowed and not allowed. Second, parsers become
much more complicated. Third, does the length limit then apply to the
escaped or unescaped string?

Rasmus
