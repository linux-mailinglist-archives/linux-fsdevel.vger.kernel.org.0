Return-Path: <linux-fsdevel+bounces-35285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B269D362E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D808B25FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879C189F2B;
	Wed, 20 Nov 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuI4Y3T2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41882178368
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093201; cv=none; b=qEd2Lqbex9zbxhuYHuubncOgqV54Csm01fW2av934tmiI/3VswFEiggzUnoZL3v2GUtwHR5FM9avMpY/DFYBuNS2wuOUFxxu7gSUcDodoIWloQORsE8pTzQccY3ZC010u0Yuq/Hu/j55oHDYiSI63VDS4vZOJ9mLaKbIKuGX0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093201; c=relaxed/simple;
	bh=gqoCziSjiEZ/8ZKLDgJocNZFBiNN+JU+ZWF2dnYaXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY4SY/Ry2wL30a2OpfdRx2y5FAzHb9Iu+ACBXj9FMktxJPbXfjkWRXz5OgGoe/40XAByG7I6tAV4UAoOLuzKpIt4z/s9RfE/pAWMJllTE6jF0AzFfSWRoAfEmslpUMcTisn7dt/QzlEvIUEN3X9ZljxbwZ4pyMjYfwtaUhLj5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuI4Y3T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA31C4CECD;
	Wed, 20 Nov 2024 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093199;
	bh=gqoCziSjiEZ/8ZKLDgJocNZFBiNN+JU+ZWF2dnYaXeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuI4Y3T2PQPiTZUxuLry+YAJHrtsUMImgggxzm7l92GEO7qMxk0f/AGafAgomT5oD
	 Oe9GVz6eKDFUUB7edrNSMwUpkCeX+3Bbtdsazu7YhxZ9xikyxO/xJ8+pnznYALJOLc
	 6v76kZkNN3QVfsebOomHBd/G0Y/jYLXyptND+ubOJJa90gaPvaoRcVO3d64HOAajkf
	 6IJT+uAYNJN583pBJtWU8FzjiKt6Ut9NQwiq3vuQ9rLd90nwkJN8MWqzM2n29yPxFd
	 19e7FL9mx7UZduzcB9k23CdvJq5V+Qa9yEVtWTML3qFMmUM7226uKE3rx+TNGD6GZi
	 Lb1vT4AUIH62Q==
Date: Wed, 20 Nov 2024 09:59:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, cel@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Hugh Dickens <hughd@google.com>, yukuai3@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Message-ID: <20241120-abzocken-senfglas-8047a54f1aba@brauner>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzuqYeENJJrLMxwM@tissot.1015granger.net>

On Mon, Nov 18, 2024 at 03:58:09PM -0500, Chuck Lever wrote:
> On Mon, Nov 18, 2024 at 03:00:56PM -0500, Jeff Layton wrote:
> > On Sun, 2024-11-17 at 16:32 -0500, cel@kernel.org wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > The fix in commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> > > for offset dir") introduced a fence in offset_iterate_dir() to stop
> > > the loop from returning child entries created after the directory
> > > was opened. This comparison relies on the strong ordering of
> > > DIR_OFFSET_MIN <= largest child offset <= next_offset to terminate
> > > the directory iteration.
> > > 
> > > However, because simple_offset_add() uses mtree_alloc_cyclic() to
> > > select each next new directory offset, ctx->next_offset is not
> > > always the highest unused offset. Once mtree_alloc_cyclic() allows
> > > a new offset value to wrap, ctx->next_offset will be set to a value
> > > less than the actual largest child offset.
> > > 
> > > The result is that readdir(3) no longer shows any entries in the
> > > directory because their offsets are above ctx->next_offset, which is
> > > now a small value. This situation is persistent, and the directory
> > > cannot be removed unless all current children are already known and
> > > can be explicitly removed by name first.
> > > 
> > > In the current Maple tree implementation, there is no practical way
> > > that 63-bit offset values can ever wrap, so this issue is cleverly
> > > avoided. But the ordering dependency is not documented via comments
> > > or code, making the mechanism somewhat brittle. And it makes the
> > > continued use of mtree_alloc_cyclic() somewhat confusing.
> > > 
> > > Further, if commit 64a7ce76fb90 ("libfs: fix infinite directory
> > > reads for offset dir") were to be backported to a kernel that still
> > > uses xarray to manage simple directory offsets, the directory offset
> > > value range is limited to 32-bits, which is small enough to allow a
> > > wrap after a few weeks of constant creation of entries in one
> > > directory.
> > > 
> > > Therefore, replace the use of ctx->next_offset for fencing new
> > > children from appearing in readdir results.
> > > 
> > > A jiffies timestamp marks the end of each opendir epoch. Entries
> > > created after this timestamp will not be visible to the file
> > > descriptor. I chose jiffies so that the dentry->d_time field can be
> > > re-used for storing the entry creation time.
> > > 
> > > The new mechanism has its own corner cases. For instance, I think
> > > if jiffies wraps twice while a directory is open, some children
> > > might become invisible. On 32-bit systems, the jiffies value wraps
> > > every 49 days. Double-wrapping is not a risk on systems with 64-bit
> > > jiffies. Unlike with the next_offset-based mechanism, re-opening the
> > > directory will make invisible children re-appear.
> > > 
> > > Reported-by: Yu Kuai <yukuai3@huawei.com>
> > > Closes: https://lore.kernel.org/stable/20241111005242.34654-1-cel@kernel.org/T/#m1c448e5bd4aae3632a09468affcfe1d1594c6a59
> > > Fixes: 64a7ce76fb90 ("libfs: fix infinite directory reads for offset dir")
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/libfs.c | 36 +++++++++++++++++-------------------
> > >  1 file changed, 17 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/fs/libfs.c b/fs/libfs.c
> > > index bf67954b525b..862a603fd454 100644
> > > --- a/fs/libfs.c
> > > +++ b/fs/libfs.c
> > > @@ -294,6 +294,7 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
> > >  		return ret;
> > >  
> > >  	offset_set(dentry, offset);
> > > +	WRITE_ONCE(dentry->d_time, jiffies);
> > >  	return 0;
> > >  }
> > >  
> > > @@ -454,9 +455,7 @@ void simple_offset_destroy(struct offset_ctx *octx)
> > >  
> > >  static int offset_dir_open(struct inode *inode, struct file *file)
> > >  {
> > > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > > -
> > > -	file->private_data = (void *)ctx->next_offset;
> > > +	file->private_data = (void *)jiffies;
> > >  	return 0;
> > >  }
> > >  
> > > @@ -473,9 +472,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
> > >   */
> > >  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > >  {
> > > -	struct inode *inode = file->f_inode;
> > > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > > -
> > >  	switch (whence) {
> > >  	case SEEK_CUR:
> > >  		offset += file->f_pos;
> > > @@ -490,7 +486,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > >  
> > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > >  	if (!offset)
> > > -		file->private_data = (void *)ctx->next_offset;
> > > +		/* Make newer child entries visible */
> > > +		file->private_data = (void *)jiffies;
> > >  	return vfs_setpos(file, offset, LONG_MAX);
> > >  }
> > >  
> > > @@ -521,7 +518,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
> > >  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> > >  }
> > >  
> > > -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
> > > +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx,
> > > +			       unsigned long fence)
> > >  {
> > >  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> > >  	struct dentry *dentry;
> > > @@ -531,14 +529,15 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> > >  		if (!dentry)
> > >  			return;
> > >  
> > > -		if (dentry2offset(dentry) >= last_index) {
> > > -			dput(dentry);
> > > -			return;
> > > -		}
> > > -
> > > -		if (!offset_dir_emit(ctx, dentry)) {
> > > -			dput(dentry);
> > > -			return;
> > > +		/*
> > > +		 * Output only child entries created during or before
> > > +		 * the current opendir epoch.
> > > +		 */
> > > +		if (time_before_eq(dentry->d_time, fence)) {
> > > +			if (!offset_dir_emit(ctx, dentry)) {
> > > +				dput(dentry);
> > > +				return;
> > > +			}
> > >  		}
> > >  
> > >  		ctx->pos = dentry2offset(dentry) + 1;
> > > @@ -569,15 +568,14 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> > >   */
> > >  static int offset_readdir(struct file *file, struct dir_context *ctx)
> > >  {
> > > +	unsigned long fence = (unsigned long)file->private_data;
> > >  	struct dentry *dir = file->f_path.dentry;
> > > -	long last_index = (long)file->private_data;
> > >  
> > >  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> > >  
> > >  	if (!dir_emit_dots(file, ctx))
> > >  		return 0;
> > > -
> > > -	offset_iterate_dir(d_inode(dir), ctx, last_index);
> > > +	offset_iterate_dir(d_inode(dir), ctx, fence);
> > >  	return 0;
> > >  }
> > >  
> > 
> > Using timestamps instead of directory ordering does seem less brittle,
> > and the choice to use jiffies makes sense given that d_time is also an
> > unsigned long.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> Precisely. The goal was to re-use as much code as possible to avoid
> perturbing the current size of "struct dentry".
> 
> That said, I'm not overjoyed with using jiffies, given it has
> similar wrapping issues as ctx->next_offset on 32-bit systems. The
> consequences of an offset value wrap are less severe, though, since
> that can no longer make children entries disappear permanently.
> 
> I've been trying to imagine a solution that does not depend on the
> range of an integer value and has solidly deterministic behavior in
> the face of multiple child entry creations during one timer tick.
> 
> We could partially re-use the legacy cursor/list mechanism.
> 
> * When a child entry is created, it is added at the end of the
>   parent's d_children list.
> * When a child entry is unlinked, it is removed from the parent's
>   d_children list.
> 
> This includes creation and removal of entries due to a rename.
> 
> 
> * When a directory is opened, mark the current end of the d_children
>   list with a cursor dentry. New entries would then be added to this
>   directory following this cursor dentry in the directory's
>   d_children list.
> * When a directory is closed, its cursor dentry is removed from the
>   d_children list and freed.
> 
> Each cursor dentry would need to refer to an opendir instance
> (using, say, a pointer to the "struct file" for that open) so that
> multiple cursors in the same directory can reside in its d_chilren
> list and won't interfere with each other. Re-use the cursor dentry's
> d_fsdata field for that.
> 
> 
> * offset_readdir gets its starting entry using the mtree/xarray to
>   map ctx->pos to a dentry.
> * offset_readdir continues iterating by following the .next pointer
>   in the current dentry's d_child field.
> * offset_readdir returns EOD when it hits the cursor dentry matching
>   this opendir instance.
> 
> 
> I think all of these operations could be O(1), but it might require
> some additional locking.

This would be a bigger refactor of the whole stable offset logic. So
even if we end up doing that I think we should use the jiffies solution
for now.

