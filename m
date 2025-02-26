Return-Path: <linux-fsdevel+bounces-42650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FEA4585B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C173618936C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74105226D18;
	Wed, 26 Feb 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgbCWtg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F2224235
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558696; cv=none; b=WQUcALYn6Qr76+4d3McAxPe0ljJd25a8KChuTEB0wOabJxoqrFwRUAqHE7ivExEfpEEHWYcGsDF1MAukVMN1eSjY9SRxdwE0isELR3RZV73g7Mu/7yjmB0kyKK4Wyn9It252B+O3h3xQII41djGBIKB2/ckv/FeWajV/N391WSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558696; c=relaxed/simple;
	bh=JwOiDuf02ZTKAV+Q7MPc+2NiNR6TXshK4IR1TsMH8M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk881pYM8esd1y4HMp1Uc2xRuL/h7JDRFNt9iiYWX6J0C3lV4HwIaZlgPWV1IOUvmmfEg4Zim4FzSWounhpMQc3iQpslbnN49TB50Aw14R23w7EJiRRslDa9JK2U9CJa7/q1lKQC7wR8lzTjtpQ6Oi0VQ1DQalcqxjQ8fWKB5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgbCWtg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D1C4CED6;
	Wed, 26 Feb 2025 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558696;
	bh=JwOiDuf02ZTKAV+Q7MPc+2NiNR6TXshK4IR1TsMH8M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgbCWtg2pQbP45r/Iw9lVxY0Ii/nfJowW9+WlKVhX9uCrqFHPxgVLL0qgNJ5Gbhhh
	 uehw3lWaMaTB8sg3gwpn4hcEevlCTm/d9+f+MT7C6wYjenqUjDqMCQyL/tlrC0i/Eq
	 nCNQpsdNHj6LlsrlitA6h4zQZI1j1c31ChftNqGoWMHC2gtJ2BBsJgaKQeFV6/+yQc
	 5dMomC9eJ1Dr33WN/8Kuy/TYEUdHnka+yBylvxAAcTwtjOZq3vqZNhShTbTuL9hGMT
	 HPiV+TicLAJCWaEAZb3f6bUbLv49T03gx/5dZc5/sdZkoJ6vmM3fCawRffzmyeJrwj
	 hQZuuaczoKinQ==
Date: Wed, 26 Feb 2025 09:31:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 06/21] split d_flags calculation out of d_set_d_op()
Message-ID: <20250226-bratwurst-lesekompetenz-9a18dc21fba2@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-6-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:36PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c | 53 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cd5e5139ca4c..1201149e1e2c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1811,33 +1811,40 @@ struct dentry *d_alloc_name(struct dentry *parent, const char *name)
>  }
>  EXPORT_SYMBOL(d_alloc_name);
>  
> +#define DCACHE_OP_FLAGS \
> +	(DCACHE_OP_HASH | DCACHE_OP_COMPARE | DCACHE_OP_REVALIDATE | \
> +	 DCACHE_OP_WEAK_REVALIDATE | DCACHE_OP_DELETE | DCACHE_OP_REAL)
> +
> +static unsigned int d_op_flags(const struct dentry_operations *op)
> +{
> +	unsigned int flags = 0;
> +	if (op) {
> +		if (op->d_hash)
> +			flags |= DCACHE_OP_HASH;
> +		if (op->d_compare)
> +			flags |= DCACHE_OP_COMPARE;
> +		if (op->d_revalidate)
> +			flags |= DCACHE_OP_REVALIDATE;
> +		if (op->d_weak_revalidate)
> +			flags |= DCACHE_OP_WEAK_REVALIDATE;
> +		if (op->d_delete)
> +			flags |= DCACHE_OP_DELETE;
> +		if (op->d_prune)
> +			flags |= DCACHE_OP_PRUNE;
> +		if (op->d_real)
> +			flags |= DCACHE_OP_REAL;
> +	}
> +	return flags;
> +}
> +
>  void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
>  {
> +	unsigned int flags = d_op_flags(op);
>  	WARN_ON_ONCE(dentry->d_op);
> -	WARN_ON_ONCE(dentry->d_flags & (DCACHE_OP_HASH	|
> -				DCACHE_OP_COMPARE	|
> -				DCACHE_OP_REVALIDATE	|
> -				DCACHE_OP_WEAK_REVALIDATE	|
> -				DCACHE_OP_DELETE	|
> -				DCACHE_OP_REAL));
> +	WARN_ON_ONCE(dentry->d_flags & DCACHE_OP_FLAGS);
>  	dentry->d_op = op;
> -	if (!op)
> -		return;
> -	if (op->d_hash)
> -		dentry->d_flags |= DCACHE_OP_HASH;
> -	if (op->d_compare)
> -		dentry->d_flags |= DCACHE_OP_COMPARE;
> -	if (op->d_revalidate)
> -		dentry->d_flags |= DCACHE_OP_REVALIDATE;
> -	if (op->d_weak_revalidate)
> -		dentry->d_flags |= DCACHE_OP_WEAK_REVALIDATE;
> -	if (op->d_delete)
> -		dentry->d_flags |= DCACHE_OP_DELETE;
> -	if (op->d_prune)
> -		dentry->d_flags |= DCACHE_OP_PRUNE;
> -	if (op->d_real)
> -		dentry->d_flags |= DCACHE_OP_REAL;
> -
> +	if (flags)
> +		dentry->d_flags |= flags;
>  }
>  EXPORT_SYMBOL(d_set_d_op);
>  
> -- 
> 2.39.5
> 

