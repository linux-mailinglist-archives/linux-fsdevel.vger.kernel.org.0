Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A023466BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCWRuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhCWRuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:50:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF5C0613DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 10:49:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b4so3994970lfi.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7FG8frtqOnIaco1BBcfNWyiT6YFpbAkPyq6JjHD/SQ=;
        b=RqC83U3mrLkb+QFRLoON0Zw9/YzFosu29mToXdupbyes+eP8PIbUGwPqm8r7/KpwRR
         oZelC5ZmxImg8iBbM2gmLroSoYCiCEUvGtkQiOC4/PAEclQS7ugWWjIJNtnS3605Q2J8
         ZIN/PuHLu1RX17VYbH9ddtJ1VMYZ2UYl/zac1wDW7HAuCdsaxKFv6RGRsTr5dG5anaRB
         vswno94C7eL1m8PiYJ70kLt+hevGKr4aTJ011awdWOMnAZwre4yQob6AqxNo1DVYfd7u
         GLlsD8eUCAS1xPvQV5CkZ/lmgLn5dFcI7bh1eIS+ioRFxMljDx1upkfbDIXRXDqwZEuq
         dslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7FG8frtqOnIaco1BBcfNWyiT6YFpbAkPyq6JjHD/SQ=;
        b=R/4MqA+eGZ1vBEvb/x9YYDlToKUDpHh3Tvpjhn10jrM2iBnmj/y/lHRhWbNmIZCaZ6
         MZK3Fr1pZRgmmykFIrYBrNoA2k2L8BOhFngfaZVCTqJVQ+hZMrfQjzbZAQhkQgTFxDX4
         kFOOrFOPMoJ9v5gugtYTjPpk3YbFXkDyZdjtocsmRXtfOckJaoXl+3Sk7PKXgDzt+owu
         qgRhgAheU2u6G7akIRVOv3VxlP2Q+5t/U2gEjvHxSuyT/I+tIR2yRIjZ0SSGSu3383Vm
         mS4Uz2AIBISjh0I0GRueFztcYvirf0uzzfjyvErFaMZ3w3xAMpAwo8BsXYhNS0HojeWv
         M4cQ==
X-Gm-Message-State: AOAM5330sC0C1jdvaKZ86KBejyE5zdm2dOfAtBqZK9AqzRnx8G++li29
        aSa8Ok+zcwKujeySlKJHIftp2PoMHyxQeaQY0Z6LGw==
X-Google-Smtp-Source: ABdhPJwyenFneH4fs+z0uzL0vIEhWiSdc0Ge3Zq/4vWaO4unkEzFLjqdXBLZ4GR4Y3t93oZd2IPWbg1ktdyPCk9cf3w=
X-Received: by 2002:a19:22d6:: with SMTP id i205mr3164515lfi.352.1616521789635;
 Tue, 23 Mar 2021 10:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204252.427806-1-mic@digikod.net> <20210316204252.427806-8-mic@digikod.net>
 <CAG48ez1arKO3uYzwng8fst-UHkcH6J7YzyHFN+vfXUT2=1HT+w@mail.gmail.com> <b41a021c-69f4-075f-e9a0-a4483b280df8@digikod.net>
In-Reply-To: <b41a021c-69f4-075f-e9a0-a4483b280df8@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Mar 2021 18:49:22 +0100
Message-ID: <CAG48ez1Vkd3KtYphDHLLbbkKY9T_ByhUcxwYAcWuDAyiA04A+w@mail.gmail.com>
Subject: Re: [PATCH v30 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Mar 23, 2021 at 4:54 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 23/03/2021 01:13, Jann Horn wrote:
> >  On Tue, Mar 16, 2021 at 9:43 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> >> Using Landlock objects and ruleset, it is possible to tag inodes
> >> according to a process's domain.
> > [...]
> >> +static void release_inode(struct landlock_object *const object)
> >> +       __releases(object->lock)
> >> +{
> >> +       struct inode *const inode =3D object->underobj;
> >> +       struct super_block *sb;
> >> +
> >> +       if (!inode) {
> >> +               spin_unlock(&object->lock);
> >> +               return;
> >> +       }
> >> +
> >> +       /*
> >> +        * Protects against concurrent use by hook_sb_delete() of the =
reference
> >> +        * to the underlying inode.
> >> +        */
> >> +       object->underobj =3D NULL;
> >> +       /*
> >> +        * Makes sure that if the filesystem is concurrently unmounted=
,
> >> +        * hook_sb_delete() will wait for us to finish iput().
> >> +        */
> >> +       sb =3D inode->i_sb;
> >> +       atomic_long_inc(&landlock_superblock(sb)->inode_refs);
> >> +       spin_unlock(&object->lock);
> >> +       /*
> >> +        * Because object->underobj was not NULL, hook_sb_delete() and
> >> +        * get_inode_object() guarantee that it is safe to reset
> >> +        * landlock_inode(inode)->object while it is not NULL.  It is =
therefore
> >> +        * not necessary to lock inode->i_lock.
> >> +        */
> >> +       rcu_assign_pointer(landlock_inode(inode)->object, NULL);
> >> +       /*
> >> +        * Now, new rules can safely be tied to @inode with get_inode_=
object().
> >> +        */
> >> +
> >> +       iput(inode);
> >> +       if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode_r=
efs))
> >> +               wake_up_var(&landlock_superblock(sb)->inode_refs);
> >> +}
> > [...]
> >> +static struct landlock_object *get_inode_object(struct inode *const i=
node)
> >> +{
> >> +       struct landlock_object *object, *new_object;
> >> +       struct landlock_inode_security *inode_sec =3D landlock_inode(i=
node);
> >> +
> >> +       rcu_read_lock();
> >> +retry:
> >> +       object =3D rcu_dereference(inode_sec->object);
> >> +       if (object) {
> >> +               if (likely(refcount_inc_not_zero(&object->usage))) {
> >> +                       rcu_read_unlock();
> >> +                       return object;
> >> +               }
> >> +               /*
> >> +                * We are racing with release_inode(), the object is g=
oing
> >> +                * away.  Wait for release_inode(), then retry.
> >> +                */
> >> +               spin_lock(&object->lock);
> >> +               spin_unlock(&object->lock);
> >> +               goto retry;
> >> +       }
> >> +       rcu_read_unlock();
> >> +
> >> +       /*
> >> +        * If there is no object tied to @inode, then create a new one=
 (without
> >> +        * holding any locks).
> >> +        */
> >> +       new_object =3D landlock_create_object(&landlock_fs_underops, i=
node);
> >> +       if (IS_ERR(new_object))
> >> +               return new_object;
> >> +
> >> +       /* Protects against concurrent get_inode_object() calls. */
> >> +       spin_lock(&inode->i_lock);
> >> +       object =3D rcu_dereference_protected(inode_sec->object,
> >> +                       lockdep_is_held(&inode->i_lock));
> >
> > rcu_dereference_protected() requires that inode_sec->object is not
> > concurrently changed, but I think another thread could call
> > get_inode_object() while we're in landlock_create_object(), and then
> > we could race with the NULL write in release_inode() here? (It
> > wouldn't actually be a UAF though because we're not actually accessing
> > `object` here.) Or am I missing a lock that prevents this?
> >
> > In v28 this wasn't an issue because release_inode() was holding
> > inode->i_lock (and object->lock) during the NULL store; but in v29 and
> > this version the NULL store in release_inode() moved out of the locked
> > region. I think you could just move the NULL store in release_inode()
> > back up (and maybe add a comment explaining the locking rules for
> > landlock_inode(...)->object)?
> >
> > (Or alternatively you could use rcu_dereference_raw() with a comment
> > explaining that the read pointer is only used to check for NULL-ness,
> > and that it is guaranteed that the pointer can't change if it is NULL
> > and we're holding the lock. But that'd be needlessly complicated, I
> > think.)
>
> To reach rcu_assign_pointer(landlock_inode(inode)->object, NULL) in
> release_inode() or in hook_sb_delete(), the
> landlock_inode(inode)->object need to be non-NULL,

Yes.

> which implies that a
> call to get_inode_object(inode) either "retry" (because release_inode is
> only called by landlock_put_object, which set object->usage to 0) until
> it creates a new object, or reuses the existing referenced object (and
> increments object->usage).

But it can be that landlock_inode(inode)->object only becomes non-NULL
after get_inode_object() has checked
rcu_dereference(inode_sec->object).

> The worse case would be if
> get_inode_object(inode) is called just before the
> rcu_assign_pointer(landlock_inode(inode)->object, NULL) from
> hook_sb_delete(), which would result in an object with a NULL underobj,
> which is the expected behavior (and checked by release_inode).

The scenario I'm talking about doesn't involve hook_sb_delete().

> The line rcu_assign_pointer(inode_sec->object, new_object) from
> get_inode_object() can only be reached if the underlying inode doesn't
> reference an object,

Yes.

> in which case hook_sb_delete() will not reach the
> rcu_assign_pointer(landlock_inode(inode)->object, NULL) line for this
> same inode.
>
> This works because get_inode_object(inode) is mutually exclusive to
> itself with the same inode (i.e. an inode can only point to an object
> that references this same inode).

To clarify: You can concurrently call get_inode_object() multiple
times on the same inode, right? There are no locks held on entry to
that function.

> I tried to explain this with the comment "Protects against concurrent
> get_inode_object() calls" in get_inode_object(), and the comments just
> before both rcu_assign_pointer(landlock_inode(inode)->object, NULL).

The scenario I'm talking about is:

Initially the inode does not have an associated landlock_object. There
are two threads A and B. Thread A is going to execute
get_inode_object(). Thread B is going to execute get_inode_object()
followed immediately by landlock_put_object().

thread A: enters get_inode_object()
thread A: rcu_dereference(inode_sec->object) returns NULL
thread A: enters landlock_create_object()
thread B: enters get_inode_object()
thread B: rcu_dereference(inode_sec->object) returns NULL
thread B: calls landlock_create_object()
thread B: sets inode_sec->object while holding inode->i_lock
thread B: leaves get_inode_object()
thread B: enters landlock_put_object()
thread B: object->usage drops to 0, object->lock is taken
thread B: calls release_inode()
thread B: drops object->lock
thread A: returns from landlock_create_object()
thread A: takes inode->i_lock

At this point, thread B will run:

    rcu_assign_pointer(landlock_inode(inode)->object, NULL);

while thread A runs:

    rcu_dereference_protected(inode_sec->object,
        lockdep_is_held(&inode->i_lock));

meaning there is a (theoretical) data race, since
rcu_dereference_protected() doesn't use READ_ONCE().

> >> +       if (unlikely(object)) {
> >> +               /* Someone else just created the object, bail out and =
retry. */
> >> +               spin_unlock(&inode->i_lock);
> >> +               kfree(new_object);
> >> +
> >> +               rcu_read_lock();
> >> +               goto retry;
> >> +       }
> >> +
> >> +       rcu_assign_pointer(inode_sec->object, new_object);
> >> +       /*
> >> +        * @inode will be released by hook_sb_delete() on its superblo=
ck
> >> +        * shutdown.
> >> +        */
> >> +       ihold(inode);
> >> +       spin_unlock(&inode->i_lock);
> >> +       return new_object;
> >> +}
