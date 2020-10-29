Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A029E014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbgJ2BHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 21:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404131AbgJ2BGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:06:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83089C0613D5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:06:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l28so1163817lfp.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uwGgr3GLwTr1yGzOv+StyXrvYqSZsWQzZJYgcvr8cgA=;
        b=df6qBeOaNUd6TR5g2Iduv1RbCNFi8OcVtdGJPwnOqidbMRSpY+gx7jNumMCFFMrQR0
         D2WTecqdr/nzO6H3904DrOChaJ95WPh5tkbtMP0IhqOzfuSvYEzIcM3dM5K3qYtS5nf+
         tP1GqVk3jYP6rtxGckMrt1PCndsfnYCzEA7Ini61jyWjkjySwujyBt7Eaos5JTV8hwVN
         PdL8fDYte/58X38wQyOqZPd37vxR+HBWhsaegapKGzwq1yuGHbNZUbK4+Ycfyh8EnWta
         61pizGpWdO1q6PqMehNyy89spICLXBpIvm5gAXjHYml0kvQ3u+knHn7KFJsYkdr+F8Us
         /xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uwGgr3GLwTr1yGzOv+StyXrvYqSZsWQzZJYgcvr8cgA=;
        b=Hhz7geuraWedVRPqmM/pEpmt/D0qmt2vbTowLcwk322jK3QTpxNQbVTlS8UWkm+ZMB
         p/pspT+7/fZBc8gVkhvl+YBq66BtgNfiXfzQM72E1o8B2zhePZ8jqIL8/KvdHwWuk439
         H4dmgQPqxS5523O1wodBAXYJkkLUI01tg5PTwnRcgD3ZTn+6CJS2ENLAPhP8N4kzn8JL
         DG1Y1/Fr9kAnK7zFogNXTEdgaA7YthJ8Pc6P4MVjsvaK+FaBQDJoIs2/3VksbJrvIhTc
         qBTCP2UjOIJEvoLAVMTUpp67dPH4LJY/borVxztQLFgT6Ygbl5IeIxo0P/eVf9JKP3gQ
         0Xkg==
X-Gm-Message-State: AOAM533ojkO+tF1WvaykZESJD+2joSF6kDrPfUuz7t6gLIHhzTfz+9qV
        oALh4T0nG9LfvVkPdiv9+9N/nqsFwgpgiyCwHngr6A==
X-Google-Smtp-Source: ABdhPJwPgJyMC5u+kpiuN1spW+0PRJDgh7VvqnPziPVW6Pzm2fdllTPcvPfrnGQZZXjgS9/qQttZh+vG7ocqG2scSuk=
X-Received: by 2002:a19:ef07:: with SMTP id n7mr573964lfh.482.1603933580785;
 Wed, 28 Oct 2020 18:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-3-mic@digikod.net>
In-Reply-To: <20201027200358.557003-3-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:05:53 +0100
Message-ID: <CAG48ez1j9KELLconr2RTmzt6j7QkY-wKC+8fn-rsG+wfxFJ=jg@mail.gmail.com>
Subject: Re: [PATCH v22 02/12] landlock: Add ruleset and domain management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested access
> e.g., to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
>
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>

with some nits:

[...]
> +static struct landlock_ruleset *create_ruleset(void)
> +{
> +       struct landlock_ruleset *new_ruleset;
> +
> +       new_ruleset =3D kzalloc(sizeof(*new_ruleset), GFP_KERNEL_ACCOUNT)=
;
> +       if (!new_ruleset)
> +               return ERR_PTR(-ENOMEM);
> +       refcount_set(&new_ruleset->usage, 1);
> +       mutex_init(&new_ruleset->lock);
> +       /*
> +        * root =3D RB_ROOT

This should probably be done explicitly, even though it's currently a
no-op, in case the implementation of RB_ROOT changes in the future.

> +        * hierarchy =3D NULL
> +        * nb_rules =3D 0
> +        * nb_layers =3D 0
> +        * fs_access_mask =3D 0
> +        */
> +       return new_ruleset;
> +}
[...]
> +/**
> + * landlock_insert_rule - Insert a rule in a ruleset
> + *
> + * @ruleset: The ruleset to be updated.
> + * @rule: Read-only payload to be inserted (not own by this function).

s/own/owned/

> + * @is_merge: If true, intersects access rights and updates the rule's l=
ayers
> + *            (e.g. merge two rulesets), else do a union of access right=
s and
> + *            keep the rule's layers (e.g. extend a ruleset)
> + *
> + * Assumptions:
> + *
> + * - An inserted rule cannot be removed.
> + * - The underlying kernel object must be held by the caller.
> + */
> +int landlock_insert_rule(struct landlock_ruleset *const ruleset,
> +               struct landlock_rule *const rule, const bool is_merge)
[...]
> +static int merge_ruleset(struct landlock_ruleset *const dst,
> +               struct landlock_ruleset *const src)
> +{
> +       struct landlock_rule *walker_rule, *next_rule;
> +       int err =3D 0;
> +
> +       might_sleep();
> +       if (!src)
> +               return 0;
> +       /* Only merge into a domain. */
> +       if (WARN_ON_ONCE(!dst || !dst->hierarchy))
> +               return -EFAULT;
> +
> +       mutex_lock(&dst->lock);
> +       mutex_lock_nested(&src->lock, 1);

Maybe add a comment like this above these two lines? "Ruleset locks
are ordered by time of ruleset creation; dst is newer than src."

Also, maybe s/1/SINGLE_DEPTH_NESTING/.


> +       /*
> +        * Makes a new layer, but only increments the number of layers af=
ter
> +        * the rules are inserted.
> +        */
> +       if (dst->nb_layers =3D=3D sizeof(walker_rule->layers) * BITS_PER_=
BYTE) {
> +               err =3D -E2BIG;
> +               goto out_unlock;
> +       }
> +       dst->fs_access_mask |=3D src->fs_access_mask;
> +
> +       /* Merges the @src tree. */
> +       rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
> +                       &src->root, node) {
> +               err =3D landlock_insert_rule(dst, walker_rule, true);
> +               if (err)
> +                       goto out_unlock;
> +       }
> +       dst->nb_layers++;
> +
> +out_unlock:
> +       mutex_unlock(&src->lock);
> +       mutex_unlock(&dst->lock);
> +       return err;
> +}
[...]
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
[...]
> +struct landlock_rule {
> +       /**
> +        * @node: Node in the red-black tree.

s/the red-black tree/the ruleset's red-black tree/

> +        */
> +       struct rb_node node;
> +       /**
> +        * @object: Pointer to identify a kernel object (e.g. an inode). =
 This
> +        * is used as a key for this ruleset element.  This pointer is se=
t once
> +        * and never modified.  It always point to an allocated object be=
cause

s/point/points/

> +        * each rule increment the refcount of there object.

s/increment/increments/
s/there/its/

> +        */
> +       struct landlock_object *object;
> +       /**
> +        * @layers: Bitfield to identify the layers which resulted to @ac=
cess
> +        * from different consecutive intersections.
> +        */
> +       u64 layers;
> +       /**
> +        * @access: Bitfield of allowed actions on the kernel object.  Th=
ey are
> +        * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).  =
This
> +        * may be the result of the merged access rights (boolean AND) fr=
om
> +        * multiple layers referring to the same object.
> +        */
> +       u32 access;
> +};
> +
> +/**
> + * struct landlock_hierarchy - Node in a ruleset hierarchy
> + */
> +struct landlock_hierarchy {
> +       /**
> +        * @parent: Pointer to the parent node, or NULL if it is a root L=
anlock

nit: Landlock

> +        * domain.
> +        */
> +       struct landlock_hierarchy *parent;
> +       /**
> +        * @usage: Number of potential children domains plus their parent
> +        * domain.
> +        */
> +       refcount_t usage;
> +};
> +
> +/**
> + * struct landlock_ruleset - Landlock ruleset
> + *
> + * This data structure must contains unique entries, be updatable, and q=
uick to

s/contains/contain/

> + * match an object.
> + */
> +struct landlock_ruleset {
> +       /**
> +        * @root: Root of a red-black tree containing &struct landlock_ru=
le
> +        * nodes.

Maybe add: "Once the ruleset is installed on a process, this tree is
immutable until @usage reaches zero."

> +        */
> +       struct rb_root root;
> +       /**
> +        * @hierarchy: Enables hierarchy identification even when a paren=
t
> +        * domain vanishes.  This is needed for the ptrace protection.
> +        */
> +       struct landlock_hierarchy *hierarchy;
> +       union {
> +               /**
> +                * @work_free: Enables to free a ruleset within a lockles=
s
> +                * section.  This is only used by
> +                * landlock_put_ruleset_deferred() when @usage reaches ze=
ro.
> +                * The fields @lock, @usage, @nb_layers, @nb_rules and
> +                * @fs_access_mask are then unused.
> +                */
> +               struct work_struct work_free;
> +               struct {
> +                       /**
> +                        * @lock: Guards against concurrent modifications=
 of
> +                        * @root, if @usage is greater than zero.
> +                        */
> +                       struct mutex lock;
> +                       /**
> +                        * @usage: Number of processes (i.e. domains) or =
file
> +                        * descriptors referencing this ruleset.
> +                        */
> +                       refcount_t usage;
> +                       /**
> +                        * @nb_rules: Number of non-overlapping (i.e. not=
 for
> +                        * the same object) rules in this ruleset.
> +                        */
> +                       u32 nb_rules;
> +                       /**
> +                        * @nb_layers: Number of layers which are used in=
 this
> +                        * ruleset.  This enables to check that all the l=
ayers
> +                        * allow an access request.  A value of 0 identif=
y a

s/identify/identifies/



> +                        * non-merged ruleset (i.e. not a domain).
> +                        */
> +                       u32 nb_layers;
> +                       /**
> +                        * @fs_access_mask: Contains the subset of filesy=
stem
> +                        * actions which are restricted by a ruleset.  Th=
is is
> +                        * used when merging rulesets and for user space
> +                        * backward compatibility (i.e. future-proof).  S=
et
> +                        * once and never changed for the lifetime of the
> +                        * ruleset.
> +                        */
> +                       u32 fs_access_mask;
> +               };
> +       };
> +};
