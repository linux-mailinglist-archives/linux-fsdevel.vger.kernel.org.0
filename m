Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565FE6874CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 05:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBBE75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 23:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBBE74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:59:56 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199765267;
        Wed,  1 Feb 2023 20:59:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VajHcsn_1675313989;
Received: from 30.221.130.224(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VajHcsn_1675313989)
          by smtp.aliyun-inc.com;
          Thu, 02 Feb 2023 12:59:50 +0800
Message-ID: <ad3099ba-5428-5748-d161-f3c8f1973d19@linux.alibaba.com>
Date:   Thu, 2 Feb 2023 12:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     Alexander Larsson <alexl@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>, gscrivan@redhat.com,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
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
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <64348226-0be8-4fb4-8f1e-1f118511bdc7@linux.alibaba.com>
In-Reply-To: <64348226-0be8-4fb4-8f1e-1f118511bdc7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/2/23 12:57 PM, Jingbo Xu wrote:
> 
> 
> On 2/1/23 5:46 PM, Alexander Larsson wrote:
>> On Wed, 2023-02-01 at 12:28 +0800, Jingbo Xu wrote:
>>> Hi all,
>>>
>>> There are some updated performance statistics with different
>>> combinations on my test environment if you are interested.
>>>
>>>
>>> On 1/27/23 6:24 PM, Gao Xiang wrote:
>>>> ...
>>>>
>>>> I've made a version and did some test, it can be fetched from:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>>>> -b
>>>> experimental
>>>>
>>>
>>> Setup
>>> ======
>>> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
>>> Disk: 6800 IOPS upper limit
>>> OS: Linux v6.2 (with composefs v3 patchset)
>>
>> For the record, what was the filesystem backing the basedir files?
>>
>>> I build erofs/squashfs images following the scripts attached on [1],
>>> with each file in the rootfs tagged with "metacopy" and "redirect"
>>> xattr.
>>>
>>> The source rootfs is from the docker image of tensorflow [2].
>>>
>>> The erofs images are built with mkfs.erofs with support for sparse
>>> file
>>> added [3].
>>>
>>> [1]
>>> https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com/
>>> [2]
>>> https://hub.docker.com/layers/tensorflow/tensorflow/2.10.0/images/sha256-7f9f23ce2473eb52d17fe1b465c79c3a3604047343e23acc036296f512071bc9?context=explore
>>> [3]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=7c49e8b195ad90f6ca9dfccce9f6e3e39a8676f6
>>>
>>>
>>>
>>> Image size
>>> ===========
>>> 6.4M large.composefs
>>> 5.7M large.composefs.w/o.digest (w/o --compute-digest)
>>> 6.2M large.erofs
>>> 5.2M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
>>> 1.7M large.squashfs
>>> 5.8M large.squashfs.uncompressed (with -noI -noD -noF -noX)
>>>
>>> (large.erofs.T0 is built without nanosecond timestamp, so that we get
>>> smaller disk inode size (same with squashfs).)
>>>
>>>
>>> Runtime Perf
>>> =============
>>>
>>> The "uncached" column is tested with:
>>> hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"
>>>
>>>
>>> While the "cached" column is tested with:
>>> hyperfine -w 1 "ls -lR $MNTPOINT"
>>>
>>>
>>> erofs and squashfs are mounted with loopback device.
>>>
>>>
>>>                                   | uncached(ms)| cached(ms)
>>> ----------------------------------|-------------|-----------
>>> composefs (with digest)           | 326         | 135
>>> erofs (w/o -T0)                   | 264         | 172
>>> erofs (w/o -T0) + overlayfs       | 651         | 238
>>> squashfs (compressed)	            | 538         | 211
>>> squashfs (compressed) + overlayfs | 968         | 302
>>
>>
>> Clearly erofs with sparse files is the best fs now for the ro-fs +
>> overlay case. But still, we can see that the additional cost of the
>> overlayfs layer is not negligible. 
>>
>> According to amir this could be helped by a special composefs-like mode
>> in overlayfs, but its unclear what performance that would reach, and
>> we're then talking net new development that further complicates the
>> overlayfs codebase. Its not clear to me which alternative is easier to
>> develop/maintain.
>>
>> Also, the difference between cached and uncached here is less than in
>> my tests. Probably because my test image was larger. With the test
>> image I use, the results are:
>>
>>                                   | uncached(ms)| cached(ms)
>> ----------------------------------|-------------|-----------
>> composefs (with digest)           | 681         | 390
>> erofs (w/o -T0) + overlayfs       | 1788        | 532
>> squashfs (compressed) + overlayfs | 2547        | 443
>>
>>
>> I gotta say it is weird though that squashfs performed better than
>> erofs in the cached case. May be worth looking into. The test data I'm
>> using is available here:
>>   
>> https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
>>
>>
> 
> Hi,
> 
> I also tested upon the rootfs you given.
> 
> 
> Setup
> ======
> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> Disk: 11800 IOPS upper limit
> OS: Linux v6.2 (with composefs v3 patchset)
> FS of backing objects: xfs
> 
> 
> Image size
> ===========
> 8.6M large.composefs (with --compute-digest)
> 7.6M large.composefs.wo.digest (w/o --compute-digest)
> 8.9M large.erofs
> 7.4M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
> 2.6M large.squashfs.compressed
> 8.2M large.squashfs.uncompressed (with -noI -noD -noF -noX)
> 
> 
> Runtime Perf
> =============
> 
> The "uncached" column is tested with:
> hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"
> 
> 
> While the "cached" column is tested with:
> hyperfine -w 1 "ls -lR $MNTPOINT"
> 
> 
> erofs and squashfs are mounted with loopback device.
> 
> 				  | uncached(ms)| cached(ms)
> ----------------------------------|-------------|-----------
> composefs			  | 408		| 176
> erofs			  	  | 308		| 190
> erofs     + overlayfs	  	  | 1097	| 294
> erofs.hack			  | 298		| 187
> erofs.hack + overlayfs	  	  | 524		| 283
> squashfs (compressed)		  | 770		| 265
> squashfs (compressed) + overlayfs | 1600	| 372
> squashfs (uncompressed)		  | 646		| 223
> squashfs (uncompressed)+overlayfs | 1480	| 330
> 
> - all erofs mounted with "noacl"
> - composefs: using large.composefs
> - erofs: using large.erofs
> - erofs.hack: using large.erofs.hack where each file in the erofs layer
> redirecting to the same lower block, e.g.
> "/objects/00/02bef8682cac782594e542d1ec6e031b9f7ac40edcfa6a1eb6d15d3b1ab126",
> to evaluate the potential optimization of composefs like "lazy lookup"
						^
			composefs-like "lazy lookup" in overlayfs ...
> in overlayfs
> - squashfs (compressed): using large.squashfs.compressed
> - squashfs (uncompressed): using large.squashfs.uncompressed
> 
> 

-- 
Thanks,
Jingbo
