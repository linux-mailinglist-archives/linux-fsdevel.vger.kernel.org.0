Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1C679C25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjAXOku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAXOkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:40:49 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067E1BF2;
        Tue, 24 Jan 2023 06:40:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Va7l73x_1674571240;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Va7l73x_1674571240)
          by smtp.aliyun-inc.com;
          Tue, 24 Jan 2023 22:40:42 +0800
Message-ID: <1d65be2f-6d3a-13c6-4982-66bbb0f9b530@linux.alibaba.com>
Date:   Tue, 24 Jan 2023 22:40:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/24 21:10, Alexander Larsson wrote:
> On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
>> On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>

...

>>
>> No it is not overlayfs, it is overlayfs+squashfs, please stick to
>> facts.
>> As Gao wrote, squashfs does not optimize directory lookup.
>> You can run a test with ext4 for POC as Gao suggested.
>> I am sure that mkfs.erofs sparse file support can be added if needed.
> 
> New measurements follow, they now include also erofs over loopback,
> although that isn't strictly fair, because that image is much larger
> due to the fact that it didn't store the files sparsely. It also
> includes a version where the topmost lower is directly on the backing
> xfs (i.e. not via loopback). I attached the scripts used to create the
> images and do the profiling in case anyone wants to reproduce.
> 
> Here are the results (on x86-64, xfs base fs):
> 
> overlayfs + loopback squashfs - uncached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):      2.483 s ±  0.029 s    [User: 0.167 s, System: 1.656 s]
>    Range (min … max):    2.427 s …  2.530 s    10 runs
>   
> overlayfs + loopback squashfs - cached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):     429.2 ms ±   4.6 ms    [User: 123.6 ms, System: 295.0 ms]
>    Range (min … max):   421.2 ms … 435.3 ms    10 runs
>   
> overlayfs + loopback ext4 - uncached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):      4.332 s ±  0.060 s    [User: 0.204 s, System: 3.150 s]
>    Range (min … max):    4.261 s …  4.442 s    10 runs
>   
> overlayfs + loopback ext4 - cached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):     528.3 ms ±   4.0 ms    [User: 143.4 ms, System: 381.2 ms]
>    Range (min … max):   521.1 ms … 536.4 ms    10 runs
>   
> overlayfs + loopback erofs - uncached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):      3.045 s ±  0.127 s    [User: 0.198 s, System: 1.129 s]
>    Range (min … max):    2.926 s …  3.338 s    10 runs
>   
> overlayfs + loopback erofs - cached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):     516.9 ms ±   5.7 ms    [User: 139.4 ms, System: 374.0 ms]
>    Range (min … max):   503.6 ms … 521.9 ms    10 runs
>   
> overlayfs + direct - uncached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):      2.562 s ±  0.028 s    [User: 0.199 s, System: 1.129 s]
>    Range (min … max):    2.497 s …  2.585 s    10 runs
>   
> overlayfs + direct - cached
> Benchmark 1: ls -lR mnt-ovl
>    Time (mean ± σ):     524.5 ms ±   1.6 ms    [User: 148.7 ms, System: 372.2 ms]
>    Range (min … max):   522.8 ms … 527.8 ms    10 runs
>   
> composefs - uncached
> Benchmark 1: ls -lR mnt-fs
>    Time (mean ± σ):     681.4 ms ±  14.1 ms    [User: 154.4 ms, System: 369.9 ms]
>    Range (min … max):   652.5 ms … 703.2 ms    10 runs
>   
> composefs - cached
> Benchmark 1: ls -lR mnt-fs
>    Time (mean ± σ):     390.8 ms ±   4.7 ms    [User: 144.7 ms, System: 243.7 ms]
>    Range (min … max):   382.8 ms … 399.1 ms    10 runs
> 
> For the uncached case, composefs is still almost four times faster than
> the fastest overlay combo (squashfs), and the non-squashfs versions are
> strictly slower. For the cached case the difference is less (10%) but
> with similar order of performance.
> 
> For size comparison, here are the resulting images:
> 
> 8.6M large.composefs
> 2.5G large.erofs
> 200M large.ext4
> 2.6M large.squashfs
Ok, I have to say I'm a bit surprised by these results. Just a wild guess,
`ls -lR` is a seq-like access, so that compressed data (assumed that you
use it) is benefited from it.  I cannot think of a proper cause before
looking into more.  EROFS is impacted since EROFS on-disk inodes are not
arranged together with the current mkfs.erofs implemenetation (it's just
a userspace implementation details, if people really care about it, I
will refine the implementation), and I will also implement such sparse
files later so that all on-disk inodes won't be impacted as well (I'm on
vacation, but I will try my best).

 From the overall results, I don't really know what's the most bottleneck
point honestly:
   maybe just like what you said -- due to overlayfs overhead;
   or maybe a bottleneck of loopback device.

   so it's much better to show some results of "ls -lR" without overlayfs
stacked too.

IMHO, Amir's main point is always [1]
"w.r.t overlayfs, I am not even sure that anything needs to be modified
  in the driver.
  overlayfs already supports "metacopy" feature which means that an upper
  layer could be composed in a way that the file content would be read
  from an arbitrary path in lower fs, e.g. objects/cc/XXX. "

I think there is nothing wrong with it (except for fsverity). From the
results, such functionality indeed can already be achieved by overlayfs
+ some localfs with some user-space adaption. And it was not mentioned
in RFC and v2.

So without fs-verity requirement, currently your proposal is mainly
resolving a performance issue of an exist in-kernel approach (except for
unprivileged mounts).  It's much better to describe in the cover letter
-- The original problem, why overlayfs + (localfs or FUSE for metadata)
doesn't meet the requirements.  That makes much sense compared with the
current cover letter.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com/
