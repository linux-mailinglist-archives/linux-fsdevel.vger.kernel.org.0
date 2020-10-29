Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE629E76D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJ2Jfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 05:35:30 -0400
Received: from smtp-8fac.mail.infomaniak.ch ([83.166.143.172]:38675 "EHLO
        smtp-8fac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgJ2Jfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:35:30 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CMKzz22RSzljGmw;
        Thu, 29 Oct 2020 10:35:27 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CMKzx1whmzlh8TY;
        Thu, 29 Oct 2020 10:35:25 +0100 (CET)
Subject: Re: [PATCH v22 02/12] landlock: Add ruleset and domain management
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
 <20201027200358.557003-3-mic@digikod.net>
 <CAG48ez1j9KELLconr2RTmzt6j7QkY-wKC+8fn-rsG+wfxFJ=jg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <c52342ee-cf5c-e4d6-145e-0080fc07bc91@digikod.net>
Date:   Thu, 29 Oct 2020 10:35:24 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1j9KELLconr2RTmzt6j7QkY-wKC+8fn-rsG+wfxFJ=jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:05, Jann Horn wrote:
> On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>> A Landlock ruleset is mainly a red-black tree with Landlock rules as
>> nodes.  This enables quick update and lookup to match a requested access
>> e.g., to a file.  A ruleset is usable through a dedicated file
>> descriptor (cf. following commit implementing syscalls) which enables a
>> process to create and populate a ruleset with new rules.
>>
>> A domain is a ruleset tied to a set of processes.  This group of rules
>> defines the security policy enforced on these processes and their future
>> children.  A domain can transition to a new domain which is the
>> intersection of all its constraints and those of a ruleset provided by
>> the current process.  This modification only impact the current process.
>> This means that a process can only gain more constraints (i.e. lose
>> accesses) over time.
>>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks.

> 
> with some nits:
> 
> [...]
>> +static struct landlock_ruleset *create_ruleset(void)
>> +{
>> +       struct landlock_ruleset *new_ruleset;
>> +
>> +       new_ruleset = kzalloc(sizeof(*new_ruleset), GFP_KERNEL_ACCOUNT);
>> +       if (!new_ruleset)
>> +               return ERR_PTR(-ENOMEM);
>> +       refcount_set(&new_ruleset->usage, 1);
>> +       mutex_init(&new_ruleset->lock);
>> +       /*
>> +        * root = RB_ROOT
> 
> This should probably be done explicitly, even though it's currently a
> no-op, in case the implementation of RB_ROOT changes in the future.

OK, I'll do it for RB_ROOT.

> 
>> +        * hierarchy = NULL
>> +        * nb_rules = 0
>> +        * nb_layers = 0
>> +        * fs_access_mask = 0
>> +        */
>> +       return new_ruleset;
>> +}
> [...]
>> +/**
>> + * landlock_insert_rule - Insert a rule in a ruleset
>> + *
>> + * @ruleset: The ruleset to be updated.
>> + * @rule: Read-only payload to be inserted (not own by this function).
> 
> s/own/owned/

OK

> 
>> + * @is_merge: If true, intersects access rights and updates the rule's layers
>> + *            (e.g. merge two rulesets), else do a union of access rights and
>> + *            keep the rule's layers (e.g. extend a ruleset)
>> + *
>> + * Assumptions:
>> + *
>> + * - An inserted rule cannot be removed.
>> + * - The underlying kernel object must be held by the caller.
>> + */
>> +int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>> +               struct landlock_rule *const rule, const bool is_merge)
> [...]
>> +static int merge_ruleset(struct landlock_ruleset *const dst,
>> +               struct landlock_ruleset *const src)
>> +{
>> +       struct landlock_rule *walker_rule, *next_rule;
>> +       int err = 0;
>> +
>> +       might_sleep();
>> +       if (!src)
>> +               return 0;
>> +       /* Only merge into a domain. */
>> +       if (WARN_ON_ONCE(!dst || !dst->hierarchy))
>> +               return -EFAULT;
>> +
>> +       mutex_lock(&dst->lock);
>> +       mutex_lock_nested(&src->lock, 1);
> 
> Maybe add a comment like this above these two lines? "Ruleset locks
> are ordered by time of ruleset creation; dst is newer than src."

OK

> 
> Also, maybe s/1/SINGLE_DEPTH_NESTING/.

OK

> 
> 
>> +       /*
>> +        * Makes a new layer, but only increments the number of layers after
>> +        * the rules are inserted.
>> +        */
>> +       if (dst->nb_layers == sizeof(walker_rule->layers) * BITS_PER_BYTE) {
>> +               err = -E2BIG;
>> +               goto out_unlock;
>> +       }
>> +       dst->fs_access_mask |= src->fs_access_mask;
>> +
>> +       /* Merges the @src tree. */
>> +       rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
>> +                       &src->root, node) {
>> +               err = landlock_insert_rule(dst, walker_rule, true);
>> +               if (err)
>> +                       goto out_unlock;
>> +       }
>> +       dst->nb_layers++;
>> +
>> +out_unlock:
>> +       mutex_unlock(&src->lock);
>> +       mutex_unlock(&dst->lock);
>> +       return err;
>> +}
> [...]
>> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> [...]
>> +struct landlock_rule {
>> +       /**
>> +        * @node: Node in the red-black tree.
> 
> s/the red-black tree/the ruleset's red-black tree/

OK

> 
>> +        */
>> +       struct rb_node node;
>> +       /**
>> +        * @object: Pointer to identify a kernel object (e.g. an inode).  This
>> +        * is used as a key for this ruleset element.  This pointer is set once
>> +        * and never modified.  It always point to an allocated object because
> 
> s/point/points/

OK

> 
>> +        * each rule increment the refcount of there object.
> 
> s/increment/increments/
> s/there/its/

OK

> 
>> +        */
>> +       struct landlock_object *object;
>> +       /**
>> +        * @layers: Bitfield to identify the layers which resulted to @access
>> +        * from different consecutive intersections.
>> +        */
>> +       u64 layers;
>> +       /**
>> +        * @access: Bitfield of allowed actions on the kernel object.  They are
>> +        * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).  This
>> +        * may be the result of the merged access rights (boolean AND) from
>> +        * multiple layers referring to the same object.
>> +        */
>> +       u32 access;
>> +};
>> +
>> +/**
>> + * struct landlock_hierarchy - Node in a ruleset hierarchy
>> + */
>> +struct landlock_hierarchy {
>> +       /**
>> +        * @parent: Pointer to the parent node, or NULL if it is a root Lanlock
> 
> nit: Landlock

Thanks :)

> 
>> +        * domain.
>> +        */
>> +       struct landlock_hierarchy *parent;
>> +       /**
>> +        * @usage: Number of potential children domains plus their parent
>> +        * domain.
>> +        */
>> +       refcount_t usage;
>> +};
>> +
>> +/**
>> + * struct landlock_ruleset - Landlock ruleset
>> + *
>> + * This data structure must contains unique entries, be updatable, and quick to
> 
> s/contains/contain/

OK

> 
>> + * match an object.
>> + */
>> +struct landlock_ruleset {
>> +       /**
>> +        * @root: Root of a red-black tree containing &struct landlock_rule
>> +        * nodes.
> 
> Maybe add: "Once the ruleset is installed on a process, this tree is
> immutable until @usage reaches zero."

Right.

> 
>> +        */
>> +       struct rb_root root;
>> +       /**
>> +        * @hierarchy: Enables hierarchy identification even when a parent
>> +        * domain vanishes.  This is needed for the ptrace protection.
>> +        */
>> +       struct landlock_hierarchy *hierarchy;
>> +       union {
>> +               /**
>> +                * @work_free: Enables to free a ruleset within a lockless
>> +                * section.  This is only used by
>> +                * landlock_put_ruleset_deferred() when @usage reaches zero.
>> +                * The fields @lock, @usage, @nb_layers, @nb_rules and
>> +                * @fs_access_mask are then unused.
>> +                */
>> +               struct work_struct work_free;
>> +               struct {
>> +                       /**
>> +                        * @lock: Guards against concurrent modifications of
>> +                        * @root, if @usage is greater than zero.
>> +                        */
>> +                       struct mutex lock;
>> +                       /**
>> +                        * @usage: Number of processes (i.e. domains) or file
>> +                        * descriptors referencing this ruleset.
>> +                        */
>> +                       refcount_t usage;
>> +                       /**
>> +                        * @nb_rules: Number of non-overlapping (i.e. not for
>> +                        * the same object) rules in this ruleset.
>> +                        */
>> +                       u32 nb_rules;
>> +                       /**
>> +                        * @nb_layers: Number of layers which are used in this
>> +                        * ruleset.  This enables to check that all the layers
>> +                        * allow an access request.  A value of 0 identify a
> 
> s/identify/identifies/

OK

> 
> 
> 
>> +                        * non-merged ruleset (i.e. not a domain).
>> +                        */
>> +                       u32 nb_layers;
>> +                       /**
>> +                        * @fs_access_mask: Contains the subset of filesystem
>> +                        * actions which are restricted by a ruleset.  This is
>> +                        * used when merging rulesets and for user space
>> +                        * backward compatibility (i.e. future-proof).  Set
>> +                        * once and never changed for the lifetime of the
>> +                        * ruleset.
>> +                        */
>> +                       u32 fs_access_mask;
>> +               };
>> +       };
>> +};
