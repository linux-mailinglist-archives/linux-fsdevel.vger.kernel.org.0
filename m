Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8143E670FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 02:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjARB1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 20:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjARB1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:27:35 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738638669;
        Tue, 17 Jan 2023 17:27:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VZoS7M5_1674005249;
Received: from 30.13.162.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZoS7M5_1674005249)
          by smtp.aliyun-inc.com;
          Wed, 18 Jan 2023 09:27:31 +0800
Message-ID: <0aaac76f-74a0-f6f9-089f-636b38a2bea7@linux.alibaba.com>
Date:   Wed, 18 Jan 2023 09:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Dave Chinner <david@fromorbit.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
 <20230117101202.4v4zxuj2tbljogbx@wittgenstein> <87fsc9gt7b.fsf@redhat.com>
 <20230117152756.jbwmeq724potyzju@wittgenstein>
 <20230118002242.GB937597@dread.disaster.area>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230118002242.GB937597@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/18 08:22, Dave Chinner wrote:
> On Tue, Jan 17, 2023 at 04:27:56PM +0100, Christian Brauner wrote:
>> On Tue, Jan 17, 2023 at 02:56:56PM +0100, Giuseppe Scrivano wrote:
>>> Christian Brauner <brauner@kernel.org> writes:
>>> 2) no multi repo support:
>>>
>>> Both reflinks and hardlinks do not work across mount points, so we
>>
>> Just fwiw, afaict reflinks work across mount points since at least 5.18.
> 

...

> 
> As such, I think composefs is definitely worth further time and
> investment as a unique line of filesystem development for Linux.
> Solve the chain of trust problem (i.e. crypto signing for the
> manifest files) and we potentially have game changing container
> infrastructure in a couple of thousand lines of code...

I think that is the last time I write some words in this v2
patchset.  At a quick glance of the current v2 patchset:
   
   1) struct cfs_buf {  -> struct erofs_buf;

   2) cfs_buf_put -> erofs_put_metabuf;

   3) cfs_get_buf -> erofs_bread -> (but erofs_read_metabuf() in
                                        v5.17 is much closer);
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/erofs/data.c?h=linux-5.17.y

   4) cfs_dentry_s -> erofs_dirent;

   ...

Also it drops EROFS __lexx and uses buggy uxx instead.

It drops iomap/fscache interface with a stackable file
interface and it doesn't have ACL and (else) I don't
have time to look into more.

That is the current my point of view of the current
Composefs. Yes, you could use/fork any code in
open-source projects, but it currently seems like an
immature EROFS-truncated copy and its cover letter
never mentioned EROFS at all.

I'd suggest you guys refactor similar code (if you
claim that is not another EROFS) before it really
needs to be upstreamed, otherwise I would feel
uneasy as well.  Apart from that, again I have no
objection if folks feel like a new read-only
stackable filesystem like this.

Apart from the codebase, I do hope there could be some
discussion of this topic at LSF/MM/BPF 2023 as Amir
suggested because I don't think this overlay model is
really safe without fs-verity enforcing.

Thank all for the time.  I'm done.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
