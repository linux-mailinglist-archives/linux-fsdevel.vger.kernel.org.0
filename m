Return-Path: <linux-fsdevel+bounces-69479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2290C7D562
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6C834E32FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E126FDB2;
	Sat, 22 Nov 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJX4qxzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2C846F;
	Sat, 22 Nov 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763835557; cv=none; b=me86mnIx1IJoUG5LtyBeUorYLxO58rk01hDQewvzS5UyhDIR9hk0I32HsDmxEA62alreBjfrlXM/oRaE2qNcJXLUV3Hu/3jPCk+8ZSa9pVsmwF169xinXrvpeIay276+IhLN6KqFEe5ku/rPkN+qiENkATyQB1SIYZ1dmh8uYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763835557; c=relaxed/simple;
	bh=evUzKx3L4rrqlSjgN6yULWLWGPrGF5cq0KQWOKa1cCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgwjt9AcKx17/5PkKmlxwTn3ejB6l+eTTwTdWLndV6uam78c5RrwIIHCz/KEIk4eeh1u4ikH6Bt9MUKeyR9HTeMj+o9J1idNVfVV6ahLblJCLdRNy5z+evpGMBmTroWKDLtOIzohevEX1Vn/8/IfFsOByeFKIc+L1ejkaX9vkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJX4qxzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01035C4CEF5;
	Sat, 22 Nov 2025 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763835556;
	bh=evUzKx3L4rrqlSjgN6yULWLWGPrGF5cq0KQWOKa1cCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJX4qxzJDek73qTk6QjQ4ZYHTwS7FNpz23Q8XgjBF79QTyAZTdVHqQXjWzEWeGbDh
	 N+pMJcoxquWoZAyx8a3gQeDJHyhof/pp5esTjWUInn0N3vb28YU1y9ZdA1Zxugw9c2
	 M8/LpF24kl03DYMylnggdh3TT9k8Ho/6CZ8RAC9l+Zz82tPPcPP1bKtkwhVE6r1a6I
	 zMqIF6CPoR7TVxbBt9t6KlT/v1LXKbOaMAQIYlb7CjQoGBSu/numimc4grxUSxKzSg
	 28Jm6KM2/KT7MLx0tW1C4g/LbrPOs7a8N9cGyQ0N/j5cTLCyLDBrZMz72DI4zDFz/2
	 4ID9ZGG+tetcQ==
Date: Sat, 22 Nov 2025 10:19:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/11] fscrypt: return a byte offset from
 bh_get_inode_and_lblk_num
Message-ID: <20251122181914.GB1626@quark>
References: <20251118062159.2358085-1-hch@lst.de>
 <20251118062159.2358085-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118062159.2358085-9-hch@lst.de>

On Tue, Nov 18, 2025 at 07:21:51AM +0100, Christoph Hellwig wrote:
> All the callers now want a byte offset into the inode, so return
> that from bh_get_inode_and_lblk_num.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/inline_crypt.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index c069958c4819..128268adf960 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -315,7 +315,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
>  /* Extract the inode and logical block number from a buffer_head. */

inode and file position

>  static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  				      const struct inode **inode_ret,
> -				      u64 *lblk_num_ret)
> +				      loff_t *pos_ret)

Rename to bh_get_inode_and_pos()

> * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead  
> * of an inode and block number directly.                                        
> */                                                                              
> void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,                               
>                                  const struct buffer_head *first_bh,            
>                                  gfp_t gfp_mask)                

inode and file position

> * Same as fscrypt_mergeable_bio(), except this takes a buffer_head instead of
> * an inode and block number directly.
> *
> * Return: true iff the I/O is mergeable
> */
> bool fscrypt_mergeable_bio_bh(struct bio *bio,
>                              const struct buffer_head *next_bh)

inode and file position

- Eric

