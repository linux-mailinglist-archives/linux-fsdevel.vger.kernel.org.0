Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9F29DE29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbgJ2AxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:53:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60629 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgJ2Afd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:33 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuJ-0008Ep-Vc; Thu, 29 Oct 2020 00:35:12 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
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
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 00/34] fs: idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:18 +0100
Message-Id: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

I vanished for a little while to focus on this work here so sorry for
not being available by mail for a while.

Since quite a long time we have issues with sharing mounts between
multiple unprivileged containers with different id mappings, sharing a
rootfs between multiple containers with different id mappings, and also
sharing regular directories and filesystems between users with different
uids and gids. The latter use-cases have become even more important with
the availability and adoption of systemd-homed (cf. [1]) to implement
portable home directories.

The solutions we have tried and proposed so far include the introduction
of fsid mappings, a tiny overlay based filesystem, and an approach to
call override creds in the vfs. None of these solutions have covered all
of the above use-cases.

The solution proposed here has it's origins in multiple discussions
during Linux Plumbers 2017 during and after the end of the containers
microconference.
To the best of my knowledge this involved Aleksa, Stéphane, Eric, David,
James, and myself. A variant of the solution proposed here has also been
discussed, again to the best of my knowledge, after a Linux conference
in St. Petersburg in Russia between Christoph, Tycho, and myself in 2017
after Linux Plumbers.
I've taken the time to finally implement a working version of this
solution over the last weeks to the best of my abilities. Tycho has
signed up for this sligthly crazy endeavour as well and he has helped
with the conversion of the xattr codepaths.

The core idea is to make idmappings a property of struct vfsmount
instead of tying it to a process being inside of a user namespace which
has been the case for all other proposed approaches.
It means that idmappings become a property of bind-mounts, i.e. each
bind-mount can have a separate idmapping. This has the obvious advantage
that idmapped mounts can be created inside of the initial user
namespace, i.e. on the host itself instead of requiring the caller to be
located inside of a user namespace. This enables such use-cases as e.g.
making a usb stick available in multiple locations with different
idmappings (see the vfat port that is part of this patch series).

The vfsmount struct gains a new struct user_namespace member. The
idmapping of the user namespace becomes the idmapping of the mount. A
caller that is either privileged with respect to the user namespace of
the superblock of the underlying filesystem or a caller that is
privileged with respect to the user namespace a mount has been idmapped
with can create a new bind-mount and mark it with a user namespace. The
user namespace the mount will be marked with can be specified by passing
a file descriptor refering to the user namespace as an argument to the
new mount_setattr() syscall together with the new MOUNT_ATTR_IDMAP flag.
By default vfsmounts are marked with the initial user namespace and no
behavioral or performance changes should be observed. All mapping
operations are nops for the initial user namespace.

When a file/inode is accessed through an idmapped mount the i_uid and
i_gid of the inode will be remapped according to the user namespace the
mount has been marked with. When a new object is created based on the
fsuid and fsgid of the caller they will similarly be remapped according
to the user namespace of the mount they care created from.

This means the user namespace of the mount needs to be passed down into
a few relevant inode_operations. This mostly includes inode operations
that create filesystem objects or change file attributes. Some of them
such as ->getattr() don't even need to change since they pass down a
struct path and thus the struct vfsmount is already available. Other
inode operations need to be adapted to pass down the user namespace the
vfsmount has been marked with. Al was nice enough to point out that he
will not tolerate struct vfsmount being passed to filesystems and that I
should pass down the user namespace directly; which is what I did.
The inode struct itself is never altered whenever the i_uid and i_gid
need to be mapped, i.e. i_uid and i_gid are only remapped at the time of
the check. An inode once initialized (during lookup or object creation)
is never altered when accessed through an idmapped mount.

To limit the amount of noise in this first iteration we have not changed
the existing inode operations but rather introduced a few new struct
inode operation methods such as ->mkdir_mapped which pass down the user
namespace of the mount they have been called from. Should this solution
be worth pursuing we have no problem adapting the existing inode
operations instead.

In order to support idmapped mounts, filesystems need to be changed and
mark themselves with the FS_ALLOW_IDMAP flag in fs_flags. In this first
iteration I tried to illustrate this by changing three different
filesystem with different levels of complexity. Of course with some bias
towards urgent use-cases and filesystems I was at least a little more
familiar with. However, Tycho and I (and others) have no problem
converting each filesystem one-by-one. This first iteration includes fat
(msdos and vfat), ext4, and overlayfs (both with idmapped lower and
upper directories and idmapped merged directories). I'm sure I haven't
gotten everything right for all three of them in the first version of
this patch.

I have written a simple tool that allows to create idmapped mounts so
people can play with this patch series. Here are a few illustrations:

1. Create a simple idmapped mount of another user's home directory

u1001@f2-vm:/$ sudo ./mount-idmapped --map-mount b:1000:1001:1 /home/ubuntu/ /mnt
u1001@f2-vm:/$ ls -al /home/ubuntu/
total 28
drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 22:07 .
drwxr-xr-x 4 root   root   4096 Oct 28 04:00 ..
-rw------- 1 ubuntu ubuntu 3154 Oct 28 22:12 .bash_history
-rw-r--r-- 1 ubuntu ubuntu  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 ubuntu ubuntu 3771 Feb 25  2020 .bashrc
-rw-r--r-- 1 ubuntu ubuntu  807 Feb 25  2020 .profile
-rw-r--r-- 1 ubuntu ubuntu    0 Oct 16 16:11 .sudo_as_admin_successful
-rw------- 1 ubuntu ubuntu 1144 Oct 28 00:43 .viminfo
u1001@f2-vm:/$ ls -al /mnt/
total 28
drwxr-xr-x  2 u1001 u1001 4096 Oct 28 22:07 .
drwxr-xr-x 29 root  root  4096 Oct 28 22:01 ..
-rw-------  1 u1001 u1001 3154 Oct 28 22:12 .bash_history
-rw-r--r--  1 u1001 u1001  220 Feb 25  2020 .bash_logout
-rw-r--r--  1 u1001 u1001 3771 Feb 25  2020 .bashrc
-rw-r--r--  1 u1001 u1001  807 Feb 25  2020 .profile
-rw-r--r--  1 u1001 u1001    0 Oct 16 16:11 .sudo_as_admin_successful
-rw-------  1 u1001 u1001 1144 Oct 28 00:43 .viminfo
u1001@f2-vm:/$ touch /mnt/my-file
u1001@f2-vm:/$ setfacl -m u:1001:rwx /mnt/my-file
u1001@f2-vm:/$ sudo setcap -n 1001 cap_net_raw+ep /mnt/my-file
u1001@f2-vm:/$ ls -al /mnt/my-file
-rw-rwxr--+ 1 u1001 u1001 0 Oct 28 22:14 /mnt/my-file
u1001@f2-vm:/$ ls -al /home/ubuntu/my-file
-rw-rwxr--+ 1 ubuntu ubuntu 0 Oct 28 22:14 /home/ubuntu/my-file
u1001@f2-vm:/$ getfacl /mnt/my-file
getfacl: Removing leading '/' from absolute path names
# file: mnt/my-file
# owner: u1001
# group: u1001
user::rw-
user:u1001:rwx
group::rw-
mask::rwx
other::r--
u1001@f2-vm:/$ getfacl /home/ubuntu/my-file
getfacl: Removing leading '/' from absolute path names
# file: home/ubuntu/my-file
# owner: ubuntu
# group: ubuntu
user::rw-
user:ubuntu:rwx
group::rw-
mask::rwx
other::r--

2. Create mapping of the whole ext4 rootfs without a mapping for uid and gid 0

ubuntu@f2-vm:~$ sudo /mount-idmapped --map-mount b:1:1:65536 / /mnt/
ubuntu@f2-vm:~$ findmnt | grep mnt
└─/mnt                                /dev/sda2  ext4       rw,relatime
  └─/mnt/mnt                          /dev/sda2  ext4       rw,relatime
ubuntu@f2-vm:~$ sudo mkdir /AS-ROOT-CAN-CREATE
ubuntu@f2-vm:~$ sudo mkdir /mnt/AS-ROOT-CANT-CREATE
mkdir: cannot create directory ‘/mnt/AS-ROOT-CANT-CREATE’: Value too large for defined data type
ubuntu@f2-vm:~$ mkdir /mnt/home/ubuntu/AS-USER-1000-CAN-CREATE

3. Create a vfat usb mount and expose to user 1001 and 5000

ubuntu@f2-vm:/$ sudo mount /dev/sdb /mnt
ubuntu@f2-vm:/$ findmnt  | grep mnt
└─/mnt                                /dev/sdb vfat       rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro
ubuntu@f2-vm:/$ ls -al /mnt
total 12
drwxr-xr-x  2 root root 4096 Jan  1  1970 .
drwxr-xr-x 34 root root 4096 Oct 28 22:24 ..
-rwxr-xr-x  1 root root    4 Oct 28 03:44 aaa
-rwxr-xr-x  1 root root    0 Oct 28 01:09 bbb
ubuntu@f2-vm:/$ sudo /mount-idmapped --map-mount b:0:1001:1 /mnt /mnt-1001/
ubuntu@f2-vm:/$ ls -al /mnt-1001/
total 12
drwxr-xr-x  2 u1001 u1001 4096 Jan  1  1970 .
drwxr-xr-x 34 root  root  4096 Oct 28 22:24 ..
-rwxr-xr-x  1 u1001 u1001    4 Oct 28 03:44 aaa
-rwxr-xr-x  1 u1001 u1001    0 Oct 28 01:09 bbb
ubuntu@f2-vm:/$ sudo /mount-idmapped --map-mount b:0:5000:1 /mnt /mnt-5000/
ubuntu@f2-vm:/$ ls -al /mnt-5000/
total 12
drwxr-xr-x  2 5000 5000 4096 Jan  1  1970 .
drwxr-xr-x 34 root root 4096 Oct 28 22:24 ..
-rwxr-xr-x  1 5000 5000    4 Oct 28 03:44 aaa
-rwxr-xr-x  1 5000 5000    0 Oct 28 01:09 bbb

4. Create an idmapped rootfs mount for a container

root@f2-vm:~# ls -al /var/lib/lxc/f2/rootfs/
total 68
drwxr-xr-x 17 20000 20000 4096 Sep 24 07:48 .
drwxrwx---  3 20000 20000 4096 Oct 16 19:26 ..
lrwxrwxrwx  1 20000 20000    7 Sep 24 07:43 bin -> usr/bin
drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 boot
drwxr-xr-x  3 20000 20000 4096 Oct 16 19:26 dev
drwxr-xr-x 61 20000 20000 4096 Oct 16 19:26 etc
drwxr-xr-x  3 20000 20000 4096 Sep 24 07:45 home
lrwxrwxrwx  1 20000 20000    7 Sep 24 07:43 lib -> usr/lib
lrwxrwxrwx  1 20000 20000    9 Sep 24 07:43 lib32 -> usr/lib32
lrwxrwxrwx  1 20000 20000    9 Sep 24 07:43 lib64 -> usr/lib64
lrwxrwxrwx  1 20000 20000   10 Sep 24 07:43 libx32 -> usr/libx32
drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 media
drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 mnt
drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 opt
drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 proc
drwx------  2 20000 20000 4096 Sep 24 07:43 root
drwxr-xr-x  2 20000 20000 4096 Sep 24 07:45 run
lrwxrwxrwx  1 20000 20000    8 Sep 24 07:43 sbin -> usr/sbin
drwxr-xr-x  2 20000 20000 4096 Sep 24 07:43 srv
drwxr-xr-x  2 20000 20000 4096 Apr 15  2020 sys
drwxrwxrwt  2 20000 20000 4096 Sep 24 07:44 tmp
drwxr-xr-x 13 20000 20000 4096 Sep 24 07:43 usr
drwxr-xr-x 12 20000 20000 4096 Sep 24 07:44 var
root@f2-vm:~# /mount-idmapped --map-mount b:20000:10000:100000 /var/lib/lxc/f2/rootfs/ /mnt
root@f2-vm:~# ls -al /mnt
total 68
drwxr-xr-x 17 10000 10000 4096 Sep 24 07:48 .
drwxr-xr-x 34 root  root  4096 Oct 28 22:24 ..
lrwxrwxrwx  1 10000 10000    7 Sep 24 07:43 bin -> usr/bin
drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 boot
drwxr-xr-x  3 10000 10000 4096 Oct 16 19:26 dev
drwxr-xr-x 61 10000 10000 4096 Oct 16 19:26 etc
drwxr-xr-x  3 10000 10000 4096 Sep 24 07:45 home
lrwxrwxrwx  1 10000 10000    7 Sep 24 07:43 lib -> usr/lib
lrwxrwxrwx  1 10000 10000    9 Sep 24 07:43 lib32 -> usr/lib32
lrwxrwxrwx  1 10000 10000    9 Sep 24 07:43 lib64 -> usr/lib64
lrwxrwxrwx  1 10000 10000   10 Sep 24 07:43 libx32 -> usr/libx32
drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 media
drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 mnt
drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 opt
drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 proc
drwx------  2 10000 10000 4096 Sep 24 07:43 root
drwxr-xr-x  2 10000 10000 4096 Sep 24 07:45 run
lrwxrwxrwx  1 10000 10000    8 Sep 24 07:43 sbin -> usr/sbin
drwxr-xr-x  2 10000 10000 4096 Sep 24 07:43 srv
drwxr-xr-x  2 10000 10000 4096 Apr 15  2020 sys
drwxrwxrwt  2 10000 10000 4096 Sep 24 07:44 tmp
drwxr-xr-x 13 10000 10000 4096 Sep 24 07:43 usr
drwxr-xr-x 12 10000 10000 4096 Sep 24 07:44 var
root@f2-vm:~# lxc-start f2 # uses /mnt as rootfs
root@f2-vm:~# lxc-attach f2 -- cat /proc/1/uid_map
         0      10000      10000
root@f2-vm:~# lxc-attach f2 -- cat /proc/1/gid_map
         0      10000      10000
root@f2-vm:~# lxc-attach f2 -- ls -al /
total 52
drwxr-xr-x  17 root   root    4096 Sep 24 07:48 .
drwxr-xr-x  17 root   root    4096 Sep 24 07:48 ..
lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
drwxr-xr-x   5 root   root     500 Oct 28 23:39 dev
drwxr-xr-x  61 root   root    4096 Oct 28 23:39 etc
drwxr-xr-x   3 root   root    4096 Sep 24 07:45 home
lrwxrwxrwx   1 root   root       7 Sep 24 07:43 lib -> usr/lib
lrwxrwxrwx   1 root   root       9 Sep 24 07:43 lib32 -> usr/lib32
lrwxrwxrwx   1 root   root       9 Sep 24 07:43 lib64 -> usr/lib64
lrwxrwxrwx   1 root   root      10 Sep 24 07:43 libx32 -> usr/libx32
drwxr-xr-x   2 root   root    4096 Sep 24 07:43 media
drwxr-xr-x   2 root   root    4096 Sep 24 07:43 mnt
drwxr-xr-x   2 root   root    4096 Sep 24 07:43 opt
dr-xr-xr-x 232 nobody nogroup    0 Oct 28 23:39 proc
drwx------   2 root   root    4096 Oct 28 23:41 root
drwxr-xr-x  12 root   root     360 Oct 28 23:39 run
lrwxrwxrwx   1 root   root       8 Sep 24 07:43 sbin -> usr/sbin
drwxr-xr-x   2 root   root    4096 Sep 24 07:43 srv
dr-xr-xr-x  13 nobody nogroup    0 Oct 28 23:39 sys
drwxrwxrwt  11 root   root    4096 Oct 28 23:40 tmp
drwxr-xr-x  13 root   root    4096 Sep 24 07:43 usr
drwxr-xr-x  12 root   root    4096 Sep 24 07:44 var
root@f2-vm:~# lxc-attach f2 -- ls -al /my-file
-rw-r--r-- 1 root root 0 Oct 28 23:43 /my-file
root@f2-vm:~# ls -al /var/lib/lxc/f2/rootfs/my-file
-rw-r--r-- 1 20000 20000 0 Oct 28 23:43 /var/lib/lxc/f2/rootfs/my-file

[1]: https://systemd.io/HOME_DIRECTORY/
     "If the UID assigned to a user does not match the owner of the home
      directory in the file system, the home directory is automatically
      and recursively chown()ed to the correct UID."
      This has huge performance impact and is also problematic since it
      chowns all files independent of ownership.
[2]: https://github.com/brauner/mount-idmapped

In no particular order I'd like to say thanks to:
Al for pointing me into the direction to avoid inode alias issues during
lookup. David for various discussions around this. Tycho for helping
with this series and on future patches if this is in any shape or form
acceptable. Alban Crequy for pointing out more application container
use-cases. Stéphane for various valuable input on various use-cases and
letting me work on this. Amir for explaining and discussing aspects of
overlayfs with me.
I'd like to especially thank Seth Forshee because he provided a lot of
good analysis, suggestions, and participated in short-notice discussions
in both chat and video.

This series can be found and pulled in three locations:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=idmapped_mounts
https://github.com/brauner/linux/tree/idmapped_mounts
https://gitlab.com/brauner/linux/-/commits/idmapped_mounts

Thanks!
Christian

Christian Brauner (32):
  namespace: take lock_mount_hash() directly when changing flags
  namespace: only take read lock in do_reconfigure_mnt()
  fs: add mount_setattr()
  tests: add mount_setattr() selftests
  fs: introduce MOUNT_ATTR_IDMAP
  fs: add id translation helpers
  capability: handle idmapped mounts
  namei: add idmapped mount aware permission helpers
  inode: add idmapped mount aware init and permission helpers
  attr: handle idmapped mounts
  acl: handle idmapped mounts
  commoncap: handle idmapped mounts
  stat: add mapped_generic_fillattr()
  namei: handle idmapped mounts in may_*() helpers
  namei: introduce struct renamedata
  namei: prepare for idmapped mounts
  namei: add lookup helpers with idmapped mounts aware permission
    checking
  open: handle idmapped mounts in do_truncate()
  open: handle idmapped mounts
  af_unix: handle idmapped mounts
  utimes: handle idmapped mounts
  would_dump: handle idmapped mounts
  exec: handle idmapped mounts
  fs: add helpers for idmap mounts
  apparmor: handle idmapped mounts
  audit: handle idmapped mounts
  ima: handle idmapped mounts
  ext4: support idmapped mounts
  expfs: handle idmapped mounts
  overlayfs: handle idmapped lower directories
  overlayfs: handle idmapped merged mounts
  fat: handle idmapped mounts

Tycho Andersen (2):
  xattr: handle idmapped mounts
  selftests: add idmapped mounts xattr selftest

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/Kconfig                                    |   6 +
 fs/attr.c                                     | 142 ++-
 fs/coredump.c                                 |  12 +-
 fs/exec.c                                     |  12 +-
 fs/exportfs/expfs.c                           |   4 +-
 fs/ext4/acl.c                                 |  11 +-
 fs/ext4/acl.h                                 |   3 +
 fs/ext4/ext4.h                                |  14 +-
 fs/ext4/file.c                                |   4 +
 fs/ext4/ialloc.c                              |   7 +-
 fs/ext4/inode.c                               |  27 +-
 fs/ext4/ioctl.c                               |  18 +-
 fs/ext4/namei.c                               | 145 ++-
 fs/ext4/super.c                               |   4 +
 fs/ext4/symlink.c                             |   9 +
 fs/ext4/xattr_hurd.c                          |  22 +-
 fs/ext4/xattr_security.c                      |  18 +-
 fs/ext4/xattr_trusted.c                       |  18 +-
 fs/fat/fat.h                                  |   2 +
 fs/fat/file.c                                 |  27 +-
 fs/fat/namei_msdos.c                          |   7 +
 fs/fat/namei_vfat.c                           |   7 +
 fs/inode.c                                    |  66 +-
 fs/internal.h                                 |   9 +
 fs/namei.c                                    | 597 ++++++++----
 fs/namespace.c                                | 446 ++++++++-
 fs/open.c                                     |  52 +-
 fs/overlayfs/copy_up.c                        | 104 +-
 fs/overlayfs/dir.c                            | 219 +++--
 fs/overlayfs/export.c                         |   3 +-
 fs/overlayfs/file.c                           |  23 +-
 fs/overlayfs/inode.c                          | 121 ++-
 fs/overlayfs/namei.c                          |  64 +-
 fs/overlayfs/overlayfs.h                      | 158 +++-
 fs/overlayfs/ovl_entry.h                      |   1 +
 fs/overlayfs/readdir.c                        |  34 +-
 fs/overlayfs/super.c                          | 109 ++-
 fs/overlayfs/util.c                           |  38 +-
 fs/posix_acl.c                                | 130 ++-
 fs/stat.c                                     |  18 +-
 fs/utimes.c                                   |   4 +-
 fs/xattr.c                                    | 264 ++++--
 include/linux/audit.h                         |  10 +-
 include/linux/capability.h                    |  12 +-
 include/linux/fs.h                            | 254 ++++-
 include/linux/ima.h                           |  15 +-
 include/linux/lsm_hook_defs.h                 |  10 +-
 include/linux/lsm_hooks.h                     |   1 +
 include/linux/mount.h                         |  20 +-
 include/linux/namei.h                         |   6 +
 include/linux/posix_acl.h                     |  14 +-
 include/linux/posix_acl_xattr.h               |  12 +-
 include/linux/security.h                      |  36 +-
 include/linux/syscalls.h                      |   3 +
 include/linux/xattr.h                         |  29 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/mount.h                    |  26 +
 ipc/mqueue.c                                  |   8 +-
 kernel/auditsc.c                              |  29 +-
 kernel/capability.c                           |  22 +-
 net/unix/af_unix.c                            |   2 +-
 security/apparmor/domain.c                    |   9 +-
 security/apparmor/file.c                      |   5 +-
 security/apparmor/lsm.c                       |  12 +-
 security/commoncap.c                          |  50 +-
 security/integrity/ima/ima.h                  |  19 +-
 security/integrity/ima/ima_api.c              |  10 +-
 security/integrity/ima/ima_appraise.c         |  14 +-
 security/integrity/ima/ima_asymmetric_keys.c  |   2 +-
 security/integrity/ima/ima_main.c             |  28 +-
 security/integrity/ima/ima_policy.c           |  17 +-
 security/integrity/ima/ima_queue_keys.c       |   2 +-
 security/security.c                           |  18 +-
 security/selinux/hooks.c                      |  13 +-
 security/smack/smack_lsm.c                    |  11 +-
 tools/include/uapi/asm-generic/unistd.h       |   4 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/idmap_mounts/.gitignore |   1 +
 tools/testing/selftests/idmap_mounts/Makefile |   8 +
 tools/testing/selftests/idmap_mounts/config   |   1 +
 tools/testing/selftests/idmap_mounts/xattr.c  | 389 ++++++++
 .../selftests/mount_setattr/.gitignore        |   1 +
 .../testing/selftests/mount_setattr/Makefile  |   7 +
 tools/testing/selftests/mount_setattr/config  |   1 +
 .../mount_setattr/mount_setattr_test.c        | 888 ++++++++++++++++++
 102 files changed, 4109 insertions(+), 912 deletions(-)
 create mode 100644 tools/testing/selftests/idmap_mounts/.gitignore
 create mode 100644 tools/testing/selftests/idmap_mounts/Makefile
 create mode 100644 tools/testing/selftests/idmap_mounts/config
 create mode 100644 tools/testing/selftests/idmap_mounts/xattr.c
 create mode 100644 tools/testing/selftests/mount_setattr/.gitignore
 create mode 100644 tools/testing/selftests/mount_setattr/Makefile
 create mode 100644 tools/testing/selftests/mount_setattr/config
 create mode 100644 tools/testing/selftests/mount_setattr/mount_setattr_test.c


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.29.0

