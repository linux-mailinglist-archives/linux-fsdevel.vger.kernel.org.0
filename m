Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C428AC7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgJLD1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 23:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgJLD1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:27:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE9C0613CE;
        Sun, 11 Oct 2020 20:27:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRoV2-00Fkpi-Oy; Mon, 12 Oct 2020 03:27:48 +0000
Date:   Mon, 12 Oct 2020 04:27:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] vfs.git mount compat series
Message-ID: <20201012032748.GH3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The last remnants of mount(2) compat buried.  Buried into NFS, that is;
generally I'm less enthusiastic about "let's use in_compat_syscall() deep in
call chain" kind of approach than Christoph seems to be, but in this case it's
warranted - that crap had been an NFS-specific wart, hopefully not to be repeated
in any other filesystems (read: any new filesystem introducing non-text mount
options will get NAKed even if it doesn't fuck the layout up).  Not worth trying
to grow an infrastructure that would avoid that use of in_compat_syscall()...
	[Note: alpha-related tail of the series got dropped]

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git compat.mount

for you to fetch changes up to 028abd9222df0cf5855dab5014a5ebaf06f90565:

  fs: remove compat_sys_mount (2020-09-22 23:45:57 -0400)

----------------------------------------------------------------
Christoph Hellwig (3):
      nfs: simplify nfs4_parse_monolithic
      fs,nfs: lift compat nfs4 mount data handling into the nfs code
      fs: remove compat_sys_mount

 arch/arm64/include/asm/unistd32.h                  |   2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   2 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |   2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |   2 +-
 arch/s390/kernel/syscalls/syscall.tbl              |   2 +-
 arch/sparc/kernel/syscalls/syscall.tbl             |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl             |   2 +-
 fs/Makefile                                        |   1 -
 fs/compat.c                                        | 132 --------------
 fs/internal.h                                      |   3 -
 fs/namespace.c                                     |   4 +-
 fs/nfs/fs_context.c                                | 195 +++++++++++++--------
 include/linux/compat.h                             |   6 -
 include/uapi/asm-generic/unistd.h                  |   2 +-
 tools/include/uapi/asm-generic/unistd.h            |   2 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   2 +-
 18 files changed, 138 insertions(+), 227 deletions(-)
 delete mode 100644 fs/compat.c
