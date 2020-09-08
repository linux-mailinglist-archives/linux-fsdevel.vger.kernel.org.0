Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9026091B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 05:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgIHDwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 23:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHDwf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:52:35 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EABF21532;
        Tue,  8 Sep 2020 03:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599537155;
        bh=fN8AhtI3aQIvbSB8LoU345e31LixDtJNb/l5e5uby40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSMBACaSU8jEcSemij/IEHWXt1ugiuCfCQKdsQZQWPXa6fFx5a8iIVlCF1c2OXT0e
         doJweme0kQr9N7ZpQkh/XM2QWkz3fgfyDFBjgUV28Tc8Qjj+LmnU5Li2iNs6MTF0NZ
         74VBgz/4j6I0v3obOiDJi8O6pbcLst+UID3YJDgE=
Date:   Mon, 7 Sep 2020 20:52:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/18] fscrypt: don't balk when inode is already
 marked encrypted
Message-ID: <20200908035233.GF68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-6-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:24PM -0400, Jeff Layton wrote:
> Cephfs (currently) sets this flag early and only fetches the context
> later. Eventually we may not need this, but for now it prevents this
> warning from popping.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/keysetup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index ad64525ec680..3b4ec16fc528 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -567,7 +567,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
>  		const union fscrypt_context *dummy_ctx =
>  			fscrypt_get_dummy_context(inode->i_sb);
>  
> -		if (IS_ENCRYPTED(inode) || !dummy_ctx) {
> +		if (!dummy_ctx) {
>  			fscrypt_warn(inode,
>  				     "Error %d getting encryption context",
>  				     res);

This makes errors reading the encryption xattr of an encrypted inode be ignored
when the filesystem is mounted with test_dummy_encryption.  That's undesirable.

Isn't this change actually no longer needed, now that new inodes will use
fscrypt_prepare_new_inode() instead of fscrypt_get_encryption_info()?

- Eric
