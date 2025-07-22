Return-Path: <linux-fsdevel+bounces-55685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74676B0DA8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C5C1886DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C72E9EC1;
	Tue, 22 Jul 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QadgiOYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047D22CBE9;
	Tue, 22 Jul 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189749; cv=none; b=WBbsJzEr2tiUINMKPxjV/3KrjNDUJJfgf6Y3ld4FQZDxt4GNlxsxLBacECAjjhOWihz9s1zAbvWIDKxg2kx63X1SC4c2I2y/y0Iu9tAB7xvmpqkL5B1z1Lu3Dg4mRmE1XEMaNH630vKztnRY637pFg4/osGhECtYtUKCHR/cpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189749; c=relaxed/simple;
	bh=bzVAmmGZf3VMk2q+JXLm5CtNP4ixsVqkIHH1goyOATw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO2Q4wSHT9GgaYfq+Z7MFp20cz0oeHZTs28gdiEnGr9V2kzUu1b1Fa/aIg1wehFUq84HxGtBL/kqQirzwopT1lgKf8dtMfmMJgcZme6nCAC04T3Kk2AzN14m0xWpctzGwE1xqDgWWQNz+5tUaK2/JIYycITi4GyQP1My3lxS5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QadgiOYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B2C4CEF6;
	Tue, 22 Jul 2025 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189748;
	bh=bzVAmmGZf3VMk2q+JXLm5CtNP4ixsVqkIHH1goyOATw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QadgiOYkyd6HlyPL5ThhevexeuXUudGNCIwScnnf9G6lIiVaHLs1qRYuT4MEOGcxm
	 xlYdTbnC0Daz/x0wWWWa6Ekpa0KH2FY0ckZhkJucYldNvgRYicVNRNrcOK079TskMU
	 3MAOpT41IW7XHrN7ETQaQtk1kz7dbE27XXAU4/nj9R4wr4wcZErh4+gF6my4d7gXX/
	 WWk9QfCYzznwlDJ7xsjJ8BiK46XBG3UQY2lIkRaxukgfAcgvFR1lZ+ykNqMyOtCHN5
	 oVz/uMjopA4KkuxmBBmkFVAcIHn93wuQ9bNnsYFehx93qF3Nt3C0lKq5UelJ/Iw35V
	 emMmJxay2lDqA==
Date: Tue, 22 Jul 2025 15:09:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH RFC DRAFT v2 00/13] Move fscrypt and fsverity out of
 struct inode
Message-ID: <20250722-telefon-chloren-648e8850e6bb@brauner>
References: <fhppu2rnsykr5obrib3btw7wemislq36wufnbl67salvoguaof@kkxaosrv3oho>
 <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>

On Tue, Jul 22, 2025 at 02:57:06PM +0200, Christian Brauner wrote:
> Hey,
> 
> This is a POC. We're still discussing alternatives and I want to provide
> some useful data on what I learned about using offsets to drop fscrypt
> and fsverity from struct inode.
> 
> As discussed, this moves the fscrypt and fsverity pointers out of struct
> inode shrinking it by 16 bytes. The pointers move into the individual
> filesystems that actually do make use of them.
> 
> In order to find the fscrypt and fsverity data pointers offsets from the
> embedded struct inode in the filesystem's private inode data are
> stored in struct inode_operations. This means we get fast access to the
> data pointers without having to rely on indirect calls.
> 
> Bugs & Issues
> =============
> 
> * For fscrypt specifically the biggest issue is
>   fscrypt_prepare_new_inode() is called in filesystem's inode allocation
>   functions before inode->i_op is set. That means the offset isn't
>   available at the time when we would need it. To fix this we can set
>   dummy encrypted inode operations for the respective filesystem with an
>   initialized offset.
> 
> * For both fscrypt & fsverity the biggest issue is that every codepath
>   that currently calls make_bad_inode() after having initialized fscrypt
>   or fsverity data will override inode->i_op with bad_inode_ops. At
>   which point we're back to the previous problem: The offset isn't
>   available anymore. So when inode->i_sb->s_op->evict_inode() is called
>   fscrypt_put_encryption_info() doesn't have the offset available
>   anymore and would corrupt the hell out of everything and also leak
>   memory.
> 
>   Obviously we could use a flag to detect a bad inodes instead of i_op
>   and let the filesystem assign it's own bad inode operations including
>   the correct offset. Is it worth it?
> 
>   The other way I see we can fix this if we require fixed offsets in the
>   filesystems inode so fscrypt and fsverity always now what offset to
>   calculate. We could use two consecutive pointers at the beginning of
>   the filesystem's inode. Does that always work and is it worth it?

Another, way less idiotic but way more obvious solution is to move the
offsets to struct super_operations. That will mean one additional
pointer deref but it will have the big advantage that the patch will
become really really simple. Thoughts? Otherwise I'd implement that.

