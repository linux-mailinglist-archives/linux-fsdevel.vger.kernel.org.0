Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE42DB43B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 20:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgLOTEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 14:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgLOTDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:03:44 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE8C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:03:04 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lb18so118648pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kicgBJLt4ABQDEHcioYExmPzV/2uiTpHJkCQCxMA5+w=;
        b=FUgdGMNYuT26lP93FAQqxf8N8wTSEsVknI864cXABnZm7a5tGppyEKTwklZ+KMxnx7
         zp8iPaez04jLGXIJq5VJaLW7XpuddTjBo/9yPWMvzlkmYdRYCVLjoaUAxTROu9zdt4Lv
         VYP3WZqvxm80uCAkqNG1UhWo3rRFFP9eRY2qnanmTHarPp7r1r/neHZRvRtfsfv7BPPo
         3+ib/22AXs9jYPwetua9ah1LQzu9fiBkqDHdJKH8IOuo6AGRQ4quGvpdhWDFIkVzddcp
         iW/eWqT4J5EsDy2dNq6O3V8dAHvh8mEcIjGv4GNUPW6YBjgCu8IlHb8zYFfSt0G8xObA
         DhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kicgBJLt4ABQDEHcioYExmPzV/2uiTpHJkCQCxMA5+w=;
        b=sFWab469rJrQuNbpP5xQyGuKfUTtxt9YVWdqzQgwhp5SWT/Ulqj91TSQM7X6MJ4oUk
         00hUS+NdhLNkh2YpyMnrlbSmN4I8sU/iutIyeJqZ57FuP4HFXlxdzXHR/MV+xYiwqMbs
         jY1tZqd0f2qGpKtBlDS9yFm4IBF6BSjm1d7b0a7XQlNgiea38q3T+AXBHdUBHNyO3x4D
         M8tOowvX3Qfzdg45igrmDJZ0aeJusBjxxtgft217YkeTBa53MXj0Sl1MSnPk5M838r3t
         a5DfR/fEIkPBOBsgugsduFKU4nse5C5kzuIkr8vxfAiSNeNaWSnriMjWUi7UT15gepIm
         AYAw==
X-Gm-Message-State: AOAM531Zmzhxx2AFxSJfajadT/bMFAfFrgUeCoJvcNA1VWVlYjVAtu6E
        JaUnuizHlTizwq3wcNFsBhaW+Ochvb7vfA==
X-Google-Smtp-Source: ABdhPJzKVerjdPmbZbCl0WM5oc6k90ZPn1nFyGsbXUqlbrQgeqPTMjz5ykIpNBpm1ITB9fE835jtTA==
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr291606pjt.198.1608058983682;
        Tue, 15 Dec 2020 11:03:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a26sm25317305pgd.64.2020.12.15.11.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:03:03 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
 <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org>
 <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk>
 <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
 <01be1442-a4d1-6347-f955-3a28a8d253e7@kernel.dk>
 <CAHk-=wgyKDvLhiKfQ1xvBxFkD_+v_SCmMeJvzNJ_maibWH6QRQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e9f9121-68dd-81a1-38b7-8e1b4fd0cf0f@kernel.dk>
Date:   Tue, 15 Dec 2020 12:03:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgyKDvLhiKfQ1xvBxFkD_+v_SCmMeJvzNJ_maibWH6QRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 11:47 AM, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 10:44 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> In usecs again, same test, this time just using io_uring:
>>
>> Cached          5.10-git        5.10-git+LOOKUP_NONBLOCK
>> --------------------------------------------------------
>> 33%             1,014,975       900,474
>> 100%            435,636         151,475
> 
> Ok, that's quite convincing. Thanks,

Just for completeness, here's 89% (tool is pretty basic, closest I can
get to 90%):

Cached          5.10-git        5.10-git+LOOKUP_NONBLOCK
--------------------------------------------------------
89%             545,466		292,937

which is about an 1.8x win, where 100% is a 2.8x win.

And for comparison, doing the same thing with the regular openat2()
system call takes 867,897 usec.

-- 
Jens Axboe

