Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0345B5AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 08:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhKXHm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:42:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:36145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhKXHm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637739578;
        bh=OUcfVT+7GdgH3jfVAk+MtD927iJsLIYpHGzdDaslNQo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=aWhXkjHQQRlFVsYcglK2cZEgY37dWTUHRMSRamzgQJ/G4vUoy3U2vhMq7akEecHAr
         +SzdLyKtSAP0BUyml+mG2f5wGLQIEAlKbXVJDW3gAzhdQjji3cJttdkB0nhHh9ZOyY
         lcBSvmCDUd7Y2GeyI6DXXMRCff8AH4xaM10k1Pg0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JqV-1mpVtY1alN-000OyQ; Wed, 24
 Nov 2021 08:39:38 +0100
Message-ID: <60ecb6a2-da19-6876-8c43-42011b4e374d@gmx.com>
Date:   Wed, 24 Nov 2021 15:39:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
 <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
 <20211124072533.tleak7xavj3tqxly@naota-xeon>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
In-Reply-To: <20211124072533.tleak7xavj3tqxly@naota-xeon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NgpZeP8KvC3VenFhqM7eEmUrzBFdXC23+SMhYpRI9j3GdNb72WZ
 bLn0Yb0+EI/SEEscvpMcvbievmzSZ5FPICNRYeKG9f/ZB+MACVPgUMYDM0IcLjRAOnzic0n
 /6Ip/mqoQbDUUTNzlyj4auPW4Ec1WOGG1p1qx6U/0BA2lhI+QAisEQ3x0gWy7Hd/NBhe1k0
 +NQ0nNrgE5BR01I8cu8JA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dnNVMEhUHSA=:/jsYaBkS6kH5uU3jUFArc/
 PvLJy1ZvRmbnZjrvdGTTq/kSVoUSTzZI5bqTf6JpAIM/MKay148fpfiPZtrG6c8wnhKf75fGB
 nvcqCoCQyh/HPjKHawN91Sb1GSpc+jITWvYCx1EZRQx+Gc8ujA2HIhmx9mVVPMrRmoaIw/lig
 bzLVoqaQJca5DdROJFFkd0oqqv6cxrngX+Mm+o54sDD8SJ6BrLMWurjc6buE2KwTCoA5BzEdY
 GwMbLn5KVZLMTcBvV2rtkxFmCUMKzlvzjpP3Z84h/ZvgNd/6Z98qRoVuIJCSVCQc1OUdgB3Sv
 n/rnS+WM0gN9t3rKNgZ7ftHJMUwXjweHXJ4cRRJ+eY7bJyl84QX+M/587lDlkvjWUwJ6dQzW9
 Xef6oIN3aGozyMHcOrvRwTAMOSM1S3Ij2BF29IR3gDWtLluhDnxRU7d6CiAbzrAHG9HQK/bQQ
 96RXdKYkRnndgS4e8rvmxU5CrDF3kfsHL+DZZyjqST/7znncTv1K7WXhEfnBx9S+F8DBci65z
 1dXcefG0XXbeJK36ql/7cvD7oFB7yoTesKK3Auzhi/RXQrhPXYtUU4qeqCP9zVgWY7npB9SO/
 fQOIkGx/wt90hMMXHBsOLnpKv4/Ziz5ew0EHLEC2gpzZv8mlVeZKmZJ6XTV88pBFGLtOr/bKZ
 fzYX30iSrzaXgux9exSBSb+IwigXhIL56s3RFZm6aCb7cK6mNZa6MPD3vk70LryRIMVlVtaDO
 p08J1jJcnW1w8f8YMohew8UhrHUYBEJVRzhBWAxewYj4cvxjerHCenmzTIq8QEHyks9X9IvYy
 xPHJZ3Ss1/2rgNsEXKMrcgEh/BWCR19V1hXnUHvP0Lqf9z99KR2zH4+ZRT8eKrviyjwHIjw+i
 l37Mi9A8wikc+naCxEqfILOfyYCp60haIqVjIWZN/2shuoTLfcYdTLFBBiZh9rxyxBv8hohRU
 PL/6yFnagalLsltcBq4rpd5V4axyeO14zdVeE35r7viK9yQYWNU690Hc5BXlnt42mGGRSyd+a
 Ee4zi6Qo/ykFT5VmAKwVFuhq2JFSMLieLxNjXDKvSjY/S6cqgJ4QzFxskBRRk8dIXa9HCpgPc
 4UVx7ZQ7xbBnaE=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/24 15:25, Naohiro Aota wrote:
> On Wed, Nov 24, 2021 at 07:07:18AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/23 22:28, hch@infradead.org wrote:
>>> On Tue, Nov 23, 2021 at 11:39:11AM +0000, Johannes Thumshirn wrote:
>>>> I think we have to differentiate two cases here:
>>>> A "regular" REQ_OP_ZONE_APPEND bio and a RAID stripe REQ_OP_ZONE_APPE=
ND
>>>> bio. The 1st one (i.e. the regular REQ_OP_ZONE_APPEND bio) can't be s=
plit
>>>> because we cannot guarantee the order the device writes the data to d=
isk.
>>
>> That's correct.
>>
>> But if we want to move all bio split into chunk layer, we want a initia=
l
>> bio without any limitation, and then using that bio to create real
>> REQ_OP_ZONE_APPEND bios with proper size limitations.
>>
>>>> For the RAID stripe bio we can split it into the two (or more) parts =
that
>>>> will end up on _different_ devices. All we need to do is a) ensure it
>>>> doesn't cross the device's zone append limit and b) clamp all
>>>> bi_iter.bi_sector down to the start of the target zone, a.k.a stickin=
g to
>>>> the rules of REQ_OP_ZONE_APPEND.
>>>
>>> Exactly.  A stacking driver must never split a REQ_OP_ZONE_APPEND bio.
>>> But the file system itself can of course split it as long as each spli=
t
>>> off bio has it's own bi_end_io handler to record where it has been
>>> written to.
>>>
>>
>> This makes me wonder, can we really forget the zone thing for the
>> initial bio so we just create a plain bio without any special
>> limitation, and let every split condition be handled in the lower layer=
?
>>
>> Including raid stripe boundary, zone limitations etc.
>
> What really matters is to ensure the "one bio (for real zoned device)
> =3D=3D one ordered extent" rule. When a device rewrites ZONE_APPEND bio'=
s
> sector address, we rewrite the ordered extent's logical address
> accordingly in the end_io process. For ensuring the rewriting works,
> one extent must be composed with one contiguous bio.
>
> So, if we can split an ordered extent at the bio splitting process,
> that will be fine. Or, it is also fine if we can split an ordered
> extent at end_bio process. But, I think it is difficult because
> someone can be already waiting for the ordered extent, and splitting
> it at that point will break some assumptions in the code.

OK, I see the problem now.

It's extract_ordered_extent() relying on the zoned append bio to split
the ordered extents.

Not the opposite, thus it will be still more complex than I thought to
split bio in chunk layer.

I'll leave the zoned part untouched for now until I have a better solution=
.

Thanks,
Qu
>
>> (yeah, it's still not pure stacking driver, but it's more
>> stacking-driver like).
>>
>> In that case, the missing piece seems to be a way to convert a splitted
>> plain bio into a REQ_OP_ZONE_APPEND bio.
>>
>> Can this be done without slow bvec copying?
>>
>> Thanks,
>> Qu
