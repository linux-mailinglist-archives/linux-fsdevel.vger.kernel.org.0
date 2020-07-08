Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49CE217DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgGHEMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgGHEMd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:12:33 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19A6206BE;
        Wed,  8 Jul 2020 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594181552;
        bh=vVo5pFG1bIjLvY9lAeAGfvgg5b4sWEYOCkrdKFS1mXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSWV4k3cUI0VfYbcLiHz5o0XnCW8TiB2Wg/1SLaul78EN8pmhvRHpRmgVoH6YnT7D
         N5iKpo3Z5QvG752hE8YITH/HzmSP2BpWdJ/uS94cOWb+jOSs89Ub/i0bwdiDeUY89N
         cwpUj4+ARwqK6UR8iy1V0w2HiqBTz5/F/K09BnAc=
Date:   Tue, 7 Jul 2020 21:12:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v11 2/4] fs: Add standard casefolding support
Message-ID: <20200708041230.GL839@sol.localdomain>
References: <20200708030552.3829094-1-drosen@google.com>
 <20200708030552.3829094-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708030552.3829094-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 08:05:50PM -0700, Daniel Rosenberg wrote:
> +/**
> + * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
> + * @dentry:	dentry whose name we are checking against
> + * @len:	len of name of dentry
> + * @str:	str pointer to name of dentry
> + * @name:	Name to compare against
> + *
> + * Return: 0 if names match, 1 if mismatch, or -ERRNO
> + */
> +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +			  const char *str, const struct qstr *name)
> +{
> +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> +	const struct inode *inode = READ_ONCE(parent->d_inode);

How about calling the 'inode' variable 'dir' instead?

That would help avoid confusion about what is the directory and what is a file
in the directory.

Likewise in generic_ci_d_hash().

> +/**
> + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> + * @dentry:	dentry whose name we are hashing

This comment for @dentry needs to be updated.

It's the parent dentry, not the dentry whose name we are hashing.

> + * @str:	qstr of name whose hash we should fill in
> + *
> + * Return: 0 if hash was successful, or -ERRNO

As I mentioned on v9, this can also return 0 if the hashing was not done because
it wants to fallback to the standard hashing.  Can you please fix the comment?

> +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> +{
> +	const struct inode *inode = READ_ONCE(dentry->d_inode);
> +	struct super_block *sb = dentry->d_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	int ret = 0;
> +
> +	if (!inode || !needs_casefold(inode))
> +		return 0;
> +
> +	ret = utf8_casefold_hash(um, dentry, str);
> +	if (ret < 0)
> +		goto err;
> +
> +	return 0;
> +err:
> +	if (sb_has_strict_encoding(sb))
> +		ret = -EINVAL;
> +	else
> +		ret = 0;
> +	return ret;
> +}

On v9, Gabriel suggested simplifying this to:

	ret = utf8_casefold_hash(um, dentry, str);
	if (ret < 0 && sb_has_enc_strict_mode(sb))
		return -EINVAL;
	return 0;

Any reason not to do that?

- Eric
