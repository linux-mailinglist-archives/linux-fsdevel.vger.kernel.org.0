Return-Path: <linux-fsdevel+bounces-59485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F1B39C19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6073B2FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A930F7FD;
	Thu, 28 Aug 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNqMY2j3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433C30E83A;
	Thu, 28 Aug 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382408; cv=none; b=ih1c5YsjrpBZo2XcFWlrpBcZ4LUXMXfef9llONkR0W2HPfh3rEptNO25z0KAKiUfMoANK/3F2QDH61LcmS5o5+9OKRbaE1YMyNFI7Rge2jaiuoBB9435b37Gq2Grvi639ry/zzAu/f/skzUQ2HB7Xhtw1PE8fsMlbIbnf6OrcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382408; c=relaxed/simple;
	bh=zV9nQQ1jeG4pQcfTCaKJZhlVkkd7LJWhgCAobAnzgwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb83Fe0QWkvCeJhH2x/vmnZWTQC36Mm55agVSQLaCTxld7TNPd+KVEHttc07Y6bJQjweUKeJOinm6LFQGifCiEAO7hbqF1Rw7YM9KQpn1xNaaNkHt0JCo4YdtR6YZ246rYqIEIHkat0ghazSYXkkYrzt90NVa03qMn8jqjJdDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNqMY2j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A59C4CEEB;
	Thu, 28 Aug 2025 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756382407;
	bh=zV9nQQ1jeG4pQcfTCaKJZhlVkkd7LJWhgCAobAnzgwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNqMY2j3A6b9vRxGUxCKEmSYBzZUlrob5mMh9CM0nTTeNn9dCPcBbdIGFV4ZSuHO3
	 VZVnJtQRYb98n/3gMUxUtUDLwBggUK25DaxDP1iODGUpefkHSDWRmm2/L68hzGT4Mv
	 Wmlqf2UH5Q4d+2tkxo7TYAbwVbEsFmnovVoGMmLF5kOvwvBLSgmZ2G0APAaUEH+trp
	 5hFSKJmZyFmxvfGEcBpmAGiEqUPGLmnSeY4yDClNX6Xa8pDMUC9TBzMPrw+9hmOT7A
	 A3dzgJNA0U2LwCaXriHcTzBEw0nkDw/U6cCXP6l4BBpb/E6xiyJQK/R7MxcwvvlYaI
	 HctxlVa4tvP3A==
Date: Thu, 28 Aug 2025 14:00:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 22/54] fs: convert i_count to refcount_t
Message-ID: <20250828-bergkette-umtriebe-921d8f3bdf4e@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <36a888e4cf47948c01f49ee24ede2b662075fc5e.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36a888e4cf47948c01f49ee24ede2b662075fc5e.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:22AM -0400, Josef Bacik wrote:
> Now that we do not allow i_count to drop to 0 and be used we can convert
> it to a refcount_t and benefit from the protections those helpers add.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c   | 2 +-
>  fs/inode.c         | 9 +++++----
>  include/linux/fs.h | 6 +++---
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e16df38e0eef..eb9496342346 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3418,7 +3418,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	unsigned long flags;
>  
> -	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
> +	if (refcount_dec_not_one(&inode->vfs_inode.i_count)) {

Now this is the only place outside core VFS where we open-access
i_count. Add a helper and reuse it iput() as well? icount_maybe_dec()?
icount_dec_not_one()?

>  		iobj_put(&inode->vfs_inode);
>  		return;
>  	}
> diff --git a/fs/inode.c b/fs/inode.c
> index 1992db5cd70a..0be1c137bf1e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -236,7 +236,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  	inode->i_state = 0;
>  	atomic64_set(&inode->i_sequence, 0);
>  	refcount_set(&inode->i_obj_count, 1);
> -	atomic_set(&inode->i_count, 1);
> +	refcount_set(&inode->i_count, 1);
>  	inode->i_op = &empty_iops;
>  	inode->i_fop = &no_open_fops;
>  	inode->i_ino = 0;
> @@ -545,7 +545,8 @@ static void init_once(void *foo)
>  void ihold(struct inode *inode)
>  {
>  	iobj_get(inode);
> -	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> +	refcount_inc(&inode->i_count);
> +	WARN_ON(icount_read(inode) < 2);
>  }
>  EXPORT_SYMBOL(ihold);
>  
> @@ -2011,7 +2012,7 @@ static void __iput(struct inode *inode, bool skip_lru)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
>  
> -	if (atomic_add_unless(&inode->i_count, -1, 1)) {
> +	if (refcount_dec_not_one(&inode->i_count)) {
>  		iobj_put(inode);
>  		return;
>  	}
> @@ -2031,7 +2032,7 @@ static void __iput(struct inode *inode, bool skip_lru)
>  	 */
>  	drop = maybe_add_lru(inode, skip_lru);
>  
> -	if (atomic_dec_and_test(&inode->i_count)) {
> +	if (refcount_dec_and_test(&inode->i_count)) {
>  		/* iput_final() drops i_lock */
>  		iput_final(inode, drop);
>  	} else {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 999ffea2aac1..fc23e37ca250 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -875,7 +875,7 @@ struct inode {
>  	};
>  	atomic64_t		i_version;
>  	atomic64_t		i_sequence; /* see futex */
> -	atomic_t		i_count;
> +	refcount_t		i_count;
>  	atomic_t		i_dio_count;
>  	atomic_t		i_writecount;
>  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> @@ -3399,12 +3399,12 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
>  static inline void __iget(struct inode *inode)
>  {
>  	iobj_get(inode);
> -	atomic_inc(&inode->i_count);
> +	refcount_inc(&inode->i_count);
>  }
>  
>  static inline int icount_read(const struct inode *inode)
>  {
> -	return atomic_read(&inode->i_count);
> +	return refcount_read(&inode->i_count);
>  }
>  
>  extern void iget_failed(struct inode *);
> -- 
> 2.49.0
> 

