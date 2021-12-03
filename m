Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB646754C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbhLCKqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:11 -0500
Received: from foss.arm.com ([217.140.110.172]:46902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351699AbhLCKqK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F20D1435;
        Fri,  3 Dec 2021 02:42:46 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9934B3F5A1;
        Fri,  3 Dec 2021 02:42:43 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 00/14] fs/proc/vmcore: Remove unnecessary user pointer conversions 
Date:   Fri,  3 Dec 2021 16:12:17 +0530
Message-Id: <20211203104231.17597-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series aims to restructure the external interfaces as well internal
code used in fs/proc/vmcore.c by removing the interchangeable use of user
and kernel pointers. This unnecessary conversion may obstruct the tools
such as sparse in generating meaningful results. This also simplifies
the things by keeping the user and kernel pointers separate during
propagation.

The external interfaces such as copy_oldmem_page, copy_oldmem_page_encrypted
and read_from_oldmem are used across different architectures. The goal
here is to update one architecture at a time and hence there is an extra
cleanup done in the end to remove the intermediaries.

In this series, an extra user pointer is added as a parameter to all the
above functions instead of an union as there were disagreement in earlier ideas
of using universal pointer [1,2]. This series is posted as RFC so as to
find out an acceptable way of handling this use case.

This series is based on v5.16-rc3 and is compile tested for modified
architectures and boot tested in qemu for all architectures except ia64.

Note: This patch series breaks the crash dump functionality after patch
3 and is restored after each arch implements its own
copy_oldmem_page_buf() interface.

Thanks,
Amit Daniel

[1]: https://lore.kernel.org/lkml/20200624162901.1814136-2-hch@lst.de/
[2]: https://lore.kernel.org/lkml/CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com/

Amit Daniel Kachhap (14):
  fs/proc/vmcore: Update read_from_oldmem() for user pointer
  fs/proc/vmcore: Update copy_oldmem_page_encrypted() for user buffer
  fs/proc/vmcore: Update copy_oldmem_page() for user buffer
  x86/crash_dump_64: Use the new interface copy_oldmem_page_buf
  x86/crash_dump_32: Use the new interface copy_oldmem_page_buf
  arm64/crash_dump: Use the new interface copy_oldmem_page_buf
  arm/crash_dump: Use the new interface copy_oldmem_page_buf
  mips/crash_dump: Use the new interface copy_oldmem_page_buf
  sh/crash_dump: Use the new interface copy_oldmem_page_buf
  riscv/crash_dump: Use the new interface copy_oldmem_page_buf
  powerpc/crash_dump: Use the new interface copy_oldmem_page_buf
  ia64/crash_dump: Use the new interface copy_oldmem_page_buf
  s390/crash_dump: Use the new interface copy_oldmem_page_buf
  fs/proc/vmcore: Remove the unused old interface copy_oldmem_page

 arch/arm/kernel/crash_dump.c     | 21 ++++----
 arch/arm64/kernel/crash_dump.c   | 21 ++++----
 arch/ia64/kernel/crash_dump.c    | 25 +++++-----
 arch/mips/kernel/crash_dump.c    | 24 ++++-----
 arch/powerpc/kernel/crash_dump.c | 33 +++++++------
 arch/riscv/kernel/crash_dump.c   | 25 +++++-----
 arch/s390/kernel/crash_dump.c    | 12 ++---
 arch/sh/kernel/crash_dump.c      | 25 +++++-----
 arch/x86/kernel/crash_dump_32.c  | 24 ++++-----
 arch/x86/kernel/crash_dump_64.c  | 48 +++++++++---------
 fs/proc/vmcore.c                 | 85 +++++++++++++++++---------------
 include/linux/crash_dump.h       | 23 +++++----
 12 files changed, 189 insertions(+), 177 deletions(-)

-- 
2.17.1

