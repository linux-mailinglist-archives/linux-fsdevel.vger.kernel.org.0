Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E583C5E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhGLOfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 10:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234869AbhGLOfL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:35:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B0E461156;
        Mon, 12 Jul 2021 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626100343;
        bh=kzAMr6x9W8QB1Mb/Dxfqkufi1FLyAx2wvP2lKj/OtbM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uT88ec0RVq7O0WmUsaf/pDnqatVPTufZvRgveNXec+id6893SYFDjvo+5b7jiEawR
         E2a0JhHDG9kIclR1GMVc9CEaBqER8UhqYr/mHBGxdWsSZOkJhXmH71HKatGIQbPT6F
         wx6jRRBvugfuCoVXSZGC40PSpRoOtgDnZcqWIRJGA1QWn9+zk/CuxptioWpNlcN/Xq
         XvH8fItmyrX9JvaDaJMJsEupSXzCu5Uc8s6Y3dIuLztOdaURZ49w8Iu92nXYGObyBV
         SKd75fn/Fdt0APTGPVimythpLa48NEfJX4VxYDw8Ue9k+8AhHkT2LUREPag+Ug5Kc8
         alcsSqRFcFGhA==
Message-ID: <48fd676431f1589e8fc1cbc27c8ec011498de6c5.camel@kernel.org>
Subject: Re: [RFC PATCH v7 02/24] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 12 Jul 2021 10:32:21 -0400
In-Reply-To: <YOxQKyZtWgFZ85YK@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-3-jlayton@kernel.org>
         <YOstFfnzitZrAlLZ@quark.localdomain>
         <6b701c8dfc9e16964718f2b4c1e52fda954ed26b.camel@kernel.org>
         <YOxQKyZtWgFZ85YK@quark.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-07-12 at 09:22 -0500, Eric Biggers wrote:
> On Mon, Jul 12, 2021 at 07:55:37AM -0400, Jeff Layton wrote:
> > On Sun, 2021-07-11 at 12:40 -0500, Eric Biggers wrote:
> > > Some nits about comments:
> > > 
> > > On Fri, Jun 25, 2021 at 09:58:12AM -0400, Jeff Layton wrote:
> > > > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > > > index 6ca7d16593ff..32b1f50433ba 100644
> > > > --- a/fs/crypto/fname.c
> > > > +++ b/fs/crypto/fname.c
> > > > @@ -178,10 +178,8 @@ static int fname_decrypt(const struct inode *inode,
> > > >  static const char lookup_table[65] =
> > > >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> > > >  
> > > > -#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> > > > -
> > > >  /**
> > > > - * base64_encode() - base64-encode some bytes
> > > > + * fscrypt_base64_encode() - base64-encode some bytes
> > > >   * @src: the bytes to encode
> > > >   * @len: number of bytes to encode
> > > >   * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> > > >   *
> > > >   * Encodes the input string using characters from the set [A-Za-z0-9+,].
> > > >   * The encoded string is roughly 4/3 times the size of the input string.
> > > >   *
> > > >   * Return: length of the encoded string
> > > >   */
> > > > -static int base64_encode(const u8 *src, int len, char *dst)
> > > > +int fscrypt_base64_encode(const u8 *src, int len, char *dst)
> > > 
> > > As this function will be used more widely, this comment should be fixed to be
> > > more precise.  "Roughly 4/3" isn't precise; it's actually exactly
> > > FSCRYPT_BASE64_CHARS(len), right?  The following would be better:
> > > 
> > >  * Encode the input bytes using characters from the set [A-Za-z0-9+,].
> > >  *
> > >  * Return: length of the encoded string.  This will be equal to
> > >  *         FSCRYPT_BASE64_CHARS(len).
> > > 
> > 
> > I'm not certain, but I thought that FSCRYPT_BASE64_CHARS gave you a
> > worst-case estimate of the inflation. This returns the actual length of
> > the resulting encoded string, which may be less than
> > FSCRYPT_BASE64_CHARS(len).
> > 
> 
> As far as I can tell, it's the exact amount.

Yeah, now that I went back and re-read the code, I think you're right.
I'll fix the comment.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

