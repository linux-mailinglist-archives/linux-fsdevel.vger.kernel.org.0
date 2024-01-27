Return-Path: <linux-fsdevel+bounces-9194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A573083EBA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 08:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84131C21C55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 07:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC341D6A7;
	Sat, 27 Jan 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYspIfFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED41DFC4;
	Sat, 27 Jan 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339865; cv=none; b=hILEiAZdGfGghRsif+MD9zWEN22z8VAGSd5U8gMmdM2xKQEslKDGea+sCztSsBuWxuh+drjrL1gQUkpBKvWA1nIb8YXVwR5u45Chsd11rDVWH4Xahyu7LoG2otpQu6k+u5Uzcc1eGSO639MPfFiRd7eHizSAbJL6Xi33Km+bJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339865; c=relaxed/simple;
	bh=2sb2qVxt6PrgAJqmZv6M7/Y6R04t+vvkBE5DfqST5ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWvgnkXSAM8UDn+pJhVPENMJqXAbS2zpVT7P+dU5SOv5I7PnYNHRpOMYIhlbgabR5v3q4bhyny2DMxwpWtW/Ib2558nilSf411TjyXKYnB4qKzkKUiKbiGTalPtDyYPgJrhDM5mZWmCzpNUxGMWvqKQy2iNvlcXElt6igMMIHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYspIfFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC8C433C7;
	Sat, 27 Jan 2024 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706339864;
	bh=2sb2qVxt6PrgAJqmZv6M7/Y6R04t+vvkBE5DfqST5ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYspIfFu81fmBkiTLdK61JeZiCDlltocBkCBZfhPSLEcIETq0mgrTlexbUkIYiRB8
	 3jmCOCeeJ+vYB8WyyRcpnzT6HCkaDrVQSpGG9H8sOoKhd1kYgNIbSAbn7ETdYv422+
	 i9CJynZWA4ZYQG5YDNvP9V4vOc88ZSt9ObVv1qKELukHbI2qHsR0ukiLZ8XBTozMpO
	 jQj62mTGi1+LSoe9WOh73mr59q+Jskojd8zWGSCsqUsoES9ZD+R4phP/7NqL0NSIjR
	 oSAcW8ohaBQPqBuLcfgvuYI66L5bN/rjgp4b6DRQqLHiF6hiFpI51wF0B7RfsHb3Oo
	 3KKnhK2fjT6IQ==
Date: Fri, 26 Jan 2024 23:17:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
Message-ID: <20240127071742.GE11935@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-5-krisman@suse.de>
 <20240125031251.GC52073@sol.localdomain>
 <875xzhxizb.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xzhxizb.fsf@mailhost.krisman.be>

On Thu, Jan 25, 2024 at 05:20:56PM -0300, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Fri, Jan 19, 2024 at 03:47:36PM -0300, Gabriel Krisman Bertazi wrote:
> >> /*
> >>  * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
> >>  * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
> >>  * cleared.  Note that we don't have to support arbitrary moves of this flag
> >>  * because fscrypt doesn't allow no-key names to be the source or target of a
> >>  * rename().
> >>  */
> >>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
> >>  {
> >>  	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
> >> +
> >> +	/*
> >> +	 * Save the d_revalidate call cost during VFS operations.  We
> >> +	 * can do it because, when the key is available, the dentry
> >> +	 * can't go stale and the key won't go away without eviction.
> >> +	 */
> >> +	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
> >> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
> >>  }
> >
> > Is there any way to optimize this further for the case where fscrypt is not
> > being used?  This is called unconditionally from d_move().  I've generally been
> > trying to avoid things like this where the fscrypt support slows things down for
> > everyone even when they're not using the feature.
> 
> The problem would be figuring out whether the filesystem has fscrypt
> enabled.  I think we can rely on sb->s_cop always being set:
> 
> if (sb->s_cop)
>    fscrypt_handle_d_move(dentry);
> 
> What do you think?

That's better, I just wonder if there's an even better way.  Do you need to do
this for dentries that don't have DCACHE_NOKEY_NAME set?  If not, it would be
more efficient to test for DCACHE_NOKEY_NAME before clearing the flags.

- Eric

