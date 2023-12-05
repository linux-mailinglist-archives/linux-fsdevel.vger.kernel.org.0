Return-Path: <linux-fsdevel+bounces-4830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8E80489A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 05:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E6B1C20D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD6D277
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r02qo91q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056748BE0;
	Tue,  5 Dec 2023 04:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A81FC433C8;
	Tue,  5 Dec 2023 04:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701749689;
	bh=iQazwE8QV7i3bW9dzP/yfDnf3MBG8vyjFJft5anNNPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r02qo91qzswRa1vfOGPCzwWDRfYfsb5tNudZW2S9oO1h5Svti+xBFlCpylS5OdWWz
	 WuaMVwzUrdWx12XUEqJNhlw38h0lfY54vYI/hDn8nZM7JM26h9in2ZZZq53rhbN2LV
	 yo5tU80hdDAncJMzsjNA1SgQ27vKKBlnMH285aXF0sZaQOI08Hstyp3eCueksXvTy0
	 IlBEH4kpOe5OH7N3FVlvEi/XQIX4dCum6PW7Uu3cSqX9cGuAwX3SB/YKJTR4Y5gO1C
	 sbD4k29qDWHW6OeGCA1wV7UbZ474Myc3FUwAtk+7iCc6GFbSgT1Z3byUuamCMaCgqf
	 8y3va/IXjLloQ==
Date: Mon, 4 Dec 2023 20:14:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/46] fscrypt: add a fscrypt_inode_open helper
Message-ID: <20231205041447.GF1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <32beea11211858a998ba2de88d01471c31004f2d.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32beea11211858a998ba2de88d01471c31004f2d.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:00PM -0500, Josef Bacik wrote:
> We have fscrypt_file_open() which is meant to be called on files being
> opened so that their key is loaded when we start reading data from them.
> 
> However for btrfs send we are opening the inode directly without a filp,
> so we need a different helper to make sure we can load the fscrypt
> context for the inode before reading its contents.
> 
> We need a different helper as opposed to simply using
> fscrypt_has_permitted_context() directly because of '-o
> test_dummy_encryption', which allows for encrypted files to be created
> with !IS_ENCRYPTED set on the directory (the root directory in this
> case).  fscrypt_file_open() already does the appropriate check where it
> simply doesn't call fscrypt_has_permitted_context() if the parent
> directory isn't marked with IS_ENCRYPTED in order to facilitate this
> invariant when using '-o test_dummy_encryption'.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/crypto/hooks.c       | 42 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/fscrypt.h |  8 ++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index 52504dd478d3..a391a987c58f 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -49,6 +49,48 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_file_open);
>  
> +/**
> + * fscrypt_inode_open() - prepare to open a possibly-encrypted regular file
> + * @dir: the directory that contains this inode
> + * @inode: the inode being opened
> + *
> + * Currently, an encrypted regular file can only be opened if its encryption key
> + * is available; access to the raw encrypted contents is not supported.
> + * Therefore, we first set up the inode's encryption key (if not already done)
> + * and return an error if it's unavailable.
> + *
> + * We also verify that if the parent directory is encrypted, then the inode
> + * being opened uses the same encryption policy.  This is needed as part of the
> + * enforcement that all files in an encrypted directory tree use the same
> + * encryption policy, as a protection against certain types of offline attacks.
> + * Note that this check is needed even when opening an *unencrypted* file, since
> + * it's forbidden to have an unencrypted file in an encrypted directory.
> + *
> + * File systems should be using fscrypt_file_open in their open callback.  This
> + * is for file systems that may need to open inodes outside of the normal file
> + * open path, btrfs send for example.
> + *
> + * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
> + */
> +int fscrypt_inode_open(struct inode *dir, struct inode *inode)
> +{
> +	int err;
> +
> +	err = fscrypt_require_key(inode);
> +	if (err)
> +		return err;
> +
> +	if (IS_ENCRYPTED(dir) &&
> +	    !fscrypt_has_permitted_context(dir, inode)) {
> +		fscrypt_warn(inode,
> +			     "Inconsistent encryption context (parent directory: %lu)",
> +			     dir->i_ino);
> +		err = -EPERM;
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_inode_open);

The comment and code is heavily copy+pasted from fscrypt_file_open(), which is
not great.  How about naming the new function __fscrypt_file_open(),
implementing fscrypt_file_open() on top of it, and making the comment describe
the differences vs. fscrypt_file_open()?

So fscrypt_file_open() would do:

	struct inode *dir;
	int err;

	dir = dget_parent(file_dentry(filp));

	err = __fscrypt_file_open(dir, filp);

	dput(dir);
	return err;

... and the comment for the new function would be something like:

/**
 * __fscrypt_file_open() - prepare for filesystem-internal access to a
 *			   possibly-encrypted regular file
 * @dir: the inode for the directory via which the file is being accessed
 * @inode: the inode being "opened"
 *
 * This is like fscrypt_file_open(), but instead of taking the 'struct file'
 * being opened it takes the parent directory explicitly.  This is intended for
 * use cases such as "send/receive" which involve the filesystem accessing file
 * contents without setting up a 'struct file'.
 *
 * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
 */
int __fscrypt_file_open(struct inode *dir, struct inode *inode)


Note, we need to be careful when describing "@dir".  It's not simply "the
directory that contains this inode".  An inode can be in multiple directories.

- Eric

