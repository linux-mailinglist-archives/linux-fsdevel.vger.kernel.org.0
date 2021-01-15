Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648762F74F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhAOJLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 04:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbhAOJLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:11:12 -0500
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35736C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 01:10:27 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DHFl51bMyzMprtq;
        Fri, 15 Jan 2021 10:10:25 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DHFl26L60zlppyv;
        Fri, 15 Jan 2021 10:10:22 +0100 (CET)
Subject: Re: [PATCH v26 07/12] landlock: Support filesystem access-control
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
References: <20201209192839.1396820-1-mic@digikod.net>
 <20201209192839.1396820-8-mic@digikod.net>
 <CAG48ez1wbAQwU-eoC9DngHyUM_5F01MJQpRnLaJFvfRUrnXBdA@mail.gmail.com>
 <aeb3e152-8108-89d2-0577-4b130368f14f@digikod.net>
 <CAG48ez2HJCFvmFALDYDYnufE755Dqh3JquAMf-1mnzmRrdKaoQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <9be6481f-9c03-dd32-378f-20bc7c52315c@digikod.net>
Date:   Fri, 15 Jan 2021 10:10:36 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez2HJCFvmFALDYDYnufE755Dqh3JquAMf-1mnzmRrdKaoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/01/2021 23:43, Jann Horn wrote:
> On Thu, Jan 14, 2021 at 7:54 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 14/01/2021 04:22, Jann Horn wrote:
>>> On Wed, Dec 9, 2020 at 8:28 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> Thanks to the Landlock objects and ruleset, it is possible to identify
>>>> inodes according to a process's domain.  To enable an unprivileged
>>>> process to express a file hierarchy, it first needs to open a directory
>>>> (or a file) and pass this file descriptor to the kernel through
>>>> landlock_add_rule(2).  When checking if a file access request is
>>>> allowed, we walk from the requested dentry to the real root, following
>>>> the different mount layers.  The access to each "tagged" inodes are
>>>> collected according to their rule layer level, and ANDed to create
>>>> access to the requested file hierarchy.  This makes possible to identify
>>>> a lot of files without tagging every inodes nor modifying the
>>>> filesystem, while still following the view and understanding the user
>>>> has from the filesystem.
>>>>
>>>> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
>>>> keep the same struct inodes for the same inodes whereas these inodes are
>>>> in use.
>>>>
>>>> This commit adds a minimal set of supported filesystem access-control
>>>> which doesn't enable to restrict all file-related actions.  This is the
>>>> result of multiple discussions to minimize the code of Landlock to ease
>>>> review.  Thanks to the Landlock design, extending this access-control
>>>> without breaking user space will not be a problem.  Moreover, seccomp
>>>> filters can be used to restrict the use of syscall families which may
>>>> not be currently handled by Landlock.
>>> [...]
>>>> +static bool check_access_path_continue(
>>>> +               const struct landlock_ruleset *const domain,
>>>> +               const struct path *const path, const u32 access_request,
>>>> +               u64 *const layer_mask)
>>>> +{
>>> [...]
>>>> +       /*
>>>> +        * An access is granted if, for each policy layer, at least one rule
>>>> +        * encountered on the pathwalk grants the access, regardless of their
>>>> +        * position in the layer stack.  We must then check not-yet-seen layers
>>>> +        * for each inode, from the last one added to the first one.
>>>> +        */
>>>> +       for (i = 0; i < rule->num_layers; i++) {
>>>> +               const struct landlock_layer *const layer = &rule->layers[i];
>>>> +               const u64 layer_level = BIT_ULL(layer->level - 1);
>>>> +
>>>> +               if (!(layer_level & *layer_mask))
>>>> +                       continue;
>>>> +               if ((layer->access & access_request) != access_request)
>>>> +                       return false;
>>>> +               *layer_mask &= ~layer_level;
>>>
>>> Hmm... shouldn't the last 5 lines be replaced by the following?
>>>
>>> if ((layer->access & access_request) == access_request)
>>>     *layer_mask &= ~layer_level;
>>>
>>> And then, since this function would always return true, you could
>>> change its return type to "void".
>>>
>>>
>>> As far as I can tell, the current version will still, if a ruleset
>>> looks like this:
>>>
>>> /usr read+write
>>> /usr/lib/ read
>>>
>>> reject write access to /usr/lib, right?
>>
>> If these two rules are from different layers, then yes it would work as
>> intended. However, if these rules are from the same layer the path walk
>> will not stop at /usr/lib but go down to /usr, which grants write
>> access.
> 
> I don't see why the code would do what you're saying it does. And an
> experiment seems to confirm what I said; I checked out landlock-v26,
> and the behavior I get is:

There is a misunderstanding, I was responding to your proposition to
modify check_access_path_continue(), not about the behavior of landlock-v26.

> 
> user@vm:~/landlock$ dd if=/dev/null of=/tmp/aaa
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 0.00106365 s, 0.0 kB/s
> user@vm:~/landlock$ LL_FS_RO='/lib' LL_FS_RW='/' ./sandboxer dd
> if=/dev/null of=/tmp/aaa
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 0.000491814 s, 0.0 kB/s
> user@vm:~/landlock$ LL_FS_RO='/tmp' LL_FS_RW='/' ./sandboxer dd
> if=/dev/null of=/tmp/aaa
> dd: failed to open '/tmp/aaa': Permission denied
> user@vm:~/landlock$
> 
> Granting read access to /tmp prevents writing to it, even though write
> access was granted to /.
> 

It indeed works like this with landlock-v26. However, with your above
proposition, it would work like this:

$ LL_FS_RO='/tmp' LL_FS_RW='/' ./sandboxer dd if=/dev/null of=/tmp/aaa
0+0 records in
0+0 records out
0 bytes copied, 0.000187265 s, 0.0 kB/s

…which is not what users would expect I guess. :)
