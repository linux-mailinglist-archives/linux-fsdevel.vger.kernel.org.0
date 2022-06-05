Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892DE53D90B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiFEBWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 21:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbiFEBWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:22:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956016581;
        Sat,  4 Jun 2022 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dH54PSrFco+H8DGFoqRIG9kEOF7BLwa04CYIF43RYjM=; b=wvdMRYsE+Cwjl/mw2wvYdsNC40
        b/eGYqjt9EQm3LehOvGEOUnb1PqoZ3fzsAtlDhgUmbknhbhqpWFu8j1fTmUipMTrtPM27otzIlE+Y
        oqloGTo1m0yQFGKDQFbXz/Xwx2HQPmqGnLCOaCB8HKQECjpF+DSCMn0VbJdRcpOLyLwTloKxSf9sA
        5iKg3pcuvd2E831NZMX1+T/P/QEG7Ygtiffk3NSKftuCWQVDMJyl5x88wNUG6Y8kPTmHPFvYqs4hL
        h3AbzE++9gtsK9SCfze9oxDdOceGnArHFhROzRRazaR07TMLTh3FZ6qqHLj779NgzNXlytaArqkeZ
        L7ISAzwA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxey0-003dsZ-Jy; Sun, 05 Jun 2022 01:22:08 +0000
Date:   Sun, 5 Jun 2022 01:22:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] mount-related stuff
Message-ID: <YpwFQLi1eeo3TmkQ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.mount

for you to fetch changes up to 70f8d9c5750bbb0ca4ef7e23d6abcb05e6061138:

  move mount-related externs from fs.h to mount.h (2022-05-19 23:25:48 -0400)

----------------------------------------------------------------
	Cleanups (and one fix) around struct mount handling.
The fix is usermode_driver.c one - once you've done kern_mount(), you
must kern_unmount(); simple mntput() will end up with a leak.  Several
failure exits in there messed up that way...  In practice you won't
hit those particular failure exits without fault injection, though.

----------------------------------------------------------------
Al Viro (5):
      uninline may_mount() and don't opencode it in fspick(2)/fsopen(2)
      linux/mount.h: trim includes
      m->mnt_root->d_inode->i_sb is a weird way to spell m->mnt_sb...
      blob_to_mnt(): kern_unmount() is needed to undo kern_mount()
      move mount-related externs from fs.h to mount.h

 arch/alpha/kernel/osf_sys.c |  1 +
 fs/fsopen.c                 |  4 ++--
 fs/internal.h               |  1 +
 fs/namespace.c              |  2 +-
 fs/nfs/nfs4file.c           |  4 ++--
 include/linux/fs.h          | 11 -----------
 include/linux/mount.h       | 29 +++++++++++++++++------------
 kernel/usermode_driver.c    |  4 ++--
 security/smack/smackfs.c    |  1 +
 9 files changed, 27 insertions(+), 30 deletions(-)
