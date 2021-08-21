Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836D93F37E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhHUBMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 21:12:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:55623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHUBMW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 21:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629508297;
        bh=rsF/9Y1W4s1enmJfcUq4mHsHRWaNu+mxRl2OdfIvAgA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=g793vqVgDJaWziIvPveR3zO42yA25TL4ZoStHPtjuGCPiV/EtCjx0ylNALT8fgUUC
         tD4nB5Q3TBJJB774AV0M758IkZUb5dLjLd7iFitlE+8eOO3OSewA/Yh3I6lvnbvbJ3
         /tyJVXanAE1Er6advmrfEm1X7GSSqBcUPYO5AeyE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1mWbcL1syW-00X57a; Sat, 21
 Aug 2021 03:11:37 +0200
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
 <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
 <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
 <YR/wQPJcv25vPIp7@relinquished.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
Message-ID: <d7e302f9-7230-0065-c908-86c10d77d738@gmx.com>
Date:   Sat, 21 Aug 2021 09:11:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR/wQPJcv25vPIp7@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tzl6/9YY2KjiUvi9znImUVGUZC+JDucaRnNpDPUYlX0PtGesSmH
 gM1lE6SiNcGQPuCHr7cJ01lxfUMsApgYpSxwk97dXKu+hS0B/zCHPoM0Lp6ntuwtJf0M7Ix
 C0KMwRj668judAheWL4iqoxWl347QP9ndaWGhTYdD/4iKYMitMmVmJF9rmJJ+RyAmqEl+St
 ifvMetmP0cYGsU4EFi8NA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:idshmnk7gLU=:lriiHwSXKZR5/OrHIHhgfV
 TQ5WnIqEkTa1NJWP3yc7pbQI4isq60A/3ZxaqJm2l4ieHIo1spF6WzNlKpIj6UNnqfoBv63GC
 hN9TOKw/TrOo8F3+8EtVDJVf3j+OM3aUVqLMHgnZbKWEIrtpiQIPgfLfcoWjZhKPyVCHVUTN8
 hJr54x3WxrwIJ7Q/r3BB7RiHGEuTEPV9njxUZkTDOth7Ib7RKTF39sFRn9G/4tCKL9uvaaqDY
 lg9k981Ell1x9HHGBEcmw/f1Kxkidr5zb3s1wCyUWMdqyw3A3PBWOoqR436mOm0cFljnzewLR
 0RLBRxPjIpQbUNuvD1EwdXNNYJVWMdcBDER8eo+/rzbbV/DtJlzRDzsrYhwWpg0EVQAfliR+1
 vBIl4PkfPUq82Q3JjU4WeF0R/e8U0FmdRJAoBbeGaUZ0z3pOexN8rb6nL6OrlfLxjMnyQd4Bd
 Cs/83jNjkZ2W3rQJuL8SFWdnkDU8MNRqV/DfCuLxj9p3ZNeZvNYufRqwIWYX4UaNPTh2l4F8l
 VFft66kDQZG9d7BNPg/+DUKW9m09ubgZwmu7MfRmVS+VSp2UUPPhhIqnyY1vENSOR1OSM90D7
 UPKTXdZe3kGBDQM87+1kqmeXKVpko8oVx4QhchgTtoWgczXkbDxKFdMrU312gJyTnuSH0YsZC
 iWR0vrY3a2aELbel1cplsNGKy4QYrAjNyYC35uegG7UN4jFKcU6wFcHXWpIbMsvKSyYnls8Qx
 nxlssSQPy7yzLXKVbbDuKy5Vv875AqyQB5cjsS5AtnlUbHxI/Ww3xlblR88ntNjp3AJXOrJoI
 PY0HZJU0Y9+A03xUE3SNoMysmhcEIRIZPlc31kNdFg8/Ds7Yal7MBC2Ca5H4LbCCWdg/gpoRb
 a04lE6xyqJ0gE5qsABqbdW0/FAtLki1HpCdNEQtxrou8p+9d9NiHWOqQPg+moOVuoo/CgXU8N
 hA/vKavZ8LsvMXl43+xqS5DxFCFudbCmxP5dag1v70K1Wtp0C1ZGk+wrig4pFjJ4qm50W+G22
 5lHOz7fwzPNJCXOvYHOB3GNzg0XEqQ3+smxA1SrKAouxA2o9FBESuOS7NRMz0su9TQeeOUtUi
 y1DuDEq8Ct7UZGC+znvi4eNyZVolm/mNuHn4cVDtvoGamRbW55FHsNtEQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=882:11, Omar Sandoval wrote:
> On Fri, Aug 20, 2021 at 05:13:34PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/20 =E4=B8=8B=E5=8D=884:51, Nikolay Borisov wrote:
>>>
>>>
>>> On 18.08.21 =D0=B3. 0:06, Omar Sandoval wrote:
>>>> From: Omar Sandoval <osandov@fb.com>
>>>>
>>>> Currently, an inline extent is always created after i_size is extende=
d
>>>> from btrfs_dirty_pages(). However, for encoded writes, we only want t=
o
>>>> update i_size after we successfully created the inline extent.
>>
>> To me, the idea of write first then update isize is just going to cause
>> tons of inline extent related prblems.
>>
>> The current example is falloc, which only update the isize after the
>> falloc finishes.
>>
>> This behavior has already bothered me quite a lot, as it can easily
>> create mixed inline and regular extents.
>
> Do you have an example of how this would happen? I have the inode and
> extent bits locked during an encoded write, and I see that fallocate
> does the same.

xfs_io -f -c "pwrite 0 1K" -c "sync" -c "falloc 0 4k" -c "pwrite 4k 4k"

The [0, 1K) will be written as inline without doubt.

Then we go to falloc, it will try to zero the range [1K, 4K), but it
doesn't increase the isize.
Thus the page [0, 4k) will still be written back as inline, since isize
is still 1K.

Later [4K, 8K) will be written back as regular, causing mixed extents.

>
>> Can't we remember the old isize (with proper locking), enlarge isize
>> (with holes filled), do the write.
>>
>> If something wrong happened, we truncate the isize back to its old isiz=
e.
>>
[...]
>>>
>>> Urgh, just some days ago Qu was talking about how awkward it is to hav=
e
>>> mixed extents in a file. And now, AFAIU, you are making them more like=
ly
>>> since now they can be created not just at the beginning of the file bu=
t
>>> also after i_size write. While this won't be a problem in and of itsel=
f
>>> it goes just the opposite way of us trying to shrink the possible case=
s
>>> when we can have mixed extents.
>>
>> Tree-checker should reject such inline extent at non-zero offset.
>
> This change does not allow creating inline extents at a non-zero offset.
>
>>> Qu what is your take on that?
>>
>> My question is, why encoded write needs to bother the inline extents at=
 all?
>>
>> My intuition of such encoded write is, it should not create inline
>> extents at all.
>>
>> Or is there any special use-case involved for encoded write?
>
> We create compressed inline extents with normal writes. We should be
> able to send and receive them without converting them into regular
> extents.
>
But my first impression for any encoded write is that, they should work
like DIO, thus everything should be sectorsize aligned.

Then why could they create inline extent? As inline extent can only be
possible when the isize is smaller than sectorsize.

Thanks,
Qu
