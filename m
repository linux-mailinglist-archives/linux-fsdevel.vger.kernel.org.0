Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791ED68623A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBAI7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 03:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjBAI7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:59:34 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA55D907;
        Wed,  1 Feb 2023 00:59:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VafSXjC_1675241963;
Received: from 30.221.131.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VafSXjC_1675241963)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 16:59:24 +0800
Message-ID: <ea8819bc-c340-bf4c-ad91-1a520fe3914b@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 16:59:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
 <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <CAOQ4uxhzGru2Z8tjcAWvKVi0reNeX9SHMi6cwdyA9Vws8c1ppw@mail.gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAOQ4uxhzGru2Z8tjcAWvKVi0reNeX9SHMi6cwdyA9Vws8c1ppw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/1/23 3:44 PM, Amir Goldstein wrote:
> On Wed, Feb 1, 2023 at 6:28 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> There are some updated performance statistics with different
>> combinations on my test environment if you are interested.
>>
> 
> Cool report!
> 
>>
>> On 1/27/23 6:24 PM, Gao Xiang wrote:
>>> ...
>>>
>>> I've made a version and did some test, it can be fetched from:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b
>>> experimental
>>>
>>
>> Setup
>> ======
>> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
>> Disk: 6800 IOPS upper limit
>> OS: Linux v6.2 (with composefs v3 patchset)
>>
>> I build erofs/squashfs images following the scripts attached on [1],
>> with each file in the rootfs tagged with "metacopy" and "redirect" xattr.
>>
>> The source rootfs is from the docker image of tensorflow [2].
>>
>> The erofs images are built with mkfs.erofs with support for sparse file
>> added [3].
>>
>> [1]
>> https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com/
>> [2]
>> https://hub.docker.com/layers/tensorflow/tensorflow/2.10.0/images/sha256-7f9f23ce2473eb52d17fe1b465c79c3a3604047343e23acc036296f512071bc9?context=explore
>> [3]
>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=7c49e8b195ad90f6ca9dfccce9f6e3e39a8676f6
>>
>>
>>
>> Image size
>> ===========
>> 6.4M large.composefs
>> 5.7M large.composefs.w/o.digest (w/o --compute-digest)
>> 6.2M large.erofs
>> 5.2M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
>> 1.7M large.squashfs
>> 5.8M large.squashfs.uncompressed (with -noI -noD -noF -noX)
>>
>> (large.erofs.T0 is built without nanosecond timestamp, so that we get
>> smaller disk inode size (same with squashfs).)
>>
>>
>> Runtime Perf
>> =============
>>
>> The "uncached" column is tested with:
>> hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"
>>
>>
>> While the "cached" column is tested with:
>> hyperfine -w 1 "ls -lR $MNTPOINT"
>>
>>
>> erofs and squashfs are mounted with loopback device.
>>
>>
>>                                   | uncached(ms)| cached(ms)
>> ----------------------------------|-------------|-----------
>> composefs (with digest)           | 326         | 135
>> erofs (w/o -T0)                   | 264         | 172
>> erofs (w/o -T0) + overlayfs       | 651         | 238
> 
> This is a nice proof of the overlayfs "early lookup" overhead.
> As I wrote, this overhead could be optimized by doing "lazy lookup"
> on open like composefs does.
> 
> Here is a suggestion for a simple test variant that could be used to
> approximate the expected improvement -
> if you set all the metacopy files in erofs to redirect to the same
> lower block, most of the lower lookup time will be amortized
> because all but the first lower lookup are cached.
> If you get a performance number with erofs + overlayfs that are
> close to composefs performance numbers, it will prove the point
> that same functionality and performance could be achieved by
> modifying ovelrayfs/mkfs.erofs.
> 

I redid the test with suggestion from Amir, with all files inside the
erofs layer are redirected to the same lower block, e.g.
"/objects/00/014430a0b489d101c8a103ef829dd258448a13eb48b4d1e9ff0731d1e82b92".

The result is shown in the fourth line.

				  | uncached(ms)| cached(ms)
----------------------------------|-------------|-----------
composefs (with digest)		  | 326		| 135
erofs (w/o -T0)			  | 264		| 172
erofs (w/o -T0) + overlayfs	  | 651		| 238
erofs (hacked and redirect to one |		|
lower block) + overlayfs	  | 400		| 230

It seems that the "lazy lookup" in overlayfs indeed optimizes in this
situation.


The performance gap in cached situation (especially comparing composefs
and standalone erofs) is still under investigation and I will see if
there's any hint by perf diff.



overlayfs + loopback erofs(redirect to the one same lwer block) - uncached
Benchmark 1: ls -lR /mnt/ovl/mntdir
  Time (mean ± σ):     399.5 ms ±   3.8 ms    [User: 69.9 ms, System:
298.1 ms]
  Range (min … max):   394.3 ms … 403.7 ms    10 runs

overlayfs + loopback erofs(w/o -T0) - cached
Benchmark 1: ls -lR /mnt/ovl/mntdir
  Time (mean ± σ):     230.5 ms ±   5.7 ms    [User: 63.8 ms, System:
165.6 ms]
  Range (min … max):   220.4 ms … 240.2 ms    12 runs


-- 
Thanks,
Jingbo
