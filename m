Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51283114AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 03:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfLFC2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 21:28:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53196 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfLFC2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:28:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1id3MR-0003pE-7y; Fri, 06 Dec 2019 02:28:51 +0000
Date:   Fri, 6 Dec 2019 02:28:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [git pull] vfs.git d_inode/d_flags barriers
Message-ID: <20191206022851.GM4203@ZenIV.linux.org.uk>
References: <20191206013819.GL4203@ZenIV.linux.org.uk>
 <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:15:54PM -0800, Linus Torvalds wrote:
> On Thu, Dec 5, 2019 at 5:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
> 
> I'm not pulling this.
> 
> Commit 6c2d4798a8d1 ("new helper: lookup_positive_unlocked()") results
> in a new - and valid - compiler warning:
> 
>   fs/quota/dquot.c: In function ‘dquot_quota_on_mount’:
>   fs/quota/dquot.c:2499:1: warning: label ‘out’ defined but not used
> [-Wunused-label]
>    2499 | out:
>         | ^~~
> 
> and I don't want to see new warnings in my tree.
> 
> I wish linux-next would complain about warnings (assuming this had
> been there), because they aren't ok.

Fixed...  Could you pull #fixes1 instead?  diff is literally removal of one
line; updated shortlog/diffstat follows:

The following changes since commit 3e5aeec0e267d4422a4e740ce723549a3098a4d1:

  cramfs: fix usage on non-MTD device (2019-11-23 21:44:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes1

for you to fetch changes up to 7fcd59b64a7b69718cc851865a1578138b481541:

  fs/namei.c: fix missing barriers when checking positivity (2019-12-05 21:04:35 -0500)

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
 fs/quota/dquot.c       |  8 +-------
 include/linux/dcache.h |  5 +++++
 include/linux/namei.h  |  1 +
 11 files changed, 56 insertions(+), 74 deletions(-)
