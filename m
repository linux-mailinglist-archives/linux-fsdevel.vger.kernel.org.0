Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DF12AA0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 04:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLZDmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 22:42:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbfLZDmN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:42:13 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44DEA9AECB4CD7818790;
        Thu, 26 Dec 2019 11:42:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 26 Dec
 2019 11:42:08 +0800
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20191223040020.109570-1-yuchao0@huawei.com>
 <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2d2b3477-3eb4-7dd3-09b1-8c686e519c0e@huawei.com>
Date:   Thu, 26 Dec 2019 11:42:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/23 16:41, Geert Uytterhoeven wrote:
> Hi,
> 
> CC linux-fsdevel
> 
> On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
>> As Geert Uytterhoeven reported:
>>
>> for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
>>
>> On some platforms, HZ can be less than 50, then unexpected 0 timeout
>> jiffies will be set in congestion_wait().
>>
>> This patch introduces a macro DEFAULT_IO_TIMEOUT_JIFFIES to limit
>> mininum value of timeout jiffies.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks for your patch!
> 
>> ---
>>  fs/f2fs/compress.c |  3 ++-
>>  fs/f2fs/data.c     |  5 +++--
>>  fs/f2fs/f2fs.h     |  2 ++
>>  fs/f2fs/gc.c       |  3 ++-
>>  fs/f2fs/inode.c    |  3 ++-
>>  fs/f2fs/node.c     |  3 ++-
>>  fs/f2fs/recovery.c |  6 ++++--
>>  fs/f2fs/segment.c  | 12 ++++++++----
>>  fs/f2fs/super.c    |  6 ++++--
>>  9 files changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 1bc86a54ad71..ee4fe8e644aa 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -945,7 +945,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>>                         } else if (ret == -EAGAIN) {
>>                                 ret = 0;
>>                                 cond_resched();
>> -                               congestion_wait(BLK_RW_ASYNC, HZ/50);
>> +                               congestion_wait(BLK_RW_ASYNC,
>> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>>                                 lock_page(cc->rpages[i]);
>>                                 clear_page_dirty_for_io(cc->rpages[i]);
>>                                 goto retry_write;
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index f1f5c701228d..78b5c0b0287e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2320,7 +2320,8 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
>>                 /* flush pending IOs and wait for a while in the ENOMEM case */
>>                 if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
>>                         f2fs_flush_merged_writes(fio->sbi);
>> -                       congestion_wait(BLK_RW_ASYNC, HZ/50);
>> +                       congestion_wait(BLK_RW_ASYNC,
>> +                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>>                         gfp_flags |= __GFP_NOFAIL;
>>                         goto retry_encrypt;
>>                 }
>> @@ -2900,7 +2901,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>                                         if (wbc->sync_mode == WB_SYNC_ALL) {
>>                                                 cond_resched();
>>                                                 congestion_wait(BLK_RW_ASYNC,
>> -                                                               HZ/50);
>> +                                                       DEFAULT_IO_TIMEOUT_JIFFIES);
>>                                                 goto retry_write;
>>                                         }
>>                                         goto next;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 16edbf4e05e8..4bdc20a94185 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -559,6 +559,8 @@ enum {
>>
>>  #define DEFAULT_RETRY_IO_COUNT 8       /* maximum retry read IO count */
>>
>> +#define        DEFAULT_IO_TIMEOUT_JIFFIES      (max_t(long, HZ/50, 1))
>> +
>>  /* maximum retry quota flush count */
>>  #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT                8
>>
> 
> Seeing other file systems (ext4, xfs) and even core MM code suffers from
> the same issue, perhaps it makes sense to move this into congestion_wait(),
> i.e. increase the timeout to 1 if it's zero in the latter function?

Yup, maybe I can submit a RFC patch to change congestion_wait(), before that
we still need this f2fs change.

Thanks,

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
