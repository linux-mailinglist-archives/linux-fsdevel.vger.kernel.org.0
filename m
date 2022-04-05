Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE014F4D55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581950AbiDEXlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457508AbiDEQDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:19 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F5245BA
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 08:55:35 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KXsgB4M82zMq0sP;
        Tue,  5 Apr 2022 17:55:34 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KXsg91X3NzlhSMT;
        Tue,  5 Apr 2022 17:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649174134;
        bh=n8eScuGwrUyyZSJgvZ6lVdoUOYD/v6TfS3yMx/Udtks=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=JnDSENf16eneR0rB24qn+a2KSFPCjzI4EXohLg+3kAT8m4AC3+MfQVCKykfm6TKH2
         MCz+01LQ4oBu62PsNO8nwK1T+DFOsDvhCKaFTkZKM9hj4PFy4VmKOnL/ryJ8yuTY6R
         irEn/3AiFzY58nJOspTOKxoSr9FMCyracTvvgYF8=
Message-ID: <673bfc0f-7263-9404-3d88-6cc0ae1a1ae1@digikod.net>
Date:   Tue, 5 Apr 2022 17:55:58 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <202204041451.CC4F6BF@keescook>
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


On 05/04/2022 00:25, Kees Cook wrote:
> On Mon, Apr 04, 2022 at 02:28:19PM -0700, Linus Torvalds wrote:
>> Now, what I *think* you mean is
>>
>>   (1) user-space executable loaders want to be able to test the *same*
>> policy as the kernel does for execve()
> 
> Right. The script interpreter wants to ask "if this file were actually
> an ELF going through execve(), would the kernel allow it?"

The current behavior was a bit more flexible thanks to the sysctl. It 
was either the mount exec option check, the file perm check or both. The 
rationale is to let sysadmins adapt their system to existing 
applications/interpreters without breaking. Only basing the check on 
mount exec and file perm could be an issue in the short term, but I 
guess it would deter inconsistencies in existing systems… I'm not sure 
it is a wise move because if no interpreter want to use this check it 
would then be useless. See commit message in 
https://lore.kernel.org/all/20220104155024.48023-3-mic@digikod.net/ and 
the trusted_for_policy sysctl documentation:

"Even without enforced security policy, user space interpreters can use
this syscall to try as much as possible to enforce the system policy at
their level, knowing that it will not break anything on running systems
which do not care about this feature.  However, on systems which want
this feature enforced, there will be knowledgeable people (i.e. system
administrator who configured fs.trusted_for_policy deliberately) to
manage it. [...]"


> 
>>   (2) access(path, EXECVE_OK) will do the same permission checks as
>> "execve()" would do for that path
> 
> Maybe. I defer to Mickaël here, but my instinct is to avoid creating an
> API that can be accidentally misused. I'd like this to be fd-only based,
> since that removes path name races. (e.g. trusted_for() required an fd.)

The fd-based approach is definitely better from a security point of view 
but there is indeed a use case for pathnames. I guess we could highlight 
this point in the documentation.

> 
>>   (3) if you already have the fd open, use "faccess(fd, NULL,
>> F_OK_TO_EXECUTE, AT_EMPTY_PATH)"
> 
> Yes, specifically faccessat2(). (And continuing the race thought above,
> yes, there could still be races if the content of the file could be
> changed, but that case is less problematic under real-world conditions.)

I'm not worried about changes in the file once it is opened. This could 
be an issue but not in the kernel (e.g. flaky update system).

[...]
