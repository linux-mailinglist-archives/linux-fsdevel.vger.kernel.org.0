Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E64A41FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 05:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfHaDud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 23:50:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfHaDud (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:50:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 573B89E32BE16FCE1349;
        Sat, 31 Aug 2019 11:50:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 11:50:22 +0800
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
To:     <dsterba@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com> <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com> <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com> <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4> <20190829154346.GK23584@kadam>
 <cd38b645-2930-3e02-6c6a-5972ea02b537@huawei.com>
 <20190830115142.GM2752@twin.jikos.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <29d7e697-3d74-bc0e-a756-713f682c32ff@huawei.com>
Date:   Sat, 31 Aug 2019 11:50:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830115142.GM2752@twin.jikos.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/30 19:51, David Sterba wrote:
> On Fri, Aug 30, 2019 at 10:06:25AM +0800, Chao Yu wrote:
>> On 2019/8/29 23:43, Dan Carpenter wrote:
>>>> p.s. There are 2947 (un)likely places in fs/ directory.
>>>
>>> I was complaining about you adding new pointless ones, not existing
>>> ones.  The likely/unlikely annotations are supposed to be functional and
>>> not decorative.  I explained this very clearly.
>>>
>>> Probably most of the annotations in fs/ are wrong but they are also
>>> harmless except for the slight messiness.  However there are definitely
>>> some which are important so removing them all isn't a good idea.
>>
>> Hi Dan,
>>
>> Could you please pick up one positive example using likely and unlikely
>> correctly? so we can follow the example, rather than removing them all blindly.
> 
> Remove all of them and re-add with explanation if and how each is going
> to make things better. If you can't reason about, prove by benchmarks or
> point to inefficient asm code generated, then don't add them again.

It seems the result of it is strongly related to arch and compiler, if we readd
it after we just prove its gain only in one combination, I doubt we may suffer
regression in other combination in between archs and comilers. It looks like we
don't have any cheaper way to readd it? instead of verifying all/most combinations.

> 
> The feedback I got from CPU and compiler people over the years is not to
> bother using the annotations. CPUs are doing dynamic branch prediction
> and compilers are applying tons of optimizations.
> 
> GCC docs state about the builtin: "In general, you should prefer to use
> actual profile feedback for this (-fprofile-arcs), as programmers are
> notoriously bad at predicting how their programs actually perform."
> (https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html)

Yes, I agree with this. Thanks a lot for sharing your experience. :)

The removal change has done and been merged into Greg's tree, let's consider to
readd it later if possible as you suggested.

thanks,

> .
> 
