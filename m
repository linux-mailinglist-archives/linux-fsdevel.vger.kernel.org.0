Return-Path: <linux-fsdevel+bounces-59009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB5B33E54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595467AAF14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F182C0F66;
	Mon, 25 Aug 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYtuHf8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC11E5710;
	Mon, 25 Aug 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122390; cv=none; b=Ss/1MpJZ8ZoVg0TA+dH5cnKHhF8MjZoQwgN5hDV6+6cWik62x5QCc+TKyMTYcS7oblYtw8zqS31RSrK99uhNk0kzwczeJXXj5njxvkScyFFaSfs+xFAuQ2YijVhntNZ9W4POxX2ywp/jJ17qHFG49uqT8ms3S7yKVZf+H/FMvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122390; c=relaxed/simple;
	bh=pvBXdjbZFIvwciYOzt+jhMAY8D5whyMKD7O4SG+Wcwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvpyzQww4Vn3f0FFwVpEd55EHH5fs04VzE2NI7WZe9fYgC1yRCIITR8PABz0b1QVAUOfaxMaauRQkwGgwZfiVVg6TjSKROiztd0z+CtN9oqBa2kfiHIWmrEje4iDbtD5xiID2WA/l3VHVdtoFEpTz0qNoh8ex+dHZpE4IR8qhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYtuHf8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1012CC4CEED;
	Mon, 25 Aug 2025 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122389;
	bh=pvBXdjbZFIvwciYOzt+jhMAY8D5whyMKD7O4SG+Wcwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYtuHf8tg6AqE99tfIDPB2f7H4dc6GZd/XVuWdch94F5FC9RCIt1ou0RuMWJ6qNG3
	 SLIxPJ//rJObQeyUVPZRJfimfUNAo943Ta6TrjsrebGf16EUyEC9MCwMShgtaPaoAs
	 ZqsPUt4zLIqoiV5LlE6xqm70fJsQRqXcihYgNPNPRc4mbZipzSSsUBDfHoizERjD//
	 tG40+uNzO1UU/IisFNjbaBseKdmORGR57dLgfO6cz2Kr4C55LEc1bbJcRKbHL+8+pq
	 Z6/d9nYlVD0Hib7eZGGFs1yfcl8D6O0SkJdiHWwDA6Xzhkuv1JH3y50yLILWbo6BFc
	 q5MUx0g7iRWaQ==
Date: Mon, 25 Aug 2025 13:46:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 35/50] fs: remove I_WILL_FREE|I_FREEING from
 fs-writeback.c
Message-ID: <20250825-tassen-saugt-7fb4b5909be1@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <4ce42c8d0da7647e98a7dc3b704d19b57e60b71d.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ce42c8d0da7647e98a7dc3b704d19b57e60b71d.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:46PM -0400, Josef Bacik wrote:
> Now that we have the reference count to indicate live inodes, we can
> remove all of the uses of I_WILL_FREE and I_FREEING in fs-writeback.c
> and use the appropriate reference count checks.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Very nice change and it will be even better without the plain accesses
to i_count. ;)

>  fs/fs-writeback.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 789c4228412c..0ea6d0e86791 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -129,7 +129,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(!refcount_read(&inode->i_count));
>  
>  	if (list_empty(&inode->i_io_list))
>  		iobj_get(inode);
> @@ -314,7 +314,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(!refcount_read(&inode->i_count));
>  
>  	inode->i_state &= ~I_SYNC_QUEUED;
>  	if (wb != &wb->bdi->wb)
> @@ -415,10 +415,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	xa_lock_irq(&mapping->i_pages);
>  
>  	/*
> -	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
> -	 * path owns the inode and we shouldn't modify ->i_io_list.
> +	 * Once the refcount is 0, the eviction path owns the inode and we
> +	 * shouldn't modify ->i_io_list.
>  	 */
> -	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
> +	if (unlikely(!refcount_read(&inode->i_count)))
>  		goto skip_switch;
>  
>  	trace_inode_switch_wbs(inode, old_wb, new_wb);
> @@ -570,13 +570,16 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> -	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> +	    inode->i_state & I_WB_SWITCH ||
>  	    inode_to_wb(inode) == new_wb) {
>  		spin_unlock(&inode->i_lock);
>  		return false;
>  	}
> +	if (!inode_tryget(inode)) {
> +		spin_unlock(&inode->i_lock);
> +		return false;
> +	}
>  	inode->i_state |= I_WB_SWITCH;
> -	__iget(inode);
>  	spin_unlock(&inode->i_lock);
>  
>  	return true;
> @@ -1207,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(!refcount_read(&inode->i_count));
>  
>  	inode->i_state &= ~I_SYNC_QUEUED;
>  	inode_delete_from_io_list(inode);
> @@ -1405,7 +1408,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
>  	 * tracking. Flush worker will ignore this inode anyway and it will
>  	 * trigger assertions in inode_io_list_move_locked().
>  	 */
> -	if (inode->i_state & I_FREEING) {
> +	if (!refcount_read(&inode->i_count)) {
>  		inode_delete_from_io_list(inode);
>  		wb_io_lists_depopulated(wb);
>  		return;
> @@ -1621,7 +1624,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  			  struct writeback_control *wbc,
>  			  unsigned long dirtied_before)
>  {
> -	if (inode->i_state & I_FREEING)
> +	if (!refcount_read(&inode->i_count))
>  		return;
>  
>  	/*
> @@ -1787,7 +1790,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>   * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
>   *
>   * To prevent the inode from going away, either the caller must have a reference
> - * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
> + * to the inode, or the inode must have a zero refcount.
>   */
>  static int writeback_single_inode(struct inode *inode,
>  				  struct writeback_control *wbc)
> @@ -1797,9 +1800,7 @@ static int writeback_single_inode(struct inode *inode,
>  
>  	spin_lock(&inode->i_lock);
>  	if (!refcount_read(&inode->i_count))
> -		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
> -	else
> -		WARN_ON(inode->i_state & I_WILL_FREE);
> +		WARN_ON(inode->i_state & I_NEW);
>  
>  	if (inode->i_state & I_SYNC) {
>  		/*
> @@ -1837,7 +1838,7 @@ static int writeback_single_inode(struct inode *inode,
>  	 * If the inode is freeing, its i_io_list shoudn't be updated
>  	 * as it can be finally deleted at this moment.
>  	 */
> -	if (!(inode->i_state & I_FREEING)) {
> +	if (refcount_read(&inode->i_count)) {
>  		/*
>  		 * If the inode is now fully clean, then it can be safely
>  		 * removed from its writeback list (if any). Otherwise the
> @@ -1957,7 +1958,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 * kind writeout is handled by the freer.
>  		 */
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if ((inode->i_state & I_NEW) || !refcount_read(&inode->i_count)) {
>  			redirty_tail_locked(inode, wb);
>  			spin_unlock(&inode->i_lock);
>  			continue;
> @@ -2615,7 +2616,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			if (inode_unhashed(inode))
>  				goto out_unlock;
>  		}
> -		if (inode->i_state & I_FREEING)
> +		if (!refcount_read(&inode->i_count))
>  			goto out_unlock;
>  
>  		/*
> @@ -2729,13 +2730,17 @@ static void wait_sb_inodes(struct super_block *sb)
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> +		if (inode->i_state & I_NEW) {
> +			spin_unlock(&inode->i_lock);
> +			spin_lock_irq(&sb->s_inode_wblist_lock);
> +			continue;
> +		}
> +
> +		if (!inode_tryget(inode)) {
>  			spin_unlock(&inode->i_lock);
> -
>  			spin_lock_irq(&sb->s_inode_wblist_lock);
>  			continue;
>  		}
> -		__iget(inode);
>  
>  		/*
>  		 * We could have potentially ended up on the cached LRU list, so
> @@ -2886,7 +2891,7 @@ EXPORT_SYMBOL(sync_inodes_sb);
>   * This function commits an inode to disk immediately if it is dirty. This is
>   * primarily needed by knfsd.
>   *
> - * The caller must either have a ref on the inode or must have set I_WILL_FREE.
> + * The caller must either have a ref on the inode or the inode must have a zero refcount.
>   */
>  int write_inode_now(struct inode *inode, int sync)
>  {
> -- 
> 2.49.0
> 

