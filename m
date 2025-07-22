Return-Path: <linux-fsdevel+bounces-55746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C85B0E4D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E979118858BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E7284674;
	Tue, 22 Jul 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th38QT5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903880C02;
	Tue, 22 Jul 2025 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215591; cv=none; b=jv0CYxiGhRk9MDYhSrfogP4wpG956gGoAcKF5VzUvr7k2sLCNa8K3VCUY3762FWsx1VWo9ZL4mJNyWAkMgQW1hYIFLlILS9RNas3VB6ybiQfL/0lCH4SBVMc/lio5wq9mzeshh9sUEHHbzPOe5Orz4GQyijpe8T7/V7xD+mOI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215591; c=relaxed/simple;
	bh=/o/woutJhjSsPa08LxYD40uSshatW58sCwC45kM2VQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCG/mUkbZvG4yRGZ8yEVm1Y26LOd25OefuBWSjpSXp4SLsC98WAfiVtJTAci9OSrtXjMn6c28J1IG4ho52yI0Zin3rKjDuEzRTRtuvY1bKJPs2/SJcePwVcI3rVg6tDU9hpVDDkeeIC4dxavbbH9TGpYEKT10j08CHn+u55CeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th38QT5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4018C4CEEB;
	Tue, 22 Jul 2025 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753215590;
	bh=/o/woutJhjSsPa08LxYD40uSshatW58sCwC45kM2VQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=th38QT5n5+hA/TmHhDZAD/CKT/8omTLhd55gdA9AKRXMsbtCvhtdlvjUoW3j+IsCh
	 qxB48TupY42tHNtKrT++7CAiR0pTv9ZRlMHjuaSpIUgw1TOj5aV1M03BFO2pBnAliu
	 iM8OlNVhSgAjEJUQA+HnvdhaDQYcxQKVqG/yIr9GJ9DwlDGSKzYbUFLArCrc9CFNfR
	 8QhN0Qg89wTqxPZ5hlZFJNb1sTidoH+Pd/rU+BYH2f/umdJtKWDS4D+uBXA68a+8E6
	 GkyWuz4uY+Z98MYGPbkcUK6k9erh/QtM6RVCe0X6PVvLYE/++l87gnyYJNSuq689iD
	 QXBV5jooBuI+A==
Date: Tue, 22 Jul 2025 13:19:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 07/13] fs: drop i_crypt_info from struct inode
Message-ID: <20250722201945.GD111676@quark>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-7-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-7-bdc1033420a0@kernel.org>

On Tue, Jul 22, 2025 at 09:27:25PM +0200, Christian Brauner wrote:
> @@ -799,12 +799,11 @@ void fscrypt_put_encryption_info(struct inode *inode)
>  {
>  	struct fscrypt_inode_info **crypt_info;
>  
> -	if (inode->i_sb->s_op->i_fscrypt)
> +	if (inode->i_sb->s_op->i_fscrypt) {
>  		crypt_info = fscrypt_addr(inode);
> -	else
> -		crypt_info = &inode->i_crypt_info;
> -	put_crypt_info(*crypt_info);
> -	*crypt_info = NULL;
> +		put_crypt_info(*crypt_info);
> +		*crypt_info = NULL;
> +	}
>  }

This could use an IS_ENCRYPTED(inode) check at the beginning, to
minimize the overhead on unencrypted files.  Before we just loaded
inode:i_crypt_info, but now that accessing the fscrypt_inode_info will
be more expensive it would be worthwhile to check IS_ENCRYPTED() first.

>  static inline struct fscrypt_inode_info *
> @@ -232,15 +224,14 @@ fscrypt_get_inode_info(const struct inode *inode)
>  {
>  	/*
>  	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
> -	 * I.e., another task may publish ->i_crypt_info concurrently, executing
> +	 * I.e., another task may publish ->i_fscrypt_info concurrently, executing
>  	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
>  	 * ACQUIRE the memory the other task published.
>  	 */
>  
>  	if (inode->i_sb->s_op->i_fscrypt)
>  		return smp_load_acquire(fscrypt_addr(inode));
> -
> -	return smp_load_acquire(&inode->i_crypt_info);
> +	return NULL;

The conditional here shouldn't be needed, since this should be called
only on filesystems that support encryption.  Did you find a case where
it isn't?

- Eric

