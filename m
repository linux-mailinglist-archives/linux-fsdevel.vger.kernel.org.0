Return-Path: <linux-fsdevel+bounces-12919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD9868902
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 07:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB10B237B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59D41C6A;
	Tue, 27 Feb 2024 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAON0pAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443B256A;
	Tue, 27 Feb 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015776; cv=none; b=RZvLjTOmmXN7l3vp76yBzZcuuqSoI7/h277gHpbLs6xc7rJ6wd3mottmqzdTtHqhLbfqJ+e7uR2cXRPdX64yDe+tRMdXOBA8tQE/vNTLVcHU/wcE+VqJeyYgb1DdnG7ls1qLyw9fctLP0BxCzFFs4OZDuAXbWNO4QDQnt4LaNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015776; c=relaxed/simple;
	bh=BnWI1QlWvLT8QiqmYWbI9nYOFqfqKjduJfF+ni+ECWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqlQCdHjIsgkIGJelIUmEt98ajOScQfyZjc0HBKvXHE0r9lP0A+zM6p+LybYXlH3UyHA1zG/KIjOXdMz+hSLDmG4Xbgcckg/B2JRHIf7aYSKIJ1gLAVo5RC6+ZIstZYPwDiXBNhwmU3SO0rZ+hdbEwzGWYYPpHUNjRHZLmcmMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAON0pAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0E8C433C7;
	Tue, 27 Feb 2024 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709015776;
	bh=BnWI1QlWvLT8QiqmYWbI9nYOFqfqKjduJfF+ni+ECWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAON0pASJNwPRPdlYDWOlNy5thVAd1zfXGGDMD9tvgdhVDaM5MNasI2hsJeAog4tq
	 7CTK3YUoVpDtoSiwjBCcs1j8vsWNtuNltYFB2rpX5BA8lpn/ER+fi+uVYOiaslWRaB
	 XPj3t5FLRAz5a4gWlqFvqfHWQNMawq6j6zD6CqvUGJ5fmaW9ltX7XUqs0garIZvcAE
	 r/1CDWmMln2ZZ5SQzUh1yg3TkgSgQvG07KDx7Dn5Yr5UCvCMi2QH8Z/wIrLCX2XwrE
	 F9TjgMeBF2H5Lxr7j46Wnvh/8W/qUtLTUWQRcH3QLnYc5/msk+7Cw58aZIFQhiiARk
	 tYei7ksoL52xQ==
Date: Mon, 26 Feb 2024 22:36:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v7 00/10] Set casefold/fscrypt dentry operations through
 sb->s_d_op
Message-ID: <20240227063614.GB1126@sol.localdomain>
References: <20240221171412.10710-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221171412.10710-1-krisman@suse.de>

On Wed, Feb 21, 2024 at 12:14:02PM -0500, Gabriel Krisman Bertazi wrote:
> 
> When case-insensitive and fscrypt were adapted to work together, we moved the
> code that sets the dentry operations for case-insensitive dentries(d_hash and
> d_compare) to happen from a helper inside ->lookup.  This is because fscrypt
> wants to set d_revalidate only on some dentries, so it does it only for them in
> d_revalidate.
> 
> But, case-insensitive hooks are actually set on all dentries in the filesystem,
> so the natural place to do it is through s_d_op and let d_alloc handle it [1].
> In addition, doing it inside the ->lookup is a problem for case-insensitive
> dentries that are not created through ->lookup, like those coming
> open-by-fhandle[2], which will not see the required d_ops.
> 
> This patchset therefore reverts to using sb->s_d_op to set the dentry operations
> for case-insensitive filesystems.  In order to set case-insensitive hooks early
> and not require every dentry to have d_revalidate in case-insensitive
> filesystems, it introduces a patch suggested by Al Viro to disable d_revalidate
> on some dentries on the fly.
> 
> It survives fstests encrypt and quick groups without regressions.  Based on
> v6.7-rc1.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
> [2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/
> 
> Gabriel Krisman Bertazi (10):
>   ovl: Always reject mounting over case-insensitive directories
>   fscrypt: Factor out a helper to configure the lookup dentry
>   fscrypt: Drop d_revalidate for valid dentries during lookup
>   fscrypt: Drop d_revalidate once the key is added
>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>   libfs: Add helper to choose dentry operations at mount-time
>   ext4: Configure dentry operations at dentry-creation time
>   f2fs: Configure dentry operations at dentry-creation time
>   ubifs: Configure dentry operations at dentry-creation time
>   libfs: Drop generic_set_encrypted_ci_d_ops
> 
>  fs/crypto/hooks.c       | 15 ++++------
>  fs/ext4/namei.c         |  1 -
>  fs/ext4/super.c         |  1 +
>  fs/f2fs/namei.c         |  1 -
>  fs/f2fs/super.c         |  1 +
>  fs/libfs.c              | 62 +++++++++++---------------------------
>  fs/overlayfs/params.c   | 14 +++++++--
>  fs/ubifs/dir.c          |  1 -
>  fs/ubifs/super.c        |  1 +
>  include/linux/fs.h      | 11 ++++++-
>  include/linux/fscrypt.h | 66 ++++++++++++++++++++++++++++++++++++-----
>  11 files changed, 105 insertions(+), 69 deletions(-)
> 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

