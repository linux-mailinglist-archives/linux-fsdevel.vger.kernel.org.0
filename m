Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49C1723F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgB0QvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 11:51:14 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:54545 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgB0QvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:51:14 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (smtp-2-0000.mail.infomaniak.ch [10.5.36.107])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id 01RGoZLm055757
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Feb 2020 17:50:35 +0100
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48SzF33Z82zlj7qp;
        Thu, 27 Feb 2020 17:50:31 +0100 (CET)
Subject: Re: [RFC PATCH v14 05/10] fs,landlock: Support filesystem
 access-control
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-6-mic@digikod.net>
 <CAG48ez36SMrPPgsj0omcVukRLwOzBzqWOQjuGCmmmrmsGiNukw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <34319b76-44bd-8915-fd7c-5147f901615e@digikod.net>
Date:   Thu, 27 Feb 2020 17:50:31 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez36SMrPPgsj0omcVukRLwOzBzqWOQjuGCmmmrmsGiNukw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/02/2020 21:29, Jann Horn wrote:
> On Mon, Feb 24, 2020 at 5:03 PM Mickaël Salaün <mic@digikod.net> wrote:
>> +static inline u32 get_mem_access(unsigned long prot, bool private)
>> +{
>> +       u32 access = LANDLOCK_ACCESS_FS_MAP;
>> +
>> +       /* Private mapping do not write to files. */
>> +       if (!private && (prot & PROT_WRITE))
>> +               access |= LANDLOCK_ACCESS_FS_WRITE;
>> +       if (prot & PROT_READ)
>> +               access |= LANDLOCK_ACCESS_FS_READ;
>> +       if (prot & PROT_EXEC)
>> +               access |= LANDLOCK_ACCESS_FS_EXECUTE;
>> +       return access;
>> +}
> 
> When I do the following, is landlock going to detect that the mmap()
> is a read access, or is it incorrectly going to think that it's
> neither read nor write?
> 
> $ cat write-only.c
> #include <fcntl.h>
> #include <sys/mman.h>
> #include <stdio.h>
> int main(void) {
>   int fd = open("/etc/passwd", O_RDONLY);
>   char *ptr = mmap(NULL, 0x1000, PROT_WRITE, MAP_PRIVATE, fd, 0);
>   printf("'%.*s'\n", 4, ptr);
> }
> $ gcc -o write-only write-only.c -Wall
> $ ./write-only
> 'root'
> $
> 

Thanks to the "if (!private && (prot & PROT_WRITE))", Landlock allows
this private mmap (as intended) even if there is no write access to this
file, but not with a shared mmap (and a file opened with O_RDWR). I just
added a test for this to be sure.

However, I'm not sure this hook is useful for now. Indeed, the process
still need to have a file descriptor open with the right accesses.
