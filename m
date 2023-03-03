Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8096A9A58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCCPOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 10:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCCPOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:14:06 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDBC2696
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 07:13:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vd.vVDu_1677856432;
Received: from 30.25.230.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd.vVDu_1677856432)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 23:13:54 +0800
Message-ID: <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 23:13:51 +0800
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
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

On 2023/3/3 21:57, Alexander Larsson wrote:
> On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
>>
>> Hello,
>>
>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
>> Composefs filesystem. It is an opportunistically sharing, validating
>> image-based filesystem, targeting usecases like validated ostree
>> rootfs:es, validated container images that share common files, as well
>> as other image based usecases.
>>
>> During the discussions in the composefs proposal (as seen on LWN[3])
>> is has been proposed that (with some changes to overlayfs), similar
>> behaviour can be achieved by combining the overlayfs
>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>>
>> There are pros and cons to both these approaches, and the discussion
>> about their respective value has sometimes been heated. We would like
>> to have an in-person discussion at the summit, ideally also involving
>> more of the filesystem development community, so that we can reach
>> some consensus on what is the best apporach.
> 
> In order to better understand the behaviour and requirements of the
> overlayfs+erofs approach I spent some time implementing direct support
> for erofs in libcomposefs. So, with current HEAD of
> github.com/containers/composefs you can now do:
> 
> $ mkcompose --digest-store=objects --format=erofs source-dir image.erofs

Thanks you for taking time on working on EROFS support.  I don't have
time to play with it yet since I'd like to work out erofs-utils 1.6
these days and will work on some new stuffs such as !pagesize block
size as I said previously.

> 
> This will produce an object store with the backing files, and a erofs
> file with the required overlayfs xattrs, including a made up one
> called "overlay.fs-verity" containing the expected fs-verity digest
> for the lower dir. It also adds the required whiteouts to cover the
> 00-ff dirs from the lower dir.
> 
> These erofs files are ordered similarly to the composefs files, and we
> give similar guarantees about their reproducibility, etc. So, they
> should be apples-to-apples comparable with the composefs images.
> 
> Given this, I ran another set of performance tests on the original cs9
> rootfs dataset, again measuring the time of `ls -lR`. I also tried to
> measure the memory use like this:
> 
> # echo 3 > /proc/sys/vm/drop_caches
> # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
> /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> 
> These are the alternatives I tried:
> 
> xfs: the source of the image, regular dir on xfs
> erofs: the image.erofs above, on loopback
> erofs dio: the image.erofs above, on loopback with --direct-io=on
> ovl: erofs above combined with overlayfs
> ovl dio: erofs dio above combined with overlayfs
> cfs: composefs mount of image.cfs
> 
> All tests use the same objects dir, stored on xfs. The erofs and
> overlay implementations are from a stock 6.1.13 kernel, and composefs
> module is from github HEAD.
> 
> I tried loopback both with and without the direct-io option, because
> without direct-io enabled the kernel will double-cache the loopbacked
> data, as per[1].
> 
> The produced images are:
>   8.9M image.cfs
> 11.3M image.erofs
> 
> And gives these results:
>             | Cold cache | Warm cache | Mem use
>             |   (msec)   |   (msec)   |  (mb)
> -----------+------------+------------+---------
> xfs        |   1449     |    442     |    54
> erofs      |    700     |    391     |    45
> erofs dio  |    939     |    400     |    45
> ovl        |   1827     |    530     |   130
> ovl dio    |   2156     |    531     |   130
> cfs        |    689     |    389     |    51
> 
> I also ran the same tests in a VM that had the latest kernel including
> the lazyfollow patches (ovl lazy in the table, not using direct-io),
> this one ext4 based:
> 
>             | Cold cache | Warm cache | Mem use
>             |   (msec)   |   (msec)   |  (mb)
> -----------+------------+------------+---------
> ext4       |   1135     |    394     |    54
> erofs      |    715     |    401     |    46
> erofs dio  |    922     |    401     |    45
> ovl        |   1412     |    515     |   148
> ovl dio    |   1810     |    532     |   149
> ovl lazy   |   1063     |    523     |    87
> cfs        |    719     |    463     |    51
> 
> Things noticeable in the results:
> 
> * composefs and erofs (by itself) perform roughly  similar. This is
>    not necessarily news, and results from Jingbo Xu match this.
> 
> * Erofs on top of direct-io enabled loopback causes quite a drop in
>    performance, which I don't really understand. Especially since its
>    reporting the same memory use as non-direct io. I guess the
>    double-cacheing in the later case isn't properly attributed to the
>    cgroup so the difference is not measured. However, why would the
>    double cache improve performance?  Maybe I'm not completely
>    understanding how these things interact.

We've already analysed the root cause of composefs is that composefs
uses a kernel_read() to read its path while irrelevant metadata
(such as dir data) is read together.  Such heuristic readahead is a
unusual stuff for all local fses (obviously almost all in-kernel
filesystems don't use kernel_read() to read their metadata. Although
some filesystems could readahead some related extent metadata when
reading inode, they at least does _not_ work as kernel_read().) But
double caching will introduce almost the same impact as kernel_read()
(assuming you read some source code of loop device.)

I do hope you already read what Jingbo's latest test results, and that
test result shows how bad readahead performs if fs metadata is
partially randomly used (stat < 1500 files):
https://lore.kernel.org/r/83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com

Also you could explicitly _disable_ readahead for composefs
manifiest file (because all EROFS metadata read is without
readahead), and let's see how it works then.

Again, if your workload is just "ls -lR".  My answer is "just async
readahead the whole manifest file / loop device together" when
mounting.  That will give the best result to you.  But I'm not sure
that is the real use case you propose.

> 
> * Stacking overlay on top of erofs causes about 100msec slower
>    warm-cache times compared to all non-overlay approaches, and much
>    more in the cold cache case. The cold cache performance is helped
>    significantly by the lazyfollow patches, but the warm cache overhead
>    remains.
> 
> * The use of overlayfs more than doubles memory use, probably
>    because of all the extra inodes and dentries in action for the
>    various layers. The lazyfollow patches helps, but only partially.
> 
> * Even though overlayfs+erofs is slower than cfs and raw erofs, it is
>    not that much slower (~25%) than the pure xfs/ext4 directory, which
>    is a pretty good baseline for comparisons. It is even faster when
>    using lazyfollow on ext4.
> 
> * The erofs images are slightly larger than the equivalent composefs
>    image.
> 
> In summary: The performance of composefs is somewhat better than the
> best erofs+ovl combination, although the overlay approach is not
> significantly worse than the baseline of a regular directory, except
> that it uses a bit more memory.
> 
> On top of the above pure performance based comparisons I would like to
> re-state some of the other advantages of composefs compared to the
> overlay approach:
> 
> * composefs is namespaceable, in the sense that you can use it (given
>    mount capabilities) inside a namespace (such as a container) without
>    access to non-namespaced resources like loopback or device-mapper
>    devices. (There was work on fixing this with loopfs, but that seems
>    to have stalled.)
> 
> * While it is not in the current design, the simplicity of the format
>    and lack of loopback makes it at least theoretically possible that
>    composefs can be made usable in a rootless fashion at some point in
>    the future.
Do you consider sending some commands to /dev/cachefiles to configure
a daemonless dir and mount erofs image directly by using "erofs over
fscache" but in a daemonless way?  That is an ongoing stuff on our side.

IMHO, I don't think file-based interfaces are quite a charmful stuff.
Historically I recalled some practice is to "avoid directly reading
files in kernel" so that I think almost all local fses don't work on
files directl and loopback devices are all the ways for these use
cases.  If loopback devices are not okay to you, how about improving
loopback devices and that will benefit to almost all local fses.

> 
> And of course, there are disadvantages to composefs too. Primarily
> being more code, increasing maintenance burden and risk of security
> problems. Composefs is particularly burdensome because it is a
> stacking filesystem and these have historically been shown to be hard
> to get right.
> 
> 
> The question now is what is the best approach overall? For my own
> primary usecase of making a verifying ostree root filesystem, the
> overlay approach (with the lazyfollow work finished) is, while not
> ideal, good enough.

So your judgement is still "ls -lR" and your use case is still just
pure read-only and without writable stuff?

Anyway, I'm really happy to work with you on your ostree use cases
as always, as long as all corner cases work out by the community.

> 
> But I know for the people who are more interested in using composefs
> for containers the eventual goal of rootless support is very
> important. So, on behalf of them I guess the question is: Is there
> ever any chance that something like composefs could work rootlessly?
> Or conversely: Is there some way to get rootless support from the
> overlay approach? Opinions? Ideas?

Honestly, I do want to get a proper answer when Giuseppe asked me
the same question.  My current view is simply "that question is
almost the same for all in-kernel fses with some on-disk format".

If you think EROFS compression part is too complex and useless to your
use cases,  okay,  I think we could add a new mount option called
"nocompress" so that we can avoid that part runtimely explicitly. But
that still doesn't help to the original question on my side.

Thanks,
Gao Xiang

> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6
> 
> 
> 
> --
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
>   Alexander Larsson                                Red Hat, Inc
>         alexl@redhat.com         alexander.larsson@gmail.com
