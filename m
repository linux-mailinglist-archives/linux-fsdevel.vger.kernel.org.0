Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643B4269A63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIOAXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIOAXU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:23:20 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08053208DB;
        Tue, 15 Sep 2020 00:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600129400;
        bh=/KHIwmAZHBGxN2hme49i1Rm87+EqkDUwuyfb8e1vWO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWArI4HqvLA7GX4fNj4OKkv24BUybW+WanxiqITMNutB9wXxAKiIA3BCFKLYoiVFO
         g/TDJnlXxqq8gVO2Q8v8m5Z8DI5tjqsbmhgcJPyQ8FMKWrcYcfoalAj/F9vqmCNRca
         2XYgWmTch0xjnNJbLHTow9fG2oJj1AoXDSCw20Ls=
Date:   Mon, 14 Sep 2020 17:23:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 05/16] fscrypt: make fscrypt_fname_disk_to_usr
 return whether result is nokey name
Message-ID: <20200915002318.GE899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-6-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:56PM -0400, Jeff Layton wrote:
> Ceph will sometimes need to know whether the resulting name from this
> function is a nokey name, in order to set the dentry flags without
> racy checks on the parent inode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fname.c       | 5 ++++-
>  fs/crypto/hooks.c       | 4 ++--
>  fs/ext4/dir.c           | 3 ++-
>  fs/ext4/namei.c         | 6 ++++--
>  fs/f2fs/dir.c           | 3 ++-
>  fs/ubifs/dir.c          | 4 +++-
>  include/linux/fscrypt.h | 4 ++--
>  7 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 0d41eb4a5493..b97a81ccd838 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -353,6 +353,7 @@ EXPORT_SYMBOL(fscrypt_encode_nokey_name);
>   * @oname: output buffer for the user-presentable filename.  The caller must
>   *	   have allocated enough space for this, e.g. using
>   *	   fscrypt_fname_alloc_buffer().
> + * @is_nokey: set to true if oname is a no-key name
>   *
>   * If the key is available, we'll decrypt the disk name.  Otherwise, we'll
>   * encode it for presentation in fscrypt_nokey_name format.
> @@ -363,7 +364,8 @@ EXPORT_SYMBOL(fscrypt_encode_nokey_name);
>  int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  			      u32 hash, u32 minor_hash,
>  			      const struct fscrypt_str *iname,
> -			      struct fscrypt_str *oname)
> +			      struct fscrypt_str *oname,
> +			      bool *is_nokey)
>  {
>  	const struct qstr qname = FSTR_TO_QSTR(iname);
>  	struct fscrypt_nokey_name nokey_name;
> @@ -411,6 +413,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  		size = FSCRYPT_NOKEY_NAME_MAX;
>  	}
>  	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);
> +	*is_nokey = true;
>  	return 0;
>  }

Can you do:

	if (is_nokey)
		*is_nokey = true;

... so that callers who don't care can just pass NULL?

Also, to make the kerneldoc clearer:

 * @is_nokey: (output) if non-NULL, set to true if the key wasn't available
 *
 * If the key is available, we'll decrypt the disk name.  Otherwise, we'll
 * encode it for presentation in fscrypt_nokey_name format and set
 * *is_nokey=true.  See struct fscrypt_nokey_name for details.
