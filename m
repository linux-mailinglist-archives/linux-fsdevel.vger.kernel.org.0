Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03FE6AD593
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 04:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCGDQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 22:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCGDQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:16:12 -0500
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF563211C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 19:15:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VdJP1g1_1678158636;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdJP1g1_1678158636)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 11:10:38 +0800
Message-ID: <49f80793-2349-4a1a-cdad-ed29da2d4e79@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 11:10:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
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
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <13e7205f-113b-ad47-417f-53b63743c64c@linux.alibaba.com>
 <4782a0db-5780-4309-badf-67f69507cc81@app.fastmail.com>
 <0a571702-a907-c2b1-bb38-96aa7b268a1b@linux.alibaba.com>
 <6bea16fa-737f-4aad-a2cd-0a12029e614d@app.fastmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6bea16fa-737f-4aad-a2cd-0a12029e614d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/7 09:00, Colin Walters wrote:
> 
> 
> On Sat, Mar 4, 2023, at 10:29 AM, Gao Xiang wrote:
>> Hi Colin,
>>
>> On 2023/3/4 22:59, Colin Walters wrote:
>>>
>>>
>>> On Fri, Mar 3, 2023, at 12:37 PM, Gao Xiang wrote:
>>>>
>>>> Actually since you're container guys, I would like to mention
>>>> a way to directly reuse OCI tar data and not sure if you
>>>> have some interest as well, that is just to generate EROFS
>>>> metadata which could point to the tar blobs so that data itself
>>>> is still the original tar, but we could add fsverity + IMMUTABLE
>>>> to these blobs rather than the individual untared files.
>>>
>>>>     - OCI layer diff IDs in the OCI spec [1] are guaranteed;
>>>
>>> The https://github.com/vbatts/tar-split approach addresses this problem domain adequately I think.
>>
>> Thanks for the interest and comment.
>>
>> I'm not aware of this project, and I'm not sure if tar-split
>> helps mount tar stuffs, maybe I'm missing something?
> 
> Not directly; it's widely used in the container ecosystem (podman/docker etc.) to split off the original bit-for-bit tar stream metadata content from the actually large data (particularly regular files) so that one can write the files to a regular underlying fs (xfs/ext4/etc.) and use overlayfs on top.   Then it helps reverse the process and reconstruct the original tar stream for pushes, for exactly the reason you mention.
> 
> Slightly OT but a whole reason we're having this conversation now is definitely rooted in the original Docker inventor having the idea of *deriving* or layering on top of previous images, which is not part of dpkg/rpm or squashfs or raw disk images etc.  Inherent in this is the idea that we're not talking about *a* filesystem - we're talking about filesystem*s* plural and how they're wired together and stacked.

Yes, as you said, if you think the actual OCI standard (or Docker
whatever) is all about layering.  There could be a possibility to
directly use the original layer for mounting without any conversion
(like "untar" or converting to another blob format which could
  support 4k reflink dedupe.)

I believe it can save untar time and snapshot gc problems that
users concern, such as our cloud with thousands of containers
launching/running/gcing in the same time.

> 
> It's really only very simplistic use cases for which a single read-only filesystem suffices.  They exist - e.g. people booting things like Tails OS https://tails.boum.org/ on one of those USB sticks with a physical write protection switch, etc.

I cannot access the webside. If you consider physical write
protection, then a read-only filesystem written on physical
media is needed.  So that EROFS manifest can be landed on
raw disks (for write protection and hardware integrate check)
or on other local filesystems.  It depends on the actual
detailed requirement.

> 
> But that approach makes every OS update very expensive - most use cases really want fast and efficient incremental in-place OS updates and a clear distinct split between OS filesystem and app filesystems.   But without also forcing separate size management onto both.
> 
>> Not bacause EROFS cannot do on-disk dedupe, just because in this
>> way EROFS can only use the original tar blobs, and EROFS is not
>> the guy to resolve the on-disk sharing stuff.
> 
> Right, agree; this ties into my larger point above that no one technology/filesystem is the sole solution in the general case.

Anyway, if you consider an _untar_ way, you could also
consider a conversion way (like you said padding to 4k).

Since OCI standard is all about layering, so you could
pad to 4k and then do data dedupe with:
   - data blobs theirselves (some recent project like
     Nydus with EROFS);
   - reflink enabled filesystems (such as XFS or btrfs).

Because untar behaves almost the same as the conversion
way, except that it doesn't produce massive files/dirs
to the underlay filesystem and then gc massive files/dirs
again.

To be clarified, since you are the OSTree original author,
here I'm not promoting alternative ways for you.  I believe
any practical engineering projects all have advantages and
disadvantages.  For example, even git is moving toward using
packed object store more and more, and I guess OSTree for
effective distribution could also have some packed format
at least to some extent.

Here I just would like to say, on-disk EROFS format (or
other most-used kernel filesystem) is not just designed for
a specific use cases like OSTree, tar blobs or whatever, or
specific media like block-based, file-based, etc.

As far as I can see, at least EROFS+overlay already supports
the OSTree composefs-like use cases for two years and landed
in many distros. And other local kernel filesystems don't
behave quite well with "ls -lR" workload.

> 
>> As a kernel filesystem, if two files are equal, we could treat them
>> in the same inode address space, even they are actually with slightly
>> different inode metadata (uid, gid, mode, nlink, etc).  That is
>> entirely possible as an in-kernel filesystem even currently linux
>> kernel doesn't implement finer page cache sharing, so EROFS can
>> support page-cache sharing of files in all tar streams if needed.
> 
> Hmmm.  I should clarify here I have zero kernel patches, I'm a userspace developer (on container and OS updates, for which I'd like a unified stack).  But it seems to me that while you're right that it would be technically possible for a single filesystem to do this, in practice it would require some sort of virtual sub-filesystem internally.  And at that point, it does seem more elegant to me to make that stacking explicit, more like how composefs is doing it.

As you said you're a userspace developer, here I just need
to clarify internal inodes are very common among local fses,
at least to my knowledge I know btrfs and f2fs in addition to
EROFS all have such stuffs to keep something to make use of
kernel page cache.

One advantage over the stackable way is that:  With the
stackable way, you have to explicitly open the backing file
which takes more time to lookup dcache/icache and even on-disk
hierarchy.  By contrast, if you consider page cache sharing
original tar blobs, you don't need to do another open at all.
Surely, it's not benchmarked by "ls -lR" but it indeed impacts
end users.

Again, here I'm trying to say I'm not in favor of or against
any user-space distribution solution, like OSTree or some else.
Nydus is just one of userspace examples to use EROFS which I
persuaded them to do such adaption.  Besides, EROFS is already
landed to all mainstream in-market Android smartphones, and I
hope it can get more attention, adaption over various use cases
and more developers could join us.

> 
> That said I think there's a lot of legitimate debate here, and I hope we can continue doing so productively!

Thanks, as a kernel filesystem developer for many years, I hope
our (at least myself) design can be used wider.  So again, I'm
not against your OSTree design and I believe all detailed
distribution approaches have pros and cons.

Thanks,
Gao Xiang

> 
