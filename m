Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7D29F3C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJ2SGc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 14:06:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ2SGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:06:21 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stgraber@ubuntu.com>)
        id 1kYCI0-0003zM-Of
        for linux-fsdevel@vger.kernel.org; Thu, 29 Oct 2020 18:04:44 +0000
Received: by mail-ed1-f49.google.com with SMTP id dg9so3934051edb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 11:04:44 -0700 (PDT)
X-Gm-Message-State: AOAM533ih+a6/kgjcUDDKU1TqVmpsDG0AL8oAz1fz9LHg4N2s2Soiitc
        m3JuDpa7hSLcaznW4Zz2hlZyWVD6aIb4ZyrU66GHUA==
X-Google-Smtp-Source: ABdhPJzOR+GvYdcxThjeYM4q+BnWieqIoL3kVTr7F9zyXSA8NyVuuYCL1zVggZkDC4pHflRK6EVUPiYtBnL0ZVxrdaQ=
X-Received: by 2002:ac2:5c49:: with SMTP id s9mr1955451lfp.14.1603994683268;
 Thu, 29 Oct 2020 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org> <20201029161231.GA108315@cisco> <87blglc77y.fsf@x220.int.ebiederm.org>
In-Reply-To: <87blglc77y.fsf@x220.int.ebiederm.org>
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Thu, 29 Oct 2020 14:04:31 -0400
X-Gmail-Original-Message-ID: <CA+enf=vn1TgdLx9TR3m=wdBzbZxRbxK4NFY4NdYn0v5gzewCyw@mail.gmail.com>
Message-ID: <CA+enf=vn1TgdLx9TR3m=wdBzbZxRbxK4NFY4NdYn0v5gzewCyw@mail.gmail.com>
Subject: Re: [PATCH 00/34] fs: idmapped mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Barber <smbarber@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:45 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Tycho Andersen <tycho@tycho.pizza> writes:
>
> > Hi Eric,
> >
> > On Thu, Oct 29, 2020 at 10:47:49AM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
> >>
> >> > Hey everyone,
> >> >
> >> > I vanished for a little while to focus on this work here so sorry for
> >> > not being available by mail for a while.
> >> >
> >> > Since quite a long time we have issues with sharing mounts between
> >> > multiple unprivileged containers with different id mappings, sharing a
> >> > rootfs between multiple containers with different id mappings, and also
> >> > sharing regular directories and filesystems between users with different
> >> > uids and gids. The latter use-cases have become even more important with
> >> > the availability and adoption of systemd-homed (cf. [1]) to implement
> >> > portable home directories.
> >>
> >> Can you walk us through the motivating use case?
> >>
> >> As of this year's LPC I had the distinct impression that the primary use
> >> case for such a feature was due to the RLIMIT_NPROC problem where two
> >> containers with the same users still wanted different uid mappings to
> >> the disk because the users were conflicting with each other because of
> >> the per user rlimits.
> >>
> >> Fixing rlimits is straight forward to implement, and easier to manage
> >> for implementations and administrators.
> >
> > Our use case is to have the same directory exposed to several
> > different containers which each have disjoint ID mappings.
>
> Why do the you have disjoint ID mappings for the users that are writing
> to disk with the same ID?
>
> >> Reading up on systemd-homed it appears to be a way to have encrypted
> >> home directories.  Those home directories can either be encrypted at the
> >> fs or at the block level.  Those home directories appear to have the
> >> goal of being luggable between systems.  If the systems in question
> >> don't have common administration of uids and gids after lugging your
> >> encrypted home directory to another system chowning the files is
> >> required.
> >>
> >> Is that the use case you are looking at removing the need for
> >> systemd-homed to avoid chowning after lugging encrypted home directories
> >> from one system to another?  Why would it be desirable to avoid the
> >> chown?
> >
> > Not just systemd-homed, but LXD has to do this,
>
> I asked why the same disk users are assigned different kuids and the
> only reason I have heard that LXD does this is the RLIMIT_NPROC problem.
>
> Perhaps there is another reason.
>
> In part this is why I am eager to hear peoples use case, and why I was
> trying very hard to make certain we get the requirements.
>
> I want the real requirements though and some thought, not just we did
> this and it hurts.  Changning the uids on write is a very hard problem,
> and not just in implementating it but also in maintaining and
> understanding what is going on.

The most common cases where shiftfs is used or where folks would like
to use it today are (by importance):
 - Fast container creation (by not having to uid/gid shift all files
in the downloaded image)
 - Sharing data between the host system and a container (some paths
under /home being the most common)
 - Sharing data between unprivileged containers with a disjointed map
 - Sharing data between multiple containers, some privileged, some unprivileged

Fixing the ulimit issue only takes care of one of those (3rd item), it
does not solve any of the other cases.

The first item on there alone can be quite significant. Creation and
startup of a regular Debian container on my system takes around 500ms
when shiftfs is used (btrfs/lvm/zfs copy-on-write clone of the image,
setup shiftfs, start container) compared to 2-3s when running without
it (same clone, followed by rewrite of all uid/gid present on the fs,
including acls and capabilities, then start container). And that's on
a fast system with an NVME SSD and a small rootfs. We have had reports
of a few users running on slow spinning rust with large containers
where shifting can take several minutes.

The second item can technically be worked around without shifted
bind-mounts by doing userns map hole punching, mapping the user's
uid/gid from the host straight into the container. The downside to
this is that another shifting pass becomes needed for any file outside
of the bind-mounted path (or it would become owned by -1/-1) and it's
very much not dynamic, requiring the container be stopped, config
updated by the user, /etc/subuid and subgid maps being updated and
container started back up. If you need another user/group be exposed,
start all over again...
This is far more complex, slow and disruptive than the shifted
approach where we just need to do:
   lxc config device add MY-CONTAINER home disk source=/home
path=/home shift=true
To inject a new mount of /home from the host into the container with a
shifting layer in place, no need to reconfig subuid/subgid, no need to
re-create the userns to update the mapping and no need to go through
the container's rootfs for any file which may now need remapping
because of the map change.

Stéphane

> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
