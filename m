Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE732DB497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 20:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgLOTjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 14:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLOTjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:39:42 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73571C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:39:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so15936971pga.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ny+6VHr3rCVkpRDtspTdbnm/DIlwsYB9DGmVDQKkiY=;
        b=1hB1o2Z19fihn5NqJHuE+yw/dzRaNVHYlrCInQwWSUeOZ+Os8UpOp7VEGWF2gA1wcJ
         DSNCYQlkwyccSvbI38r3UZ7e//NPjphzONc/IebYHC/1NcsUX/C6qq8KSxyTTjJaDrAK
         tAUhgwvpkhy2ZlYzdPg9IYsE0eR4nA2+aNJ6lM88irZwXAcWkDsSxLh+fUuyeC0s5PZs
         daersR1D4mKP2cWWiG3zELNuG1NdXKja3X0acePAm7ySEZM0vqKYrlwJbdxDZBR/Xn/0
         xhc4qNRi68njocAUZIhYiWCTZgRqwd1hIy3dOsrRuTSBxdnxA7EuppZ2wh0+SxspieVy
         Eiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ny+6VHr3rCVkpRDtspTdbnm/DIlwsYB9DGmVDQKkiY=;
        b=Wm0arPoN4tfR5QWKH5mtF6jmxCN7ruF1BlkSf0qj+NOLlMYX5rc1VqPzxf2ZWU+Bc3
         n80IWtAvuu3kHgjtStr4QGg1564dH5YWpmo5nxG9gJl3s4fG5hv0bqOB2KICG6QslOAL
         0BnikBMTS+ZkF5NGHXr8y0G1aF3plyOVyLKv3UtfJwzxz8D1yHsiABIVCjssRVk7tCX1
         zU3tHO1xHS880svHiz0GfJEqiyRNrtcGtQexJFsHJIGrqy6+RtE8bqms6pyTXSkDUmx8
         i2nxCRV5/KxaW7tkgfP7JVzUXQ8OazXjjzW8VLU4LbheqBwU8kxwgR+/l+RDICAoakox
         zDmA==
X-Gm-Message-State: AOAM532iHMxL+9dzmoiXrFH8nwaoKHBNBtEuM5no6xt44JsHvHvDZ2kF
        gKzfqGIG/1V0ZMwJcht0AzpTbX+ftBsbpA==
X-Google-Smtp-Source: ABdhPJw0DgDP5Q1Hz7kbSmIegj6LPSYS/55F6t7efwvGBC2xgOWYnUYQSudYsucnnBk9CfRU5T7Tdw==
X-Received: by 2002:a62:17d0:0:b029:19e:5cf9:a7f6 with SMTP id 199-20020a6217d00000b029019e5cf9a7f6mr30219999pfx.0.1608061141900;
        Tue, 15 Dec 2020 11:39:01 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x23sm9571391pge.47.2020.12.15.11.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:39:01 -0800 (PST)
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
 <5e9f9121-68dd-81a1-38b7-8e1b4fd0cf0f@kernel.dk>
 <CAHk-=wgdcShySTmDbpwDiDQvDifLNN9XPjqw7BPij0YT4-z6sw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67388bd9-755f-6ca6-0805-fb9e5ea1ff5a@kernel.dk>
Date:   Tue, 15 Dec 2020 12:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgdcShySTmDbpwDiDQvDifLNN9XPjqw7BPij0YT4-z6sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 12:32 PM, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> And for comparison, doing the same thing with the regular openat2()
>> system call takes 867,897 usec.
> 
> Well, you could always thread it. That's what git does for its
> 'stat()' loop for 'git diff' and friends (the whole "check that the
> index is up-to-date with all the files in the working tree" is
> basically just a lot of lstat() calls).

Sure, but imho the whole point of LOOKUP_NONBLOCK + io_uring is that you
don't have to worry about (or deal with) threading. As the offload
numbers prove, offloading when you don't have to is always going to be a
big loss. I like the model where the fast path is just done the right
way, and the slow path is handled automatically, a whole lot more than
chunking it off like that.

Granted that's less of an issue if the workload is "stat this crap ton
of files", it's more difficult when you're doing it in a more piecemeal
fashion as needed.

Actually been on my list to use io_uring stat with git, but needed to
get the LOOKUP_NONBLOCK done first...

-- 
Jens Axboe

