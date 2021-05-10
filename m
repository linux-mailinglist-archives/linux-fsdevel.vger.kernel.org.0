Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A77378B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhEJMGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 08:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:55762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242404AbhEJLrB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 07:47:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C456AB6D;
        Mon, 10 May 2021 11:45:55 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 5f84ca35;
        Mon, 10 May 2021 11:47:28 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <87czu45gcs.fsf@suse.de> <YJPIyLZ9ofnPy3F6@codewreck.org>
        <87zgx83vj9.fsf@suse.de> <87r1ii4i2a.fsf@suse.de>
        <YJXfjDfw9KM50f4y@codewreck.org> <875yzq270z.fsf@suse.de>
Date:   Mon, 10 May 2021 12:47:28 +0100
In-Reply-To: <875yzq270z.fsf@suse.de> (Luis Henriques's message of "Mon, 10
        May 2021 11:54:36 +0100")
Message-ID: <871rae24kv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Luis Henriques <lhenriques@suse.de> writes:

> Dominique Martinet <asmadeus@codewreck.org> writes:
>
>> Luis Henriques wrote on Fri, May 07, 2021 at 05:36:29PM +0100:
>>> Ok, I spent some more time on this issue today.  I've hacked a bit of code
>>> to keep track of new inodes' qids and I'm convinced there are no
>>> duplicates when this issue happens.
>>
>> Ok, that's good.
>> Just to make sure what did you look at aside of the qid to make sure
>> it's unique? i_ino comes straight from qid->path too so we don't have
>> any great key available which is why I hadn't suggesting building a
>> debug table.
>> (... well, actually that means we'll never try to allocate two inodes
>> with the same inode number because of how v9fs_qid_iget_dotl() works, so
>> if there is a collision in qid paths we wouldn't see it through cookies
>> collision in the first place. I'm not sure that's good? But at least
>> that clears up that theory, sorry for the bad suggestion)
>>
>
> Ok, I should probably have added some more details in my email.  So,
> here's what I did:
>
> I've created a list (actually a tree...) of objects that keep track of
> each new inode in v9fs_qid_iget_dotl().  These objects contain the inode
> number, and the qid (type, version, path).  These are then removed from
> the list in v9fs_evict_inode().
>
> Whenever there's an error in v9fs_cache_inode_get_cookie(), i.e. when
> v9inode->fscache == NULL, I'll search this list to see if that inode
> number was there (or if I can find the qid.path and qid.version).  
>
> I have never seen a hit in this search, hence my claim of not having a
> duplicate qids involved.  Of course my hack can be buggy and I completely
> miss it ;-)
>
>>> OTOH, I've done another quick test: in v9fs_cache_inode_get_cookie(), I do
>>> an fscache_acquire_cookie() retry when it fails (due to the dup error),
>>> and this retry *does* succeed.  Which means, I guess, there's a race going
>>> on.  I didn't managed to look too deep yet, but my current theory is that
>>> the inode is being evicted while an open is triggered.  A new inode is
>>> allocated but the old inode fscache cookie hasn't yet been relinquished.
>>> Does this make any sense?
>>
>> hm, if the retry goes through I guess that'd make sense; if they both
>> were used in parallel the second call should fail all the same so that's
>> definitely a likely explanation.
>>
>> It wouldn't hurt to check with v9fs_evict_inode if that's correct...
>> There definitely is a window where inode is no longer findable (thus
>> leading to allocation of a new one) and the call to the
>> fscache_relinquish_cookie() at eviction, but looking at e.g. afs they
>> are doing exactly the same as 9p here (iget5_locked, if that gets a new
>> inode then call fscache_acquire_cookie // fscache_relinquish_cookie in
>> evict op) so I'm not sure what we're missing.
>>
>>
>> David, do you have an idea?
>
> I've just done a quick experiment: moving the call to function
> v9fs_cache_inode_put_cookie() in v9fs_evict_inode() to the beginning
> (before truncate_inode_pages_final()) and it seems to, at least, narrow
> the window -- I'm not able to reproduce the issue anymore.  But I'll need
> to look closer.
>

And right after sending this email I decided to try a different
experiment.  Here's the code I had in v9fs_evict_inode():

void v9fs_evict_inode(struct inode *inode)
{
	struct v9fs_inode *v9inode = V9FS_I(inode);

	v9fs_debug_remove(inode->i_ino); /* <------------------------- */
	truncate_inode_pages_final(&inode->i_data);
	clear_inode(inode);
	filemap_fdatawrite(&inode->i_data);

	v9fs_cache_inode_put_cookie(inode);
	/* clunk the fid stashed in writeback_fid */
	if (v9inode->writeback_fid) {
		p9_client_clunk(v9inode->writeback_fid);
		v9inode->writeback_fid = NULL;
	}
}

v9fs_debug_remove() is the function that would remove the inode from my
debug tree.  In my new experiment, I changed this with:

void v9fs_evict_inode(struct inode *inode)
{
	struct v9fs_inode *v9inode = V9FS_I(inode);

	v9fs_debug_tag(inode->i_ino);
	(...)
	v9fs_debug_remove(inode->i_ino);
}

So, I effectively "tag" the inode for removing it from the list but only
remove it in the end.  The result is that I actually started seeing this
inode tagged for removing in v9fs_cache_inode_get_cookie() when fscache
detects the duplicate cookie!

I'm attaching the debug patch I'm using.  Obviously, I'm not really proud
of this code and is not for merging (it's *really* hacky!), but maybe it
helps clarifying what I tried to explain above.  I.e. that
fscache_relinquish_cookie() should probably be invoked early when evicting
an inode.

FTR, with this patch applied I occasionally (but not always!) see the
following:

  [DEBUG] inode: 24187397 quid: 0.1711203.633864d4
  [DEBUG] found in tree qid: 0.1711203.633864d4 removing: 1
  [DEBUG] found dup ino: 24187397 0.1711203.633864d4 removing: 1

(Sometimes I do not see the duplicate being found, which probably means I
didn't hit the race.)

David, does this make sense?

Cheers
-- 
Luis


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=debug-code.patch

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index eb2151fb6049..59b59291609c 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -122,6 +122,30 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
 						  i_size_read(&v9inode->vfs_inode),
 						  true);
 
+	if (!v9inode->fscache) {
+		struct v9fs_debug *db, *next;
+
+		mutex_lock(&v9fs_debug_tree_mutex);
+		db = v9fs_debug_search(inode->i_ino);
+		printk("[DEBUG] inode: %ld quid: %x.%llx.%x\n",
+		       inode->i_ino,
+		       v9inode->qid.type,
+		       (unsigned long long)v9inode->qid.path,
+		       v9inode->qid.version);
+		if (db)
+			printk("[DEBUG] found in tree qid: %x.%llx.%x removing: %d\n",
+			       db->type, (unsigned long long)db->path,
+			       db->version, db->removing);
+		rbtree_postorder_for_each_entry_safe(db, next, &v9fs_debug_tree, node) {
+			if (db->path == v9inode->qid.path &&
+			    db->version == v9inode->qid.version)
+				printk("[DEBUG] found dup ino: %ld %x.%llx.%x removing: %d\n",
+				       db->inode,
+				       db->type, (unsigned long long)db->path,
+				       db->version, db->removing);
+		}
+		mutex_unlock(&v9fs_debug_tree_mutex);
+	}
 	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
 		 inode, v9inode->fscache);
 }
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 4ca56c5dd637..7935ab56453c 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -119,6 +119,22 @@ struct v9fs_inode {
 	struct inode vfs_inode;
 };
 
+struct v9fs_debug {
+	struct rb_node node;
+	unsigned long inode;
+	u8 type;
+	u32 version;
+	u64 path;
+	bool removing;
+};
+
+extern struct rb_root v9fs_debug_tree;
+extern struct mutex v9fs_debug_tree_mutex;
+extern void v9fs_debug_remove(unsigned long inode);
+extern void v9fs_debug_tag(unsigned long inode);
+extern struct v9fs_debug *v9fs_debug_search(unsigned long inode);
+extern void v9fs_debug_insert(unsigned long inode, u8 type, u32 version, u64 path);
+
 static inline struct v9fs_inode *V9FS_I(const struct inode *inode)
 {
 	return container_of(inode, struct v9fs_inode, vfs_inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 795706520b5e..e5ebec787c28 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -377,6 +377,7 @@ void v9fs_evict_inode(struct inode *inode)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 
+	v9fs_debug_tag(inode->i_ino);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);
@@ -387,6 +388,7 @@ void v9fs_evict_inode(struct inode *inode)
 		p9_client_clunk(v9inode->writeback_fid);
 		v9inode->writeback_fid = NULL;
 	}
+	v9fs_debug_remove(inode->i_ino);
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index e1c0240b51c0..56a7bc0c627b 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -32,6 +32,9 @@
 #include "xattr.h"
 #include "acl.h"
 
+struct rb_root v9fs_debug_tree = RB_ROOT;
+DEFINE_MUTEX(v9fs_debug_tree_mutex);
+
 static int
 v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
 		    struct dentry *dentry, umode_t omode, dev_t rdev);
@@ -94,6 +97,94 @@ static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
 	return 0;
 }
 
+struct v9fs_debug *v9fs_debug_search(unsigned long inode)
+{
+	struct rb_node *node = v9fs_debug_tree.rb_node;
+
+	while (node) {
+		struct v9fs_debug *data = container_of(node, struct v9fs_debug, node);
+
+		if (data->inode < inode)
+			node = node->rb_left;
+		else if (data->inode > inode)
+			node = node->rb_right;
+		else
+			return data;
+	}
+	return NULL;
+}
+
+void v9fs_debug_tag(unsigned long inode)
+{
+	struct v9fs_debug *node;
+
+	mutex_lock(&v9fs_debug_tree_mutex);
+	node = v9fs_debug_search(inode);
+	if (node)
+		node->removing = true;
+	else
+		printk("[DEBUG] can't find %ld for tagging\n", inode);
+	mutex_unlock(&v9fs_debug_tree_mutex);
+}
+
+void v9fs_debug_remove(unsigned long inode)
+{
+	struct v9fs_debug *node;
+
+	mutex_lock(&v9fs_debug_tree_mutex);
+	node = v9fs_debug_search(inode);
+	if (node) {
+		rb_erase(&node->node, &v9fs_debug_tree);
+		kfree(node);
+	} else
+		printk("[DEBUG] can't find %ld\n", inode);
+	mutex_unlock(&v9fs_debug_tree_mutex);
+}
+
+void v9fs_debug_insert(unsigned long inode, u8 type, u32 version, u64 path)
+{
+	struct v9fs_debug *db = NULL;
+	struct rb_node **node, *parent = NULL;
+
+	mutex_lock(&v9fs_debug_tree_mutex);
+	node = &(v9fs_debug_tree.rb_node);
+	while (*node) {
+		parent = *node;
+		db = container_of(*node, struct v9fs_debug, node);
+
+		if (db->inode < inode)
+			node = &((*node)->rb_left);
+		else if (db->inode > inode)
+			node = &((*node)->rb_right);
+		else
+			break;
+	}
+	if (!db || (db->inode != inode)) {
+		db = kmalloc(sizeof(*db), GFP_KERNEL);
+		if (db) {
+			db->inode = inode;
+			db->type = type;
+			db->version = version;
+			db->path = path;
+			db->removing = false;
+			rb_link_node(&db->node, parent, node);
+			rb_insert_color(&db->node, &v9fs_debug_tree);
+		} else
+			printk("[DEBUG] Failed to alloc memory!\n");
+	}
+	if (db) {
+		if (type != db->type ||
+		    version != db->version ||
+		    path != db->path) {
+			db->inode = inode;
+			db->type = type;
+			db->version = version;
+			db->path = path;
+		}
+	}
+	mutex_unlock(&v9fs_debug_tree_mutex);
+}
+
 static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					struct p9_qid *qid,
 					struct p9_fid *fid,
@@ -134,6 +225,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	if (retval)
 		goto error;
 
+	v9fs_debug_insert(inode->i_ino, qid->type, qid->version, qid->path);
 	unlock_new_inode(inode);
 	return inode;
 error:

--=-=-=
Content-Type: text/plain


> And yeah, I had checked other filesystems too and they seem to follow this
> pattern.  So either I'm looking at the wrong place or this is something
> that is much more likely to be triggered by 9p.
>
> Cheers,
> -- 
> Luis
>
>>> If this theory is correct, I'm not sure what's the best way to close this
>>> race because the v9inode->fscache_lock can't really be used.  But I still
>>> need to proof this is really what's happening.
>>
>> Yes, I think we're going to need proof before thinking of a solution, I
>> can't think of anything simple either.
>>
>>
>> Thanks again for looking into it,
>> -- 
>> Dominique


--=-=-=--
