Return-Path: <linux-fsdevel+bounces-14042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CAA876F8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957B51C20C41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFEF3714C;
	Sat,  9 Mar 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvPB9L1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE8208A8
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970808; cv=none; b=LXREV5EEp9+R2PRZxV5fjW+x5Yj2isnpfzdHK+WFlZw3+jNu73U7VOIdJGDKwOYfOZqp8IRBqjGqBB9BFReGJHDjIui8i2rxP1Ora1yIgymukmAbb89JzEqJuOkuOidnJx0v3LP90aO8uSl2dY2T2NQICuCd3MqUvJ+F0hwm8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970808; c=relaxed/simple;
	bh=qoFW8DZBq91sTZr7j0ROS++/7rTnESnP/y/mqKeQUlY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=alwGT/WUcgluapdoz/R0OnWOP0DSf8PtMR00fD6CdU2cAf+5lJ1+oFQpLMXzG9DbqwOjpxv1PmUm5i1sBPK2BwaJdertlPtkZDus0HQ4jIsuc26tNWbByetZUNO+eCCfX2zXSW6fP8GZkadKvW6UoGghsvcy3rNKjxDHUf95EYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvPB9L1/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b282961so15823887b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970805; x=1710575605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUYBKLmZK+2vqITBGbW9SoUgTbWfduo3D1Swglk29sA=;
        b=rvPB9L1/36sJa26D5bChqAHeqlkvCF/M5KcZysbdOJpBk3bZFKsMy2EkzAmk8kBJAX
         klhTUJUthnTFlWeOSXIWooxoHPMzE3NGSmgHKqWyPPpL7wZhs3gxjLIkIEWVAsiI3t7W
         ExTTx2qiUAXSUBs9md4J9yHnktO4CUP9SFLjhtQe8HIgQtkbZin+r6askxIxgQ5GCZDT
         FiYYsBkRXswd7fXOtsxG5b+q+RNOB0Eob0j77oVVhNmT36lVZKHiNDN3Nnb9joiaPHCC
         EJtm+YDV+znHnUlGXdYWfW6r7OVLleSFei2MUpoyJl0XsIJI+yO9+k0bNCbHsseWheY1
         OYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970805; x=1710575605;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUYBKLmZK+2vqITBGbW9SoUgTbWfduo3D1Swglk29sA=;
        b=en18iCaC3gxJFMfIB4kWFAAIszdl8aAhLE/BZ0STTlLuZ67sBjjGa99X3HmVTImTj3
         3ihxpn2wUENTaPLLv6z7G7lZN/t8seB0h04jMyCBOqZ422GbWYt3jbysQMOE4t5ZS9M6
         ccvoxCc+FCGKp2y3k5NeFxne1EpgH6iE1Gnhqjif0PtUUi6jMRDhRKfG6VrN86SxiFa+
         ovs0dkG5xWm+SYScBAzPN1AYZpjpmi2VsEcDcegWoS05vKdbNYkwT1MH5/N6dC1WWjIc
         zijrssKvrDepgipbtEXVPHsO+XnXRV33x7sA50qsRKbRwVUeVHqW49F25dbniKJIlXx1
         BCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX++KVBEymu6rRecTThM7NZatCMKXbO9XU9eGClqJShh71/bJW58OVOItSyQjGMzda5AWIINE7vdfTkqq82Vr1KHXlkrVPlz/16G5WQ+Q==
X-Gm-Message-State: AOJu0YxZ0gX+rn1SFVasylLworR7LYaHH2VC5xyo9A+Zz5d1iOgA/WZQ
	h/6xwfHQWJzExyA6UsqiCil+zmhHrKPtqxqp5lbMOHTyBcmPeSPDDbv8KrL2JmWJjmR4KW0vQ/s
	zyw==
X-Google-Smtp-Source: AGHT+IGcmoevZxPeXRFgH7fd8jWtjB2zkV5Ec7XXyB155F0fwkXnm2TYruPU72pmHn0IyaWQME2zsBkqiJw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a0d:cb86:0:b0:608:1b39:245c with SMTP id
 n128-20020a0dcb86000000b006081b39245cmr441832ywd.9.1709970805062; Fri, 08 Mar
 2024 23:53:25 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:11 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-1-gnoack@google.com>
Subject: [PATCH v10 0/9] Landlock: IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

These patches add simple ioctl(2) support to Landlock.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL_DEV right, which restricts the
use of ioctl(2) on block and character devices.

We attach the this access right to opened file descriptors, as we
already do for LANDLOCK_ACCESS_FS_TRUNCATE.

If LANDLOCK_ACCESS_FS_IOCTL_DEV is handled (restricted in the
ruleset), the LANDLOCK_ACCESS_FS_IOCTL_DEV right governs the use of
all device-specific IOCTL commands.  We make exceptions for common and
known-harmless IOCTL commands such as FIOCLEX, FIONCLEX, FIONBIO and
FIOASYNC, as well as other IOCTL commands for regular files, which are
implemented in fs/ioctl.c.  A full list of these IOCTL commands is
listed in the documentation.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between complexity of the Landlock API and
implementation and flexibility when the feature is used.

Current limitations
~~~~~~~~~~~~~~~~~~~

With this patch set, ioctl(2) requests can *not* be filtered based on
file type, device number (dev_t) or on the ioctl(2) request number.

On the initial RFC patch set [1], we have reached consensus to start
with this simpler coarse-grained approach, and build additional IOCTL
restriction capabilities on top in subsequent steps.

[1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2=
a0c023dd761@digikod.net/

Notable implications of this approach
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* A processes' existing open file descriptors stay unaffected
  when a process enables Landlock.

  This means in particular that in common scenarios,
  the terminal's IOCTLs (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors for
  non-device files.  Example: Network sockets, memfd_create(2).

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL_DEV right is part of the "read-write"
rights here, so we expect that newly opened files outside of $HOME
don't work with most IOCTL commands.

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

Unaffected IOCTL commands
~~~~~~~~~~~~~~~~~~~~~~~~~

To decide which IOCTL commands should be blanket-permitted, we went
through the list of IOCTL commands which are handled directly in
fs/ioctl.c and looked at them individually to understand what they are
about.

The following commands are permitted by Landlock unconditionally:

 * FIOCLEX, FIONCLEX - these work on the file descriptor and
   manipulate the close-on-exec flag (also available through
   fcntl(2) with F_SETFD)
 * FIONBIO, FIOASYNC - these work on the struct file and enable
   nonblocking-IO and async flags (also available through
   fcntl(2) with F_SETFL)

The following commands are also technically permitted by Landlock
unconditionally, but are not supported by device files.  By permitting
them in Landlock on device files, we naturally return the normal error
code.

 * FIOQSIZE - get the size of the opened file or directory
 * FIBMAP - get the file system block numbers underlying a file
 * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
   FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS
   preallocation syscalls which predate fallocate(2).

The following commands are also technically permitted by Landlock, but
they are really operating on the file system's superblock, rather than
on the file itself:

 * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
   system. Requires CAP_SYS_ADMIN.
 * FIGETBSZ - get file system blocksize

The following commands are technically permitted by Landlock:

 * FS_IOC_FIEMAP - get information about file extent mapping
   (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
 * FIDEDUPERANGE, FICLONE, FICLONERANGE - manipulating shared physical stor=
age
   between multiple files.  These only work on some COW file systems, by de=
sign.
 * Accessing file attributes:
   * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflag=
s(2))
   * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes

Notably, the command FIONREAD is *not* blanket-permitted,
because it would be a device-specific implementation.


Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee backwards compatibility to the same extent
as Linux does, so it's easier for them to update these lists in later
versions.  It might not be a feasible approach for Linux though.

[2] https://man.openbsd.org/OpenBSD-7.4/pledge.2


Open Questions
~~~~~~~~~~~~~~

 * Is it OK to introduce the LSM file_vfs_ioctl hook?

 * We may need to revise the tests that we added in V9 and before,
   so of them probably don't make sense any more.


Changes
~~~~~~~

V10:
 * Major change: only restrict IOCTL invocations on device files
   * Rename access right to LANDLOCK_ACCESS_FS_IOCTL_DEV
   * Remove the notion of synthetic access rights and IOCTL right groups
 * Introduce a new LSM hook file_vfs_ioctl, which gets invoked just
   before the call to f_ops->unlocked_ioctl()
 * Documentation
   * Various complications were removed or simplified:
     * Suggestion to mount file systems as nodev is not needed any more,
       as Landlock already lets users distinguish device files.
     * Remarks about fscrypt were removed.  The fscrypt-related IOCTLs only
       applied to regular files and directories, so this patch does not aff=
ect
       them any more.
     * Various documentation of the IOCTL grouping approach was removed,
       as it's not needed any more.

V9:
 * in =E2=80=9Clandlock: Add IOCTL access right=E2=80=9D:
   * Change IOCTL group names and grouping as discussed with Micka=C3=ABl.
     This makes the grouping coarser, and we occasionally rely on the
     underlying implementation to perform the appropriate read/write
     checks.
     * Group IOCTL_RW (one of READ_FILE, WRITE_FILE or READ_DIR):
       FIONREAD, FIOQSIZE, FIGETBSZ
     * Group IOCTL_RWF (one of READ_FILE or WRITE_FILE):
       FS_IOC_FIEMAP, FIBMAP, FIDEDUPERANGE, FICLONE, FICLONERANGE,
       FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
       FS_IOC_ZERO_RANGE
   * Excempt pipe file descriptors from IOCTL restrictions,
     even for named pipes which are opened from the file system.
     This is to be consistent with anonymous pipes created with pipe(2).
     As discussed in https://lore.kernel.org/r/ZP7lxmXklksadvz+@google.com
   * Document rationale for the IOCTL grouping in the code
   * Use __attribute_const__
   * Rename required_ioctl_access() to get_required_ioctl_access()
 * Selftests
   * Simplify IOCTL test fixtures as a result of simpler grouping.
   * Test that IOCTLs are permitted on named pipe FDs.
   * Test that IOCTLs are permitted on named Unix Domain Socket FDs.
   * Work around compilation issue with old GCC / glibc.
     https://sourceware.org/glibc/wiki/Synchronizing_Headers
     Thanks to Huyadi <hu.yadi@h3c.com>, who pointed this out in
     https://lore.kernel.org/all/f25be6663bcc4608adf630509f045a76@h3c.com/
     and Micka=C3=ABl, who fixed it through #include reordering.
 * Documentation changes
   * Reword "IOCTL commands" section a bit
   * s/permit/allow/
   * s/access right/right/, if preceded by LANDLOCK_ACCESS_FS_*
   * s/IOCTL/FS_IOCTL/ in ASCII table
   * Update IOCTL grouping documentation in header file
 * Removed a few of the earlier commits in this patch set,
   which have already been merged.

V8:
 * Documentation changes
   * userspace-api/landlock.rst:
     * Add an extra paragraph about how the IOCTL right combines
       when used with other access rights.
     * Explain better the circumstances under which passing of
       file descriptors between different Landlock domains can happen
   * limits.h: Add comment to explain public vs internal FS access rights
   * Add a paragraph in the commit to explain better why the IOCTL
     right works as it does

V7:
 * in =E2=80=9Clandlock: Add IOCTL access right=E2=80=9D:
   * Make IOCTL_GROUPS a #define so that static_assert works even on
     old compilers (bug reported by Intel about PowerPC GCC9 config)
   * Adapt indentation of IOCTL_GROUPS definition
   * Add missing dots in kernel-doc comments.
 * in =E2=80=9Clandlock: Remove remaining "inline" modifiers in .c files=E2=
=80=9D:
   * explain reasoning in commit message

V6:
 * Implementation:
   * Check that only publicly visible access rights can be used when adding=
 a
     rule (rather than the synthetic ones).  Thanks Micka=C3=ABl for spotti=
ng that!
   * Move all functionality related to IOCTL groups and synthetic access ri=
ghts
     into the same place at the top of fs.c
   * Move kernel doc to the .c file in one instance
   * Smaller code style issues (upcase IOCTL, vardecl at block start)
   * Remove inline modifier from functions in .c files
 * Tests:
   * use SKIP
   * Rename 'fd' to dir_fd and file_fd where appropriate
   * Remove duplicate "ioctl" mentions from test names
   * Rename "permitted" to "allowed", in ioctl and ftruncate tests
   * Do not add rules if access is 0, in test helper

V5:
 * Implementation:
   * move IOCTL group expansion logic into fs.c (implementation suggested b=
y
     mic)
   * rename IOCTL_CMD_G* constants to LANDLOCK_ACCESS_FS_IOCTL_GROUP*
   * fs.c: create ioctl_groups constant
   * add "const" to some variables
 * Formatting and docstring fixes (including wrong kernel-doc format)
 * samples/landlock: fix ABI version and fallback attribute (mic)
 * Documentation
   * move header documentation changes into the implementation commit
   * spell out how FIFREEZE, FITHAW and attribute-manipulation ioctls from
     fs/ioctl.c are handled
   * change ABI 4 to ABI 5 in some missing places

V4:
 * use "synthetic" IOCTL access rights, as previously discussed
 * testing changes
   * use a large fixture-based test, for more exhaustive coverage,
     and replace some of the earlier tests with it
 * rebased on mic-next

V3:
 * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC an=
d
   FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
 * increment ABI version in the same commit where the feature is introduced
 * testing changes
   * use FIOQSIZE instead of TTY IOCTL commands
     (FIOQSIZE works with regular files, directories and memfds)
   * run the memfd test with both Landlock enabled and disabled
   * add a test for the always-permitted IOCTL commands

V2:
 * rebased on mic-next
 * added documentation
 * exercise ioctl(2) in the memfd test
 * test: Use layout0 for the test

---

V1: https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gno=
ack3000@gmail.com/
V2: https://lore.kernel.org/linux-security-module/20230623144329.136541-1-g=
noack@google.com/
V3: https://lore.kernel.org/linux-security-module/20230814172816.3907299-1-=
gnoack@google.com/
V4: https://lore.kernel.org/linux-security-module/20231103155717.78042-1-gn=
oack@google.com/
V5: https://lore.kernel.org/linux-security-module/20231117154920.1706371-1-=
gnoack@google.com/
V6: https://lore.kernel.org/linux-security-module/20231124173026.3257122-1-=
gnoack@google.com/
V7: https://lore.kernel.org/linux-security-module/20231201143042.3276833-1-=
gnoack@google.com/
V8: https://lore.kernel.org/linux-security-module/20231208155121.1943775-1-=
gnoack@google.com/
V9: https://lore.kernel.org/linux-security-module/20240209170612.1638517-1-=
gnoack@google.com/

G=C3=BCnther Noack (9):
  security: Create security_file_vfs_ioctl hook
  landlock: Add IOCTL access right for character and block devices
  selftests/landlock: Test IOCTL support
  selftests/landlock: Test IOCTL with memfds
  selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
  selftests/landlock: Test IOCTLs on named pipes
  selftests/landlock: Check IOCTL restrictions for named UNIX domain
    sockets
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
  landlock: Document IOCTL support

 Documentation/userspace-api/landlock.rst     |  76 +++-
 fs/ioctl.c                                   |  14 +-
 include/linux/lsm_hook_defs.h                |   2 +
 include/linux/security.h                     |   8 +
 include/uapi/linux/landlock.h                |  35 +-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/fs.c                       |  38 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   8 +-
 security/security.c                          |  22 +
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 407 ++++++++++++++++++-
 12 files changed, 581 insertions(+), 46 deletions(-)


base-commit: d8482176c8c319b11d683913f780d63b44257d0f
--=20
2.44.0.278.ge034bb2e1d-goog


