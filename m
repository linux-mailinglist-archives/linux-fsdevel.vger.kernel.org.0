Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C383E35F0B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347494AbhDNJWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:22:49 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1060 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhDNJWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:22:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UVXq55I_1618392139;
Received: from 30.21.164.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UVXq55I_1618392139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 17:22:19 +0800
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com>
 <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
 <d9b71523-153c-12fa-fc60-d89b27e04854@linux.alibaba.com>
 <CAJfpegsurP8JshxFah0vCwBQicc0ijRnGyLeZZ-4tio6BHqEzQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <0fdb09fa-9b0f-1115-2540-6016ce664370@linux.alibaba.com>
Date:   Wed, 14 Apr 2021 17:22:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsurP8JshxFah0vCwBQicc0ijRnGyLeZZ-4tio6BHqEzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/4/14 17:02, Miklos Szeredi 写道:
> On Wed, Apr 14, 2021 at 10:42 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> 
>> Sorry I missed this patch before, and I've tested this patch, it seems
>> can solve the deadlock issue I met before.
> 
> Great, thanks for testing.
> 
>> But look at this patch in detail, I think this patch only reduced the
>> deadlock window, but did not remove the possible deadlock scenario
>> completely like I explained in the commit log.
>>
>> Since the fuse_fill_write_pages() can still lock the partitail page in
>> your patch, and will be wait for the partitail page waritehack is
>> completed if writeback is set in fuse_send_write_pages().
>>
>> But at the same time, a writeback worker thread may be waiting for
>> trying to lock the partitail page to write a bunch of dirty pages by
>> fuse_writepages().
> 
> As you say, fuse_fill_write_pages() will lock a partial page.  This
> page cannot become dirty, only after being read completely, which
> first requires the page lock.  So dirtying this page can only happen
> after the writeback of the fragment was completed.

What I mean is the writeback worker had looked up the dirty pages in 
write_cache_pages() and stored them into a temporary pagevec, then try 
to lock dirty page one by one and write them.

For example, suppose it looked up 2 dirty pages (named page 1 and page 
2), and writed down page 1 by fuse_writepages_fill(), unlocked page 1. 
Then try to lock page 2.

At the same time, suppose the fuse_fill_write_pages() will write the 
same page 1 and partitail page 2, and it will lock partital page 2 and 
wait for the page 1's writeback is completed. But page 1's writeback can 
not be completed, since the writeback worker is waiting for locking page 
2, which was already locked by fuse_fill_write_pages().

Does that make sense to you? Or I missed something else?
