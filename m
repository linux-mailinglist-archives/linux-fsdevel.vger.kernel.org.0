Return-Path: <linux-fsdevel+bounces-27023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228295DD27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059871F226CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F07155A34;
	Sat, 24 Aug 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJibrq5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A0153BE8
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491610; cv=none; b=CJ7oPwPoTJReKuVRp9fi/aEmBMtd3tJNiVaPR6QmrSugzHRf64sd8e8esBGVp7z29HuX/nDbBUbJxv/xWc8CFzU5DNCviMP3eEVJGm78gX7kJZrXE/LC0SrmRwdnaTok6YdKWXtMVGCJvKxlhwF1zZLSxu50aOirAb06zxUE3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491610; c=relaxed/simple;
	bh=ziICq6DFNB78GoIcDhpa2GzEKQONvFJRJOFerp0CyXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cowmuUEGrpi2IhFaetozGc0W7y7+cxYk/SBtbx6hFGu5va7MElYBs24tAqe+sIbutv2o/lbjZrzUhbvWkA8BJLEFSHnJIfCWImVlgchTEZ8FnzE3za4svkRL6eBy4gFWoOYB1iue1tiVkPp00JdrhXM9GGpHKtPEBnOQPuiydVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJibrq5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201DCC32781;
	Sat, 24 Aug 2024 09:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724491609;
	bh=ziICq6DFNB78GoIcDhpa2GzEKQONvFJRJOFerp0CyXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJibrq5a4cnWtXWKeG1KJuDM9IOAjUFGhM+tZE9ruekxZampEuK+RMFvVohPm2sZ0
	 pIiZjf0z0YOYSPrcclLLzqZm4X15mm64N7YRILXN+ykeOH0IpdOJYkaYumxEqr8ni8
	 6K9J7iE3tGgc2TNrny0siEHYso9kONOZxwIrPBDWzA0E/Ot7Ghgq2cbs1iV98fPk8p
	 el7vT4YmuB1/OCKNsrQ9r6q1PiAfatnTw1gIVZTXFZnev38QkKcKfBgLWNOYLL7QoY
	 Z0czDtWmPtIjlrfglCfOeHDNvo2Gk0U+dLIGGNpt/mq576yMtR02RnT0ec6gGP2xQu
	 Jfq+XWeqs1Itw==
Date: Sat, 24 Aug 2024 11:26:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <20240824-peinigen-hocken-7384b977c643@brauner>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>
 <20240822-soviel-rohmaterial-210aef53569b@brauner>
 <47187d8f-483b-45e6-a2be-ea7826bebb62@kernel.dk>
 <20240823-luftdicht-berappen-d69a2166a0db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tqv6c5l7nrp7v7pf"
Content-Disposition: inline
In-Reply-To: <20240823-luftdicht-berappen-d69a2166a0db@brauner>


--tqv6c5l7nrp7v7pf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Aug 23, 2024 at 10:16:28AM GMT, Christian Brauner wrote:
> On Thu, Aug 22, 2024 at 10:17:37AM GMT, Jens Axboe wrote:
> > On 8/22/24 9:10 AM, Christian Brauner wrote:
> > >> Do we want to add a comment to this effect? I know it's obvious from
> > >> sharing with f_task_work, but...
> > > 
> > > I'll add one.
> > 
> > Sounds good. You can add my:
> > 
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > 
> > as well, forgot to mention that in the original reply.
> 
> I think we can deliver 192 bytes aka 3 cachelines.
> Afaict we can move struct file_ra_state into the union instead of
> f_version. See the appended patch I'm testing now. If that works then
> we're down by 40 bytes this cycle.

Seems to hold up. I've reorderd things so that no member crosses a
cacheline. Patch appended and in vfs.misc.

--tqv6c5l7nrp7v7pf
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-fs-pack-struct-file.patch"

From 88dad26dcadd9e8a47ff0cd85e9aef5a5b1667f7 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Aug 2024 21:06:58 +0200
Subject: [PATCH] fs: pack struct file

Now that we shrunk struct file to 192 bytes aka 3 cachelines reorder
struct file to not leave any holes or have members cross cachelines.

Add a short comment to each of the fields and mark the cachelines.
It's possible that we may have to tweak this based on profiling in the
future. So far I had Jens test this comparing io_uring with non-fixed
and fixed files and it improved performance. The layout is a combination
of Jens' and my changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 90 +++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c19f87ea615..ace14421d7dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -986,52 +986,62 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 		index <  ra->start + ra->size);
 }
 
-/*
- * f_{lock,count,pos_lock} members can be highly contended and share
- * the same cacheline. f_{lock,mode} are very frequently used together
- * and so share the same cacheline as well. The read-mostly
- * f_{path,inode,op} are kept on a separate cacheline.
+/**
+ * struct file - Represents a file
+ * @f_lock: Protects f_ep, f_flags. Must not be taken from IRQ context.
+ * @f_mode: FMODE_* flags often used in hotpaths
+ * @f_mapping: Contents of a cacheable, mappable object.
+ * @f_flags: file flags
+ * @f_iocb_flags: iocb flags
+ * @private_data: filesystem or driver specific data
+ * @f_path: path of the file
+ * @f_inode: cached inode
+ * @f_count: reference count
+ * @f_pos_lock: lock protecting file position
+ * @f_pos: file position
+ * @f_version: file version
+ * @f_security: LSM security context of this file
+ * @f_owner: file owner
+ * @f_cred: stashed credentials of creator/opener
+ * @f_wb_err: writeback error
+ * @f_sb_err: per sb writeback errors
+ * @f_ep: link of all epoll hooks for this file
+ * @f_task_work: task work entry point
+ * @f_llist: work queue entrypoint
+ * @f_ra: file's readahead state
  */
 struct file {
-	union {
-		/* fput() uses task work when closing and freeing file (default). */
-		struct callback_head 	f_task_work;
-		/* fput() must use workqueue (most kernel threads). */
-		struct llist_node	f_llist;
-		/* Invalid after last fput(). */
-		struct file_ra_state	f_ra;
-	};
-	/*
-	 * Protects f_ep, f_flags.
-	 * Must not be taken from IRQ context.
-	 */
-	spinlock_t		f_lock;
-	fmode_t			f_mode;
-	atomic_long_t		f_count;
-	struct mutex		f_pos_lock;
-	loff_t			f_pos;
-	unsigned int		f_flags;
-	unsigned int 		f_iocb_flags;
-	struct fown_struct	*f_owner;
-	const struct cred	*f_cred;
-	struct path		f_path;
-	struct inode		*f_inode;	/* cached value */
+	spinlock_t			f_lock;
+	fmode_t				f_mode;
 	const struct file_operations	*f_op;
-
-	u64			f_version;
+	struct address_space		*f_mapping;
+	unsigned int			f_flags;
+	unsigned int			f_iocb_flags;
+	void				*private_data;
+	struct path			f_path;
+	struct inode			*f_inode;
+	/* --- cacheline 1 boundary (64 bytes) --- */
+	atomic_long_t			f_count;
+	struct mutex			f_pos_lock;
+	loff_t				f_pos;
+	u64				f_version;
 #ifdef CONFIG_SECURITY
-	void			*f_security;
+	void				*f_security;
 #endif
-	/* needed for tty driver, and maybe others */
-	void			*private_data;
-
+	/* --- cacheline 2 boundary (128 bytes) --- */
+	struct fown_struct		*f_owner;
+	const struct cred		*f_cred;
+	errseq_t			f_wb_err;
+	errseq_t			f_sb_err;
 #ifdef CONFIG_EPOLL
-	/* Used by fs/eventpoll.c to link all the hooks to this file */
-	struct hlist_head	*f_ep;
-#endif /* #ifdef CONFIG_EPOLL */
-	struct address_space	*f_mapping;
-	errseq_t		f_wb_err;
-	errseq_t		f_sb_err; /* for syncfs */
+	struct hlist_head		*f_ep;
+#endif
+	union {
+		struct callback_head	f_task_work;
+		struct llist_node	f_llist;
+		struct file_ra_state	f_ra;
+	};
+	/* --- cacheline 2 boundary (192 bytes) --- */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
-- 
2.43.0


--tqv6c5l7nrp7v7pf--

