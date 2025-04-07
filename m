Return-Path: <linux-fsdevel+bounces-45864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2926A7DD8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E67A3A45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345D2459EF;
	Mon,  7 Apr 2025 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrzmbwZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982823907E;
	Mon,  7 Apr 2025 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028368; cv=none; b=F9qwvkhbTgX3CcVpvmmCaVNnEUpTXcrWD2OgIEpXS18FT4Ds06RTsISvoa1XZnWKiTJ11hX9AnEltV6IsstHcpfxIo59Va5buh6MMbW47K2NRpZq9uiVfTu270YEhKgm7fKz63cRmOWm1AoY64VkGCaEKPvyA77JxnXGzT4Oq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028368; c=relaxed/simple;
	bh=9/e70p2LL1FnQygMmOhD5HM46aVyjlYEtUpR4XAuHg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaokqdCpvL9LN8ln04qaFYzhvIxTWqsXoEcpmCV50WK4gFglO8wPnDyw56qY7AJERV6TnZZXms4ePDB/PiIK0KcPtW3ggA0HG5obgnSIIc0LQEQwAtVAukOvKdGZkoXSBYJhdeE55lo3ms04OrADDAxNE8NgVFEdtXScGqjtOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrzmbwZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2269C4CEDD;
	Mon,  7 Apr 2025 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028367;
	bh=9/e70p2LL1FnQygMmOhD5HM46aVyjlYEtUpR4XAuHg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LrzmbwZIbHW+LpTXis6xG3QjqVHe5CLKock553NEfcL24noNZ6PuuF+UcawcNFQY/
	 yuUm1NvPlwAJxeFHEWMLWtwzJ7hDlDvs6PDWud6AtB3mmK8pW//3kSUCReN2l34ojS
	 pIVEUngbAXAdaHoYjkX3T/XuQtXBq78+o4L1C8g6p1KguE5hNVWKhw6nPlXNmxvYRl
	 wqmr5oo/Rxra/UTc1r0hm6F+dS/+8bM8A2WS8GHsudECoUW05wFTJIYCDjPgOKhsA/
	 s2luLv/btOGVOHxA1jfhvusAEbIpx1GF8wINvOza8kQkQNfAmYgDWtcOQCQrSpzSdK
	 94ktqmzTq/hMA==
Message-ID: <dfa046b304aa0c66dde37da5ed9cf31759cb6f18.camel@kernel.org>
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Mateusz Guzik
 <mjguzik@gmail.com>,  Penglei Jiang <superman.xpt@gmail.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Josef Bacik	
 <josef@toxicpanda.com>,
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Date: Mon, 07 Apr 2025 08:19:25 -0400
In-Reply-To: <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
	 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 11:54 +0200, Christian Brauner wrote:
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.
>=20
> Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> Cc: <stable@vger.kernel.org> # all LTS kernels
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@goo=
gle.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
>  fs/internal.h    |  3 +++
>  fs/libfs.c       |  2 +-
>  3 files changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 583ac81669c2..42e4b9c34f89 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -24,9 +24,43 @@
> =20
>  #include <linux/uaccess.h>
> =20
> +#include "internal.h"
> +
>  static struct vfsmount *anon_inode_mnt __ro_after_init;
>  static struct inode *anon_inode_inode __ro_after_init;
> =20
> +/*
> + * User space expects anonymous inodes to have no file type in st_mode.

Weird. Does anything actually depend on this?

ISTM that they should report a file type.

> + *
> + * In particular, 'lsof' has this legacy logic:
> + *
> + *	type =3D s->st_mode & S_IFMT;
> + *	switch (type) {
> + *	  ...
> + *	case 0:
> + *		if (!strcmp(p, "anon_inode"))
> + *			Lf->ntype =3D Ntype =3D N_ANON_INODE;
> + *
> + * to detect our old anon_inode logic.
> + *
> + * Rather than mess with our internal sane inode data, just fix it
> + * up here in getattr() by masking off the format bits.
> + */
> +int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
> +		       struct kstat *stat, u32 request_mask,
> +		       unsigned int query_flags)
> +{
> +	struct inode *inode =3D d_inode(path->dentry);
> +
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> +	stat->mode &=3D ~S_IFMT;
> +	return 0;
> +}
> +
> +static const struct inode_operations anon_inode_operations =3D {
> +	.getattr =3D anon_inode_getattr,
> +};
> +
>  /*
>   * anon_inodefs_dname() is called from d_path().
>   */
> @@ -66,6 +100,7 @@ static struct inode *anon_inode_make_secure_inode(
>  	if (IS_ERR(inode))
>  		return inode;
>  	inode->i_flags &=3D ~S_PRIVATE;
> +	inode->i_op =3D &anon_inode_operations;
>  	error =3D	security_inode_init_security_anon(inode, &QSTR(name),
>  						  context_inode);
>  	if (error) {
> @@ -313,6 +348,7 @@ static int __init anon_inode_init(void)
>  	anon_inode_inode =3D alloc_anon_inode(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(anon_inode_inode))
>  		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(ano=
n_inode_inode));
> +	anon_inode_inode->i_op =3D &anon_inode_operations;
> =20
>  	return 0;
>  }
> diff --git a/fs/internal.h b/fs/internal.h
> index b9b3e29a73fd..717dc9eb6185 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -343,3 +343,6 @@ static inline bool path_mounted(const struct path *pa=
th)
>  void file_f_owner_release(struct file *file);
>  bool file_seek_cur_needs_f_lock(struct file *file);
>  int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, b=
ool uid_map);
> +int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
> +		       struct kstat *stat, u32 request_mask,
> +		       unsigned int query_flags);
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 6393d7c49ee6..0ad3336f5b49 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1647,7 +1647,7 @@ struct inode *alloc_anon_inode(struct super_block *=
s)
>  	 * that it already _is_ on the dirty list.
>  	 */
>  	inode->i_state =3D I_DIRTY;
> -	inode->i_mode =3D S_IRUSR | S_IWUSR;
> +	inode->i_mode =3D S_IFREG | S_IRUSR | S_IWUSR;
>  	inode->i_uid =3D current_fsuid();
>  	inode->i_gid =3D current_fsgid();
>  	inode->i_flags |=3D S_PRIVATE;
>=20

--=20
Jeff Layton <jlayton@kernel.org>

