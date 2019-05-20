Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8224390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfETWpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 18:45:55 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:53113 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfETWpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 18:45:55 -0400
Received: from [4.30.142.84] (helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hSr2T-000DNC-Gj; Mon, 20 May 2019 18:45:49 -0400
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, tytso@mit.edu, amakhalov@vmware.com,
        anishs@vmware.com, srivatsab@vmware.com
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <238e14ff-68d1-3b21-a291-28de4f2d77af@csail.mit.edu>
Date:   Mon, 20 May 2019 15:45:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/19 3:19 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>
>> On 5/18/19 11:39 AM, Paolo Valente wrote:
>>> I've addressed these issues in my last batch of improvements for BFQ,
>>> which landed in the upcoming 5.2. If you give it a try, and still see
>>> the problem, then I'll be glad to reproduce it, and hopefully fix it
>>> for you.
>>>
>>
>> Hi Paolo,
>>
>> Thank you for looking into this!
>>
>> I just tried current mainline at commit 72cf0b07, but unfortunately
>> didn't see any improvement:
>>
>> dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
>>
>> With mq-deadline, I get:
>>
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>>
>> With bfq, I get:
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>>
> 
> Hi Srivatsa,
> thanks for reproducing this on mainline.  I seem to have reproduced a
> bonsai-tree version of this issue.  Before digging into the block
> trace, I'd like to ask you for some feedback.
> 
> First, in my test, the total throughput of the disk happens to be
> about 20 times as high as that enjoyed by dd, regardless of the I/O
> scheduler.  I guess this massive overhead is normal with dsync, but
> I'd like know whether it is about the same on your side.  This will
> help me understand whether I'll actually be analyzing about the same
> problem as yours.
> 

Do you mean to say the throughput obtained by dd'ing directly to the
block device (bypassing the filesystem)? That does give me a 20x
speedup with bs=512, but much more with a bigger block size (achieving
a max throughput of about 110 MB/s).

dd if=/dev/zero of=/dev/sdc bs=512 count=10000 conv=fsync
10000+0 records in
10000+0 records out
5120000 bytes (5.1 MB, 4.9 MiB) copied, 0.15257 s, 33.6 MB/s

dd if=/dev/zero of=/dev/sdc bs=4k count=10000 conv=fsync
10000+0 records in
10000+0 records out
40960000 bytes (41 MB, 39 MiB) copied, 0.395081 s, 104 MB/s

I'm testing this on a Toshiba MG03ACA1 (1TB) hard disk.

> Second, the commands I used follow.  Do they implement your test case
> correctly?
> 
> [root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
> [root@localhost tmp]# echo $BASHPID > /sys/fs/cgroup/blkio/testgrp/cgroup.procs
> [root@localhost tmp]# cat /sys/block/sda/queue/scheduler
> [mq-deadline] bfq none
> [root@localhost tmp]# dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
> 10000+0 record dentro
> 10000+0 record fuori
> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
> [root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
> [root@localhost tmp]# dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
> 10000+0 record dentro
> 10000+0 record fuori
> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s
> 

Yes, this is indeed the testcase, although I see a much bigger
drop in performance with bfq, compared to the results from
your setup.

Regards,
Srivatsa
