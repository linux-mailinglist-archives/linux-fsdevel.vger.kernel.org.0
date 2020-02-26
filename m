Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B69170285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgBZPcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 10:32:08 -0500
Received: from smtp-42ae.mail.infomaniak.ch ([84.16.66.174]:52867 "EHLO
        smtp-42ae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbgBZPcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:32:08 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 1B8451003B26A;
        Wed, 26 Feb 2020 16:32:03 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48SKXv31G3zlhLS9;
        Wed, 26 Feb 2020 16:31:59 +0100 (CET)
Subject: Re: [RFC PATCH v14 01/10] landlock: Add object and rule management
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
 <20200224160215.4136-2-mic@digikod.net>
 <CAG48ez1FN0B05r35c-EDuQNoW=5ZTy1iBzksbkt+toqs+_tdqg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 mQINBFNUOTgBEAC5HCwtCH/iikbZRDkXUSZa078Fz8H/21oNdzi13NM0ZdeR9KVq28ZCBAud
 law2P+HhaPFuZLqzRiy+iNOumPgrUyNphLhxWby/JgD7hvhYs5HJgdX0VTwzGqprmAeDKbnS
 G0Q2zxmnkb1/ENRTfrOIBm5LwyRhWIw5hg+HKh88g6qztDHdVSGqgWGLhj7RqDgHCgC4kAve
 /tWwfnpmMMndi5V+wg5EanyiffjAq6GHwzWbal+u3lkV8zNo15VZ+6mOY3X6dfYFVeX8hAP4
 u6OxzK4dQhDMVnJux5jum8RXtkSASiQpvx80npFbToIMgziWoWPV+Ag3Ti9JsactNzygozjL
 G0j8nc4dtfdkFoflEqtFIz2ZVWlmvcjbxTbvFpK2TwbVSiXe3Iyn4FIatk8tPsyY+mwKLzsc
 RNXaOXXB3kza0JmmnOyLCZuCTkds8FHvEG3nMIvyzXiobFM5F2b5Xo5x0fSo2ycIXXWgNJFn
 X1QXiPEM+emIRH0q2mHNAdvDki/Ns+qmkI4MQjWNGLGzlzb2GJBb5jXmkxEhk0/hUXVK3WYu
 /jGRQAbyX3XASArcw4RNFWd6fwzsX4Ras52BwI2qZaVAh4OclArEoSh5lGweizpN+1K8SnxG
 zVmvUDS8MfwlO97Kge4jzD0nRFOVE/z2DOLp6ZOcdRTxmTZNEwARAQABtCJNaWNrYcOrbCBT
 YWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+iQI9BBMBCgAnBQJTVDk4AhsDBQkLRzUABQsJCAcD
 BRUKCQgLBRYDAgEAAh4BAheAAAoJECkv1ZR9XFaW/64P/3wPay/u16aRGeRgUl7ZZ8aZ50WH
 kCZHmX/aemxBk4lKNjbghzQFcuRkLODN0HXHZqqObLo77BKrSiVwlPSTNguXs9R6IaRfITvP
 6k1ka/1I5ItczhHq0Ewf0Qs9SUphIGa71aE0zoWC4AWMz/avx/tvPdI4HoQop4K3DCJU5BXS
 NYDVOc8Ug9Zq+C1dM3PnLbL1BR1/K3D+fqAetQ9Aq/KP1NnsfSYQvkMoHIJ/6s0p3cUTkWJ3
 0TjkJliErYdn+V3Uj049XPe1KN04jldZ5MJDEQv5G3o4zEGcMpziYxw75t6SJ+/lzeJyzJjy
 uYYzg8fqxJ8x9CYVrG1s8xcXu9TqPzFcHszfl9N01gOaT5UbJrjI8d2b2SG7SR9Wzn9FWNdy
 Uc/r/enMcnRkiMgadt6qSG+Z0UMwxPt/DTOkv5ISxyY8IzDJDCZ5HrBd9hTmTSztS+UUC2r1
 5ijaOSCTWtGgJz/86ERDiUULZmhmQ1C9On46ilAgKEq4Eg3fXy6+kMaZXT3RTDrCtVrD4U58
 11KD1mR4y8WwW5LJvKikqspaqrEVC4AyAbLwEsdjVmEVkdFqm6qW4YbaK+g/Wkr0jxuJ0bVn
 PTABQxmDBVUxsE6qDy6+s8ZWoPfwI1FK2TZwoIH0OQiffSXx6mdEO5X4O4Pj7f8pz723xCxV
 1hqz/rrZ
Message-ID: <67465638-e22c-5d1a-df37-862b31d999a1@digikod.net>
Date:   Wed, 26 Feb 2020 16:31:47 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1FN0B05r35c-EDuQNoW=5ZTy1iBzksbkt+toqs+_tdqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 25/02/2020 21:49, Jann Horn wrote:
> On Mon, Feb 24, 2020 at 5:05 PM Mickaël Salaün <mic@digikod.net> wrote:
>> A Landlock object enables to identify a kernel object (e.g. an inode).
>> A Landlock rule is a set of access rights allowed on an object.  Rules
>> are grouped in rulesets that may be tied to a set of processes (i.e.
>> subjects) to enforce a scoped access-control (i.e. a domain).
>>
>> Because Landlock's goal is to empower any process (especially
>> unprivileged ones) to sandbox themselves, we can't rely on a system-wide
>> object identification such as file extended attributes.  Indeed, we need
>> innocuous, composable and modular access-controls.
>>
>> The main challenge with this constraints is to identify kernel objects
>> while this identification is useful (i.e. when a security policy makes
>> use of this object).  But this identification data should be freed once
>> no policy is using it.  This ephemeral tagging should not and may not be
>> written in the filesystem.  We then need to manage the lifetime of a
>> rule according to the lifetime of its object.  To avoid a global lock,
>> this implementation make use of RCU and counters to safely reference
>> objects.
>>
>> A following commit uses this generic object management for inodes.
> [...]
>> diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
>> new file mode 100644
>> index 000000000000..4a321d5b3f67
>> --- /dev/null
>> +++ b/security/landlock/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config SECURITY_LANDLOCK
>> +       bool "Landlock support"
>> +       depends on SECURITY
>> +       default n
> 
> (I think "default n" is implicit?)

It seems that most (all?) Kconfig are written like this.

> 
>> +       help
>> +         This selects Landlock, a safe sandboxing mechanism.  It enables to
>> +         restrict processes on the fly (i.e. enforce an access control policy),
>> +         which can complement seccomp-bpf.  The security policy is a set of access
>> +         rights tied to an object, which could be a file, a socket or a process.
>> +
>> +         See Documentation/security/landlock/ for further information.
>> +
>> +         If you are unsure how to answer this question, answer N.
> [...]
>> diff --git a/security/landlock/object.c b/security/landlock/object.c
>> new file mode 100644
>> index 000000000000..38fbbb108120
>> --- /dev/null
>> +++ b/security/landlock/object.c
>> @@ -0,0 +1,339 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Landlock LSM - Object and rule management
>> + *
>> + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
>> + * Copyright © 2018-2020 ANSSI
>> + *
>> + * Principles and constraints of the object and rule management:
>> + * - Do not leak memory.
>> + * - Try as much as possible to free a memory allocation as soon as it is
>> + *   unused.
>> + * - Do not use global lock.
>> + * - Do not charge processes other than the one requesting a Landlock
>> + *   operation.
>> + */
>> +
>> +#include <linux/bug.h>
>> +#include <linux/compiler.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/fs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/rbtree.h>
>> +#include <linux/rcupdate.h>
>> +#include <linux/refcount.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "object.h"
>> +
>> +struct landlock_object *landlock_create_object(
>> +               const enum landlock_object_type type, void *underlying_object)
>> +{
>> +       struct landlock_object *object;
>> +
>> +       if (WARN_ON_ONCE(!underlying_object))
>> +               return NULL;
>> +       object = kzalloc(sizeof(*object), GFP_KERNEL);
>> +       if (!object)
>> +               return NULL;
>> +       refcount_set(&object->usage, 1);
>> +       refcount_set(&object->cleaners, 1);
>> +       spin_lock_init(&object->lock);
>> +       INIT_LIST_HEAD(&object->rules);
>> +       object->type = type;
>> +       WRITE_ONCE(object->underlying_object, underlying_object);
> 
> `object` is not globally visible at this point, so WRITE_ONCE() is unnecessary.

Right. It was written like this to have a uniform use of this pointer,
but I'll remove it.

> 
>> +       return object;
>> +}
>> +
>> +struct landlock_object *landlock_get_object(struct landlock_object *object)
>> +       __acquires(object->usage)
>> +{
>> +       __acquire(object->usage);
>> +       /*
>> +        * If @object->usage equal 0, then it will be ignored by writers, and
>> +        * underlying_object->object may be replaced, but this is not an issue
>> +        * for release_object().
>> +        */
>> +       if (object && refcount_inc_not_zero(&object->usage)) {
>> +               /*
>> +                * It should not be possible to get a reference to an object if
>> +                * its underlying object is being terminated (e.g. with
>> +                * landlock_release_object()), because an object is only
>> +                * modifiable through such underlying object.  This is not the
>> +                * case with landlock_get_object_cleaner().
>> +                */
>> +               WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
>> +               return object;
>> +       }
>> +       return NULL;
>> +}
>> +
>> +static struct landlock_object *get_object_cleaner(
>> +               struct landlock_object *object)
>> +       __acquires(object->cleaners)
>> +{
>> +       __acquire(object->cleaners);
>> +       if (object && refcount_inc_not_zero(&object->cleaners))
>> +               return object;
>> +       return NULL;
>> +}
> 
> I don't get this whole "cleaners" thing. Can you give a quick
> description of why this is necessary, and what benefits it has over a
> standard refcounting+RCU scheme? I don't immediately see anything that
> requires this.

This indeed needs more documentation here. Here is a comment I'll add to
get_object_cleaner():

This enables to safely get a reference to an object to potentially free
it if it is not already being freed by a concurrent thread. Indeed, the
object's address may still be read and dereferenced while a concurrent
thread is attempting to clean the object. Cf. &struct
landlock_object->usage and &struct landlock_object->cleaners.

See below the explanation about "usage" and "cleaners".

> 
>> +/*
>> + * There is two cases when an object should be free and the reference to the
>> + * underlying object should be put:
>> + * - when the last rule tied to this object is removed, which is handled by
>> + *   landlock_put_rule() and then release_object();
>> + * - when the object is being terminated (e.g. no more reference to an inode),
>> + *   which is handled by landlock_put_object().
>> + */
>> +static void put_object_free(struct landlock_object *object)
>> +       __releases(object->cleaners)
>> +{
>> +       __release(object->cleaners);
>> +       if (!refcount_dec_and_test(&object->cleaners))
>> +               return;
>> +       WARN_ON_ONCE(refcount_read(&object->usage));
>> +       /*
>> +        * Ensures a safe use of @object in the RCU block from
>> +        * landlock_put_rule().
>> +        */
>> +       kfree_rcu(object, rcu_free);
>> +}
>> +
>> +/*
>> + * Destroys a newly created and useless object.
>> + */
>> +void landlock_drop_object(struct landlock_object *object)
>> +{
>> +       if (WARN_ON_ONCE(!refcount_dec_and_test(&object->usage)))
>> +               return;
>> +       __acquire(object->cleaners);
>> +       put_object_free(object);
>> +}
>> +
>> +/*
>> + * Puts the underlying object (e.g. inode) if it is the first request to
>> + * release @object, without calling landlock_put_object().
>> + *
>> + * Return true if this call effectively marks @object as released, false
>> + * otherwise.
>> + */
>> +static bool release_object(struct landlock_object *object)
>> +       __releases(&object->lock)
>> +{
>> +       void *underlying_object;
>> +
>> +       lockdep_assert_held(&object->lock);
>> +
>> +       underlying_object = xchg(&object->underlying_object, NULL);
>> +       spin_unlock(&object->lock);
>> +       might_sleep();
>> +       if (!underlying_object)
>> +               return false;
>> +
>> +       switch (object->type) {
>> +       case LANDLOCK_OBJECT_INODE:
>> +               break;
>> +       default:
>> +               WARN_ON_ONCE(1);
>> +       }
>> +       return true;
>> +}
>> +
>> +static void put_object_cleaner(struct landlock_object *object)
>> +       __releases(object->cleaners)
>> +{
>> +       /* Let's try an early lockless check. */
>> +       if (list_empty(&object->rules) &&
>> +                       READ_ONCE(object->underlying_object)) {
>> +               /*
>> +                * Puts @object if there is no rule tied to it and the
>> +                * remaining user is the underlying object.  This check is
>> +                * atomic because @object->rules and @object->underlying_object
>> +                * are protected by @object->lock.
>> +                */
>> +               spin_lock(&object->lock);
>> +               if (list_empty(&object->rules) &&
>> +                               READ_ONCE(object->underlying_object) &&
>> +                               refcount_dec_if_one(&object->usage)) {
>> +                       /*
>> +                        * Releases @object, in place of
>> +                        * landlock_release_object().
>> +                        *
>> +                        * @object is already empty, implying that all its
>> +                        * previous rules are already disabled.
>> +                        *
>> +                        * Unbalance the @object->cleaners counter to reflect
>> +                        * the underlying object release.
>> +                        */
>> +                       if (!WARN_ON_ONCE(!release_object(object))) {
>> +                               __acquire(object->cleaners);
>> +                               put_object_free(object);
>> +                       }
>> +               } else {
>> +                       spin_unlock(&object->lock);
>> +               }
>> +       }
>> +       put_object_free(object);
>> +}
>> +
>> +/*
>> + * Putting an object is easy when the object is being terminated, but it is
>> + * much more tricky when the reason is that there is no more rule tied to this
>> + * object.  Indeed, new rules could be added at the same time.
>> + */
>> +void landlock_put_object(struct landlock_object *object)
>> +       __releases(object->usage)
>> +{
>> +       struct landlock_object *object_cleaner;
>> +
>> +       __release(object->usage);
>> +       might_sleep();
>> +       if (!object)
>> +               return;
>> +       /*
>> +        * Guards against concurrent termination to be able to terminate
>> +        * @object if it is empty and not referenced by another rule-appender
>> +        * other than the underlying object.
>> +        */
>> +       object_cleaner = get_object_cleaner(object);
>> +       if (WARN_ON_ONCE(!object_cleaner)) {
>> +               __release(object->cleaners);
>> +               return;
>> +       }
>> +       /*
>> +        * Decrements @object->usage and if it reach zero, also decrement
>> +        * @object->cleaners.  If both reach zero, then release and free
>> +        * @object.
>> +        */
>> +       if (refcount_dec_and_test(&object->usage)) {
>> +               struct landlock_rule *rule_walker, *rule_walker2;
>> +
>> +               spin_lock(&object->lock);
>> +               /*
>> +                * Disables all the rules tied to @object when it is forbidden
>> +                * to add new rule but still allowed to remove them with
>> +                * landlock_put_rule().  This is crucial to be able to safely
>> +                * free a rule according to landlock_rule_is_disabled().
>> +                */
>> +               list_for_each_entry_safe(rule_walker, rule_walker2,
>> +                               &object->rules, list)
>> +                       list_del_rcu(&rule_walker->list);
>> +
>> +               /*
>> +                * Releases @object if it is not already released (e.g. with
>> +                * landlock_release_object()).
>> +                */
>> +               release_object(object);
>> +               /*
>> +                * Unbalances the @object->cleaners counter to reflect the
>> +                * underlying object release.
>> +                */
>> +               __acquire(object->cleaners);
>> +               put_object_free(object);
>> +       }
>> +       put_object_cleaner(object_cleaner);
>> +}
>> +
>> +void landlock_put_rule(struct landlock_object *object,
>> +               struct landlock_rule *rule)
>> +{
>> +       if (!rule)
>> +               return;
>> +       WARN_ON_ONCE(!object);
>> +       /*
>> +        * Guards against a concurrent @object self-destruction with
>> +        * landlock_put_object() or put_object_cleaner().
>> +        */
>> +       rcu_read_lock();
>> +       if (landlock_rule_is_disabled(rule)) {
>> +               rcu_read_unlock();
>> +               if (refcount_dec_and_test(&rule->usage))
>> +                       kfree_rcu(rule, rcu_free);
>> +               return;
>> +       }
>> +       if (refcount_dec_and_test(&rule->usage)) {
>> +               struct landlock_object *safe_object;
>> +
>> +               /*
>> +                * Now, @rule may still be enabled, or in the process of being
>> +                * untied to @object by put_object_cleaner().  However, we know
>> +                * that @object will not be freed until rcu_read_unlock() and
>> +                * until @object->cleaners reach zero.  Furthermore, we may not
>> +                * be the only one willing to free a @rule linked with @object.
>> +                * If we succeed to hold @object with get_object_cleaner(), we
>> +                * know that until put_object_cleaner(), we can safely use
>> +                * @object to remove @rule.
>> +                */
>> +               safe_object = get_object_cleaner(object);
>> +               rcu_read_unlock();
>> +               if (!safe_object) {
>> +                       __release(safe_object->cleaners);
>> +                       /*
>> +                        * We can safely free @rule because it is already
>> +                        * removed from @object's list.
>> +                        */
>> +                       WARN_ON_ONCE(!landlock_rule_is_disabled(rule));
>> +                       kfree_rcu(rule, rcu_free);
>> +               } else {
>> +                       spin_lock(&safe_object->lock);
>> +                       if (!landlock_rule_is_disabled(rule))
>> +                               list_del(&rule->list);
>> +                       spin_unlock(&safe_object->lock);
>> +                       kfree_rcu(rule, rcu_free);
>> +                       put_object_cleaner(safe_object);
>> +               }
>> +       } else {
>> +               rcu_read_unlock();
>> +       }
>> +       /*
>> +        * put_object_cleaner() might sleep, but it is only reachable if
>> +        * !landlock_rule_is_disabled().  Therefore, clean_ref() can not sleep.
>> +        */
>> +       might_sleep();
>> +}
>> +
>> +void landlock_release_object(struct landlock_object __rcu *rcu_object)
>> +{
>> +       struct landlock_object *object;
>> +
>> +       if (!rcu_object)
>> +               return;
>> +       rcu_read_lock();
>> +       object = get_object_cleaner(rcu_dereference(rcu_object));
> 
> This is not how RCU works. You need the rcu annotation on the access
> to the data structure member (or global variable) that's actually
> being accessed. A "struct foo __rcu *foo" argument is essentially
> always wrong.

Absolutely! I fixed this with the following patch:

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7f3bd4fd04bb..01a48c75f210 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -98,7 +98,9 @@ void landlock_release_inodes(struct super_block *sb)
 		if (iput_inode)
 			iput(iput_inode);

-		landlock_release_object(inode_landlock(inode)->object);
+		rcu_read_lock();
+		landlock_release_object(rcu_dereference(
+					inode_landlock(inode)->object));

 		iput_inode = inode;
 		spin_lock(&sb->s_inode_list_lock);
diff --git a/security/landlock/object.c b/security/landlock/object.c
index 2d373f224989..a0e65a78068d 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -300,14 +300,16 @@ void landlock_put_rule(struct landlock_object *object,
 	might_sleep();
 }

-void landlock_release_object(struct landlock_object __rcu *rcu_object)
+void landlock_release_object(struct landlock_object *rcu_object)
+	__releases(RCU)
 {
 	struct landlock_object *object;

-	if (!rcu_object)
+	if (!rcu_object) {
+		rcu_read_unlock();
 		return;
-	rcu_read_lock();
-	object = get_object_cleaner(rcu_dereference(rcu_object));
+	}
+	object = get_object_cleaner(rcu_object);
 	rcu_read_unlock();
 	if (unlikely(!object)) {
 		__release(object->cleaners);
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 15dfc9a75a82..78bfb25d4bcc 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -12,9 +12,9 @@
 #include <linux/compiler_types.h>
 #include <linux/list.h>
 #include <linux/poison.h>
-#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>

 struct landlock_access {
 	/*
@@ -105,7 +105,8 @@ struct landlock_object {
 void landlock_put_rule(struct landlock_object *object,
 		struct landlock_rule *rule);

-void landlock_release_object(struct landlock_object __rcu *rcu_object);
+void landlock_release_object(struct landlock_object *object)
+	__releases(RCU);

 struct landlock_object *landlock_create_object(
 		const enum landlock_object_type type, void *underlying_object);


> 
>> +struct landlock_rule {
>> +       struct landlock_access access;
>> +       /*
>> +        * @list: Linked list with other rules tied to the same object, which
>> +        * enable to manage their lifetimes.  This is also used to identify if
>> +        * a rule is still valid, thanks to landlock_rule_is_disabled(), which
>> +        * is important in the matching process because the original object
>> +        * address might have been recycled.
>> +        */
>> +       struct list_head list;
>> +       union {
>> +               /*
>> +                * @usage: Number of rulesets pointing to this rule.  This
>> +                * field is never used by RCU readers.
>> +                */
>> +               refcount_t usage;
>> +               struct rcu_head rcu_free;
>> +       };
>> +};
> 
> An object that is subject to RCU but whose refcount must not be
> accessed from RCU context? That seems a weird.

The fields "access" and "list" are read (in a RCU-read block) by
ruleset.c:landlock_find_access() (cf. patch 2). The use of the "usage"
counter is in landlock_insert_ruleset_rule() and landlock_put_rule(),
but in these cases the rule is always owned/held by the caller. I should
say something like "This field must only be used when already holding
the rule."

> 
>> +enum landlock_object_type {
>> +       LANDLOCK_OBJECT_INODE = 1,
>> +};
>> +
>> +struct landlock_object {
>> +       /*
>> +        * @usage: Main usage counter, used to tie an object to it's underlying
>> +        * object (i.e. create a lifetime) and potentially add new rules.
> 
> I can't really follow this by reading this patch on its own. As one
> suggestion to make things at least a bit better, how about documenting
> here that `usage` always reaches zero before `cleaners` does?

What about this?

This counter is used to tie an object to its underlying object (e.g. an
inode) and to modify it (e.g. add or remove a rule). If this counter
reaches zero, the object must not be modified, but it may still be used
from within an RCU-read block. When adding a new rule to an object with
a usage counter of zero, the underlying object must be locked and its
object pointer can then be replaced with a new empty object (while
ignoring the disabled object which is being handled by another thread).
This counter always reaches zero before @cleaners does.


> 
>> +        */
>> +       refcount_t usage;
>> +       /*
>> +        * @cleaners: Usage counter used to free a rule from @rules (thanks to
>> +        * put_rule()).  Enables to get a reference to this object until it
>> +        * really become freed.  Cf. put_object().
> 
> Maybe add: @usage being non-zero counts as one reference to @cleaners.
> Once @cleaners has become zero, the object is freed after an RCU grace
> period.

What about this?

This counter can only reach zero if the @usage counter already reached
zero. Indeed, @usage being non-zero counts as one reference to
@cleaners. Once @cleaners has become zero, the object is freed after an
RCU grace period. This enables concurrent threads to safely get an
object reference to terminate it if there is no more concurrent cleaners
for this object. This mechanism is required to enable concurrent threads
to safely dereference an object from potentially different pointers
(e.g. the underlying object, or a rule tied to this object), to
potentially terminate and free it (i.e. if there is no more rules tied
to it, or if the underlying object is being terminated).

> 
>> +        */
>> +       refcount_t cleaners;
>> +       union {
>> +               /*
>> +                * The use of this struct is controlled by @usage and
>> +                * @cleaners, which makes it safe to union it with @rcu_free.
>> +                */
> [...]
>> +               struct rcu_head rcu_free;
>> +       };
>> +};
> [...]
>> +static inline bool landlock_rule_is_disabled(
>> +               struct landlock_rule *rule)
>> +{
>> +       /*
>> +        * Disabling (i.e. unlinking) a landlock_rule is a one-way operation.
>> +        * It is not possible to re-enable such a rule, then there is no need
>> +        * for smp_load_acquire().
>> +        *
>> +        * LIST_POISON2 is set by list_del() and list_del_rcu().
>> +        */
>> +       return !rule || READ_ONCE(rule->list.prev) == LIST_POISON2;
> 
> You're not allowed to do this, the comment above list_del() states:
> 
>  * Note: list_empty() on entry does not return true after this, the entry is
>  * in an undefined state.

list_del() checks READ_ONCE(head->next) == head, but
landlock_rule_is_disabled() checks READ_ONCE(rule->list.prev) ==
LIST_POISON2.
The comment about LIST_POISON2 is right but may be misleading. There is
no use of list_empty() with a landlock_rule->list, only
landlock_object->rules. The only list_del() is in landlock_put_rule()
when there is a guarantee that there is no other reference to it, hence
no possible use of landlock_rule_is_disabled() with this rule. I could
replace it with a call to list_del_rcu() to make it more consistent.

> 
> If you want to be able to test whether the element is on a list
> afterwards, use stuff like list_del_init().

There is no need to re-initialize the list but using list_del_init() and
list_empty() could work too. However, there is no list_del_init_rcu()
helper. Moreover, resetting the list's pointer with LIST_POISON2 might
help to detect bugs.


Thanks for this review!
