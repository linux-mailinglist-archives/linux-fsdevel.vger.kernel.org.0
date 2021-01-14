Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4292F6874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbhANRzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 12:55:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbhANRzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:55:41 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l06pa-0006dG-Cq; Thu, 14 Jan 2021 17:54:46 +0000
Date:   Thu, 14 Jan 2021 18:54:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
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
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 00/42] idmapped mounts
Message-ID: <20210114175441.v5cbtzad3ejjcjsw@wittgenstein>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210114171241.GA1164240@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114171241.GA1164240@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:12:41AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 12, 2021 at 11:00:42PM +0100, Christian Brauner wrote:
> > Hey everyone,
> > 
> > The only major change is the inclusion of hch's patch to port XFS to
> > support idmapped mounts. Thanks to Christoph for doing that work.
> 
> Yay :)
> 
> > (For a full list of major changes between versions see the end of this
> >  cover letter.
> >  Please also note the large xfstests testsuite in patch 42 that has been
> >  kept as part of this series. It verifies correct vfs behavior with and
> >  without idmapped mounts including covering newer vfs features such as
> >  io_uring.
> >  I currently still plan to target the v5.12 merge window.)
> > 
> > With this patchset we make it possible to attach idmappings to mounts,
> > i.e. simply put different bind mounts can expose the same file or
> > directory with different ownership.
> > Shifting of ownership on a per-mount basis handles a wide range of
> > long standing use-cases. Here are just a few:
> > - Shifting of a subset of ownership-less filesystems (vfat) for use by
> >   multiple users, effectively allowing for DAC on such devices
> >   (systemd, Android, ...)
> > - Allow remapping uid/gid on external filesystems or paths (USB sticks,
> >   network filesystem, ...) to match the local system's user and groups.
> >   (David Howells intends to port AFS as a first candidate.)
> > - Shifting of a container rootfs or base image without having to mangle
> >   every file (runc, Docker, containerd, k8s, LXD, systemd ...)
> > - Sharing of data between host or privileged containers with
> >   unprivileged containers (runC, Docker, containerd, k8s, LXD, ...)
> > - Data sharing between multiple user namespaces with incompatible maps
> >   (LXD, k8s, ...)
> 
> That sounds neat.  AFAICT, the VFS passes the filesystem a mount userns
> structure, which is then carried down the call stack to whatever
> functions actually care about mapping kernel [ug]ids to their ondisk
> versions?

Yes. This requires not too many changes to the actual filesystems as you
can see from the xfs conversion that Christoph has done.

> 
> Does quota still work after this patchset is applied?  There isn't any
> mention of that in the cover letter and I don't see a code patch, so
> does that mean everything just works?  I'm particularly curious about

The most interesting quota codepaths I audited are dquot_transfer that
transfers quota from one inode to another one during setattr. That
happens via a struct iattr which will already contain correctly
translated ia_uid and ia_gid values according to the mount the caller is
coming from. I'll take another close look at that now and add tests for
that if I can find some in xfstests.

> whether there can exist processes with CAP_SYS_ADMIN and an idmapped
> mount?  Syscalls like bulkstat and quotactl present file [ug]ids to

Yes, that should be possible.

> programs, but afaict there won't be any translating going on?

quotactl operates on the superblock. So the caller would need a mapping
in the user namespace of the superblock. That doesn't need to change.
But we could in the future extend this to be on a per-mount basis if
this was a desired use-case. I don't think it needs to happen right now
though.

> 
> (To be fair, bulkstat is an xfs-only thing, but quota control isn't.)

I'm certain we'll find more things to cover after the first version has
landed. :)
We for sure won't cover it all in the first iteration.

> 
> I'll start skimming the patchset...

Thanks!
Christian
