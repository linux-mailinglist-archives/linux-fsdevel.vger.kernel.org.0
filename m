Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E396AEF00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfD3DJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:09:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37472 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfD3DJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:09:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLJ8s-0005zU-Pv; Tue, 30 Apr 2019 03:09:14 +0000
Date:   Tue, 30 Apr 2019 04:09:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Message-ID: <20190430030914.GF23075@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:01:16AM -0700, Linus Torvalds wrote:
> On Tue, Apr 16, 2019 at 10:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >  83 files changed, 241 insertions(+), 516 deletions(-)
> 
> I think this single line is pretty convincing on its own. Ignoring
> docs and fs/inode.c, we have
> 
>  80 files changed, 190 insertions(+), 494 deletions(-)
> 
> IOW, just over 300 lines of boiler plate code removed.
> 
> The additions are
> 
>  - Ten more lines of actual code in fs/inode.c (and that's not
> actually added complexity, it looks simpler if anything - most of it
> is the new "i_callback()" helper function)
> 
>  - 19 lines of doc updates.
> 
> So it absolutely looks fine to me.
> 
> I only skimmed through the actual filesystem (and one networking)
> patches, but they looked like trivial conversions to a better
> interface.

... except that this callback can (and always could) get executed after
freeing struct super_block.  So we can't just dereference ->i_sb->s_op
and expect to survive; the table ->s_op pointed to will still be there,
but ->i_sb might very well have been freed, with all its contents overwritten.
We need to copy the callback into struct inode itself, unfortunately.
The following incremental fixes it; I'm going to fold it into the first
commit in there.

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 9d80f9e0855e..b8d3ddd8b8db 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -655,3 +655,11 @@ in your dentry operations instead.
 		* if ->free_inode() is non-NULL, it gets scheduled by call_rcu()
 		* combination of NULL ->destroy_inode and NULL ->free_inode is
 		  treated as NULL/free_inode_nonrcu, to preserve the compatibility.
+
+	Note that the callback (be it via ->free_inode() or explicit call_rcu()
+	in ->destroy_inode()) is *NOT* ordered wrt superblock destruction;
+	as the matter of fact, the superblock and all associated structures
+	might be already gone.  The filesystem driver is guaranteed to be still
+	there, but that's it.  Freeing memory in the callback is fine; doing
+	more than that is possible, but requires a lot of care and is best
+	avoided.
diff --git a/fs/inode.c b/fs/inode.c
index fb45590d284e..855dad43b11d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -164,6 +164,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_wb_frn_avg_time = 0;
 	inode->i_wb_frn_history = 0;
 #endif
+	inode->free_inode = sb->s_op->free_inode;
 
 	if (security_inode_alloc(inode))
 		goto out;
@@ -211,8 +212,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
 static void i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
-	if (inode->i_sb->s_op->free_inode)
-		inode->i_sb->s_op->free_inode(inode);
+	if (inode->free_inode)
+		inode->free_inode(inode);
 	else
 		free_inode_nonrcu(inode);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e9b9f87caca..5ed6b39e588e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -718,6 +718,7 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
+	void (*free_inode)(struct inode *);
 } __randomize_layout;
 
 static inline unsigned int i_blocksize(const struct inode *node)
