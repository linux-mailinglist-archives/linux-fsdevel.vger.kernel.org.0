Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CD477BEF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHNR2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjHNR2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:43 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9110D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:42 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-99cb1b83eacso581414366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034120; x=1692638920;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5l+QsaLOamdQtdZNWRx5dwfJH2NfNhSil0AGBzNqbQ=;
        b=MxYMQKX0tKAkAYY763XB6WjWSY5UsteWZWsFgjK++o2hOCH0tYo7pd5oPwVw8YjEt7
         GGv0x6tdfeTJD5+CCgVngp0m4UfKGshelUkXDzj3QwwMkdoj3Gn2eEZ/H4s2C83MzXjv
         SNGZCjADmm0nRDCmTJ10te01Nza285lDw23CzY2HfuEP2Y4rU7KLKl8QBlXSdhebtk2C
         J8r009uW4+uPSXPv/gtQTmK2WwU+NaWS5/ZR75zKCuul3emTJ3XiZJDpttNR0bpw0Xvn
         2BibWrRWKIMqkUkbhq2eXuQ78+nnmFxYaWpe2hFw34obUB59e2oAwj2UMQumFLQZqXlP
         ac7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034120; x=1692638920;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5l+QsaLOamdQtdZNWRx5dwfJH2NfNhSil0AGBzNqbQ=;
        b=YD76NLKpoYuF+aGuBOpEgs2NRaLhsA3sIAn00MSjkhqh+7QpYauVrH71Mn8FcUfsGV
         BRxKHd/dR4m+3ahpJlA/yp1OCJ9QQlAu570vVgO0Rp0DcMp4/AOCZ3bT4QTQDhS/0SKI
         ChQiQmpAuXsTTDGpGJCCVsQ9lJ+aV8Sz5K88eyNRQ5crjnHD3sIr2XpW93li1U1w+iyO
         ca8SMAcGJ5B0F/g1WSvVLreNLquzZDBodwqNk05HS3RBsdGGfAL9c8l8NAmXOSHpgNWo
         PYJTCr36/Jh44AInj4QWQP6uQDJcQcIk5H5oXnbstYuDm463dIrfr/BYImchKDF1fFDY
         PXIw==
X-Gm-Message-State: AOJu0YwFDcRwcWJHwQY+fgyWUyjizS+nGIQjvWFDV3MdiDD/fBz+6tYJ
        KxQwE+U8Oq1+KzOGkgmE4EIQNYIpsvk=
X-Google-Smtp-Source: AGHT+IGWg3IpP0RSlqkJ0MiWjSt+va5EmEZVpaXHnaXupCXQthaUimwM/v7HUlxPMi+qQaA5BEXFBO62RzM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a17:907:1622:b0:99b:cb25:3980 with SMTP id
 hb34-20020a170907162200b0099bcb253980mr105897ejc.2.1692034120668; Mon, 14 Aug
 2023 10:28:40 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:11 +0200
Message-Id: <20230814172816.3907299-1-gnoack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 0/5] Landlock: IOCTL support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

These patches add simple ioctl(2) support to Landlock.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
of ioctl(2) on file descriptors.

We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.

We make an exception for the common and known-harmless IOCTL commands FIOCL=
EX,
FIONCLEX, FIONBIO, FIOASYNC and FIONREAD.  These IOCTL commands are always
permitted.  The functionality of the first four is already available throug=
h
fcntl(2), and FIONREAD only returns the number of ready-to-read bytes.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between Landlock API and implementation
complexity and flexibility when the feature is used.

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

* Existing inherited file descriptors stay unaffected
  when a program enables Landlock.

  This means in particular that in common scenarios,
  the terminal's IOCTLs (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors acquired
  through means other than open(2).  Example: Network sockets,
  memfd_create(2), file descriptors that are already open before the
  Landlock ruleset is enabled.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
here, so we expect that newly opened files outside of $HOME don't work
with ioctl(2).

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

How we arrived at the list of always-permitted IOCTL commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To decide which IOCTL commands should be blanket-permitted I went through t=
he
list of IOCTL commands mentioned in fs/ioctl.c and looked at them individua=
lly
to understand what they are about.  The following list is my conclusion fro=
m
that.

We should always allow the following IOCTL commands:

 * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
   close-on-exec flag
 * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking=
-IO
   and async flags
 * FIONREAD - get the number of bytes available for reading (the implementa=
tion
   is defined per file type)

The first four are also available through fcntl with the F_SETFD and F_SETF=
L
commands.

The following commands mentioned in fs/ioctl.c should be guarded by the
LANDLOCK_ACCESS_FS_IOCTL access right, the same as the other ioctl commands=
,
because they are nontrivial:

 * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
   system. Requires CAP_SYS_ADMIN.
 * FICLONE, FICLONERANGE, FIDEDUPRANGE - making files share physical storag=
e
   between multiple files.  These only work on some file systems, by design=
.
 * Commands that read file system internals:
   * FS_IOC_FIEMAP - get information about file extent mapping
     (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
   * FIBMAP - get a file's file system block number
   * FIGETBSZ - get file system blocksize
 * Accessing file attributes:
   * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflag=
s(2))
   * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes
 * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
   FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS preallocation
   syscalls which predate fallocate(2).

Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee ABI backwards compatibility to the same
extent as Linux does, so it's easier for them to update these lists in
later versions.  It might not be a feasible approach for Linux though.

[2] https://man.openbsd.org/OpenBSD-7.3/pledge.2

Changes
~~~~~~~

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

G=C3=BCnther Noack (5):
  landlock: Add ioctl access right
  selftests/landlock: Test ioctl support
  selftests/landlock: Test ioctl with memfds
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
  landlock: Document ioctl support

 Documentation/userspace-api/landlock.rst     |  74 ++++++++---
 include/uapi/linux/landlock.h                |  31 +++--
 samples/landlock/sandboxer.c                 |  12 +-
 security/landlock/fs.c                       |  38 +++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 133 +++++++++++++++++--
 8 files changed, 249 insertions(+), 45 deletions(-)


base-commit: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
--=20
2.41.0.694.ge786442a9b-goog

