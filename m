Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF28D217C93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGHB12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 21:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgGHB11 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:27:27 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B77020708;
        Wed,  8 Jul 2020 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594171647;
        bh=/7pCaqefr9jo0aoJVKw/0wOb++ZXKm19cVeKnE9mCvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHRW7YN0Nlb2+aagrXIdgt1BRs2O/ElEgTA8SeDY58ttcpFjV2WMguBka5e0D14/6
         eII1Utr6Zyf7C+j8nqJKF6oIyPa7Lvr7IX+95hdHWJfLY6SYii6lxG8/9KTCfZj1j0
         lMNMPiLdrNgHwelooIlKFukdniOyCGAXm4jCeDcE=
Date:   Tue, 7 Jul 2020 18:27:25 -0700
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
Subject: Re: [PATCH v10 2/4] fs: Add standard casefolding support
Message-ID: <20200708012725.GE839@sol.localdomain>
References: <20200707113123.3429337-1-drosen@google.com>
 <20200707113123.3429337-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113123.3429337-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:31:21AM -0700, Daniel Rosenberg wrote:
> +/*
> + * Determine if the name of a dentry should be casefolded. It does not make
> + * sense to casefold the no-key token of an encrypted filename.
> + *
> + * Return: if names will need casefolding
> + */
> +static bool needs_casefold(const struct inode *dir, const struct dentry *dentry)
> +{
> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
> +			!(dentry->d_flags & DCACHE_ENCRYPTED_NAME);
> +}
> +
[...]
> +/**
> + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> + * @dentry:	dentry whose name we are hashing
> + * @str:	qstr of name whose hash we should fill in
> + *
> + * Return: 0 if hash was successful, or -ERRNO
> + */
> +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> +{
> +	const struct inode *inode = READ_ONCE(dentry->d_inode);
> +	struct super_block *sb = dentry->d_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	int ret = 0;
> +
> +	if (!inode || !needs_casefold(inode, dentry))
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
> +EXPORT_SYMBOL(generic_ci_d_hash);

I thought this was discussed before, but the 'dentry' passed to ->d_hash() is
the parent dentry, not the one being hashed.

Therefore checking DCACHE_ENCRYPTED_NAME on 'dentry' is wrong here.  Instead we
need to use !fscrypt_has_encryption_key() here.  (IOW, while checking
DCACHE_ENCRYPTED_NAME is better *when possible*, it's not possible here.)

Note that the whole point of ->d_hash() is to hash the filename so that the VFS
can find the dentry.  If the VFS already had the dentry, there would be no need
for ->d_hash().

Also, did you consider my suggestion to not handle encrypt+casefold in this
patch?  I'd like to get this series in as a refactoring for 5.9.  The encryption
handling (which is new) might better belong in a later patch series.

- Eric
