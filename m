Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9EBF2E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIZMYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:24:45 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34751 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZMYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:24:44 -0400
Received: by mail-ed1-f44.google.com with SMTP id p10so1822815edq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQ67hGY/AbvosKPF2PuZidEVo/xhx2hsF6M+eM2YXEc=;
        b=uoddVmWoWrK0UcBSC00q9KT4+3OR6PDaTDkyXZiX+ZFAUmhTanen3M05SJzIe7w9ns
         pr2GTnf7m3/GUncoyb9iyZNjwODOEqTA4GFyHx9U/YK3AeW9kxbb2KPNm/RhPv6eprK/
         7ckWTfziAljDWTnBXBqnLQcFIxh3X7zt9kQVsarqIYYCLtcN1T1Edqg5zQ/5Nodc3qTQ
         FMiLV10Ifct9Hrov8lWxWq1JsKcEJfo5kZ6NaDjTG4sLMczSh9PFMC2vxfLCJ+Woqsgk
         13V+CEveJQ+rJrNZQTDaunCOpDLMg/UNRxhzE10d2kabWZToBhHWmAe0o7+At4rCM0R6
         c/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQ67hGY/AbvosKPF2PuZidEVo/xhx2hsF6M+eM2YXEc=;
        b=ljNDjYoWLw6mULTyFktsBR72wJibAgp1a+fnJ42f0SL/nMjKC9NWlJw6YcmiZHpSVW
         JYTp2CG2bPnl/1q7iFlkt+9KgOBQfaQNS4VOfI37R5dwaQ5h8KwyB7IZtObZ3pBW4Q3x
         7BgtOsYPHWUV/uIXbGtAhKpuWvlWAY7XOVuVWzqlxY5yS9ExlEvFzV86zQqLZxwNltFn
         fQGP2WCwoGwTJpEhofYMsMnwCQ9VnHkaNW87WYmguU0J+MyKUUsVQr20EewDNxWBDrSs
         VErNj8nHcPgUAXTEvasITEmjd1IOf9fGf+odtHuIQAA3jbtMnx7If75quwNqzaSTQTR0
         OohQ==
X-Gm-Message-State: APjAAAXWYx6loiJ0PRC+mQApfbZPF3ZGA+j+FhCxMp1nzjaPuoaRIkFa
        9QwDvLrw2sQhFf/hyYjggpM=
X-Google-Smtp-Source: APXvYqyFH56ptKXk1SUSA915HmQre+ngFJ+FfXX9jONV26QimsyNYR2nJfdPfPaMYwjpNkWbbYfIEA==
X-Received: by 2002:a17:906:3746:: with SMTP id e6mr2751013ejc.238.1569500683275;
        Thu, 26 Sep 2019 05:24:43 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id f36sm447010ede.28.2019.09.26.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:24:42 -0700 (PDT)
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
 <0bb90477-e0b5-650b-d8c0-fb44723691a4@gmail.com>
 <91c22d2d-15fd-393d-dee2-8e74bdd8833a@fastmail.fm>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <8280e517-1077-14f7-ff84-4597e78a327c@gmail.com>
Date:   Thu, 26 Sep 2019 15:24:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <91c22d2d-15fd-393d-dee2-8e74bdd8833a@fastmail.fm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/09/2019 15:12, Bernd Schubert wrote:
>>> Are you interested in comparing zufs with the scalable fuse prototype?
>>>  If so, I'll push the code into a public repo with some instructions,
>>>
>>
>> Yes please do send it. I will give it a good run.
>> What fuseFS do you use in usermode?
> 
> For the start passthrough should do, modified to skip all data. 

skip all data is not good for me. Because it hides away the page-faults
and the actual memory bandwith. But what I do is either memcpy
a single preallocated block to all blocks in the IO and/or set
in a defined pattern where each ulong in the file contains its
offset as data. This gives me true results.

> That is
> what I am doing to measure fuse bandwidth. It also shouldn't be too
> difficult to add an in-mem tree for dentries and inodes, to be able to
> measure without tmpfs overhead.
> 
Thanks that is very helpful I will use this
Boaz

> 
> Bernd
> 
