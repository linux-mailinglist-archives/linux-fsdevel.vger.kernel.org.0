Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44344F7C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 13:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhKNMMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 07:12:01 -0500
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:40911 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhKNML7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 07:11:59 -0500
X-Greylist: delayed 83216 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2021 07:11:59 EST
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HsWMM73kGzMpvZb;
        Sun, 14 Nov 2021 13:09:03 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HsWMH5cBRzlh8Tl;
        Sun, 14 Nov 2021 13:08:59 +0100 (CET)
Subject: Re: [PATCH v16 1/3] fs: Add trusted_for(2) syscall implementation and
 related sysctl
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20211110190626.257017-1-mic@digikod.net>
 <20211110190626.257017-2-mic@digikod.net>
 <8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com>
 <5312f022-96ea-5555-8d17-4e60a33cf8f8@digikod.net>
 <34779736-e875-c3e0-75d5-0f0a55d729aa@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <ebaba192-1f0b-eb5e-0914-a0c885afdac6@digikod.net>
Date:   Sun, 14 Nov 2021 13:09:06 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <34779736-e875-c3e0-75d5-0f0a55d729aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/11/2021 20:56, Alejandro Colomar (man-pages) wrote:
> Hi Mickaël,
> 
> On 11/13/21 14:02, Mickaël Salaün wrote:
>>> TL;DR:
>>>
>>> ISO C specifies that for the following code:
>>>
>>>      enum foo {BAR};
>>>
>>>      enum foo foobar;
>>>
>>> typeof(foo)    shall be int
>>> typeof(foobar) is implementation-defined
>>
>> I tested with some version of GCC (from 4.9 to 11) and clang (10 and 11)
>> with different optimizations and the related sizes are at least the same
>> as for the int type.
> 
> GCC has -fshort-enums to make enum types be as short as possible.  I
> expected -Os to turn this on, since it saves space, but it doesn't.
> 
> Still, not relying on enum == int is better, IMO.
> 
>>
>>>
>>> Since foobar = BAR; assigns an int, the best thing to do to avoid
>>> implementation-defined behavior, is to declare foobar as int too.
>>
>> OK, so it should be enough to change the syscall argument type from enum
>> trusted_for_usage to int, but we can keep the UAPI with the enum (i.e.
>> we don't need to change the value to #define TRUSTED_FOR_EXECUTION 1)
>> right?
> 
> Correct.  The enumerations are guaranteed to be int (except in case of
> UB, see below), so they'll be (almost) the same as a #define after the
> preprocessor.

Thanks for the detailed explanation! I'll send a new patch taking into
account your suggestion.

> 
> 
> If you do
> 
> enum foo {
>     FOO = 1L << INT_WIDTH
> };
> 
> since that doesn't fit in either int or unsigned int,
> it is Undefined Behavior,
> and here GCC decides to use long for FOO.
> 
> +++++++++ UB example ++++++++++++++
> 
> $ cat foo.c
>     #include <limits.h>
>     #include <stdio.h>
> 
> 
>     enum foo {
>         FOO = 1L << UINT_WIDTH
>     };
> 
>     int main(void)
>     {
>         printf("\tsizeof(enum foo) = %zu\n", sizeof(enum foo));
>         printf("\tsizeof(FOO)      = %zu\n", sizeof(FOO));
>     }
> 
> $ cc foo.c -Wall -Wextra -Werror -Wpedantic -pedantic-errors -std=c2x
> foo.c:6:23: error: ISO C restricts enumerator values to range of 'int'
> [-Wpedantic]
>     6 |                 FOO = 1L << UINT_WIDTH
>       |                       ^~
> $ cc foo.c -Wall -Wextra -Werror -std=c2x
> $ ./a.out
>     sizeof(enum foo) = 8
>     sizeof(FOO)      = 8
> 
> +++++++++++++ -fshort-enums example +++++++++++++++
> 
> $ cat foo.c
>     #include <stdio.h>
> 
> 
>     enum foo {
>         FOO = 1
>     };
> 
>     int main(void)
>     {
>         printf("\tsizeof(enum foo) = %zu\n", sizeof(enum foo));
>         printf("\tsizeof(FOO)      = %zu\n", sizeof(FOO));
>     }
> 
> $ cc foo.c -Wall -Wextra -Werror -Wpedantic -pedantic-errors -fshort-enums
> $ ./a.out
>     sizeof(enum foo) = 1
>     sizeof(FOO)      = 4
> 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Cheers,
> Alex
> 
> 
>>
>>>
>>>
>>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>>> index 528a478dbda8..c535e0e43cc8 100644
>>>> --- a/include/linux/syscalls.h
>>>> +++ b/include/linux/syscalls.h
>>>> @@ -462,6 +463,7 @@ asmlinkage long sys_fallocate(int fd, int mode,
>>>> loff_t offset, loff_t len);
>>>>    asmlinkage long sys_faccessat(int dfd, const char __user *filename,
>>>> int mode);
>>>>    asmlinkage long sys_faccessat2(int dfd, const char __user *filename,
>>>> int mode,
>>>>                       int flags);
>>>> +asmlinkage long sys_trusted_for(int fd, enum trusted_for_usage usage,
>>>> u32 flags);
>>>
>>> Same here.
>>>
>>>>    asmlinkage long sys_chdir(const char __user *filename);
>>>>    asmlinkage long sys_fchdir(unsigned int fd);
>>>>    asmlinkage long sys_chroot(const char __user *filename);
>>>
>>> Thanks,
>>> Alex
>>>
>>>
> 
