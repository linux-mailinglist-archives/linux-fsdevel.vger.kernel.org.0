Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A024327516D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIWGZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 02:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgIWGY7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:24:59 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425FC21D43;
        Wed, 23 Sep 2020 06:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600842298;
        bh=EH8hBpeiETHC+h9j5rcOQFLvuMpOSGcVeSqcrnJIr+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9hZFORZJfS43AD9qs/eouYS9H2lmfwPF3ydoBftcuORWrWFA+Oosf8DKY1mk3Zm3
         cIZCITTnRgEk6JhC/F6wZsXxGJPNPdgYJYJhHDaphw687jIKp1UHYaNhlwigfbmU7Y
         swkdL+l/hvzPy8OCNZxj+GedL3eT8qcF1ZOoGSNU=
Date:   Tue, 22 Sep 2020 23:24:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 5/5] f2fs: Handle casefolding with Encryption
Message-ID: <20200923062456.GF9538@sol.localdomain>
References: <20200923010151.69506-1-drosen@google.com>
 <20200923010151.69506-6-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923010151.69506-6-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:01:51AM +0000, Daniel Rosenberg wrote:
> Expand f2fs's casefolding support to include encrypted directories.  To
> index casefolded+encrypted directories, we use the SipHash of the
> casefolded name, keyed by a key derived from the directory's fscrypt
> master key.  This ensures that the dirhash doesn't leak information
> about the plaintext filenames.
> 
> Encryption keys are unavailable during roll-forward recovery, so we
> can't compute the dirhash when recovering a new dentry in an encrypted +
> casefolded directory.  To avoid having to force a checkpoint when a new
> file is fsync'ed, store the dirhash on-disk appended to i_name.
> 
> This patch incorporates work by Eric Biggers <ebiggers@google.com>
> and Jaegeuk Kim <jaegeuk@kernel.org>.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---

Generally looks good.  If it's needed, you can add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

(Though, some may claim I can't give Reviewed-by since this patch already has my
Co-developed-by.)

One comment below, though:

> @@ -218,9 +219,28 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
>  {
>  	const struct super_block *sb = dir->i_sb;
>  	const struct unicode_map *um = sb->s_encoding;
> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
>  	struct qstr entry = QSTR_INIT(de_name, de_name_len);
>  	int res;
>  
> +	if (IS_ENCRYPTED(dir)) {
> +		const struct fscrypt_str encrypted_name =
> +			FSTR_INIT((u8 *)de_name, de_name_len);
> +
> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
> +			return false;
> +
> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		if (!decrypted_name.name)
> +			return false;
> +		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
> +						&decrypted_name);
> +		if (res < 0)
> +			goto out;

We probably should be passing up errors from here to f2fs_match_name(), then to
f2fs_find_target_dentry(), then to f2fs_find_in_inline_dir() or find_in_block().

Ignoring the filename may be okay if fscrypt_fname_disk_to_usr() returns
-EUCLEAN, indicating that it's invalid.  However, if the error is -ENOMEM,
either from the kmalloc() or from fscrypt_fname_disk_to_usr(), then the caller
should receive an error rather than the filename being ignored.

- Eric
