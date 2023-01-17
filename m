Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14766D397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAQAMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 19:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjAQAMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:12:21 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AB233CA;
        Mon, 16 Jan 2023 16:12:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZkmK9w_1673914334;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZkmK9w_1673914334)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 08:12:15 +0800
Message-ID: <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
Date:   Tue, 17 Jan 2023 08:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <cover.1673623253.git.alexl@redhat.com>
 <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2023/1/16 23:27, Alexander Larsson wrote:
> On Mon, 2023-01-16 at 21:26 +0800, Gao Xiang wrote:

I will stop saying this overlay permission model anymore since
there are more experienced folks working on this, although SUID
stuff is still dangerous to me as an end-user:  IMHO, its hard
for me to identify proper sub-sub-subdir UID/GID in "objects"
at runtime, even they could happen much deep which is different
from localfs with loopback devices or overlayfs.  I don't know
what then inproper sub-sub-subdir UID/GID in "objects" could
cause.

It seems currently ostree uses "root" all the time for such
"objects" subdirs, I don't know.

>>>
>>>>
>>>>>
>>>>> Instead what we have done with composefs is to make filesystem
>>>>> image
>>>>> generation from the ostree repository 100% reproducible. Then
>>>>> we
>>>>> can
>>>>
>>>> EROFS is all 100% reproduciable as well.
>>>>
>>>
>>>
>>> Really, so if I today, on fedora 36 run:
>>> # tar xvf oci-image.tar
>>> # mkfs.erofs oci-dir/ oci.erofs
>>>
>>> And then in 5 years, if someone on debian 13 runs the same, with
>>> the
>>> same tar file, then both oci.erofs files will have the same sha256
>>> checksum?
>>
>> Why it doesn't?  Reproducable builds is a MUST for Android use cases
>> as well.
> 
> That is not quite the same requirements. A reproducible build in the
> traditional sense is limited to a particular build configuration. You
> define a set of tools for the build, and use the same ones for each
> build, and get a fixed output. You don't expect to be able to change
> e.g. the compiler and get the same result. Similarly, it is often the
> case that different builds or versions of compression libraries gives
> different results, so you can't expect to use e.g. a different libz and
> get identical images.
> 
>> Yes, it may break between versions by mistake, but I think
>> reproducable builds is a basic functionalaity for all image
>> use cases.
>>
>>>
>>> How do you handle things like different versions or builds of
>>> compression libraries creating different results? Do you guarantee
>>> to
>>> not add any new backwards compat changes by default, or change any
>>> default options? Do you guarantee that the files are read from
>>> "oci-
>>> dir" in the same order each time? It doesn't look like it.
>>
>> If you'd like to say like that, why mkcomposefs doesn't have the
>> same issue that it may be broken by some bug.
>>
> 
> libcomposefs defines a normalized form for everything like file order,
> xattr orders, etc, and carefully normalizes everything such that we can
> guarantee these properties. It is possible that some detail was missed,
> because we're humans. But it was a very conscious and deliberate design
> choice that is deeply encoded in the code and format. For example, this
> is why we don't use compression but try to minimize size in other ways.

EROFS is reproducable since its dirents are all sorted because
of its on-disk definition.  And its xattrs are also sorted if
images needs to be reproducable.

I don't know what's the difference between these two
reproducable builds.  EROFS is designed for golden images, if
you pass in a set of configuration options for mkfs.erofs, it
should output the same output, otherwise they are really
buges and need to be fixed.

Compression algorithms could generate different outputs between
versions, and generally compressed data is stable for most
compression algorithms in a specific version but that is another
story.

EROFS can live without compression.

> 
>>>>
>>>> But really, personally I think the issue above is different from
>>>> loopback devices and may need to be resolved first. And if
>>>> possible,
>>>> I hope it could be an new overlayfs feature for everyone.
>>>
>>> Yeah. Independent of composefs, I think EROFS would be better if
>>> you
>>> could just point it to a chunk directory at mount time rather than
>>> having to route everything through a system-wide global cachefs
>>> singleton. I understand that cachefs does help with the on-demand
>>> download aspect, but when you don't need that it is just in the
>>> way.
>>
>> Just check your reply to Dave's review, it seems that how
>> composefs dir on-disk format works is also much similar to
>> EROFS as well, see:
>>
>> https://docs.kernel.org/filesystems/erofs.html -- Directories
>>
>> a block vs a chunk = dirent + names
>>
>> cfs_dir_lookup -> erofs_namei + find_target_block_classic;
>> cfs_dir_lookup_in_chunk -> find_target_dirent.
> 
> Yeah, the dirent layout looks very similar. I guess great minds think
> alike! My approach was simpler initially, but it kinda converged on
> this when I started optimizing the kernel lookup code with binary
> search.
> 
>> Yes, great projects could be much similar to each other
>> occasionally, not to mention opensource projects ;)
>>
>> Anyway, I'm not opposed to Composefs if folks really like a
>> new read-only filesystem for this. That is almost all I'd like
>> to say about Composefs formally, have fun!
Because, anyway, I have no idea considering opensource projects
could also do folk, so (maybe) such is life.

It seems rather another an incomplete EROFS from several points
of view.  Also see:
https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u

I will go on making a better EROFS as a promise to the
community initially.

Thanks,
Gao Xiang

>>
>> Thanks,
>> Gao Xiang
> 
> Cool, thanks for the feedback.
> 
> 
