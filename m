Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346553DC814
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGaTwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 15:52:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhGaTwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 15:52:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EFBF01F42E77
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
Organization: Collabora
References: <20210720155944.1447086-9-krisman@collabora.com>
        <20210731063818.GB18773@xsang-OptiPlex-9020>
        <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
Date:   Sat, 31 Jul 2021 15:51:52 -0400
In-Reply-To: <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
        (Amir Goldstein's message of "Sat, 31 Jul 2021 12:27:43 +0300")
Message-ID: <87lf5mi7mv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -3.3% regression of unixbench.score due to commit:
>>
>>
>> commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
>> url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
>> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
>>
>> in testcase: unixbench
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
>> with following parameters:
>>
>>         runtime: 300s
>>         nr_task: 1
>>         test: pipe
>>         cpufreq_governor: performance
>>         ucode: 0x4003006
>>
>> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
>> test-url: https://github.com/kdlucas/byte-unixbench
>>
>> In addition to that, the commit also has significant impact on the following tests:
>>
>> +------------------+-------------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
>> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
>> | test parameters  | cpufreq_governor=performance                                                        |
>> |                  | mode=thread                                                                         |
>> |                  | nr_task=100%                                                                        |
>> |                  | test=eventfd1                                                                       |
>> |                  | ucode=0x5003006                                                                     |
>> +------------------+-------------------------------------------------------------------------------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>
> Gabriel,
>
> It looks like my change throws away much of the performance gain for
> small IO on pipes without any watches that was achieved by commit
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> when there is no watcher").
>
> I think the way to fix it is to lift the optimization in __fsnotify()
> to the fsnotify_parent() inline wrapper as Mel considered doing
> but was not sure it was worth the effort at the time.
>
> It's not completely trivial. I think it requires setting a flag
> MNT_FSNOTIFY_WATCHED when there are watches on the
> vfsmount. I will look into it.

Amir,

Since this patch is a clean up, would you mind if I drop it from my
series and base my work on top of mainline? Eventually, we can rebase
this patch, when the performance issue is addressed.

I ask because I'm about to send a v5 and I'm not sure if I should wait
to have this fixed.

-- 
Gabriel Krisman Bertazi
