Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52472F6727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhANRN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 12:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhANRNZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:13:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14C6723B44;
        Thu, 14 Jan 2021 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644362;
        bh=yheaKMHMla9YzK/iec7jHjLwLb88iZgiZgz44yA5VAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mo/fG+kXMSKWZPMhGNiDG4MQ8jqd5FxwGAqAD5wp8WBu/oKgiJeUW1M4ERegPKgRe
         5pEL6jC8RuucLh5w9/YXt6LcqrbUtFNiElyvejv3acDsjmpTu/pHpEFundveaj9lDV
         SbwBmYM2JjOky03Id2h7hEU9rWVYqhYgvo/wbLlcWaJSHvUT6XJzYKwmI/DP7RKmoI
         PzA2a67SiIILhy/Elqn80K7EjvzxPlNWad4G8zm8PGEoYI5APH3C9VDT+xxznKp6Zt
         DF8stY/OvLeLBWsEcocI9Tr/yBmkbS/5jxGSXWg7NvpPmEASZJIBq8SsNIeQGJ17kA
         H26WQ3tNexT0g==
Date:   Thu, 14 Jan 2021 09:12:41 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Subject: Re: [PATCH v5 00/42] idmapped mounts
Message-ID: <20210114171241.GA1164240@magnolia>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:00:42PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> The only major change is the inclusion of hch's patch to port XFS to
> support idmapped mounts. Thanks to Christoph for doing that work.

Yay :)

> (For a full list of major changes between versions see the end of this
>  cover letter.
>  Please also note the large xfstests testsuite in patch 42 that has been
>  kept as part of this series. It verifies correct vfs behavior with and
>  without idmapped mounts including covering newer vfs features such as
>  io_uring.
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

That sounds neat.  AFAICT, the VFS passes the filesystem a mount userns
structure, which is then carried down the call stack to whatever
functions actually care about mapping kernel [ug]ids to their ondisk
versions?

Does quota still work after this patchset is applied?  There isn't any
mention of that in the cover letter and I don't see a code patch, so
does that mean everything just works?  I'm particularly curious about
whether there can exist processes with CAP_SYS_ADMIN and an idmapped
mount?  Syscalls like bulkstat and quotactl present file [ug]ids to
programs, but afaict there won't be any translating going on?

(To be fair, bulkstat is an xfs-only thing, but quota control isn't.)

I'll start skimming the patchset...

--D

> 
> There has been significant interest in this patchset as evidenced by
> user commenting on previous version of this patchset. They include
> containerd, ChromeOS, systemd, LXD and a range of others. There is
> already a patchset up for containerd, the default Kubernetes container
> runtime https://github.com/containerd/containerd/pull/4734
> to make use of this. systemd intends to use it in their systemd-homed
> implementation for portable home directories. ChromeOS wants to make use
> of it to share data between the host and the Linux containers they run
> on Chrome- and Pixelbooks.
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
> u1001@f2-vm:/$ ls -al /mnt/
> total 28
> drwxr-xr-x  2 u1001 u1001 4096 Oct 28 22:07 .
> drwxr-xr-x 29 root  root  4096 Oct 28 22:01 ..
> -rw-------  1 u1001 u1001 3154 Oct 28 22:12 .bash_history
> -rw-r--r--  1 u1001 u1001  220 Feb 25  2020 .bash_logout
> -rw-r--r--  1 u1001 u1001 3771 Feb 25  2020 .bashrc
> -rw-r--r--  1 u1001 u1001  807 Feb 25  2020 .profile
> -rw-r--r--  1 u1001 u1001    0 Oct 16 16:11 .sudo_as_admin_successful
> -rw-------  1 u1001 u1001 1144 Oct 28 00:43 .viminfo
> u1001@f2-vm:/$ touch /mnt/my-file
> u1001@f2-vm:/$ setfacl -m u:1001:rwx /mnt/my-file
> u1001@f2-vm:/$ sudo setcap -n 1001 cap_net_raw+ep /mnt/my-file
> u1001@f2-vm:/$ ls -al /mnt/my-file
> -rw-rwxr--+ 1 u1001 u1001 0 Oct 28 22:14 /mnt/my-file
> u1001@f2-vm:/$ ls -al /home/ubuntu/my-file
> -rw-rwxr--+ 1 ubuntu ubuntu 0 Oct 28 22:14 /home/ubuntu/my-file
> u1001@f2-vm:/$ getfacl /mnt/my-file
> getfacl: Removing leading '/' from absolute path names
> # file: mnt/my-file
> # owner: u1001
> # group: u1001
> user::rw-
> user:u1001:rwx
> group::rw-
> mask::rwx
> other::r--
> u1001@f2-vm:/$ getfacl /home/ubuntu/my-file
> getfacl: Removing leading '/' from absolute path names
> # file: home/ubuntu/my-file
> # owner: ubuntu
> # group: ubuntu
> user::rw-
> user:ubuntu:rwx
> group::rw-
> mask::rwx
> other::r--
> 
> 2. Create mapping of the whole ext4 rootfs without a mapping for uid and gid 0
> 
> ubuntu@f2-vm:~$ sudo /mount-idmapped --map-mount b:1:1:65536 / /mnt/
> ubuntu@f2-vm:~$ findmnt | grep mnt
> └─/mnt                                /dev/sda2  ext4       rw,relatime
>   └─/mnt/mnt                          /dev/sda2  ext4       rw,relatime
> ubuntu@f2-vm:~$ sudo mkdir /AS-ROOT-CAN-CREATE
> ubuntu@f2-vm:~$ sudo mkdir /mnt/AS-ROOT-CANT-CREATE
> mkdir: cannot create directory ‘/mnt/AS-ROOT-CANT-CREATE’: Value too large for defined data type
> ubuntu@f2-vm:~$ mkdir /mnt/home/ubuntu/AS-USER-1000-CAN-CREATE
> 
> 3. Create a vfat usb mount and expose to user 1001 and 5000
> 
> ubuntu@f2-vm:/$ sudo mount /dev/sdb /mnt
> ubuntu@f2-vm:/$ findmnt  | grep mnt
> └─/mnt                                /dev/sdb vfat       rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro
> ubuntu@f2-vm:/$ ls -al /mnt
> total 12
> drwxr-xr-x  2 root root 4096 Jan  1  1970 .
> drwxr-xr-x 34 root root 4096 Oct 28 22:24 ..
> -rwxr-xr-x  1 root root    4 Oct 28 03:44 aaa
> -rwxr-xr-x  1 root root    0 Oct 28 01:09 bbb
> ubuntu@f2-vm:/$ sudo /mount-idmapped --map-mount b:0:1001:1 /mnt /mnt-1001/
> ubuntu@f2-vm:/$ ls -al /mnt-1001/
> total 12
> drwxr-xr-x  2 u1001 u1001 4096 Jan  1  1970 .
> drwxr-xr-x 34 root  root  4096 Oct 28 22:24 ..
> -rwxr-xr-x  1 u1001 u1001    4 Oct 28 03:44 aaa
> -rwxr-xr-x  1 u1001 u1001    0 Oct 28 01:09 bbb
> ubuntu@f2-vm:/$ sudo /mount-idmapped --map-mount b:0:5000:1 /mnt /mnt-5000/
> ubuntu@f2-vm:/$ ls -al /mnt-5000/
> total 12
> drwxr-xr-x  2 5000 5000 4096 Jan  1  1970 .
> drwxr-xr-x 34 root root 4096 Oct 28 22:24 ..
> -rwxr-xr-x  1 5000 5000    4 Oct 28 03:44 aaa
> -rwxr-xr-x  1 5000 5000    0 Oct 28 01:09 bbb
> 
> 4. Create an idmapped rootfs mount for a container
> 
> root@f2-vm:~# ls -al /var/lib/lxc/f2/rootfs/
> total 68
> drwxr-xr-x 17 20000 20000 4096 Sep 24 07:48 .
> drwxrwx---  3 20000 20000 4096 Oct 16 19:26 ..
> lrwxrwxrwx  1 20000 20000    7 Sep 24 07:43 bin -> usr/bin
> drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 boot
> drwxr-xr-x  3 20000 20000 4096 Oct 16 19:26 dev
> drwxr-xr-x 61 20000 20000 4096 Oct 16 19:26 etc
> drwxr-xr-x  3 20000 20000 4096 Sep 24 07:45 home
> lrwxrwxrwx  1 20000 20000    7 Sep 24 07:43 lib -> usr/lib
> lrwxrwxrwx  1 20000 20000    9 Sep 24 07:43 lib32 -> usr/lib32
> lrwxrwxrwx  1 20000 20000    9 Sep 24 07:43 lib64 -> usr/lib64
> lrwxrwxrwx  1 20000 20000   10 Sep 24 07:43 libx32 -> usr/libx32
> drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 media
> drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 mnt
> drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 opt
> drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 proc
> drwx------  2 20000 20000 4096 Sep 24 07:43 root
> drwxr-xr-x  2 20000 20000 4096 Sep 24 07:45 run
> lrwxrwxrwx  1 20000 20000    8 Sep 24 07:43 sbin -> usr/sbin
> drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 srv
> drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 sys
> drwxrwxrwt  2 20000 20000 4096 Sep 24 07:44 tmp
> drwxr-xr-x 13 20000 20000 4096 Sep 24 07:43 usr
> drwxr-xr-x 12 20000 20000 4096 Sep 24 07:44 var
> root@f2-vm:~# /mount-idmapped --map-mount b:20000:10000:100000 /var/lib/lxc/f2/rootfs/ /mnt
> root@f2-vm:~# ls -al /mnt
> total 68
> drwxr-xr-x 17 10000 10000 4096 Sep 24 07:48 .
> drwxr-xr-x 34 root  root  4096 Oct 28 22:24 ..
> lrwxrwxrwx  1 10000 10000    7 Sep 24 07:43 bin -> usr/bin
> drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 boot
> drwxr-xr-x  3 10000 10000 4096 Oct 16 19:26 dev
> drwxr-xr-x 61 10000 10000 4096 Oct 16 19:26 etc
> drwxr-xr-x  3 10000 10000 4096 Sep 24 07:45 home
> lrwxrwxrwx  1 10000 10000    7 Sep 24 07:43 lib -> usr/lib
> lrwxrwxrwx  1 10000 10000    9 Sep 24 07:43 lib32 -> usr/lib32
> lrwxrwxrwx  1 10000 10000    9 Sep 24 07:43 lib64 -> usr/lib64
> lrwxrwxrwx  1 10000 10000   10 Sep 24 07:43 libx32 -> usr/libx32
> drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 media
> drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 mnt
> drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 opt
> drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 proc
> drwx------  2 10000 10000 4096 Sep 24 07:43 root
> drwxr-xr-x  2 10000 10000 4096 Sep 24 07:45 run
> lrwxrwxrwx  1 10000 10000    8 Sep 24 07:43 sbin -> usr/sbin
> drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 srv
> drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 sys
> drwxrwxrwt  2 10000 10000 4096 Sep 24 07:44 tmp
> drwxr-xr-x 13 10000 10000 4096 Sep 24 07:43 usr
> drwxr-xr-x 12 10000 10000 4096 Sep 24 07:44 var
> root@f2-vm:~# lxc-start f2 # uses /mnt as rootfs
> root@f2-vm:~# lxc-attach f2 -- cat /proc/1/uid_map
>          0      10000      10000
> root@f2-vm:~# lxc-attach f2 -- cat /proc/1/gid_map
>          0      10000      10000
> root@f2-vm:~# lxc-attach f2 -- ls -al /
> total 52
> drwxr-xr-x  17 root   root    4096 Sep 24 07:48 .
> drwxr-xr-x  17 root   root    4096 Sep 24 07:48 ..
> lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
> drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
> drwxr-xr-x   5 root   root     500 Oct 28 23:39 dev
> drwxr-xr-x  61 root   root    4096 Oct 28 23:39 etc
> drwxr-xr-x   3 root   root    4096 Sep 24 07:45 home
> lrwxrwxrwx   1 root   root       7 Sep 24 07:43 lib -> usr/lib
> lrwxrwxrwx   1 root   root       9 Sep 24 07:43 lib32 -> usr/lib32
> lrwxrwxrwx   1 root   root       9 Sep 24 07:43 lib64 -> usr/lib64
> lrwxrwxrwx   1 root   root      10 Sep 24 07:43 libx32 -> usr/libx32
> drwxr-xr-x   2 root   root    4096 Sep 24 07:43 media
> drwxr-xr-x   2 root   root    4096 Sep 24 07:43 mnt
> drwxr-xr-x   2 root   root    4096 Sep 24 07:43 opt
> dr-xr-xr-x 232 nobody nogroup    0 Oct 28 23:39 proc
> drwx------   2 root   root    4096 Oct 28 23:41 root
> drwxr-xr-x  12 root   root     360 Oct 28 23:39 run
> lrwxrwxrwx   1 root   root       8 Sep 24 07:43 sbin -> usr/sbin
> drwxr-xr-x   2 root   root    4096 Sep 24 07:43 srv
> dr-xr-xr-x  13 nobody nogroup    0 Oct 28 23:39 sys
> drwxrwxrwt  11 root   root    4096 Oct 28 23:40 tmp
> drwxr-xr-x  13 root   root    4096 Sep 24 07:43 usr
> drwxr-xr-x  12 root   root    4096 Sep 24 07:44 var
> root@f2-vm:~# lxc-attach f2 -- ls -al /my-file
> -rw-r--r-- 1 root root 0 Oct 28 23:43 /my-file
> root@f2-vm:~# ls -al /var/lib/lxc/f2/rootfs/my-file
> -rw-r--r-- 1 20000 20000 0 Oct 28 23:43 /var/lib/lxc/f2/rootfs/my-file
> 
> I'd like to say thanks to:
> Al for pointing me into the direction to avoid inode alias issues during
> lookup. David for various discussions around this. Christoph for porting
> xfs, providing good reviews and for being involved in the original idea.
> Tycho for helping with this series and on future patches to convert
> filesystems. Alban Crequy and the Kinvolk peeps located just a few
> streets away from me in Berlin for providing use-case discussions and
> writing patches for containerd. Stéphane for his invaluable input on
> many things and level head and enabling me to work on this. Amir for
> explaining and discussing aspects of overlayfs with me. I'd like to
> especially thank Seth Forshee. He provided a lot of good analysis,
> suggestions, and participated in short-notice discussions in both chat
> and video for some nitty-gritty technical details.
> 
> This series can be found and pulled from the three usual locations:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=idmapped_mounts
> https://github.com/brauner/linux/tree/idmapped_mounts
> https://gitlab.com/brauner/linux/-/commits/idmapped_mounts
> 
> /* v5 */
> - Adress Christoph's feedback.
> - Use v5.11-rc3 as new base.
> - Add Christoph's xfs port.
> 
> /* v4 */
> - Split out several preparatory patches from the initial mount_setattr
>   patch as requested by Christoph.
> - Add new tests for file/directory creation in directories with the
>   setgid bit set. Specifically, verify that the setgid bit is correctly
>   ignored when creating a file with the setgid bit and the parent
>   directory's i_gid isn't in_group_p() and the caller isn't
>   capable_wrt_inode_uidgid() over the parent directory's inode when
>   inode_init_owner() is called.
>   Conversely, verify that the setgid bit is set when creating a file
>   with the setgid bit and the parent's i_gid is either in_group_p() or
>   the caller is capable_wrt_inode_uidgid() over the parent directory's
>   inode. In additiona, verify that the setgid bit is always inherited
>   when creating directories.
>   Test all of this on regular mounts, idmapped mounts, and on idmapped
>   mounts in user namespaces.
> - Add new tests to verify that the i_gid of newly created files or
>   directories is correctly set to the parent directory's i_gid when the
>   parent directory has the setgid bit set.
> - Use "mnt_userns" as the de facto name for a vfsmount's user namespace
>   everywhere as suggested by Serge.
> - Reuse existing propagation flags instead of introducing new ones as
>   suggested by Christoph. (This is in line with Linus request to not
>   introduce too many new flags as evidenced by prior discussions on
>   other patchsets such as openat2().)
> - Add first set of Acked-bys from Serge and Reviewed-bys from Christoph.
> - Fix commit messages to reflect the fact that we modify existing
>   vfs helpers but do not introduce new ones like we did in the first
>   version. Some commit messages still implied we were adding new
>   helpers.
> - Reformat all commit messages to adhere to 73 char length limit and
>   wrap all lines in commits at 80 chars whenever this doesn't hinder
>   legibility.
> - Simplify various codepaths with Christoph's suggestions.
> 
> /* v3 */
> - The major change is the port of the test-suite from the
>   kernel-internal selftests framework to xfstests as requested by
>   Darrick and Christoph. The test-suite for xfstests is patch 38 in this
>   series. It has been kept as part of this series even though it belongs
>   to xfstests so it's easier to see what is tested and to keep it
>   in-sync.
> - Note, the test-suite now has been extended to cover io_uring and
>   idmapped mounts. The IORING_REGISTER_PERSONALITY feature allows to
>   register the caller's credentials with io_uring and returns an id
>   associated with these credentials. This is useful for applications
>   that wish to share a ring between separate users/processes. Callers
>   can pass in the credential id in the sqe personality field. If set,
>   that particular sqe will be issued with these credentials.
>   The test-suite now tests that the openat* operations with different
>   registered credentials work correctly and safely on regular mounts, on
>   regular mounts inside user namespaces, on idmapped mounts, and on
>   idmapped mounts inside user namespaces.
> 
> /* v2 */
> - The major change is the rework requested by Christoph and others to
>   adapt all relevant helpers and inode_operations methods to account for
>   idmapped mounts instead of introducing new helpers and methods
>   specific to idmapped mounts like we did before. We've also moved the
>   overlayfs conversion to handle idmapped mounts into a separate
>   patchset that will be sent out separately after the core changes
>   landed. The converted filesytems in this series include fat and ext4.
>   As per Christoph's request the vfs-wide config option to disable
>   idmapped mounts has been removed. Instead the filesystems can decide
>   whether or not they want to allow idmap mounts through a config
>   option. These config options default to off. Having a config option
>   allows us to gain some confidence in the patchset over multiple kernel
>   releases.
> - This version introduces a large test-suite to test current vfs
>   behavior and idmapped mounts behavior. This test-suite is intended to
>   grow over time.
> - While while working on adapting this patchset to the requested
>   changes, the runC and containerd crowd was nice enough to adapt
>   containerd to this patchset to make use of idmapped mounts in one of
>   the most widely used container runtimes:
>   https://github.com/containerd/containerd/pull/4734
> 
> The solution proposed here has it's origins in multiple discussions
> during Linux Plumbers 2017 during and after the end of the containers
> microconference.
> To the best of my knowledge this involved Aleksa, Stéphane, Eric, David,
> James, and myself.The original idea or a variant thereof has been
> discussed, again to the best of my knowledge, after a Linux conference
> in St. Petersburg in Russia in 2017 between Christoph, Tycho, and
> myself.
> We've taken the time to implement a working version of this solution
> over the last weeks to the best of my abilities. Tycho has signed up
> for this sligthly crazy endeavour as well and he has helped with the
> conversion of the xattr codepaths and will be involved with others in
> converting additional filesystems.
> 
> Thanks!
> Christian
> 
> Christian Brauner (39):
>   namespace: take lock_mount_hash() directly when changing flags
>   mount: make {lock,unlock}_mount_hash() static
>   namespace: only take read lock in do_reconfigure_mnt()
>   fs: split out functions to hold writers
>   fs: add attr_flags_to_mnt_flags helper
>   fs: add mount_setattr()
>   tests: add mount_setattr() selftests
>   fs: add id translation helpers
>   mount: attach mappings to mounts
>   capability: handle idmapped mounts
>   namei: make permission helpers idmapped mount aware
>   inode: make init and permission helpers idmapped mount aware
>   attr: handle idmapped mounts
>   acl: handle idmapped mounts
>   fs: add file_user_ns() helper
>   commoncap: handle idmapped mounts
>   stat: handle idmapped mounts
>   namei: handle idmapped mounts in may_*() helpers
>   namei: introduce struct renamedata
>   namei: prepare for idmapped mounts
>   open: handle idmapped mounts in do_truncate()
>   open: handle idmapped mounts
>   af_unix: handle idmapped mounts
>   utimes: handle idmapped mounts
>   fcntl: handle idmapped mounts
>   notify: handle idmapped mounts
>   init: handle idmapped mounts
>   ioctl: handle idmapped mounts
>   would_dump: handle idmapped mounts
>   exec: handle idmapped mounts
>   fs: make helpers idmap mount aware
>   apparmor: handle idmapped mounts
>   ima: handle idmapped mounts
>   fat: handle idmapped mounts
>   ext4: support idmapped mounts
>   ecryptfs: do not mount on top of idmapped mounts
>   overlayfs: do not mount on top of idmapped mounts
>   fs: introduce MOUNT_ATTR_IDMAP
>   tests: extend mount_setattr tests
> 
> Christoph Hellwig (1):
>   xfs: support idmapped mounts
> 
> Tycho Andersen (1):
>   xattr: handle idmapped mounts
> 
>  Documentation/filesystems/locking.rst         |    6 +-
>  Documentation/filesystems/porting.rst         |    2 +
>  Documentation/filesystems/vfs.rst             |   19 +-
>  arch/alpha/kernel/syscalls/syscall.tbl        |    1 +
>  arch/arm/tools/syscall.tbl                    |    1 +
>  arch/arm64/include/asm/unistd32.h             |    2 +
>  arch/ia64/kernel/syscalls/syscall.tbl         |    1 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |    1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |    1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl     |    1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl     |    1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl     |    1 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |    1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |    1 +
>  arch/powerpc/platforms/cell/spufs/inode.c     |    5 +-
>  arch/s390/kernel/syscalls/syscall.tbl         |    1 +
>  arch/sh/kernel/syscalls/syscall.tbl           |    1 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |    1 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |    1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |    1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |    1 +
>  drivers/android/binderfs.c                    |    6 +-
>  drivers/base/devtmpfs.c                       |   12 +-
>  fs/9p/acl.c                                   |    8 +-
>  fs/9p/v9fs.h                                  |    3 +-
>  fs/9p/v9fs_vfs.h                              |    2 +-
>  fs/9p/vfs_inode.c                             |   36 +-
>  fs/9p/vfs_inode_dotl.c                        |   39 +-
>  fs/9p/xattr.c                                 |    1 +
>  fs/adfs/adfs.h                                |    3 +-
>  fs/adfs/inode.c                               |    5 +-
>  fs/affs/affs.h                                |   10 +-
>  fs/affs/inode.c                               |    7 +-
>  fs/affs/namei.c                               |   15 +-
>  fs/afs/dir.c                                  |   34 +-
>  fs/afs/inode.c                                |    9 +-
>  fs/afs/internal.h                             |    7 +-
>  fs/afs/security.c                             |    2 +-
>  fs/afs/xattr.c                                |    2 +
>  fs/attr.c                                     |  124 +-
>  fs/autofs/root.c                              |   13 +-
>  fs/bad_inode.c                                |   36 +-
>  fs/bfs/dir.c                                  |   12 +-
>  fs/btrfs/acl.c                                |    5 +-
>  fs/btrfs/ctree.h                              |    3 +-
>  fs/btrfs/inode.c                              |   45 +-
>  fs/btrfs/ioctl.c                              |   25 +-
>  fs/btrfs/tests/btrfs-tests.c                  |    2 +-
>  fs/btrfs/xattr.c                              |    2 +
>  fs/cachefiles/interface.c                     |    4 +-
>  fs/cachefiles/namei.c                         |   19 +-
>  fs/cachefiles/xattr.c                         |   16 +-
>  fs/ceph/acl.c                                 |    5 +-
>  fs/ceph/dir.c                                 |   23 +-
>  fs/ceph/inode.c                               |   17 +-
>  fs/ceph/super.h                               |   12 +-
>  fs/ceph/xattr.c                               |    1 +
>  fs/cifs/cifsfs.c                              |    4 +-
>  fs/cifs/cifsfs.h                              |   21 +-
>  fs/cifs/dir.c                                 |    8 +-
>  fs/cifs/inode.c                               |   26 +-
>  fs/cifs/link.c                                |    3 +-
>  fs/cifs/xattr.c                               |    1 +
>  fs/coda/coda_linux.h                          |    6 +-
>  fs/coda/dir.c                                 |   17 +-
>  fs/coda/inode.c                               |    9 +-
>  fs/coda/pioctl.c                              |    6 +-
>  fs/configfs/configfs_internal.h               |    7 +-
>  fs/configfs/dir.c                             |    3 +-
>  fs/configfs/inode.c                           |    5 +-
>  fs/configfs/symlink.c                         |    5 +-
>  fs/coredump.c                                 |   14 +-
>  fs/crypto/policy.c                            |    2 +-
>  fs/debugfs/inode.c                            |    9 +-
>  fs/ecryptfs/crypto.c                          |    4 +-
>  fs/ecryptfs/inode.c                           |   80 +-
>  fs/ecryptfs/main.c                            |    6 +
>  fs/ecryptfs/mmap.c                            |    4 +-
>  fs/efivarfs/file.c                            |    2 +-
>  fs/efivarfs/inode.c                           |    4 +-
>  fs/erofs/inode.c                              |    7 +-
>  fs/erofs/internal.h                           |    5 +-
>  fs/exec.c                                     |   12 +-
>  fs/exfat/exfat_fs.h                           |    8 +-
>  fs/exfat/file.c                               |   14 +-
>  fs/exfat/namei.c                              |   14 +-
>  fs/ext2/acl.c                                 |    5 +-
>  fs/ext2/acl.h                                 |    3 +-
>  fs/ext2/ext2.h                                |    5 +-
>  fs/ext2/ialloc.c                              |    2 +-
>  fs/ext2/inode.c                               |   15 +-
>  fs/ext2/ioctl.c                               |    6 +-
>  fs/ext2/namei.c                               |   22 +-
>  fs/ext2/xattr_security.c                      |    1 +
>  fs/ext2/xattr_trusted.c                       |    1 +
>  fs/ext2/xattr_user.c                          |    1 +
>  fs/ext4/acl.c                                 |    5 +-
>  fs/ext4/acl.h                                 |    3 +-
>  fs/ext4/ext4.h                                |   21 +-
>  fs/ext4/ialloc.c                              |    7 +-
>  fs/ext4/inode.c                               |   21 +-
>  fs/ext4/ioctl.c                               |   19 +-
>  fs/ext4/namei.c                               |   49 +-
>  fs/ext4/super.c                               |    2 +-
>  fs/ext4/xattr_hurd.c                          |    1 +
>  fs/ext4/xattr_security.c                      |    1 +
>  fs/ext4/xattr_trusted.c                       |    1 +
>  fs/ext4/xattr_user.c                          |    1 +
>  fs/f2fs/acl.c                                 |    5 +-
>  fs/f2fs/acl.h                                 |    3 +-
>  fs/f2fs/f2fs.h                                |    7 +-
>  fs/f2fs/file.c                                |   35 +-
>  fs/f2fs/namei.c                               |   23 +-
>  fs/f2fs/xattr.c                               |    4 +-
>  fs/fat/fat.h                                  |    6 +-
>  fs/fat/file.c                                 |   24 +-
>  fs/fat/namei_msdos.c                          |   12 +-
>  fs/fat/namei_vfat.c                           |   15 +-
>  fs/fcntl.c                                    |    3 +-
>  fs/fuse/acl.c                                 |    3 +-
>  fs/fuse/dir.c                                 |   45 +-
>  fs/fuse/fuse_i.h                              |    4 +-
>  fs/fuse/xattr.c                               |    2 +
>  fs/gfs2/acl.c                                 |    5 +-
>  fs/gfs2/acl.h                                 |    3 +-
>  fs/gfs2/file.c                                |    4 +-
>  fs/gfs2/inode.c                               |   59 +-
>  fs/gfs2/inode.h                               |    3 +-
>  fs/gfs2/xattr.c                               |    1 +
>  fs/hfs/attr.c                                 |    1 +
>  fs/hfs/dir.c                                  |   13 +-
>  fs/hfs/hfs_fs.h                               |    2 +-
>  fs/hfs/inode.c                                |    7 +-
>  fs/hfsplus/dir.c                              |   25 +-
>  fs/hfsplus/hfsplus_fs.h                       |    5 +-
>  fs/hfsplus/inode.c                            |   16 +-
>  fs/hfsplus/ioctl.c                            |    2 +-
>  fs/hfsplus/xattr.c                            |    1 +
>  fs/hfsplus/xattr_security.c                   |    1 +
>  fs/hfsplus/xattr_trusted.c                    |    1 +
>  fs/hfsplus/xattr_user.c                       |    1 +
>  fs/hostfs/hostfs_kern.c                       |   29 +-
>  fs/hpfs/hpfs_fn.h                             |    2 +-
>  fs/hpfs/inode.c                               |    7 +-
>  fs/hpfs/namei.c                               |   20 +-
>  fs/hugetlbfs/inode.c                          |   31 +-
>  fs/init.c                                     |   27 +-
>  fs/inode.c                                    |   50 +-
>  fs/internal.h                                 |    2 +-
>  fs/jffs2/acl.c                                |    5 +-
>  fs/jffs2/acl.h                                |    3 +-
>  fs/jffs2/dir.c                                |   32 +-
>  fs/jffs2/fs.c                                 |    7 +-
>  fs/jffs2/os-linux.h                           |    2 +-
>  fs/jffs2/security.c                           |    1 +
>  fs/jffs2/xattr_trusted.c                      |    1 +
>  fs/jffs2/xattr_user.c                         |    1 +
>  fs/jfs/acl.c                                  |    5 +-
>  fs/jfs/file.c                                 |    9 +-
>  fs/jfs/ioctl.c                                |    2 +-
>  fs/jfs/jfs_acl.h                              |    3 +-
>  fs/jfs/jfs_inode.c                            |    2 +-
>  fs/jfs/jfs_inode.h                            |    2 +-
>  fs/jfs/namei.c                                |   21 +-
>  fs/jfs/xattr.c                                |    2 +
>  fs/kernfs/dir.c                               |    7 +-
>  fs/kernfs/inode.c                             |   19 +-
>  fs/kernfs/kernfs-internal.h                   |    9 +-
>  fs/libfs.c                                    |   28 +-
>  fs/minix/bitmap.c                             |    2 +-
>  fs/minix/file.c                               |    7 +-
>  fs/minix/inode.c                              |    6 +-
>  fs/minix/minix.h                              |    3 +-
>  fs/minix/namei.c                              |   24 +-
>  fs/mount.h                                    |   10 -
>  fs/namei.c                                    |  513 ++++--
>  fs/namespace.c                                |  484 +++++-
>  fs/nfs/dir.c                                  |   25 +-
>  fs/nfs/inode.c                                |    9 +-
>  fs/nfs/internal.h                             |   10 +-
>  fs/nfs/namespace.c                            |   14 +-
>  fs/nfs/nfs3_fs.h                              |    3 +-
>  fs/nfs/nfs3acl.c                              |    3 +-
>  fs/nfs/nfs4proc.c                             |    3 +
>  fs/nfsd/nfs2acl.c                             |    4 +-
>  fs/nfsd/nfs3acl.c                             |    4 +-
>  fs/nfsd/nfs4acl.c                             |    4 +-
>  fs/nfsd/nfs4recover.c                         |    6 +-
>  fs/nfsd/nfsfh.c                               |    2 +-
>  fs/nfsd/nfsproc.c                             |    2 +-
>  fs/nfsd/vfs.c                                 |   47 +-
>  fs/nilfs2/inode.c                             |   13 +-
>  fs/nilfs2/ioctl.c                             |    2 +-
>  fs/nilfs2/namei.c                             |   19 +-
>  fs/nilfs2/nilfs.h                             |    4 +-
>  fs/notify/fanotify/fanotify_user.c            |    2 +-
>  fs/notify/inotify/inotify_user.c              |    3 +-
>  fs/ntfs/inode.c                               |    6 +-
>  fs/ntfs/inode.h                               |    3 +-
>  fs/ocfs2/acl.c                                |    5 +-
>  fs/ocfs2/acl.h                                |    3 +-
>  fs/ocfs2/dlmfs/dlmfs.c                        |   17 +-
>  fs/ocfs2/file.c                               |   17 +-
>  fs/ocfs2/file.h                               |   11 +-
>  fs/ocfs2/ioctl.c                              |    2 +-
>  fs/ocfs2/namei.c                              |   21 +-
>  fs/ocfs2/refcounttree.c                       |    4 +-
>  fs/ocfs2/xattr.c                              |    3 +
>  fs/omfs/dir.c                                 |   13 +-
>  fs/omfs/file.c                                |    7 +-
>  fs/omfs/inode.c                               |    2 +-
>  fs/open.c                                     |   50 +-
>  fs/orangefs/acl.c                             |    5 +-
>  fs/orangefs/inode.c                           |   20 +-
>  fs/orangefs/namei.c                           |   12 +-
>  fs/orangefs/orangefs-kernel.h                 |   13 +-
>  fs/orangefs/xattr.c                           |    1 +
>  fs/overlayfs/copy_up.c                        |   20 +-
>  fs/overlayfs/dir.c                            |   31 +-
>  fs/overlayfs/file.c                           |    6 +-
>  fs/overlayfs/inode.c                          |   26 +-
>  fs/overlayfs/overlayfs.h                      |   44 +-
>  fs/overlayfs/super.c                          |   19 +-
>  fs/overlayfs/util.c                           |    4 +-
>  fs/posix_acl.c                                |  101 +-
>  fs/proc/base.c                                |   28 +-
>  fs/proc/fd.c                                  |    5 +-
>  fs/proc/fd.h                                  |    3 +-
>  fs/proc/generic.c                             |   12 +-
>  fs/proc/internal.h                            |    5 +-
>  fs/proc/proc_net.c                            |    5 +-
>  fs/proc/proc_sysctl.c                         |   15 +-
>  fs/proc/root.c                                |    5 +-
>  fs/proc_namespace.c                           |    3 +
>  fs/ramfs/file-nommu.c                         |    9 +-
>  fs/ramfs/inode.c                              |   18 +-
>  fs/reiserfs/acl.h                             |    3 +-
>  fs/reiserfs/inode.c                           |    7 +-
>  fs/reiserfs/ioctl.c                           |    4 +-
>  fs/reiserfs/namei.c                           |   21 +-
>  fs/reiserfs/reiserfs.h                        |    3 +-
>  fs/reiserfs/xattr.c                           |   12 +-
>  fs/reiserfs/xattr.h                           |    3 +-
>  fs/reiserfs/xattr_acl.c                       |    7 +-
>  fs/reiserfs/xattr_security.c                  |    3 +-
>  fs/reiserfs/xattr_trusted.c                   |    3 +-
>  fs/reiserfs/xattr_user.c                      |    3 +-
>  fs/remap_range.c                              |    7 +-
>  fs/stat.c                                     |   26 +-
>  fs/sysv/file.c                                |    7 +-
>  fs/sysv/ialloc.c                              |    2 +-
>  fs/sysv/itree.c                               |    6 +-
>  fs/sysv/namei.c                               |   21 +-
>  fs/sysv/sysv.h                                |    3 +-
>  fs/tracefs/inode.c                            |    4 +-
>  fs/ubifs/dir.c                                |   30 +-
>  fs/ubifs/file.c                               |    5 +-
>  fs/ubifs/ioctl.c                              |    2 +-
>  fs/ubifs/ubifs.h                              |    5 +-
>  fs/ubifs/xattr.c                              |    1 +
>  fs/udf/file.c                                 |    9 +-
>  fs/udf/ialloc.c                               |    2 +-
>  fs/udf/namei.c                                |   24 +-
>  fs/udf/symlink.c                              |    7 +-
>  fs/ufs/ialloc.c                               |    2 +-
>  fs/ufs/inode.c                                |    7 +-
>  fs/ufs/namei.c                                |   19 +-
>  fs/ufs/ufs.h                                  |    3 +-
>  fs/utimes.c                                   |    4 +-
>  fs/vboxsf/dir.c                               |   12 +-
>  fs/vboxsf/utils.c                             |    9 +-
>  fs/vboxsf/vfsmod.h                            |    8 +-
>  fs/verity/enable.c                            |    2 +-
>  fs/xattr.c                                    |  136 +-
>  fs/xfs/xfs_acl.c                              |    5 +-
>  fs/xfs/xfs_acl.h                              |    3 +-
>  fs/xfs/xfs_file.c                             |    4 +-
>  fs/xfs/xfs_inode.c                            |   26 +-
>  fs/xfs/xfs_inode.h                            |   16 +-
>  fs/xfs/xfs_ioctl.c                            |   23 +-
>  fs/xfs/xfs_iops.c                             |   98 +-
>  fs/xfs/xfs_iops.h                             |    3 +-
>  fs/xfs/xfs_qm.c                               |    3 +-
>  fs/xfs/xfs_super.c                            |    2 +-
>  fs/xfs/xfs_symlink.c                          |    5 +-
>  fs/xfs/xfs_symlink.h                          |    5 +-
>  fs/xfs/xfs_xattr.c                            |    3 +-
>  fs/zonefs/super.c                             |    9 +-
>  include/linux/capability.h                    |   15 +-
>  include/linux/fs.h                            |  158 +-
>  include/linux/ima.h                           |   17 +-
>  include/linux/lsm_hook_defs.h                 |   15 +-
>  include/linux/lsm_hooks.h                     |    1 +
>  include/linux/mount.h                         |    7 +
>  include/linux/nfs_fs.h                        |    7 +-
>  include/linux/posix_acl.h                     |   15 +-
>  include/linux/posix_acl_xattr.h               |   12 +-
>  include/linux/security.h                      |   46 +-
>  include/linux/syscalls.h                      |    4 +
>  include/linux/xattr.h                         |   30 +-
>  include/uapi/asm-generic/unistd.h             |    4 +-
>  include/uapi/linux/mount.h                    |   17 +
>  ipc/mqueue.c                                  |    8 +-
>  kernel/auditsc.c                              |    5 +-
>  kernel/bpf/inode.c                            |   13 +-
>  kernel/capability.c                           |   14 +-
>  kernel/cgroup/cgroup.c                        |    2 +-
>  kernel/sys.c                                  |    2 +-
>  mm/madvise.c                                  |    4 +-
>  mm/memcontrol.c                               |    2 +-
>  mm/mincore.c                                  |    4 +-
>  mm/shmem.c                                    |   48 +-
>  net/socket.c                                  |    6 +-
>  net/unix/af_unix.c                            |    4 +-
>  security/apparmor/apparmorfs.c                |    3 +-
>  security/apparmor/domain.c                    |   13 +-
>  security/apparmor/file.c                      |    5 +-
>  security/apparmor/lsm.c                       |   12 +-
>  security/commoncap.c                          |  109 +-
>  security/integrity/evm/evm_crypto.c           |   11 +-
>  security/integrity/evm/evm_main.c             |    4 +-
>  security/integrity/evm/evm_secfs.c            |    2 +-
>  security/integrity/ima/ima.h                  |   19 +-
>  security/integrity/ima/ima_api.c              |   10 +-
>  security/integrity/ima/ima_appraise.c         |   22 +-
>  security/integrity/ima/ima_asymmetric_keys.c  |    2 +-
>  security/integrity/ima/ima_main.c             |   31 +-
>  security/integrity/ima/ima_policy.c           |   19 +-
>  security/integrity/ima/ima_queue_keys.c       |    2 +-
>  security/security.c                           |   25 +-
>  security/selinux/hooks.c                      |   22 +-
>  security/smack/smack_lsm.c                    |   18 +-
>  tools/include/uapi/asm-generic/unistd.h       |    4 +-
>  tools/testing/selftests/Makefile              |    1 +
>  .../selftests/mount_setattr/.gitignore        |    1 +
>  .../testing/selftests/mount_setattr/Makefile  |    7 +
>  tools/testing/selftests/mount_setattr/config  |    1 +
>  .../mount_setattr/mount_setattr_test.c        | 1424 +++++++++++++++++
>  338 files changed, 4718 insertions(+), 1731 deletions(-)
>  create mode 100644 tools/testing/selftests/mount_setattr/.gitignore
>  create mode 100644 tools/testing/selftests/mount_setattr/Makefile
>  create mode 100644 tools/testing/selftests/mount_setattr/config
>  create mode 100644 tools/testing/selftests/mount_setattr/mount_setattr_test.c
> 
> 
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> -- 
> 2.30.0
> 
