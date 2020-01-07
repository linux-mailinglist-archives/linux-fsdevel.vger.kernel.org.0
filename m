Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F91132DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGR7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:59:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgAGR7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:59:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so236983pga.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+lDQbpVYj7+3hOzgYRBGgCRI9V3/aLmWBx0c90vo9Q=;
        b=O9Qg9iekpvnSfzQ40a812uua0q0S8PQDjlBeyTrvT/JrHk2KWKerQ1kCQxvkFzOsz+
         VFbNcxc8dA9rfiCwEtlIElhkMdhY725BfCrXTMwxvc6+ZqF++jzpXrvW5uTQhVmHjC3I
         GF/k8nYeI7XIK7F4kD8DTk5xqdmZv0LFykEZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+lDQbpVYj7+3hOzgYRBGgCRI9V3/aLmWBx0c90vo9Q=;
        b=J99ir3RSWiLh2Oth9aGiXkPk4erefzAFd1AYNLdlPPGtu6+IJUCGRhqVyfleyFhbmL
         h9Hd5uFQzLRoy6FsyUrxKTDn86XxgAXq7RFnZk0Rgu43MkXBMdU/cyw4V/ROP7Q116Zq
         rfkEO619BwawV9fzSZmlee1zqkE0upEoUTXOJZ0IszqwZ6toEweigyvWcu7PEEPrAlk5
         N0kVnuPkkcVhWabz/jRZv9hvwjqZfi4DmW55LODUBF2CKI42HtpmBf45RBoEXi6cK9IQ
         dWlfxrbrZzTBBjvfOaTspIykZFI3GuURBIBxxaIkY+d+fxVStosP+2f9SWCTdikJKUbB
         Acsg==
X-Gm-Message-State: APjAAAX1f2mnhlp5LSNOecybeMWGyMfWExeC+qFZ53TOTUjMRovxdrWV
        Lz6giQc03tvZYEITxLF6rmGE6Q==
X-Google-Smtp-Source: APXvYqzVECWqoOVyp/kktUAZ0xSYlbvmZNRqSIgSZUwpij0riNvR3b01eRsabah/C0cxwAL2MC9RHw==
X-Received: by 2002:a62:a515:: with SMTP id v21mr463508pfm.128.1578419973186;
        Tue, 07 Jan 2020 09:59:33 -0800 (PST)
Received: from ubuntu.netflix.com (166.sub-174-194-208.myvzw.com. [174.194.208.166])
        by smtp.gmail.com with ESMTPSA id g7sm210324pfq.33.2020.01.07.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:59:32 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v9 0/4] Add pidfd_getfd syscall
Date:   Tue,  7 Jan 2020 09:59:23 -0800
Message-Id: <20200107175927.4558-1-sargun@sargun.me>
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
it moved to an ioctl on the pidfd. Given the core functionality, it made
sense to make it a syscall which did not require the process to be stopped.

Previous versions:
 V8: https://lore.kernel.org/lkml/20200103162928.5271-1-sargun@sargun.me/
 V7: https://lore.kernel.org/lkml/20191226180227.GA29389@ircssh-2.c.rugged-nimbus-611.internal/
 V6: https://lore.kernel.org/lkml/20191223210823.GA25083@ircssh-2.c.rugged-nimbus-611.internal/
 V5: https://lore.kernel.org/lkml/20191220232746.GA20215@ircssh-2.c.rugged-nimbus-611.internal/
 V4: https://lore.kernel.org/lkml/20191218235310.GA17259@ircssh-2.c.rugged-nimbus-611.internal/
 V3: https://lore.kernel.org/lkml/20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal/
 V2: https://lore.kernel.org/lkml/20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal/
 RFC V1: https://lore.kernel.org/lkml/20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal/

Changes since v8:
 * Cleanup / comments on tests
 * Split out implementation of syscall vs. arch wiring

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

Sargun Dhillon (4):
  vfs, fdtable: Add fget_task helper
  pid: Implement pidfd_getfd syscall
  arch: wire up pidfd_getfd syscall
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
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 tools/testing/selftests/pidfd/pidfd.h         |   9 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 249 ++++++++++++++++++
 27 files changed, 395 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

-- 
2.20.1

