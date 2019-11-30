Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD810DC45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 04:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfK3Doq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 22:44:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfK3Doq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 22:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lV4uw+gaYRWbW1eWDpyMQCkqCu9PdBiUUsVW1HFSueI=; b=nuqW/nv5PpexoOa3FQ/20rync
        nlnrQ7TY/5SK6OvPl12Wjou2bzDq0lMN1p6zUU1lCrFaakfcumxvZaPWPVRY+EiCFDsMkalJb5Ndn
        nbjs1fCtFWrvLZiAh6bgX92rbbCDl0pBeMP+x0YrW/5kbXriWeuoW702VV8tSl+6ltgSxtVGJ/G31
        stPmm0w3UKiwDLpRVZtBEt5/FP+mXTptK1TcoqU9roQHxILl16cPv+5ygUslS8Poaz2DlInKIIPSF
        AlqrzYK4pZGkptZRiZtcVQhSorDnbOUCpxZUHPAJ5iglQhkUXCpCpveyasdHzWrO3AdDT7r1TCsu9
        yyNC6jgLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iatfX-0002t5-34; Sat, 30 Nov 2019 03:43:39 +0000
Date:   Fri, 29 Nov 2019 19:43:39 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, oleg@redhat.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, tytso@mit.edu,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191130034339.GI20752@bombadil.infradead.org>
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130020225.20239-2-yukuai3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 30, 2019 at 10:02:23AM +0800, yu kuai wrote:
> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.

No.  These need meaningful names.  Indeed, I think D_LOCK_NESTED is
a terrible name.

Looking at the calls:

$ git grep -n nested.*d_lock fs
fs/autofs/expire.c:82:          spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
fs/dcache.c:619:                spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
fs/dcache.c:1086:       spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
fs/dcache.c:1303:               spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
fs/dcache.c:2822:               spin_lock_nested(&old_parent->d_lock, DENTRY_D_LOCK_NESTED);
fs/dcache.c:2827:                       spin_lock_nested(&target->d_parent->d_lock,
fs/dcache.c:2830:       spin_lock_nested(&dentry->d_lock, 2);
fs/dcache.c:2831:       spin_lock_nested(&target->d_lock, 3);
fs/dcache.c:3121:       spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
fs/libfs.c:112:                 spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
fs/libfs.c:341:         spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
fs/notify/fsnotify.c:129:                       spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);

Most of these would be well-expressed by DENTRY_D_LOCK_CHILD.

The exception is __d_move() where I think we should actually name the
different lock classes instead of using a bare '2' and '3'.  Something
like this, perhaps:

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 2866fabf497f..f604175243eb 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -79,7 +79,7 @@ static struct dentry *positive_after(struct dentry *p, struct dentry *child)
 		child = list_first_entry(&p->d_subdirs, struct dentry, d_child);
 
 	list_for_each_entry_from(child, &p->d_subdirs, d_child) {
-		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_CHILD);
 		if (simple_positive(child)) {
 			dget_dlock(child);
 			spin_unlock(&child->d_lock);
diff --git a/fs/dcache.c b/fs/dcache.c
index e88cf0554e65..c73b7d7bc785 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -616,7 +616,7 @@ static struct dentry *__lock_parent(struct dentry *dentry)
 	}
 	rcu_read_unlock();
 	if (parent != dentry)
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_CHILD);
 	else
 		parent = NULL;
 	return parent;
@@ -1083,7 +1083,7 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 		spin_lock(&dentry->d_lock);
 		goto out;
 	}
-	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_CHILD);
 	if (likely(!dentry->d_lockref.count))
 		return true;
 	spin_unlock(&parent->d_lock);
@@ -1300,7 +1300,7 @@ static void d_walk(struct dentry *parent, void *data,
 		if (unlikely(dentry->d_flags & DCACHE_DENTRY_CURSOR))
 			continue;
 
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_CHILD);
 
 		ret = enter(data, dentry);
 		switch (ret) {
@@ -2819,16 +2819,16 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	} else if (!p) {
 		/* target is not a descendent of dentry->d_parent */
 		spin_lock(&target->d_parent->d_lock);
-		spin_lock_nested(&old_parent->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&old_parent->d_lock, DENTRY_D_LOCK_PARENT_2);
 	} else {
 		BUG_ON(p == dentry);
 		spin_lock(&old_parent->d_lock);
 		if (p != target)
 			spin_lock_nested(&target->d_parent->d_lock,
-					DENTRY_D_LOCK_NESTED);
+					DENTRY_D_LOCK_PARENT_2);
 	}
-	spin_lock_nested(&dentry->d_lock, 2);
-	spin_lock_nested(&target->d_lock, 3);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_CHILD);
+	spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_CHILD_2);
 
 	if (unlikely(d_in_lookup(target))) {
 		dir = target->d_parent->d_inode;
@@ -2837,7 +2837,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	}
 
 	write_seqcount_begin(&dentry->d_seq);
-	write_seqcount_begin_nested(&target->d_seq, DENTRY_D_LOCK_NESTED);
+	write_seqcount_begin_nested(&target->d_seq, DENTRY_D_LOCK_CHILD);
 
 	/* unhash both */
 	if (!d_unhashed(dentry))
@@ -3118,7 +3118,7 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
-	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_CHILD);
 	dentry->d_name.len = sprintf(dentry->d_iname, "#%llu",
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
diff --git a/fs/libfs.c b/fs/libfs.c
index 1463b038ffc4..c68dedbf4ad2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -109,7 +109,7 @@ static struct dentry *scan_positives(struct dentry *cursor,
 		if (d->d_flags & DCACHE_DENTRY_CURSOR)
 			continue;
 		if (simple_positive(d) && !--count) {
-			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_CHILD);
 			if (simple_positive(d))
 				found = dget_dlock(d);
 			spin_unlock(&d->d_lock);
@@ -336,9 +336,9 @@ int simple_empty(struct dentry *dentry)
 	struct dentry *child;
 	int ret = 0;
 
-	spin_lock(&dentry->d_lock);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_PARENT_2);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
-		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_CHILD_2);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
 			goto out;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ecef6155fc0..23492f2e4915 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -126,7 +126,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 			if (!child->d_inode)
 				continue;
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_CHILD);
 			if (watched)
 				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 			else
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 10090f11ab95..6a497c63bd38 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -121,15 +121,20 @@ struct dentry {
 } __randomize_layout;
 
 /*
- * dentry->d_lock spinlock nesting subclasses:
+ * dentry->d_lock spinlock nesting subclasses.  Always taken in increasing
+ * order although some subclasses may be skipped.
  *
  * 0: normal
- * 1: nested
+ * 1: either a descendent of "normal" or a cousin.
+ * 2: child of the "normal" dentry
+ * 3: child of the "parent2" dentry
  */
 enum dentry_d_lock_class
 {
-	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
-	DENTRY_D_LOCK_NESTED
+	DENTRY_D_LOCK_NORMAL,   /* implicitly used by plain spin_lock() APIs */
+	DENTRY_D_LOCK_PARENT_2, /* not an ancestor of parent */
+	DENTRY_D_LOCK_CHILD,    /* nests under parent's lock */
+	DENTRY_D_LOCK_CHILD_2,  /* PARENT_2's child */
 };
 
 struct dentry_operations {
