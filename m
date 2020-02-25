Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F116F08C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgBYUuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 15:50:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36058 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:50:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so854661otq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cN7Q4dVydT4xYlRzhXk1sRwtrE826VFs1l2/vxQJcvQ=;
        b=ltEi9IHcymn8kA5Bo4Q/bznz0r5VMTRacX6R3LcY9xUZ3gClNFcfJIRVk3gRVpQkQX
         +VE9xCNeUAfxtq5wIkeG95u3mhdPhLQCtHsvHgfRsLVZXjMSAKQOj1cVLFCftpXMsOGS
         z+FMROp6M+Q7DxtzA7btZo0irkZY/QhK2N2jz/FDvywurbv2KAbuQZVZPahVmp25r5MG
         qt/hViiWH/XAcpfyYzzQoL8JGKogorzR5nrIMCBxQiutr3g+WPUEHxHcmxRYa1moIpij
         xyODtMiCAw0boQmMPJ4WOt9xZdnkN/vdbtHWxzmnnVjX/WCpVqWTlkzJUp6moh0ltyZo
         /PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cN7Q4dVydT4xYlRzhXk1sRwtrE826VFs1l2/vxQJcvQ=;
        b=GDcPw06eC8cwMypG47fM8DqEEosZ15FY+mu62xuWiqhgVw/tDOpXV0zIlTdb96g8IG
         gWi1gVllJjxZvkEA1PNtQaTgaAUZxnZeiVDbHc6tIo61gacrTcXo6R+VKr/Ew5mOysSF
         xWu8I2aqnXCxx14kwQ0BGOX7NanUHcDY4reGLp57ODz2axR8Y482d87sN1GV+IMOB/KG
         15DqFf8EWPprvv2td5LramJqJ13/ah9mPSRUGjhppEm/ibjMl5ZE/8wCcHq8ITxhzyZL
         COklEnlyFatLxv7wCeTL1CsPj3fS6FttCk/d6Z7ehkJSTyz/rJFzQ3aFFQxxPFh5d1IX
         nTJQ==
X-Gm-Message-State: APjAAAU98DeXeNrA4wcNYwzQXtprN5YMYZll0g7CCD6ESTS+5TFwMDHj
        RTDDx6nSDx2OImRSsy4ALK5/O+nyRkYC4nBi8ZfT/Q==
X-Google-Smtp-Source: APXvYqy0mDp21Y+Hj6qrkPvHOelZCXjMBtpFN8Bj28fsPkz/lgS1es5GWIVnhOXNkqbFeOM6C9PbvDEEeYWXWEOuc/Y=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr381742otl.110.1582663823821;
 Tue, 25 Feb 2020 12:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <20200224160215.4136-2-mic@digikod.net>
In-Reply-To: <20200224160215.4136-2-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 Feb 2020 21:49:57 +0100
Message-ID: <CAG48ez1FN0B05r35c-EDuQNoW=5ZTy1iBzksbkt+toqs+_tdqg@mail.gmail.com>
Subject: Re: [RFC PATCH v14 01/10] landlock: Add object and rule management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
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
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
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
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:05 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock object enables to identify a kernel object (e.g. an inode).
> A Landlock rule is a set of access rights allowed on an object.  Rules
> are grouped in rulesets that may be tied to a set of processes (i.e.
> subjects) to enforce a scoped access-control (i.e. a domain).
>
> Because Landlock's goal is to empower any process (especially
> unprivileged ones) to sandbox themselves, we can't rely on a system-wide
> object identification such as file extended attributes.  Indeed, we need
> innocuous, composable and modular access-controls.
>
> The main challenge with this constraints is to identify kernel objects
> while this identification is useful (i.e. when a security policy makes
> use of this object).  But this identification data should be freed once
> no policy is using it.  This ephemeral tagging should not and may not be
> written in the filesystem.  We then need to manage the lifetime of a
> rule according to the lifetime of its object.  To avoid a global lock,
> this implementation make use of RCU and counters to safely reference
> objects.
>
> A following commit uses this generic object management for inodes.
[...]
> diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
> new file mode 100644
> index 000000000000..4a321d5b3f67
> --- /dev/null
> +++ b/security/landlock/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SECURITY_LANDLOCK
> +       bool "Landlock support"
> +       depends on SECURITY
> +       default n

(I think "default n" is implicit?)

> +       help
> +         This selects Landlock, a safe sandboxing mechanism.  It enables=
 to
> +         restrict processes on the fly (i.e. enforce an access control p=
olicy),
> +         which can complement seccomp-bpf.  The security policy is a set=
 of access
> +         rights tied to an object, which could be a file, a socket or a =
process.
> +
> +         See Documentation/security/landlock/ for further information.
> +
> +         If you are unsure how to answer this question, answer N.
[...]
> diff --git a/security/landlock/object.c b/security/landlock/object.c
> new file mode 100644
> index 000000000000..38fbbb108120
> --- /dev/null
> +++ b/security/landlock/object.c
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Object and rule management
> + *
> + * Copyright =C2=A9 2016-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> + * Copyright =C2=A9 2018-2020 ANSSI
> + *
> + * Principles and constraints of the object and rule management:
> + * - Do not leak memory.
> + * - Try as much as possible to free a memory allocation as soon as it i=
s
> + *   unused.
> + * - Do not use global lock.
> + * - Do not charge processes other than the one requesting a Landlock
> + *   operation.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/compiler.h>
> +#include <linux/compiler_types.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/rbtree.h>
> +#include <linux/rcupdate.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#include "object.h"
> +
> +struct landlock_object *landlock_create_object(
> +               const enum landlock_object_type type, void *underlying_ob=
ject)
> +{
> +       struct landlock_object *object;
> +
> +       if (WARN_ON_ONCE(!underlying_object))
> +               return NULL;
> +       object =3D kzalloc(sizeof(*object), GFP_KERNEL);
> +       if (!object)
> +               return NULL;
> +       refcount_set(&object->usage, 1);
> +       refcount_set(&object->cleaners, 1);
> +       spin_lock_init(&object->lock);
> +       INIT_LIST_HEAD(&object->rules);
> +       object->type =3D type;
> +       WRITE_ONCE(object->underlying_object, underlying_object);

`object` is not globally visible at this point, so WRITE_ONCE() is unnecess=
ary.

> +       return object;
> +}
> +
> +struct landlock_object *landlock_get_object(struct landlock_object *obje=
ct)
> +       __acquires(object->usage)
> +{
> +       __acquire(object->usage);
> +       /*
> +        * If @object->usage equal 0, then it will be ignored by writers,=
 and
> +        * underlying_object->object may be replaced, but this is not an =
issue
> +        * for release_object().
> +        */
> +       if (object && refcount_inc_not_zero(&object->usage)) {
> +               /*
> +                * It should not be possible to get a reference to an obj=
ect if
> +                * its underlying object is being terminated (e.g. with
> +                * landlock_release_object()), because an object is only
> +                * modifiable through such underlying object.  This is no=
t the
> +                * case with landlock_get_object_cleaner().
> +                */
> +               WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
> +               return object;
> +       }
> +       return NULL;
> +}
> +
> +static struct landlock_object *get_object_cleaner(
> +               struct landlock_object *object)
> +       __acquires(object->cleaners)
> +{
> +       __acquire(object->cleaners);
> +       if (object && refcount_inc_not_zero(&object->cleaners))
> +               return object;
> +       return NULL;
> +}

I don't get this whole "cleaners" thing. Can you give a quick
description of why this is necessary, and what benefits it has over a
standard refcounting+RCU scheme? I don't immediately see anything that
requires this.

> +/*
> + * There is two cases when an object should be free and the reference to=
 the
> + * underlying object should be put:
> + * - when the last rule tied to this object is removed, which is handled=
 by
> + *   landlock_put_rule() and then release_object();
> + * - when the object is being terminated (e.g. no more reference to an i=
node),
> + *   which is handled by landlock_put_object().
> + */
> +static void put_object_free(struct landlock_object *object)
> +       __releases(object->cleaners)
> +{
> +       __release(object->cleaners);
> +       if (!refcount_dec_and_test(&object->cleaners))
> +               return;
> +       WARN_ON_ONCE(refcount_read(&object->usage));
> +       /*
> +        * Ensures a safe use of @object in the RCU block from
> +        * landlock_put_rule().
> +        */
> +       kfree_rcu(object, rcu_free);
> +}
> +
> +/*
> + * Destroys a newly created and useless object.
> + */
> +void landlock_drop_object(struct landlock_object *object)
> +{
> +       if (WARN_ON_ONCE(!refcount_dec_and_test(&object->usage)))
> +               return;
> +       __acquire(object->cleaners);
> +       put_object_free(object);
> +}
> +
> +/*
> + * Puts the underlying object (e.g. inode) if it is the first request to
> + * release @object, without calling landlock_put_object().
> + *
> + * Return true if this call effectively marks @object as released, false
> + * otherwise.
> + */
> +static bool release_object(struct landlock_object *object)
> +       __releases(&object->lock)
> +{
> +       void *underlying_object;
> +
> +       lockdep_assert_held(&object->lock);
> +
> +       underlying_object =3D xchg(&object->underlying_object, NULL);
> +       spin_unlock(&object->lock);
> +       might_sleep();
> +       if (!underlying_object)
> +               return false;
> +
> +       switch (object->type) {
> +       case LANDLOCK_OBJECT_INODE:
> +               break;
> +       default:
> +               WARN_ON_ONCE(1);
> +       }
> +       return true;
> +}
> +
> +static void put_object_cleaner(struct landlock_object *object)
> +       __releases(object->cleaners)
> +{
> +       /* Let's try an early lockless check. */
> +       if (list_empty(&object->rules) &&
> +                       READ_ONCE(object->underlying_object)) {
> +               /*
> +                * Puts @object if there is no rule tied to it and the
> +                * remaining user is the underlying object.  This check i=
s
> +                * atomic because @object->rules and @object->underlying_=
object
> +                * are protected by @object->lock.
> +                */
> +               spin_lock(&object->lock);
> +               if (list_empty(&object->rules) &&
> +                               READ_ONCE(object->underlying_object) &&
> +                               refcount_dec_if_one(&object->usage)) {
> +                       /*
> +                        * Releases @object, in place of
> +                        * landlock_release_object().
> +                        *
> +                        * @object is already empty, implying that all it=
s
> +                        * previous rules are already disabled.
> +                        *
> +                        * Unbalance the @object->cleaners counter to ref=
lect
> +                        * the underlying object release.
> +                        */
> +                       if (!WARN_ON_ONCE(!release_object(object))) {
> +                               __acquire(object->cleaners);
> +                               put_object_free(object);
> +                       }
> +               } else {
> +                       spin_unlock(&object->lock);
> +               }
> +       }
> +       put_object_free(object);
> +}
> +
> +/*
> + * Putting an object is easy when the object is being terminated, but it=
 is
> + * much more tricky when the reason is that there is no more rule tied t=
o this
> + * object.  Indeed, new rules could be added at the same time.
> + */
> +void landlock_put_object(struct landlock_object *object)
> +       __releases(object->usage)
> +{
> +       struct landlock_object *object_cleaner;
> +
> +       __release(object->usage);
> +       might_sleep();
> +       if (!object)
> +               return;
> +       /*
> +        * Guards against concurrent termination to be able to terminate
> +        * @object if it is empty and not referenced by another rule-appe=
nder
> +        * other than the underlying object.
> +        */
> +       object_cleaner =3D get_object_cleaner(object);
> +       if (WARN_ON_ONCE(!object_cleaner)) {
> +               __release(object->cleaners);
> +               return;
> +       }
> +       /*
> +        * Decrements @object->usage and if it reach zero, also decrement
> +        * @object->cleaners.  If both reach zero, then release and free
> +        * @object.
> +        */
> +       if (refcount_dec_and_test(&object->usage)) {
> +               struct landlock_rule *rule_walker, *rule_walker2;
> +
> +               spin_lock(&object->lock);
> +               /*
> +                * Disables all the rules tied to @object when it is forb=
idden
> +                * to add new rule but still allowed to remove them with
> +                * landlock_put_rule().  This is crucial to be able to sa=
fely
> +                * free a rule according to landlock_rule_is_disabled().
> +                */
> +               list_for_each_entry_safe(rule_walker, rule_walker2,
> +                               &object->rules, list)
> +                       list_del_rcu(&rule_walker->list);
> +
> +               /*
> +                * Releases @object if it is not already released (e.g. w=
ith
> +                * landlock_release_object()).
> +                */
> +               release_object(object);
> +               /*
> +                * Unbalances the @object->cleaners counter to reflect th=
e
> +                * underlying object release.
> +                */
> +               __acquire(object->cleaners);
> +               put_object_free(object);
> +       }
> +       put_object_cleaner(object_cleaner);
> +}
> +
> +void landlock_put_rule(struct landlock_object *object,
> +               struct landlock_rule *rule)
> +{
> +       if (!rule)
> +               return;
> +       WARN_ON_ONCE(!object);
> +       /*
> +        * Guards against a concurrent @object self-destruction with
> +        * landlock_put_object() or put_object_cleaner().
> +        */
> +       rcu_read_lock();
> +       if (landlock_rule_is_disabled(rule)) {
> +               rcu_read_unlock();
> +               if (refcount_dec_and_test(&rule->usage))
> +                       kfree_rcu(rule, rcu_free);
> +               return;
> +       }
> +       if (refcount_dec_and_test(&rule->usage)) {
> +               struct landlock_object *safe_object;
> +
> +               /*
> +                * Now, @rule may still be enabled, or in the process of =
being
> +                * untied to @object by put_object_cleaner().  However, w=
e know
> +                * that @object will not be freed until rcu_read_unlock()=
 and
> +                * until @object->cleaners reach zero.  Furthermore, we m=
ay not
> +                * be the only one willing to free a @rule linked with @o=
bject.
> +                * If we succeed to hold @object with get_object_cleaner(=
), we
> +                * know that until put_object_cleaner(), we can safely us=
e
> +                * @object to remove @rule.
> +                */
> +               safe_object =3D get_object_cleaner(object);
> +               rcu_read_unlock();
> +               if (!safe_object) {
> +                       __release(safe_object->cleaners);
> +                       /*
> +                        * We can safely free @rule because it is already
> +                        * removed from @object's list.
> +                        */
> +                       WARN_ON_ONCE(!landlock_rule_is_disabled(rule));
> +                       kfree_rcu(rule, rcu_free);
> +               } else {
> +                       spin_lock(&safe_object->lock);
> +                       if (!landlock_rule_is_disabled(rule))
> +                               list_del(&rule->list);
> +                       spin_unlock(&safe_object->lock);
> +                       kfree_rcu(rule, rcu_free);
> +                       put_object_cleaner(safe_object);
> +               }
> +       } else {
> +               rcu_read_unlock();
> +       }
> +       /*
> +        * put_object_cleaner() might sleep, but it is only reachable if
> +        * !landlock_rule_is_disabled().  Therefore, clean_ref() can not =
sleep.
> +        */
> +       might_sleep();
> +}
> +
> +void landlock_release_object(struct landlock_object __rcu *rcu_object)
> +{
> +       struct landlock_object *object;
> +
> +       if (!rcu_object)
> +               return;
> +       rcu_read_lock();
> +       object =3D get_object_cleaner(rcu_dereference(rcu_object));

This is not how RCU works. You need the rcu annotation on the access
to the data structure member (or global variable) that's actually
being accessed. A "struct foo __rcu *foo" argument is essentially
always wrong.

> +struct landlock_rule {
> +       struct landlock_access access;
> +       /*
> +        * @list: Linked list with other rules tied to the same object, w=
hich
> +        * enable to manage their lifetimes.  This is also used to identi=
fy if
> +        * a rule is still valid, thanks to landlock_rule_is_disabled(), =
which
> +        * is important in the matching process because the original obje=
ct
> +        * address might have been recycled.
> +        */
> +       struct list_head list;
> +       union {
> +               /*
> +                * @usage: Number of rulesets pointing to this rule.  Thi=
s
> +                * field is never used by RCU readers.
> +                */
> +               refcount_t usage;
> +               struct rcu_head rcu_free;
> +       };
> +};

An object that is subject to RCU but whose refcount must not be
accessed from RCU context? That seems a weird.

> +enum landlock_object_type {
> +       LANDLOCK_OBJECT_INODE =3D 1,
> +};
> +
> +struct landlock_object {
> +       /*
> +        * @usage: Main usage counter, used to tie an object to it's unde=
rlying
> +        * object (i.e. create a lifetime) and potentially add new rules.

I can't really follow this by reading this patch on its own. As one
suggestion to make things at least a bit better, how about documenting
here that `usage` always reaches zero before `cleaners` does?

> +        */
> +       refcount_t usage;
> +       /*
> +        * @cleaners: Usage counter used to free a rule from @rules (than=
ks to
> +        * put_rule()).  Enables to get a reference to this object until =
it
> +        * really become freed.  Cf. put_object().

Maybe add: @usage being non-zero counts as one reference to @cleaners.
Once @cleaners has become zero, the object is freed after an RCU grace
period.

> +        */
> +       refcount_t cleaners;
> +       union {
> +               /*
> +                * The use of this struct is controlled by @usage and
> +                * @cleaners, which makes it safe to union it with @rcu_f=
ree.
> +                */
[...]
> +               struct rcu_head rcu_free;
> +       };
> +};
[...]
> +static inline bool landlock_rule_is_disabled(
> +               struct landlock_rule *rule)
> +{
> +       /*
> +        * Disabling (i.e. unlinking) a landlock_rule is a one-way operat=
ion.
> +        * It is not possible to re-enable such a rule, then there is no =
need
> +        * for smp_load_acquire().
> +        *
> +        * LIST_POISON2 is set by list_del() and list_del_rcu().
> +        */
> +       return !rule || READ_ONCE(rule->list.prev) =3D=3D LIST_POISON2;

You're not allowed to do this, the comment above list_del() states:

 * Note: list_empty() on entry does not return true after this, the entry i=
s
 * in an undefined state.

If you want to be able to test whether the element is on a list
afterwards, use stuff like list_del_init().

> +}
