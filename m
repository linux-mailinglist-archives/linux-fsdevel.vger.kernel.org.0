Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8469D65822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGKNym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:54:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbfGKNym (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:54:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B2A661F1E0477FEB895;
        Thu, 11 Jul 2019 21:54:23 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 21:54:16 +0800
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
To:     Matthew Wilcox <willy@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>,
        =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Chao Yu <yuchao0@huawei.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        <chao@kernel.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
 <1506e523-109d-7253-ee4b-961c4264781d@aol.com>
 <20190711130649.GQ32320@bombadil.infradead.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e2c3f973-8000-869e-a2bf-867631c64ab4@huawei.com>
Date:   Thu, 11 Jul 2019 21:54:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190711130649.GQ32320@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/11 21:06, Matthew Wilcox wrote:
> On Thu, Jul 11, 2019 at 07:42:20AM +0800, Gao Xiang wrote:
>>
>> At 2019/7/11 ??????5:50, Andreas Gr??nbacher Wrote:
>>> At this point, can I ask how important this packing mechanism is to
>>> you? I can see a point in implementing inline files, which help
>>> because there tends to be a large number of very small files. But for
>>> not-so-small files, is saving an extra block really worth the trouble,
>>> especially given how cheap storage has become?
>>
>> I would try to answer the above. I think there are several advantages by
>> using tail-end packing inline:
>> 1) It is more cache-friendly. Considering a file "A" accessed by user
>> now or recently, we
>> ?????? tend to (1) get more data about "A" (2) leave more data about "A"
>> according to LRU-like assumption
>> ?????? because it is more likely to be used than the metadata of some other
>> files "X", especially for files whose
>> ?????? tail-end block is relatively small enough (less than a threshold,
>> e.g. < 100B just for example);
>>
>> 2) for directories files, tail-end packing will boost up those traversal
>> performance;
>>
>> 3) I think tail-end packing is a more generic inline, it saves I/Os for
>> generic cases not just to
>> ?????? save the storage space;
>>
>> "is saving an extra block really worth the trouble" I dont understand
>> what exact the trouble is...
> 
> "the trouble" is adding code complexity and additional things to test.
> 
> I'm not sure you really understood Andreas' question.  He's saying that he
> understands the performance and space gain from packing short files
> (eg files less than 100 bytes).  But how many files are there between
> 4096 and 4196 bytes in size, let alone between 8192 and 8292, 12384 and
> 12484 ...
> 
> Is optimising for _those_ files worth it?

Hi Willy,

Thanks for your kindly explanation.. I get it :) I try to express my thoughts in
the following aspects...

1) In my thought, I personally think Chao's first patch which adds an additional
   type could be better for now, maybe we can reduce duplicate code based on that
   patch even further. What EROFS needs is only a read-only tail-end packing,
   I think for write we actually need to rethink more carefully (but it doesn't
   mean complex I think, but I don't do research on this.. I have to be silent...)
   and maybe we could leave it until a really fs user switching to iomap and mix
   INLINE and TAIL at that time...

2) EROFS actually has an unfinished feature which supports tail-end packing
   compresssed data, which means decompressed data could not be so small...
   and I know that is another matter... So to direct answer the question is
   that it depends on the userdata and user. For EROFS, tail-end packing
   inline is easy to implement, and it's a per-file optional feature (not
   mandatory) and the threshold (< 100B) is not a hardcoded limit as well,
   which is configured by mkfs users and only help mkfs decide whether the
   file should enable it or not. it should be useful for all directories
   at least, and I think it is more cache-friendly for regular files as well
   so a large range of files configured by users (not just < 100B) can be
   benefited from this...

Sorry about my English...

Thanks,
Gao Xiang

> 


