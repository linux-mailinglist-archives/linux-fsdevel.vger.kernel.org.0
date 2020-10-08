Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3928777F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgJHPc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbgJHPcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:32:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D622C0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 08:32:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g7so6526370iov.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RC21x8JZDkbxUW+NogUGgAglDCBQivF7vvLZcU4XCBk=;
        b=M+5QTSp4CppIsGYmXJM01fIlKfkO1PhhP+/at6Q9om+pM0zmeOaMVxE3Y/Jf6ituGZ
         3LQOUV47FOwo+eA8+9zheIh/pmjWQz3FN8nCKURkvlAKyXHZYVpdP90X+uIR9UU2dmzU
         8Nvq6PWO3wnANHsWDMNb5QHJG1S/anDkZsrOkj7751wJ8XNFKk3puP1FpALM9kAt5K7e
         CIC9ruCn0STDjjhlZOT9THMAZtvjgoj2FvX2/aOdrPF7UfZRWpYKxg/Z6b/QmaSpXwkq
         A7ABcVIqt/k66+g43JO/JIKkglc9nvDFyQqqBnzGhHVGl3IqZr5yoIIGY6azoNDGSPLd
         MWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RC21x8JZDkbxUW+NogUGgAglDCBQivF7vvLZcU4XCBk=;
        b=t9sr4sCC1c+NfCi596m20vArLEd/v7psqTkcBRSVFZuKqaQECb9e+2RdvMrkVW1yHP
         S30ZjyRXa6b1Nj+JibMw56VwWnNZ3eYYlXRdxGUEcAgV7lWczH8kwuxdE+BMDl5VmsTd
         wvMz7TYFH1c3I/aqX/1nOsRIC6WJOg6dGQ+73EIeG6c+L0jEhv556JZwKWRdcwu8Rlvr
         uIU4rSc5aXMMyPbuy5TeV/9fJNro3SpQjzIod7ZtEUlVR3STJSJR5/UmvlJwTG22KHvi
         5AT5Tak4r/jvIDup44RXOJwDMbAuCm12YOuEhrYPuXq97/5PYnopZZOeIc+bfMmOcBdY
         QfGQ==
X-Gm-Message-State: AOAM533mKXX/959yLsQuIZtPKRe95IN9FkPaMOFD5G+bI9HAX/qIsRsl
        sZW85XRSj9yGXOck8Ap6F7Dtaw==
X-Google-Smtp-Source: ABdhPJyIMUBKswLqP41gFCa4J4UqBSjcxDgc7d8MFdW0VAjCMs/+fIVyLqoy5VnjY3nzBTjGxVmAfg==
X-Received: by 2002:a02:6a49:: with SMTP id m9mr7169735jaf.43.1602171127855;
        Thu, 08 Oct 2020 08:32:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q16sm2779202ilj.71.2020.10.08.08.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 08:32:07 -0700 (PDT)
Subject: Re: inconsistent lock state in xa_destroy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000045ac4605b12a1720@google.com>
 <de842e7f-fa50-193b-b1d7-c573e515ef8b@kernel.dk>
 <20201008150518.GG20115@casper.infradead.org>
 <ecfb657e-91fe-5e53-20b7-63e9e6105986@kernel.dk>
 <20201008152844.GI20115@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <774b6b47-7c19-f2e9-588d-0f6bb363a2d7@kernel.dk>
Date:   Thu, 8 Oct 2020 09:32:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008152844.GI20115@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 9:28 AM, Matthew Wilcox wrote:
> On Thu, Oct 08, 2020 at 09:06:56AM -0600, Jens Axboe wrote:
>> On 10/8/20 9:05 AM, Matthew Wilcox wrote:
>>> On Thu, Oct 08, 2020 at 09:01:57AM -0600, Jens Axboe wrote:
>>>> On 10/8/20 9:00 AM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    e4fb79c7 Add linux-next specific files for 20201008
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12555227900000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=568d41fe4341ed0f
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=cdcbdc0bd42e559b52b9
>>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>>>>
>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com
>>>>
>>>> Already pushed out a fix for this, it's really an xarray issue where it just
>>>> assumes that destroy can irq grab the lock.
>>>
>>> ... nice of you to report the issue to the XArray maintainer.
>>
>> This is from not even 12h ago, 10h of which I was offline. It wasn't on
>> the top of my list of priority items to tackle this morning, but it
>> is/was on the list.
> 
> How's this?

Looks like that'll do the trick in avoiding similar future lockdep
splats for xa_destroy().

-- 
Jens Axboe

