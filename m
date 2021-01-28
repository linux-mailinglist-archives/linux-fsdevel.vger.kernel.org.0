Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB7307750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhA1NmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 08:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231932AbhA1NmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:42:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3C326146D;
        Thu, 28 Jan 2021 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611841283;
        bh=b+ujw9xo/MjXib3ZXDhj5xvuahMo4CObTSbv4xrzQXM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QX79PinPiwiK35mPy6V/sNtMuaJmg0Gq1F/lQ6pkIQ+QOFRCWq4r3603gqcCSnN8H
         5UhZVI2qGY1Gm65+TF2cHvjdDO7XEJK+YPvWjbOJDXCCvw7Tis7mkhofrv5wFlroWX
         WKAwAEsqfp7RHEQhWOyQLXJYHtSZPp2Pvbk0sk1kW9r5NgTSt4cndAq0tbv4B/xpjA
         qyBJSE7tUS2pbmJCbN9NjPkYJqCQn7YxppI74WkX7wIobSfSqlJn0nyH6zzYM6OOs5
         4u0cgU9uHjZtzweQIuZfLeSOfPibu5a19kJJMFzFppZ/QbLkLVaJ2kpbBYuzGQHwPS
         vpjnEYScPzcdA==
Message-ID: <b1a74dcd381d0ac8d460de7352fd0b0ec358fd74.camel@kernel.org>
Subject: Re: [RFC PATCH v4 13/17] ceph: add support to readdir for encrypted
 filenames
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 28 Jan 2021 08:41:21 -0500
In-Reply-To: <8735yljnya.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-14-jlayton@kernel.org> <8735yljnya.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-01-28 at 11:33 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > Add helper functions for buffer management and for decrypting filenames
> > returned by the MDS. Wire those into the readdir codepaths.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 41 ++++++++++++++++++++++++++
> >  fs/ceph/dir.c    | 62 +++++++++++++++++++++++++++++++--------
> >  fs/ceph/inode.c  | 38 ++++++++++++++++++++++--
> >  4 files changed, 202 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index f037a4939026..7ddd434c5baf 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -107,3 +107,79 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> >  		ceph_pagelist_release(pagelist);
> >  	return ret;
> >  }
> > +
> > +/**
> > + * ceph_fname_to_usr - convert a filename for userland presentation
> > + * @fname: ceph_fname to be converted
> > + * @tname: temporary name buffer to use for conversion (may be NULL)
> > + * @oname: where converted name should be placed
> > + * @is_nokey: set to true if key wasn't available during conversion (may be NULL)
> > + *
> > + * Given a filename (usually from the MDS), format it for presentation to
> > + * userland. If @parent is not encrypted, just pass it back as-is.
> > + *
> > + * Otherwise, base64 decode the string, and then ask fscrypt to format it
> > + * for userland presentation.
> > + *
> > + * Returns 0 on success or negative error code on error.
> > + */
> > +int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> > +		      struct fscrypt_str *oname, bool *is_nokey)
> > +{
> > +	int ret;
> > +	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
> > +	struct fscrypt_str iname;
> > +
> > +	if (!IS_ENCRYPTED(fname->dir)) {
> > +		oname->name = fname->name;
> > +		oname->len = fname->name_len;
> > +		return 0;
> > +	}
> > +
> > +	/* Sanity check that the resulting name will fit in the buffer */
> > +	if (fname->name_len > FSCRYPT_BASE64_CHARS(NAME_MAX))
> > +		return -EIO;
> > +
> > +	ret = __fscrypt_prepare_readdir(fname->dir);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Use the raw dentry name as sent by the MDS instead of
> > +	 * generating a nokey name via fscrypt.
> > +	 */
> > +	if (!fscrypt_has_encryption_key(fname->dir)) {
> 
> While chasing a different the bug (the one I mention yesterday on IRC), I
> came across this memory leak: oname->name needs to be freed here.  I
> believe that a
> 
> 	fscrypt_fname_free_buffer(oname);
> 
> before the kmemdup() below should be enough.
> 

Good catch. Thanks.

In hindsight, I'm regretting threading the use of fscrypt_str's through
this code. It's a rather cumbersome object, and I think I might be
better served using a different scheme. Let me think on it some...
-- 
Jeff Layton <jlayton@kernel.org>

