Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32752C1785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKWVQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgKWVQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:16:35 -0500
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024AC061A4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 13:16:35 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cg0ML4HQ7zlhShD;
        Mon, 23 Nov 2020 22:16:30 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cg0MJ0YXrzlh8TF;
        Mon, 23 Nov 2020 22:16:28 +0100 (CET)
Subject: Re: [PATCH v24 07/12] landlock: Support filesystem access-control
To:     Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
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
References: <20201112205141.775752-1-mic@digikod.net>
 <20201112205141.775752-8-mic@digikod.net>
 <CAG48ez3HA63CX852LLDFCcNyzRGwAr3x_cvA1-t8tgDxfF1dOQ@mail.gmail.com>
 <1d524ea9-85eb-049c-2156-05cad6d6fcfd@digikod.net>
 <CAG48ez2cmsrZbUEmQmzPQugJikkvfs_MWmMizxmoyspCeXAXRQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <7831e55d-34ef-cf74-3d47-15e2e1edf96c@digikod.net>
Date:   Mon, 23 Nov 2020 22:16:27 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez2cmsrZbUEmQmzPQugJikkvfs_MWmMizxmoyspCeXAXRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 23/11/2020 20:44, Jann Horn wrote:
> On Sat, Nov 21, 2020 at 11:06 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 21/11/2020 08:00, Jann Horn wrote:
>>> On Thu, Nov 12, 2020 at 9:52 PM Mickaël Salaün <mic@digikod.net> wrote:
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
>>>>
>>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>> Cc: James Morris <jmorris@namei.org>
>>>> Cc: Jann Horn <jannh@google.com>
>>>> Cc: Jeff Dike <jdike@addtoit.com>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Richard Weinberger <richard@nod.at>
>>>> Cc: Serge E. Hallyn <serge@hallyn.com>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> ---
>>>>
>>>> Changes since v23:
>>>> * Enforce deterministic interleaved path rules.  To have consistent
>>>>   layered rules, granting access to a path implies that all accesses
>>>>   tied to inodes, from the requested file to the real root, must be
>>>>   checked.  Otherwise, stacked rules may result to overzealous
>>>>   restrictions.  By excluding the ability to add exceptions in the same
>>>>   layer (e.g. /a allowed, /a/b denied, and /a/b/c allowed), we get
>>>>   deterministic interleaved path rules.  This removes an optimization
>>>
>>> I don't understand the "deterministic interleaved path rules" part.
>>
>> I explain bellow.
>>
>>>
>>>
>>> What if I have a policy like this?
>>>
>>> /home/user READ
>>> /home/user/Downloads READ+WRITE
>>>
>>> That's a reasonable policy, right?
>>
>> Definitely, I forgot this, thanks for the outside perspective!
>>
>>>
>>> If I then try to open /home/user/Downloads/foo in WRITE mode, the loop
>>> will first check against the READ+WRITE rule for /home/user, that
>>> check will pass, and then it will check against the READ rule for /,
>>> which will deny the access, right? That seems bad.
>>
>> Yes that was the intent.
>>
>>>
>>>
>>> The v22 code ensured that for each layer, the most specific rule (the
>>> first we encounter on the walk) always wins, right? What's the problem
>>> with that?
>>
>> This can be explained with the interleaved_masked_accesses test:
>> https://github.com/landlock-lsm/linux/blob/landlock-v24/tools/testing/selftests/landlock/fs_test.c#L647
>>
>> In this case there is 4 stacked layers:
>> layer 1: allows s1d1/s1d2/s1d3/file1
>> layer 2: allows s1d1/s1d2/s1d3
>>          denies s1d1/s1d2
>> layer 3: allows s1d1
>> layer 4: allows s1d1/s1d2
>>
>> In the v23, access to file1 would be allowed until layer 3, but layer 4
>> would merge a new rule for the s1d2 inode. Because we don't record where
>> exactly the access come from, we can't tell that layer 2 allowed access
>> thanks to s1d3 and that its s1d2 rule was ignored. I think this behavior
>> doesn't make sense from the user point of view.
> 
> Aah, I think I'm starting to understand the issue now. Basically, with
> the current UAPI, the semantics have to be "an access is permitted if,
> for each policy layer, at least one rule encountered on the pathwalk
> permits the access; rules that deny the access are irrelevant". And if
> it turns out that someone needs to be able to deny access to specific
> inodes, we'll have to extend struct landlock_path_beneath_attr.

Right, I'll add this to the documentation (aligned with the new
implementation).

> 
> That reminds me... if we do need to make such a change in the future,
> it would be easier in terms of UAPI compatibility if
> landlock_add_rule() used copy_struct_from_user(), which is designed to
> create backwards and forwards compatibility with other version of UAPI
> headers. So adding that now might save us some headaches later.

I used copy_struct_from_user() before v21, but Arnd wasn't a fan of
having type and size arguments, so we simplified the UAPI in the v21 by
removing the size argument. The type argument is enough to extend the
structure, but indeed, we lose the forward compatibility. Relying on one
syscall per rule type seems too much, though.

Arnd, what do you think?

> 
> 
>> In the v24, access to file1 would only be allowed with layer 1. The
>> layer 2, would deny access to file1 because of the s1d2 rule. This makes
>> the reasoning consistent and deterministic whatever the layers are,
>> while storing the same access and layer bits. But I agree that this may
>> not be desirable.
>>
>> In a perfect v25, file1 should be allowed by all these layers. I didn't
>> find a simple solution to this while minimizing the memory allocated by
>> rule (cf. struct landlock_rule: mainly 32-bits for access rights and
>> 64-bits for the layers that contributed to this ANDed accesses). I would
>> like to avoid storing 32-bits access rights per stacked layer. Do you
>> see another solution?
> 
> I don't think you can avoid storing the access rights per layer unless
> you actually merge the layers when setting up the ruleset (which would
> be messy). But I don't think that's a big problem. A straightforward
> implementation might become inefficient if you stack too many policy
> layers, but I don't think that's a problem for an initial
> implementation - the common usecase is probably going to be a single
> layer, or maybe two, or something like that?

If layers are correctly used, a few I guess.

> 
> If you had a ton of layers, most of them would likely specify the same
> access permissions - so one possible optimization might be to use the
> current representation if all rules matching the inode specify the
> same permissions, and use a different representation otherwise. But I
> don't think such an optimization is necessary at this point.

I agree, I'll not implement such optimization for now.
