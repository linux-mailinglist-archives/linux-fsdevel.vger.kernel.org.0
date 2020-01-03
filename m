Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3612FA58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgACQ3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 11:29:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39866 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACQ3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:29:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so16274908plp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjtYs0UBINRJ4+zsLLVMr6kENETZfvFZvXMDxajufTI=;
        b=OHSZ65bRDGA3pSlea/mIUMh4/x/eUVHnSjYPqjrSWQe1HIHWnrT90Ez8p9Yhwz/857
         uAmmm/wDVZ6zgRlBObJhm2qRWglCHL8cr68F/wOiQ58rRY6S33Ip6pfb5bubDMm5Ut9D
         0ffkmMneo7XM01oGFghkFS2/Bv3O7MjYbg6nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjtYs0UBINRJ4+zsLLVMr6kENETZfvFZvXMDxajufTI=;
        b=ZG00yPGOLfupfXQ1smgS2vzjnQw/VTXKgdhpuEhjw+w8t6k39Yiqt+i8nyhNqPyt1H
         omJHFdJ5Fh8lJWLO0tWC9YhY3DY2UkBOUQQQoiGLn1bTs8XG0zuPwzRJa1NjC1RyTuTD
         u15sk6Cz4/9WrZOmxJ6VTk++vaei2TYUBClldi2Itvbq1eHoGnrVoJQm/6UMRaja7EnH
         b2dKHm9GTzdJ3JOLDolkgz6vBqyDXXqO3LzWzPvmQnI6ux+UHmHmKgzObliG5kDtg8YM
         2vm3oyDnBGW6F4v4/onZS8yEwb7oSNhse2Ce8uy5xvKa0/IFUBDRjszoHH5PwT2tRbDX
         qaRA==
X-Gm-Message-State: APjAAAXXQFMJ8PkG1lWsinmW9NgXfuzrBZxjNoggXOShIHlMV3FIiQqJ
        bwj4i9uLJWe6dbcnb1itzhinzg==
X-Google-Smtp-Source: APXvYqxgDqGdS6beRqsWT3wx3IkYkSpOQVLFgAnGl1qpFlaigdh9WdUHvgEazdhdeNpP7mAVwFmyiQ==
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr87107883plm.26.1578068982189;
        Fri, 03 Jan 2020 08:29:42 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m22sm67373970pgn.8.2020.01.03.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:29:41 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v8 0/3] Add pidfd_getfd syscall
Date:   Fri,  3 Jan 2020 08:29:25 -0800
Message-Id: <20200103162928.5271-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset introduces a mechanism (pidfd_getfd syscall) to get file
descriptors from other processes via pidfd. Although this can be achieved
using SCM_RIGHTS, and parasitic code injection, this offers a more
straightforward mechanism, with less overhead and complexity. The process
under manipulation's fd still remains valid, and unmodified by the
copy operation.

It introduces a flags field. The flags field is reserved a the moment,
but the intent is to extend it with the following capabilities:
 * Close the remote FD when copying it
 * Drop the cgroup data if it's a fd pointing a socket when copying it

The syscall numbers were chosen to be one greater than openat2.

Summary of history:
This initially started as a ptrace command. It did not require the process
to be stopped, and felt like kind of an awkward fit for ptrace. After that,
it moved to an ioctl on the pidfd. Given functionality, it made sense to
make it a syscall which did not require the process to be stopped.

Previous versions:
 V7: https://lore.kernel.org/lkml/20191226180227.GA29389@ircssh-2.c.rugged-nimbus-611.internal/
 V6: https://lore.kernel.org/lkml/20191223210823.GA25083@ircssh-2.c.rugged-nimbus-611.internal/
 V5: https://lore.kernel.org/lkml/20191220232746.GA20215@ircssh-2.c.rugged-nimbus-611.internal/
 V4: https://lore.kernel.org/lkml/20191218235310.GA17259@ircssh-2.c.rugged-nimbus-611.internal/
 V3: https://lore.kernel.org/lkml/20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal/
 V2: https://lore.kernel.org/lkml/20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal/
 RFC V1: https://lore.kernel.org/lkml/20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal/

Changes since v7:
 * No longer put security_file_recv at the end, and align with other
   usages of putting it at the end of the file_recv.
 * Rewrite self-tests in kselftest harness.
 * Minor refactoring

Changes since v6:
 * Proper attribution of get_task_file helper
 * Move all types for syscall to int to represent fd

Changes since v5:
 * Drop pidfd_getfd_options struct and replace with a flags field

Changes since v4:
 * Turn into a syscall
 * Move to PTRACE_MODE_ATTACH_REALCREDS from PTRACE_MODE_READ_REALCREDS
 * Remove the sample code. This will come in another patchset, as the
   new self-tests cover all the functionality.

Changes since v3:
 * Add self-test
 * Move to ioctl passing fd directly, versus args struct
 * Shuffle around include files

Changes since v2:
 * Move to ioctl on pidfd instead of ptrace function
 * Add security check before moving file descriptor

Changes since the RFC v1:
 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (3):
  vfs, fdtable: Add get_task_file helper
  pid: Introduce pidfd_getfd syscall
  test: Add test for pidfd getfd

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
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
 fs/file.c                                     |  22 +-
 include/linux/file.h                          |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 kernel/pid.c                                  |  90 +++++++
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   4 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 227 ++++++++++++++++++
 26 files changed, 365 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

-- 
2.20.1

