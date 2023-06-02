Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550271F743
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjFBArV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 20:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFBArP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:47:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E4F2
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 17:47:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652d76be8c2so267319b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 17:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685666833; x=1688258833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnRu1Ekfwdrg+A5ovmm5zAEOw3CprjRg24Z8Orpw2uQ=;
        b=G4i8C4zWjxUOnmWFk275VeIb5Nf5EbYvlVFFwXn1P9CavvdsBXavproFw2wDQG4QxW
         GmRaRZbRzNfj63dNAAbv9OQRD18qR6e4W1cpK8ZKzyRMUvZJmdwSJpgMcKp2SNS0j7Xo
         q6A4ECaQ/BGboYDydc6kylLtRZrye/YiH6kNScQ1TJMoEYho7SKRf7OUBIQ7jFq4EuzN
         gsj/eje/a6BwmP62P42E2aIo1dP3k62QOLers62506N4TKHVYuuhDZW99l6cHI/C6wLP
         HEil1y7R5mH+hPLc6raTBWYSkHlgd5224knKmZ1QyXUKBP+Bm7/7gsaCZGsmLcLDOv6T
         d7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685666833; x=1688258833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnRu1Ekfwdrg+A5ovmm5zAEOw3CprjRg24Z8Orpw2uQ=;
        b=ephsytCzun7y9P8PYvTftA17tPVMgleizg8xMwy8aWj3Ew9TqBILoGldkk8jMfw423
         2KbGbYYEqYaSUnIC7GCRIuWENi02OzbgIv/X4VonAy7M3GtAmApBmuvK/1OPclQhofq2
         rr72n6UjrzCdWgO1H4yk1GMC4BzqnR0rD43jknf9DDPU5P7siDyHpYA5ksq5zvfPyCr3
         LOzb/CEjHo0CdZT0fHFmSHAfrIX5vdDL/hwprKZRKob94J5E5NDPGtKcNhHT5krizsSn
         jnRJXS2cVGSM5vhCgD66yCUQu2xPpaBWW74TjK/yKEwdtFnM78kSfi/QvLDyenxaqub3
         oPyQ==
X-Gm-Message-State: AC+VfDzT3xR9J2F7pf/GGbKP6wEC6EZ95D19gX3hBIj/0Uaetve1+XtQ
        nz/sM6+xAMZoePaw+ZmJNsJ2Ow==
X-Google-Smtp-Source: ACHHUZ4tCstGkq0nK4V8as/QJveHny4XYvHGVGmmtU2Xd7gEov81zmYTX54nuOiWypaNhQDCM0l01Q==
X-Received: by 2002:a05:6a00:16c5:b0:64d:5f1d:3d77 with SMTP id l5-20020a056a0016c500b0064d5f1d3d77mr12571067pfc.34.1685666833094;
        Thu, 01 Jun 2023 17:47:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b0063b86aff031sm5648713pfn.108.2023.06.01.17.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 17:47:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4swg-006i6z-0M;
        Fri, 02 Jun 2023 10:47:10 +1000
Date:   Fri, 2 Jun 2023 10:47:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Chen, Zhiyin" <zhiyin.chen@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zou, Nanhai" <nanhai.zou@intel.com>,
        "Feng, Xiaotian" <xiaotian.feng@intel.com>
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <ZHk8Dmvr1hl/o6+a@dread.disaster.area>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
 <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
 <ZHfKmG5RtgrMb6OT@dread.disaster.area>
 <CO1PR11MB49317EB3364DB47F1FF6839FE4499@CO1PR11MB4931.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB49317EB3364DB47F1FF6839FE4499@CO1PR11MB4931.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:47:53AM +0000, Chen, Zhiyin wrote:
> Good questions.
> perf has been applied to analyze the performance. In the syscall test, the patch can 
> reduce the CPU cycles for filp_close. Besides, the HITM count is also reduced from 
> 43182 to 33146.
> The test is not restricted to a set of adjacent cores. The numactl command is only 
> used to limit the number of processing cores.

And, in doing so, it limits the physical locality of the cores being
used to 3-18. That effectively puts them all on the socket because
the test is not using all 16 CPUs and the scheduler tends to put all
related tasks on the same socket if there are enoguh idle CPUs to do
so....

> In most situations, only 8/16/32 CPU 
> cores are used. Performance improvement is still obvious, even if non-adjacent 
> CPU cores are used.
> 
> No matter what CPU type, cache size, or architecture, false sharing is always 
> negative on performance. And the read mostly members should be put together.
> 
> To further prove the updated layout effectiveness on some other codes path, 
> results of fsdisk, fsbuffer, and fstime are also shown in the new commit message. 
> 
> Actually, the new layout can only reduce false sharing in high-contention situations. 
> The performance gain is not obvious, if there are some other bottlenecks. For 
> instance, if the cores are spread across multiple sockets, memory access may be 
> the new bottleneck due to NUMA.
> 
> Here are the results across NUMA nodes. The patch has no negative effect on the
> performance result.
> 
> Command:  numactl -C 0-3,16-19,63-66,72-75 ./Run -c 16 syscall fstime fsdisk fsbuffer
> With Patch
> Benchmark Run: Thu Jun 01 2023 03:13:52 - 03:23:15
> 224 CPUs in system; running 16 parallel copies of tests
> 
> File Copy 1024 bufsize 2000 maxblocks        589958.6 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks          148779.2 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks       1968023.8 KBps  (30.0 s, 2 samples)
> System Call Overhead                        5804316.1 lps   (10.0 s, 7 samples)

Ok, so very small data buffers and file sizes which means the
working set of the benchmark is almost certainly going to be CPU
cache resident.

This is a known problem with old IO benchmarks on modern CPUs - the
data set is small enough that it often fits mostly in the CPU cache
and so small variations in code layout can make 20-30%
difference in performance for file copy benchmarks. Use a different
compiler, or even a different filesystem, and the amazing gain
goes away and may even result in a regression....

For example, this has been a known problem with IOZone for at least
15 years now, making it largely unreliable as a benchmarking tool.
Unless, of course, you know exactly what you are doing and can avoid
all the tests that are susceptible to CPU cache residency
variations....

> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     589958.6   1489.8
> File Copy 256 bufsize 500 maxblocks            1655.0     148779.2    899.0
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1968023.8   3393.1
> System Call Overhead                          15000.0    5804316.1   3869.5
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         2047.8
> 
> Without Patch
> Benchmark Run: Thu Jun 01 2023 02:11:45 - 02:21:08
> 224 CPUs in system; running 16 parallel copies of tests
> 
> File Copy 1024 bufsize 2000 maxblocks        571829.9 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks          147693.8 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks       1938854.5 KBps  (30.0 s, 2 samples)
> System Call Overhead                        5791936.3 lps   (10.0 s, 7 samples)
> 
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     571829.9   1444.0
> File Copy 256 bufsize 500 maxblocks            1655.0     147693.8    892.4
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1938854.5   3342.9
> System Call Overhead                          15000.0    5791936.3   3861.3
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         2019.5

Yeah, that's what I thought we'd see. i.e. as soon as we go
off-socket, there's no actual performance change. This generally
means there is no difference in cacheline sharing across CPUs
between the two tests. You can likely use `perf stat` to confirm
this from the hardware l1/l2/llc data cache miss counters; I'd guess
they are nearly identical with/without the patch.

If this truly was a false cacheline sharing situation, the
cross-socket test results should measurably increase in perofrmance
as the frequently accessed read-only data cacheline is shared across
all CPU caches instead of being bounced exclusively between CPUs.
The amount of l1/l2/llc data cache misses during the workload should
reduce measurably if this is happening.

As a technical note, if you want to split data out into different
cachelines, you should be using annotations like
'____cacheline_aligned_in_smp' to align structures and variables
inside structures to the start of a new cacheline. Not only is this
self documenting, it will pad the structure appropriately to ensure
that the update-heavy variable(s) you want isolated to a new
cacheline are actually on a separate cacheline.  It may be that the
manual cacheline separation isn't quite good enough to show
improvement on multi-socket machines, so improving the layout via
explicit alignment directives may show further improvement.

FYI, here's an example of how avoiding false sharing should improve
performance when we go off-socket. Here's a comparison of the same
16-way workload, one on a 2x8p dual socket machine (machine A), the
other running on a single 16p CPU core (machine B). The workload
used 99% of all available CPU doing bulk file removal.

commit b0dff466c00975a3e3ec97e6b0266bfd3e4805d6
Author: Dave Chinner <dchinner@redhat.com>
Date:   Wed May 20 13:17:11 2020 -0700

    xfs: separate read-only variables in struct xfs_mount
    
    Seeing massive cpu usage from xfs_agino_range() on one machine;
    instruction level profiles look similar to another machine running
    the same workload, only one machine is consuming 10x as much CPU as
    the other and going much slower. The only real difference between
    the two machines is core count per socket. Both are running
    identical 16p/16GB virtual machine configurations
    
    Machine A:
    
      25.83%  [k] xfs_agino_range
      12.68%  [k] __xfs_dir3_data_check
       6.95%  [k] xfs_verify_ino
       6.78%  [k] xfs_dir2_data_entry_tag_p
       3.56%  [k] xfs_buf_find
       2.31%  [k] xfs_verify_dir_ino
       2.02%  [k] xfs_dabuf_map.constprop.0
       1.65%  [k] xfs_ag_block_count
    
    And takes around 13 minutes to remove 50 million inodes.
    
    Machine B:
    
      13.90%  [k] __pv_queued_spin_lock_slowpath
       3.76%  [k] do_raw_spin_lock
       2.83%  [k] xfs_dir3_leaf_check_int
       2.75%  [k] xfs_agino_range
       2.51%  [k] __raw_callee_save___pv_queued_spin_unlock
       2.18%  [k] __xfs_dir3_data_check
       2.02%  [k] xfs_log_commit_cil
    
    And takes around 5m30s to remove 50 million inodes.
    
    Suspect is cacheline contention on m_sectbb_log which is used in one
    of the macros in xfs_agino_range. This is a read-only variable but
    shares a cacheline with m_active_trans which is a global atomic that
    gets bounced all around the machine.
    
    The workload is trying to run hundreds of thousands of transactions
    per second and hence cacheline contention will be occurring on this
    atomic counter. Hence xfs_agino_range() is likely just be an
    innocent bystander as the cache coherency protocol fights over the
    cacheline between CPU cores and sockets.
    
    On machine A, this rearrangement of the struct xfs_mount
    results in the profile changing to:
    
       9.77%  [kernel]  [k] xfs_agino_range
       6.27%  [kernel]  [k] __xfs_dir3_data_check
       5.31%  [kernel]  [k] __pv_queued_spin_lock_slowpath
       4.54%  [kernel]  [k] xfs_buf_find
       3.79%  [kernel]  [k] do_raw_spin_lock
       3.39%  [kernel]  [k] xfs_verify_ino
       2.73%  [kernel]  [k] __raw_callee_save___pv_queued_spin_unlock
    
    Vastly less CPU usage in xfs_agino_range(), but still 3x the amount
    of machine B and still runs substantially slower than it should.
    
    Current rm -rf of 50 million files:
    
                    vanilla         patched
    machine A       13m20s          6m42s
    machine B       5m30s           5m02s
    
    It's an improvement, hence indicating that separation and further
    optimisation of read-only global filesystem data is worthwhile, but
    it clearly isn't the underlying issue causing this specific
    performance degradation.
    
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
    Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Notice how much of an improvement occurred on the 2x8p system vs a
single 16p core when the false sharing was removed? The 16p core
showed ~10% reduction in CPU time, whilst the 2x8p showed a 50%
reduction in CPU time. That's the sort of gains I'd expect if false
sharing was an issue for this workload. The lack of multi-socket
performance improvement tends to indicate that false sharing is not
occurring and that something else has resulted in the single socket
performance increases....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
