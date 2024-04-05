Return-Path: <linux-fsdevel+bounces-16229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF489A624
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464831C20D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336F174EF3;
	Fri,  5 Apr 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eg/eVVpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB786174EEA
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353260; cv=none; b=eF6eTcwM+YourmAO9NhvQDyrQVcK879USg+bRpyeyQQb2nlB2/hFSjHdGc9ay8Bf5YGhL36ynJT0p1NqzwTZJKtcOdByYTMjk0ZtGl8DqstwUDtxfFOnosM4H3mcWAkt4KRZlzgF1CLwkV++uVOsKxQJFkHPQ/IjUERIGozCrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353260; c=relaxed/simple;
	bh=XW4YB28CPLDRnRRz5pq8im+aIfwGVpE7Ur+1TkiB8H0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HkRvKs6wXhsTHoWnw3/BU1lvapCB8JFBXlUPk2xy1Z2lvN2cOmxeFMncAqLQCz2HVJLR/o9493VoIrvEK2NQIigzj/tR4q74ST61VJVhhVYcNEctHQSbHJOk//p0nLa4D2bjFcxYL07iIXIzwH8gRJuevKeVuxNt7/OQGBwgkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eg/eVVpD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61575fc6d1cso41868517b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353257; x=1712958057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd/fA569wpTtRDSYUWNaDOdA/bZAIsCJPomhesoQ98Y=;
        b=eg/eVVpD1pHuHWlrtYsTv6U6Bi+CXmQycgONm7JFh84CTJqC4HWrAAc3EOFa4LrwDO
         wIPAMC1LjObEqGoa4VzOgZ9X6AHZMsAGdkH6l26lkiA3hkBKHpf/t2qizyqgnuYPR0AJ
         kzt9TsT3FE24yF5KTQQ3s2vTryE9Ud6kUr2IVr7eNu57lLiM/LnRheqfERiUy9ZRdmbu
         5aDinKNrcUdYf9pNg7X5Ng0dopC1L2xpmmKwqS5/zoA4WdEBrkh7c6wiZsPE+D0OBkPL
         gIFLcGeNeR626Xi62Q68b6hIG8kAxb6ZakmSo1rNY6sUZt3GlHC7LXBg+DpJFFsBvlRX
         Ezpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353257; x=1712958057;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd/fA569wpTtRDSYUWNaDOdA/bZAIsCJPomhesoQ98Y=;
        b=X/7EKGcG8Iw06lW/XPgnGcc6H89dSby7ALnEb5dTK5HvADrSX+e5JYeqO29g92OlrP
         dLjiTAd9ibFxoNPCKgb+5l2VqZYvXo54++bPd0X8YIqk9l5jnaNllFWVa8ZTb/WTco+r
         uQppCysNME4+i3F7sxx1SfaX8i9i2TqDUEQ+pnv/gVMKR9yynVCqNsS0Pow6VIP9tKbK
         Axr8Z+/EHIOrhnIq2cu2Id1yLVbAiJSaWfQO2eRdqvplSMPe7nDnG+UeVUpDSiz6aFvB
         e9r1750uNGkc2SboR1D3kO+faKc/4JPZRcdLg0MI35bRDusiNngowCl0pY+D4CKuqxl9
         2bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLMYmkEi2hYFC49BvNUy16HpWtwKXPP2AfxdxT2NLku3aLY+Wem/fWzfAT/D2c1Lodnnl+JF08smTLRulFYVqCBJpCaWq7pw0dJwCf7A==
X-Gm-Message-State: AOJu0YyYGlK1HAuyHMByDo2iH7jprX8g+6iDl7572esr+bsQeeYt/pRe
	hUbt98SX8cZYuZxHkseqL249Aedc+DSdiaa+0RcrxYdVI/wYa4Ljm0Na71gWUQqqZ9aRsuqErwO
	/Kg==
X-Google-Smtp-Source: AGHT+IGMe4+Mv2VpKb4qMCiV88O+31eMVbkWF3MwqD9R8xAhRSXii3Ydw6QzFP7TDCj6qzuTB48ub0WFYos=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:f:b0:615:80c8:94eb with SMTP id
 bc15-20020a05690c000f00b0061580c894ebmr586964ywb.10.1712353257602; Fri, 05
 Apr 2024 14:40:57 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:28 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-1-gnoack@google.com>
Subject: [PATCH v14 00/12] Landlock: IOCTL support
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

Make ioctl(2) requests for device files restrictable with Landlock,
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
FIOASYNC, as well as other IOCTL commands which are implemented in
fs/ioctl.c.  A full list of these IOCTL commands is listed in the
documentation.

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

  This means that in common scenarios, where the terminal file
  descriptor is inherited from the parent process, the terminal's
  IOCTLs (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors for
  non-device files.  Example: Network sockets, memfd_create(2),
  regular files and directories.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL_DEV right is part of the "read-write"
rights here, so we expect that newly opened device files outside of
$HOME don't work with most IOCTL commands.

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

The following commands are also unconditionally permitted by Landlock, beca=
use
they are really operating on the file system's superblock, rather than on t=
he
file itself (the same funcionality is also available from any other file on=
 the
same file system):

 * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
   system. Requires CAP_SYS_ADMIN.
 * FIGETBSZ - get file system blocksize
 * FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH - getting file system properties

Notably, the command FIONREAD is *not* blanket-permitted,
because it would be a device-specific implementation.

Detailed reasoning about each IOCTL command from fs/ioctl.c is in
get_required_ioctl_dev_access() in security/landlock/fs.c.


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


Implementation Rationale
~~~~~~~~~~~~~~~~~~~~~~~~

A main constraint of this implementation is that the blanket-permitted
IOCTL commands for device files should never dispatch to the
device-specific implementations in f_ops->unlocked_ioctl() and
f_ops->compat_ioctl().

There are many implementations of these f_ops operations and they are
too scattered across the kernel to give strong guarantees about them.
Additionally, some existing implementations do work before even
checking whether they support the cmd number which was passed to them.


In this implementation, we are listing the blanket-permitted IOCTL
commands in the Landlock implementation, mirroring a subset of the
IOCTL commands which are directly implemented in do_vfs_ioctl() in
fs/ioctl.c.  The trade-off is that the Landlock LSM needs to track
future developments in fs/ioctl.c to keep up to date with that, in
particular when new IOCTL commands are introduced there, or when they
are moved there from the f_ops implementations.

We mitigate this risk in this patch set by adding fs/ioctl.c to the
paths that are relevant to Landlock in the MAINTAINERS file.

The trade-off is discussed in more detail in [3].


Previous versions of this patch set have used different implementation
approaches to guarantee the main constraint above, which we have
dismissed due to the following reasons:

* V10: Introduced a new LSM hook file_vfs_ioctl, which gets invoked
  just before the call to f_ops->unlocked_ioctl().

  Not done, because it would have created an avoidable overlap between
  the file_ioctl and file_vfs_ioctl LSM hooks [4].

* V11: Introduced an indirection layer in fs/ioctl.c, so that Landlock
  could figure out the list of IOCTL commands which are handled by
  do_vfs_ioctl().

  Not done due to additional indirection and possible performance
  impact in fs/ioctl.c [5]

* V12: Introduced a special error code to be returned from the
  file_ioctl hook, and matching logic that would disallow the call to
  f_ops->unlocked_ioctl() in case that this error code is returned.

  Not done due because this approach would conflict with Landlock's
  planned audit logging [6] and because LSM hooks with special error
  codes are generally discouraged and have lead to problems in the
  past [7].

Thanks to Arnd Bergmann, Christian Brauner, Kent Overstreet, Micka=C3=ABl S=
ala=C3=BCn and
Paul Moore for guiding this implementation on the right track!

[3] https://lore.kernel.org/all/ZgLJG0aN0psur5Z7@google.com/
[4] https://lore.kernel.org/all/CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=
=3DtL1XhVdyg@mail.gmail.com/
[5] https://lore.kernel.org/all/32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fa=
stmail.com
[6] https://lore.kernel.org/all/20240326.ahyaaPa0ohs6@digikod.net
[7] https://lore.kernel.org/all/CAHC9VhQJFWYeheR-EqqdfCq0YpvcQX5Scjfgcz1q+j=
rWg8YsdA@mail.gmail.com/


Changes
~~~~~~~

V14:
 * Revise which IOCTLs are permitted.
   It is almost the same as the vfs_masked_device_ioctl() hooks from
   https://lore.kernel.org/all/20240219183539.2926165-1-mic@digikod.net/,
   with the following differences:
   * Added cases for FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH
   * Do not blanket-permit FS_IOC_{GET,SET}{FLAGS,XATTR}.
     They fall back to the device implementation.
 * fs/ioctl:
   * Small prerequisite change so that FS_IOC_GETFSUUID and
     FS_IOC_GETFSSYSFSPATH do not fall back to the device implementation.
   * Slightly rephrase wording in the warning above do_vfs_ioctl().
 * Implement compat handler
 * Improve UAPI header documentation
 * Code structure
   * Change helper function style to return a boolean
   * Reorder structure of the IOCTL hooks (much cleaner now -- thanks for t=
he
     hint, Micka=C3=ABl!)
   * Extract is_device() helper

V13:
 * Using the existing file_ioctl hook and a hardcoded list of IOCTL command=
s.
   (See the section on implementation rationale above.)
 * Add support for FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH.
  =20
V12:
 * Rebased on Arnd's proposal:
   https://lore.kernel.org/all/32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fas=
tmail.com/
   This means that:
   * the IOCTL security hooks can return a special value ENOFILEOPS,
     which is treated specially in fs/ioctl.c to permit the IOCTL,
     but only as long as it does not call f_ops->unlocked_ioctl or
     f_ops->compat_ioctl.
 * The only change compared to V11 is commit 1, as well as a small
   adaptation in the commit 2 (The Landlock implementation needs to
   return the new special value).  The tests and documentation commits
   are exactly the same as before.

V11:
 * Rebased on Micka=C3=ABl's proposal to refactor fs/ioctl.c:
   https://lore.kernel.org/all/20240315145848.1844554-1-mic@digikod.net/
   This means that:
   * we do not add the file_vfs_ioctl() hook as in V10
   * we add vfs_get_ioctl_handler() instead, so that Landlock
     can query which of the IOCTL commands in handled in do_vfs_ioctl()

   That proposal is used here unmodified (except for minor typos in the com=
mit
   description).
 * Use the hook_ioctl_compat LSM hook as well.

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

V1: https://lore.kernel.org/all/20230502171755.9788-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20230623144329.136541-1-gnoack@google.com/
V3: https://lore.kernel.org/all/20230814172816.3907299-1-gnoack@google.com/
V4: https://lore.kernel.org/all/20231103155717.78042-1-gnoack@google.com/
V5: https://lore.kernel.org/all/20231117154920.1706371-1-gnoack@google.com/
V6: https://lore.kernel.org/all/20231124173026.3257122-1-gnoack@google.com/
V7: https://lore.kernel.org/all/20231201143042.3276833-1-gnoack@google.com/
V8: https://lore.kernel.org/all/20231208155121.1943775-1-gnoack@google.com/
V9: https://lore.kernel.org/all/20240209170612.1638517-1-gnoack@google.com/
V10: https://lore.kernel.org/all/20240309075320.160128-1-gnoack@google.com/
V11: https://lore.kernel.org/all/20240322151002.3653639-1-gnoack@google.com=
/
V12: https://lore.kernel.org/all/20240325134004.4074874-1-gnoack@google.com=
/
V13: https://lore.kernel.org/all/20240327131040.158777-1-gnoack@google.com/

G=C3=BCnther Noack (12):
  fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH
    fail
  landlock: Add IOCTL access right for character and block devices
  selftests/landlock: Test IOCTL support
  selftests/landlock: Test IOCTL with memfds
  selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
  selftests/landlock: Test IOCTLs on named pipes
  selftests/landlock: Check IOCTL restrictions for named UNIX domain
    sockets
  selftests/landlock: Exhaustive test for the IOCTL allow-list
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
  landlock: Document IOCTL support
  MAINTAINERS: Notify Landlock maintainers about changes to fs/ioctl.c
  fs/ioctl: Add a comment to keep the logic in sync with LSM policies

 Documentation/userspace-api/landlock.rst     |  76 ++-
 MAINTAINERS                                  |   1 +
 fs/ioctl.c                                   |   7 +-
 include/uapi/linux/landlock.h                |  38 +-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/fs.c                       | 221 ++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   8 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 491 ++++++++++++++++++-
 10 files changed, 813 insertions(+), 46 deletions(-)


base-commit: e9df9344b6f3e5e1c745a71f125ff4b5c6ddc96b
--=20
2.44.0.478.gd926399ef9-goog


