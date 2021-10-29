Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91023440315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2T1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJ2T1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:27:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE51C061570;
        Fri, 29 Oct 2021 12:25:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v17so18005058wrv.9;
        Fri, 29 Oct 2021 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tvo7OsKnZiYhW/CIzL+toK1Ob0iQFZhcf7j3OyPg3VI=;
        b=GfrBZJ5iIL2QX+F3UY0p1FFnKImW3UfN7kqg/dcOvO4f8lWc2w7qiWoPuGR2YeBRhR
         mF7VjPK+mwaulVbIioBdngv17VHlkQ7XuoQQStaDRen0Aa8gM0FBI8Tlxt0Pg+YL4UIs
         bozizwsms5KMPr3ZZYUfTnAG8FMfSBQdxr7z5OnwF1CkzBihDZel1yjELtS9eZgSMC6B
         T2qKwPfCNz9g8VzTQhK9BPS4FCar+DNfqOGds8bW2mDy5IIWIk2QmgJS/csc5LgXdg5w
         S9ve7qcjIR8BPp48lZAi7/MBoeG+ZkutgW0OyDmAMfhJxmsYtIXUFl8s+WA01RaMnNjr
         pNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tvo7OsKnZiYhW/CIzL+toK1Ob0iQFZhcf7j3OyPg3VI=;
        b=w02xQyjsB+QsB6dVCo/DuojCInnbh/z5NAh9ZgZJ3VLH6n4YoQli5M/8PLngjqHnwN
         5tDJSh56/o3CbxaYZfmngYNQS5Me9YwFfQdSie1A2+jdoitsbmcL2MBMIqWgna9v9vd2
         SeZiIpzN6huphuxB0uuok6XDm/RzKLYuRAZQ0oVzjl2crD8C7j+ObfAdGJNC8iZeLwrZ
         8yiI6vpAiXrFxau+X24maBMtdnqLhDTlQddx9w8zFJtt5fj5CfMghZ/8P2qzN1mTDcrK
         y8IlULHBkJhz9Kd4AWpX4z8gawkyaTu/D2zrvVcfMkPHAm2hoKW832rpuhB+qiv2Z3Sp
         v2zg==
X-Gm-Message-State: AOAM532/x+9vyyeXV5b4oZ0t1IpLaiaZANurEIYVfUEkFtSqwUv2dVbJ
        cbZ/W9JlaJp/ThmOA9G7wJBHKBKS5/OXHQ==
X-Google-Smtp-Source: ABdhPJwJT6TiYb3/JIfjJ6JLlOKjZCQT2hYhBeN/ZIZiycBjCWzDjHwZ0BUCh015OF6O6jcWdT+TvA==
X-Received: by 2002:a5d:6da7:: with SMTP id u7mr16031755wrs.322.1635535499887;
        Fri, 29 Oct 2021 12:24:59 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.129.16])
        by smtp.gmail.com with ESMTPSA id j20sm5407595wmp.27.2021.10.29.12.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 12:24:59 -0700 (PDT)
Message-ID: <f3e14569-a399-f6da-fd3e-993b579eaf74@gmail.com>
Date:   Fri, 29 Oct 2021 20:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA
 flag
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
 <20211029165747.GC2237511@magnolia>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20211029165747.GC2237511@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/29/21 17:57, Darrick J. Wong wrote:
> On Fri, Oct 29, 2021 at 12:46:14PM +0100, Pavel Begunkov wrote:
>> On 10/28/21 23:59, Dave Chinner wrote:
>> [...]
>>>>> Well, my point is doing recovery from bit errors is by definition not
>>>>> the fast path.  Which is why I'd rather keep it away from the pmem
>>>>> read/write fast path, which also happens to be the (much more important)
>>>>> non-pmem read/write path.
>>>>
>>>> The trouble is, we really /do/ want to be able to (re)write the failed
>>>> area, and we probably want to try to read whatever we can.  Those are
>>>> reads and writes, not {pre,f}allocation activities.  This is where Dave
>>>> and I arrived at a month ago.
>>>>
>>>> Unless you'd be ok with a second IO path for recovery where we're
>>>> allowed to be slow?  That would probably have the same user interface
>>>> flag, just a different path into the pmem driver.
>>>
>>> I just don't see how 4 single line branches to propage RWF_RECOVERY
>>> down to the hardware is in any way an imposition on the fast path.
>>> It's no different for passing RWF_HIPRI down to the hardware *in the
>>> fast path* so that the IO runs the hardware in polling mode because
>>> it's faster for some hardware.
>>
>> Not particularly about this flag, but it is expensive. Surely looks
>> cheap when it's just one feature, but there are dozens of them with
>> limited applicability, default config kernels are already sluggish
>> when it comes to really fast devices and it's not getting better.
>> Also, pretty often every of them will add a bunch of extra checks
>> to fix something of whatever it would be.
> 
> So we can't have data recovery because moving fast the only goal?

That's not what was said and you missed the point, which was in
the rest of the message.

> 
> That's so meta.
> 
> --D
> 
>> So let's add a bit of pragmatism to the picture, if there is just one
>> user of a feature but it adds overhead for millions of machines that
>> won't ever use it, it's expensive.
>>
>> This one doesn't spill yet into paths I care about, but in general
>> it'd be great if we start thinking more about such stuff instead of
>> throwing yet another if into the path, e.g. by shifting the overhead
>> from linear to a constant for cases that don't use it, for instance
>> with callbacks or bit masks.
>>
>>> IOWs, saying that we shouldn't implement RWF_RECOVERY because it
>>> adds a handful of branches 	 the fast path is like saying that we
>>> shouldn't implement RWF_HIPRI because it slows down the fast path
>>> for non-polled IO....
>>>
>>> Just factor the actual recovery operations out into a separate
>>> function like:
>>
>> -- 
>> Pavel Begunkov

-- 
Pavel Begunkov
