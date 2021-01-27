Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC697305255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 06:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhA0FqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 00:46:09 -0500
Received: from mail.hallyn.com ([178.63.66.53]:60128 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235793AbhA0Fks (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:40:48 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 93A58864; Tue, 26 Jan 2021 23:40:00 -0600 (CST)
Date:   Tue, 26 Jan 2021 23:40:00 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
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
Subject: Re: [PATCH v6 00/40] idmapped mounts
Message-ID: <20210127054000.GA30832@mail.hallyn.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:19:19PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> The only major change is the updated version of hch's pach to port xfs
> to support idmapped mounts. Thanks again to Christoph for doing that
> work.
> (Otherwise Acked-bys and Reviewed-bys were added and the tree reordered
>  to decouple filesystem specific conversion from the vfs work so they
>  can proceed independent.
>  For a full list of major changes between versions see the end of this
>  cover letter. Please also note the large xfstests testsuite in patch 42
>  that has been kept as part of this series. It verifies correct vfs
>  behavior with and without idmapped mounts including covering newer vfs
>  features such as io_uring.
>  I currently still plan to target the v5.12 merge window.)
> 
> With this patchset we make it possible to attach idmappings to mounts,
> i.e. simply put different bind mounts can expose the same file or
> directory with different ownership.
> Shifting of ownership on a per-mount basis handles a wide range of
> long standing use-cases. Here are just a few:
> - Shifting of a subset of ownership-less filesystems (vfat) for use by
>   multiple users, effectively allowing for DAC on such devices
>   (systemd, Android, ...)
> - Allow remapping uid/gid on external filesystems or paths (USB sticks,
>   network filesystem, ...) to match the local system's user and groups.
>   (David Howells intends to port AFS as a first candidate.)
> - Shifting of a container rootfs or base image without having to mangle
>   every file (runc, Docker, containerd, k8s, LXD, systemd ...)
> - Sharing of data between host or privileged containers with
>   unprivileged containers (runC, Docker, containerd, k8s, LXD, ...)
> - Data sharing between multiple user namespaces with incompatible maps
>   (LXD, k8s, ...)
> 
> There has been significant interest in this patchset as evidenced by
> user commenting on previous version of this patchset. They include
> containerd, ChromeOS, systemd, LXD and a range of others. There is
> already a patchset up for containerd, the default Kubernetes container
> runtime https://github.com/containerd/containerd/pull/4734
> to make use of this. systemd intends to use it in their systemd-homed
> implementation for portable home directories. ChromeOS wants to make use
> of it to share data between the host and the Linux containers they run
> on Chrome- and Pixelbooks. There's also a few talks that of people who
> are going to make use of this. The most recent one was a CNCF webinar
> https://www.cncf.io/wp-content/uploads/2020/12/Rootless-Containers-in-Gitpod.pdf
> and upcoming talk during FOSDEM.
> (Fwiw, for fun and since I wanted to do this for a long time I've ported
>  my home directory to be completely portable with a simple service file
>  that now mounts my home directory on an ext4 formatted usb stick with
>  an id mapping mapping all files to the random uid I'm assigned at
>  login.)
> 
> Making it possible to share directories and mounts between users with
> different uids and gids is itself quite an important use-case in
> distributed systems environments. It's of course especially useful in
> general for portable usb sticks, sharing data between multiple users in,
> and sharing home directories between multiple users. The last example is
> now elegantly expressed in systemd's homed concept for portable home
> directories. As mentioned above, idmapped mounts also allow data from
> the host to be shared with unprivileged containers, between privileged
> and unprivileged containers simultaneously and in addition also between
> unprivileged containers with different idmappings whenever they are used
> to isolate one container completely from another container.
> 
> We have implemented and proposed multiple solutions to this before. This
> included the introduction of fsid mappings, a tiny filesystem I've
> authored with Seth Forshee that is currently carried in Ubuntu that has
> shown to be the wrong approach, and the conceptual hack of calling
> override creds directly in the vfs. In addition, to some of these
> solutions being hacky none of these solutions have covered all of the
> above use-cases.
> 
> Idmappings become a property of struct vfsmount instead of tying it to a
> process being inside of a user namespace which has been the case for all
> other proposed approaches. It also allows to pass down the user
> namespace into the filesystems which is a clean way instead of violating
> calling conventions by strapping the user namespace information that is
> a property of the mount to the caller's credentials or similar hacks.
> Each mount can have a separate idmapping and idmapped mounts can even be
> created in the initial user namespace unblocking a range of use-cases.
> 
> To this end the vfsmount struct gains a new struct user_namespace
> member. The idmapping of the user namespace becomes the idmapping of the
> mount. A caller that is privileged with respect to the user namespace of
> the superblock of the underlying filesystem can create an idmapped
> mount. In the future, we can enable unprivileged use-cases by checking
> whether the caller is privileged wrt to the user namespace that an
> already idmapped mount has been marked with, allowing them to change the
> idmapping. For now, keep things simple until the need arises.
> Note, that with syscall interception it is already possible to intercept
> idmapped mount requests from unprivileged containers and handle them in
> a sufficiently privileged container manager. Support for this is already
> available in LXD and will be available in runC where syscall
> interception is currently in the process of becoming part of the runtime
> spec: https://github.com/opencontainers/runtime-spec/pull/1074.
> 
> The user namespace the mount will be marked with can be specified by
> passing a file descriptor refering to the user namespace as an argument
> to the new mount_setattr() syscall together with the new
> MOUNT_ATTR_IDMAP flag. By default vfsmounts are marked with the initial
> user namespace and no behavioral or performance changes are observed.
> All mapping operations are nops for the initial user namespace. When a
> file/inode is accessed through an idmapped mount the i_uid and i_gid of
> the inode will be remapped according to the user namespace the mount has
> been marked with.
> 
> In order to support idmapped mounts, filesystems need to be changed and
> mark themselves with the FS_ALLOW_IDMAP flag in fs_flags. The initial
> version contains fat, ext4, and xfs including a list of examples.
> But patches for other filesystems are actively worked on and will be
> sent out separately. We are here to see this through and there are
> multiple people involved in converting filesystems. So filesystem
> developers are not left alone with this and are provided with a large
> testsuite to verify that their port is correct.
> 
> There is a simple tool available at
> https://github.com/brauner/mount-idmapped that allows to create idmapped
> mounts so people can play with this patch series. Here are a few
> illustrations:
> 
> 1. Create a simple idmapped mount of another user's home directory
> 
> u1001@f2-vm:/$ sudo ./mount-idmapped --map-mount b:1000:1001:1 /home/ubuntu/ /mnt
> u1001@f2-vm:/$ ls -al /home/ubuntu/
> total 28
> drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 22:07 .
> drwxr-xr-x 4 root   root   4096 Oct 28 04:00 ..
> -rw------- 1 ubuntu ubuntu 3154 Oct 28 22:12 .bash_history
> -rw-r--r-- 1 ubuntu ubuntu  220 Feb 25  2020 .bash_logout
> -rw-r--r-- 1 ubuntu ubuntu 3771 Feb 25  2020 .bashrc
> -rw-r--r-- 1 ubuntu ubuntu  807 Feb 25  2020 .profile
> -rw-r--r-- 1 ubuntu ubuntu    0 Oct 16 16:11 .sudo_as_admin_successful
> -rw------- 1 ubuntu ubuntu 1144 Oct 28 00:43 .viminfo

So I assume this falls under the buyer beware warning, but it's
probably important to warn people loudly of the fact that, at this
point, the user with uid 1001 can chmod u+s any binary under /mnt
and then run it from /home/ubuntu with euid=1000.  In other words,
that while this has excellent uses, if you *can* use shared group
membership, you should :)

Very cool though.
