Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0F20D2D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgF2Sww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgF2Swt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA215C030786;
        Mon, 29 Jun 2020 08:17:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so8025849pfn.10;
        Mon, 29 Jun 2020 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TU7zddstzXSdEQt8ggnNes9FhafN4Jm/qpc0MfddreY=;
        b=Mv6+Mv4V8pXDsuO8tCDoMsogn5FHDI2gsE5SudznI3835V3CdCL5t1oOXRUKxRaljg
         sEti6Lr9GSm4sT48Sn5LyLLf2uyhU/qKPMRK7B2QZCGCPEHQQNlMpZv0chqVqF5PE/c/
         iupQ0Opq5Zxbt2qssM5FTNraMN2HLXfRO+oZSu76vsXcyBckOdUaFkm7ktrzN7WV/T5D
         neWbPrtdHZJNStUf6rQ7rV1FR22okzOgnZUKMXGi9l/m6hs8B+7nPcf2+FtWqT/7Cwo7
         hdyatnogxk3d0AHr6me/Rux3yYkM4SGsGIq2VmzJjzyTDxZgTK6NZf67W6TdpS7q5a9q
         uLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TU7zddstzXSdEQt8ggnNes9FhafN4Jm/qpc0MfddreY=;
        b=nzf4Z5tXDWL8Fwl8b4BAveY+LMjtGkwTU2CBaaEYziEwSj64hcPTkmV/eQ1YXH2b25
         Al8wJ9xHO4o1ZBd1siPKjWsPX2+9lrog9f/frHRxPyWaMhNh3LsT94KksczccnN0zOnf
         QtMa58e+23pwzrgQGEUDbPrny7X8H801O9C1bBLP/khebZ2rtoFTYpW+eCSfs8G9wanP
         owjgEFT1Im+qFqWPOAxWlk02TCUhcQTOTo687KVWiUdnLiiW9yJ6HQFYIpSRhrTTxy1v
         Bb/k9HLv0QCQ5CZjFGNV7Q8OX9qh2udRR02XilKA3Zntx1D6JEy1CD1t3ijJTZfvA/up
         lFbg==
X-Gm-Message-State: AOAM5317o7ZESMgzaT9C0NXQs9S7CqyumYa7YcCSVH2hxZb8mWrSayQh
        BsyrDvrD5JKQaVLBpjF7vFBbwGMa
X-Google-Smtp-Source: ABdhPJz2SUh6ahpjpvVkNhb/b1g+16pcvO6+VvMBABgW1cnqlbi4kKBjyoohrgfDksY0CpDhjy2Btg==
X-Received: by 2002:a62:382:: with SMTP id 124mr14980547pfd.190.1593443825038;
        Mon, 29 Jun 2020 08:17:05 -0700 (PDT)
Received: from [10.1.10.11] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id s1sm264930pjp.14.2020.06.29.08.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:17:04 -0700 (PDT)
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200615121358.GF3183@techsingularity.net>
 <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
 <20200616074701.GA20086@quack2.suse.cz>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4f6c8dab-4b54-d523-8636-2b01c03d14d3@gmail.com>
Date:   Mon, 29 Jun 2020 08:17:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200616074701.GA20086@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/16/20 12:47 AM, Jan Kara wrote:
> On Mon 15-06-20 19:26:38, Amir Goldstein wrote:
>>> This patch changes alloc_file_pseudo() to always opt out of fsnotify by
>>> setting FMODE_NONOTIFY flag so that no check is made for fsnotify watchers
>>> on pseudo files. This should be safe as the underlying helper for the
>>> dentry is d_alloc_pseudo which explicitly states that no lookups are ever
>>> performed meaning that fanotify should have nothing useful to attach to.
>>>
>>> The test motivating this was "perf bench sched messaging --pipe". On
>>> a single-socket machine using threads the difference of the patch was
>>> as follows.
>>>
>>>                               5.7.0                  5.7.0
>>>                             vanilla        nofsnotify-v1r1
>>> Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
>>> Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
>>> Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
>>> Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
>>> Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
>>> Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
>>> Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
>>> Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
>>> Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)
>>>
>>> The difference is small but in some cases it's outside the noise so
>>> while marginal, there is still some small benefit to ignoring fsnotify
>>> for files allocated via alloc_file_pseudo in some cases.
>>>
>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks for the patch Mel and for review Amir! I've added the patch to my
> tree with small amendments to the changelog.
> 
> 								Honza
> 

Note this patch broke some user programs (one instance being packetdrill)

Typical legacy packetdrill script has :

// Create a socket and set it to non-blocking.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
   +0 fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0


But after this change, fcntl(3, F_GETFL) returns 0x4000002 

FMODE_NONOTIFY was not meant to be visible to user space. (otherwise
there would be a O_NONOTIFY) ?






