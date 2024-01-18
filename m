Return-Path: <linux-fsdevel+bounces-8240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A68318DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 13:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB691C250ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670BA24214;
	Thu, 18 Jan 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl8kj60A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918C241E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579612; cv=none; b=d55Zki2A05UiO+FOdgySzMRu2sWmkgVtavCiT4t1mHLtGtueFawIlVV+H33gShYDydo1is3p22bXfXx7qkT0VvVugsd+coS2w9K4yMOuT0r7lLTealkMvYUGefy4HI6BGUwyL0DfTzKP6s2MsRhzS+uramCN05afLSp8OaQaaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579612; c=relaxed/simple;
	bh=NL+9ZdIV93wVJ7V5mj8KSaNISA0W6Et7ZK/qN09JM/s=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=eyKCbcMx9sPmeqNKD0Q3GFemGbaG7OmXuk4yRRWDqoZf8sc3VDg5KmG1P3Z+g+CMTuWc+KcSn/OfxzPrekPdkp6xn5p42XQul+U4vz3C/T1XxZeJCrGMvbTqOLLQSbrzvpGdcFmzRldnHbjU7sUVlhhqI2mZV45Jw/5RVhcDUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl8kj60A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705579610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zyKI5UW1T7j3av5NA834hLqCyPt/0i5B/ndgyXGIQq4=;
	b=cl8kj60AJD9+hwiwKoq8A2vvYuNsA4p7OD5aYNQKPcAMHOIsHaLgVcme9xXCHtmVgLkVtt
	qz1EbdlW5wgnQNdGKLZ/pssctWCftmWWpMPRDDFCvMn3JKce87Ik66f0G0VimhHb+CEqjA
	Dug36Fo5nF6xVe/NyUIAlKbvj2N+fdo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-dJSQ_xMPMMWLKov0OB0l5w-1; Thu, 18 Jan 2024 07:06:48 -0500
X-MC-Unique: dJSQ_xMPMMWLKov0OB0l5w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cd64024de2so73975401fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 04:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705579607; x=1706184407;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyKI5UW1T7j3av5NA834hLqCyPt/0i5B/ndgyXGIQq4=;
        b=SMIGmdwev9uxEpP/yraLclk3C6XoZ2vkOJPeiqU9Z1+XWYNPOUE9uiNN+GY2Mrh4zX
         8fJFONHttxwbAz6wvkPtWofuyoVi1eVyrFTvWoZlJtqfA/b67sTegpsVVaXXbJdUbW47
         KO/DgJMsrKRhLMkqKVILJE1K7mvECXMJoM2tPPylFPGCv/19O8gH1BYa33YrCf0rip6q
         LQuQmcaJXxHaCdY5eD9vFCBMJ7U29F9n2U175fLbKvDTKDhfVZixXNjyrbhdummkqhUI
         WAQtx5MR9fb4i1q6E1pxpCOvKRRtnvtMi6Y+rkDb50HNPfN7br3mB8lkvHi74Yl9NiFR
         NqfA==
X-Gm-Message-State: AOJu0YxMyK+h63nTsXugcLjz507jKy4GbH04zPD1x6gDXQX4NeTrlpue
	g9gzkOOQH3QjvuLWDwuUdEIA6IRIllz9FyxgIYWKZ3gdyUaDCssV6ZLaEn/EE7YJcfXjrNaXa6u
	y8vSCKkSWisZr1T9uVn5kg6xWlcAABHuLKRTvzKB4XyLg6WA/0Pl7E3W1uwEjm+Q=
X-Received: by 2002:a05:651c:1a11:b0:2cc:fd12:40ea with SMTP id by17-20020a05651c1a1100b002ccfd1240eamr652473ljb.42.1705579607068;
        Thu, 18 Jan 2024 04:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqOBfcuM9PQhe2nBHpjNEUciiHUhwftXzgJeTCcMnCs7SEvXwoi4R7i08kQZmWGrfTFSdb/Q==
X-Received: by 2002:a05:651c:1a11:b0:2cc:fd12:40ea with SMTP id by17-20020a05651c1a1100b002ccfd1240eamr652466ljb.42.1705579606685;
        Thu, 18 Jan 2024 04:06:46 -0800 (PST)
Received: from [172.31.0.10] (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id e22-20020a2e9e16000000b002cd628d6ea3sm2199724ljk.112.2024.01.18.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:06:46 -0800 (PST)
Message-ID: <32aad0c3f19a60a5cdefff93a6d927ff40eaf30c.camel@redhat.com>
Subject: Re: [PATCH] ovl: require xwhiteout feature flag on layer roots
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 18 Jan 2024 13:06:45 +0100
In-Reply-To: <20240118104144.465158-1-mszeredi@redhat.com>
References: <20240118104144.465158-1-mszeredi@redhat.com>
Autocrypt: addr=alexl@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 11:41 +0100, Miklos Szeredi wrote:
> Add a check on each layer for the xwhiteout feature.=C2=A0 This prevents
> unnecessary checking the overlay.whiteouts xattr when reading a
> directory if this feature is not enabled, i.e. most of the time.
>=20
> Fixes: bc8df7a3dc03 ("ovl: Add an alternative type of whiteout")
> Cc: <stable@vger.kernel.org> # v6.7
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>=20
> Hi Alex,
>=20
> Can you please test this in your environment?

Interesting, I was just finishing a patch for this, and it is mostly
identical.
It works in my testing.

Reviewed-by: Alexander Larsson <alexl@redhat.com>

>=20
> I xwhiteout test in xfstests needs this tweak:
>=20
> --- a/tests/overlay/084
> +++ b/tests/overlay/084
> @@ -115,6 +115,7 @@ do_test_xwhiteout()
> =C2=A0
> =C2=A0	mkdir -p $basedir/lower $basedir/upper $basedir/work
> =C2=A0	touch $basedir/lower/regular $basedir/lower/hidden=C2=A0
> $basedir/upper/hidden
> +	setfattr -n $prefix.overlay.feature_xwhiteout -v "y"
> $basedir/upper
> =C2=A0	setfattr -n $prefix.overlay.whiteouts -v "y" $basedir/upper
> =C2=A0	setfattr -n $prefix.overlay.whiteout -v "y"
> $basedir/upper/hidden
> =C2=A0

Also, I will need to update mkcomposefs to set this xattr and bump the
image version.

>=20
> Thanks,
> Miklos
>=20
> fs/overlayfs/namei.c=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++---
> =C2=A0fs/overlayfs/overlayfs.h |=C2=A0 8 ++++++--
> =C2=A0fs/overlayfs/ovl_entry.h |=C2=A0 2 ++
> =C2=A0fs/overlayfs/readdir.c=C2=A0=C2=A0 | 11 ++++++++---
> =C2=A0fs/overlayfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++++++++-
> =C2=A0fs/overlayfs/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++=
+-
> =C2=A06 files changed, 43 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 03bc8d5dfa31..583cf56df66e 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -863,7 +863,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs
> *ofs, struct dentry *upper,
> =C2=A0 * Returns next layer in stack starting from top.
> =C2=A0 * Returns -1 if this is the last layer.
> =C2=A0 */
> -int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
> +int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
> +		=C2=A0 const struct ovl_layer **layer)
> =C2=A0{
> =C2=A0	struct ovl_entry *oe =3D OVL_E(dentry);
> =C2=A0	struct ovl_path *lowerstack =3D ovl_lowerstack(oe);
> @@ -871,13 +872,16 @@ int ovl_path_next(int idx, struct dentry
> *dentry, struct path *path)
> =C2=A0	BUG_ON(idx < 0);
> =C2=A0	if (idx =3D=3D 0) {
> =C2=A0		ovl_path_upper(dentry, path);
> -		if (path->dentry)
> +		if (path->dentry) {
> +			*layer =3D &OVL_FS(dentry->d_sb)->layers[0];
> =C2=A0			return ovl_numlower(oe) ? 1 : -1;
> +		}
> =C2=A0		idx++;
> =C2=A0	}
> =C2=A0	BUG_ON(idx > ovl_numlower(oe));
> =C2=A0	path->dentry =3D lowerstack[idx - 1].dentry;
> -	path->mnt =3D lowerstack[idx - 1].layer->mnt;
> +	*layer =3D lowerstack[idx - 1].layer;
> +	path->mnt =3D (*layer)->mnt;
> =C2=A0
> =C2=A0	return (idx < ovl_numlower(oe)) ? idx + 1 : -1;
> =C2=A0}
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 05c3dd597fa8..991eb5d5c66c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -51,6 +51,7 @@ enum ovl_xattr {
> =C2=A0	OVL_XATTR_PROTATTR,
> =C2=A0	OVL_XATTR_XWHITEOUT,
> =C2=A0	OVL_XATTR_XWHITEOUTS,
> +	OVL_XATTR_FEATURE_XWHITEOUT,
> =C2=A0};
> =C2=A0
> =C2=A0enum ovl_inode_flag {
> @@ -492,7 +493,9 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs,
> const struct path *path,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum ovl_xattr ox);
> =C2=A0bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct
> path *path);
> =C2=A0bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struc=
t
> path *path);
> -bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const
> struct path *path);
> +bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct ovl_layer *layer,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct path *path);
> =C2=A0bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs=
,
> =C2=A0			 const struct path *upperpath);
> =C2=A0
> @@ -674,7 +677,8 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct
> dentry *origin,
> =C2=A0struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh
> *fh);
> =C2=A0struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry
> *upper,
> =C2=A0				struct dentry *origin, bool verify);
> -int ovl_path_next(int idx, struct dentry *dentry, struct path
> *path);
> +int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
> +		=C2=A0 const struct ovl_layer **layer);
> =C2=A0int ovl_verify_lowerdata(struct dentry *dentry);
> =C2=A0struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
> =C2=A0			=C2=A0 unsigned int flags);
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index d82d2a043da2..51729e614f5a 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -40,6 +40,8 @@ struct ovl_layer {
> =C2=A0	int idx;
> =C2=A0	/* One fsid per unique underlying sb (upper fsid =3D=3D 0) */
> =C2=A0	int fsid;
> +	/* xwhiteouts are enabled on this layer*/
> +	bool feature_xwhiteout;
> =C2=A0};
> =C2=A0
> =C2=A0struct ovl_path {
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index a490fc47c3e7..c2597075e3f8 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -305,8 +305,6 @@ static inline int ovl_dir_read(const struct path
> *realpath,
> =C2=A0	if (IS_ERR(realfile))
> =C2=A0		return PTR_ERR(realfile);
> =C2=A0
> -	rdd->in_xwhiteouts_dir =3D rdd->dentry &&
> -		ovl_path_check_xwhiteouts_xattr(OVL_FS(rdd->dentry-
> >d_sb), realpath);
> =C2=A0	rdd->first_maybe_whiteout =3D NULL;
> =C2=A0	rdd->ctx.pos =3D 0;
> =C2=A0	do {
> @@ -359,10 +357,14 @@ static int ovl_dir_read_merged(struct dentry
> *dentry, struct list_head *list,
> =C2=A0		.is_lowest =3D false,
> =C2=A0	};
> =C2=A0	int idx, next;
> +	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +	const struct ovl_layer *layer;
> =C2=A0
> =C2=A0	for (idx =3D 0; idx !=3D -1; idx =3D next) {
> -		next =3D ovl_path_next(idx, dentry, &realpath);
> +		next =3D ovl_path_next(idx, dentry, &realpath,
> &layer);
> =C2=A0		rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D
> realpath.dentry;
> +		if (ovl_path_check_xwhiteouts_xattr(ofs, layer,
> &realpath))
> +			rdd.in_xwhiteouts_dir =3D true;
> =C2=A0
> =C2=A0		if (next !=3D -1) {
> =C2=A0			err =3D ovl_dir_read(&realpath, &rdd);
> @@ -568,6 +570,7 @@ static int ovl_dir_read_impure(const struct path
> *path,=C2=A0 struct list_head *list,
> =C2=A0	int err;
> =C2=A0	struct path realpath;
> =C2=A0	struct ovl_cache_entry *p, *n;
> +	struct ovl_fs *ofs =3D OVL_FS(path->dentry->d_sb);
> =C2=A0	struct ovl_readdir_data rdd =3D {
> =C2=A0		.ctx.actor =3D ovl_fill_plain,
> =C2=A0		.list =3D list,
> @@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path
> *path,=C2=A0 struct list_head *list,
> =C2=A0	INIT_LIST_HEAD(list);
> =C2=A0	*root =3D RB_ROOT;
> =C2=A0	ovl_path_upper(path->dentry, &realpath);
> +	if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0],
> &realpath))
> +		rdd.in_xwhiteouts_dir =3D true;
> =C2=A0

I'm not sure exactly how impure dirs work, but I don't think this is
needed. When we hit the read_impure() codepath, we never then actually
look at the p->is_whiteout information.

> =C2=A0	err =3D ovl_dir_read(&realpath, &rdd);
> =C2=A0	if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a0967bb25003..4e507ab780f3 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1291,7 +1291,7 @@ int ovl_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0	struct ovl_entry *oe;
> =C2=A0	struct ovl_layer *layers;
> =C2=A0	struct cred *cred;
> -	int err;
> +	int err, i;
> =C2=A0
> =C2=A0	err =3D -EIO;
> =C2=A0	if (WARN_ON(fc->user_ns !=3D current_user_ns()))
> @@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0	if (err)
> =C2=A0		goto out_free_oe;
> =C2=A0
> +	for (i =3D 0; i < ofs->numlayer; i++) {
> +		struct path path =3D { .mnt =3D layers[i].mnt };
> +
> +		if (path.mnt) {
> +			path.dentry =3D path.mnt->mnt_root;
> +			err =3D ovl_path_getxattr(ofs, &path,
> OVL_XATTR_FEATURE_XWHITEOUT, NULL, 0);
> +			if (err >=3D 0)
> +				layers[i].feature_xwhiteout =3D true;
> +		}
> +	}
> +
> =C2=A0	/* Show index=3Doff in /proc/mounts for forced r/o mount */
> =C2=A0	if (!ofs->indexdir) {
> =C2=A0		ofs->config.index =3D false;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index c3f020ca13a8..cae8219618e3 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -739,11 +739,16 @@ bool ovl_path_check_xwhiteout_xattr(struct
> ovl_fs *ofs, const struct path *path)
> =C2=A0	return res >=3D 0;
> =C2=A0}
> =C2=A0
> -bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const
> struct path *path)
> +bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct ovl_layer *layer,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct path *path)
> =C2=A0{
> =C2=A0	struct dentry *dentry =3D path->dentry;
> =C2=A0	int res;
> =C2=A0
> +	if (!layer->feature_xwhiteout)
> +		return false;
> +
> =C2=A0	/* xattr.whiteouts must be a directory */
> =C2=A0	if (!d_is_dir(dentry))
> =C2=A0		return false;
> @@ -838,6 +843,7 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs,
> const struct path *path,
> =C2=A0#define OVL_XATTR_PROTATTR_POSTFIX	"protattr"
> =C2=A0#define OVL_XATTR_XWHITEOUT_POSTFIX	"whiteout"
> =C2=A0#define OVL_XATTR_XWHITEOUTS_POSTFIX	"whiteouts"
> +#define OVL_XATTR_FEATURE_XWHITEOUT_POSTFIX	"feature_xwhiteout"
> =C2=A0
> =C2=A0#define OVL_XATTR_TAB_ENTRY(x) \
> =C2=A0	[x] =3D { [false] =3D OVL_XATTR_TRUSTED_PREFIX x ## _POSTFIX, \
> @@ -855,6 +861,7 @@ const char *const ovl_xattr_table[][2] =3D {
> =C2=A0	OVL_XATTR_TAB_ENTRY(OVL_XATTR_PROTATTR),
> =C2=A0	OVL_XATTR_TAB_ENTRY(OVL_XATTR_XWHITEOUT),
> =C2=A0	OVL_XATTR_TAB_ENTRY(OVL_XATTR_XWHITEOUTS),
> +	OVL_XATTR_TAB_ENTRY(OVL_XATTR_FEATURE_XWHITEOUT),
> =C2=A0};
> =C2=A0
> =C2=A0int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry
> *upperdentry,

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a gun-slinging hunchbacked boxer She's a psychotic=20
antique-collecting politician who don't take no shit from nobody. They=20
fight crime!=20


