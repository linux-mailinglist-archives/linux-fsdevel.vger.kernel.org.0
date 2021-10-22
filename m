Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9543759E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhJVKm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 06:42:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:59837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhJVKm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634899209;
        bh=P3pL0z5U1lr82ILvj/7RspKnruMijC05DS94G9TQaDc=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=DhxXAmbhxw5I6uIQhKKOcHxXKVyVQ804xYm8hIGroBVVQTSMYL2FQmZ7T3/8KM+Q+
         4tGRd/8ZPHgpQ/GRV1ylmZ5qHP/k8UAPq9L0s+kykMBfsF/6BUtt1LeR7wU1rkeC1U
         ECREQXjXbq4Rj4o6Eq9+RRa6DmqwodYHrrIMdhF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1mTiZK0V7H-00HMcZ; Fri, 22
 Oct 2021 12:40:09 +0200
Message-ID: <93e4eccb-d839-0e8e-4b87-1964232a0458@gmx.com>
Date:   Fri, 22 Oct 2021 18:40:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Phillip Susi <phill@thesusis.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-bcache@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>,
        ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net> <20211022084127.GA1026@quack2.suse.cz>
 <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
 <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
 <YXKG0V99Ph9KhDyg@B-P7TQMD6M-0146.local>
 <YXKKOx6OX1LzLShe@B-P7TQMD6M-0146.local>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Readahead for compressed data
In-Reply-To: <YXKKOx6OX1LzLShe@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XaNW1n6QiLwbDcJuGYG2KuaxcGS/lNhVqz994mJdjFhdak8XHNx
 P3uHq1BxPePF5ZPfY0V9Oold01NUP2jZWnLdXeW+LI1ea267R3os6v1Z4HwnrzGq5dFbDoG
 4FlctrJUAemI8gI2DiXrq9CWZ5Zf9Fg2IZv2SetOd+Ra+P7ecZN4tfG2+gsQlvsbZVIzoA4
 bBghD2DLCCzez9t2IiRgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oq6mfoU8d9w=:I5ti4YfEhwgoBn0lqMXVxk
 WVT10J57+uUdZyn3btezxd2lgD7qoOPHkoOIvtVq0HTHpW9z5pqZZyIr6jGe8UOy+OduVzVYf
 8dH3YlfHPuBAvnd3+5CIToFOVZ41PCiP10u67Ms5LdLQkztpQ3qXGlR8Dz1bRTzCoX86UgRN+
 xAEsZK3xObBinyluHwGJQSD07+tlXVjRFzZ3fMCJS+hhrzL+JN9sVGIx+GVhoi5aGIVnTjLil
 PQOeFUTCpoYPKvzaDYhRjhECeNk3jnBJ0eoRywrfpre7C1lLC3YU9Mywd+8vyH240kelUGSrq
 RX9MLZPw82Q0/mxc/ZfQ4UNmWCoA0HT9ia2SlE7Fh47A66PwrvbNXc/XupSvLUgmbP2zFXc6D
 J0ReYjpi4bmutPK5pLgL9EjjTWKBq0CVoxc0c/fS3IU7e+H2K1IZvLRm6buDeFuhAyo34Jf2Q
 MhTYURJqFvhOeHgGcqwnVhLR8RyhtJVJ0UByLjLBGmPKW9sLkdL7iW51Y4bQcBpkxAp8nTC9o
 CzTdXj6HouOsU/CaKpRRgVu91pVSStNObxxI9T3x77fSsWKvsTL9i0wsfqOwnAFjvUl8OlqHh
 ASt9zOE3iQfE/shJxDu/9YCfq94ZadnU1wpSr5OogQPG+zkBIdAHo7UbNUWlNLdBsbVhSTPcv
 D+FedBvtyP5TmsANQ5Ad8JjsF9Tacvi8rRxN3KLVDmQimNkYOJHvJD5h6Bf35DKws/M/jlHoh
 C73rU/Srjc70GSvIv1+OZ0OobhD4BI7GqaOzXdegV4JkReTQTchqyguBxWoyZLQcqEpqYdeFt
 7eZ0ReNjgCzUv/pDcYE1mN+GzphB8Hvhl48+phxG0p8LfvYs47HTq8EbFkDi8RAayr9rgwb4e
 0SOmKI2qgEoTz14MTcRa4MXqR/Egr/2WIGdccyBcnI2Cv6huoXmLZ6uAIHgA/ncAlRYYhiCS/
 GydBgauPDM9YetxNKMITQuAJbV/tuXAv/RR3fTYF+2zA5RKHnVIN9Iu6mjlpsA+dGqhHsSixp
 AzpE4OJjRnxLS3nsVIEiKMpigCWEHQHy6byuWFFpPYBpse3Cg+xD7PY8NUK2vAonvEsu3N7Xm
 bXUfXsGXjsQ/PY=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/10/22 17:54, Gao Xiang wrote:
> On Fri, Oct 22, 2021 at 05:39:29PM +0800, Gao Xiang wrote:
>> Hi Qu,
>>
>> On Fri, Oct 22, 2021 at 05:22:28PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/10/22 17:11, Gao Xiang wrote:
>>>> On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
>>>>> On Thu 21-10-21 21:04:45, Phillip Susi wrote:
>>>>>>
>>>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>>>
>>>>>>> As far as I can tell, the following filesystems support compressed=
 data:
>>>>>>>
>>>>>>> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>>>>>>>
>>>>>>> I'd like to make it easier and more efficient for filesystems to
>>>>>>> implement compressed data.  There are a lot of approaches in use t=
oday,
>>>>>>> but none of them seem quite right to me.  I'm going to lay out a f=
ew
>>>>>>> design considerations next and then propose a solution.  Feel free=
 to
>>>>>>> tell me I've got the constraints wrong, or suggest alternative sol=
utions.
>>>>>>>
>>>>>>> When we call ->readahead from the VFS, the VFS has decided which p=
ages
>>>>>>> are going to be the most useful to bring in, but it doesn't know h=
ow
>>>>>>> pages are bundled together into blocks.  As I've learned from talk=
ing to
>>>>>>> Gao Xiang, sometimes the filesystem doesn't know either, so this i=
sn't
>>>>>>> something we can teach the VFS.
>>>>>>>
>>>>>>> We (David) added readahead_expand() recently to let the filesystem
>>>>>>> opportunistically add pages to the page cache "around" the area re=
quested
>>>>>>> by the VFS.  That reduces the number of times the filesystem has t=
o
>>>>>>> decompress the same block.  But it can fail (due to memory allocat=
ion
>>>>>>> failures or pages already being present in the cache).  So filesys=
tems
>>>>>>> still have to implement some kind of fallback.
>>>>>>
>>>>>> Wouldn't it be better to keep the *compressed* data in the cache an=
d
>>>>>> decompress it multiple times if needed rather than decompress it on=
ce
>>>>>> and cache the decompressed data?  You would use more CPU time
>>>>>> decompressing multiple times, but be able to cache more data and av=
oid
>>>>>> more disk IO, which is generally far slower than the CPU can decomp=
ress
>>>>>> the data.
>>>>>
>>>>> Well, one of the problems with keeping compressed data is that for m=
map(2)
>>>>> you have to have pages decompressed so that CPU can access them. So =
keeping
>>>>> compressed data in the page cache would add a bunch of complexity. T=
hat
>>>>> being said keeping compressed data cached somewhere else than in the=
 page
>>>>> cache may certainly me worth it and then just filling page cache on =
demand
>>>>> from this data...
>>>>
>>>> It can be cached with a special internal inode, so no need to take
>>>> care of the memory reclaim or migration by yourself.
>>>
>>> There is another problem for btrfs (and maybe other fses).
>>>
>>> Btrfs can refer to part of the uncompressed data extent.
>>>
>>> Thus we could have the following cases:
>>>
>>> 	0	4K	8K	12K
>>> 	|	|	|	|
>>> 		    |	    \- 4K of an 128K compressed extent,
>>> 		    |		compressed size is 16K
>>> 		    \- 4K of an 64K compressed extent,
>>> 			compressed size is 8K
>>
>> Thanks for this, but the diagram is broken on my side.
>> Could you help fix this?
>
> Ok, I understand it. I think here is really a strategy problem
> out of CoW, since only 2*4K is needed, you could
>   1) cache the whole compressed extent and hope they can be accessed
>      later, so no I/O later at all;
>   2) don't cache such incomplete compressed extents;
>   3) add some trace record and do some finer strategy.

Yeah, this should be determined by each fs, like whether they want to
cache compressed extent at all, and at which condition to cache
compressed extent.

(e.g. for btrfs, if we find the range we want is even smaller than the
compressed size, we can skip such cache)

Thus I don't think there would be a silver bullet for such case.

>
>>
>>>
>>> In above case, we really only need 8K for page cache, but if we're
>>> caching the compressed extent, it will take extra 24K.
>>
>> Apart from that, with my wild guess, could we cache whatever the
>> real I/O is rather than the whole compressed extent unconditionally?
>> If the whole compressed extent is needed then, we could check if
>> it's all available in cache, or read the rest instead?
>>
>> Also, I think no need to cache uncompressed COW data...

Yeah, that's definitely the case, as page cache is already doing the
work for us.

Thanks,
Qu

>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> It's definitely not really worthy for this particular corner case.
>>>
>>> But it would be pretty common for btrfs, as CoW on compressed data can
>>> easily lead to above cases.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Otherwise, these all need to be take care of. For fixed-sized input
>>>> compression, since they are reclaimed in page unit, so it won't be
>>>> quite friendly since such data is all coupling. But for fixed-sized
>>>> output compression, it's quite natural.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> 								Honza
>>>>> --
>>>>> Jan Kara <jack@suse.com>
>>>>> SUSE Labs, CR
