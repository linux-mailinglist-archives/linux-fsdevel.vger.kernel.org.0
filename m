Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FD3C5E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhGLOZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 10:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhGLOZ0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:25:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E488F61026;
        Mon, 12 Jul 2021 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626099758;
        bh=WDLpyiYZPuIbdT5FYXxPE9ngp9ZuV7QqvfJGcKZInfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2GjlAH5IhOzU46VW3MwayvjOOvLw4XRb/YrkXH76igFXtP8m0J5tmSBolcv/S/1Z
         /sZRa81q5laowrrpH0xFMJs8XEG41veidnE/h1s5aexPrsU6s62mqMkLXkywnAckAP
         gjZ1DhjT99eYd67ux3PSctuHwBp6LTR46tYwqbig80aQh7FAiNruD0Eji/xlXEm/L1
         CuDK2rxotI872jeawbL99QoeCX/e8hxgcfRPFVfqsOcst8nVgH+3yR1oSiVPI9Fzjt
         IsO9cP2GkJuq6CokDL+IzH8USF5l8u6X2L543BRWEVI1Ng2ccvYGyihcf6jZnbEBKN
         VL6aXosGVdmiw==
Date:   Mon, 12 Jul 2021 09:22:35 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 02/24] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
Message-ID: <YOxQKyZtWgFZ85YK@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-3-jlayton@kernel.org>
 <YOstFfnzitZrAlLZ@quark.localdomain>
 <6b701c8dfc9e16964718f2b4c1e52fda954ed26b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b701c8dfc9e16964718f2b4c1e52fda954ed26b.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 07:55:37AM -0400, Jeff Layton wrote:
> On Sun, 2021-07-11 at 12:40 -0500, Eric Biggers wrote:
> > Some nits about comments:
> > 
> > On Fri, Jun 25, 2021 at 09:58:12AM -0400, Jeff Layton wrote:
> > > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > > index 6ca7d16593ff..32b1f50433ba 100644
> > > --- a/fs/crypto/fname.c
> > > +++ b/fs/crypto/fname.c
> > > @@ -178,10 +178,8 @@ static int fname_decrypt(const struct inode *inode,
> > >  static const char lookup_table[65] =
> > >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> > >  
> > > -#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> > > -
> > >  /**
> > > - * base64_encode() - base64-encode some bytes
> > > + * fscrypt_base64_encode() - base64-encode some bytes
> > >   * @src: the bytes to encode
> > >   * @len: number of bytes to encode
> > >   * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> > >   *
> > >   * Encodes the input string using characters from the set [A-Za-z0-9+,].
> > >   * The encoded string is roughly 4/3 times the size of the input string.
> > >   *
> > >   * Return: length of the encoded string
> > >   */
> > > -static int base64_encode(const u8 *src, int len, char *dst)
> > > +int fscrypt_base64_encode(const u8 *src, int len, char *dst)
> > 
> > As this function will be used more widely, this comment should be fixed to be
> > more precise.  "Roughly 4/3" isn't precise; it's actually exactly
> > FSCRYPT_BASE64_CHARS(len), right?  The following would be better:
> > 
> >  * Encode the input bytes using characters from the set [A-Za-z0-9+,].
> >  *
> >  * Return: length of the encoded string.  This will be equal to
> >  *         FSCRYPT_BASE64_CHARS(len).
> > 
> 
> I'm not certain, but I thought that FSCRYPT_BASE64_CHARS gave you a
> worst-case estimate of the inflation. This returns the actual length of
> the resulting encoded string, which may be less than
> FSCRYPT_BASE64_CHARS(len).
> 

As far as I can tell, it's the exact amount.

- Eric
