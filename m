Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E799721F6FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGNQP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:15:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40926 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgGNQPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:15:55 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvNan-0005y1-RV; Tue, 14 Jul 2020 16:15:41 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/4] fs: add mount_setattr()
Date:   Tue, 14 Jul 2020 18:14:11 +0200
Message-Id: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This series can be found at:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=mount_setattr
https://gitlab.com/brauner/linux/-/commits/mount_setattr
https://github.com/brauner/linux/tree/mount_setattr

This implements the mount_setattr() syscall which has come up a few
times already back in 2018 and again now in recent discussions and as
promised (see [1] and [2]) here is the first version. Sorry for the
delay but there's never enough time to get things done on time.

While the new mount api allows to change the properties of a superblock
there is currently no way to change the mount properties of a mount or
mount tree using mount file descriptors which the new mount api is based
on. In addition the old mount api has the big restriction that mount
options cannot be applied recursively. This hasn't changed since
changing mount options on a per-mount basis was implemented and has been
a frequent request and a source of bugs. The inability to change the
read-only mount option recursively alone is invaluable to userspace. Not
too long ago there was another significant security issue that was
caused by mount properties not being applied recurisvely (cf. [3]).
Additionally, various userspace projects have switched over to the new
mount api (including the ones I maintain) but we still have terrible
hacks and loops around changing mount properties for existing mount
trees. With mount_setattr() all these codepaths will be demoted to
fallback codepaths, hopefully. Michael Kerrisk recently pointed out the
missing support for this syscall as well.

The new mount_setattr() syscall allows to recursively clear and set
mount options in one shot. Multiple calls to change mount options
requesting the same changes are idempotent:

int mount_setattr(int dfd, const char *path, unsigned flags,
                  struct mount_attr *uattr, size_t usize);

Flags to modify path resolution behavior are specified in the @flags
argument. Currently, AT_EMPTY_PATH, AT_RECURSIVE, AT_SYMLINK_NOFOLLOW,
and AT_NO_AUTOMOUNT are supported. If useful, additional lookup flags to
restrict path resolution as introduced with openat2() might be supported
in the future.

mount_setattr() can be expected to grow over time and is designed with
extensibility in mind. It follows the extensible syscall pattern we have
used with other syscalls such as openat2(), clone3(),
sched_{set,get}attr(), and others.
The set of mount options is passed in the uapi struct mount_attr which
currently has the following layout:

struct mount_attr {
	__u64 attr_set;
	__u64 attr_clr;
	__u32 propagation;
	__u32 atime;
};

The @attr_set and @attr_clr members are used to clear and set mount
options. This way a user can e.g. request that a set of flags is to be
raised such as turning mounts readonly by raising MOUNT_ATTR_RDONLY in
@attr_set while at the same time requesting that another set of flags is
to be lowered such as removing noexec from a mount tree by specifying
MOUNT_ATTR_NOEXEC in @attr_clr.

The @propagation field lets callers specify the propagation type of a
mount tree. Propagation is a single property that has four different
settings and as such is not really a flag argument but an enum.
Specifically, it would be unclear what setting and clearing propagation
settings in combination would amount to. The legacy mount() syscall thus
forbids the combination of multiple propagation settings too. The goal
is to keep the semantics of mount propagation somewhat simple as they
are overly complex as it is.

Finally, struct mount_attr contains an @atime field which can be used to
set the atime behavior of a mount tree. Currently, access times are
already treated and defined like an enum in the new mount api so there's
no reason to treat them equivalent to a flag argument. A new atime enum
is introduced. The reason for not reusing the atime flags useable with
fsmount() and defined in the new mount api is that the
MOUNT_ATTR_RELATIME enum is defined as 0. This means, a user wanting to
transition to relative atime cannot simply specify MOUNT_ATTR_RELATIME
in @atime or @attr_set as this would mean not specifying any atime
settings is equivalent to specifying relative atime. This would cause
confusion for userspace as not specifying atime settings would switch
them to relatime. The new set of enums rectifies this by starting the
definition at 1 and letting 0 mean that atime settings are supposed to
be left unchanged.

Changing mount option has quite a few moving parts and the locking is
quite intricate so it is not unlikely that I got subtleties (very) wrong.

I've also merged the syscall addition into the individual arches into
the main patch itself since Linus once expressed that he prefers this
wher it makes sense. Manpage and selftests included.

[1]: https://lore.kernel.org/lkml/20200518144212.xpfjlajgwzwhlq7r@wittgenstein/
[2]: https://lore.kernel.org/lkml/CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com/
[3]: https://github.com/moby/moby/issues/37838

Thanks!
Christian

Christian Brauner (4):
  namespace: take lock_mount_hash() directly when changing flags
  namespace: only take read lock in do_reconfigure_mnt()
  fs: add mount_setattr()
  tests: add mount_setattr() selftests

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
 fs/internal.h                                 |   7 +
 fs/namespace.c                                | 300 ++++++-
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/mount.h                    |  31 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/mount_setattr/.gitignore        |   1 +
 .../testing/selftests/mount_setattr/Makefile  |   7 +
 tools/testing/selftests/mount_setattr/config  |   1 +
 .../mount_setattr/mount_setattr_test.c        | 802 ++++++++++++++++++
 27 files changed, 1145 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/mount_setattr/.gitignore
 create mode 100644 tools/testing/selftests/mount_setattr/Makefile
 create mode 100644 tools/testing/selftests/mount_setattr/config
 create mode 100644 tools/testing/selftests/mount_setattr/mount_setattr_test.c


base-commit: dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
-- 
2.27.0

