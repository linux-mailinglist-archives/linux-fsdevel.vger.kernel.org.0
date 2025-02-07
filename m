Return-Path: <linux-fsdevel+bounces-41168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043CA2BE87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0301916A154
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A91B653C;
	Fri,  7 Feb 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DQ60v9Nd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877821AE877;
	Fri,  7 Feb 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918560; cv=none; b=MLHgzc9xQ4VZeWTXXsfgA+09qgOGtx8uaBg1uUUv1CGuTDd1gVAYVkTbG39Q37zxW5SkC/tLJzNRyxl8zD9kVnOLLGo61sxQLCYjPQmY9gVewJGkjROQv6/s5sGwObcDibXMMeIoEBgFP8fUec7cO+h7KXf2+ptJShvaCcy6EG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918560; c=relaxed/simple;
	bh=sRB/hfq34WKlWGDM77dH3EUoChMdI3eVl5+yVG/zhNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3PmMaIOUwOPWa7YtiTsBiMScYaFstkE+eCFjH9926zOeiP3mUZUw1CW1wHkh2FyRHc8ZE1MQdm+z29RDnkAH/yv5EENDr9xPIq0d19zfYRCVlJrsus4g0w1Zmda/VRSmoPwv9JhkfTKTdvhxxKxAidFuzjuOJVwO6x0XOPovIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DQ60v9Nd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TurJ5LVFWxcEAzd3rCDFRjE0zJPW0AK79OZFMOKCnZY=; b=DQ60v9NdOrOuEWUD/bowJ+YQLb
	MtzqEOpgu7OHqNFkgiUnnijZP5k/msJuIF1wdGTLvWajMt3ejkpkzRR+54+Bu/EFcYXdZG8uvBgru
	BCCJrH8f+SX17RMmM4MkSEEKTfhgz2jgOHrjHeo27+7XGOC7nzwj+WVExiQBAySZl5QUBQ3kMX2C8
	eP1wKSbSyoP5myDQB9wtl3OMsUoCrgzigZLeFeuK6nuBKyKLsLGUGgxRlmVjGcLGlFNaGcSKezSuW
	ljCPqsDMURD979app+AQ4ZmVZH2U5scO/R6AhG+mRQDcNfeikQLC3etkoZa63vp1RuxyE8NcRVw/N
	tX7Uiv8g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tgK9L-005ikV-Vr; Fri, 07 Feb 2025 09:55:53 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH] fuse: add new function to invalidate cache for all
 inodes
In-Reply-To: <20250115163253.8402-1-luis@igalia.com> (Luis Henriques's message
	of "Wed, 15 Jan 2025 16:32:53 +0000")
References: <20250115163253.8402-1-luis@igalia.com>
Date: Fri, 07 Feb 2025 08:55:53 +0000
Message-ID: <87zfiyqgkm.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Wed, Jan 15 2025, Luis Henriques wrote:

> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
>
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate a=
ll
> the inodes, it also shrinks the superblock dcache.

Gentle ping, any comments on how to improve/modify this patch so that it
could eventually be acceptable in mainline?

Cheers,
--=20
Lu=C3=ADs

>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Just an additional note that this patch could eventually be simplified if
> Dave Chinner patch to iterate through the superblock inodes[1] is merged.
>
> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
>
>  fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |  3 +++
>  2 files changed, 56 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..1fd9a5f303da 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64=
 nodeid,
>  	return NULL;
>  }
>=20=20
> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
> +{
> +	struct fuse_mount *fm;
> +	struct super_block *sb;
> +	struct inode *inode, *old_inode =3D NULL;
> +	struct fuse_inode *fi;
> +
> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
> +	if (!inode)
> +		return -ENOENT;
> +
> +	fm =3D get_fuse_mount(inode);
> +	iput(inode);
> +	if (!fm)
> +		return -ENOENT;
> +	sb =3D fm->sb;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		spin_lock(&inode->i_lock);
> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		    !atomic_read(&inode->i_count)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +
> +		__iget(inode);
> +		spin_unlock(&inode->i_lock);
> +		spin_unlock(&sb->s_inode_list_lock);
> +		iput(old_inode);
> +
> +		fi =3D get_fuse_inode(inode);
> +		spin_lock(&fi->lock);
> +		fi->attr_version =3D atomic64_inc_return(&fm->fc->attr_version);
> +		spin_unlock(&fi->lock);
> +		fuse_invalidate_attr(inode);
> +		forget_all_cached_acls(inode);
> +
> +		old_inode =3D inode;
> +		cond_resched();
> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	iput(old_inode);
> +
> +	shrink_dcache_sb(sb);
> +
> +	return 0;
> +}
> +
>  int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  			     loff_t offset, loff_t len)
>  {
> @@ -554,6 +604,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u6=
4 nodeid,
>  	pgoff_t pg_start;
>  	pgoff_t pg_end;
>=20=20
> +	if (nodeid =3D=3D FUSE_INVAL_ALL_INODES)
> +		return fuse_reverse_inval_all(fc);
> +
>  	inode =3D fuse_ilookup(fc, nodeid, NULL);
>  	if (!inode)
>  		return -ENOENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index f1e99458e29e..e9e78292d107 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -658,6 +658,9 @@ enum fuse_notify_code {
>  	FUSE_NOTIFY_CODE_MAX,
>  };
>=20=20
> +/* The nodeid to request to invalidate all inodes */
> +#define FUSE_INVAL_ALL_INODES 0
> +
>  /* The read buffer is required to be at least 8k, but may be much larger=
 */
>  #define FUSE_MIN_READ_BUFFER 8192
>=20=20


