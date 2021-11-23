Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1F459D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKWIN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:13:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:53915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhKWIN6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637655041;
        bh=EzH8SWgZyUqFLFn5zr0sLSZytj5dw3+p+P/oDHcnTdg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fg14ypbqjUynUdJYlI22vh2TBB1iSMGjEUaavrkZkVJEcbxEoMmFtWNtIQlHYPrIc
         sF3G4YEfoW2+95T0vk2un6L8LGihaIXue6FjxDg82fMFYNB7tkJ4NYBMRpQx8wkymg
         TUnzZe4ZaXN3F76iKELRctdmou6XBGhv3Pk+3NaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsUC-1myCJL3dNA-008ux0; Tue, 23
 Nov 2021 09:10:40 +0100
Message-ID: <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
Date:   Tue, 23 Nov 2021 16:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YZybvlheyLGAadFF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rg/Rm168QvJOdNz5YKh5ZCVWWVBPRkDbZagTO5jwh/m3LDnxxUb
 d8aqhhXb6IAlm5fjBku/tmMeT7iz1fjPcyDV8SESHD2Qlhmo3nr1Nhrkndsxg29ET4gP9nE
 HgxE3eMMF01+Ep0+mCExLAovOCM9Xthd+6fjGroiER2b4GmaXIEOUHNhDUbrmIHzYaH6j7M
 JJB+JfBLhWOEC4sxfeGqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vCwmNzWg38U=:CIYVsCzfFx+PcCSDC2vePp
 cIRTZqy/9bv7ZkemI3pmqx5vqlNDuLQJ/Tc9jUS37D5lGKWzMOSaqKb6HNLwmR5idBoihlWhe
 /P0LdNJPSi70T0dH5ItAkRD5SD8cjiUQQeggfshAED9BTWBn5EY+UCHXEKVwwkjIfPDn9NhEk
 vwbqmgt5lWQ8AQ+Jd7sclamVHlRvPvCU6zBWA3D+i+d/GSUyPNKpN+Mg2Y4ACkoP/ADsT0K6Q
 0/wOTwGF5wzM75dmxsOHre8j95oSJuNOfRyeYJeaXb9mp0FFXRQ9tySeh8UOfwp8wE64mJ75q
 zz2oWXqDoT+dYVEdGC9gOJDXjaRLBMDy/QIhtOPOZaYhPFukvR9On7nsqWES+fsZc00IfiqVC
 G5aPFowHzFiLFpbcu7YQIjYC4LrUDhO9Aqy0udyV9s/P64Gzyxa1Di/I6xwnW9eBT+3nB+iNi
 siePKgVbnn6htlk48z4uOS3ctTyUkOptdkUpiRa+hesnPlO1KkMCc1sNprzdc7dc9amEnD4Xf
 JIR11cOR1Y+vv8EsfqriCRBsyPj9CxRukNlr4SWWul5ByO4uchlmIXYhcNzt52J3Kb3nL0mLi
 m/GGW3iYLBL9xaGJPgv6/bPP+Gyc5PUHDI77kcRGungP9p/naMVoEw/tkR16MhiDT3Fn4E9A1
 ryzfhgl01JRy0EPM0qqa6TZQ8fmwrIMMaRBCHNXLJiayUkOO0ImJdCxBcbjvUoyB8mspBRvUE
 41zfrdsC4oRlGOOIJP8vPKpXKFwY8capVWk9ijWpCRxRHPXQi/A3aeEypvaRAWvBSYAldlFdH
 tvjgbF9YJV5xsxMY/+YjRl0+RGkPP0T6f/1iWpSnnXv6SLk7vpJpoHwM1vXhFYR82G5V3XUn2
 yVolQCQEQHIhk7xeGjyoDr/Oyj7G90IqZrxxqTkpEDwcSab8RZ9EA5vXW8zv+LM42RlRzZwgZ
 duZyiY6nf7tpqn9YUJ56gsmFM1E+/TM9IF/Lt+MvqA+ID/f2pI9SlD9uA4pWKFw7oyxf4bsOd
 PlW1lOxCOZ0W/0zGsnGVf6e/nBXLtKA0v1AOtVhq0RhDnF9kiiEvCjfczXLwed45b2AP58l9F
 wFQguHf9cCs+pI=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/23 15:43, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 02:44:32PM +0800, Qu Wenruo wrote:
>> Hi,
>>
>> Although there are some out-of-date comments mentions other
>> bio_clone_*() variants, but there isn't really any other bio clone
>> variants other than __bio_clone_fast(), which shares bi_io_vec with the
>> source bio.
>>
>> This limits means we can't free the source bio before the cloned one.
>>
>> Is there any bio_clone variant which do a deep clone, including bi_io_v=
ec?
>
> There is no use case for that, unless the actual data changes like in
> the bounce buffering code.
>
>> That's why the bio_clone thing is involved, there is still some corner
>> cases that we don't want to fail the whole large bio if there is only
>> one stripe failed (mostly for read bio, that we want to salvage as much
>> data as possible)
>>
>> Thus regular bio_split() + bio_chain() solution is not that good here.
>>
>> Any idea why no such bio_clone_slow() or bio_split_slow() provided in
>> block layer?
>>
>> Or really bio_split() + bio_chain() is the only recommended solution?
>
> You can use bio_split witout bio_chain.  You just need your own
> bi_end_io handler that first performs the action you want and then
> contains code equivalent to __bio_chain_endio.  As a bonus you can
> pint bi_private to whatever you want, it does not have to be the parent
> bio, just something that allows you to find it.
>
Without bio_chain() sounds pretty good, as we can still utilize
bi_end_io and bi_private.

But this also means, we're now responsible not to release the source bio
since it has the real bi_io_vec.

Let me explore this and hopefully to align btrfs with dm/md code more.

Thanks,
Qu
