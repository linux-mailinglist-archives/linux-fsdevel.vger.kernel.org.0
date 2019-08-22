Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1E994B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbfHVNR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 09:17:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbfHVNR0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:17:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10E13CD345109B68C36D;
        Thu, 22 Aug 2019 21:17:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.208.128) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 21:17:22 +0800
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain>
 <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
 <20190821160551.GD9095@stefanha-x1.localdomain>
 <954b5f8a-4007-f29c-f38e-dd5585879541@huawei.com>
 <CAJfpegtBYLJLWM8GJ1h66PMf2J9o38FG6udcd2hmamEEQddf5w@mail.gmail.com>
 <0e8090c7-0c7c-bcbe-af75-33054d3a3efb@huawei.com>
 <CAJfpegurYLAApon5Ai6Q33vEy+GPxtOTUwDCCbJ2JAbg4csDSg@mail.gmail.com>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        <linux-fsdevel@vger.kernel.org>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
From:   wangyan <wangyan122@huawei.com>
Message-ID: <a19866be-3693-648e-ee6c-8d302c830834@huawei.com>
Date:   Thu, 22 Aug 2019 21:17:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegurYLAApon5Ai6Q33vEy+GPxtOTUwDCCbJ2JAbg4csDSg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.208.128]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/22 21:07, Miklos Szeredi wrote:
> On Thu, Aug 22, 2019 at 2:48 PM wangyan <wangyan122@huawei.com> wrote:
>>
>> On 2019/8/22 19:43, Miklos Szeredi wrote:
>>> On Thu, Aug 22, 2019 at 2:59 AM wangyan <wangyan122@huawei.com> wrote:
>>>> I will test it when I get the patch, and post the compared result with
>>>> 9p.
>>>
>>> Could you please try the attached patch?  My guess is that it should
>>> improve the performance, perhaps by a big margin.
>>>
>>> Further improvement is possible by eliminating page copies, but that
>>> is less trivial.
>>>
>>> Thanks,
>>> Miklos
>>>
>> Using the same test model. And the test result is:
>>         1. Latency
>>                 virtiofs: avg-lat is 15.40 usec, bigger than before(6.64 usec).
>>                 4K: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, iodepth=1
>>                 fio-2.13
>>                 Starting 1 process
>>                 Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/142.4MB/0KB /s] [0/36.5K/0
>> iops] [eta 00m:00s]
>>                 4K: (groupid=0, jobs=1): err= 0: pid=5528: Thu Aug 22 20:39:07 2019
>>                   write: io=6633.2MB, bw=226404KB/s, iops=56600, runt= 30001msec
>>                         clat (usec): min=2, max=40403, avg=14.77, stdev=33.71
>>                          lat (usec): min=3, max=40404, avg=15.40, stdev=33.74
>>
>>         2. Bandwidth
>>                 virtiofs: bandwidth is 280840KB/s, lower than before(691894KB/s).
>>                 1M: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=psync, iodepth=1
>>                 fio-2.13
>>                 Starting 1 process
>>                 Jobs: 1 (f=1): [f(1)] [100.0% done] [0KB/29755KB/0KB /s] [0/29/0 iops]
>> [eta 00m:00s]
>>                 1M: (groupid=0, jobs=1): err= 0: pid=5550: Thu Aug 22 20:41:28 2019
>>                   write: io=8228.0MB, bw=280840KB/s, iops=274, runt= 30001msec
>>                         clat (usec): min=362, max=11038, avg=3571.33, stdev=1062.72
>>                          lat (usec): min=411, max=11093, avg=3628.39, stdev=1064.53
>>
>> According to the result, the patch doesn't work and make it worse than
>> before.
>
> Is server started with "-owriteback"?
>
> Thanks,
> Miklos
>
> .
>

I used these commands:
virtiofsd cmd:
	./virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/mnt/share/ 
-o cache=always -o writeback
mount cmd:
	mount -t virtio_fs myfs /mnt/virtiofs -o 
rootmode=040000,user_id=0,group_id=0

Thanks,
Yan Wang

