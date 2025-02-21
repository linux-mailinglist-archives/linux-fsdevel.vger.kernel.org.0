Return-Path: <linux-fsdevel+bounces-42218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5EA3F23F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 11:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2282A178A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2AB205ACE;
	Fri, 21 Feb 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L9OFWkVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E592046A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134343; cv=none; b=SPVaM6c99etM5DMHUtGaobNCWvteWk2C0PPQpm4z1uhk9tWQTFVirYzdR4Jzz2Ws8HrMquCgu/+6Z78CVnnQW0foz0rzj6LVHnm3b+YoIaDWzJVgtwqiV2h1RWCiO8wxjZcUvDTHXN5a6IKdUCF2jVDgCy6MOughdG/CInMekaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134343; c=relaxed/simple;
	bh=s6pAXJxmMqQc1KfL+ML6Dw5aGOwZP3xL1FMEbkRGiQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPdikXZsLFNv6SPLj3Zx2kmtJoPpNSHEl7Z/PvHAlLjOFayqoMWwlMaoHBA55WsIZoopZzEZjuysgRo7GQxv3H6ZGdoXaB6+j2yZLqnEjcTOUAT7Em6KxnDSMXe4Q8426Qvqte+phnaynPt9eGssu4aCuonGv3l5b4eryVCgRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=L9OFWkVG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MHDxPaRLXXgYypKx+F8xxAnErJBu1fZq9gfAq8eJUHU=; b=L9OFWkVG9nyrDzR1s7zoOnl4tf
	IdYq6GuWT23yjsaPjIomtiuDJem6e5ezFI2nRpFA4cQ3hxZFnuZSlwQwBD+Tf+NW3LxCM413P4iT2
	QiDFdQJI8DL8+4VXubv00oFjDMQJaa42WfifLG+UQjgrj+ybgoeWfkYrRRRHyU8LdtUmO18/npToX
	7zuvkYS7IQp31MLJ5dFTfRJ5dmLEma3yKjUuELzBqQQMzcFu1OU1gG4X8mpN2XBbn3XgZtsWvIW57
	zhhByPN4w8Q6SnfjwXHwhqmShBUNHkKBz5UevtXFbuPFpxc1Cu54nLn9T4hDm+mgCqCYSUA3wpeln
	iVikmh5A==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tlQQk-00G3AE-Tx; Fri, 21 Feb 2025 11:38:56 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Bernd
 Schubert <bernd.schubert@fastmail.fm>,  Laura Promberger
 <laura.promberger@cern.ch>,  Sam Lewis <samclewis@google.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
In-Reply-To: <20250220100258.793363-1-mszeredi@redhat.com> (Miklos Szeredi's
	message of "Thu, 20 Feb 2025 11:02:58 +0100")
References: <20250220100258.793363-1-mszeredi@redhat.com>
Date: Fri, 21 Feb 2025 10:38:56 +0000
Message-ID: <87y0xzh9a7.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025, Miklos Szeredi wrote:

> Fuse allows the value of a symlink to change and this property is exploit=
ed
> by some filesystems (e.g. CVMFS).
>
> It has been observed, that sometimes after changing the symlink contents,
> the value is truncated to the old size.
>
> This is caused by fuse_getattr() racing with fuse_reverse_inval_inode().
> fuse_reverse_inval_inode() updates the fuse_inode's attr_version, which
> results in fuse_change_attributes() exiting before updating the cached
> attributes
>
> This is okay, as the cached attributes remain invalid and the next call to
> fuse_change_attributes() will likely update the inode with the correct
> values.
>
> The reason this causes problems is that cached symlinks will be
> returned through page_get_link(), which truncates the symlink to
> inode->i_size.  This is correct for filesystems that don't mutate
> symlinks, but in this case it causes bad behavior.
>
> The solution is to just remove this truncation.  This can cause a
> regression in a filesystem that relies on supplying a symlink larger than
> the file size, but this is unlikely.  If that happens we'd need to make
> this behavior conditional.
>
> Reported-by: Laura Promberger <laura.promberger@cern.ch>
> Tested-by: Sam Lewis <samclewis@google.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

OK, I finally managed to reproduce the bug (thanks for the hints, Sam!)
and I can also confirm this patch fixes it.

So, feel free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>
Tested-by: Luis Henriques <luis@igalia.com>

Cheers,
--=20
Lu=C3=ADs

> ---
>  fs/fuse/dir.c      |  2 +-
>  fs/namei.c         | 24 +++++++++++++++++++-----
>  include/linux/fs.h |  2 ++
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 589e88822368..83c56ce6ad20 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1645,7 +1645,7 @@ static const char *fuse_get_link(struct dentry *den=
try, struct inode *inode,
>  		goto out_err;
>=20=20
>  	if (fc->cache_symlinks)
> -		return page_get_link(dentry, inode, callback);
> +		return page_get_link_raw(dentry, inode, callback);
>=20=20
>  	err =3D -ECHILD;
>  	if (!dentry)
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..ecb7b95c2ca3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5356,10 +5356,9 @@ const char *vfs_get_link(struct dentry *dentry, st=
ruct delayed_call *done)
>  EXPORT_SYMBOL(vfs_get_link);
>=20=20
>  /* get the link contents into pagecache */
> -const char *page_get_link(struct dentry *dentry, struct inode *inode,
> -			  struct delayed_call *callback)
> +static char *__page_get_link(struct dentry *dentry, struct inode *inode,
> +			     struct delayed_call *callback)
>  {
> -	char *kaddr;
>  	struct page *page;
>  	struct address_space *mapping =3D inode->i_mapping;
>=20=20
> @@ -5378,8 +5377,23 @@ const char *page_get_link(struct dentry *dentry, s=
truct inode *inode,
>  	}
>  	set_delayed_call(callback, page_put_link, page);
>  	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
> -	kaddr =3D page_address(page);
> -	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
> +	return page_address(page);
> +}
> +
> +const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
> +			      struct delayed_call *callback)
> +{
> +	return __page_get_link(dentry, inode, callback);
> +}
> +EXPORT_SYMBOL_GPL(page_get_link_raw);
> +
> +const char *page_get_link(struct dentry *dentry, struct inode *inode,
> +					struct delayed_call *callback)
> +{
> +	char *kaddr =3D __page_get_link(dentry, inode, callback);
> +
> +	if (!IS_ERR(kaddr))
> +		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
>  	return kaddr;
>  }
>=20=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..9346adf28f7b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3452,6 +3452,8 @@ extern const struct file_operations generic_ro_fops;
>=20=20
>  extern int readlink_copy(char __user *, int, const char *, int);
>  extern int page_readlink(struct dentry *, char __user *, int);
> +extern const char *page_get_link_raw(struct dentry *, struct inode *,
> +				     struct delayed_call *);
>  extern const char *page_get_link(struct dentry *, struct inode *,
>  				 struct delayed_call *);
>  extern void page_put_link(void *);
> --=20
>
> 2.48.1
>
>


