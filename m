Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947970FC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEXRFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjEXRFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0E12B;
        Wed, 24 May 2023 10:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B4263738;
        Wed, 24 May 2023 17:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6825EC433EF;
        Wed, 24 May 2023 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684947933;
        bh=5msYT2xJYYGairPBr0tzDWJW/tq/WFkKdahahH8wkJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Su2dnSmZ8IYxiDYWOrBtGR/JlQYs9KWjy6g4IHj09onLZDL6xJwMD2eie6P3KzjSY
         bGqHbqHIpKAwjFK2uEGtq60Us8APmdeXtTpjlfx8AynXFdZtv7itaZK0VogopGTuvV
         x3p7pP5RGCCS6hgaaPqsU243Y32uDlfkcxxH/lj0gwUKKE6qzX5zNzrXwfgW4MIxF5
         MMrnWv+y+zj++PVQiKqJ1Ydd475LYJliCz7DhyQwpkhEeKn50PO0qUOQvZxKzuDfo9
         VNLgQdF5Qq6ug5Wao4vQAGSSPSX+6PRw4VRCZnL+QAFhj5W85+36fBEMFmPbfqQHAP
         3gDATHFDPN8Mw==
Message-ID: <61146b7311e44d89034bd09dee901254a4a6a60b.camel@kernel.org>
Subject: Re: [PATCH] exportfs: check for error return value from
 exportfs_encode_*()
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Date:   Wed, 24 May 2023 13:05:31 -0400
In-Reply-To: <20230524154825.881414-1-amir73il@gmail.com>
References: <20230524154825.881414-1-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-24 at 18:48 +0300, Amir Goldstein wrote:
> The exportfs_encode_*() helpers call the filesystem ->encode_fh()
> method which returns a signed int.
>=20
> All the in-tree implementations of ->encode_fh() return a positive
> integer and FILEID_INVALID (255) for error.
>=20
> Fortify the callers for possible future ->encode_fh() implementation
> that will return a negative error value.
>=20
> name_to_handle_at() would propagate the returned error to the users
> if filesystem ->encode_fh() method returns an error.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-fsdevel/ca02955f-1877-4fde-b453-3c1d2=
2794740@kili.mountain/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Jan,
>=20
> This patch is on top of the patches you have queued on fsnotify branch.
>=20
> I am not sure about the handling of negative value in nfsfh.c.
>=20
> Jeff/Chuck,
>=20
> Could you please take a look.
>=20
> I've test this patch with fanotify LTP tests, xfstest -g exportfs tests
> and some sanity xfstest nfs tests, but I did not try to inject errors
> in encode_fh().
>=20
> Please let me know what you think.
>=20
> Thanks,
> Amir.
>=20
>=20
>=20
>  fs/fhandle.c                  | 5 +++--
>  fs/nfsd/nfsfh.c               | 4 +++-
>  fs/notify/fanotify/fanotify.c | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 4a635cf787fc..fd0d6a3b3699 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -57,18 +57,19 @@ static long do_sys_name_to_handle(const struct path *=
path,
>  	handle_bytes =3D handle_dwords * sizeof(u32);
>  	handle->handle_bytes =3D handle_bytes;
>  	if ((handle->handle_bytes > f_handle.handle_bytes) ||
> -	    (retval =3D=3D FILEID_INVALID) || (retval =3D=3D -ENOSPC)) {
> +	    (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
>  		/* As per old exportfs_encode_fh documentation
>  		 * we could return ENOSPC to indicate overflow
>  		 * But file system returned 255 always. So handle
>  		 * both the values
>  		 */
> +		if (retval =3D=3D FILEID_INVALID || retval =3D=3D -ENOSPC)
> +			retval =3D -EOVERFLOW;
>  		/*
>  		 * set the handle size to zero so we copy only
>  		 * non variable part of the file_handle
>  		 */
>  		handle_bytes =3D 0;
> -		retval =3D -EOVERFLOW;
>  	} else
>  		retval =3D 0;
>  	/* copy the mount id */
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 31e4505c0df3..0f5eacae5f43 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -416,9 +416,11 @@ static void _fh_update(struct svc_fh *fhp, struct sv=
c_export *exp,
>  		int maxsize =3D (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
>  		int fh_flags =3D (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
>  				EXPORT_FH_CONNECTABLE;
> +		int fileid_type =3D
> +			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
> =20
>  		fhp->fh_handle.fh_fileid_type =3D
> -			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
> +			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>  		fhp->fh_handle.fh_size +=3D maxsize * 4;
>  	} else {
>  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index d2bbf1445a9e..9dac7f6e72d2 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -445,7 +445,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh,=
 struct inode *inode,
>  	dwords =3D fh_len >> 2;
>  	type =3D exportfs_encode_fid(inode, buf, &dwords);

Are you sure this patch is against the HEAD? My tree has this call as
exportfs_encode_inode_fh.

>  	err =3D -EINVAL;
> -	if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << 2)
> +	if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << =
2)

>  		goto out_err;
> =20
>  	fh->type =3D type;

I'm generally in favor of better guardrails for these sorts of
operations, so ACK on the general idea around the patch.

--=20
Jeff Layton <jlayton@kernel.org>
