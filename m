Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F280312A95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 07:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBHGNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 01:13:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12460 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBHGNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:13:04 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYwdF4CldzjK9j;
        Mon,  8 Feb 2021 14:11:13 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 14:12:10 +0800
Subject: Re: [PATCH] fs/buffer.c: Add checking buffer head stat before clear
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yang Guo <guoyang2@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nick Piggin <npiggin@suse.de>
References: <1612332890-57918-1-git-send-email-zhangshaokun@hisilicon.com>
 <20210205154548.49dd62b161b794b9f29026f1@linux-foundation.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <dbf9670a-13c8-634b-b10b-7da19c7c50be@hisilicon.com>
Date:   Mon, 8 Feb 2021 14:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20210205154548.49dd62b161b794b9f29026f1@linux-foundation.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

ÔÚ 2021/2/6 7:45, Andrew Morton Ð´µÀ:
> On Wed, 3 Feb 2021 14:14:50 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> From: Yang Guo <guoyang2@huawei.com>
>>
>> clear_buffer_new() is used to clear buffer new stat. When PAGE_SIZE
>> is 64K, most buffer heads in the list are not needed to clear.
>> clear_buffer_new() has an enpensive atomic modification operation,
>> Let's add checking buffer head before clear it as __block_write_begin_int
>> does which is good for performance.
> 
> Did this produce any measurable improvement?

It has been tested on Huwei Kunpeng 920 which is ARM64 platform and test commond is below:
numactl --cpunodebind=0 --membind=0 fio -name=randwrite -numjobs=16 -filename=/mnt/test1
-rw=randwrite -ioengine=libaio -direct=0 -iodepth=64 -sync=0 -norandommap -group_reporting
-runtime=60 -time_based -bs=4k -size=5G

The test result before patch:
WRITE: bw=930MiB/s (976MB/s), 930MiB/s-930MiB/s (976MB/s-976MB/s), io=54.5GiB (58.5GB),
run=60001-60001msec

The test result after patch:
WRITE: bw=958MiB/s (1005MB/s), 958MiB/s-958MiB/s (1005MB/s-1005MB/s), io=56.1GiB (60.3GB),
run=60001-60001msec

> 
> Perhaps we should give clear_buffer_x() the same optimization as
> set_buffer_x()?
> 

Good catch,
but we check it more about it, if we do it the same as set_buffer_x(),
many more codes will be fixed, such as ext4_wait_block_bitmap
it has done sanity check using buffer_new and clear_buffer_new
will check it again.

Thanks,
Shaokun

> 
> static __always_inline void set_buffer_##name(struct buffer_head *bh)	\
> {									\
> 	if (!test_bit(BH_##bit, &(bh)->b_state))			\
> 		set_bit(BH_##bit, &(bh)->b_state);			\
> }									\
> static __always_inline void clear_buffer_##name(struct buffer_head *bh)	\
> {									\
> 	clear_bit(BH_##bit, &(bh)->b_state);				\
> }									\
> 
> 
> .
> 
