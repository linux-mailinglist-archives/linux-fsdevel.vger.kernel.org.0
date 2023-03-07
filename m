Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90C6ADA80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCGJih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 04:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCGJie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:38:34 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBB39CC6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 01:38:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdKm34u_1678181908;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdKm34u_1678181908)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 17:38:29 +0800
Message-ID: <2a9d79b0-1610-2f66-9a72-a8a938030247@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 17:38:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
 <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
 <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
 <CAL7ro1FPKPWQvHteQq_t=u_LuR4B1Q5c=FBE-tRTN8CfoZCAHw@mail.gmail.com>
 <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com>
In-Reply-To: <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com>
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



On 2023/3/7 17:26, Gao Xiang wrote:
> 
> 
> On 2023/3/7 17:07, Alexander Larsson wrote:
>> On Tue, Mar 7, 2023 at 9:34 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2023/3/7 16:21, Alexander Larsson wrote:
>>>> On Mon, Mar 6, 2023 at 5:17 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>>>>>> I tested the performance of "ls -lR" on the whole tree of
>>>>>>> cs9-developer-rootfs.  It seems that the performance of erofs (generated
>>>>>>> from mkfs.erofs) is slightly better than that of composefs.  While the
>>>>>>> performance of erofs generated from mkfs.composefs is slightly worse
>>>>>>> that that of composefs.
>>>>>>
>>>>>> I suspect that the reason for the lower performance of mkfs.composefs
>>>>>> is the added overlay.fs-verity xattr to all the files. It makes the
>>>>>> image larger, and that means more i/o.
>>>>>
>>>>> Actually you could move overlay.fs-verity to EROFS shared xattr area (or
>>>>> even overlay.redirect but it depends) if needed, which could save some
>>>>> I/Os for your workloads.
>>>>>
>>>>> shared xattrs can be used in this way as well if you care such minor
>>>>> difference, actually I think inlined xattrs for your workload are just
>>>>> meaningful for selinux labels and capabilities.
>>>>
>>>> Really? Could you expand on this, because I would think it will be
>>>> sort of the opposite. In my usecase, the erofs fs will be read by
>>>> overlayfs, which will probably access overlay.* pretty often.  At the
>>>> very least it will load overlay.metacopy and overlay.redirect for
>>>> every lookup.
>>>
>>> Really.  In that way, it will behave much similiar to composefs on-disk
>>> arrangement now (in composefs vdata area).
>>>
>>> Because in that way, although an extra I/O is needed for verification,
>>> and it can only happen when actually opening the file (so "ls -lR" is
>>> not impacted.) But on-disk inodes are more compact.
>>>
>>> All EROFS xattrs will be cached in memory so that accessing
>>> overlay.* pretty often is not greatly impacted due to no real I/Os
>>> (IOWs, only some CPU time is consumed).
>>
>> So, I tried moving the overlay.digest xattr to the shared area, but
>> actually this made the performance worse for the ls case. I have not
> 
> That is much strange.  We'd like to open it up if needed.  BTW, did you
> test EROFS with acl enabled all the time?
> 
>> looked into the cause in detail, but my guess is that ls looks for the
>> acl xattr, and such a negative lookup will cause erofs to look at all
>> the shared xattrs for the inode, which means they all end up being
>> loaded anyway. Of course, this will only affect ls (or other cases
>> that read the acl), so its perhaps a bit uncommon.
> 
> Yeah, in addition to that, I guess real acls could be landed in inlined
> xattrs as well if exists...
> 
>>
>> Did you ever consider putting a bloom filter in the h_reserved area of
>> erofs_xattr_ibody_header? Then it could return early without i/o
>> operations for keys that are not set for the inode. Not sure what the
>> computational cost of that would be though.
> 
> Good idea!  Let me think about it, but enabling "noacl" mount
> option isn't prefered if acl is no needed in your use cases.

           ^ is preferred.

> Optimizing negative xattr lookups might need more on-disk
> improvements which we didn't care about xattrs more. (although
> "overlay.redirect" and "overlay.digest" seems fine for
> composefs use cases.)

Or we could just add a FEATURE_COMPAT_NOACL mount option to disable
ACLs explicitly if the image doesn't have any ACLs.  At least it's
useful for your use cases.

Thanks,
Gao Xiang

> 
> BTW, if you have more interest in this way, we could get in
> touch in a more effective way to improve EROFS in addition to
> community emails except for the userns stuff (I know it's useful
> but I don't know the answers, maybe as Chistian said, we could
> develop a new vfs feature to delegate a filesystem mount to an
> unprivileged one [1].  I think it's much safer in that way for
> kernel fses with on-disk format.)
> 
> [1] https://lore.kernel.org/r/20230126082228.rweg75ztaexykejv@wittgenstein
> 
> Thanks,
> Gao Xiang
>>
