Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53F28F5B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfHOUXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 16:23:55 -0400
Received: from fieldses.org ([173.255.197.46]:34802 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfHOUXz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:23:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 27271BC3; Thu, 15 Aug 2019 16:23:55 -0400 (EDT)
Date:   Thu, 15 Aug 2019 16:23:55 -0400
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
Subject: Re: [PATCH] nfsd: fix dentry leak upon mkdir failure.
Message-ID: <20190815202355.GC19554@fieldses.org>
References: <0000000000001097b6058fe1fb22@google.com>
 <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190812030354.GR1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812030354.GR1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 04:03:54AM +0100, Al Viro wrote:
> On Mon, Aug 12, 2019 at 11:16:11AM +0900, Tetsuo Handa wrote:
> > syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
> > d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
> > injection) [1].
> 
> That's not the only problem I see there.
>         ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
>         if (ret)
>                 goto out_err;
>         if (ncl) {
>                 d_inode(dentry)->i_private = ncl;
>                 kref_get(&ncl->cl_ref);
>         }
> and we are doing that to inode *after* it has become visible via dcache -
> __nfsd_mkdir() has already done d_add() (and pinged f-snotify, at that).
> Looks fishy...

Whoops, thanks.  Considering the following (untested).

--b.

commit 930f7dd94cc2
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Thu Aug 15 16:18:26 2019 -0400

    nfsd: initialize i_private before d_add
    
    A process could race in an open and attempt to read one of these files
    before i_private is initialized, and get a spurious error.
    
    Reported-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b14f825c62fe..3cf4f6aa48d6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1171,13 +1171,17 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	return inode;
 }
 
-static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode, struct nfsdfs_client *ncl)
 {
 	struct inode *inode;
 
 	inode = nfsd_get_inode(dir->i_sb, mode);
 	if (!inode)
 		return -ENOMEM;
+	if (ncl) {
+		inode->i_private = ncl;
+		kref_get(&ncl->cl_ref);
+	}
 	d_add(dentry, inode);
 	inc_nlink(dir);
 	fsnotify_mkdir(dir, dentry);
@@ -1194,13 +1198,9 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 	dentry = d_alloc_name(parent, name);
 	if (!dentry)
 		goto out_err;
-	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
+	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600, ncl);
 	if (ret)
 		goto out_err;
-	if (ncl) {
-		d_inode(dentry)->i_private = ncl;
-		kref_get(&ncl->cl_ref);
-	}
 out:
 	inode_unlock(dir);
 	return dentry;
