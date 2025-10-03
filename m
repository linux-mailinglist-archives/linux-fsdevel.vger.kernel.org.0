Return-Path: <linux-fsdevel+bounces-63396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC6BB8188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0D719E6E07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988122D780;
	Fri,  3 Oct 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDwkzeuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1317A2E1;
	Fri,  3 Oct 2025 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522963; cv=none; b=noh0IPtfRoE2kEbWsXMHCswXvQqlhD485wZqd1RUaVaqJe/PE0qfYNGj3XLHLb5tMMiQNeuMRy91mKbI0F3WPqhqpLKipAdDHCb88g4ZDQjq7s0QPPl5KqArFUvPUuQjxq9+8Mm3sPcRftXel+ZBQ9L2/rR+1ADwtjGECYkT084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522963; c=relaxed/simple;
	bh=ZWuAYLzcB5M0YLrWElkToEmrzc++2vCARxZvzmBun/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKjrvDmRL+ghTe+NwZk30ZMXVbn03yr+VPjg7vT1706lN1EqyCymoZraOyox9I+NDn3h/aeN/3/MNye5s05CyVzhAnewgPVvdVL0Wy8vgd4uyPXYQOgRoUHSIzWTMUo14DteS0n4w6OXzyWXkKJgAQhTJDt/0EQLdQGOaCVtdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=uDwkzeuy reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ie7VpTVQGHumN0D6yzqUveYN7Cgx4KCz/Feuh+IPz94=; b=uDwkzeuyhuN5TZvMem00DJ1Kij
	OwzoBqHmEYUuFPejuGg4uFGc4AQEJ9l4Lbxsegjwmizr0TStvq5OcU5m/31aurpc6fMKnNiuehkui
	AUWQb+wDGUjf75Rl4mHDu8UlVObtrUfo8X5jCaghcFNrKom5Ft64KhwivOGrHdsPwEdbbPjdAb3yn
	RtSyiA2TJfPhK1SLdQVqr5z5I8ktKT4zg314+Gb9hD4s/5J5wuH0tYvCFat7yk6WOJc2LYhfjzpUx
	w9IxWkktR/hMNFXlEcBmcVZ/S3jZVCSS5AGvDq4siFZVr7/m2CCFmUoHGEUeqeUnBHXTPWVQu6vaY
	PkcOTYxw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4mIS-000000095Ew-0kqB;
	Fri, 03 Oct 2025 20:22:32 +0000
Date: Fri, 3 Oct 2025 13:22:28 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: ocfs2-devel@lists.linux.dev, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joseph.qi@linux.alibaba.com, brauner@kernel.org
Subject: Re: [PATCH v2] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Message-ID: <aOAwhPT-rlnxmEtS@google.com>
Mail-Followup-To: Mateusz Guzik <mjguzik@gmail.com>,
	ocfs2-devel@lists.linux.dev, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joseph.qi@linux.alibaba.com, brauner@kernel.org
References: <20251003023652.249775-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003023652.249775-1-mjguzik@gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>


Since this is in `iput_final()`, it's outside of OCFS2 cluster locking.
The only work `ocfs_drop_inode()` does is to juggle the spinlock and
state while writing the inode.  `evict()` does this just a little later
in `iput_final()`, and there's no real way the flow gets interrupted, so
it is not even moving the writeout that far.

Reviewed-by: Joel Becker <jlbec@evilplan.org>

On Fri, Oct 03, 2025 at 04:36:52AM +0200, Mateusz Guzik wrote:
> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> fine (tm).
> 
> The intent is to retire the I_WILL_FREE flag.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> v2:
> - rebase -- generic_delete_inode -> inode_just_drop
> 
> The original posting got derailed and then this got lost in the shuffle,
> see: https://lore.kernel.org/linux-fsdevel/20250904154245.644875-1-mjguzik@gmail.com/
> 
> This is the only filesystem using the flag. The only other spot is in
> iput_final().
> 
> I have a wip patch to sort out the writeback vs iput situation a little
> bit and need this out of the way.
> 
> Even if said patch does not go in, this clearly pushes things forward by
> removing flag usage.
> 
>  fs/ocfs2/inode.c       | 23 ++---------------------
>  fs/ocfs2/inode.h       |  1 -
>  fs/ocfs2/ocfs2_trace.h |  2 --
>  fs/ocfs2/super.c       |  2 +-
>  4 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..84115bf8b464 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
>  
>  void ocfs2_evict_inode(struct inode *inode)
>  {
> +	write_inode_now(inode, 1);
> +
>  	if (!inode->i_nlink ||
>  	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
>  		ocfs2_delete_inode(inode);
> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
>  	ocfs2_clear_inode(inode);
>  }
>  
> -/* Called under inode_lock, with no more references on the
> - * struct inode, so it's safe here to check the flags field
> - * and to manipulate i_nlink without any other locks. */
> -int ocfs2_drop_inode(struct inode *inode)
> -{
> -	struct ocfs2_inode_info *oi = OCFS2_I(inode);
> -
> -	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> -				inode->i_nlink, oi->ip_flags);
> -
> -	assert_spin_locked(&inode->i_lock);
> -	inode->i_state |= I_WILL_FREE;
> -	spin_unlock(&inode->i_lock);
> -	write_inode_now(inode, 1);
> -	spin_lock(&inode->i_lock);
> -	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state &= ~I_WILL_FREE;
> -
> -	return 1;
> -}
> -
>  /*
>   * This is called from our getattr.
>   */
> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> index accf03d4765e..07bd838e7843 100644
> --- a/fs/ocfs2/inode.h
> +++ b/fs/ocfs2/inode.h
> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
>  }
>  
>  void ocfs2_evict_inode(struct inode *inode);
> -int ocfs2_drop_inode(struct inode *inode);
>  
>  /* Flags for ocfs2_iget() */
>  #define OCFS2_FI_FLAG_SYSFILE		0x1
> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> index 54ed1495de9a..4b32fb5658ad 100644
> --- a/fs/ocfs2/ocfs2_trace.h
> +++ b/fs/ocfs2/ocfs2_trace.h
> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
>  
>  DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
>  
> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> -
>  TRACE_EVENT(ocfs2_inode_revalidate,
>  	TP_PROTO(void *inode, unsigned long long ino,
>  		 unsigned int flags),
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 53daa4482406..2c7ba1480f7a 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
>  	.statfs		= ocfs2_statfs,
>  	.alloc_inode	= ocfs2_alloc_inode,
>  	.free_inode	= ocfs2_free_inode,
> -	.drop_inode	= ocfs2_drop_inode,
> +	.drop_inode	= inode_just_drop,
>  	.evict_inode	= ocfs2_evict_inode,
>  	.sync_fs	= ocfs2_sync_fs,
>  	.put_super	= ocfs2_put_super,
> -- 
> 2.43.0
> 
> 

-- 

"Hell is oneself, hell is alone, the other figures in it, merely projections."
        - T. S. Eliot

			http://www.jlbec.org/
			jlbec@evilplan.org

