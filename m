Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545E66DB20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 11:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjAQKbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 05:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjAQKan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:30:43 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8A279A7;
        Tue, 17 Jan 2023 02:30:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VZmkg46_1673951428;
Received: from 30.97.48.207(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZmkg46_1673951428)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 18:30:29 +0800
Message-ID: <3127b4dd-b266-e804-3040-d7c200711d2d@linux.alibaba.com>
Date:   Tue, 17 Jan 2023 18:30:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <cover.1673623253.git.alexl@redhat.com>
 <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
 <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir and Christian,

On 2023/1/17 18:12, Christian Brauner wrote:
> On Tue, Jan 17, 2023 at 09:05:53AM +0200, Amir Goldstein wrote:
>>> It seems rather another an incomplete EROFS from several points
>>> of view.  Also see:
>>> https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u
>>>
>>
>> Ironically, ZUFS is one of two new filesystems that were discussed in LSFMM19,
>> where the community reactions rhyme with the reactions to composefs.
>> The discussion on Incremental FS resembles composefs case even more [1].
>> AFAIK, Android is still maintaining Incremental FS out-of-tree.
>>
>> Alexander and Giuseppe,
>>
>> I'd like to join Gao is saying that I think it is in the best interest
>> of everyone,
>> composefs developers and prospect users included,
>> if the composefs requirements would drive improvement to existing
>> kernel subsystems rather than adding a custom filesystem driver
>> that partly duplicates other subsystems.
>>
>> Especially so, when the modifications to existing components
>> (erofs and overlayfs) appear to be relatively minor and the maintainer
>> of erofs is receptive to new features and happy to collaborate with you.
>>
>> w.r.t overlayfs, I am not even sure that anything needs to be modified
>> in the driver.
>> overlayfs already supports "metacopy" feature which means that an upper layer
>> could be composed in a way that the file content would be read from an arbitrary
>> path in lower fs, e.g. objects/cc/XXX.
>>
>> I gave a talk on LPC a few years back about overlayfs and container images [2].
>> The emphasis was that overlayfs driver supports many new features, but userland
>> tools for building advanced overlayfs images based on those new features are
>> nowhere to be found.
>>
>> I may be wrong, but it looks to me like composefs could potentially
>> fill this void,
>> without having to modify the overlayfs driver at all, or maybe just a
>> little bit.
>> Please start a discussion with overlayfs developers about missing driver
>> features if you have any.
> 

...

> 
> I want to stress that I'm not at all saying "no more new fs" but we
> should be hesitant before we merge new filesystems into the kernel.
> 
> Especially for filesystems that are tailored to special use-cases.
> Every few years another filesystem tailored to container use-cases shows
> up. And frankly, a good portion of the issues that they are trying to
> solve are caused by design choices in userspace.
> 
> And I have to say I'm especially NAK-friendly about anything that comes
> even close to yet another stacking filesystems or anything that layers
> on top of a lower filesystem/mount such as ecryptfs, ksmbd, and
> overlayfs. They are hard to get right, with lots of corner cases and
> they cause the most headaches when making vfs changes.

That is also my original (little) request if such overlay model is
correct...

In principle, it's not hard for EROFS since currently EROFS already
has symlink on-disk layout, and the difference is just applying them
to all regular files (even without some on-disk changes, but maybe
we need to optimize them if there are other special requirements
for specific use cases like ostree), and makes EROFS do like
stackable way... That is not hard honestly (on-disk compatible)...

But I'm not sure whether it's fortunate for EROFS now to support
this without a proper overlay model for careful discussion.

So if there could be some discussion for this overlay model on
LSF/MM/BPF, I'd like to attend (thanks!) And I support to make it
in overlayfs (if possible) but it seems EROFS could do as well as
long as it has enough constrait to conclude...

Thanks,
Gao Xiang


> 
