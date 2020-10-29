Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF26C29E750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJ2JaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 05:30:10 -0400
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:39353 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgJ2JaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:30:09 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CMKsq0bfrzljf95;
        Thu, 29 Oct 2020 10:30:07 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CMKsn1t98zlh8Tj;
        Thu, 29 Oct 2020 10:30:05 +0100 (CET)
Subject: Re: [PATCH v22 01/12] landlock: Add object management
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
 <20201027200358.557003-2-mic@digikod.net>
 <CAG48ez3CKa12SFHjVUPnYzJm2E7OBWnuh3JzVMrsvqdcMS1A8A@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <afa8e978-d22c-f06a-d57b-e0d1a9918062@digikod.net>
Date:   Thu, 29 Oct 2020 10:30:04 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez3CKa12SFHjVUPnYzJm2E7OBWnuh3JzVMrsvqdcMS1A8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:05, Jann Horn wrote:
> On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>> A Landlock object enables to identify a kernel object (e.g. an inode).
>> A Landlock rule is a set of access rights allowed on an object.  Rules
>> are grouped in rulesets that may be tied to a set of processes (i.e.
>> subjects) to enforce a scoped access-control (i.e. a domain).
>>
>> Because Landlock's goal is to empower any process (especially
>> unprivileged ones) to sandbox themselves, we cannot rely on a
>> system-wide object identification such as file extended attributes.
>> Indeed, we need innocuous, composable and modular access-controls.
>>
>> The main challenge with these constraints is to identify kernel objects
>> while this identification is useful (i.e. when a security policy makes
>> use of this object).  But this identification data should be freed once
>> no policy is using it.  This ephemeral tagging should not and may not be
>> written in the filesystem.  We then need to manage the lifetime of a
>> rule according to the lifetime of its objects.  To avoid a global lock,
>> this implementation make use of RCU and counters to safely reference
>> objects.
>>
>> A following commit uses this generic object management for inodes.
>>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks for the review.

> 
> except for some minor nits:
> 
> [...]
>> diff --git a/security/landlock/object.c b/security/landlock/object.c
> [...]
>> +void landlock_put_object(struct landlock_object *const object)
>> +{
>> +       /*
>> +        * The call to @object->underops->release(object) might sleep e.g.,
> 
> s/ e.g.,/, e.g./

I indeed prefer the comma preceding the "e.g.", but it seems that there
is a difference between UK english and US english:
https://english.stackexchange.com/questions/16172/should-i-always-use-a-comma-after-e-g-or-i-e
Looking at the kernel documentation makes it clear:
$ git grep -F 'e.g. ' | wc -l
1179
$ git grep -F 'e.g., ' | wc -l
160

I'll apply your fix in the whole patch series.

> 
>> +        * because of iput().
>> +        */
>> +       might_sleep();
>> +       if (!object)
>> +               return;
> [...]
>> +}
>> diff --git a/security/landlock/object.h b/security/landlock/object.h
> [...]
>> +struct landlock_object {
>> +       /**
>> +        * @usage: This counter is used to tie an object to the rules matching
>> +        * it or to keep it alive while adding a new rule.  If this counter
>> +        * reaches zero, this struct must not be modified, but this counter can
>> +        * still be read from within an RCU read-side critical section.  When
>> +        * adding a new rule to an object with a usage counter of zero, we must
>> +        * wait until the pointer to this object is set to NULL (or recycled).
>> +        */
>> +       refcount_t usage;
>> +       /**
>> +        * @lock: Guards against concurrent modifications.  This lock must be
> 
> s/must be/must be held/ ?

Right.

> 
>> +        * from the time @usage drops to zero until any weak references from
>> +        * @underobj to this object have been cleaned up.
>> +        *
>> +        * Lock ordering: inode->i_lock nests inside this.
>> +        */
>> +       spinlock_t lock;
> [...]
>> +};
>> +
>> +struct landlock_object *landlock_create_object(
>> +               const struct landlock_object_underops *const underops,
>> +               void *const underojb);
> 
> nit: "underobj"
> 

Good catch!
