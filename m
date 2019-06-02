Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D695032279
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2019 09:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFBHfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jun 2019 03:35:10 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:45621 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfFBHfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jun 2019 03:35:09 -0400
Received: from c-73-193-85-113.hsd1.wa.comcast.net ([73.193.85.113] helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hXKXo-000XZY-I5; Sun, 02 Jun 2019 03:04:40 -0400
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
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
 <0d6e3c02-1952-2177-02d7-10ebeb133940@csail.mit.edu>
 <7B74A790-BD98-412B-ADAB-3B513FB1944E@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <6a6f4aa4-fc95-f132-55b2-224ff52bd2d8@csail.mit.edu>
Date:   Sun, 2 Jun 2019 00:04:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7B74A790-BD98-412B-ADAB-3B513FB1944E@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/19 3:45 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 30 mag 2019, alle ore 10:29, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>
[...]
>>
>> Your fix held up well under my testing :)
>>
> 
> Great!
> 
>> As for throughput, with low_latency = 1, I get around 1.4 MB/s with
>> bfq (vs 1.6 MB/s with mq-deadline). This is a huge improvement
>> compared to what it was before (70 KB/s).
>>
> 
> That's beautiful news!
> 
> So, now we have the best of the two worlds: maximum throughput and
> total control on I/O (including minimum latency for interactive and
> soft real-time applications).  Besides, no manual configuration
> needed.  Of course, this holds unless/until you find other flaws ... ;)
> 

Indeed, that's awesome! :)

>> With tracing on, the throughput is a bit lower (as expected I guess),
>> about 1 MB/s, and the corresponding trace file
>> (trace-waker-detection-1MBps) is available at:
>>
>> https://www.dropbox.com/s/3roycp1zwk372zo/bfq-traces.tar.gz?dl=0
>>
> 
> Thank you for the new trace.  I've analyzed it carefully, and, as I
> imagined, this residual 12% throughput loss is due to a couple of
> heuristics that occasionally get something wrong.  Most likely, ~12%
> is the worst-case loss, and if one repeats the tests, the loss may be
> much lower in some runs.
>

Ah, I see.
 
> I think it is very hard to eliminate this fluctuation while keeping
> full I/O control.  But, who knows, I might have some lucky idea in the
> future.
> 

:)

> At any rate, since you pointed out that you are interested in
> out-of-the-box performance, let me complete the context: in case
> low_latency is left set, one gets, in return for this 12% loss,
> a) at least 1000% higher responsiveness, e.g., 1000% lower start-up
> times of applications under load [1];
> b) 500-1000% higher throughput in multi-client server workloads, as I
> already pointed out [2].
> 

I'm very happy that you could solve the problem without having to
compromise on any of the performance characteristics/features of BFQ!


> I'm going to prepare complete patches.  In addition, if ok for you,
> I'll report these results on the bug you created.  Then I guess we can
> close it.
> 

Sounds great!

> [1] https://algo.ing.unimo.it/people/paolo/disk_sched/results.php
> [2] https://www.linaro.org/blog/io-bandwidth-management-for-production-quality-services/
> 
>> Thank you so much for your tireless efforts in fixing this issue!
>>
> 
> I did enjoy working on this with you: your test case and your support
> enabled me to make important improvements.  So, thank you very much
> for your collaboration so far,
> Paolo

My pleasure! :)
 
Regards,
Srivatsa
VMware Photon OS
