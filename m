Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95C4E680A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352296AbiCXRr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiCXRr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCBAB246A;
        Thu, 24 Mar 2022 10:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A6D619EC;
        Thu, 24 Mar 2022 17:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E33DC340EC;
        Thu, 24 Mar 2022 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648143983;
        bh=OcjId5T49OJaEhbKeAWDg/6fz9gw1xv3vjc13O1bZ4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvXXaceKIAoBBrRK+diIA8BIMwyrryXqJrDI0HuOk+l9iDm6ynsThowM61FoxZfgZ
         6uJ+hfnH35j5RoIm+CckaqMtHudY+GrKSVEE23K2W92lKX+yUbg3tyMCWMEOwhg07K
         wu2aDxcdkNeadTnuLCXa2M4IKMSmZqCdb1rkCYXs4AEPRTxg4w57Sofn+DvthTNhWg
         +lT8IQwUXLTkZY82u6Bp83B3AS+REY3iJivS7N4fGaa+jLoZvcOhbsUwnsaZ6KlpyW
         6yLC76FPrZj6XyEEjkwR9LPsK4a/tHsCUJMGs/CWH1DRFXM/6eoM5fdZhVMJIF9Bss
         vtFr8DpRlbAbg==
Date:   Thu, 24 Mar 2022 17:46:21 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v11 02/51] fscrypt: export fscrypt_base64url_encode
 and fscrypt_base64url_decode
Message-ID: <YjyubQgfbQbUn4Ct@gmail.com>
References: <20220322141316.41325-1-jlayton@kernel.org>
 <20220322141316.41325-3-jlayton@kernel.org>
 <87zglgoi1e.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zglgoi1e.fsf@brahms.olymp>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:33:17PM +0000, Luís Henriques wrote:
> Hi Eric,
> 
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > Ceph is going to add fscrypt support, but we still want encrypted
> > filenames to be composed of printable characters, so we can maintain
> > compatibility with clients that don't support fscrypt.
> >
> > We could just adopt fscrypt's current nokey name format, but that is
> > subject to change in the future, and it also contains dirhash fields
> > that we don't need for cephfs. Because of this, we're going to concoct
> > our own scheme for encoding encrypted filenames. It's very similar to
> > fscrypt's current scheme, but doesn't bother with the dirhash fields.
> >
> > The ceph encoding scheme will use base64 encoding as well, and we also
> > want it to avoid characters that are illegal in filenames. Export the
> > fscrypt base64 encoding/decoding routines so we can use them in ceph's
> > fscrypt implementation.
> >
> > Acked-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/crypto/fname.c       | 8 ++++----
> >  include/linux/fscrypt.h | 5 +++++
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > index a9be4bc74a94..1e4233c95005 100644
> > --- a/fs/crypto/fname.c
> > +++ b/fs/crypto/fname.c
> > @@ -182,8 +182,6 @@ static int fname_decrypt(const struct inode *inode,
> >  static const char base64url_table[65] =
> >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
> >  
> > -#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> > -
> >  /**
> >   * fscrypt_base64url_encode() - base64url-encode some binary data
> >   * @src: the binary data to encode
> > @@ -198,7 +196,7 @@ static const char base64url_table[65] =
> >   * Return: the length of the resulting base64url-encoded string in bytes.
> >   *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
> >   */
> > -static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
> > +int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
> 
> I know you've ACK'ed this patch already, but I was wondering if you'd be
> open to change these encode/decode interfaces so that they could be used
> for non-url base64 too.
> 
> My motivation is that ceph has this odd limitation where snapshot names
> can not start with the '_' character.  And I've an RFC that adds snapshot
> names encryption support which, unfortunately, can end up starting with
> this char after base64 encoding.
> 
> So, my current proposal is to use a different encoding table.  I was
> thinking about the IMAP mailboxes naming which uses '+' and ',' instead of
> the '-' and '_', but any other charset would be OK (except those that
> include '/' of course).  So, instead of adding yet another base64
> implementation to the kernel, I was wondering if you'd be OK accepting a
> patch to add an optional arg to these encoding/decoding functions to pass
> an alternative table.  Or, if you'd prefer, keep the existing interface
> but turning these functions into wrappers to more generic functions.
> 
> Obviously, Jeff, please feel free to comment too if you have any reserves
> regarding this approach.
> 
> Cheers,
> -- 
> Luís
> 

Base64 encoding/decoding is trivial enough that I think you should just add your
own functions to fs/ceph/ for now if you need yet another Base64 variant.  If we
were to add general functions that allow "building your own" Base64 variant, I
think they'd belong in lib/, not fs/crypto/.  (I objected to lib/ in the first
version of Jeff's patchset because that patchset proposed adding just the old,
idiosyncratic fscrypt Base64 variant to lib/ and just calling it "base64", which
was misleading.  But, if there were to be properly documented functions to
"build your own" Base64 variant, allowing control over both the character set
and whether padding is done, lib/ would be the place...)

- Eric
