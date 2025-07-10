Return-Path: <linux-fsdevel+bounces-54475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68748B0009D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6869F1892660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D732405E1;
	Thu, 10 Jul 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkjviHby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8718DF8D;
	Thu, 10 Jul 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147259; cv=none; b=rbIHGkq6KQpw74i2BgpsUpqjorJesQkbxC5Vc1Re/EyX43zWdSTjxKQdDLpEgnByKDASi+qkf9HwuH67/HudXZ8rKb6g6goyKvhC2jvKtKLvKEzJX7wbcVPisV/ROQhMbbYHfeAA0CNa36EUmGHHhr+YA4GOB/6n1QuzGAv+Wcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147259; c=relaxed/simple;
	bh=1ZXonOqJ78xdsDZGVmG2kZqrXIiiC2fiMzdbOnUF2uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM3bBPYOMF+l5ZcdB79ZnsdMo0wV6XV0iv2oKoFzfS94NWNCNxU7LjNIrxWRZ92sYzYfI+NSvV6ZKkaU6liHWddvqjz0FIbm8vR4oqCgJKUdL7aw64Rv4yrGdSZDpRjFiuzD0zey9YvhhrKS35+Eyzac4MYxYJRtnzT7EQHxdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkjviHby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F6C4CEE3;
	Thu, 10 Jul 2025 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752147258;
	bh=1ZXonOqJ78xdsDZGVmG2kZqrXIiiC2fiMzdbOnUF2uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkjviHby9wfKTNMSK2qRLWu8kgKdbc5PivPhEXlpeEEgCPwGx/KwkDNOIkIvmc0F5
	 9KAji7iveotko5CQCXoldLKtGBsr4hvJ1OajuT57EGZ6JnpCghzDKAr/ucHecSXpdW
	 TPbHquhR3EKySyy28mBhUMzEAtkkU8o5u4naTwUHbAwiJPlxKFsa3FmVV5m+LsmkQS
	 QBbccSYav9CqcZlR3mvF6gNPRu91aVp7J8bUjMvDiWBZCD7UY2PnhBtC/jl4KlQhSw
	 lFccXVW5zAO8xYKTPw/bQ8mjOuCGUQZDMpSKtp0mw5+cSWBRrYV8aBQheuYbJiQ4L5
	 sIlYnvh5hFPXA==
Date: Thu, 10 Jul 2025 13:34:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/1] fs: Fix use of incorrect flags with splice() on
 pipe from/to memfd
Message-ID: <20250710-geburt-aufbegehren-07813aabf939@brauner>
References: <20250708154352.3913726-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708154352.3913726-1-japo@linux.ibm.com>

On Tue, Jul 08, 2025 at 05:43:52PM +0200, Jan Polensky wrote:
> Fix use of incorrect flags when using splice() with pipe ends and
> memfd secret. Ensure that pipe and memfd file descriptors are properly
> recognized and handled to prevent unintended EACCES errors in scenarios
> where EBADF or EINVAL are expected.
> 
> This resolves failures in LTP's splice07 test case:
> 
>     ./ltp-bin/testcases/bin/splice07
>     [skip]
>     splice07.c:54: TFAIL: splice() on pipe read end -> memfd secret expected EBADF, EINVAL: EACCES (13)
>     [skip]
>     splice07.c:54: TFAIL: splice() on memfd secret -> pipe write end expected EBADF, EINVAL: EACCES (13)
>     [skip]
> 
> Fixes: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  fs/anon_inodes.c   | 11 +++++++----
>  include/linux/fs.h |  2 +-
>  mm/secretmem.c     |  2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 1d847a939f29..f4eade76273b 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -104,6 +104,7 @@ static struct file_system_type anon_inode_fs_type = {
>   * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
>   * @context_inode:
>   *		[in]	Optional parent inode for security inheritance
> + * @secmem	[in]	Indicates wheather the inode should be threaded as secretmem
>   *
>   * The function ensures proper security initialization through the LSM hook
>   * security_inode_init_security_anon().
> @@ -111,7 +112,7 @@ static struct file_system_type anon_inode_fs_type = {
>   * Return:	Pointer to new inode on success, ERR_PTR on failure.
>   */
>  struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
> -					   const struct inode *context_inode)
> +					   const struct inode *context_inode, bool secmem)
>  {
>  	struct inode *inode;
>  	int error;
> @@ -119,8 +120,10 @@ struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *n
>  	inode = alloc_anon_inode(sb);
>  	if (IS_ERR(inode))
>  		return inode;
> -	inode->i_flags &= ~S_PRIVATE;
> -	inode->i_op = &anon_inode_operations;
> +	if (!secmem) {
> +		inode->i_flags &= ~S_PRIVATE;
> +		inode->i_op = &anon_inode_operations;
> +	}

That hides secret memory inodes from LSMs which is the exact opposite of
what the original commit was there to fix. I'm pretty sure that the
EACCES comes from the LSM layer because the relevant refpolicy or
however that works hasn't been updated to allow secret memory files to
use splice().

This is a chicken-and-egg problem withy anything that strips S_PRIVATE
from things that were previously S_PRIVATE.

