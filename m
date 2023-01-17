Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110966E0A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjAQOaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 09:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjAQO3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:29:45 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2381E287;
        Tue, 17 Jan 2023 06:28:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZnLW.p_1673965717;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZnLW.p_1673965717)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 22:28:38 +0800
Message-ID: <74810a5f-3ed3-27f1-caa6-8d3724f1c85e@linux.alibaba.com>
Date:   Tue, 17 Jan 2023 22:28:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1673623253.git.alexl@redhat.com>
 <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
 <20230117101202.4v4zxuj2tbljogbx@wittgenstein> <87fsc9gt7b.fsf@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87fsc9gt7b.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/17 21:56, Giuseppe Scrivano wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 

...

> 
> We looked at EROFS since it is already upstream but it is quite
> different than what we are doing as Alex already pointed out.
> 

Sigh..  please kindly help me find out what's the difference if
EROFS uses some symlink layout for each regular inode?

Some question for me to ask about this new overlay permission
model once again:

What's the difference between symlink (maybe with some limitations)
and this new overlay model? I'm not sure why symlink permission bits
is ignored (AFAIK)?  I don't think it too further since I don't quite
an experienced one in the unionfs field, but if possible, I'm quite
happy to learn new stuffs as a newbie filesystem developer to gain
more knowledge if it could be some topic at LSF/MM/BPF 2023.

> Sure we could bloat EROFS and add all the new features there, after all
> composefs is quite simple, but I don't see how this is any cleaner than
> having a simple file system that does just one thing.

Also if I have time, I could do a code-truncated EROFS without any
useless features specificly for ostree use cases.  Or I could just
seperate out all of that useless code of Ostree-specific use cases
by using Kconfig.

If you don't want to use EROFS from whatever reason, I'm not oppose
to it (You also could use other in-kernel local filesystem for this
as well).  Except for this new overlay model, I just tried to say
how it works similiar to EROFS.

> 
> On top of what was already said: I wish at some point we can do all of
> this from a user namespace.  That is the main reason for having an easy
> on-disk format for composefs.  This seems much more difficult to achieve
> with EROFS given its complexity.

Why?


[ Gao Xiang: this time I will try my best stop talking about EROFS under
   the Composefs patchset anymore because I'd like to avoid appearing at
   the first time (unless such permission model is never discussed until
   now)...

   No matter in the cover letter it never mentioned EROFS at all. ]

Thanks,
Gao Xiang
