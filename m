Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAEB260922
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 05:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgIHDzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 23:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHDzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:55:24 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CD721532;
        Tue,  8 Sep 2020 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599537324;
        bh=3j30SNNaqdlmUFdDgAnYF+7+PSeA7/LqgQAhChlSAaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROz6m5uOpzlT+jJgNNGzVpHLZ5dCfPbCaF1g/x0xj+2L5SzeqBk1NIENPEeak34ck
         pfa2gFkcZgCgvcCqBNSJxmDfhiYcH2leHOltjG2jdywNkoV/nfN7mdxtcIXNWZO88g
         Zsi+ofSxfU3j9u2HzB6jQgNtZ6sucCUTCETK84Wg=
Date:   Mon, 7 Sep 2020 20:55:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/18] fscrypt: move nokey_name conversion to
 separate function and export it
Message-ID: <20200908035522.GG68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-7-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:25PM -0400, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fname.c       | 71 +++++++++++++++++++++++------------------
>  include/linux/fscrypt.h |  3 ++
>  2 files changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 9440a44e24ac..09f09def87fc 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -300,6 +300,45 @@ void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
>  }
>  EXPORT_SYMBOL(fscrypt_fname_free_buffer);
>  
> +void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
> +			     const struct fscrypt_str *iname,
> +			     struct fscrypt_str *oname)
> +{
> +	struct fscrypt_nokey_name nokey_name;
> +	u32 size; /* size of the unencoded no-key name */
> +
> +	/*
> +	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
> +	 * between fields and that its encoded size never exceeds NAME_MAX.
> +	 */
> +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
> +		     offsetof(struct fscrypt_nokey_name, bytes));
> +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
> +		     offsetof(struct fscrypt_nokey_name, sha256));
> +	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
> +
> +	if (hash) {
> +		nokey_name.dirhash[0] = hash;
> +		nokey_name.dirhash[1] = minor_hash;
> +	} else {
> +		nokey_name.dirhash[0] = 0;
> +		nokey_name.dirhash[1] = 0;
> +	}
> +	if (iname->len <= sizeof(nokey_name.bytes)) {
> +		memcpy(nokey_name.bytes, iname->name, iname->len);
> +		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
> +	} else {
> +		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
> +		/* Compute strong hash of remaining part of name. */
> +		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
> +				  iname->len - sizeof(nokey_name.bytes),
> +				  nokey_name.sha256);
> +		size = FSCRYPT_NOKEY_NAME_MAX;
> +	}
> +	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
> +}
> +EXPORT_SYMBOL(fscrypt_encode_nokey_name);

Why does this need to be exported?

There's no user of this function introduced in this patchset.

- Eric
