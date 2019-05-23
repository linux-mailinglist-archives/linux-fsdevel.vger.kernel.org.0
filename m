Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48C2745F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfEWCa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 22:30:27 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:36078 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbfEWCa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 22:30:27 -0400
Received: from [4.30.142.84] (helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hTdUn-000CNl-Vx; Wed, 22 May 2019 22:30:18 -0400
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
 <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
 <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
Date:   Wed, 22 May 2019 19:30:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/19 3:54 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 22 mag 2019, alle ore 12:01, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
>>
>> On 5/22/19 2:09 AM, Paolo Valente wrote:
>>>
>>> First, thank you very much for testing my patches, and, above all, for
>>> sharing those huge traces!
>>>
>>> According to the your traces, the residual 20% lower throughput that you
>>> record is due to the fact that the BFQ injection mechanism takes a few
>>> hundredths of seconds to stabilize, at the beginning of the workload.
>>> During that setup time, the throughput is equal to the dreadful ~60-90 KB/s
>>> that you see without this new patch.  After that time, there
>>> seems to be no loss according to the trace.
>>>
>>> The problem is that a loss lasting only a few hundredths of seconds is
>>> however not negligible for a write workload that lasts only 3-4
>>> seconds.  Could you please try writing a larger file?
>>>
>>
>> I tried running dd for longer (about 100 seconds), but still saw around
>> 1.4 MB/s throughput with BFQ, and between 1.5 MB/s - 1.6 MB/s with
>> mq-deadline and noop.
> 
> Ok, then now the cause is the periodic reset of the mechanism.
> 
> It would be super easy to fill this gap, by just gearing the mechanism
> toward a very aggressive injection.  The problem is maintaining
> control.  As you can imagine from the performance gap between CFQ (or
> BFQ with malfunctioning injection) and BFQ with this fix, it is very
> hard to succeed in maximizing the throughput while at the same time
> preserving control on per-group I/O.
> 

Ah, I see. Just to make sure that this fix doesn't overly optimize for
total throughput (because of the testcase we've been using) and end up
causing regressions in per-group I/O control, I ran a test with
multiple simultaneous dd instances, each writing to a different
portion of the filesystem (well separated, to induce seeks), and each
dd task bound to its own blkio cgroup. I saw similar results with and
without this patch, and the throughput was equally distributed among
all the dd tasks.

> On the bright side, you might be interested in one of the benefits
> that BFQ gives in return for this ~10% loss of throughput, in a
> scenario that may be important for you (according to affiliation you
> report): from ~500% to ~1000% higher throughput when you have to serve
> the I/O of multiple VMs, and to guarantee at least no starvation to
> any VM [1].  The same holds with multiple clients or containers, and
> in general with any set of entities that may compete for storage.
> 
> [1] https://www.linaro.org/blog/io-bandwidth-management-for-production-quality-services/
> 

Great article! :) Thank you for sharing it!

>> But I'm not too worried about that difference.
>>
>>> In addition, I wanted to ask you whether you measured BFQ throughput
>>> with traces disabled.  This may make a difference.
>>>
>>
>> The above result (1.4 MB/s) was obtained with traces disabled.
>>
>>> After trying writing a larger file, you can try with low_latency on.
>>> On my side, it causes results to become a little unstable across
>>> repetitions (which is expected).
>>>
>> With low_latency on, I get between 60 KB/s - 100 KB/s.
>>
> 
> Gosh, full regression.  Fortunately, it is simply meaningless to use
> low_latency in a scenario where the goal is to guarantee per-group
> bandwidths.  Low-latency heuristics, to reach their (low-latency)
> goals, modify the I/O schedule compared to the best schedule for
> honoring group weights and boosting throughput.  So, as recommended in
> BFQ documentation, just switch low_latency off if you want to control
> I/O with groups.  It may still make sense to leave low_latency on
> in some specific case, which I don't want to bother you about.
> 

My main concern here is about Linux's I/O performance out-of-the-box,
i.e., with all default settings, which are:

- cgroups and blkio enabled (systemd default)
- blkio non-root cgroups in use (this is the implicit systemd behavior
  if docker is installed; i.e., it runs tasks under user.slice)
- I/O scheduler with blkio group sched support: bfq
- bfq default configuration: low_latency = 1

If this yields a throughput that is 10x-30x slower than what is
achievable, I think we should either fix the code (if possible) or
change the defaults such that they don't lead to this performance
collapse (perhaps default low_latency to 0 if bfq group scheduling
is in use?)

> However, I feel bad with such a low throughput :)  Would you be so
> kind to provide me with a trace?
> 
Certainly! Short runs of dd resulted in a lot of variation in the
throughput (between 60 KB/s - 1 MB/s), so I increased dd's runtime
to get repeatable numbers (~70 KB/s). As a result, the trace file
(trace-bfq-boost-injection-low-latency-71KBps) is quite large, and
is available here:

https://www.dropbox.com/s/svqfbv0idcg17pn/bfq-traces.tar.gz?dl=0

Also, I'm very happy to run additional tests or experiments to help
track down this issue. So, please don't hesitate to let me know if
you'd like me to try anything else or get you additional traces etc. :)

Thank you!

Regards,
Srivatsa
VMware Photon OS
