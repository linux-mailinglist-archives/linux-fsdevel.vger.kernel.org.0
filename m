Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C126A692
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIONvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgIONud (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:50:33 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0BF52226B;
        Tue, 15 Sep 2020 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600176471;
        bh=6Q+MhOQ7glSuksMrPnQjc8ZQNpw75aqn4R5Ei+SbD3I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=klfozuaokmIqv4d7ZXuZqLVJ2QIc763AaKRei6S+8wtuxsjzys4htoj5BrTSoMWo4
         K6S8KifJMkxOxUIZwbvWovDtH0J8atG5IMTquTE+1l4mx2uPWJvaYBslWsqXv7hPSW
         NjMYahRUky0JWuJP6fT+am8Pe7tXXm06Pm/QJjps=
Message-ID: <bf448095f9d675bad3adb0ddc2d7652625824bc6.camel@kernel.org>
Subject: Re: [RFC PATCH v3 14/16] ceph: add support to readdir for encrypted
 filenames
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 15 Sep 2020 09:27:49 -0400
In-Reply-To: <20200915015719.GL899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-15-jlayton@kernel.org>
         <20200915015719.GL899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 18:57 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:17:05PM -0400, Jeff Layton wrote:
> > Add helper functions for buffer management and for decrypting filenames
> > returned by the MDS. Wire those into the readdir codepaths.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/crypto.c | 47 +++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 35 +++++++++++++++++++++++++++++
> >  fs/ceph/dir.c    | 58 +++++++++++++++++++++++++++++++++++++++---------
> >  fs/ceph/inode.c  | 31 +++++++++++++++++++++++---
> >  4 files changed, 157 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index f037a4939026..e3038c88c7a0 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -107,3 +107,50 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> >  		ceph_pagelist_release(pagelist);
> >  	return ret;
> >  }
> > +
> > +int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
> > +			struct fscrypt_str *tname, struct fscrypt_str *oname,
> > +			bool *is_nokey)
> > +{
> > +	int ret, declen;
> > +	u32 save_len;
> > +	struct fscrypt_str myname = FSTR_INIT(NULL, 0);
> > +
> > +	if (!IS_ENCRYPTED(parent)) {
> > +		oname->name = name;
> > +		oname->len = len;
> > +		return 0;
> > +	}
> > +
> > +	ret = fscrypt_get_encryption_info(parent);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (tname) {
> > +		save_len = tname->len;
> > +	} else {
> > +		int err;
> > +
> > +		save_len = 0;
> > +		err = fscrypt_fname_alloc_buffer(NAME_MAX, &myname);
> > +		if (err)
> > +			return err;
> > +		tname = &myname;
> 
> The 'err' variable isn't needed, since 'ret' can be used instead.
> 
> > +	}
> > +
> > +	declen = fscrypt_base64_decode(name, len, tname->name);
> > +	if (declen < 0 || declen > NAME_MAX) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> 
> declen <= 0, to cover the empty name case.
> 
> Also, is there a point in checking for > NAME_MAX?
> 

IDK. We're getting these strings from the MDS and they could end up
being corrupt if there are bugs there (or if the MDS is compromised). 
Of course, if we get a name longer than NAME_MAX then we've overrun the
buffer.

Maybe we should add a maxlen parameter to fscrypt_base64_encode/decode ?
Or maybe I should just have fscrypt_fname_alloc_buffer allocate a buffer
the same size as "len"? It might be a little larger than necessary, but
that would be safer.

> > +
> > +	tname->len = declen;
> > +
> > +	ret = fscrypt_fname_disk_to_usr(parent, 0, 0, tname, oname, is_nokey);
> > +
> > +	if (save_len)
> > +		tname->len = save_len;
> 
> This logic for temporarily overwriting the length is weird.
> How about something like the following instead:
> 

Yeah, it is odd. I think I got spooked by the way that length in struct
fscrypt_str is handled.

Some functions treat it as representing the length of the allocated
buffer (e.g. fscrypt_fname_alloc_buffer), but others treat it as
representing the length of the string in ->name (e.g.
fscrypt_encode_nokey_name).

Your suggestion works around that though, so I'll probably adopt
something like it. Thanks!

> int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
> 		      struct fscrypt_str *tname, struct fscrypt_str *oname,
> 		      bool *is_nokey)
> {
> 	int err, declen;
> 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
> 	struct fscrypt_str iname;
> 
> 	if (!IS_ENCRYPTED(parent)) {
> 		oname->name = name;
> 		oname->len = len;
> 		return 0;
> 	}
> 
> 	err = fscrypt_get_encryption_info(parent);
> 	if (err)
> 		return err;
> 
> 	if (!tname) {
> 		err = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
> 		if (err)
> 			return err;
> 		tname = &_tname;
> 	}
> 
> 	declen = fscrypt_base64_decode(name, len, tname->name);
> 	if (declen <= 0) {
> 		err = -EIO;
> 		goto out;
> 	}
> 
> 	iname.name = tname->name;
> 	iname.len = declen;
> 	err = fscrypt_fname_disk_to_usr(parent, 0, 0, &iname, oname, is_nokey);
> out:
> 	fscrypt_fname_free_buffer(&_tname);
> 	return err;
> }

-- 
Jeff Layton <jlayton@kernel.org>

