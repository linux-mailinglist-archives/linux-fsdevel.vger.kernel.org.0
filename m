Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB22B6D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgKQSbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:31:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgKQSbU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:31:20 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D812222E;
        Tue, 17 Nov 2020 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605637879;
        bh=ao2XoyFvOst/o/NixL3wR1q1+HrjIW+xRos2auX+cis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAff5vQTLS6o1LdCvxQyE8canT3iWN4lhOjqOGcJvd1BEB21bCVXFSHoF5miY2Gel
         79iEFHbzmxHaiCXtfzsJPMSKIhcmI/q+eODrQqe3gNsV6Hx+n0ZoUYbyeZyH63OkED
         kRJNByTFXR1CQLcQyIyq+lVu8j/Kdfzeo2frG81U=
Date:   Tue, 17 Nov 2020 10:31:17 -0800
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
Subject: Re: [PATCH v2 2/3] fscrypt: Have filesystems handle their d_ops
Message-ID: <X7QW9aqdF9ivHKBe@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117040315.28548-3-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:03:14AM +0000, Daniel Rosenberg wrote:
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index a8f7a43f031b..df2c66ca370e 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -741,8 +741,9 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>   * directory's encryption key is available, then the lookup is assumed to be by
>   * plaintext name; otherwise, it is assumed to be by no-key name.
>   *
> - * This also installs a custom ->d_revalidate() method which will invalidate the
> - * dentry if it was created without the key and the key is later added.
> + * After calling this function, a filesystem should ensure that its dentry
> + * operations contain fscrypt_d_revalidate if DCACHE_ENCRYPTED_NAME was set,
> + * so that the dentry can be invalidated if the key is later added.
>   *
>   * Return: 0 on success; -ENOENT if the directory's key is unavailable but the
>   * filename isn't a valid no-key name, so a negative dentry should be created;

This should say DCACHE_NOKEY_NAME, not DCACHE_ENCRYPTED_NAME.

But more importantly, the explanation here isn't very clear.  How about the
following instead:

 * This will set DCACHE_NOKEY_NAME on the dentry if the lookup is by no-key
 * name.  In this case the filesystem must assign the dentry a dentry_operations
 * which contains fscrypt_d_revalidate (or contains a d_revalidate method that
 * calls fscrypt_d_revalidate), so that the dentry will be invalidated if the
 * directory's encryption key is later added.
