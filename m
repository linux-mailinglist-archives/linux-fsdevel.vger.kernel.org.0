Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D90678C58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAWX7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 18:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWX7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:59:13 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1226A0;
        Mon, 23 Jan 2023 15:59:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Va6CeTr_1674518344;
Received: from 192.168.1.38(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Va6CeTr_1674518344)
          by smtp.aliyun-inc.com;
          Tue, 24 Jan 2023 07:59:05 +0800
Message-ID: <45d611a6-84d4-6be2-1f45-e4f13673dbba@linux.alibaba.com>
Date:   Tue, 24 Jan 2023 07:59:04 +0800
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
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
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



On 2023/1/24 01:56, Alexander Larsson wrote:
> On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com>
>> wrote:
>>>
>>> Giuseppe Scrivano and I have recently been working on a new project
>>> we
>>> call composefs. This is the first time we propose this publically
>>> and
>>> we would like some feedback on it.
>>>
>>
>> Hi Alexander,
>>
>> I must say that I am a little bit puzzled by this v3.
>> Gao, Christian and myself asked you questions on v2
>> that are not mentioned in v3 at all.
> 
> I got lots of good feedback from Dave Chinner on V2 that caused rather
> large changes to simplify the format. So I wanted the new version with
> those changes out to continue that review. I think also having that
> simplified version will be helpful for the general discussion.
> 
>> To sum it up, please do not propose composefs without explaining
>> what are the barriers for achieving the exact same outcome with
>> the use of a read-only overlayfs with two lower layer -
>> uppermost with erofs containing the metadata files, which include
>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that
>> refer to the lowermost layer containing the content files.
> 

...

> 
> I would say both versions of this can work. There are some minor
> technical issues with the overlay option:
> 
> * To get actual verification of the backing files you would need to
> add support to overlayfs for an "trusted.overlay.digest" xattrs, with
> behaviour similar to composefs.
> 
> * mkfs.erofs doesn't support sparse files (not sure if the kernel code
> does), which means it is not a good option for the backing all these
> sparse files. Squashfs seems to support this though, so that is an
> option.

EROFS support chunk-based files, you actually can use this feature to do
sparse files if really needed.

Currently Android use cases and OCI v1 both doesn't need this feature,
but you can simply use ext4, I don't think squashfs here is a good
option since it doesn't optimize anything about directory lookup.

> 
> However, the main issue I have with the overlayfs approach is that it
> is sort of clumsy and over-complex. Basically, the composefs approach
> is laser focused on read-only images, whereas the overlayfs approach
> just chains together technologies that happen to work, but also do a
> lot of other stuff. The result is that it is more work to use it, it
> uses more kernel objects (mounts, dm devices, loopbacks) and it has
> worse performance.
> 
> To measure performance I created a largish image (2.6 GB centos9
> rootfs) and mounted it via composefs, as well as overlay-over-squashfs,
> both backed by the same objects directory (on xfs).
> 
> If I clear all caches between each run, a `ls -lR` run on composefs
> runs in around 700 msec:
> 
> # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR cfs-mount"
> Benchmark 1: ls -lR cfs-mount
>    Time (mean ± σ):     701.0 ms ±  21.9 ms    [User: 153.6 ms, System: 373.3 ms]
>    Range (min … max):   662.3 ms … 725.3 ms    10 runs
> 
> Whereas same with overlayfs takes almost four times as long:
> 
> # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR ovl-mount"
> Benchmark 1: ls -lR ovl-mount
>    Time (mean ± σ):      2.738 s ±  0.029 s    [User: 0.176 s, System: 1.688 s]
>    Range (min … max):    2.699 s …  2.787 s    10 runs
> 
> With page cache between runs the difference is smaller, but still
> there:
> 
> # hyperfine "ls -lR cfs-mnt"
> Benchmark 1: ls -lR cfs-mnt
>    Time (mean ± σ):     390.1 ms ±   3.7 ms    [User: 140.9 ms, System: 247.1 ms]
>    Range (min … max):   381.5 ms … 393.9 ms    10 runs
> 
> vs
> 
> # hyperfine -i "ls -lR ovl-mount"
> Benchmark 1: ls -lR ovl-mount
>    Time (mean ± σ):     431.5 ms ±   1.2 ms    [User: 124.3 ms, System: 296.9 ms]
>    Range (min … max):   429.4 ms … 433.3 ms    10 runs
> 
> This isn't all that strange, as overlayfs does a lot more work for
> each lookup, including multiple name lookups as well as several xattr
> lookups, whereas composefs just does a single lookup in a pre-computed
> table. But, given that we don't need any of the other features of
> overlayfs here, this performance loss seems rather unnecessary.

You should use ext4 to make a try first.

Thanks,
Gao Xiang
