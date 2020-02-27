Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73E4172416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 17:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgB0QzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 11:55:18 -0500
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175]:39273 "EHLO
        smtp-8faf.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbgB0QzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:55:18 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id DB261100339BD;
        Thu, 27 Feb 2020 17:46:04 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48Sz7r35gTzljSbn;
        Thu, 27 Feb 2020 17:46:00 +0100 (CET)
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
 <67465638-e22c-5d1a-df37-862b31d999a1@digikod.net>
 <CAG48ez33WjzAee9h_Nfxi6vbnjognsKziv=whi_7ocT36DCXcg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <dc77ece4-796f-8cad-fc68-e42871d636d5@digikod.net>
Date:   Thu, 27 Feb 2020 17:46:00 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez33WjzAee9h_Nfxi6vbnjognsKziv=whi_7ocT36DCXcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 26/02/2020 21:24, Jann Horn wrote:
> On Wed, Feb 26, 2020 at 4:32 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 25/02/2020 21:49, Jann Horn wrote:
>>> On Mon, Feb 24, 2020 at 5:05 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> A Landlock object enables to identify a kernel object (e.g. an inode).
>>>> A Landlock rule is a set of access rights allowed on an object.  Rules
>>>> are grouped in rulesets that may be tied to a set of processes (i.e.
>>>> subjects) to enforce a scoped access-control (i.e. a domain).
>>>>
>>>> Because Landlock's goal is to empower any process (especially
>>>> unprivileged ones) to sandbox themselves, we can't rely on a system-wide
>>>> object identification such as file extended attributes.  Indeed, we need
>>>> innocuous, composable and modular access-controls.
>>>>
>>>> The main challenge with this constraints is to identify kernel objects
>>>> while this identification is useful (i.e. when a security policy makes
>>>> use of this object).  But this identification data should be freed once
>>>> no policy is using it.  This ephemeral tagging should not and may not be
>>>> written in the filesystem.  We then need to manage the lifetime of a
>>>> rule according to the lifetime of its object.  To avoid a global lock,
>>>> this implementation make use of RCU and counters to safely reference
>>>> objects.
>>>>
>>>> A following commit uses this generic object management for inodes.
> [...]
>>>> +config SECURITY_LANDLOCK
>>>> +       bool "Landlock support"
>>>> +       depends on SECURITY
>>>> +       default n
>>>
>>> (I think "default n" is implicit?)
>>
>> It seems that most (all?) Kconfig are written like this.
> 
> See e.g. <https://lore.kernel.org/lkml/c187bb77-e804-93bd-64db-9418be58f191@infradead.org/>.

Ok, done.

> 
> [...]
>>>> +       return object;
>>>> +}
>>>> +
>>>> +struct landlock_object *landlock_get_object(struct landlock_object *object)
>>>> +       __acquires(object->usage)
>>>> +{
>>>> +       __acquire(object->usage);
>>>> +       /*
>>>> +        * If @object->usage equal 0, then it will be ignored by writers, and
>>>> +        * underlying_object->object may be replaced, but this is not an issue
>>>> +        * for release_object().
>>>> +        */
>>>> +       if (object && refcount_inc_not_zero(&object->usage)) {
>>>> +               /*
>>>> +                * It should not be possible to get a reference to an object if
>>>> +                * its underlying object is being terminated (e.g. with
>>>> +                * landlock_release_object()), because an object is only
>>>> +                * modifiable through such underlying object.  This is not the
>>>> +                * case with landlock_get_object_cleaner().
>>>> +                */
>>>> +               WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
>>>> +               return object;
>>>> +       }
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +static struct landlock_object *get_object_cleaner(
>>>> +               struct landlock_object *object)
>>>> +       __acquires(object->cleaners)
>>>> +{
>>>> +       __acquire(object->cleaners);
>>>> +       if (object && refcount_inc_not_zero(&object->cleaners))
>>>> +               return object;
>>>> +       return NULL;
>>>> +}
>>>
>>> I don't get this whole "cleaners" thing. Can you give a quick
>>> description of why this is necessary, and what benefits it has over a
>>> standard refcounting+RCU scheme? I don't immediately see anything that
>>> requires this.
>>
>> This indeed needs more documentation here. Here is a comment I'll add to
>> get_object_cleaner():
>>
>> This enables to safely get a reference to an object to potentially free
>> it if it is not already being freed by a concurrent thread.
> 
> "get a reference to an object to potentially free it" just sounds all
> wrong to me. You free an object when you're *dropping* a reference to
> it. Your refcounting scheme doesn't fit my mental models of how normal
> refcounting works at all...

Unfortunately, as I explain below, it is a bit tricky.

> 
> [...]
>>>> +/*
>>>> + * Putting an object is easy when the object is being terminated, but it is
>>>> + * much more tricky when the reason is that there is no more rule tied to this
>>>> + * object.  Indeed, new rules could be added at the same time.
>>>> + */
>>>> +void landlock_put_object(struct landlock_object *object)
>>>> +       __releases(object->usage)
>>>> +{
>>>> +       struct landlock_object *object_cleaner;
>>>> +
>>>> +       __release(object->usage);
>>>> +       might_sleep();
>>>> +       if (!object)
>>>> +               return;
>>>> +       /*
>>>> +        * Guards against concurrent termination to be able to terminate
>>>> +        * @object if it is empty and not referenced by another rule-appender
>>>> +        * other than the underlying object.
>>>> +        */
>>>> +       object_cleaner = get_object_cleaner(object);
> [...]
>>>> +       /*
>>>> +        * Decrements @object->usage and if it reach zero, also decrement
>>>> +        * @object->cleaners.  If both reach zero, then release and free
>>>> +        * @object.
>>>> +        */
>>>> +       if (refcount_dec_and_test(&object->usage)) {
>>>> +               struct landlock_rule *rule_walker, *rule_walker2;
>>>> +
>>>> +               spin_lock(&object->lock);
>>>> +               /*
>>>> +                * Disables all the rules tied to @object when it is forbidden
>>>> +                * to add new rule but still allowed to remove them with
>>>> +                * landlock_put_rule().  This is crucial to be able to safely
>>>> +                * free a rule according to landlock_rule_is_disabled().
>>>> +                */
>>>> +               list_for_each_entry_safe(rule_walker, rule_walker2,
>>>> +                               &object->rules, list)
>>>> +                       list_del_rcu(&rule_walker->list);
> 
> So... rules don't take references on the landlock_objects they use?
> Instead, the landlock_object knows which rules use it, and when the
> landlock_object goes away, it nukes all the rules associated with
> itself?

Right.

> 
> That seems terrible to me - AFAICS it means that if some random
> process decides to install a landlock rule that uses inode X, and then
> that process dies together with all its landlock rules, the inode
> still stays pinned in kernel memory as long as the superblock is
> mounted. In other words, it's a resource leak.

That is not correct. When there is no more process enforced by a
domain/ruleset, this domain is terminated, which means that every rules
linked to this domain are put away. When the usage counter of a rule
reaches zero, then the rule is terminated with landlock_put_rule() which
unlink the rule from its object and clean this object. The cleaning
involves to free the object if there is no rule tied to this object,
thanks to put_object_cleaner().

When the underlying object is terminated, landlock_release_object() also
decrement the usage counter. However, if there is a concurrent thread
adding a new rule, the usage counter still stay greater than zero while
the new rule is being added, but the counter then drops to zero at the
end of this addition, which can then unbalance the "cleaners" counter,
which will finally leads to the object freeing. This design enables to
add rules without locking (if the object already exists). While this
property is interesting for a performance point of view, the main reason
is to avoid unnecessary lock between processes (especially from
different domains).

> (And if I'm not missing
> something in patch 5, that applies even if the inode has been
> unlinked?)

That is true for now, but only because I didn't find yet the right spot
to call landlock_release_inode(). Indeed, unlinking a file may not
terminate an inode because it can still be open by a process, and
freeing an object when the underlying object is unlinked could be a way
to bypass a check on that object/inode.

Do you know where is the best spot to identify the last userspace
reference (through the filesystem or a file descriptor) to an inode?
Fnotify doesn't seem to check for that.


> 
> Can you please refactor your refcounting as follows?
> 
>  - A rule takes a reference on each landlock_object it uses.
>  - A landlock_object takes a reference on the underlying object (just like now).
>  - The underlying object *DOES NOT* take a reference on the
> landlock_object (unlike now); the reference from the underlying object
> to the landlock_object has weak pointer semantics.

We need to increment the reference counter of the underlying objects
(i.e. inodes) not to lose the link with their Landlock object and then
the related access-control. For instance, if a struct inode (e.g. a
directory) is first tied to a Landlock object/access-control, then
because the inode is not open nor used by any process and the kernel
decides to free it, when a process tries to access a file beneath this
directory, there will not have any Landlock object tied to it and the
requested access might then be forbidden (whereas the initial policy
allowed it).

>  - When a landlock_object's refcount drops to zero (iow no rules use
> it anymore), it is freed.

Before the current design, I used a similar pattern, but this is not
necessary because of the management of the underlying object lifetime.
The list_empty() check is enough, and because we need to handle
concurrent termination, the object's usage counter for the rules seems
unnecessary.

> 
> That might also help get rid of the awkward ->cleaners thing?
> 
>>>> +               /*
>>>> +                * Releases @object if it is not already released (e.g. with
>>>> +                * landlock_release_object()).
>>>> +                */
>>>> +               release_object(object);
>>>> +               /*
>>>> +                * Unbalances the @object->cleaners counter to reflect the
>>>> +                * underlying object release.
>>>> +                */
>>>> +               __acquire(object->cleaners);
>>>> +               put_object_free(object);
>>>> +       }
>>>> +       put_object_cleaner(object_cleaner);
>>>> +}
> [...]
>>>> +static inline bool landlock_rule_is_disabled(
>>>> +               struct landlock_rule *rule)
>>>> +{
>>>> +       /*
>>>> +        * Disabling (i.e. unlinking) a landlock_rule is a one-way operation.
>>>> +        * It is not possible to re-enable such a rule, then there is no need
>>>> +        * for smp_load_acquire().
>>>> +        *
>>>> +        * LIST_POISON2 is set by list_del() and list_del_rcu().
>>>> +        */
>>>> +       return !rule || READ_ONCE(rule->list.prev) == LIST_POISON2;
>>>
>>> You're not allowed to do this, the comment above list_del() states:
>>>
>>>  * Note: list_empty() on entry does not return true after this, the entry is
>>>  * in an undefined state.
>>
>> list_del() checks READ_ONCE(head->next) == head, but
>> landlock_rule_is_disabled() checks READ_ONCE(rule->list.prev) ==
>> LIST_POISON2.
>> The comment about LIST_POISON2 is right but may be misleading. There is
>> no use of list_empty() with a landlock_rule->list, only
>> landlock_object->rules. The only list_del() is in landlock_put_rule()
>> when there is a guarantee that there is no other reference to it, hence
>> no possible use of landlock_rule_is_disabled() with this rule. I could
>> replace it with a call to list_del_rcu() to make it more consistent.
>>
>>>
>>> If you want to be able to test whether the element is on a list
>>> afterwards, use stuff like list_del_init().
>>
>> There is no need to re-initialize the list but using list_del_init() and
>> list_empty() could work too. However, there is no list_del_init_rcu()
>> helper. Moreover, resetting the list's pointer with LIST_POISON2 might
>> help to detect bugs.
> 
> Either way, you are currently using the list_head API in a way that
> goes against what the header documents. If you want to rely on
> list_del() bringing the object into a specific state, then you can't
> leave the comment above list_del() as-is that says that it puts the
> object in an undefined state; and this kind of check should probably
> be done in a helper in list.h instead of open-coding the check for
> LIST_POISON2.

In the case of Landlock, it is illegal to use or recycle a rule which
was untied from its (initial) object. There is no use of
list_empty(&landlock_rule->list), only
landlock_rule_is_disabled(landlock_rule). The LIST_POISON2 might help to
identify such misuse.
