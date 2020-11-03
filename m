Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5F2A4AB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgKCQDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgKCQDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:03:51 -0500
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ECEC061A48
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 08:03:50 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CQZMm1C8kzlhqv5;
        Tue,  3 Nov 2020 17:03:48 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CQZMk0bzXzlh8TS;
        Tue,  3 Nov 2020 17:03:46 +0100 (CET)
Subject: Re: [PATCH v22 07/12] landlock: Support filesystem access-control
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201027200358.557003-1-mic@digikod.net>
 <20201027200358.557003-8-mic@digikod.net>
 <CAG48ez1xMfxkwhXK4b1BB4GrTVauNzfwPoCutn9axKt_PFRSVQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <056d8f1a-b45f-379f-d81a-8c13a1536c3f@digikod.net>
Date:   Tue, 3 Nov 2020 17:03:45 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1xMfxkwhXK4b1BB4GrTVauNzfwPoCutn9axKt_PFRSVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:06, Jann Horn wrote:
> (On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:

>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> [...]
>> +static inline u32 get_file_access(const struct file *const file)
>> +{
>> +       u32 access = 0;
>> +
>> +       if (file->f_mode & FMODE_READ) {
>> +               /* A directory can only be opened in read mode. */
>> +               if (S_ISDIR(file_inode(file)->i_mode))
>> +                       return LANDLOCK_ACCESS_FS_READ_DIR;
>> +               access = LANDLOCK_ACCESS_FS_READ_FILE;
>> +       }
>> +       /*
>> +        * A LANDLOCK_ACCESS_FS_APPEND could be added but we also need to check
>> +        * fcntl(2).
>> +        */
> 
> Once https://lore.kernel.org/linux-api/20200831153207.GO3265@brightrain.aerifal.cx/
> lands, pwritev2() with RWF_NOAPPEND will also be problematic for
> classifying "write" vs "append"; you may want to include that in the
> comment. (Or delete the comment.)

Contrary to fcntl(2), pwritev2(2) doesn't seems to modify the file
description. Otherwise, other LSMs would need to be patched.
I'll remove this comment anyway.

> 
>> +       if (file->f_mode & FMODE_WRITE)
>> +               access |= LANDLOCK_ACCESS_FS_WRITE_FILE;
>> +       /* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
>> +       if (file->f_flags & __FMODE_EXEC)
>> +               access |= LANDLOCK_ACCESS_FS_EXECUTE;
>> +       return access;
>> +}
> [...]
> 
