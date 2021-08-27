Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E33F992D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhH0Mu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 08:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhH0Mu1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:50:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD0B60560;
        Fri, 27 Aug 2021 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630068578;
        bh=7X1FUZPYHV8C/LDg1yLAoXkgfZziyq7WviwzthMoZ3o=;
        h=Subject:From:To:Cc:Date:From;
        b=DsssK88JcIB3FT5QVQnCZODM+PJnPwHDH/U/0e9vkxRnD8K8hBfpcnN4LpP6JXSAR
         sCfV3sjUHG6GONVH/UrEINJIis1iROthypbM0xLh4RkEcLUwAGNVT/Cd+vNS6mYj7u
         IME8XZ04T4pIpt29Lb+IqcFfm8JmKOmSMHoEK87uCpsLf/UuAq65OQT01Uh7IPq9Ci
         MqvHMC44SMh5Pnj/tm2nUItpBNoQPokNqOdoNb0R3Qr/m6rrwnOzwpP0UAi049sjED
         bYAuDJkDy57G29xkJpa9bpGdUL53CUH8vpyBj+ZnqTpu2z4WscE8nO8nJr5BfnUU+p
         7QEAtCZfgOx/A==
Message-ID: <03b3f42bbc92fdd1c798c29451eac66a0576adf1.camel@kernel.org>
Subject: [GIT PULL] File locking changes for v5.15
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 27 Aug 2021 08:49:36 -0400
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2021-08-21 11:27:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.15

for you to fetch changes up to 2949e8427af3bb74a1e26354cb68c1700663c827:

  fs: clean up after mandatory file locking support removal (2021-08-24 07:52:45 -0400)

----------------------------------------------------------------
Hi Linus,

Sending this along early as I don't expect it to change between now and
when the merge window opens.

This PR starts with a couple of fixes for potential deadlocks in the
fowner/fasync handling. The next patch removes the old mandatory locking
code from the kernel altogether. The last patch cleans up rw_verify_area
a bit more after the mandatory locking removal.

Thanks!
----------------------------------------------------------------
Desmond Cheong Zhi Xi (2):
      fcntl: fix potential deadlocks for &fown_struct.lock
      fcntl: fix potential deadlock for &fasync_struct.fa_lock

Jeff Layton (1):
      fs: remove mandatory file locking support

Lukas Bulwahn (1):
      fs: clean up after mandatory file locking support removal

 Documentation/filesystems/mandatory-locking.rst | 188 --------------------------------------------
 fs/9p/vfs_file.c                                |  13 ---
 fs/Kconfig                                      |  10 ---
 fs/afs/flock.c                                  |   4 -
 fs/ceph/locks.c                                 |   3 -
 fs/fcntl.c                                      |  18 +++--
 fs/gfs2/file.c                                  |   3 -
 fs/locks.c                                      | 117 +--------------------------
 fs/namei.c                                      |   4 +-
 fs/namespace.c                                  |  29 +++----
 fs/nfs/file.c                                   |   4 -
 fs/nfsd/nfs4state.c                             |  14 ----
 fs/nfsd/vfs.c                                   |  23 +-----
 fs/ocfs2/locks.c                                |   4 -
 fs/open.c                                       |   8 +-
 fs/read_write.c                                 |  17 +---
 fs/remap_range.c                                |  12 ---
 include/linux/fs.h                              |  84 --------------------
 mm/mmap.c                                       |   6 --
 mm/nommu.c                                      |   3 -
 20 files changed, 28 insertions(+), 536 deletions(-)
 delete mode 100644 Documentation/filesystems/mandatory-locking.rst

-- 
Jeff Layton <jlayton@kernel.org>

