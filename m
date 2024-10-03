Return-Path: <linux-fsdevel+bounces-30870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B598EF58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1F1F2179F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC69187330;
	Thu,  3 Oct 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2/IV37D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B1EB48;
	Thu,  3 Oct 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959165; cv=none; b=I09qoI33A6lB+pk9OhRbPVMnnXf8eToAwbtaESS1DYVnUIO0J5ym8NkgIHPrIE57Q73b/UjZlPeyZ9giPiJ7vthODRE9PeJvZ4Od8kz4YI9dPebEgiveqFH4Szvc3UFXPpqx5yyXSxh3H2w8apdciLMIcx+ZFW2avNwAXJzZJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959165; c=relaxed/simple;
	bh=5emo6GNn5T3u+Erigf/h3xgnTZXxlGfabcYARaSSexY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO3YQevFkEVtvX/PzpJvQs6P/aVoli368ELcZSusqCmyVbu0Yy33q1AS8KQDkDQIkyHzp7oiwNGX+MxsS1ax/L+sTjcKBxd3WBvu2jgR+jrEO7SOQB/dKYTT9rO3gqrP818q50iLHaMisI//Jk7A4/BYIhS95tYeZ9F0eqeiEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u2/IV37D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hsDe1nr8NAOzLkgvsUccvOHrTmnfX+aPFrJP4xKc2G8=; b=u2/IV37DynVoDQm2tdZoTXmZwg
	lpZG37ipgUsPsDbwyA+uGmDsm740kFRKzurQ8udYY6TkifjzuGzckPC+xfz6yAQ1p4exgIG6aWzFL
	xseVTy48EfXREoiUMhAO1YDvjofk+E9bCzneeKpqgIsvfOuulwaFET9Qw7MlQ/qtkuM56DjeGCmWQ
	nez/zSeyV6Ao2A20Wv8eIv7ujwr4pH+A9hH63Zp2peglZh5U51jlol087dRefUum0DzlkntzuwlMj
	9Fas9eOSlQ2VbRkDDSRtS5lIbzjzPGhkGhhGveBPCGbR4V36A8xr9PR5NOdODvPGb4g7tJNS7wD0o
	fm4/sU+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swL75-000000092H8-1SjF;
	Thu, 03 Oct 2024 12:39:23 +0000
Date: Thu, 3 Oct 2024 05:39:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv6Qe-9O44g6qnSu@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003122657.mrqwyc5tzeggrzbt@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 02:26:57PM +0200, Jan Kara wrote:
> On Thu 03-10-24 05:11:11, Christoph Hellwig wrote:
> > On Thu, Oct 03, 2024 at 01:57:21PM +0200, Jan Kara wrote:
> > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > I'd wait with that convertion until this series lands.
> > 
> > I don't see how that has anything to do with iterators or not.
> 
> Well, the patches would obviously conflict

Conflict with what?

> which seems pointless if we
> could live with three iterations for a few years until somebody noticed :).
> And with current Dave's version of iterators it will not be possible to
> integrate evict_inodes() iteration with the other two without a layering
> violation. Still we could go from 3 to 2 iterations.

What layering violation?

Below is quick compile tested part to do the fsnotify side and
get rid of the fsnotify iteration, which looks easily worth it.

landlock is a bit more complex because of lsm hooks, and the internal
underobj abstraction inside of landlock.  But looking at the release
inode data vs unomunt synchronization it has and the duplicate code I
think doing it this way is worth the effort even more, it'll just need 
someone who knows landlock and the lsm layering to help with the work.

diff --git a/fs/inode.c b/fs/inode.c
index 3f335f78c5b228..7d5f8a09e4d29d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -789,11 +789,23 @@ static bool dispose_list(struct list_head *head)
  */
 static int evict_inode_fn(struct inode *inode, void *data)
 {
+	struct super_block *sb = inode->i_sb;
 	struct list_head *dispose = data;
+	bool post_unmount = !(sb->s_flags & SB_ACTIVE);
 
 	spin_lock(&inode->i_lock);
-	if (atomic_read(&inode->i_count) ||
-	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
+	if (atomic_read(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+
+		/* for each watch, send FS_UNMOUNT and then remove it */
+		if (post_unmount && fsnotify_sb_info(sb)) {
+			fsnotify_inode(inode, FS_UNMOUNT);
+			fsnotify_inode_delete(inode);
+		}
+		return INO_ITER_DONE;
+	}
+
+	if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 		spin_unlock(&inode->i_lock);
 		return INO_ITER_DONE;
 	}
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 68c34ed9427190..cf89aa69e82c8d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -28,16 +28,6 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	fsnotify_clear_marks_by_mount(mnt);
 }
 
-static int fsnotify_unmount_inode_fn(struct inode *inode, void *data)
-{
-	spin_unlock(&inode->i_lock);
-
-	/* for each watch, send FS_UNMOUNT and then remove it */
-	fsnotify_inode(inode, FS_UNMOUNT);
-	fsnotify_inode_delete(inode);
-	return INO_ITER_DONE;
-}
-
 void fsnotify_sb_delete(struct super_block *sb)
 {
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
@@ -46,19 +36,6 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	/*
-	 * If i_count is zero, the inode cannot have any watches and
-	 * doing an __iget/iput with SB_ACTIVE clear would actually
-	 * evict all inodes with zero i_count from icache which is
-	 * unnecessarily violent and may in fact be illegal to do.
-	 * However, we should have been called /after/ evict_inodes
-	 * removed all zero refcount inodes, in any case. Hence we use
-	 * INO_ITER_REFERENCED to ensure zero refcount inodes are filtered
-	 * properly.
-	 */
-	super_iter_inodes(sb, fsnotify_unmount_inode_fn, NULL,
-			INO_ITER_REFERENCED);
-
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
diff --git a/fs/super.c b/fs/super.c
index 971ad4e996e0ba..88dd1703fe73db 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -167,28 +167,17 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
-bool super_iter_iget(struct inode *inode, int flags)
+bool super_iter_iget(struct inode *inode)
 {
-	bool	ret = false;
+	bool ret = false;
 
 	spin_lock(&inode->i_lock);
-	if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))
-		goto out_unlock;
-
-	/*
-	 * Skip over zero refcount inode if the caller only wants
-	 * referenced inodes to be iterated.
-	 */
-	if ((flags & INO_ITER_REFERENCED) &&
-	    !atomic_read(&inode->i_count))
-		goto out_unlock;
-
-	__iget(inode);
-	ret = true;
-out_unlock:
+	if (!(inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
+		__iget(inode);
+		ret = true;
+	}
 	spin_unlock(&inode->i_lock);
 	return ret;
-
 }
 EXPORT_SYMBOL_GPL(super_iter_iget);
 
@@ -216,7 +205,7 @@ int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (!super_iter_iget(inode, flags))
+		if (!super_iter_iget(inode))
 			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 		iput(old_inode);
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ee544556cee728..5a174e690424fb 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1654,8 +1654,7 @@ xfs_iter_vfs_igrab(
 	if (ip->i_flags & XFS_ITER_VFS_NOGRAB_IFLAGS)
 		goto out_unlock_noent;
 
-	if ((flags & INO_ITER_UNSAFE) ||
-	    super_iter_iget(inode, flags))
+	if ((flags & INO_ITER_UNSAFE) || super_iter_iget(inode))
 		ret = true;
 
 out_unlock_noent:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2aa335228b84bf..a3c682f0d94c1b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2224,7 +2224,7 @@ enum freeze_holder {
 typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
 int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
 		void *private_data, int flags);
-bool super_iter_iget(struct inode *inode, int flags);
+bool super_iter_iget(struct inode *inode);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);

