Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251BC21D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfEQShR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:17 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57552 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000nf-AO; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/22] Coda updates
Date:   Fri, 17 May 2019 14:36:38 -0400
Message-Id: <cover.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch series is a collection of various fixes for Coda,
most of which were collected from linux-fsdevel or linux-kernel but
which have as yet not found their way upstream.

I've previously sent these March 20th, one of those patched is now
dropped as it got merged independently but there is a new patch in this
series that fixes a memory corruption when a Coda file is mmapped.


Arnd Bergmann (1):
  coda: stop using 'struct timespec' in user API

Colin Ian King (1):
  coda: clean up indentation, replace spaces with tab

Dan Carpenter (2):
  coda: get rid of CODA_ALLOC()
  coda: get rid of CODA_FREE()

David Howells (1):
  coda: Move internal defs out of include/linux/ [ver #2]

Fabian Frederick (6):
  coda: destroy mutex in put_super()
  coda: use SIZE() for stat
  coda: add __init to init_coda_psdev()
  coda: remove sysctl object from module when unused
  coda: remove sb test in coda_fid_to_inode()
  coda: ftoc validity check integration

Jan Harkes (7):
  coda: pass the host file in vma->vm_file on mmap
  coda: potential buffer overflow in coda_psdev_write()
  coda: don't try to print names that were considered too long
  uapi linux/coda_psdev.h: Move CODA_REQ_ from uapi to kernel side
    headers
  coda: change Coda's user api to use 64-bit time_t in timespec
  coda: bump module version
  coda: remove uapi/linux/coda_psdev.h

Mikko Rapeli (2):
  uapi linux/coda.h: use __kernel_pid_t for userspace
  uapi linux/coda_psdev.h: move upc_req definition from uapi to kernel
    side headers

Sam Protsenko (1):
  coda: Fix build using bare-metal toolchain

Zhouyang Jia (1):
  coda: add error handling for fget

 Documentation/filesystems/coda.txt      | 11 +--
 fs/coda/Makefile                        |  3 +-
 fs/coda/cache.c                         |  2 +-
 fs/coda/cnode.c                         | 17 +++--
 fs/coda/coda_fs_i.h                     |  3 +-
 fs/coda/coda_int.h                      | 10 +++
 fs/coda/coda_linux.c                    | 45 +++++++++----
 fs/coda/coda_linux.h                    | 16 -----
 {include/linux => fs/coda}/coda_psdev.h | 52 +++++++++-----
 fs/coda/dir.c                           | 12 ++--
 fs/coda/file.c                          | 90 ++++++++++++++++++++-----
 fs/coda/inode.c                         |  3 +-
 fs/coda/pioctl.c                        |  3 +-
 fs/coda/psdev.c                         | 36 ++++++----
 fs/coda/symlink.c                       |  3 +-
 fs/coda/sysctl.c                        | 11 ---
 fs/coda/upcall.c                        | 78 ++++++++++++++-------
 include/linux/coda.h                    |  3 +-
 include/uapi/linux/coda.h               | 29 ++++----
 include/uapi/linux/coda_psdev.h         | 28 --------
 20 files changed, 274 insertions(+), 181 deletions(-)
 rename {include/linux => fs/coda}/coda_psdev.h (62%)
 delete mode 100644 include/uapi/linux/coda_psdev.h

-- 
2.20.1

