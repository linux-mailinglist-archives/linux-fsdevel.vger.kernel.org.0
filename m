Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC70D121E9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 23:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLPWyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 17:54:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35635 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLPWyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:54:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id f71so1556665otf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qerC5f2g4K0CLRKMpy8gs8tB4kD6Nc3TAFdz4gfy1tA=;
        b=GoxdipU08WF/hBd/Xo7+BpPL0vsDh2D8cNoBypL2vwB05UhmXAk/4yO0/Cfmviu7Fm
         e+tn3V8sDthIue1ID5iFWdq0c7YsYNYnzxneAx7E8sbHUuoMC3hYHjn7rJNk/HXpPkiT
         Tl6xu6eGuOqoacPBQGU2zeYAo3Y7MNWILBzhjKDGtuX4aOowIkPekwsh3axn6EEa8j8h
         B+0UyxOPIREj4iNTNRbCq34GeuuAaq8unoQLjjaTnqpfshPg8hVYkYz5Nm0FceXjTLSy
         WLsQCmdCSQHlWhWMatM3iXAK9SdZM9Ezh+uOsNoTjZtJRYRyM63RETGl0lxISSWbC+oT
         czYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qerC5f2g4K0CLRKMpy8gs8tB4kD6Nc3TAFdz4gfy1tA=;
        b=Z5O4aUbEhpkLApiWMCptcQvRXCmAX/HGf65mWwdr1aYeopWjcnJPVoKAOt00O/ReuN
         mWHO20lbyYXOnboEkI1nFqA5pEDb3fRo0tap/Ky0d40ogVCMJB8B1lIYnn3eidtxt+ol
         GyBu15lz5FRYu6dPNVMr+rzGGdwqazHhISUhAkO2CltmBLf/g9XRvU5dJozkQ5P/JRH/
         PTZXcWK+4kDYv7C6MyANThvRfM4HKTH+HKNW0/62Ho564B1fp/djdiAYElBgLwTNhi4V
         HP3eYMIZEZ+WUOihUmIsDvyAfKOCtZKtNQWioy2qXrXnQUyAA4FUwD/n/neWRfyVpDUb
         2fnw==
X-Gm-Message-State: APjAAAXwSZggfLQnJUVZkcuyJbyyxD8UWzzohA3m2mkQvldyEvrrHOfO
        z2tVML6otWQSAklcOF8DA6WbQZ69r1au+3lAOEkBWQ==
X-Google-Smtp-Source: APXvYqy1hECV7GCgPWmRWV7xZsNCBrwr6cCGgSjrqmtTSzsSQSSks+h7nRXhxJEWrL5nsuAz8LmXa13t5JLWnazcDPY=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr579460oti.32.1576536861535;
 Mon, 16 Dec 2019 14:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20191216091220.465626-1-laurent@vivier.eu> <20191216091220.465626-2-laurent@vivier.eu>
 <CAG48ez2xNCRmuzpNqYW5R+XMKzW8YiemsPUPgk42KSkSZXmvLg@mail.gmail.com> <15d270a6-2264-adc5-3f56-fdb8b67ad267@vivier.eu>
In-Reply-To: <15d270a6-2264-adc5-3f56-fdb8b67ad267@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Dec 2019 23:53:54 +0100
Message-ID: <CAG48ez2YE33KiuhnHa=cq_DymqWLAv9CyeD3BOrjsStKfb_dBQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Greg Kurz <groug@kaod.org>, Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Henning Schild <henning.schild@siemens.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 9:05 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 16/12/2019 =C3=A0 20:08, Jann Horn a =C3=A9crit :
> > On Mon, Dec 16, 2019 at 10:12 AM Laurent Vivier <laurent@vivier.eu> wro=
te:
> >> This patch allows to have a different binfmt_misc configuration
> >> for each new user namespace. By default, the binfmt_misc configuration
> >> is the one of the previous level, but if the binfmt_misc filesystem is
> >> mounted in the new namespace a new empty binfmt instance is created an=
d
> >> used in this namespace.
> >>
> >> For instance, using "unshare" we can start a chroot of another
> >> architecture and configure the binfmt_misc interpreter without being r=
oot
> >> to run the binaries in this chroot.
> >
> > How do you ensure that when userspace is no longer using the user
> > namespace and mount namespace, the entries and the binfmt_misc
> > superblock are deleted? As far as I can tell from looking at the code,
> > at the moment, if I create a user namespace+mount namespace, mount
> > binfmt_misc in there, register a file format and then let all
> > processes inside the namespaces exit, the binfmt_misc mount will be
> > kept alive by the simple_pin_fs() stuff, and the binfmt_misc entries
> > will also stay in memory.
> >
> > [...]
>
> Do you have any idea how I can fix this issue?

I think the easiest way (keeping in mind that we want to avoid having
to fiddle around with reference loops, where e.g. interpreter
executable files opened by binfmt_misc have references back to the
user namespace through ->f_cred) would be to add a new patch in front
of this one that changes the semantics such that when binfmt_misc is
unmounted, all the existing format registrations are deleted. That's
probably also nicer from the perspective of inspectability. It could
in theory break stuff, but I think that's probably somewhat unlikely.
Still, it'd be an API change, and therefore you should CC linux-api@
on such a change.

> >> @@ -718,7 +736,9 @@ static ssize_t bm_register_write(struct file *file=
, const char __user *buffer,
> >>         if (!inode)
> >>                 goto out2;
> >>
> >> -       err =3D simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> >> +       ns =3D binfmt_ns(file_dentry(file)->d_sb->s_user_ns);
> >> +       err =3D simple_pin_fs(&bm_fs_type, &ns->bm_mnt,
> >> +                           &ns->entry_count);
> >
> > When you call simple_pin_fs() here, the user namespace of `current`
> > and the user namespace of the superblock are not necessarily related.
> > So simple_pin_fs() may end up taking a reference on the mountpoint for
> > a user namespace that has nothing to do with the namespace for which
> > an entry is being created.
>
> Do you have any idea how I can fix this issue?

If you fix the memory leak the way I suggested, this wouldn't be a
problem anymore either.

> >> +static void bm_free(struct fs_context *fc)
> >> +{
> >> +       if (fc->s_fs_info)
> >> +               put_user_ns(fc->s_fs_info);
> >> +}
> >
> > Silly question: Why the "if"? Can you ever reach this with fc->s_fs_inf=
o=3D=3DNULL?
>
> So I understand the if is unnecessary and I will remove it.

Your code was actually exactly right, I didn't understand how
fc->s_fs_info works.

> >>  static int bm_get_tree(struct fs_context *fc)
> >>  {
> >> -       return get_tree_single(fc, bm_fill_super);
> >> +       return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_=
ns));
> >
> > get_user_ns() increments the refcount of the namespace, but in the
> > case where a binfmt_misc mount already exists, that refcount is never
> > dropped, right? That would be a security bug, since an attacker could
> > overflow the refcount of the user namespace and then trigger a UAF.
> > (And the refcount hardening won't catch it because user namespaces
> > still use raw atomics instead of refcount_t.)
>
> Do you have any idea how I can fix this issue?

Ah, this was actually fine. I missed that get_tree_keyed() stashes
that pointer in fc->s_fs_info.

> >> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> >
> > Nit: Isn't this kind of check normally written as "#ifdef"?
> >
>
> What is the difference?

As explained in Documentation/process/coding-style.rst and the
relevant header, IS_ENABLED() is for inline use in C expressions.
