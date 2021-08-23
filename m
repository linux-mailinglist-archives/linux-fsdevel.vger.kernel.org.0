Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2685F3F53A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhHWXdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 19:33:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:50391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhHWXdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629761533;
        bh=mVehhbyodt+j7tlMOfap5tCDadNAkrLaPtHAWZ5lH5I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SEPsfNqP3EB5HJ6uv0CnpRUmWGP+MdYJiRnbhAqdVuYqTUsIPzN+H12VmvMuRP5m6
         ta6m1CP5p0g8G8xS3eSAfuINQYEGSluzwMxQv3V6ehgipkCurEc3N0oUxpZMQqDQOa
         9G76TRVUDbFs6c17+r7ms9a4SBVTEFrXylPBk8HM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1mMjGe1DvM-004PIY; Tue, 24
 Aug 2021 01:32:12 +0200
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
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
 <d7e302f9-7230-0065-c908-86c10d77d738@gmx.com>
 <YSPl/psinnRhev4x@relinquished.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5a35da37-1504-361a-46bc-3fe1c1846871@gmx.com>
Date:   Tue, 24 Aug 2021 07:32:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSPl/psinnRhev4x@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ALVYKneymACxNyLkPITy2zot7uBFJnMtBV183FvGjjZvDpfqV9l
 gr2sBe/qThYAGFzS2uwfxPjfhWiQhjjJyconS/IwzndGSPQ/ZR4Q1yGL2TxLHFEOM1Uq2mK
 JbQwSqo/xvZlI/sRqqMWmUNoonJ2By4WqvsMrGP96yiGyFL2NMpzsl7ReV7Y697cWL+UdjU
 Kf2AkFhhI9NBACLYK72Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WE30JcqmvQU=:GNqOng74jaS0Pej8Yi7i5Q
 YdzZQIXQ+DYTtJjOlTKTtmhsgL3pWYnoLZz3sY3ABO1liyyzaPcfr1Dsuff7umGS0ffbWFYml
 3ExZD+461SGAuwmqqfyYptB6I4VRaMjMKLRYzCzudpc4fkTB25+gkdHlDW9BhQ+mG2KxTpgf8
 iujgqSzQqHHtHT9mTBhh/iIKmfpFzoPpXy3DO0w7794oC5D4P4ph0FaWHrpPBEe84+eV0bXhd
 +uK3q4N30t31WC2EbbZ7NQK7tJpn+aQA7Fi8vMntpBaAcKMXJyWaCv2rhrutOkLoIMMJJnsA6
 EePPmUmf6knnAeuEBJgmwM8KxfuLoIoOfWIGgFvxgufAi9YDuGhl+2Uaq2ebg0xlR72VhmDtW
 jenJUH5Yiuh7YeRbyICj3O5wPzZk01+0S8XCRzPke03ETKlsGb+j2HBaraWjnqOg8qfLFM0Xw
 7gWWfeTstcUTvmoMnAkW7Jg0g4B/oesDzJlmbOcaLjenLoVdysvI4zN7NZnFsX65dDwovq26+
 Fev7aNrAq1tMz33rR6Ri6k7PZ8vtszk5Xv8/UyfUZ3uLgejGbzWYkDfWo/M1s1QTG+hHfRMn3
 Fcv5LOt19V/8/+2eS73rAG0UCSZ0/gA0VCHKeUkT4ltDynZDfaUCmX4o66073hQd0vPDxDoa+
 0xCQ18ywzD1chTf5LBjdqJ97YdMe3v3pEbH+o83TqaFWR9kWoQxpBzbfL+s/W0Q6gvcWzRgFq
 j+tt8RtkX9Vd35DhUxw70bhkTcEx5bhMgZp4H8LuU3Zdwris3tTaIgTXikU5B9sPwOCvSS3bi
 v2Yxu9hxcPlbJbo/Rl/MaB8PH58QJdP6ZhVpj66oBY/62bDv/P9jf5gBa/yBBjx08C/Mp1q7r
 JeYcjCjZv1noy52aygWoI2SLKC+dUc2xdw08iyZu994ZUeY5Tcw6xA18i8v5DqgEf6alMjzYB
 runMALBy53eHt0Hx2zfkM/tS+NbI9t/XOWpN4XwRdqkpYQIfQg/EGSV7TT4mjvSorBVYz87Pv
 CPj3j7EoqvQpWW8QwbLIsGmdDqGD48RK8bPK85XSsb8pTY69nG4i5ZuBUDaMw4jLV/iYkGOxC
 C1YKZAzR4lTmwbe+TMzjJtsJ4MyeYNaXEVONbWgUb+fQ+5PDMsS6acRQg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=882:16, Omar Sandoval wrote:
> On Sat, Aug 21, 2021 at 09:11:26AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/21 =E4=B8=8A=E5=8D=882:11, Omar Sandoval wrote:
>>> On Fri, Aug 20, 2021 at 05:13:34PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/20 =E4=B8=8B=E5=8D=884:51, Nikolay Borisov wrote:
>>>>>
>>>>>
>>>>> On 18.08.21 =D0=B3. 0:06, Omar Sandoval wrote:
>>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>>
>>>>>> Currently, an inline extent is always created after i_size is exten=
ded
>>>>>> from btrfs_dirty_pages(). However, for encoded writes, we only want=
 to
>>>>>> update i_size after we successfully created the inline extent.
>>>>
>>>> To me, the idea of write first then update isize is just going to cau=
se
>>>> tons of inline extent related prblems.
>>>>
>>>> The current example is falloc, which only update the isize after the
>>>> falloc finishes.
>>>>
>>>> This behavior has already bothered me quite a lot, as it can easily
>>>> create mixed inline and regular extents.
>>>
>>> Do you have an example of how this would happen? I have the inode and
>>> extent bits locked during an encoded write, and I see that fallocate
>>> does the same.
>>
>> xfs_io -f -c "pwrite 0 1K" -c "sync" -c "falloc 0 4k" -c "pwrite 4k 4k"
>>
>> The [0, 1K) will be written as inline without doubt.
>>
>> Then we go to falloc, it will try to zero the range [1K, 4K), but it
>> doesn't increase the isize.
>> Thus the page [0, 4k) will still be written back as inline, since isize
>> is still 1K.
>>
>> Later [4K, 8K) will be written back as regular, causing mixed extents.
>
> I'll have to read fallocate more closely to follow what's going on here
> and figure out if it applies to encoded writes. Please help me out if
> you see how this would be an issue with encoded writes.

This won't cause anything wrong, if the encoded writes follows the
existing inline extents requirement (always at offset 0).

Otherwise, the read path could be affected to handle inlined extent at
non-zero offset.

>
>>>> Can't we remember the old isize (with proper locking), enlarge isize
>>>> (with holes filled), do the write.
>>>>
>>>> If something wrong happened, we truncate the isize back to its old is=
ize.
>>>>
>> [...]
>>>>>
>>>>> Urgh, just some days ago Qu was talking about how awkward it is to h=
ave
>>>>> mixed extents in a file. And now, AFAIU, you are making them more li=
kely
>>>>> since now they can be created not just at the beginning of the file =
but
>>>>> also after i_size write. While this won't be a problem in and of its=
elf
>>>>> it goes just the opposite way of us trying to shrink the possible ca=
ses
>>>>> when we can have mixed extents.
>>>>
>>>> Tree-checker should reject such inline extent at non-zero offset.
>>>
>>> This change does not allow creating inline extents at a non-zero offse=
t.
>>>
>>>>> Qu what is your take on that?
>>>>
>>>> My question is, why encoded write needs to bother the inline extents =
at all?
>>>>
>>>> My intuition of such encoded write is, it should not create inline
>>>> extents at all.
>>>>
>>>> Or is there any special use-case involved for encoded write?
>>>
>>> We create compressed inline extents with normal writes. We should be
>>> able to send and receive them without converting them into regular
>>> extents.
>>>
>> But my first impression for any encoded write is that, they should work
>> like DIO, thus everything should be sectorsize aligned.
>>
>> Then why could they create inline extent? As inline extent can only be
>> possible when the isize is smaller than sectorsize.
>
> ENCODED_WRITE is not defined as "O_DIRECT, but encoded". It happens to
> have some resemblance to O_DIRECT because we have alignment requirements
> for new extents and because we bypass the page cache, but there's no
> reason to copy arbitrary restrictions from O_DIRECT. If someone is using
> ENCODED_WRITE to write compressed data, then they care about space
> efficiency, so we should make efficient use of inline extents.
>
Then as long as the inline extent requirement for 0 offset is still
followed, I'll be fine with that.

But for non-zero offset inline extent? It looks like a much larger
change, and may affect read path.

So I'd prefer we keep the 0 offset requirement for inline extent, and
find a better way to work around.

Thanks,
Qu
