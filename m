Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C74E5447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiCWOeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCWOe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:34:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599831222;
        Wed, 23 Mar 2022 07:32:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FC2A1F37F;
        Wed, 23 Mar 2022 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648045978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNiwTKRmVGioNI4r3rxOC3Dp0Dgtr6hFyDUErY47Yb0=;
        b=Lod5jB7AbPd8wgpAbueuW4Q7Urgn8vbi39g3qX6KNRBwbPr9PdXRQo62i5e7svmbjlYl3o
        wDBwmUAJNeDJzH90wJT18nRUX39hNPlKUpUIXm7TNbbGtLRAZ7N8vA8rXFRTzpe2gg1MDx
        czOWZ2uPI/H+MZkhPeO4+mLoIcYZFQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648045978;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNiwTKRmVGioNI4r3rxOC3Dp0Dgtr6hFyDUErY47Yb0=;
        b=q35h0+7EjuB6ibw2M6MJxT4eaU8rIUdX+w43HH/nmFLDiEGOsNg3HYP/pHfQz9JUsT4YeT
        mRWRcy2TgUddiuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC62913302;
        Wed, 23 Mar 2022 14:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9wCK5kvO2IATgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 23 Mar 2022 14:32:57 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 39ee974f;
        Wed, 23 Mar 2022 14:33:17 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@google.com>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v11 02/51] fscrypt: export fscrypt_base64url_encode
 and fscrypt_base64url_decode
References: <20220322141316.41325-1-jlayton@kernel.org>
        <20220322141316.41325-3-jlayton@kernel.org>
Date:   Wed, 23 Mar 2022 14:33:17 +0000
In-Reply-To: <20220322141316.41325-3-jlayton@kernel.org> (Jeff Layton's
        message of "Tue, 22 Mar 2022 10:12:27 -0400")
Message-ID: <87zglgoi1e.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

Jeff Layton <jlayton@kernel.org> writes:

> Ceph is going to add fscrypt support, but we still want encrypted
> filenames to be composed of printable characters, so we can maintain
> compatibility with clients that don't support fscrypt.
>
> We could just adopt fscrypt's current nokey name format, but that is
> subject to change in the future, and it also contains dirhash fields
> that we don't need for cephfs. Because of this, we're going to concoct
> our own scheme for encoding encrypted filenames. It's very similar to
> fscrypt's current scheme, but doesn't bother with the dirhash fields.
>
> The ceph encoding scheme will use base64 encoding as well, and we also
> want it to avoid characters that are illegal in filenames. Export the
> fscrypt base64 encoding/decoding routines so we can use them in ceph's
> fscrypt implementation.
>
> Acked-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fname.c       | 8 ++++----
>  include/linux/fscrypt.h | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index a9be4bc74a94..1e4233c95005 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -182,8 +182,6 @@ static int fname_decrypt(const struct inode *inode,
>  static const char base64url_table[65] =3D
>  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
>=20=20
> -#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> -
>  /**
>   * fscrypt_base64url_encode() - base64url-encode some binary data
>   * @src: the binary data to encode
> @@ -198,7 +196,7 @@ static const char base64url_table[65] =3D
>   * Return: the length of the resulting base64url-encoded string in bytes.
>   *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
>   */
> -static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
> +int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)

I know you've ACK'ed this patch already, but I was wondering if you'd be
open to change these encode/decode interfaces so that they could be used
for non-url base64 too.

My motivation is that ceph has this odd limitation where snapshot names
can not start with the '_' character.  And I've an RFC that adds snapshot
names encryption support which, unfortunately, can end up starting with
this char after base64 encoding.

So, my current proposal is to use a different encoding table.  I was
thinking about the IMAP mailboxes naming which uses '+' and ',' instead of
the '-' and '_', but any other charset would be OK (except those that
include '/' of course).  So, instead of adding yet another base64
implementation to the kernel, I was wondering if you'd be OK accepting a
patch to add an optional arg to these encoding/decoding functions to pass
an alternative table.  Or, if you'd prefer, keep the existing interface
but turning these functions into wrappers to more generic functions.

Obviously, Jeff, please feel free to comment too if you have any reserves
regarding this approach.

Cheers,
--=20
Lu=C3=ADs

>  {
>  	u32 ac =3D 0;
>  	int bits =3D 0;
> @@ -217,6 +215,7 @@ static int fscrypt_base64url_encode(const u8 *src, in=
t srclen, char *dst)
>  		*cp++ =3D base64url_table[(ac << (6 - bits)) & 0x3f];
>  	return cp - dst;
>  }
> +EXPORT_SYMBOL_GPL(fscrypt_base64url_encode);
>=20=20
>  /**
>   * fscrypt_base64url_decode() - base64url-decode a string
> @@ -233,7 +232,7 @@ static int fscrypt_base64url_encode(const u8 *src, in=
t srclen, char *dst)
>   * Return: the length of the resulting decoded binary data in bytes,
>   *	   or -1 if the string isn't a valid base64url string.
>   */
> -static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
> +int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
>  {
>  	u32 ac =3D 0;
>  	int bits =3D 0;
> @@ -256,6 +255,7 @@ static int fscrypt_base64url_decode(const char *src, =
int srclen, u8 *dst)
>  		return -1;
>  	return bp - dst;
>  }
> +EXPORT_SYMBOL_GPL(fscrypt_base64url_decode);
>=20=20
>  bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
>  				  u32 orig_len, u32 max_len,
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 91ea9477e9bd..671181d196a8 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -46,6 +46,9 @@ struct fscrypt_name {
>  /* Maximum value for the third parameter of fscrypt_operations.set_conte=
xt(). */
>  #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
>=20=20
> +/* len of resulting string (sans NUL terminator) after base64 encoding n=
bytes */
> +#define FSCRYPT_BASE64URL_CHARS(nbytes)		DIV_ROUND_UP((nbytes) * 4, 3)
> +
>  #ifdef CONFIG_FS_ENCRYPTION
>=20=20
>  /*
> @@ -305,6 +308,8 @@ void fscrypt_free_inode(struct inode *inode);
>  int fscrypt_drop_inode(struct inode *inode);
>=20=20
>  /* fname.c */
> +int fscrypt_base64url_encode(const u8 *src, int len, char *dst);
> +int fscrypt_base64url_decode(const char *src, int len, u8 *dst);
>  int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
>  			   int lookup, struct fscrypt_name *fname);
>=20=20
> --=20
>
> 2.35.1
>

