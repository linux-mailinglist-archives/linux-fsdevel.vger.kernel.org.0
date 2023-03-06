Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E506ABF47
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCFMPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 07:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCFMPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:15:40 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F320D20
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 04:15:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdGQCAk_1678104928;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdGQCAk_1678104928)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 20:15:29 +0800
Message-ID: <e595f640-53e2-cd6a-f169-e1567c4ff73b@linux.alibaba.com>
Date:   Mon, 6 Mar 2023 20:15:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/6 19:33, Alexander Larsson wrote:
> On Fri, Mar 3, 2023 at 2:57 PM Alexander Larsson <alexl@redhat.com> wrote:
>>
>> On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
>>>
>>> Hello,
>>>
>>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
>>> Composefs filesystem. It is an opportunistically sharing, validating
>>> image-based filesystem, targeting usecases like validated ostree
>>> rootfs:es, validated container images that share common files, as well
>>> as other image based usecases.
>>>
>>> During the discussions in the composefs proposal (as seen on LWN[3])
>>> is has been proposed that (with some changes to overlayfs), similar
>>> behaviour can be achieved by combining the overlayfs
>>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>>>
>>> There are pros and cons to both these approaches, and the discussion
>>> about their respective value has sometimes been heated. We would like
>>> to have an in-person discussion at the summit, ideally also involving
>>> more of the filesystem development community, so that we can reach
>>> some consensus on what is the best apporach.
>>
>> In order to better understand the behaviour and requirements of the
>> overlayfs+erofs approach I spent some time implementing direct support
>> for erofs in libcomposefs. So, with current HEAD of
>> github.com/containers/composefs you can now do:
>>
>> $ mkcompose --digest-store=objects --format=erofs source-dir image.erofs
>>
>> This will produce an object store with the backing files, and a erofs
>> file with the required overlayfs xattrs, including a made up one
>> called "overlay.fs-verity" containing the expected fs-verity digest
>> for the lower dir. It also adds the required whiteouts to cover the
>> 00-ff dirs from the lower dir.
>>
>> These erofs files are ordered similarly to the composefs files, and we
>> give similar guarantees about their reproducibility, etc. So, they
>> should be apples-to-apples comparable with the composefs images.
>>
>> Given this, I ran another set of performance tests on the original cs9
>> rootfs dataset, again measuring the time of `ls -lR`. I also tried to
>> measure the memory use like this:
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>> # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
>> /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>>
>> These are the alternatives I tried:
>>
>> xfs: the source of the image, regular dir on xfs
>> erofs: the image.erofs above, on loopback
>> erofs dio: the image.erofs above, on loopback with --direct-io=on
>> ovl: erofs above combined with overlayfs
>> ovl dio: erofs dio above combined with overlayfs
>> cfs: composefs mount of image.cfs
>>
>> All tests use the same objects dir, stored on xfs. The erofs and
>> overlay implementations are from a stock 6.1.13 kernel, and composefs
>> module is from github HEAD.
>>
>> I tried loopback both with and without the direct-io option, because
>> without direct-io enabled the kernel will double-cache the loopbacked
>> data, as per[1].
>>
>> The produced images are:
>>   8.9M image.cfs
>> 11.3M image.erofs
>>
>> And gives these results:
>>             | Cold cache | Warm cache | Mem use
>>             |   (msec)   |   (msec)   |  (mb)
>> -----------+------------+------------+---------
>> xfs        |   1449     |    442     |    54
>> erofs      |    700     |    391     |    45
>> erofs dio  |    939     |    400     |    45
>> ovl        |   1827     |    530     |   130
>> ovl dio    |   2156     |    531     |   130
>> cfs        |    689     |    389     |    51
> 
> It has been noted that the readahead done by kernel_read() may cause
> read-ahead of unrelated data into memory which skews the results in
> favour of workloads that consume all the filesystem metadata (such as
> the ls -lR usecase of the above test). In the table above this favours
> composefs (which uses kernel_read in some codepaths) as well as
> non-dio erofs (non-dio loopback device uses readahead too).
> 
> I updated composefs to not use kernel_read here:
>    https://github.com/containers/composefs/pull/105
> 
> And a new kernel patch-set based on this is available at:
>    https://github.com/alexlarsson/linux/tree/composefs
> 
> The resulting table is now (dropping the non-dio erofs):
> 
>             | Cold cache | Warm cache | Mem use
>             |   (msec)   |   (msec)   |  (mb)
> -----------+------------+------------+---------
> xfs        |   1449     |    442     |   54
> erofs dio  |    939     |    400     |   45
> ovl dio    |   2156     |    531     |  130
> cfs        |    833     |    398     |   51
> 
>             | Cold cache | Warm cache | Mem use
>             |   (msec)   |   (msec)   |  (mb)
> -----------+------------+------------+---------
> ext4       |   1135     |    394     |   54
> erofs dio  |    922     |    401     |   45
> ovl dio    |   1810     |    532     |  149
> ovl lazy   |   1063     |    523     |  87
> cfs        |    768     |    459     |  51
> 
> So, while cfs is somewhat worse now for this particular usecase, my
> overall analysis still stands.

We will investigate it later, also you might still need to test some
other random workloads other than "ls -lR" (such as stat ~1000 files
randomly [1]) rather than completely ignore my and Jingbo's comments,
or at least you have to answer why "ls -lR" is the only judgement on
your side.

My point is simply simple.  If you consider a chance to get an
improved EROFS in some extents, we do hope we could improve your
"ls -lR" as much as possible without bad impacts to random access.
Or if you'd like to upstream a new file-based stackable filesystem
for this ostree specific use cases for your whatever KPIs anyway,
I don't think we could get some conclusion here and I cannot do any
help to you since I'm not that one.

Since you're addressing a very specific workload "ls -lR" and EROFS
as well as EROFS + overlayfs doesn't perform so bad without further
insights compared with Composefs even EROFS doesn't directly use
file-based interfaces.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com

> 
