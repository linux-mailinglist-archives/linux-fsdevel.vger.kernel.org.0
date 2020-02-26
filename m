Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810F5170969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 21:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBZUYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 15:24:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44209 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBZUYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:24:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so842224oia.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 12:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/yuB9e50FXgZH1kWP3PvcSWvly1QzKcT8fkXyUBwZug=;
        b=hJfFvk1BBgp6CKUYRdD1jQxc14aW/w/AbcBTbwrzKwq3DM2yx/BE2MASsQJ3DStPTm
         0ZzDVitbKMbtU53yFkVDCz6bOY1WgOIexH60oERBmmyfo1EY+5VQypd8EnXZPIq8mf8C
         QkjWkeCsyF3qrYgvnptSHYtFQ5hFjbDsni/rfJHrp1xEOlwGjrkHmEj1lD4vPmEYOkdD
         Is4C+U8nei/W32Fe2CBDZtQR5embRLef5RrNT56N53+g24udNAHhVt2l3H0TOnEf8iKM
         SQVJQE9H+mSaX6DoFUk+VqULMZnBnbDV/nYS70nj8w3piPPfhTny8p0cTbFsmq5zmn1E
         0lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/yuB9e50FXgZH1kWP3PvcSWvly1QzKcT8fkXyUBwZug=;
        b=d+8ZqEe5EfsvQmZ8jX2dSTxkoBRGP2hCAVd8gymYnrFx+NAUnj4gIzLHH9uHxrBCBt
         IfcOxZAR90bzVxOCCjbqKS3Ar/HoAarZwiAO05P2QLsnxIt1ISNAPbgalt5VQvQBIZjp
         71aYEaQ+yj6msBMImACXmwj1Q3LPvKNam2q6t/2OwFVnU3IrjIJAMtpaSjv78tii7wJx
         QlFxUTe2EVPFT/nhiiYXkDaxjXVbd9/utZecPDJ7Fea97Xf/5RS2WeDhQ0XODl/ZmHAo
         fY60+F+fr101qSyUt/MAaASusJ+kPfbk3+xq3AYfgulwOcRnHATfdLpgfbzvgWoBkpNU
         AMAg==
X-Gm-Message-State: APjAAAVhaikdauz0FaUEAyOnZlQb0mra2EssJBIv5dP0B2wC8H6dnVwd
        t+RIvPBJ0mj5kaH0PSx/MRZcxcxJQ0JTX6y6gYtEFQ==
X-Google-Smtp-Source: APXvYqyuaFgGkEJyCG6QR25XliBYVPp5k6c9VgvhycShsyyaF/p8qL+6bNOtGljtyq2r14WIwBKO0518S14eLWcVBr8=
X-Received: by 2002:aca:d954:: with SMTP id q81mr599159oig.157.1582748670642;
 Wed, 26 Feb 2020 12:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <20200224160215.4136-2-mic@digikod.net>
 <CAG48ez1FN0B05r35c-EDuQNoW=5ZTy1iBzksbkt+toqs+_tdqg@mail.gmail.com> <67465638-e22c-5d1a-df37-862b31d999a1@digikod.net>
In-Reply-To: <67465638-e22c-5d1a-df37-862b31d999a1@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Feb 2020 21:24:04 +0100
Message-ID: <CAG48ez33WjzAee9h_Nfxi6vbnjognsKziv=whi_7ocT36DCXcg@mail.gmail.com>
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

On Wed, Feb 26, 2020 at 4:32 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 25/02/2020 21:49, Jann Horn wrote:
> > On Mon, Feb 24, 2020 at 5:05 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> A Landlock object enables to identify a kernel object (e.g. an inode).
> >> A Landlock rule is a set of access rights allowed on an object.  Rules
> >> are grouped in rulesets that may be tied to a set of processes (i.e.
> >> subjects) to enforce a scoped access-control (i.e. a domain).
> >>
> >> Because Landlock's goal is to empower any process (especially
> >> unprivileged ones) to sandbox themselves, we can't rely on a system-wi=
de
> >> object identification such as file extended attributes.  Indeed, we ne=
ed
> >> innocuous, composable and modular access-controls.
> >>
> >> The main challenge with this constraints is to identify kernel objects
> >> while this identification is useful (i.e. when a security policy makes
> >> use of this object).  But this identification data should be freed onc=
e
> >> no policy is using it.  This ephemeral tagging should not and may not =
be
> >> written in the filesystem.  We then need to manage the lifetime of a
> >> rule according to the lifetime of its object.  To avoid a global lock,
> >> this implementation make use of RCU and counters to safely reference
> >> objects.
> >>
> >> A following commit uses this generic object management for inodes.
[...]
> >> +config SECURITY_LANDLOCK
> >> +       bool "Landlock support"
> >> +       depends on SECURITY
> >> +       default n
> >
> > (I think "default n" is implicit?)
>
> It seems that most (all?) Kconfig are written like this.

See e.g. <https://lore.kernel.org/lkml/c187bb77-e804-93bd-64db-9418be58f191=
@infradead.org/>.

[...]
> >> +       return object;
> >> +}
> >> +
> >> +struct landlock_object *landlock_get_object(struct landlock_object *o=
bject)
> >> +       __acquires(object->usage)
> >> +{
> >> +       __acquire(object->usage);
> >> +       /*
> >> +        * If @object->usage equal 0, then it will be ignored by write=
rs, and
> >> +        * underlying_object->object may be replaced, but this is not =
an issue
> >> +        * for release_object().
> >> +        */
> >> +       if (object && refcount_inc_not_zero(&object->usage)) {
> >> +               /*
> >> +                * It should not be possible to get a reference to an =
object if
> >> +                * its underlying object is being terminated (e.g. wit=
h
> >> +                * landlock_release_object()), because an object is on=
ly
> >> +                * modifiable through such underlying object.  This is=
 not the
> >> +                * case with landlock_get_object_cleaner().
> >> +                */
> >> +               WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
> >> +               return object;
> >> +       }
> >> +       return NULL;
> >> +}
> >> +
> >> +static struct landlock_object *get_object_cleaner(
> >> +               struct landlock_object *object)
> >> +       __acquires(object->cleaners)
> >> +{
> >> +       __acquire(object->cleaners);
> >> +       if (object && refcount_inc_not_zero(&object->cleaners))
> >> +               return object;
> >> +       return NULL;
> >> +}
> >
> > I don't get this whole "cleaners" thing. Can you give a quick
> > description of why this is necessary, and what benefits it has over a
> > standard refcounting+RCU scheme? I don't immediately see anything that
> > requires this.
>
> This indeed needs more documentation here. Here is a comment I'll add to
> get_object_cleaner():
>
> This enables to safely get a reference to an object to potentially free
> it if it is not already being freed by a concurrent thread.

"get a reference to an object to potentially free it" just sounds all
wrong to me. You free an object when you're *dropping* a reference to
it. Your refcounting scheme doesn't fit my mental models of how normal
refcounting works at all...

[...]
> >> +/*
> >> + * Putting an object is easy when the object is being terminated, but=
 it is
> >> + * much more tricky when the reason is that there is no more rule tie=
d to this
> >> + * object.  Indeed, new rules could be added at the same time.
> >> + */
> >> +void landlock_put_object(struct landlock_object *object)
> >> +       __releases(object->usage)
> >> +{
> >> +       struct landlock_object *object_cleaner;
> >> +
> >> +       __release(object->usage);
> >> +       might_sleep();
> >> +       if (!object)
> >> +               return;
> >> +       /*
> >> +        * Guards against concurrent termination to be able to termina=
te
> >> +        * @object if it is empty and not referenced by another rule-a=
ppender
> >> +        * other than the underlying object.
> >> +        */
> >> +       object_cleaner =3D get_object_cleaner(object);
[...]
> >> +       /*
> >> +        * Decrements @object->usage and if it reach zero, also decrem=
ent
> >> +        * @object->cleaners.  If both reach zero, then release and fr=
ee
> >> +        * @object.
> >> +        */
> >> +       if (refcount_dec_and_test(&object->usage)) {
> >> +               struct landlock_rule *rule_walker, *rule_walker2;
> >> +
> >> +               spin_lock(&object->lock);
> >> +               /*
> >> +                * Disables all the rules tied to @object when it is f=
orbidden
> >> +                * to add new rule but still allowed to remove them wi=
th
> >> +                * landlock_put_rule().  This is crucial to be able to=
 safely
> >> +                * free a rule according to landlock_rule_is_disabled(=
).
> >> +                */
> >> +               list_for_each_entry_safe(rule_walker, rule_walker2,
> >> +                               &object->rules, list)
> >> +                       list_del_rcu(&rule_walker->list);

So... rules don't take references on the landlock_objects they use?
Instead, the landlock_object knows which rules use it, and when the
landlock_object goes away, it nukes all the rules associated with
itself?

That seems terrible to me - AFAICS it means that if some random
process decides to install a landlock rule that uses inode X, and then
that process dies together with all its landlock rules, the inode
still stays pinned in kernel memory as long as the superblock is
mounted. In other words, it's a resource leak. (And if I'm not missing
something in patch 5, that applies even if the inode has been
unlinked?)

Can you please refactor your refcounting as follows?

 - A rule takes a reference on each landlock_object it uses.
 - A landlock_object takes a reference on the underlying object (just like =
now).
 - The underlying object *DOES NOT* take a reference on the
landlock_object (unlike now); the reference from the underlying object
to the landlock_object has weak pointer semantics.
 - When a landlock_object's refcount drops to zero (iow no rules use
it anymore), it is freed.

That might also help get rid of the awkward ->cleaners thing?

> >> +               /*
> >> +                * Releases @object if it is not already released (e.g=
. with
> >> +                * landlock_release_object()).
> >> +                */
> >> +               release_object(object);
> >> +               /*
> >> +                * Unbalances the @object->cleaners counter to reflect=
 the
> >> +                * underlying object release.
> >> +                */
> >> +               __acquire(object->cleaners);
> >> +               put_object_free(object);
> >> +       }
> >> +       put_object_cleaner(object_cleaner);
> >> +}
[...]
> >> +static inline bool landlock_rule_is_disabled(
> >> +               struct landlock_rule *rule)
> >> +{
> >> +       /*
> >> +        * Disabling (i.e. unlinking) a landlock_rule is a one-way ope=
ration.
> >> +        * It is not possible to re-enable such a rule, then there is =
no need
> >> +        * for smp_load_acquire().
> >> +        *
> >> +        * LIST_POISON2 is set by list_del() and list_del_rcu().
> >> +        */
> >> +       return !rule || READ_ONCE(rule->list.prev) =3D=3D LIST_POISON2=
;
> >
> > You're not allowed to do this, the comment above list_del() states:
> >
> >  * Note: list_empty() on entry does not return true after this, the ent=
ry is
> >  * in an undefined state.
>
> list_del() checks READ_ONCE(head->next) =3D=3D head, but
> landlock_rule_is_disabled() checks READ_ONCE(rule->list.prev) =3D=3D
> LIST_POISON2.
> The comment about LIST_POISON2 is right but may be misleading. There is
> no use of list_empty() with a landlock_rule->list, only
> landlock_object->rules. The only list_del() is in landlock_put_rule()
> when there is a guarantee that there is no other reference to it, hence
> no possible use of landlock_rule_is_disabled() with this rule. I could
> replace it with a call to list_del_rcu() to make it more consistent.
>
> >
> > If you want to be able to test whether the element is on a list
> > afterwards, use stuff like list_del_init().
>
> There is no need to re-initialize the list but using list_del_init() and
> list_empty() could work too. However, there is no list_del_init_rcu()
> helper. Moreover, resetting the list's pointer with LIST_POISON2 might
> help to detect bugs.

Either way, you are currently using the list_head API in a way that
goes against what the header documents. If you want to rely on
list_del() bringing the object into a specific state, then you can't
leave the comment above list_del() as-is that says that it puts the
object in an undefined state; and this kind of check should probably
be done in a helper in list.h instead of open-coding the check for
LIST_POISON2.
