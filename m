Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ACB2615F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgIHQ6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731848AbgIHQUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FDB22224;
        Tue,  8 Sep 2020 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599569406;
        bh=L/1KcuNfBToc/6pbLQgWvbQ3+WTJIAuKpXxm0KYE5ic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZsHws3d2EiPSU5glotZhjtf3IoGWZ/7BRPyABfOV6JC2S3ocal4h/m/oX5PNNE6bp
         h49jIh+rPmqDZC/vwUPNNZ6vIva/mBzwNnoFJIh1D7+RCRszRfxZ4KpAabIX/hyClY
         VyT/Vc9H9ZLIl+MSZKp9/5OeBPT4WtFtmbr8MX0E=
Message-ID: <a4b61098eaacca55e5f455b7c7df05dbc4839d3d.camel@kernel.org>
Subject: Re: [RFC PATCH v2 06/18] fscrypt: move nokey_name conversion to
 separate function and export it
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 08:50:04 -0400
In-Reply-To: <20200908035522.GG68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-7-jlayton@kernel.org>
         <20200908035522.GG68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 20:55 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:25PM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/crypto/fname.c       | 71 +++++++++++++++++++++++------------------
> >  include/linux/fscrypt.h |  3 ++
> >  2 files changed, 43 insertions(+), 31 deletions(-)
> > 
> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > index 9440a44e24ac..09f09def87fc 100644
> > --- a/fs/crypto/fname.c
> > +++ b/fs/crypto/fname.c
> > @@ -300,6 +300,45 @@ void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
> >  }
> >  EXPORT_SYMBOL(fscrypt_fname_free_buffer);
> >  
> > +void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
> > +			     const struct fscrypt_str *iname,
> > +			     struct fscrypt_str *oname)
> > +{
> > +	struct fscrypt_nokey_name nokey_name;
> > +	u32 size; /* size of the unencoded no-key name */
> > +
> > +	/*
> > +	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
> > +	 * between fields and that its encoded size never exceeds NAME_MAX.
> > +	 */
> > +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
> > +		     offsetof(struct fscrypt_nokey_name, bytes));
> > +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
> > +		     offsetof(struct fscrypt_nokey_name, sha256));
> > +	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
> > +
> > +	if (hash) {
> > +		nokey_name.dirhash[0] = hash;
> > +		nokey_name.dirhash[1] = minor_hash;
> > +	} else {
> > +		nokey_name.dirhash[0] = 0;
> > +		nokey_name.dirhash[1] = 0;
> > +	}
> > +	if (iname->len <= sizeof(nokey_name.bytes)) {
> > +		memcpy(nokey_name.bytes, iname->name, iname->len);
> > +		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
> > +	} else {
> > +		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
> > +		/* Compute strong hash of remaining part of name. */
> > +		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
> > +				  iname->len - sizeof(nokey_name.bytes),
> > +				  nokey_name.sha256);
> > +		size = FSCRYPT_NOKEY_NAME_MAX;
> > +	}
> > +	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
> > +}
> > +EXPORT_SYMBOL(fscrypt_encode_nokey_name);
> 
> Why does this need to be exported?
> 
> There's no user of this function introduced in this patchset.
> 
> - Eric

Yeah, I probably should have dropped this from the series for now as
nothing uses it yet, but eventually we may need this. I did a fairly
detailed writeup of the problem here:

    https://tracker.ceph.com/issues/47162

Basically, we still need to allow clients to look up dentries in the MDS
even when they don't have the key.

There are a couple of different approaches, but the simplest is to just
have the client always store long dentry names using the nokey_name, and
then keep the full name in a new field in the dentry representation that
is sent across the wire.

This requires some changes to the Ceph MDS (which is what that tracker
bug is about), and will mean enshrining the nokey name in perpetuity.
We're still looking at this for now though, and we're open to other
approaches if you've got any to suggest.

-- 
Jeff Layton <jlayton@kernel.org>

