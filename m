Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB956F8C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfGVFSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 01:18:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbfGVFSU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:18:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 393D483F44B3A87A86CF;
        Mon, 22 Jul 2019 13:02:06 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 13:01:58 +0800
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
Date:   Mon, 22 Jul 2019 13:01:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On 2019/7/22 12:39, Amir Goldstein wrote:
> On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>>
>> Currently kernel has scattered tagged pointer usages
>> hacked by hand in plain code, without a unique and
>> portable functionset to highlight the tagged pointer
>> itself and wrap these hacked code in order to clean up
>> all over meaningless magic masks.
>>
>> This patch introduces simple generic methods to fold
>> tags into a pointer integer. Currently it supports
>> the last n bits of the pointer for tags, which can be
>> selected by users.
>>
>> In addition, it will also be used for the upcoming EROFS
>> filesystem, which heavily uses tagged pointer pproach
>>  to reduce extra memory allocation.
>>
>> Link: https://en.wikipedia.org/wiki/Tagged_pointer
> 
> Well, it won't do much good for other kernel users in fs/erofs/ ;-)

Thanks for your reply and interest in this patch.... :)

Sigh... since I'm not sure kernel folks could have some interests in that stuffs.

Actually at the time once I coded EROFS I found tagged pointer had 2 main advantages:
1) it saves an extra field;
2) it can keep the whole stuff atomicly...
And I observed the current kernel uses tagged pointer all around but w/o a proper wrapper...
and EROFS heavily uses tagged pointer... So I made a simple tagged pointer wrapper
to avoid meaningless magic masks and type casts in the code...

> 
> I think now would be a right time to promote this facility to
> include/linux as you initially proposed.
> I don't recall you got any objections. No ACKs either, but I think
> that was the good kind of silence (?)

Yes, no NAK no ACK...(it seems the ordinary state for all EROFS stuffs... :'( sigh...)
Therefore I decided to leave it in fs/erofs/ in this series...

> 
> You might want to post the __fdget conversion patch [1] as a
> bonus patch on top of your series.

I am not sure if another potential users could be quite happy with my ("sane?" or not)
implementation... (Is there some use scenerios in overlayfs and fanotify?...)

and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)

Therefore, I tend to keep silence and just promote EROFS... some better ideas?...

Thanks,
Gao Xiang
