Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B889C3C5BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhGLL62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 07:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhGLL61 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:58:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D359F610E6;
        Mon, 12 Jul 2021 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626090939;
        bh=agbXnkI+d1pZleZ1eNq+cwaIbUmy13yPymXoqaO/PXc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Am9xiyRURyzgvn5W9WwkMZoaPwFb29Qhxa7mPCu9OWKimRdSFBVs2jc5ovBYBsV0H
         tN7natS3Ln5yhPQDkstDHOb/SM+7sflTqebeNxRnSf7VhXW8KEJKdQuYiKfulAtTR5
         KnuCNvAh4uoBvloqF+n/9/m8HDliwVGSgr25RlKULVt6yL8MfXIDOvn6+Y9+S0BSPI
         m42R6wkJpBQ/4XYaR/UrFaLVBW84hJbQLFYHVieqJQEqaq7Rt2Mo2OxwKiZrbTwdep
         piCGCjqzk2KJsjn5EU9iD9I6vc3Uten+6s/zmhw5QobxCXTWjhk0ZvLB4ivaIOyQj6
         //cek6y4Hx8pg==
Message-ID: <6b701c8dfc9e16964718f2b4c1e52fda954ed26b.camel@kernel.org>
Subject: Re: [RFC PATCH v7 02/24] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 12 Jul 2021 07:55:37 -0400
In-Reply-To: <YOstFfnzitZrAlLZ@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-3-jlayton@kernel.org>
         <YOstFfnzitZrAlLZ@quark.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-07-11 at 12:40 -0500, Eric Biggers wrote:
> Some nits about comments:
> 
> On Fri, Jun 25, 2021 at 09:58:12AM -0400, Jeff Layton wrote:
> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > index 6ca7d16593ff..32b1f50433ba 100644
> > --- a/fs/crypto/fname.c
> > +++ b/fs/crypto/fname.c
> > @@ -178,10 +178,8 @@ static int fname_decrypt(const struct inode *inode,
> >  static const char lookup_table[65] =
> >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> >  
> > -#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> > -
> >  /**
> > - * base64_encode() - base64-encode some bytes
> > + * fscrypt_base64_encode() - base64-encode some bytes
> >   * @src: the bytes to encode
> >   * @len: number of bytes to encode
> >   * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> >   *
> >   * Encodes the input string using characters from the set [A-Za-z0-9+,].
> >   * The encoded string is roughly 4/3 times the size of the input string.
> >   *
> >   * Return: length of the encoded string
> >   */
> > -static int base64_encode(const u8 *src, int len, char *dst)
> > +int fscrypt_base64_encode(const u8 *src, int len, char *dst)
> 
> As this function will be used more widely, this comment should be fixed to be
> more precise.  "Roughly 4/3" isn't precise; it's actually exactly
> FSCRYPT_BASE64_CHARS(len), right?  The following would be better:
> 
>  * Encode the input bytes using characters from the set [A-Za-z0-9+,].
>  *
>  * Return: length of the encoded string.  This will be equal to
>  *         FSCRYPT_BASE64_CHARS(len).
> 

I'm not certain, but I thought that FSCRYPT_BASE64_CHARS gave you a
worst-case estimate of the inflation. This returns the actual length of
the resulting encoded string, which may be less than
FSCRYPT_BASE64_CHARS(len).

> > +/**
> > + * fscrypt_base64_decode() - base64-decode some bytes
> > + * @src: the bytes to decode
> > + * @len: number of bytes to decode
> > + * @dst: (output) decoded binary data
> 
> It's a bit confusing to talk about decoding "bytes"; it's really a string.
> How about:
> 
>  * fscrypt_base64_decode() - base64-decode a string
>  * @src: the string to decode
>  * @len: length of the source string, in bytes
>  * @dst: (output) decoded binary data
>  *
>  * Decode a string that was previously encoded using fscrypt_base64_encode().
>  * The string doesn't need to be NUL-terminated.
> 
> > + * Return: length of the decoded binary data
> 
> Also the error return values should be documented, e.g.:
> 
>  * Return: length of the decoded binary data, or a negative number if the source
>  *         string isn't a valid base64-encoded string.
> 

That update looks reasonable.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

