Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238532A190A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgJaRnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 13:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgJaRnp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:43:45 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1F42068D
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604166223;
        bh=VwVQKGVZ4cnLMs/o97T/OeE50opoRiznL7EK0zhPGx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsQFazG8fR6T63Fnd3VB1d2DB5UMVjyMF2NXFaObiDLeilHAgcLONNVQ7/iesMWLA
         kd5Gp+7C0nTKm6c/sh+m2hmq2VO6E0CO0SQZ/4ZRDaueRDnA5vM+ZPtvtUOWC8DYLO
         2AAyAGE2ETuX9XURs4VDsCZ2FL+U+LwEvFf3wrpw=
Received: by mail-wr1-f47.google.com with SMTP id i16so4451518wrv.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 10:43:43 -0700 (PDT)
X-Gm-Message-State: AOAM532AJZojETegv4UQ31E8hrjkQu0hitsDYaiOMTYleJXg7TIhjxYX
        xNmvewqMDkVNndZPN8Wt9TcpJRlq3wT81CkxhZXScg==
X-Google-Smtp-Source: ABdhPJxkeXuBZ9ppYMTVmISmCea/IZffdZXFv/zxP+96vzBS0FFhFINAWRxe2n5zvdo8ERu5qq7HsUAB8p67W3Zh/GM=
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr8926686wrx.18.1604166221960;
 Sat, 31 Oct 2020 10:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <8E455D54-FED4-4D06-8CB7-FC6291C64259@amacapital.net> <20201030120157.exz4rxmebruh7bgp@wittgenstein>
In-Reply-To: <20201030120157.exz4rxmebruh7bgp@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 31 Oct 2020 10:43:29 -0700
X-Gmail-Original-Message-ID: <CALCETrVk6OE8tC8C+DcKmKouU5PBnvFnVyZx54exBjOOM4aBMw@mail.gmail.com>
Message-ID: <CALCETrVk6OE8tC8C+DcKmKouU5PBnvFnVyZx54exBjOOM4aBMw@mail.gmail.com>
Subject: Re: [PATCH 00/34] fs: idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Barber <smbarber@chromium.org>,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 5:02 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Oct 29, 2020 at 02:58:55PM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Oct 28, 2020, at 5:35 PM, Christian Brauner <christian.brauner@ubu=
ntu.com> wrote:
> > >
> > > =EF=BB=BFHey everyone,
> > >
> > > I vanished for a little while to focus on this work here so sorry for
> > > not being available by mail for a while.
> > >
> > > Since quite a long time we have issues with sharing mounts between
> > > multiple unprivileged containers with different id mappings, sharing =
a
> > > rootfs between multiple containers with different id mappings, and al=
so
> > > sharing regular directories and filesystems between users with differ=
ent
> > > uids and gids. The latter use-cases have become even more important w=
ith
> > > the availability and adoption of systemd-homed (cf. [1]) to implement
> > > portable home directories.
> > >
> > > The solutions we have tried and proposed so far include the introduct=
ion
> > > of fsid mappings, a tiny overlay based filesystem, and an approach to
> > > call override creds in the vfs. None of these solutions have covered =
all
> > > of the above use-cases.
> > >
> > > The solution proposed here has it's origins in multiple discussions
> > > during Linux Plumbers 2017 during and after the end of the containers
> > > microconference.
> > > To the best of my knowledge this involved Aleksa, St=C3=A9phane, Eric=
, David,
> > > James, and myself. A variant of the solution proposed here has also b=
een
> > > discussed, again to the best of my knowledge, after a Linux conferenc=
e
> > > in St. Petersburg in Russia between Christoph, Tycho, and myself in 2=
017
> > > after Linux Plumbers.
> > > I've taken the time to finally implement a working version of this
> > > solution over the last weeks to the best of my abilities. Tycho has
> > > signed up for this sligthly crazy endeavour as well and he has helped
> > > with the conversion of the xattr codepaths.
> > >
> > > The core idea is to make idmappings a property of struct vfsmount
> > > instead of tying it to a process being inside of a user namespace whi=
ch
> > > has been the case for all other proposed approaches.
> > > It means that idmappings become a property of bind-mounts, i.e. each
> > > bind-mount can have a separate idmapping. This has the obvious advant=
age
> > > that idmapped mounts can be created inside of the initial user
> > > namespace, i.e. on the host itself instead of requiring the caller to=
 be
> > > located inside of a user namespace. This enables such use-cases as e.=
g.
> > > making a usb stick available in multiple locations with different
> > > idmappings (see the vfat port that is part of this patch series).
> > >
> > > The vfsmount struct gains a new struct user_namespace member. The
> > > idmapping of the user namespace becomes the idmapping of the mount. A
> > > caller that is either privileged with respect to the user namespace o=
f
> > > the superblock of the underlying filesystem or a caller that is
> > > privileged with respect to the user namespace a mount has been idmapp=
ed
> > > with can create a new bind-mount and mark it with a user namespace.
> >
> > So one way of thinking about this is that a user namespace that has an =
idmapped mount can, effectively, create or chown files with *any* on-disk u=
id or gid by doing it directly (if that uid exists in-namespace, which is l=
ikely for interesting ids like 0) or by creating a new userns with that id =
inside.
> >
> > For a file system that is private to a container, this seems moderately=
 safe, although this may depend on what exactly =E2=80=9Cprivate=E2=80=9D m=
eans. We probably want a mechanism such that, if you are outside the namesp=
ace, a reference to a file with the namespace=E2=80=99s vfsmnt does not con=
fer suid privilege.
> >
> > Imagine the following attack: user creates a namespace with a root user=
 and arranges to get an idmapped fs, e.g. by inserting an ext4 usb stick or=
 using whatever container management tool does this.  Inside the namespace,=
 the user creates a suid-root file.
> >
> > Now, outside the namespace, the user has privilege over the namespace. =
 (I=E2=80=99m assuming there is some tool that will idmap things in a names=
pace owned by an unprivileged user, which seems likely.). So the user makes=
 a new bind mount and if maps it to the init namespace. Game over.
> >
> > So I think we need to have some control to mitigate this in a comprehen=
sible way. A big hammer would be to require nosuid. A smaller hammer might =
be to say that you can=E2=80=99t create a new idmapped mount unless you hav=
e privilege over the userns that you want to use for the idmap and to say t=
hat a vfsmnt=E2=80=99s paths don=E2=80=99t do suid outside the idmap namesp=
ace.  We already do the latter for the vfsmnt=E2=80=99s mntns=E2=80=99s use=
rns.
>
> With this series, in order to create an idmapped mount the user must
> either be cap_sys_admin in the superblock of the underlying filesystem
> or if the mount is already idmapped and they want to create another
> idmapped mount from it they must have cap_sys_admin in the userns that
> the mount is currrently marked with. It is also not possible to change
> an idmapped mount once it has been idmapped, i.e. the user must create a
> new detached bind-mount first.

I think my attack might not work, but I also think I didn't explain it
very well.  Let me try again.  I'll also try to lay out what I
understand the rules of idmaps to be so that you can correct me when
I'm inevitable wrong :)

First, background: there are a bunch of user namespaces around.  Every
superblock has one, every idmapped mount has one, and every vfsmnt
also (indirectly) has one: mnt->mnt_ns->user_ns.  So, if you're
looking at a given vfsmnt, you have three user namespaces that are
relevant, in addition to whatever namespaces are active for the task
(or kernel thread) accessing that mount.  I'm wondering whether
mnt_user_ns() should possibly have a name that makes it clear that it
refers to the idmap namespace and not mnt->mnt_ns->user_ns.

So here's the attack.  An attacker with uid=3D1000 creates a userns N
(so the attacker owns the ns and 1000 outside maps to 0 inside).  N is
a child of init_user_ns.  Now the attacker creates a mount namespace M
inside the userns and, potentially with the help of a container
management tool, creates an idmapped filesystem mount F inside M.  So,
playing fast and loose with my ampersands:

F->mnt_ns =3D=3D M
F->mnt_ns->user_ns =3D=3D N
mnt_user_ns(F) =3D=3D N

I expect that this wouldn't be a particularly uncommon setup.  Now the
user has the ability to create files with inode->uid =3D=3D 0 and the SUID
bit set on their filesystem.  This isn't terribly different from FUSE,
except that the mount won't have nosuid set, whereas at least many
uses of unprivileged FUSE would have nosuid set.  So the thing that
makes me a little bit nervous.  But it actually seems likely that I
was wrong and this is okay.  Specifically, to exploit this using
kernel mechanisms, one would need to pass a mnt_may_suid() check,
which means that one would need to acquire a mount of F in one's
current mount namespace, and one would need one's current user
namespace to be init_ns (or something else sensitive).  But you
already need to own the namespace to create mounts, unless you have a
way to confuse some existing user tooling.  You would also need to be
in F's superblock's user_ns (second line of mnt_may_suid()), which
totally kills this type of attack if F's superblock is in the
container's user_ns, but I wouldn't count on that.

So maybe this is all fine.  I'll continue to try to poke holes in it,
but perhaps there aren't any holes to poke.  I'll also continue to try
to see if I can state the security properties of idmap in a way that
is clear and obviously has nice properties.

Why are you allowing the creation of a new idmapped mount if you have
cap_sys_admin over an existing idmap userns but not over the
superblock's userns?  I assume this is for a nested container use
case, but can you spell out a specific example usage?

--Andy
