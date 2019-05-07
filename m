Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045D215720
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 02:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEGA6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 20:58:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38228 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEGA6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 20:58:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNoRO-000209-WB; Tue, 07 May 2019 00:58:43 +0000
Date:   Tue, 7 May 2019 01:58:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 2: several fixes to backport
Message-ID: <20190507005842.GG23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	acct_on() fix for deadlock caught be overlayfs folks,
autofs RCU use-after-free SNAFU (->d_manage() can be called
lockless, so we need to RCU-delay freeing the objects it
looks at) and (hopefully) the end of "do we need freeing this
dentry RCU-delayed" whack-a-mole.

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git stable-fodder

for you to fetch changes up to ce285c267a003acbf607f3540ff71287f82e5282:

  autofs: fix use-after-free in lockless ->d_manage() (2019-04-09 19:18:19 -0400)

----------------------------------------------------------------
Al Viro (3):
      acct_on(): don't mess with freeze protection
      dcache: sort the freeing-without-RCU-delay mess for good.
      autofs: fix use-after-free in lockless ->d_manage()

 Documentation/filesystems/porting |  5 +++++
 fs/autofs/autofs_i.h              |  1 +
 fs/autofs/inode.c                 |  2 +-
 fs/dcache.c                       | 24 +++++++++++++-----------
 fs/internal.h                     |  2 --
 fs/nsfs.c                         |  3 +--
 include/linux/dcache.h            |  2 +-
 include/linux/mount.h             |  2 ++
 kernel/acct.c                     |  4 ++--
 9 files changed, 26 insertions(+), 19 deletions(-)
