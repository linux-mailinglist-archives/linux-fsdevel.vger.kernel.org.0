Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A77AA2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfG3NwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 09:52:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfG3NwT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:52:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC710200DE7754C3E6FA;
        Tue, 30 Jul 2019 21:52:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 21:52:08 +0800
Subject: Re: [PATCH v2] aio: add timeout validity check for io_[p]getevents
To:     Arnd Bergmann <arnd@arndb.de>
References: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
 <CAK8P3a233_UbX4roe-1Zr7d+3tn9me6hnBoqXsZcLToE_s_dag@mail.gmail.com>
CC:     linux-aio <linux-aio@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <bad8e43e-1b8b-90dd-b16e-c8784cbcc8d5@huawei.com>
Date:   Tue, 30 Jul 2019 21:52:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a233_UbX4roe-1Zr7d+3tn9me6hnBoqXsZcLToE_s_dag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/30 15:11, Arnd Bergmann Wrote:
> On Tue, Jul 30, 2019 at 3:46 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
> 
>>  {
>> -       ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
>> -       struct kioctx *ioctx = lookup_ioctx(ctx_id);
>> +       ktime_t until = KTIME_MAX;
>> +       struct kioctx *ioctx = NULL;
>>         long ret = -EINVAL;
>>
>> +       if (ts) {
>> +               if (!timespec64_valid(ts))
>> +                       return ret;
>> +               until = timespec64_to_ktime(*ts);
>> +       }
> 
> The man page should probably get updated as well to reflect that this
> will now return -EINVAL for a negative timeout or malformed
> nanoseconds.
> 

Thanks for your suggestion, I will add a patch to update the man page.

Thanks,
Yi.

