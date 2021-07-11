Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44533C3E6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGKRn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhGKRn1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:43:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D42C61151;
        Sun, 11 Jul 2021 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626025240;
        bh=NBQt4/AAMQwuEgZTeJmoGVfPbOmrc43fMa2uIXWVWDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLsrOOvLAlsTDP7BKuhpeSU6DVdOdrngiUS0DRrc6unP7AR1Lx/WsZ80tRPiiA3ey
         G3Ck62wU1CARtg7r6gmMPyEufFPGlc8IdOJIKUAKYyjKcz4KGB0q6TmhOKgzzr8wo5
         we9U4t0tClhS1fRxSD+0DTFbz8UqW1hpamkVlcdxecjOy/iIdX4VtWyxdoNT/yvZMJ
         NOn3LOpA/7qAvjws3G3jb6/wW4dxvVM0dm+eWIe/PvNh/s+vbYUvSFonvKfpK2ux6z
         uQVbC24Xoa1nVQIXclIKUPmnZlqnEhGEfNmbtmpKazEezXwuoE+3C5zf259YU7konW
         eqO+QZ7lACj4A==
Date:   Sun, 11 Jul 2021 12:40:37 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 02/24] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
Message-ID: <YOstFfnzitZrAlLZ@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625135834.12934-3-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some nits about comments:

On Fri, Jun 25, 2021 at 09:58:12AM -0400, Jeff Layton wrote:
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 6ca7d16593ff..32b1f50433ba 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -178,10 +178,8 @@ static int fname_decrypt(const struct inode *inode,
>  static const char lookup_table[65] =
>  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
>  
> -#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> -
>  /**
> - * base64_encode() - base64-encode some bytes
> + * fscrypt_base64_encode() - base64-encode some bytes
>   * @src: the bytes to encode
>   * @len: number of bytes to encode
>   * @dst: (output) the base64-encoded string.  Not NUL-terminated.
>   *
>   * Encodes the input string using characters from the set [A-Za-z0-9+,].
>   * The encoded string is roughly 4/3 times the size of the input string.
>   *
>   * Return: length of the encoded string
>   */
> -static int base64_encode(const u8 *src, int len, char *dst)
> +int fscrypt_base64_encode(const u8 *src, int len, char *dst)

As this function will be used more widely, this comment should be fixed to be
more precise.  "Roughly 4/3" isn't precise; it's actually exactly
FSCRYPT_BASE64_CHARS(len), right?  The following would be better:

 * Encode the input bytes using characters from the set [A-Za-z0-9+,].
 *
 * Return: length of the encoded string.  This will be equal to
 *         FSCRYPT_BASE64_CHARS(len).

> +/**
> + * fscrypt_base64_decode() - base64-decode some bytes
> + * @src: the bytes to decode
> + * @len: number of bytes to decode
> + * @dst: (output) decoded binary data

It's a bit confusing to talk about decoding "bytes"; it's really a string.
How about:

 * fscrypt_base64_decode() - base64-decode a string
 * @src: the string to decode
 * @len: length of the source string, in bytes
 * @dst: (output) decoded binary data
 *
 * Decode a string that was previously encoded using fscrypt_base64_encode().
 * The string doesn't need to be NUL-terminated.

> + * Return: length of the decoded binary data

Also the error return values should be documented, e.g.:

 * Return: length of the decoded binary data, or a negative number if the source
 *         string isn't a valid base64-encoded string.

- Eric
