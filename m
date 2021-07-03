Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F03BA6D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGCDDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 23:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGCDDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 23:03:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA25C061762;
        Fri,  2 Jul 2021 20:01:14 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzVu3-00EfUn-Nr; Sat, 03 Jul 2021 03:01:11 +0000
Date:   Sat, 3 Jul 2021 03:01:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git more namei.c stuff
Message-ID: <YN/S94w08pU0tZbq@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

        Small namei.c patch series, mostly to simplify the rules
for nameidata state.  It's in #work.namei and it's actually from
the previous cycle - didn't post it for review in time...

	Changes visible outside of fs/namei.c: file_open_root()
calling conventions change, some freed bits in LOOKUP_... space.

The following changes since commit 4f0ed93fb92d3528c73c80317509df3f800a222b:

  LOOKUP_MOUNTPOINT: we are cleaning "jumped" flag too late (2021-04-06 20:33:00 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

for you to fetch changes up to 7962c7d196e36aa597fadb78c1cb4fe7e209f803:

  namei: make sure nd->depth is always valid (2021-04-07 13:57:17 -0400)

----------------------------------------------------------------
Al Viro (4):
      switch file_open_root() to struct path
      take LOOKUP_{ROOT,ROOT_GRABBED,JUMPED} out of LOOKUP_... space
      teach set_nameidata() to handle setting the root as well
      namei: make sure nd->depth is always valid

 Documentation/filesystems/path-lookup.rst |  6 +--
 Documentation/filesystems/porting.rst     |  9 ++++
 arch/um/drivers/mconsole_kern.c           |  2 +-
 fs/coredump.c                             |  4 +-
 fs/fhandle.c                              |  2 +-
 fs/internal.h                             |  2 +-
 fs/kernel_read_file.c                     |  2 +-
 fs/namei.c                                | 80 +++++++++++++++++--------------
 fs/nfs/nfstrace.h                         |  4 --
 fs/open.c                                 |  4 +-
 fs/proc/proc_sysctl.c                     |  2 +-
 include/linux/fs.h                        |  8 +++-
 include/linux/namei.h                     |  3 --
 kernel/usermode_driver.c                  |  2 +-
 14 files changed, 74 insertions(+), 56 deletions(-)
