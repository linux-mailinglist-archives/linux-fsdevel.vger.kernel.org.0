Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B47103C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 03:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEAB7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 21:59:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54694 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAB7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:59:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLeWX-00044J-5V; Wed, 01 May 2019 01:59:05 +0000
Date:   Wed, 1 May 2019 02:59:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Message-ID: <20190501015904.GP23075@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
 <20190430030914.GF23075@ZenIV.linux.org.uk>
 <CAHk-=wiMvCR0iENUVorfU-3EMC7G8RNSeHSQrz9tndP1uSg2BQ@mail.gmail.com>
 <20190430040043.GH23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430040043.GH23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:00:43AM +0100, Al Viro wrote:

> Where would you put that synchronize_rcu()?  Doing that before ->put_super()
> is too early - inode references might be dropped in there.  OTOH, doing
> that after that point means that while struct super_block itself will be
> there, any number of data structures hanging from it might be not.
> 
> So we are still very limited in what we can do inside ->free_inode()
> instance *and* we get bunch of synchronize_rcu() for no good reason.
> 
> Note that for normal lockless accesses (lockless ->d_revalidate(), ->d_hash(),
> etc.) we are just fine with having struct super_block freeing RCU-delayed
> (along with any data structures we might need) - the superblock had
> been seen at some point after we'd taken rcu_read_lock(), so its
> freeing won't happen until we drop it.  So we don't need synchronize_rcu()
> for that.
> 
> Here the problem is that we are dealing with another RCU callback;
> synchronize_rcu() would be needed for it, but it will only protect that
> intermediate dereference of ->i_sb; any rcu-delayed stuff scheduled
> from inside ->put_super() would not be ordered wrt ->free_inode().
> And if we are doing that just for the sake of that one dereference,
> we might as well do it before scheduling i_callback().
> 
> PS: we *are* guaranteed that module will still be there (unregister_filesystem()
> does synchronize_rcu() and rcu_barrier() is done before kmem_cache_destroy()
> in assorted exit_foo_fs()).

After playing with that for a while, I think that adding barriers on
superblock freeing (or shutdown) should wait, assuming we do them at
all.

Right now no ->free_inode() instances look at superblock or anything
associated with it; moreover, there's no good candidate code that
could be moved there and would benefit from such access.  So we
don't have any material to see what could be useful to protect.

Access to ->i_sb->s_op->free_inode itself is the only exception and
moving that to before the rcu delay is both less invasive and a _lot_
more robust than playing with synchronize_rcu().  We can do that
without growing struct inode or storing it for long periods -
->i_fop is only accessed for struct inode with positive refcount,
so we can put that into anon union with the ->free_inode value,
setting it just before we schedule execution of i_callback()
(and before the direct call of the same in alloc_inode() failure
exit).

IMO the following is the sane incremental for the coming window purposes;
if we get a convincing case for ->free_inode() doing something that could
benefit from being ordered wrt parts of fs shutdown, we can always deal
with synchronize_rcu() later.  Existing instances will be fine, and IMO
separating RCU-delayed parts of inode destruction from the rest is
worthwhile on its own.

Objections?

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
