Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFC2600D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfEVJCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 05:02:48 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:47935 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbfEVJCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 05:02:48 -0400
Received: from c-73-193-85-113.hsd1.wa.comcast.net ([73.193.85.113] helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hTN8z-0009cO-OQ; Wed, 22 May 2019 05:02:41 -0400
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
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
 <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
 <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
 <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
 <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
 <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <f4b11315-144c-c67d-5143-50b5be950ede@csail.mit.edu>
Date:   Wed, 22 May 2019 02:02:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/19 1:05 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 22 mag 2019, alle ore 00:51, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>
>> [ Resending this mail with a dropbox link to the traces (instead
>> of a file attachment), since it didn't go through the last time. ]
>>
>> On 5/21/19 10:38 AM, Paolo Valente wrote:
>>>
>>>> So, instead of only sending me a trace, could you please:
>>>> 1) apply this new patch on top of the one I attached in my previous email
>>>> 2) repeat your test and report results
>>>
>>> One last thing (I swear!): as you can see from my script, I tested the
>>> case low_latency=0 so far.  So please, for the moment, do your test
>>> with low_latency=0.  You find the whole path to this parameter in,
>>> e.g., my script.
>>>
>> No problem! :) Thank you for sharing patches for me to test!
>>
>> I have good news :) Your patch improves the throughput significantly
>> when low_latency = 0.
>>
>> Without any patch:
>>
>> dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
>> 10000+0 records in
>> 10000+0 records out
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 58.0915 s, 88.1 kB/s
>>
>>
>> With both patches applied:
>>
>> dd if=/dev/zero of=/root/test0.img bs=512 count=10000 oflag=dsync
>> 10000+0 records in
>> 10000+0 records out
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.87487 s, 1.3 MB/s
>>
>> The performance is still not as good as mq-deadline (which achieves
>> 1.6 MB/s), but this is a huge improvement for BFQ nonetheless!
>>
>> A tarball with the trace output from the 2 scenarios you requested,
>> one with only the debug patch applied (trace-bfq-add-logs-and-BUG_ONs),
>> and another with both patches applied (trace-bfq-boost-injection) is
>> available here:
>>
>> https://www.dropbox.com/s/pdf07vi7afido7e/bfq-traces.tar.gz?dl=0
>>
> 
> Hi Srivatsa,
> I've seen the bugzilla you've created.  I'm a little confused on how
> to better proceed.  Shall we move this discussion to the bugzilla, or
> should we continue this discussion here, where it has started, and
> then update the bugzilla?
> 

Let's continue here on LKML itself. The only reason I created the
bugzilla entry is to attach the tarball of the traces, assuming
that it would allow me to upload a 20 MB file (since email attachment
didn't work). But bugzilla's file restriction is much smaller than
that, so it didn't work out either, and I resorted to using dropbox.
So we don't need the bugzilla entry anymore; I might as well close it
to avoid confusion.

Regards,
Srivatsa
VMware Photon OS

