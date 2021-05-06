Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030F375B68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhEFTIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 15:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhEFTIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620328071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fpuFMdCeajW1Uwy98sPY31ItgEQVigIlX9gJjRQOwU=;
        b=WSVLz6c6hJzhSLtTQXiM82UQCZ9EnFlva1Xt88yAcV+1QNZdTvCgAX9GKPPc5q7j8JQoEb
        g5YUuBQiFXE0vhqhpObQqdHdx2iuMJhS5q6LR3PLZcOrQIBLDut1/jmM6i6SjdS3wVUHkn
        Kk0kfats7Bn28sEPPT1Cdegsbo6PDeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-1ZKBawjKOVu4PAcNeaqJJw-1; Thu, 06 May 2021 15:07:50 -0400
X-MC-Unique: 1ZKBawjKOVu4PAcNeaqJJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAAAB801817;
        Thu,  6 May 2021 19:07:48 +0000 (UTC)
Received: from work-vm (ovpn-115-37.ams2.redhat.com [10.36.115.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 301145C1C5;
        Thu,  6 May 2021 19:07:42 +0000 (UTC)
Date:   Thu, 6 May 2021 20:07:39 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 1/2] virtiofs, dax: Fix smatch warning about loss of info
 during shift
Message-ID: <YJQ+ex2DUPYo1GV5@work-vm>
References: <20210506184304.321645-1-vgoyal@redhat.com>
 <20210506184304.321645-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210506184304.321645-2-vgoyal@redhat.com>
User-Agent: Mutt/2.0.6 (2021-03-06)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Vivek Goyal (vgoyal@redhat.com) wrote:
> Dan reported a smatch warning during potentential loss of info during
> left shift if this code is compiled on 32bit systems.
>=20
> New smatch warnings:
> fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should 'start_idx << 21'=
 be a
> +64 bit type?
>=20
> I ran smatch and found two more instances of similar warning. This patch
> fixes all such instances.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/dax.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index ff99ab2a3c43..f06fdad3f7b1 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -186,7 +186,7 @@ static int fuse_setup_one_mapping(struct inode *inode=
, unsigned long start_idx,
>  	struct fuse_conn_dax *fcd =3D fm->fc->dax;
>  	struct fuse_inode *fi =3D get_fuse_inode(inode);
>  	struct fuse_setupmapping_in inarg;
> -	loff_t offset =3D start_idx << FUSE_DAX_SHIFT;
> +	loff_t offset =3D (loff_t)start_idx << FUSE_DAX_SHIFT;

I've not followed the others back, but isn't it easier to change
the start_idx parameter to be a loff_t, since the places it's called
=66rom are poth loff_t pos?

Dave

>  	FUSE_ARGS(args);
>  	ssize_t err;
> =20
> @@ -872,7 +872,7 @@ static int dmap_writeback_invalidate(struct inode *in=
ode,
>  				     struct fuse_dax_mapping *dmap)
>  {
>  	int ret;
> -	loff_t start_pos =3D dmap->itn.start << FUSE_DAX_SHIFT;
> +	loff_t start_pos =3D (loff_t)dmap->itn.start << FUSE_DAX_SHIFT;
>  	loff_t end_pos =3D (start_pos + FUSE_DAX_SZ - 1);
> =20
>  	ret =3D filemap_fdatawrite_range(inode->i_mapping, start_pos, end_pos);
> @@ -966,7 +966,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *f=
cd, struct inode *inode,
>  	dmap =3D inode_lookup_first_dmap(inode);
>  	if (dmap) {
>  		start_idx =3D dmap->itn.start;
> -		dmap_start =3D start_idx << FUSE_DAX_SHIFT;
> +		dmap_start =3D (u64)start_idx << FUSE_DAX_SHIFT;
>  		dmap_end =3D dmap_start + FUSE_DAX_SZ - 1;
>  	}
>  	up_read(&fi->dax->sem);
> @@ -1118,7 +1118,7 @@ static int lookup_and_reclaim_dmap(struct fuse_conn=
_dax *fcd,
>  {
>  	int ret;
>  	struct fuse_inode *fi =3D get_fuse_inode(inode);
> -	loff_t dmap_start =3D start_idx << FUSE_DAX_SHIFT;
> +	loff_t dmap_start =3D (loff_t)start_idx << FUSE_DAX_SHIFT;
>  	loff_t dmap_end =3D (dmap_start + FUSE_DAX_SZ) - 1;
> =20
>  	down_write(&fi->i_mmap_sem);
> --=20
> 2.25.4
>=20
--=20
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

