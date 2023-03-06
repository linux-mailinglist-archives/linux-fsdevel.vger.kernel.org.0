Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C906AC7A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCFQVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCFQUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:20:47 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A713F94D
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 08:18:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdI8MCJ_1678119436;
Received: from 192.168.5.103(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdI8MCJ_1678119436)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 00:17:17 +0800
Message-ID: <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 00:17:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
 <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/7 00:09, Alexander Larsson wrote:
> On Mon, Mar 6, 2023 at 4:49 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>> On 3/6/23 7:33 PM, Alexander Larsson wrote:
>>> On Fri, Mar 3, 2023 at 2:57 PM Alexander Larsson <alexl@redhat.com> wrote:
>>>>
>>>> On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
>>>>> Composefs filesystem. It is an opportunistically sharing, validating
>>>>> image-based filesystem, targeting usecases like validated ostree
>>>>> rootfs:es, validated container images that share common files, as well
>>>>> as other image based usecases.
>>>>>
>>>>> During the discussions in the composefs proposal (as seen on LWN[3])
>>>>> is has been proposed that (with some changes to overlayfs), similar
>>>>> behaviour can be achieved by combining the overlayfs
>>>>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>>>>>
>>>>> There are pros and cons to both these approaches, and the discussion
>>>>> about their respective value has sometimes been heated. We would like
>>>>> to have an in-person discussion at the summit, ideally also involving
>>>>> more of the filesystem development community, so that we can reach
>>>>> some consensus on what is the best apporach.
>>>>
>>>> In order to better understand the behaviour and requirements of the
>>>> overlayfs+erofs approach I spent some time implementing direct support
>>>> for erofs in libcomposefs. So, with current HEAD of
>>>> github.com/containers/composefs you can now do:
>>>>
>>>> $ mkcompose --digest-store=objects --format=erofs source-dir image.erofs
>>>>
>>>> This will produce an object store with the backing files, and a erofs
>>>> file with the required overlayfs xattrs, including a made up one
>>>> called "overlay.fs-verity" containing the expected fs-verity digest
>>>> for the lower dir. It also adds the required whiteouts to cover the
>>>> 00-ff dirs from the lower dir.
>>>>
>>>> These erofs files are ordered similarly to the composefs files, and we
>>>> give similar guarantees about their reproducibility, etc. So, they
>>>> should be apples-to-apples comparable with the composefs images.
>>>>
>>>> Given this, I ran another set of performance tests on the original cs9
>>>> rootfs dataset, again measuring the time of `ls -lR`. I also tried to
>>>> measure the memory use like this:
>>>>
>>>> # echo 3 > /proc/sys/vm/drop_caches
>>>> # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
>>>> /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>>>>
>>>> These are the alternatives I tried:
>>>>
>>>> xfs: the source of the image, regular dir on xfs
>>>> erofs: the image.erofs above, on loopback
>>>> erofs dio: the image.erofs above, on loopback with --direct-io=on
>>>> ovl: erofs above combined with overlayfs
>>>> ovl dio: erofs dio above combined with overlayfs
>>>> cfs: composefs mount of image.cfs
>>>>
>>>> All tests use the same objects dir, stored on xfs. The erofs and
>>>> overlay implementations are from a stock 6.1.13 kernel, and composefs
>>>> module is from github HEAD.
>>>>
>>>> I tried loopback both with and without the direct-io option, because
>>>> without direct-io enabled the kernel will double-cache the loopbacked
>>>> data, as per[1].
>>>>
>>>> The produced images are:
>>>>   8.9M image.cfs
>>>> 11.3M image.erofs
>>>>
>>>> And gives these results:
>>>>             | Cold cache | Warm cache | Mem use
>>>>             |   (msec)   |   (msec)   |  (mb)
>>>> -----------+------------+------------+---------
>>>> xfs        |   1449     |    442     |    54
>>>> erofs      |    700     |    391     |    45
>>>> erofs dio  |    939     |    400     |    45
>>>> ovl        |   1827     |    530     |   130
>>>> ovl dio    |   2156     |    531     |   130
>>>> cfs        |    689     |    389     |    51
>>>
>>> It has been noted that the readahead done by kernel_read() may cause
>>> read-ahead of unrelated data into memory which skews the results in
>>> favour of workloads that consume all the filesystem metadata (such as
>>> the ls -lR usecase of the above test). In the table above this favours
>>> composefs (which uses kernel_read in some codepaths) as well as
>>> non-dio erofs (non-dio loopback device uses readahead too).
>>>
>>> I updated composefs to not use kernel_read here:
>>>    https://github.com/containers/composefs/pull/105
>>>
>>> And a new kernel patch-set based on this is available at:
>>>    https://github.com/alexlarsson/linux/tree/composefs
>>>
>>> The resulting table is now (dropping the non-dio erofs):
>>>
>>>             | Cold cache | Warm cache | Mem use
>>>             |   (msec)   |   (msec)   |  (mb)
>>> -----------+------------+------------+---------
>>> xfs        |   1449     |    442     |   54
>>> erofs dio  |    939     |    400     |   45
>>> ovl dio    |   2156     |    531     |  130
>>> cfs        |    833     |    398     |   51
>>>
>>>             | Cold cache | Warm cache | Mem use
>>>             |   (msec)   |   (msec)   |  (mb)
>>> -----------+------------+------------+---------
>>> ext4       |   1135     |    394     |   54
>>> erofs dio  |    922     |    401     |   45
>>> ovl dio    |   1810     |    532     |  149
>>> ovl lazy   |   1063     |    523     |  87
>>> cfs        |    768     |    459     |  51
>>>
>>> So, while cfs is somewhat worse now for this particular usecase, my
>>> overall analysis still stands.
>>>
>>
>> Hi,
>>
>> I tested your patch removing kernel_read(), and here is the statistics
>> tested in my environment.
>>
>>
>> Setup
>> ======
>> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
>> Disk: cloud disk, 11800 IOPS upper limit
>> OS: Linux v6.2
>> FS of backing objects: xfs
>>
>>
>> Image size
>> ===========
>> 8.6M large.composefs (with --compute-digest)
>> 8.9M large.erofs (mkfs.erofs)
>> 11M  large.cps.in.erofs (mkfs.composefs --compute-digest --format=erofs)
>>
>>
>> Perf of "ls -lR"
>> ================
>>                                                | uncached| cached
>>                                                |  (ms)   |  (ms)
>> ----------------------------------------------|---------|--------
>> composefs                                          | 519        | 178
>> erofs (mkfs.erofs, DIRECT loop)                    | 497        | 192
>> erofs (mkfs.composefs --format=erofs, DIRECT loop) | 536        | 199
>>
>> I tested the performance of "ls -lR" on the whole tree of
>> cs9-developer-rootfs.  It seems that the performance of erofs (generated
>> from mkfs.erofs) is slightly better than that of composefs.  While the
>> performance of erofs generated from mkfs.composefs is slightly worse
>> that that of composefs.
> 
> I suspect that the reason for the lower performance of mkfs.composefs
> is the added overlay.fs-verity xattr to all the files. It makes the
> image larger, and that means more i/o.

Actually you could move overlay.fs-verity to EROFS shared xattr area (or
even overlay.redirect but it depends) if needed, which could save some
I/Os for your workloads.

shared xattrs can be used in this way as well if you care such minor
difference, actually I think inlined xattrs for your workload are just
meaningful for selinux labels and capabilities.

Thanks,
Gao Xiang
