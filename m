Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA09154FDF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGA7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 19:59:54 -0500
Received: from m12-18.163.com ([220.181.12.18]:46726 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgBGA7y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:59:54 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 19:59:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=NiGx4
        pn11eSXeHc+vBWWaytW14cK5TaWStOxkiQWxsc=; b=OYj4/G8WyyjEM6LeuCqoM
        LVbUOJ/VUJRitjZrLstjEMWvlxct9b8BPQIwE7aW+iD5cSQ5VlXtwGcQuTu2jyl+
        h8EDNzjhekIP71Uxbps+QRxNCoX0NwGGOewJnzuPwEqN/WERz/zUMiNTaMWuGeTD
        aHBJFNGMWfows8iW3kq2qA=
Received: from [192.168.0.10] (unknown [183.211.128.97])
        by smtp14 (Coremail) with SMTP id EsCowAAnTobZsjxesKMcUQ--.53268S2;
        Fri, 07 Feb 2020 08:44:09 +0800 (CST)
Subject: Re: [PATCH] fuse: Don't make buffered read forward overflow value to
 a userspace process
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, yangx.jy@cn.fujitsu.com
References: <20200203073652.12067-1-ice_yangxiao@163.com>
 <CAJfpegsVjca2xGV=9xwE75a5NRSYqLpDu9x_q9CeDZ1vt-GyyQ@mail.gmail.com>
 <CAJfpegsPfurF2fB+XgSjr-CnBNcjWiqYCB6bFwP8VKNp3sUChA@mail.gmail.com>
 <bd8402d6-6d90-c659-6dc4-ac890af900a6@163.com>
 <CAJfpegvXJ21OzMP2eU0bT4XEb40aAqfkrZdk6AQk5bEWmevOmQ@mail.gmail.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <616196bf-789b-5c96-3a9c-761ad92afec9@163.com>
Date:   Fri, 7 Feb 2020 08:44:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvXJ21OzMP2eU0bT4XEb40aAqfkrZdk6AQk5bEWmevOmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: EsCowAAnTobZsjxesKMcUQ--.53268S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4UuF1rCr18GF4fKF47CFg_yoW5Ar4rpF
        93KF4ayFsrW345Ars2qwn5ZFy8K3sxGFyjqFyUXryrWa4qvFn3Aa47Ww18Wr97Wry8GryI
        qr4DX347XryDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1db8UUUUU=
X-Originating-IP: [183.211.128.97]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwPCXlXl1wQifQAAsQ
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/6/20 11:40 PM, Miklos Szeredi wrote:
> On Thu, Feb 6, 2020 at 1:33 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>> On 2/6/20 8:14 PM, Miklos Szeredi wrote:
>>> On Wed, Feb 5, 2020 at 3:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>> On Mon, Feb 3, 2020 at 8:37 AM Xiao Yang <ice_yangxiao@163.com> wrote:
>>>>> Buffered read in fuse normally goes via:
>>>>> -> generic_file_buffered_read()
>>>>>     ------------------------------
>>>>>     -> fuse_readpages()
>>>>>       -> fuse_send_readpages()
>>>>>     or
>>>>>     -> fuse_readpage() [if fuse_readpages() fails to get page]
>>>>>       -> fuse_do_readpage()
>>>>>     ------------------------------
>>>>>         -> fuse_simple_request()
>>>>>
>>>>> Buffered read changes original offset to page-aligned length by left-shift
>>>>> and extends original count to be multiples of PAGE_SIZE and then fuse
>>>>> forwards these new parameters to a userspace process, so it is possible
>>>>> for the resulting offset(e.g page-aligned offset + extended count) to
>>>>> exceed the whole file size(even the max value of off_t) when the userspace
>>>>> process does read with new parameters.
>>>>>
>>>>> xfstests generic/525 gets "pread: Invalid argument" error on virtiofs
>>>>> because it triggers this issue.  See the following explanation:
>>>>> PAGE_SIZE: 4096, file size: 2^63 - 1
>>>>> Original: offset: 2^63 - 2, count: 1
>>>>> Changed by buffered read: offset: 2^63 - 4096, count: 4096
>>>>> New offset + new count exceeds the file size as well as LLONG_MAX
>>>> Thanks for the report and analysis.
>>>>
>>>> However this patch may corrupt the cache if i_size changes between
>>>> calls to fuse_page_length().  (e.g. first page length set to 33;
>>>> second page length to 45; then 33-4095 will be zeroed and 4096-4140
>>>> will be filled from offset 33-77).  This will be mitigated by the
>>>> pages being invalidated when i_size changes
>>>> (fuse_change_attributes()).  Filling the pages with wrong data is not
>>>> a good idea regardless.
>>>>
>>>> I think the best approach is first to just fix the xfstest reported
>>>> bug by clamping the end offset to LLONG_MAX.  That's a simple patch,
>>>> independent of i_size, and hence trivial to verify and hard to mess
>>>> up.
>>> Applied a fix and pushed to:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
>> Hi Miklos,
>>
>> Sorry for the late reply.
>>
>> You have applied a fix quickly when I am going to send a patch today.
>>
>> Just one comment for your fix:
>>
>> I think we need to add the overflow check in fuse_send_readpages() and
>> fuse_do_readpage().
>>
>> Because generic_file_buffered_read() will call fuse_readpage() if
>> fuse_readpages() fails to get page.
> Thanks, fixed.

Hi Miklos,

Thanks a lot for your quick fix again. :-)

I have tested your patch and it works fine.

Reviewed-by: Xiao Yang <ice_yangxiao@163.com>

Thanks,

Xiao Yang

>
> Miklos

