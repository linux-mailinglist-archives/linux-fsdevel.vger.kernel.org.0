Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F166A9B15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 16:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjCCPsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 10:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCCPst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:48:49 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E402D41
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 07:48:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vd0-aHD_1677858520;
Received: from 30.25.230.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd0-aHD_1677858520)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 23:48:42 +0800
Message-ID: <d414d9b6-3952-d4e8-fb89-2fcb905c7c4d@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 23:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
 <83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com>
 <CAL7ro1E_g9M1S6Eg45B63Sdfif4qrj7rdYSyWEW_OaOD833dUA@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1E_g9M1S6Eg45B63Sdfif4qrj7rdYSyWEW_OaOD833dUA@mail.gmail.com>
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



On 2023/3/3 22:41, Alexander Larsson wrote:
> On Wed, Mar 1, 2023 at 4:47 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> On 2/27/23 6:45 PM, Gao Xiang wrote:
>>>
>>> (+cc Jingbo Xu and Christian Brauner)
>>>
>>> On 2023/2/27 17:22, Alexander Larsson wrote:
>>>> Hello,
>>>>
>>>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
>>>> Composefs filesystem. It is an opportunistically sharing, validating
>>>> image-based filesystem, targeting usecases like validated ostree
>>>> rootfs:es, validated container images that share common files, as well
>>>> as other image based usecases.
>>>>
>>>> During the discussions in the composefs proposal (as seen on LWN[3])
>>>> is has been proposed that (with some changes to overlayfs), similar
>>>> behaviour can be achieved by combining the overlayfs
>>>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>>>>
>>>> There are pros and cons to both these approaches, and the discussion
>>>> about their respective value has sometimes been heated. We would like
>>>> to have an in-person discussion at the summit, ideally also involving
>>>> more of the filesystem development community, so that we can reach
>>>> some consensus on what is the best apporach.
>>>>
>>>> Good participants would be at least: Alexander Larsson, Giuseppe
>>>> Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
>>>> Jingbo Xu
>>> I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addressed
>>> the root cause of the performance gap is that
>>>
>>> composefs read some data symlink-like payload data by using
>>> cfs_read_vdata_path() which involves kernel_read() and trigger heuristic
>>> readahead of dir data (which is also landed in composefs vdata area
>>> together with payload), so that most composefs dir I/O is already done
>>> in advance by heuristic  readahead.  And we think almost all exist
>>> in-kernel local fses doesn't have such heuristic readahead and if we add
>>> the similar stuff, EROFS could do better than composefs.
>>>
>>> Also we've tried random stat()s about 500~1000 files in the tree you shared
>>> (rather than just "ls -lR") and EROFS did almost the same or better than
>>> composefs.  I guess further analysis (including blktrace) could be shown by
>>> Jingbo later.
>>>
>>
>> The link path string and dirents are mix stored in a so-called vdata
>> (variable data) section[1] in composefs, sometimes even in the same
>> block (figured out by dumping the composefs image).  When doing lookup,
>> composefs will resolve the link path.  It will read the link path string
>> from vdata section through kernel_read(), along which those dirents in
>> the following blocks are also read in by the heuristic readahead
>> algorithm in kernel_read().  I believe this will much benefit the
>> performance in the workload like "ls -lR".
> 
> This is interesting stuff, and honestly I'm a bit surprised other
> filesystems don't try to readahead directory metadata to some degree
> too. It seems inherent to all filesystems that they try to pack
> related metadata near each other, so readahead would probably be
> useful even for read-write filesystems, although even more so for
> read-only filesystems (due to lack of fragmentation).

As I wrote before, IMHO, local filesystems read data in some basic
unit (for example block size), if there are other irreverent metadata
read in one shot, of course it can read together.

Some local filesystems could read more related metadata when reading
inodes.  But that is based on the logical relationship rather than
the in-kernel readahead algorithm.

> 
> But anyway, this is sort of beside the current issue. There is nothing
> inherent in composefs that makes it have to do readahead like this,
> and correspondingly, if it is a good idea to do it, erofs could do it
> too,

I don't think in-tree EROFS should do a random irreverent readahead
like kernel_read() without proof since it could have bad results to
small random file access.  If we do such thing, I'm afraid it's
also irresponsible to all end users already using EROFS in production.

Again, "ls -lR" is not the whole world, no? If you care about the
startup time, FAST 16 slacker implied only 6.4% of that data [1] is
read.  Even though it mainly told about lazy pulling, but that number
is almost the same as the startup I/O in our cloud containers too.

[1] https://www.usenix.org/conference/fast16/technical-sessions/presentation/harter

Thanks,
Gao Xiang

> 
