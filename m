Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B195114A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 02:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFBiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 20:38:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFBiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:38:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1id2ZX-00028J-6s; Fri, 06 Dec 2019 01:38:19 +0000
Date:   Fri, 6 Dec 2019 01:38:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [git pull] vfs.git d_inode/d_flags barriers
Message-ID: <20191206013819.GL4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	More fallout from tree-wide audit for ->d_inode/->d_flags barriers
use.  Basically, the problem is that negative pinned dentries require
careful treatment - unless ->d_lock is locked or parent is held at least
shared, another thread can make them positive right under us.

	Most of the uses turned out to be safe - the main surprises as
far as filesystems are concerned were
	* race in dget_parent() fastpath, that might end up with the
caller observing the returned dentry _negative_, due to insufficient
barriers.  It is positive in memory, but we could end up seeing
the wrong value of ->d_inode in CPU cache.  Fixed.
	* manual checks that result of lookup_one_len_unlocked() is
positive (and rejection of negatives).  Again, insufficient barriers
(we might end up with inconsistent observed values of ->d_inode and
->d_flags).  Fixed by switching to a new primitive that does the
checks itself and returns ERR_PTR(-ENOENT) instead of a negative
dentry.  That way we get rid of boilerplate converting negatives
into ERR_PTR(-ENOENT) in the callers and have a single place to
deal with the barrier-related mess - inside fs/namei.c rather than
in every caller out there.

	The guts of pathname resolution *do* need to be careful -
the race found by Ritesh is real, as well as several similar
races.  Fortunately, it turns out that we can take care of that
with fairly local changes in there.

	The tree-wide audit had not been fun, and I hate the idea of
repeating it.  I think the right approach would be to annotate the
places where we are _not_ guaranteed ->d_inode/->d_flags stability
and have sparse catch regressions.  But I'm still not sure what would
be the least invasive way of doing that and it's clearly the next
cycle fodder.

The following changes since commit 3e5aeec0e267d4422a4e740ce723549a3098a4d1:

  cramfs: fix usage on non-MTD device (2019-11-23 21:44:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 2fa6b1e01a9b1a54769c394f06cd72c3d12a2d48:

  fs/namei.c: fix missing barriers when checking positivity (2019-11-15 13:49:04 -0500)

----------------------------------------------------------------
Al Viro (4):
      fs/namei.c: pull positivity check into follow_managed()
      new helper: lookup_positive_unlocked()
      fix dget_parent() fastpath race
      fs/namei.c: fix missing barriers when checking positivity

 fs/cifs/cifsfs.c       |  7 +------
 fs/dcache.c            |  6 ++++--
 fs/debugfs/inode.c     |  6 +-----
 fs/kernfs/mount.c      |  2 +-
 fs/namei.c             | 56 ++++++++++++++++++++++++++++----------------------
 fs/nfsd/nfs3xdr.c      |  4 +---
 fs/nfsd/nfs4xdr.c      | 11 +---------
 fs/overlayfs/namei.c   | 24 ++++++++--------------
 fs/quota/dquot.c       |  7 +------
 include/linux/dcache.h |  5 +++++
 include/linux/namei.h  |  1 +
 11 files changed, 56 insertions(+), 73 deletions(-)
