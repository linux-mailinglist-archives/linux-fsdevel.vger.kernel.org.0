Return-Path: <linux-fsdevel+bounces-35137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C369D1962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6D1F2253A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E81E282B;
	Mon, 18 Nov 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+VEr/Zv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2831991B8
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960058; cv=none; b=OeFuibqe1MQWKnasvPKIn5NmFRyNnRgbKmZ1nX8NZTHafz22kItsWdtgohZUQPxFcbccVEwmGMnxNjmMvP0ZQdJmrtDbGqdFeYGe8BCsWagllllVbO9fltHVNqZ/SqkJc74OR1uc1srY316DBEM08AZ9IiDbru0M+gMdjxDgMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960058; c=relaxed/simple;
	bh=6ZfG54qMaBmtojfIQ1yqdSaeMf2o3Vn1qGAASG3i8j8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvsqWgol83PFbDNj+6QuniKN0p0Mxou0VI+zTrlz+VadT8cwTQk5VQTF/Xmdnors53gDjYXFI/VYZY7IQEolJUqxKWZYBHRsOPkYPl1s9/juRlI1Lj8uS4d37tC6XbUYQw4gylkFdjcdyabKdCYBq9be4JOfHHgqBKZVE7nRipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+VEr/Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC15C4CECC;
	Mon, 18 Nov 2024 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731960058;
	bh=6ZfG54qMaBmtojfIQ1yqdSaeMf2o3Vn1qGAASG3i8j8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C+VEr/Zvxtje8c/clxxc9iPck++nfEMUh0erB/RtcEIBbt6/A9hwXlSjNc4HLT3IH
	 rDiJCTKh9bj36TzCnD30+WdIWEvBKRyLlv0T+AKYaiV1uEA/Kt/gJBY5+em6SpmQ36
	 a3XgrOhpNP89XhBfPf4XIDpYQsMGWWxOD1Z29cuISHJS+Mjd1AHV0fClvHIF0bg7Dd
	 f6O9Svkqo0tGTYHSsuj5+5ZPEUNCh1MhezMn0N32QW4J5pFB3jIryi/Z4muAuqVpxz
	 p443itFh9oCZD0AczVOsk4/emYjKnGpj/WSWpKK6MmyCv1Wtgi1otVOqxRqtkchmeY
	 +ZU0tnuXMbO4A==
Message-ID: <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Hugh
 Dickens <hughd@google.com>
Cc: yukuai3@huawei.com, yangerkun@huaweicloud.com, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Mon, 18 Nov 2024 15:00:56 -0500
In-Reply-To: <20241117213206.1636438-3-cel@kernel.org>
References: <20241117213206.1636438-1-cel@kernel.org>
	 <20241117213206.1636438-3-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-11-17 at 16:32 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The fix in commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> for offset dir") introduced a fence in offset_iterate_dir() to stop
> the loop from returning child entries created after the directory
> was opened. This comparison relies on the strong ordering of
> DIR_OFFSET_MIN <=3D largest child offset <=3D next_offset to terminate
> the directory iteration.
>=20
> However, because simple_offset_add() uses mtree_alloc_cyclic() to
> select each next new directory offset, ctx->next_offset is not
> always the highest unused offset. Once mtree_alloc_cyclic() allows
> a new offset value to wrap, ctx->next_offset will be set to a value
> less than the actual largest child offset.
>=20
> The result is that readdir(3) no longer shows any entries in the
> directory because their offsets are above ctx->next_offset, which is
> now a small value. This situation is persistent, and the directory
> cannot be removed unless all current children are already known and
> can be explicitly removed by name first.
>=20
> In the current Maple tree implementation, there is no practical way
> that 63-bit offset values can ever wrap, so this issue is cleverly
> avoided. But the ordering dependency is not documented via comments
> or code, making the mechanism somewhat brittle. And it makes the
> continued use of mtree_alloc_cyclic() somewhat confusing.
>=20
> Further, if commit 64a7ce76fb90 ("libfs: fix infinite directory
> reads for offset dir") were to be backported to a kernel that still
> uses xarray to manage simple directory offsets, the directory offset
> value range is limited to 32-bits, which is small enough to allow a
> wrap after a few weeks of constant creation of entries in one
> directory.
>=20
> Therefore, replace the use of ctx->next_offset for fencing new
> children from appearing in readdir results.
>=20
> A jiffies timestamp marks the end of each opendir epoch. Entries
> created after this timestamp will not be visible to the file
> descriptor. I chose jiffies so that the dentry->d_time field can be
> re-used for storing the entry creation time.
>=20
> The new mechanism has its own corner cases. For instance, I think
> if jiffies wraps twice while a directory is open, some children
> might become invisible. On 32-bit systems, the jiffies value wraps
> every 49 days. Double-wrapping is not a risk on systems with 64-bit
> jiffies. Unlike with the next_offset-based mechanism, re-opening the
> directory will make invisible children re-appear.
>=20
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Closes: https://lore.kernel.org/stable/20241111005242.34654-1-cel@kernel.=
org/T/#m1c448e5bd4aae3632a09468affcfe1d1594c6a59
> Fixes: 64a7ce76fb90 ("libfs: fix infinite directory reads for offset dir"=
)
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index bf67954b525b..862a603fd454 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -294,6 +294,7 @@ int simple_offset_add(struct offset_ctx *octx, struct=
 dentry *dentry)
>  		return ret;
> =20
>  	offset_set(dentry, offset);
> +	WRITE_ONCE(dentry->d_time, jiffies);
>  	return 0;
>  }
> =20
> @@ -454,9 +455,7 @@ void simple_offset_destroy(struct offset_ctx *octx)
> =20
>  static int offset_dir_open(struct inode *inode, struct file *file)
>  {
> -	struct offset_ctx *ctx =3D inode->i_op->get_offset_ctx(inode);
> -
> -	file->private_data =3D (void *)ctx->next_offset;
> +	file->private_data =3D (void *)jiffies;
>  	return 0;
>  }
> =20
> @@ -473,9 +472,6 @@ static int offset_dir_open(struct inode *inode, struc=
t file *file)
>   */
>  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int wh=
ence)
>  {
> -	struct inode *inode =3D file->f_inode;
> -	struct offset_ctx *ctx =3D inode->i_op->get_offset_ctx(inode);
> -
>  	switch (whence) {
>  	case SEEK_CUR:
>  		offset +=3D file->f_pos;
> @@ -490,7 +486,8 @@ static loff_t offset_dir_llseek(struct file *file, lo=
ff_t offset, int whence)
> =20
>  	/* In this case, ->private_data is protected by f_pos_lock */
>  	if (!offset)
> -		file->private_data =3D (void *)ctx->next_offset;
> +		/* Make newer child entries visible */
> +		file->private_data =3D (void *)jiffies;
>  	return vfs_setpos(file, offset, LONG_MAX);
>  }
> =20
> @@ -521,7 +518,8 @@ static bool offset_dir_emit(struct dir_context *ctx, =
struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
> =20
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *=
ctx, long last_index)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *=
ctx,
> +			       unsigned long fence)
>  {
>  	struct offset_ctx *octx =3D inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
> @@ -531,14 +529,15 @@ static void offset_iterate_dir(struct inode *inode,=
 struct dir_context *ctx, lon
>  		if (!dentry)
>  			return;
> =20
> -		if (dentry2offset(dentry) >=3D last_index) {
> -			dput(dentry);
> -			return;
> -		}
> -
> -		if (!offset_dir_emit(ctx, dentry)) {
> -			dput(dentry);
> -			return;
> +		/*
> +		 * Output only child entries created during or before
> +		 * the current opendir epoch.
> +		 */
> +		if (time_before_eq(dentry->d_time, fence)) {
> +			if (!offset_dir_emit(ctx, dentry)) {
> +				dput(dentry);
> +				return;
> +			}
>  		}
> =20
>  		ctx->pos =3D dentry2offset(dentry) + 1;
> @@ -569,15 +568,14 @@ static void offset_iterate_dir(struct inode *inode,=
 struct dir_context *ctx, lon
>   */
>  static int offset_readdir(struct file *file, struct dir_context *ctx)
>  {
> +	unsigned long fence =3D (unsigned long)file->private_data;
>  	struct dentry *dir =3D file->f_path.dentry;
> -	long last_index =3D (long)file->private_data;
> =20
>  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> =20
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
> -
> -	offset_iterate_dir(d_inode(dir), ctx, last_index);
> +	offset_iterate_dir(d_inode(dir), ctx, fence);
>  	return 0;
>  }
> =20

Using timestamps instead of directory ordering does seem less brittle,
and the choice to use jiffies makes sense given that d_time is also an
unsigned long.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

