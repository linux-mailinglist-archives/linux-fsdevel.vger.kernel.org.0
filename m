Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6E2A476F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgKCOK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgKCOKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:10:48 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E1C061A47
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:10:48 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so18296362edj.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y8WQjpT9rqVrgeh99s8m7L7lW+jgLfIjyGz2M8+krP0=;
        b=jNSrYWNMri4UzTfQTwvUoeI3d9PbxAntszBtbkOHWPbsmFNLXoekIJ8TcfDFJbJf7v
         6+eYLKBEUBAXwADA9DJI10J7imuIzSuwLQhtXLJY1nc7fmB3dMavlYA1Xmy9wmU6aG0F
         m9nefJssTHLgeDNMLEKBtF2hV/CbFCCq5QOzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y8WQjpT9rqVrgeh99s8m7L7lW+jgLfIjyGz2M8+krP0=;
        b=PovolclPuyPM4GWpXiHMpzeE8k9CDsZqQL3rT20oKlfcGlxgUVGjx/zDTR5p0pfZ9k
         c37tN0ejwSlGlTsdVkzbwtb6qPRhLYSzryEqIKzNIXTgl5Y88JfIx8bgTwIvNadONydz
         9WHQtnsj41Tqoc7s6snawf+c/BGrLN3Ano8LMW1f/8ZMlzxuVZ91UO1S9i9vCp+PSQNO
         NnAJdQ7e2QfQUaqJ3v0fwDTwxh2FJ6Q4Dccy0hrO/ECq+s068fcwUKgX3HYZU5Y+VetD
         PoeIhE4MqmAPvkxHPrPgOnp7iWwIoe8+drPWi/8tSPiRRMgz7FUXDMBZSip5aXDP1Ob6
         rDQQ==
X-Gm-Message-State: AOAM5321Vs9BomslMeFIKALMGSh+16vGaqiLrcLP/AjOBgAjxg61/UCH
        9MWHXtf5nC2iA88f997xd321riYS9Yfp9/RZFLOCFw==
X-Google-Smtp-Source: ABdhPJwp4QL8RwmQmcT2CoPcUplHSU9HiByLsXAEntwM01IPEN+3MiJMYkcJQ6Od81V70aDSuFwsTxILAnA/OMfjXrI=
X-Received: by 2002:a05:6402:a57:: with SMTP id bt23mr10741907edb.62.1604412647178;
 Tue, 03 Nov 2020 06:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org> <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
 <87361xdm4c.fsf@x220.int.ebiederm.org>
In-Reply-To: <87361xdm4c.fsf@x220.int.ebiederm.org>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Tue, 3 Nov 2020 15:10:35 +0100
Message-ID: <CADZs7q4abuN6n8HMrpe2R2kRBUDVPoYRNpezKk4cvXRk7CVHng@mail.gmail.com>
Subject: Re: [PATCH 00/34] fs: idmapped mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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
        Theodore Tso <tytso@mit.edu>, Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 5:37 PM Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>
> Aleksa Sarai <cyphar@cyphar.com> writes:
>
> > On 2020-10-29, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
> >>
> >> > Hey everyone,
> >> >
> >> > I vanished for a little while to focus on this work here so sorry fo=
r
> >> > not being available by mail for a while.
> >> >
> >> > Since quite a long time we have issues with sharing mounts between
> >> > multiple unprivileged containers with different id mappings, sharing=
 a
> >> > rootfs between multiple containers with different id mappings, and a=
lso
> >> > sharing regular directories and filesystems between users with diffe=
rent
> >> > uids and gids. The latter use-cases have become even more important =
with
> >> > the availability and adoption of systemd-homed (cf. [1]) to implemen=
t
> >> > portable home directories.
> >>
> >> Can you walk us through the motivating use case?
> >>
> >> As of this year's LPC I had the distinct impression that the primary u=
se
> >> case for such a feature was due to the RLIMIT_NPROC problem where two
> >> containers with the same users still wanted different uid mappings to
> >> the disk because the users were conflicting with each other because of
> >> the per user rlimits.
> >>
> >> Fixing rlimits is straight forward to implement, and easier to manage
> >> for implementations and administrators.
> >
> > This is separate to the question of "isolated user namespaces" and
> > managing different mappings between containers. This patchset is solvin=
g
> > the same problem that shiftfs solved -- sharing a single directory tree
> > between containers that have different ID mappings. rlimits (nor any of
> > the other proposals we discussed at LPC) will help with this problem.
>
> First and foremost: A uid shift on write to a filesystem is a security
> bug waiting to happen.  This is especially in the context of facilities
> like iouring, that play very agressive games with how process context
> makes it to  system calls.
>
> The only reason containers were not immediately exploitable when iouring
> was introduced is because the mechanisms are built so that even if
> something escapes containment the security properties still apply.
> Changes to the uid when writing to the filesystem does not have that
> property.  The tiniest slip in containment will be a security issue.
>
> This is not even the least bit theoretical.  I have seem reports of how
> shitfs+overlayfs created a situation where anyone could read
> /etc/shadow.
>
> If you are going to write using the same uid to disk from different
> containers the question becomes why can't those containers configure
> those users to use the same kuid?
>
> What fixing rlimits does is it fixes one of the reasons that different
> containers could not share the same kuid for users that want to write to
> disk with the same uid.
>
>
> I humbly suggest that it will be more secure, and easier to maintain for
> both developers and users if we fix the reasons people want different
> containers to have the same user running with different kuids.
>
> If not what are the reasons we fundamentally need the same on-disk user
> using multiple kuids in the kernel?

I would like to use this patch set in the context of Kubernetes. I
described my two possible setups in
https://www.spinics.net/lists/linux-containers/msg36537.html:

1. Each Kubernetes pod has its own userns but with the same user id mapping
2. Each Kubernetes pod has its own userns with non-overlapping user id
mapping (providing additional isolation between pods)

But even in the setup where all pods run with the same id mappings,
this patch set is still useful to me for 2 reasons:

1. To avoid the expensive recursive chown of the rootfs. We cannot
necessarily extract the tarball directly with the right uids because
we might use the same container image for privileged containers (with
the host userns) and unprivileged containers (with a new userns), so
we have at least 2 =E2=80=9Cmappings=E2=80=9D (taking more time and resulti=
ng in more
storage space). Although the =E2=80=9Cmetacopy=E2=80=9D mount option in ove=
rlayfs
helps to make the recursive chown faster, it can still take time with
large container images with lots of files. I=E2=80=99d like to use this pat=
ch
set to set up the root fs in constant time.

2. To manage large external volumes (NFS or other filesystems). Even
if admins can decide to use the same kuid on all the nodes of the
Kubernetes cluster, this is impractical for migration. People can have
existing Kubernetes clusters (currently without using user namespaces)
and large NFS volumes. If they want to switch to a new version of
Kubernetes with the user namespace feature enabled, they would need to
recursively chown all the files on the NFS shares. This could take
time on large filesystems and realistically, we want to support
rolling updates where some nodes use the previous version without user
namespaces and new nodes are progressively migrated to the new userns
with the new id mapping. If both sets of nodes use the same NFS share,
that can=E2=80=99t work.

Alban
