Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DE750649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGLLi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjGLLix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:38:53 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DE1BE2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 04:38:36 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R1G2z2HkhzMpnPD;
        Wed, 12 Jul 2023 11:38:35 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R1G2y0VmBzMpr0r;
        Wed, 12 Jul 2023 13:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689161915;
        bh=WKYepZWiuysWhTyUjDnyBuU4+gQ8j8tjmHlLfmEnR2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FnaAPh5dYrQKOkoIGkLCOlskjMOnK9aGYHsnDLH2pa043qQ4wZ+R6QPHTVgWZ1eZm
         c/PZGmMqDAj8QCVJj+3lGQKPwEc+O9BEWO6qup/R1ZDpeLVrgSed2+YKgpijN5+izo
         XmK4X5iWVds1jEC0JctIsV6BzcXHQoDPxnYNZFMY=
Message-ID: <35048daf-a369-7fa0-3ad6-56901a2c22bc@digikod.net>
Date:   Wed, 12 Jul 2023 13:38:33 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 0/4] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
 <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
 <ZK6JhyiC0Z0vwu0u@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZK6JhyiC0Z0vwu0u@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/07/2023 13:08, Günther Noack wrote:
> Hello!
> 
> On Sat, Jun 17, 2023 at 11:47:55AM +0200, Mickaël Salaün wrote:
>>>> We should also think about batch operations on FD (see the
>>>> close_range syscall), for instance to deny all IOCTLs on inherited
>>>> or received FDs.
>>>
>>> Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
>>> rights for an entire range of FDs?
>>>
>>> I have to admit, I'm not familiar with the real-life use cases of
>>> close_range().  In most programs I work with, it's difficult to reason
>>> about their ordering once the program has really started to run. So I
>>> imagine that close_range() is mostly used to "sanitize" the open file
>>> descriptors at the start of main(), and you have a similar use case in
>>> mind for this one as well?
>>>
>>> If it's just about closing the range from 0 to 2, I'm not sure it's
>>> worth adding a custom syscall. :)
>>
>> The advantage of this kind of range is to efficiently manage all potential
>> FDs, and the main use case is to close (or change, see the flags) everything
>> *except" 0-2 (i.e. 3-~0), and then avoid a lot of (potentially useless)
>> syscalls.
>>
>> The Landlock interface doesn't need to be a syscall. We could just add a new
>> rule type which could take a FD range and restrict them when calling
>> landlock_restrict_self(). Something like this:
>> struct landlock_fd_attr {
>>      __u64 allowed_access;
>>      __u32 first;
>>      __u32 last;
>> }
> 
> FYI, regarding the idea of dropping rights on already-opened files:
> I'm starting to have doubts about how feasible this is in practice.
> 
> The "obvious" approach is to just remove the access rights from the security
> blob flags on the struct file.
> 
> But these opened "struct file"s might be shared with other processes already,
> and mutating them in place would have undesired side effects on other processes.
> 
> For example, if brltty uses ioctls on the terminal and then one of the programs
> running in that terminal drops ioctl rights on that open file, it would affect
> brltty as well, because both the Landlocked program and brltty use the same
> struct file.
> 
> It could be technically stored next to the file descriptor list, where the
> close-on-exec flag is also stored, but that seems more cumbersome than I had
> hoped.  I don't have a good approach for that idea yet, so I'll drop it for now.

Indeed, as discussed in another thread (patch v9 network support), I now 
think that file descriptors should not be touched nor restricted by 
Landlock. Even if there are file *descriptions* and file descriptors, 
Landlock should focus on what user space cannot already do (i.e. close 
file descriptors). Already acquired file descriptors should be a concern 
for user space sandboxers and the whole system/services.

> 
> Ideas are welcome. :)
> 
> —Günther
> 
