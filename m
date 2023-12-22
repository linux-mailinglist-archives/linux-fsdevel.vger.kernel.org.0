Return-Path: <linux-fsdevel+bounces-6769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D681C4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694612883DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F263B5;
	Fri, 22 Dec 2023 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQy7cwG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDC611B;
	Fri, 22 Dec 2023 05:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CFFC433C8;
	Fri, 22 Dec 2023 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703224715;
	bh=koP/w5X1JGxFG62V66WQtMlBBjy2n7pRoumVVE4mK80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQy7cwG1M88/K4d1kfWky7jNIGI7tpT0spjp/jAvD4QZp16fVYGC9b1SZ2QKclslh
	 Ku2WJTeg+6Fsa9rWOY0g7+z84e3sazJAIZxbMKPas3Omckh3RVzp337rdShFREn+xy
	 2BYpycRrCGrXOnEJUFK4ddmQ7W6rlm+E8vdh5AxqnGhVJmPKTPeRUCTbclKMvatjlb
	 ePwzcXji3riCebA0kDYWjA7mk+DO9O44vDAd+GZr480nTlD4J503jBEpA8jnkBYRVe
	 9SqQzm+J9gU3vQ/VPwLpwE8Rsc7Cgg19XytcVkXbSlgKb9JXT/prBp/3BiRkepZOVv
	 ZQS3xWLM2ciKg==
Date: Thu, 21 Dec 2023 23:58:30 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, jaegeuk@kernel.org,
	tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] fscrypt: Move d_revalidate configuration back
 into fscrypt
Message-ID: <20231222055830.GA97172@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-9-krisman@suse.de>
 <20231221073940.GC1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221073940.GC1674809@ZenIV>

On Thu, Dec 21, 2023 at 07:39:40AM +0000, Al Viro wrote:
> Hmm...  Could we simply set ->s_d_op to &fscrypt_dentry_ops in non-ci case
> *AND* have __fscrypt_prepare_lookup() clear DCACHE_OP_REVALIDATE in case
> when it's not setting DCACHE_NOKEY_NAME and ->d_op->d_revalidate is
> equal to fscrypt_d_revalidate?  I mean,
> 
> 	spin_lock(&dentry->d_lock);
>         if (fname->is_nokey_name)
>                 dentry->d_flags |= DCACHE_NOKEY_NAME;
>         else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
> 		 dentry->d_op->d_revalidate == fscrypt_d_revalidate)
> 		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
> 	spin_unlock(&dentry->d_lock);
> 
> here + always set ->s_d_op for ext4 and friends (conditional upon
> the CONFIG_UNICODE).
> 
> No encryption - fine, you get ->is_nokey_name false from the very
> beginning, DCACHE_OP_REVALIDATE is cleared and VFS won't ever call
> ->d_revalidate(); not even the first time.  
> 
> Yes, you pay minimal price in dentry_unlink_inode() when we hit
>         if (dentry->d_op && dentry->d_op->d_iput)
> and bugger off after the second fetch instead of the first one.
> I would be quite surprised if it turns out to be measurable,
> but if it is, we can always add DCACHE_OP_IPUT to flags.
> Similar for ->d_op->d_release (called in the end of
> __dentry_kill()).  Again, that only makes sense if we get
> a measurable overhead from that.

fscrypt_prepare_lookup() handles unencrypted directories inline, without calling
__fscrypt_prepare_lookup() which is only for encrypted directories.  So the
logic to clear DCACHE_OP_REVALIDATE would need to be there too.

- Eric

