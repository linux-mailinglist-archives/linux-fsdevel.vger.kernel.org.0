Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83F4F5D27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 04:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKIDNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 22:13:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53944 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfKIDNi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:13:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTHBt-0002yX-6B; Sat, 09 Nov 2019 03:13:33 +0000
Date:   Sat, 9 Nov 2019 03:13:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH][RFC] race in exportfs_decode_fh()
Message-ID: <20191109031333.GA8566@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102180842.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:08:42PM +0000, Al Viro wrote:

> It is converging to a reasonably small and understandable surface, actually,
> most of that being in core pathname resolution.  Two big piles of nightmares
> left to review - overlayfs and (somewhat surprisingly) setxattr call chains,
> the latter due to IMA/EVM/LSM insanity...

Oh, lovely - in exportfs_decode_fh() we have this:
                err = exportfs_get_name(mnt, target_dir, nbuf, result);
                if (!err) {
                        inode_lock(target_dir->d_inode);
                        nresult = lookup_one_len(nbuf, target_dir,
                                                 strlen(nbuf));
                        inode_unlock(target_dir->d_inode);
                        if (!IS_ERR(nresult)) {
                                if (nresult->d_inode) {
                                        dput(result);
                                        result = nresult;
                                } else
                                        dput(nresult);
                        }
                }
We have derived the parent from fhandle, we have a disconnected dentry for child,
we go look for the name.  We even find it.  Now, we want to look it up.  And
some bastard goes and unlinks it, just as we are trying to lock the parent.
We do a lookup, and get a negative dentry.  Then we unlock the parent... and
some other bastard does e.g. mkdir with the same name.  OK, nresult->d_inode
is not NULL (anymore).  It has fuck-all to do with the original fhandle
(different inumber, etc.) but we happily accept it.

Even better, we have no barriers between our check and nresult becoming positive.
IOW, having observed non-NULL ->d_inode doesn't give us enough - e.g. we might
still see the old ->d_flags value, from back when ->d_inode used to be NULL.
On something like alpha we also have no promises that we'll observe anything
about the fields of nresult->d_inode, but ->d_flags alone is enough for fun.
The callers can't e.g. expect d_is_reg() et.al. to match the reality.

This is obviously bogus.  And the fix is obvious: check that nresult->d_inode is
equal to result->d_inode before unlocking the parent.  Note that we'd *already* had
the original result and all of its aliases rejected by the 'acceptable' predicate,
so if nresult doesn't supply us a better alias, we are SOL.

Does anyone see objections to the following patch?  Christoph, that seems to
be your code; am I missing something subtle here?  AFAICS, that goes back to
2007 or so...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 09bc68708d28..2dd55b172d57 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -519,26 +519,33 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 		 * inode is actually connected to the parent.
 		 */
 		err = exportfs_get_name(mnt, target_dir, nbuf, result);
-		if (!err) {
-			inode_lock(target_dir->d_inode);
-			nresult = lookup_one_len(nbuf, target_dir,
-						 strlen(nbuf));
-			inode_unlock(target_dir->d_inode);
-			if (!IS_ERR(nresult)) {
-				if (nresult->d_inode) {
-					dput(result);
-					result = nresult;
-				} else
-					dput(nresult);
-			}
+		if (err) {
+			dput(target_dir);
+			goto err_result;
 		}
 
+		inode_lock(target_dir->d_inode);
+		nresult = lookup_one_len(nbuf, target_dir, strlen(nbuf));
+		if (!IS_ERR(nresult)) {
+			if (unlikely(nresult->d_inode != result->d_inode)) {
+				dput(nresult);
+				nresult = ERR_PTR(-ESTALE);
+			}
+		}
+		inode_unlock(target_dir->d_inode);
 		/*
 		 * At this point we are done with the parent, but it's pinned
 		 * by the child dentry anyway.
 		 */
 		dput(target_dir);
 
+		if (IS_ERR(nresult)) {
+			err = PTR_ERR(nresult);
+			goto err_result;
+		}
+		dput(result);
+		result = nresult;
+
 		/*
 		 * And finally make sure the dentry is actually acceptable
 		 * to NFSD.
