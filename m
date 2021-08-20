Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0F3F2D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhHTN5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhHTN5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8368610E6;
        Fri, 20 Aug 2021 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629467830;
        bh=8MnTVdYClbddCsTsLNbTMsCRF2Gxk95s2pj8wLFwQd0=;
        h=From:To:Cc:Subject:Date:From;
        b=t2HxBUM9QOrlPdcAaWYWdwKfXD7QFuBmZx3OUE5KT2Y1RrRgrlG401SCGys5CG8Fc
         +lcVOwSK0F1uRH0K8QJLDIwYW3EmP2b4Ceco7wMOADwIq3h+lqnTB1niclYqvdm+d7
         2enkha2NLg5vfDHEe2r8OXXRW79B3laihEfbtfBlVEsjUkdLaKnZVY3+uH2dh+qDQt
         utX2JoYLcmwYrQrNOrxt/rOswI8UjaFYpiDcbSrgc9rnqPDeyRgQkinXLuc7PBcbGt
         6iedGwdHK4/mUMLaWC3veuKd1igYYNJE82n3G60q/Ne/nfjplocJEfqwkX2HW7hZLL
         IPdEki8PItNtQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, david@redhat.com, willy@infradead.org,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, bfields@fieldses.org,
        w@1wt.eu, rostedt@goodmis.org
Subject: [PATCH v2 0/2] fs: remove support for mandatory locking
Date:   Fri, 20 Aug 2021 09:57:05 -0400
Message-Id: <20210820135707.171001-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch in this series adds a new warning that should pop on
kernels have mandatory locking enabled when someone mounts a filesystem
with -o mand. The second patch removes support for mandatory locking
altogether.

What I think we probably want to do is apply the first to v5.14 before
it ships and allow the new warning to trickle out into stable kernels.
Then we can merge the second patch in v5.15 to go ahead and remove it.

Sound like a plan?

Jeff Layton (2):
  fs: warn about impending deprecation of mandatory locks
  fs: remove mandatory file locking support

 .../filesystems/mandatory-locking.rst         | 188 ------------------
 fs/9p/vfs_file.c                              |  12 --
 fs/Kconfig                                    |  10 -
 fs/afs/flock.c                                |   4 -
 fs/ceph/locks.c                               |   3 -
 fs/gfs2/file.c                                |   3 -
 fs/locks.c                                    | 116 +----------
 fs/namei.c                                    |   4 +-
 fs/namespace.c                                |  31 +--
 fs/nfs/file.c                                 |   4 -
 fs/nfsd/nfs4state.c                           |  13 --
 fs/nfsd/vfs.c                                 |  15 --
 fs/ocfs2/locks.c                              |   4 -
 fs/open.c                                     |   8 +-
 fs/read_write.c                               |   7 -
 fs/remap_range.c                              |  10 -
 include/linux/fs.h                            |  84 --------
 mm/mmap.c                                     |   6 -
 mm/nommu.c                                    |   3 -
 19 files changed, 20 insertions(+), 505 deletions(-)
 delete mode 100644 Documentation/filesystems/mandatory-locking.rst

-- 
2.31.1

