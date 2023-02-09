Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E98690DA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 16:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIPyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 10:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjBIPyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:54:36 -0500
X-Greylist: delayed 636 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 07:54:34 PST
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696837572
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 07:54:33 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PCLk53YH7zMrkNX;
        Thu,  9 Feb 2023 16:43:25 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PCLk258CPzlh7;
        Thu,  9 Feb 2023 16:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1675957405;
        bh=bNW1Wg5WZW0nIMURTxjwXxKKJeK4hLfabPIk0obS01U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yhrC9HODCmFSivOVE0IKp2ondNaaLvcg5W8tO3K+NLu2V/sCkaEy51YAikMxX/bO+
         JxbV6GVXYwWp/EAnZjDieUo20IlNb8SiewRkBmtbJDATbN4UF9y7i7V377UMQNMKZD
         zeNtRSi9skrTTd1wFJGc6zKnCNxdcpxM9Wxblc2U=
Message-ID: <376258a7-b7fa-51f9-2137-c123b8ff304e@digikod.net>
Date:   Thu, 9 Feb 2023 16:43:21 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     concord@gentoo.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
 <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
 <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
 <63e3f8c8.050a0220.c0b3f.434b@mx.google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <63e3f8c8.050a0220.c0b3f.434b@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/02/2023 20:32, Kees Cook wrote:
> *thread necromancy*
> 
> On Tue, Apr 05, 2022 at 06:09:03PM +0200, Mickaël Salaün wrote:
>>
>> On 05/04/2022 01:26, Linus Torvalds wrote:
>>> On Mon, Apr 4, 2022 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> [...]
>>
>>>
>>>> I think this already exists as AT_EACCESS? It was added with
>>>> faccessat2() itself, if I'm reading the history correctly.
>>>
>>> Yeah, I noticed myself, I just hadn't looked (and I don't do enough
>>> user-space programming to be aware of if that way).
>>
>> I think AT_EACCESS should be usable with the new EXECVE_OK too.
>>
>>
>>>
>>>>>       (a) "what about suid bits that user space cannot react to"
>>>>
>>>> What do you mean here? Do you mean setid bits on the file itself?
>>>
>>> Right.
>>>
>>> Maybe we don't care.
>>
>> I think we don't. I think the only corner case that could be different is
>> for files that are executable, SUID and non-readable. In this case it
>> wouldn't matter because userspace could not read the file, which is required
>> for interpretation/execution. Anyway, S[GU]ID bits in scripts are just
>> ignored by execve and we want to follow the same semantic.
> 
> Hi Mickaël,
> 
> Is there a new version of this being worked on? It would be really nice
> to have the O_MAYEXEC/faccessat2() visibility for script execution control
> in userspace. It seems like it would be mainly a respin of an earlier
> version of this series before trusted_for() was proposed.

Yes, I plan to send a new version in a few weeks.

> 
> -Kees
> 
