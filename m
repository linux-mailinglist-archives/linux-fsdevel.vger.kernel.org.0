Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0999E6AAB17
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 17:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCDQWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 11:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDQWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:22:23 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60B15565
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 08:22:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vd3nnbI_1677946935;
Received: from 30.120.156.107(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd3nnbI_1677946935)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 00:22:17 +0800
Message-ID: <579ad5a0-2e7b-85b8-10b0-7c8879f9c872@linux.alibaba.com>
Date:   Sun, 5 Mar 2023 00:22:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
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
In-Reply-To: <0a571702-a907-c2b1-bb38-96aa7b268a1b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/4 23:29, Gao Xiang wrote:
> Hi Colin,
> 
> On 2023/3/4 22:59, Colin Walters wrote:
>>
>>
>> On Fri, Mar 3, 2023, at 12:37 PM, Gao Xiang wrote:
>>>
>>> Actually since you're container guys, I would like to mention
>>> a way to directly reuse OCI tar data and not sure if you
>>> have some interest as well, that is just to generate EROFS
>>> metadata which could point to the tar blobs so that data itself
>>> is still the original tar, but we could add fsverity + IMMUTABLE
>>> to these blobs rather than the individual untared files.
>>
>>>    - OCI layer diff IDs in the OCI spec [1] are guaranteed;
>>
>> The https://github.com/vbatts/tar-split approach addresses this problem domain adequately I think.
> 
> Thanks for the interest and comment.
> 
> I'm not aware of this project, and I'm not sure if tar-split
> helps mount tar stuffs, maybe I'm missing something?
> 
> As for EROFS, as long as we support subpage block size, it's
> entirely possible to refer the original tar data without tar
> stream modification.
> 
>>
>> Correct me if I'm wrong, but having erofs point to underlying tar wouldn't by default get us page cache sharing or even the "opportunistic" disk sharing that composefs brings, unless userspace did something like attempting to dedup files in the tar stream via hashing and using reflinks on the underlying fs.  And then doing reflinks would require alignment inside the stream, right?  The https://fedoraproject.org/wiki/Changes/RPMCoW change is very similar in that it's proposing a modification of the RPM format to 4k align files in the 
> 
> hmmm.. I think userspace don't need to dedupe files in the
> tar stream.
> 
> stream for this reason.  But that's exactly it, then it's a new tweaked format and not identical to what came before, so the "compatibility" rationale is actually weakened a lot.
>>
>>
> 
> As you said, "opportunistic" finer disk sharing inside all tar
> streams can be resolved by reflink or other stuffs by the underlay
> filesystems (like XFS, or virtual devices like device mapper).
> 
> Not bacause EROFS cannot do on-disk dedupe, just because in this
> way EROFS can only use the original tar blobs, and EROFS is not
> the guy to resolve the on-disk sharing stuff.  However, here since
> the original tar blob is used, so that the tar stream data is
> unchanged (with the same diffID) when the container is running.
> 
> As a kernel filesystem, if two files are equal, we could treat them
> in the same inode address space, even they are actually with slightly
> different inode metadata (uid, gid, mode, nlink, etc).  That is
> entirely possible as an in-kernel filesystem even currently linux
> kernel doesn't implement finer page cache sharing, so EROFS can
> support page-cache sharing of files in all tar streams if needed.

By the way, in case of misunderstanding, the current workable ways
of Linux page cache sharing don't _strictly_ need the real inode is
the same inode (like what stackable fs like overlayfs does), just
need sharing data among different inodes consecutive in one address
space, which means:

   1) we could reuse blob (the tar stream) address space to share
      page cache, actually that is what Jingbo's did for fscache
      page cache sharing:
      https://lore.kernel.org/r/20230203030143.73105-1-jefflexu@linux.alibaba.com

   2) create a virtual inode (or reuse one address space of real
      inodes) to share data between real inodes.

Either way can do page cache sharing of inodes with same data
across different filesystems and are practial without extra
linux-mm improvement.

thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
