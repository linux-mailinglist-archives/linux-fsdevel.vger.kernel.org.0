Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0792F887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfE3I3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 04:29:33 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:56488 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbfE3I3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 04:29:32 -0400
Received: from c-73-193-85-113.hsd1.wa.comcast.net ([73.193.85.113] helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hWGRC-000QA7-QF; Thu, 30 May 2019 04:29:26 -0400
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
 <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
 <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
 <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
 <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
 <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
 <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
 <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
 <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
 <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
 <2A58C239-EF3F-422B-8D87-E7A3B500C57C@linaro.org>
 <a04368ba-f1d5-8f2c-1279-a685a137d024@csail.mit.edu>
 <E270AD92-943E-4529-8158-AB480D6D9DF8@linaro.org>
 <5b71028c-72f0-73dd-0cd5-f28ff298a0a3@csail.mit.edu>
 <FFA44D26-75FF-4A8E-A331-495349BE5FFC@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <0d6e3c02-1952-2177-02d7-10ebeb133940@csail.mit.edu>
Date:   Thu, 30 May 2019 01:29:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <FFA44D26-75FF-4A8E-A331-495349BE5FFC@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/19 12:41 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 29 mag 2019, alle ore 03:09, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>
>> On 5/23/19 11:51 PM, Paolo Valente wrote:
>>>
>>>> Il giorno 24 mag 2019, alle ore 01:43, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>>>
>>>> When trying to run multiple dd tasks simultaneously, I get the kernel
>>>> panic shown below (mainline is fine, without these patches).
>>>>
>>>
>>> Could you please provide me somehow with a list *(bfq_serv_to_charge+0x21) ?
>>>
>>
>> Hi Paolo,
>>
>> Sorry for the delay! Here you go:
>>
>> (gdb) list *(bfq_serv_to_charge+0x21)
>> 0xffffffff814bad91 is in bfq_serv_to_charge (./include/linux/blkdev.h:919).
>> 914
>> 915	extern unsigned int blk_rq_err_bytes(const struct request *rq);
>> 916
>> 917	static inline unsigned int blk_rq_sectors(const struct request *rq)
>> 918	{
>> 919		return blk_rq_bytes(rq) >> SECTOR_SHIFT;
>> 920	}
>> 921
>> 922	static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
>> 923	{
>> (gdb)
>>
>>
>> For some reason, I've not been able to reproduce this issue after
>> reporting it here. (Perhaps I got lucky when I hit the kernel panic
>> a bunch of times last week).
>>
>> I'll test with your fix applied and see how it goes.
>>
> 
> Great!  the offending line above gives me hope that my fix is correct.
> If no more failures occur, then I'm eager (and a little worried ...)
> to see how it goes with throughput :)
> 

Your fix held up well under my testing :)

As for throughput, with low_latency = 1, I get around 1.4 MB/s with
bfq (vs 1.6 MB/s with mq-deadline). This is a huge improvement
compared to what it was before (70 KB/s).

With tracing on, the throughput is a bit lower (as expected I guess),
about 1 MB/s, and the corresponding trace file
(trace-waker-detection-1MBps) is available at:

https://www.dropbox.com/s/3roycp1zwk372zo/bfq-traces.tar.gz?dl=0

Thank you so much for your tireless efforts in fixing this issue!

Regards,
Srivatsa
VMware Photon OS
