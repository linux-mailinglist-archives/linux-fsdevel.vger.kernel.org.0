Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FB50D180
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiDXLfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiDXLfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:35:46 -0400
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B785DE62
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 04:32:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VB1HqHf_1650799960;
Received: from 30.225.24.146(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VB1HqHf_1650799960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 19:32:41 +0800
Message-ID: <c63d9fdb-a980-c151-8a14-d62706fd17f8@linux.alibaba.com>
Date:   Sun, 24 Apr 2022 19:32:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
Content-Language: en-US
To:     Bernd Schubert <bschubert@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
 <YmUKZQKNAGimupv7@redhat.com>
 <DM5PR1901MB20375D0CF53C5F7D338154D0B5F99@DM5PR1901MB2037.namprd19.prod.outlook.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <DM5PR1901MB20375D0CF53C5F7D338154D0B5F99@DM5PR1901MB2037.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/24/22 6:49 PM, Bernd Schubert wrote:
> I'm also traveling, but I had checked a bit the links you had given and even created github issue for the rust-fuse because it uses conflicting flags - seems to rely on non-upstream kernel.

FYI at least the C version virtiofsd (git@github.com:qemu/qemu.git
master) doesn't set FUSE_INIT_EXT on the reply to FUSE_INIT. I didn't
check the Rust version, since I'm not familiar with Rust so far...

I guess Vivek was referring to [1] when he mentioned the rust version of
virtiofsd. This is the rust version developed by the RedHat.

As for the "rust-fuse" Bernd Schubert mentioned, actually it's [2]
developed by the Alibaba folks. We tried to make this fuse daemon
support the per-inode DAX feature when the feature is still in the
progress of upstreaming kernel. Later when the feature finally gets
merged to mainline kernel, the position of the FUSE_HAS_INODE_DAX flag
bit is a little different with the initial implementation. Sadly we
forget to fix this, and the fuse daemon keeps using the flag bit
different from the mainline version. Sorry for that. Thanks for pointing
it out and we are going to fix it. Thanks.


[1] https://gitlab.com/virtio-fs/virtiofsd
[2] https://github.com/cloud-hypervisor/fuse-backend-rs


> 
> Get Outlook for Android<https://aka.ms/AAb9ysg>
> ________________________________
> From: Vivek Goyal <vgoyal@redhat.com>
> Sent: Sunday, April 24, 2022 10:29:25 AM
> To: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Bernd Schubert <bschubert@ddn.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; Jeffle Xu <jefflexu@linux.alibaba.com>; Dharmendra Singh <dsingh@ddn.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>; German Maglione <gmaglione@redhat.com>
> Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT flag
> 
> On Thu, Apr 21, 2022 at 05:36:02PM +0200, Miklos Szeredi wrote:
>> On Fri, 15 Apr 2022 at 13:54, Bernd Schubert <bschubert@ddn.com> wrote:
>>>
>>> This is just a safety precaution to avoid checking flags
>>> on memory that was initialized on the user space side.
>>> libfuse zeroes struct fuse_init_out outarg, but this is not
>>> guranteed to be done in all implementations. Better is to
>>> act on flags and to only apply flags2 when FUSE_INIT_EXT
>>> is set.
>>>
>>> There is a risk with this change, though - it might break existing
>>> user space libraries, which are already using flags2 without
>>> setting FUSE_INIT_EXT.
>>>
>>> The corresponding libfuse patch is here
>>> https://github.com/libfuse/libfuse/pull/662
>>>
>>>
>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> Agreed, this is a good change.  Applied.
>>
>> Just one comment: please consider adding  "Fixes:" and "Cc:
>> <stable@....>" tags next time.   I added them now.
> 
> I am afraid that this probably will break both C and rust version of
> virtiofsd. I had a quick look and I can't seem to find these
> implementations setting INIT_EXT flag in reply to init.
> 
> I am travelling. Will check it more closely when I return next week.
> If virtiofsd implementations don't set INIT_EXT, I would rather prefer
> to not do this change and avoid breaking it.
> 
> Thanks
> Vivek
> 
> 

-- 
Thanks,
Jeffle
