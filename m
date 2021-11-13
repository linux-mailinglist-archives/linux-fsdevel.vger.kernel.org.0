Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198244F32C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhKMNFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 08:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhKMNFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:05:11 -0500
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28BC061203
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Nov 2021 05:02:14 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Hrwb60SPVzMpqmc;
        Sat, 13 Nov 2021 14:02:10 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HrwZv5yQNzlh8T4;
        Sat, 13 Nov 2021 14:01:59 +0100 (CET)
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <5312f022-96ea-5555-8d17-4e60a33cf8f8@digikod.net>
Date:   Sat, 13 Nov 2021 14:02:02 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/11/2021 20:16, Alejandro Colomar (man-pages) wrote:
> Hi Mickaël,

Hi Alejandro,

> 
> On 11/10/21 20:06, Mickaël Salaün wrote:
>> diff --git a/fs/open.c b/fs/open.c
>> index f732fb94600c..96a80abec41b 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -480,6 +482,114 @@ SYSCALL_DEFINE2(access, const char __user *,
>> filename, int, mode)
>>       return do_faccessat(AT_FDCWD, filename, mode, 0);
>>   }
>>   +#define TRUST_POLICY_EXEC_MOUNT            BIT(0)
>> +#define TRUST_POLICY_EXEC_FILE            BIT(1)
>> +
>> +int sysctl_trusted_for_policy __read_mostly;
>> +
>> +/**
> ...
>> + */
>> +SYSCALL_DEFINE3(trusted_for, const int, fd, const enum
>> trusted_for_usage, usage,
> 
> Please, don't use enums for interfaces.  They are implementation defined
> types, and vary between compilers and within the same compiler also
> depending on optimization flags.
> 
> C17::6.7.2.2.4:
> [
> Each enumerated type shall be compatible with char,
> a signed integer type, or an unsigned integer type.
> The choice of type is implementation-defined,130)
> but shall be capable of representing the values of
> all the members of the enumeration.
> ]
> 
> See also:
> <https://stackoverflow.com/questions/366017/what-is-the-size-of-an-enum-in-c>
> 
> 
> So, please use only standard integer types for interfaces.
> 
> And in the case of enums, since the language specifies that enumeration
> constants (the macro-like identifiers) are of type int, it makes sense
> for functions to use int.
> 
> C17::6.7.2.2.3:
> [
> The identifiers in an enumerator list are declared as constants
> that have type int and may appear wherever such are permitted.
> ]
> 
> I'd use an int for the API/ABI, even if it's expected to be assigned
> values of 'enum trusted_for_usage' (that should be specified in the
> manual page in DESCRIPTION, but not in SYNOPSIS, which should specify int).
> 
> 
> 
> TL;DR:
> 
> ISO C specifies that for the following code:
> 
>     enum foo {BAR};
> 
>     enum foo foobar;
> 
> typeof(foo)    shall be int
> typeof(foobar) is implementation-defined

I tested with some version of GCC (from 4.9 to 11) and clang (10 and 11)
with different optimizations and the related sizes are at least the same
as for the int type.

> 
> Since foobar = BAR; assigns an int, the best thing to do to avoid
> implementation-defined behavior, is to declare foobar as int too.

OK, so it should be enough to change the syscall argument type from enum
trusted_for_usage to int, but we can keep the UAPI with the enum (i.e.
we don't need to change the value to #define TRUSTED_FOR_EXECUTION 1) right?

> 
> 
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 528a478dbda8..c535e0e43cc8 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -462,6 +463,7 @@ asmlinkage long sys_fallocate(int fd, int mode,
>> loff_t offset, loff_t len);
>>   asmlinkage long sys_faccessat(int dfd, const char __user *filename,
>> int mode);
>>   asmlinkage long sys_faccessat2(int dfd, const char __user *filename,
>> int mode,
>>                      int flags);
>> +asmlinkage long sys_trusted_for(int fd, enum trusted_for_usage usage,
>> u32 flags);
> 
> Same here.
> 
>>   asmlinkage long sys_chdir(const char __user *filename);
>>   asmlinkage long sys_fchdir(unsigned int fd);
>>   asmlinkage long sys_chroot(const char __user *filename);
> 
> Thanks,
> Alex
> 
> 
