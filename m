Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05765269BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgIOB5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgIOB5V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:57:21 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA2420771;
        Tue, 15 Sep 2020 01:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600135040;
        bh=m122QXVlOI6Vtyt8CgPxA/tzFHjzeaEucCPbdNM/NZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMtVvf6mxW4Ln+TyxMyrb7sOe2wCFwh1O1D2EfFyQ0edIpb1B19bvg1MEjBr6GcnC
         e5mbHZKYA9G0N3dKoWr44VFU1Na7wBXJLujb5tGXYGENcy8Af9hofgJujg06QdpN2L
         gRTUAcbU14VLDclEU3YT5T3kFCgWXQUSk9BELNkc=
Date:   Mon, 14 Sep 2020 18:57:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 14/16] ceph: add support to readdir for encrypted
 filenames
Message-ID: <20200915015719.GL899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-15-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-15-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:17:05PM -0400, Jeff Layton wrote:
> Add helper functions for buffer management and for decrypting filenames
> returned by the MDS. Wire those into the readdir codepaths.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/crypto.c | 47 +++++++++++++++++++++++++++++++++++++++
>  fs/ceph/crypto.h | 35 +++++++++++++++++++++++++++++
>  fs/ceph/dir.c    | 58 +++++++++++++++++++++++++++++++++++++++---------
>  fs/ceph/inode.c  | 31 +++++++++++++++++++++++---
>  4 files changed, 157 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index f037a4939026..e3038c88c7a0 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -107,3 +107,50 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  		ceph_pagelist_release(pagelist);
>  	return ret;
>  }
> +
> +int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
> +			struct fscrypt_str *tname, struct fscrypt_str *oname,
> +			bool *is_nokey)
> +{
> +	int ret, declen;
> +	u32 save_len;
> +	struct fscrypt_str myname = FSTR_INIT(NULL, 0);
> +
> +	if (!IS_ENCRYPTED(parent)) {
> +		oname->name = name;
> +		oname->len = len;
> +		return 0;
> +	}
> +
> +	ret = fscrypt_get_encryption_info(parent);
> +	if (ret)
> +		return ret;
> +
> +	if (tname) {
> +		save_len = tname->len;
> +	} else {
> +		int err;
> +
> +		save_len = 0;
> +		err = fscrypt_fname_alloc_buffer(NAME_MAX, &myname);
> +		if (err)
> +			return err;
> +		tname = &myname;

The 'err' variable isn't needed, since 'ret' can be used instead.

> +	}
> +
> +	declen = fscrypt_base64_decode(name, len, tname->name);
> +	if (declen < 0 || declen > NAME_MAX) {
> +		ret = -EIO;
> +		goto out;
> +	}

declen <= 0, to cover the empty name case.

Also, is there a point in checking for > NAME_MAX?

> +
> +	tname->len = declen;
> +
> +	ret = fscrypt_fname_disk_to_usr(parent, 0, 0, tname, oname, is_nokey);
> +
> +	if (save_len)
> +		tname->len = save_len;

This logic for temporarily overwriting the length is weird.
How about something like the following instead:

int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
		      struct fscrypt_str *tname, struct fscrypt_str *oname,
		      bool *is_nokey)
{
	int err, declen;
	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
	struct fscrypt_str iname;

	if (!IS_ENCRYPTED(parent)) {
		oname->name = name;
		oname->len = len;
		return 0;
	}

	err = fscrypt_get_encryption_info(parent);
	if (err)
		return err;

	if (!tname) {
		err = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
		if (err)
			return err;
		tname = &_tname;
	}

	declen = fscrypt_base64_decode(name, len, tname->name);
	if (declen <= 0) {
		err = -EIO;
		goto out;
	}

	iname.name = tname->name;
	iname.len = declen;
	err = fscrypt_fname_disk_to_usr(parent, 0, 0, &iname, oname, is_nokey);
out:
	fscrypt_fname_free_buffer(&_tname);
	return err;
}
