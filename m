Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E1B4F4D24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581574AbiDEXj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457342AbiDEQDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:06 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518521FA76
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 08:38:21 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KXsHG6sFqzMpxx0;
        Tue,  5 Apr 2022 17:38:18 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KXsHB10mbzlhNts;
        Tue,  5 Apr 2022 17:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649173098;
        bh=CsXI63Mo7UO6r/uWwmX4gFbUZp/CXy5CRXKt0P6gt6c=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=gmHoadq5c/jpwjvzRlDxdSe/QMSdIkQfuWdwnlle2JMgrxICKuYw2Otz5agkacD7Z
         B3oSAGjmLbhr+bMhGpyxWhZRNmQP4WVnKkPPMB7gr9oFepQ8SCfZOo8micekUP/VgR
         nsB09g6YQOZdXoGywDPjQHeZ/pGkYe4CO0FU08J8=
Message-ID: <1eeae491-7f4f-2cbc-7dbb-04e926c78b89@digikod.net>
Date:   Tue, 5 Apr 2022 17:38:39 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 04/04/2022 23:28, Linus Torvalds wrote:
> On Mon, Apr 4, 2022 at 1:29 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> This initial proposal was using a new faccessat2(2) flag:
>> AT_INTERPRETED, see
>> https://lore.kernel.org/all/20200908075956.1069018-2-mic@digikod.net/
>> What do you think about that? I'm happy to get back to this version if
>> everyone is OK with it.
> 
> I'm certainly happi_er_ with that, but I find that particular patch
> odd for other reasons.
> 
> In no particular order:
> 
>   - what's with the insane non-C syntax? Double parentheses have no
> actual meaning in C:
> 
>       if ((flags & AT_INTERPRETED)) {
>           if ((mode & MAY_EXEC)) {
> 
>     so I don't understand why you'd use that strance thing.

I guess it comes from a previous version that ANDed two booleans.


> 
>   - why is this an AT_INTERPRETED flag? I don't understand the name, I
> don't understand the semantics.

I wasn't sure it was a good idea to add another mode bit, so I ended up 
using a flag to not break compatibility of other mode checks but extend 
the semantic to interpreted scripts. But I agree that a new mode makes 
sense.


> 
>     Why would that flag have the same value as AT_SYMLINK_FOLLOW?

It was a bug.


> 
>     Why isn't this just a new _mode_ bit, which is what I feel is
> sensible? We only use three bits (with no bits set meaning
> "existence"), so we have *tons* of bits left in that namespace, and it
> would make much more sense to me to have
> 
>          #define EXECVE_OK 8
> 
>      which is the same as the "group exec" bit, so it actually makes
> some kind of sense too.

Looks fine to me. The "EXECVE_" prefix is a bit weird but it will not be 
defined in the kernel like X_OK and others anyway, and as you said, it 
matches S_IXGRP.


> 
>   - related to that "I don't understand the semantics", the
> "documentation" for that thing doesn't make sense either:
> 
>      +         The
>      +    main usage is for script
>      +    interpreters to enforce a policy
>      +    consistent with the kernel's one
>      +    (through sysctl configuration or LSM
>      +    policy).  */

I'll synchronize the documentation with a next series.


> 
> Now, what I *think* you mean is
See a following email in reply to Kees.
[...]

> 
> And yes, we still need to talk details:
> 
>   - no backwards compatibility issues, because we've happily always
> checked 'mode' for being valid, so old kernels will always return
> -EINVAL.
> 
>   - POSIX namespace issues for EXECVE_OK means that the name probably
> needs some thinking (maybe we just need to call it __ACCESS_OK_EXECVE
> internally or something - the kernel actually doesn't even export the
> existing [FRWX]_OK values, because we "know" they map tho the usual
> "owner RWX" bits, with F being "no bit set")

Right, I cannot find a better name for now.

See a following email in reply to Kees.
[...]

> 
> So to recap: I'm very much ok with some access() extension, but I
> think even that very much needs clarification, and the existing patch
> is just odd in many many ways.

This v8 was kind of an early version, I'll update everything. Thanks!
