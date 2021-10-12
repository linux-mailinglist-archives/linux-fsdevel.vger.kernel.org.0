Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB4429E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhJLHG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 03:06:29 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42925 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbhJLHG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:06:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UrYOY-L_1634022262;
Received: from 30.240.98.196(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UrYOY-L_1634022262)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 15:04:23 +0800
Message-ID: <48159eb1-61f7-09df-9bea-5933a283f972@linux.alibaba.com>
Date:   Tue, 12 Oct 2021 15:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH 0/3] mm, thp: introduce a new sysfs interface to
 facilitate file THP for .text
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
 <YWPwjTEfeFFrJttQ@infradead.org> <YWTp7yjaN8W//Zrf@casper.infradead.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YWTp7yjaN8W//Zrf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/12/21 9:50 AM, Matthew Wilcox wrote:
> On Mon, Oct 11, 2021 at 09:06:37AM +0100, Christoph Hellwig wrote:
>> Can we please just get proper pagecache THP (through folios) merged
>> instead of piling hacks over hacks here?  The whole readonly THP already
>> was more than painful enough due to all the hacks involved.
> 
> This was my initial reaction too.
> 
> But read the patches.  They're nothing to do with the implementation of
> THP / folios in the page cache.  They're all to make sure that mappings
> are PMD aligned.
Hi, Matthew

In fact, we had thought about realizing this by handling page cache 
directly. And then, we found that we just need to align the mapping 
address and make khugepaged can scan these 'mm_struct' base on 
READ_ONLY_THP_FOR_FS.

> 
> I think there's a lot to criticise in the patches (eg, a system-wide
> setting is probably a bad idea.  and a lot of this stuff seems to
At the beginning, we don't introduce the new sysfs interface, just 
re-use 'transparent_hugepage/enabled'. But In some production system, they
disable the THP directly, especially those applications that are 
sensitive to THP. So, Considering these scenarios, we had to design a 
new sysfs interface ('transparent_hugepage/hugetext_enabled').

And if you have other idea, we are willing to take to improve these patches.

Thanks!

> be fixing userspace bugs in the kernel).  But let's criticise what's
> actually in the patches, because these are problems that exist regardless
> of RO_THP vs folios.
>
