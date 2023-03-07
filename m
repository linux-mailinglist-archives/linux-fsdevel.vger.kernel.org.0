Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9246ADF40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 13:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCGM4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 07:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCGM4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:56:03 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77C7E885
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 04:55:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdLMZLK_1678193719;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdLMZLK_1678193719)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 20:55:21 +0800
Message-ID: <2abdc431-d4ea-ad71-7e36-928e432a8f90@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 20:55:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <20230307101548.6gvtd62zah5l3doe@wittgenstein>
 <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
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



On 2023/3/7 20:09, Alexander Larsson wrote:
> On Tue, Mar 7, 2023 at 11:16 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
>>> Hi Alexander,
>>>
>>> On 2023/3/3 21:57, Alexander Larsson wrote:
>>>> On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
> 
>>>> But I know for the people who are more interested in using composefs
>>>> for containers the eventual goal of rootless support is very
>>>> important. So, on behalf of them I guess the question is: Is there
>>>> ever any chance that something like composefs could work rootlessly?
>>>> Or conversely: Is there some way to get rootless support from the
>>>> overlay approach? Opinions? Ideas?
>>>
>>> Honestly, I do want to get a proper answer when Giuseppe asked me
>>> the same question.  My current view is simply "that question is
>>> almost the same for all in-kernel fses with some on-disk format".
>>
>> As far as I'm concerned filesystems with on-disk format will not be made
>> mountable by unprivileged containers. And I don't think I'm alone in
>> that view. The idea that ever more parts of the kernel with a massive
>> attack surface such as a filesystem need to vouchesafe for the safety in
>> the face of every rando having access to
>> unshare --mount --user --map-root is a dead end and will just end up
>> trapping us in a neverending cycle of security bugs (Because every
>> single bug that's found after making that fs mountable from an
>> unprivileged container will be treated as a security bug no matter if
>> justified or not. So this is also a good way to ruin your filesystem's
>> reputation.).
>>
>> And honestly, if we set the precedent that it's fine for one filesystem
>> with an on-disk format to be able to be mounted by unprivileged
>> containers then other filesystems eventually want to do this as well.
>>
>> At the rate we currently add filesystems that's just a matter of time
>> even if none of the existing ones would also want to do it. And then
>> we're left arguing that this was just an exception for one super
>> special, super safe, unexploitable filesystem with an on-disk format.
>>
>> Imho, none of this is appealing. I don't want to slowly keep building a
>> future where we end up running fuzzers in unprivileged container to
>> generate random images to crash the kernel.
>>
>> I have more arguments why I don't think is a path we will ever go down
>> but I don't want this to detract from the legitimate ask of making it
>> possible to mount trusted images from within unprivileged containers.
>> Because I think that's perfectly legitimate.
>>
>> However, I don't think that this is something the kernel needs to solve
>> other than providing the necessary infrastructure so that this can be
>> solved in userspace.
> 
> So, I completely understand this point of view. And, since I'm not
> really hearing any other viewpoint from the linux vfs developers it
> seems to be a shared opinion. So, it seems like further work on the
> kernel side of composefs isn't really useful anymore, and I will focus
> my work on the overlayfs side. Maybe we can even drop the summit topic
> to avoid a bunch of unnecessary travel?
I am still looking forward to see you here since I'd like to
devote my time to work on anything which could makes EROFS
better and more useful (I'm always active in the Linux FS
community.)  Even if you folks finally don't decide to give
EROFS a chance, I'm still happy to get your further inputs
since I think an immutable filesystem can do better and useful
than the current status to the whole Linux ecosystem.

I'm very sorry that I didn't have a chance to go to FOSDEM 23 due
to my unexpected travelling visa issues to Belgium at that time.

> 
> That said, even though I understand (and even agree) with your
> worries, I feel it is kind of unfortunate that we end up with
> (essentially) a setuid helper approach for this. Because it feels like
> we're giving up on a useful feature (trustless unprivileged mounts)
> that the kernel could *theoretically* deliver, but a setuid helper
> can't. Sure, if you have a closed system you can limit what images can
> get mounted to images signed by a trusted key, but it won't work well
> for things like user built images or publically available images.
> Unfortunately practicalities kinda outweigh theoretical advantages.

In principle, I think _trusted_ unprivileged mounts in kernel
could be done in somewhat degree.  But before that, firstly,
that needs very very very hard proofs why userspace cannot do
this.  As long as it has a little possibility to work in
userspace effectively, it could become another story.

I'm somewhat against with untrusted unprivileged mounts with
actual on-disk formats all the time.  Why? Just because FUSE
is a pure simple protocol, and overlayfs uses very limited
xattrs without on-disk data.

If we have some filesystem with on-disk data, the problem inside
not only just causes panic but also deadlock, livelock, DOS, or
even corrupted memory due to some on-disk format.  In principle,
we could freeze all the code without any feature enhancement,
but it becomes hard in practice since users like new on-disk
useful features all the time.

Thanks,
Gao Xiang

> 
