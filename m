Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09567E18C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjA0KZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 05:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjA0KZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:25:02 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39848222ED;
        Fri, 27 Jan 2023 02:25:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VaES2Bn_1674815095;
Received: from 192.168.1.38(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VaES2Bn_1674815095)
          by smtp.aliyun-inc.com;
          Fri, 27 Jan 2023 18:24:57 +0800
Message-ID: <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
Date:   Fri, 27 Jan 2023 18:24:55 +0800
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
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
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



On 2023/1/25 18:15, Alexander Larsson wrote:
> On Wed, 2023-01-25 at 18:05 +0800, Gao Xiang wrote:
>>
>>
>> On 2023/1/25 17:37, Alexander Larsson wrote:
>>> On Tue, 2023-01-24 at 21:06 +0200, Amir Goldstein wrote:
>>>> On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson
>>>> <alexl@redhat.com>
>>
>> ...
>>
>>>>>
>>>>> They are all strictly worse than squashfs in the above testing.
>>>>>
>>>>
>>>> It's interesting to know why and if an optimized mkfs.erofs
>>>> mkfs.ext4 would have done any improvement.
>>>
>>> Even the non-loopback mounted (direct xfs backed) version performed
>>> worse than the squashfs one. I'm sure a erofs with sparse files
>>> would
>>> do better due to a more compact file, but I don't really see how it
>>> would perform significantly different than the squashfs code. Yes,
>>> squashfs lookup is linear in directory length, while erofs is
>>> log(n),
>>> but the directories are not so huge that this would dominate the
>>> runtime.
>>>
>>> To get an estimate of this I made a broken version of the erofs
>>> image,
>>> where the metacopy files are actually 0 byte size rather than
>>> sparse.
>>> This made the erofs file 18M instead, and gained 10% in the cold
>>> cache
>>> case. This, while good, is not near enough to matter compared to
>>> the
>>> others.
>>>
>>> I don't think the base performance here is really much dependent on
>>> the
>>> backing filesystem. An ls -lR workload is just a measurement of the
>>> actual (i.e. non-dcache) performance of the filesystem
>>> implementation
>>> of lookup and iterate, and overlayfs just has more work to do here,
>>> especially in terms of the amount of i/o needed.
>>
>> I will form a formal mkfs.erofs version in one or two days since
>> we're
>> cerebrating Lunar New year now.

I've made a version and did some test, it can be fetched from:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental

this feature can be used with -Ededupe or --chunksize=# (assuming
that all sparse files are holed, so that each file will only has
one chunk.)

>>
>> Since you don't have more I/O traces for analysis, I have to do
>> another
>> wild guess.
>>
>> Could you help benchmark your v2 too? I'm not sure if such
>> performance also exists in v2.  The reason why I guess as this is
>> that it seems that you read all dir inode pages when doing the first
>> lookup, it can benefit to seq dir access.
>>
>> I'm not sure if EROFS can make a similar number by doing forcing
>> readahead on dirs to read all dir data at once as well.
>>
>> Apart from that I don't see significant difference, at least
>> personally
>> I'd like to know where it could have such huge difference.  I don't
>> think that is all because of read-only on-disk format differnce.
> 
> I think the performance difference between v2 and v3 would be rather
> minor in this case, because I don't think a lot of the directories are
> large enough to be split in chunks. I also don't believe erofs and
> composefs should fundamentally differ much in performance here, given
> that both use a compact binary searchable layout for dirents. However,
> the full comparison is "composefs" vs "overlayfs + erofs", and in that
> case composefs wins.

I'm still on vacation..  I will play with composefs personally to get
more insights when I'm back,  but it would be much better to provide
some datasets for this as well (assuming the dataset can be shown in
public.)

Thanks,
Gao Xiang

> 
