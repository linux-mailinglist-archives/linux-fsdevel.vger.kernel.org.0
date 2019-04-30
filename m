Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D60EF97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfD3E01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 00:26:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38532 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3E01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:26:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLKLY-0007Ys-3q; Tue, 30 Apr 2019 04:26:24 +0000
Date:   Tue, 30 Apr 2019 05:26:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Message-ID: <20190430042623.GJ23075@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
 <20190430030914.GF23075@ZenIV.linux.org.uk>
 <F01D238D-8A6C-4629-ABC5-4A8BAC25951F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F01D238D-8A6C-4629-ABC5-4A8BAC25951F@dilger.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:18:04PM -0600, Andreas Dilger wrote:
> > 
> > 	void			*i_private; /* fs or device private pointer */
> > +	void (*free_inode)(struct inode *);
> 
> It seems like a waste to increase the size of every struct inode just to access
> a static pointer.  Is this the only place that ->free_inode() is called?  Why
> not move the ->free_inode() pointer into inode->i_fop->free_inode() so that it
> is still directly accessible at this point.

i_op, surely?  In any case, increasing sizeof(struct inode) is not a problem -
if anything, I'd turn ->i_fop into an anon union with that.  As in,

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
index fb45590d284e..627e1766503a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -211,8 +211,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
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
@@ -236,6 +236,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 			if (!ops->free_inode)
 				return NULL;
 		}
+		inode->free_inode = ops->free_inode;
 		i_callback(&inode->i_rcu);
 		return NULL;
 	}
@@ -276,6 +277,7 @@ static void destroy_inode(struct inode *inode)
 		if (!ops->free_inode)
 			return;
 	}
+	inode->free_inode = ops->free_inode;
 	call_rcu(&inode->i_rcu, i_callback);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e9b9f87caca..92732286b748 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -694,7 +694,10 @@ struct inode {
 #ifdef CONFIG_IMA
 	atomic_t		i_readcount; /* struct files open RO */
 #endif
-	const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
+	union {
+		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
+		void (*free_inode)(struct inode *);
+	};
 	struct file_lock_context	*i_flctx;
 	struct address_space	i_data;
 	struct list_head	i_devices;
