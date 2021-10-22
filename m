Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348CF4374AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhJVJZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 05:25:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:60151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhJVJZd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634894557;
        bh=wYE5icMGjlbxqUC5vNAl8WPiRJIK0GBgDoDvJbZLhoM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=kVmflJAuInwl0zPg/sdjb7LPZHWGL7zsQv6uylHvevozFIRi5e52MiCEvjKuSTFr4
         fTRcVsovAZ7LKb9JzpaLIqklB3PvNHpTFr9ewffQfbsXiQ+ffIXK4zW85MjkSSacAd
         8xJidmRh6DO7lrh8yMpQEKIsE6JekAlhihXQyULY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1mE6g70IXW-00S3VI; Fri, 22
 Oct 2021 11:22:37 +0200
Message-ID: <62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com>
Date:   Fri, 22 Oct 2021 17:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Readahead for compressed data
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dm44L66HxZZOvJluzMF4iV9LIJ3EEb9YYGAOwv/YTcc29C93Oa8
 7KnlE2MPl5pfyoJD36N8kmOjeqjj/MpmWbl2IXs3ugp+GogwlG7LLWpfllDVb2bJzUgSjGJ
 U7EozDK5tBZnCu2+1dfjirOPJkP+aIl9u9A0d9s9C1WxWZMltcnqp9oBdgTsGS5P3cDjHNH
 bbmR1YSQ/OF2k5E2mR6oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncqkcUNDPZQ=:WDIXBzbRX/r4KBqrMdtwU3
 dvGLa7khY9U1o9cIsEiwIoHhveAmE0q/FeqMbNj6uuNy6r3peUcoo30M6EE6FayctYHn+2eWV
 0jGMvOfJSWEWuQMigrYO18Ycrc6QfWjFDCiYEngXYPbMWwWIYZVCvg7xtBj4E5qxirSC8StcH
 UDxhMGbrYQRsWXGtJGVeP05WJYinrVBacftKTnDya+trwhORFIL0QD4f9MwGhuYKAbIawWVki
 426fDcvr3CL8/4BVg94magNsJonUAUhcy40ytV+PFtJ7quCUPC/SSwPnkSoJ01Z+b/ro9qxUl
 VjBPy6rFefcnh3hqjAli5AH7SHW4OLQtf4vg9MaOh8xeizSOjz2mcZoj6cfNEQ7uT4apl7EKb
 KaCP6neLti8g99+RAO/59/TsuBJuXCBpuJBVw0oArUCwSpdMiZlekXp07P2fhRk1wI4nvmI//
 whIfesqLOxHinUnMbp6nU4g3oLCnLRRoifKYNil4fviEhYA8DJ4CDd9t+X2CsPaYqZ5gHY8Z4
 MCGRy2Kc/2R38pPHquvbX4RU7ia+cCVX8BFuVq8Lzpd/grVIyFjDAbJAcQAH8kuVpj2rzu8YR
 IacYZ2f5mZhX6aWw+KIUkjJxrsyuO7w6Sn1fF5e8P0Opzdh8jHvUGjxPMb7F3yAbyPB6+3Y0G
 k7d6fI3Wp+budjM5An2OWBiiXtdyOg/w6HtsYDAfS2CbREisjHKzVy3g9DpUmzyDZCw3rlehR
 SSiLYjG26jB95YdPPVanhepGF0/vJimeT4UzMsgw9fkfgZt0UZA48Ls+FQhExCd/WDvZ6YFoK
 U1GwkwAjiOTtQo6MP+z3Pa1xWOo+M86IAY8OFdiUhcteCXOLKvh1S/jnHncojEy0K9PWkEkD3
 gxZkHdqtahiTTQD6+b1lWDFXMZpp9c7mjja0SpGdemqGGHMGG4bMfIin/gGSSi7kt6g5vwdhR
 GR2UYGrz0mzfo6cK12tdGizDhFxyAscI0YnDOPhkpBBB26ISjaxhW03MlbwxxlHGmmUjIqWil
 TI7SJA/cWuHmMzR7ai5oEw463UaCB+zCg32zWZfvFKkCB6aKIR/oFKqo4rsY76JVvG2SuVIE6
 FLvi4lYqPZKK8o=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/10/22 17:11, Gao Xiang wrote:
> On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
>> On Thu 21-10-21 21:04:45, Phillip Susi wrote:
>>>
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>
>>>> As far as I can tell, the following filesystems support compressed da=
ta:
>>>>
>>>> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>>>>
>>>> I'd like to make it easier and more efficient for filesystems to
>>>> implement compressed data.  There are a lot of approaches in use toda=
y,
>>>> but none of them seem quite right to me.  I'm going to lay out a few
>>>> design considerations next and then propose a solution.  Feel free to
>>>> tell me I've got the constraints wrong, or suggest alternative soluti=
ons.
>>>>
>>>> When we call ->readahead from the VFS, the VFS has decided which page=
s
>>>> are going to be the most useful to bring in, but it doesn't know how
>>>> pages are bundled together into blocks.  As I've learned from talking=
 to
>>>> Gao Xiang, sometimes the filesystem doesn't know either, so this isn'=
t
>>>> something we can teach the VFS.
>>>>
>>>> We (David) added readahead_expand() recently to let the filesystem
>>>> opportunistically add pages to the page cache "around" the area reque=
sted
>>>> by the VFS.  That reduces the number of times the filesystem has to
>>>> decompress the same block.  But it can fail (due to memory allocation
>>>> failures or pages already being present in the cache).  So filesystem=
s
>>>> still have to implement some kind of fallback.
>>>
>>> Wouldn't it be better to keep the *compressed* data in the cache and
>>> decompress it multiple times if needed rather than decompress it once
>>> and cache the decompressed data?  You would use more CPU time
>>> decompressing multiple times, but be able to cache more data and avoid
>>> more disk IO, which is generally far slower than the CPU can decompres=
s
>>> the data.
>>
>> Well, one of the problems with keeping compressed data is that for mmap=
(2)
>> you have to have pages decompressed so that CPU can access them. So kee=
ping
>> compressed data in the page cache would add a bunch of complexity. That
>> being said keeping compressed data cached somewhere else than in the pa=
ge
>> cache may certainly me worth it and then just filling page cache on dem=
and
>> from this data...
>
> It can be cached with a special internal inode, so no need to take
> care of the memory reclaim or migration by yourself.

There is another problem for btrfs (and maybe other fses).

Btrfs can refer to part of the uncompressed data extent.

Thus we could have the following cases:

	0	4K	8K	12K
	|	|	|	|
		    |	    \- 4K of an 128K compressed extent,
		    |		compressed size is 16K
		    \- 4K of an 64K compressed extent,
			compressed size is 8K

In above case, we really only need 8K for page cache, but if we're
caching the compressed extent, it will take extra 24K.

It's definitely not really worthy for this particular corner case.

But it would be pretty common for btrfs, as CoW on compressed data can
easily lead to above cases.

Thanks,
Qu

>
> Otherwise, these all need to be take care of. For fixed-sized input
> compression, since they are reclaimed in page unit, so it won't be
> quite friendly since such data is all coupling. But for fixed-sized
> output compression, it's quite natural.
>
> Thanks,
> Gao Xiang
>
>>
>> 								Honza
>> --
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
