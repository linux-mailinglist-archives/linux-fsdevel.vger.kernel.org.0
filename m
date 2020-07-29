Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B663123235D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2RaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:30:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FEC061794;
        Wed, 29 Jul 2020 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Qf4hOLrKqti/BrcIwmN2iDHq4yG0O43FA9u3ufNSp0k=; b=MuxK+0p92B5ZlzJuIQLJjB9DmL
        So3A2s7hmsfeI84gIlQa72xri1ADO0LzN1Hk3due0uygnNhWE432G1UOP+fvLTIMBTOmVcNum2nEC
        Z1JZ9ID76JhZRghZDrrJ/OW2NvVpaPMBuVXJ1fcleZ57884XO/zZZe14cwaKA1Hbqm9eUJjwxpxsv
        oKEudhpSPNYuByEMGfoOnRnnr22U0H0h0fRxK924AFTH+WUNI/rBiPvQjt0s+nOBUByytfHrNSWv6
        mlBwYLWJcwviYi4nLrRQIqHMqsqbFswEwETiA8BQbiUS3TNqL1MoN2LYUEN+HZeazVm/gAN7eGs9A
        /r8viR3A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0ptt-0003Q1-Pr; Wed, 29 Jul 2020 17:29:58 +0000
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Jason Wang <jasowang@redhat.com>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <20200729082053.6c2fb654@canb.auug.org.au>
 <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
 <20200729101807-mutt-send-email-mst@kernel.org>
 <e7173f3b-6e30-03ce-74ef-291236917da3@redhat.com>
 <8271d9b6-431a-c8da-8591-4023ab6c8963@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <731f96d9-c780-5c5d-e338-e647b71fc677@infradead.org>
Date:   Wed, 29 Jul 2020 10:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8271d9b6-431a-c8da-8591-4023ab6c8963@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/20 9:14 AM, David Hildenbrand wrote:
> On 29.07.20 16:38, David Hildenbrand wrote:
>> On 29.07.20 16:18, Michael S. Tsirkin wrote:
>>> On Tue, Jul 28, 2020 at 03:31:43PM -0700, Andrew Morton wrote:
>>>> On Wed, 29 Jul 2020 08:20:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>
>>>>> Hi Andrew,
>>>>>
>>>>> On Tue, 28 Jul 2020 14:55:53 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>> config CONTIG_ALLOC
>>>>>>         def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
>>>>>>
>>>>>> says this is an improper combination.  And `make oldconfig' fixes it up.
>>>>>>
>>>>>> What's happening here?
>>>>>
>>>>> CONFIG_VIRTIO_MEM selects CONFIG_CONTIG_ALLOC ...
>>>>
>>>> Argh, select strikes again.
>>>>
>>>> So I guess VIRTIO_MEM should also select COMPACTION?
>>>
>>> +Cc the maintainer.
>>>
>>
>> We had select CONFIG_CONTIG_ALLOC before and that seemed to be wrong. I
>> was told select might be the wrong approach.
>>
>> We want memory isolation and contig_alloc with virtio-mem (which depends
>> on memory hot(un)plug). What would be the right way to achieve this?
>>
> 
> Okay, I think I am confused. I thought we had that already fixed. @mst
> what happened to
> 
> https://lkml.kernel.org/r/d03c88ea-200d-54ab-d7f3-f3e5b7a0a9dd@redhat.com
> 
> That patch is almost a month old, can you pick it, I already acked it.

That patch works for me.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy
