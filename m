Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD328AC62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 05:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgJLDRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 23:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgJLDRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:17:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF51C0613CE;
        Sun, 11 Oct 2020 20:17:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRoKw-00FkYp-70; Mon, 12 Oct 2020 03:17:22 +0000
Date:   Mon, 12 Oct 2020 04:17:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] vfs.git iov_iter series
Message-ID: <20201012031722.GF3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Christoph's series around import_iovec() and compat variant thereof.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

for you to fetch changes up to 5d47b394794d3086c1c338cc014011a9ee34005c:

  security/keys: remove compat_keyctl_instantiate_key_iov (2020-10-03 00:02:16 -0400)

----------------------------------------------------------------
Christoph Hellwig (8):
      compat.h: fix a spelling error in <linux/compat.h>
      iov_iter: refactor rw_copy_check_uvector and import_iovec
      iov_iter: transparently handle compat iovecs in import_iovec
      fs: remove various compat readv/writev helpers
      fs: remove the compat readv/writev syscalls
      fs: remove compat_sys_vmsplice
      mm: remove compat_process_vm_{readv,writev}
      security/keys: remove compat_keyctl_instantiate_key_iov

David Laight (1):
      iov_iter: move rw_copy_check_uvector() into lib/iov_iter.c

 arch/arm64/include/asm/unistd32.h                  |  10 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl          |  10 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl          |  10 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |  10 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |  10 +-
 arch/s390/kernel/syscalls/syscall.tbl              |  10 +-
 arch/sparc/kernel/syscalls/syscall.tbl             |  10 +-
 arch/x86/entry/syscall_x32.c                       |   5 +
 arch/x86/entry/syscalls/syscall_32.tbl             |  10 +-
 arch/x86/entry/syscalls/syscall_64.tbl             |  10 +-
 block/scsi_ioctl.c                                 |  12 +-
 drivers/scsi/sg.c                                  |   9 +-
 fs/aio.c                                           |   8 +-
 fs/io_uring.c                                      |  20 +-
 fs/read_write.c                                    | 362 ++-------------------
 fs/splice.c                                        |  57 +---
 include/linux/compat.h                             |  50 +--
 include/linux/fs.h                                 |  13 -
 include/linux/uio.h                                |  20 +-
 include/uapi/asm-generic/unistd.h                  |  12 +-
 lib/iov_iter.c                                     | 178 +++++++---
 mm/process_vm_access.c                             |  86 +----
 net/compat.c                                       |   4 +-
 security/keys/compat.c                             |  37 +--
 security/keys/internal.h                           |   5 -
 security/keys/keyctl.c                             |   2 +-
 tools/include/uapi/asm-generic/unistd.h            |  12 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  10 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  10 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  10 +-
 30 files changed, 298 insertions(+), 714 deletions(-)
