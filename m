Return-Path: <linux-fsdevel+bounces-44095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD04A6205B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73657165C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB73200BAA;
	Fri, 14 Mar 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="vGT6het8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9651DE8A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991287; cv=none; b=TPtT5+x3Drm1Mf6uLWeEXHvAx9Nos6lVeePbZD+YY6gacyr885pMbsR7JkHVeKNG5JQeoAOMPqfhhXSxOnAmK/jKVqmKC3VgwSsSW3Jx9JS7v4WNVQFJ/LUS9bXDzvpBLSX/fSStxvl/Qpja2TnohNJQgEc/npsC4zZIqX7HBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991287; c=relaxed/simple;
	bh=1Q9AXu5bLTb6dB1YPbDvV6DVY+k+FxmpfD9pb0jNUxo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=pSBb3ucdNECiEwdK476pGgwBGZcITbTVOrnUdrBbM+GWZlN3hE1q8EfN6G7lemOmNYxUYQTpetBtRPCpPsWhuGjlGzQf+jV8/0qu+VGEyIzGSM1yfGm/TopHVgm1ScKlGn9jTI1L7zlB7v0lmyf0FmkfuTlAydkA7WJ2CCn/0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=vGT6het8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c12b7af278so1736072fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1741991283; x=1742596083; darn=vger.kernel.org;
        h=user-agent:date:mime-version:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feac0ze6HikpkxtN6hDRr2IbhULf7JuQ3eA4z9EYJD0=;
        b=vGT6het8u8EeLIhEnMN2esBwXgzM+DXnqEuGIar+5BJc5bRkYUMrjTaQCMrK22B9YL
         r+h35dMPEKDi15nsLGaP3//+YQ+aRrKFC9qyvmj0MCmJ2fuvA+IrPOI2wSdXlNPojWLz
         8xNH2bNvyj/TGLl1uufR56FBNhGOeBXFWhEGz4FfS7W/or+qoBmM5puwnHvtIPU1Ojqd
         btZX85bTW2T4aRpCUSGC0E/nacYRjR80k6jlJ8kRdgjJDNEQs61Qn3wD8PBPhQ3tCie7
         q8ZnHAHVyxfaNUo4BehnSAG8fnuE4L6rjKfLqh2G9OqhEaCXxHEs2r/5lciQAF0xeYeT
         HRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741991283; x=1742596083;
        h=user-agent:date:mime-version:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feac0ze6HikpkxtN6hDRr2IbhULf7JuQ3eA4z9EYJD0=;
        b=DQDhLBuELGBfaT1Qzqpz4RN29EWeVsYJQ5wJGy9WohGNsQVRv5b9g2oVycR5mXnNuL
         Ul35lh4Vr8fZQHHhpwWxBjFWLNQanL0cVL4c5fCOq/9FQfaYrYix46FmIfTZcKaiIvZi
         Oiku5lOO5hhdmw7Cpbh9qklC4ngxvT35lKb/XxCO8zyjFzAOyNrzNIjrQoYWVbzqZobK
         EHMoyFp0b6J6VDUdlqAAuILHKDbEdAWZCyo2jaZW4URvyqLB0Jn899Hysg0Bh+1jpbU+
         eZaCnPNi4jv68IFJqdFJ5pFnWXoSwQm3wCTYujQ8fGPlvthZQWhfOS+OJTiZewbZt7Xa
         TpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/GIPv8htH0X+XttvIzhJTN67CFHnRHC1kNUvdqsO0Co3GSxhJIna6+Or0IgXIxvCbAVsejLU8EcGk7xJx@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgiUogRXbRn/zmYtVC/Y2tWGfMw36FG9PefJm2rD70HEJA7hG
	A+SeV5sezHibtfkYcnfSAn+WzOk/GRzSwpR/2kEqcDF01c0IZnaMlTYhlYIXl3E=
X-Gm-Gg: ASbGncvBc/Oqv3l+fpP69G1FMUy7IU4j5O3YPRW/QXOwAblKY1eioOwbTedn1PYO+r0
	224lYcUoNLx8vcQaAiew4Vf2zOU2aMKBj3fcunHe5G6E3CGyaAKxiSGllUSUIeQfzoMTZgo29Wp
	cr97iiYAFp9kd/5KQtRZsx9F839zWxfg3QgLOSCJ3bthDgVu+edJUJZiVLbRlyi7lUWVeeIhIhy
	deI18PHb9e1G5ZY4sYy3szoVcfHTnun1CzrHwet30Mu51N3umgDoYqZ09BtA2N6Wt6A7CxMVu/J
	pnoVkAp/Lqo5cTYEFjTo65cVx1DItKOmzuzAObCaUOGqhUzyhGHzbiq8E8slBaoSk3JJKZAOUyu
	JoO0DprgJxFEkvokB
X-Google-Smtp-Source: AGHT+IEcQVrM4yLizX+SD244NBQDUc/jbsxy9pjrTkVucbdKWDx8L13qOVLUAha8gMUagXg96TfntQ==
X-Received: by 2002:a05:6871:3285:b0:2b8:92f0:ba5d with SMTP id 586e51a60fabf-2c66f88b26fmr4484637fac.8.1741991282937;
        Fri, 14 Mar 2025 15:28:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a51:a450:8c55:68d0? ([2600:1700:6476:1430:7a51:a450:8c55:68d0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c67100aa32sm1039831fac.12.2025.03.14.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 15:28:01 -0700 (PDT)
Message-ID: <a62918950646701cb9bb2ab0a32c87b53e2f102e.camel@dubeyko.com>
Subject: Re: [RFC PATCH 04/35] ceph: Convert ceph_mds_request::r_pagelist
 to a databuf
From: slava@dubeyko.com
To: David Howells <dhowells@redhat.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, ceph-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 	linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Slava.Dubeyko@ibm.com
In-Reply-To: <20250313233341.1675324-5-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-5-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 15:27:55 -0700
User-Agent: Evolution 3.54.3 (by Flathub.org) 

On Thu, 2025-03-13 at 23:32 +0000, David Howells wrote:
> Convert ceph_mds_request::r_pagelist to a databuf, along with the
> stuff
> that uses it such as setxattr ops.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: ceph-devel@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> =C2=A0fs/ceph/acl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 ++++++=
++++----------
> =C2=A0fs/ceph/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++---
> =C2=A0fs/ceph/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 85 ++++++++++++++++=
+++-----------------------
> --
> =C2=A0fs/ceph/mds_client.c | 11 +++---
> =C2=A0fs/ceph/mds_client.h |=C2=A0 2 +-
> =C2=A0fs/ceph/super.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/ceph/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 68 +++++++++++++++-=
-------------------
> =C2=A07 files changed, 96 insertions(+), 123 deletions(-)
>=20
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 1564eacc253d..d6da650db83e 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -171,7 +171,7 @@ int ceph_pre_init_acls(struct inode *dir, umode_t
> *mode,
> =C2=A0{
> =C2=A0	struct posix_acl *acl, *default_acl;
> =C2=A0	size_t val_size1 =3D 0, val_size2 =3D 0;
> -	struct ceph_pagelist *pagelist =3D NULL;
> +	struct ceph_databuf *dbuf =3D NULL;
> =C2=A0	void *tmp_buf =3D NULL;
> =C2=A0	int err;
> =C2=A0
> @@ -201,58 +201,55 @@ int ceph_pre_init_acls(struct inode *dir,
> umode_t *mode,
> =C2=A0	tmp_buf =3D kmalloc(max(val_size1, val_size2), GFP_KERNEL);
> =C2=A0	if (!tmp_buf)
> =C2=A0		goto out_err;
> -	pagelist =3D ceph_pagelist_alloc(GFP_KERNEL);
> -	if (!pagelist)
> +	dbuf =3D ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_KERNEL);
> +	if (!dbuf)
> =C2=A0		goto out_err;
> =C2=A0
> -	err =3D ceph_pagelist_reserve(pagelist, PAGE_SIZE);
> -	if (err)
> -		goto out_err;
> -
> -	ceph_pagelist_encode_32(pagelist, acl && default_acl ? 2 :
> 1);
> +	ceph_databuf_encode_32(dbuf, acl && default_acl ? 2 : 1);
> =C2=A0
> =C2=A0	if (acl) {
> =C2=A0		size_t len =3D strlen(XATTR_NAME_POSIX_ACL_ACCESS);
> -		err =3D ceph_pagelist_reserve(pagelist, len +
> val_size1 + 8);
> +		err =3D ceph_databuf_reserve(dbuf, len + val_size1 +
> 8,
> +					=C2=A0=C2=A0 GFP_KERNEL);

I know that it's simple change. But this len + val_size1 + 8 looks
confusing, anyway. What this hardcoded 8 means? :)


> =C2=A0		if (err)
> =C2=A0			goto out_err;
> -		ceph_pagelist_encode_string(pagelist,
> XATTR_NAME_POSIX_ACL_ACCESS,
> -					=C2=A0=C2=A0=C2=A0 len);
> +		ceph_databuf_encode_string(dbuf,
> XATTR_NAME_POSIX_ACL_ACCESS,
> +					=C2=A0=C2=A0 len);
> =C2=A0		err =3D posix_acl_to_xattr(&init_user_ns, acl,
> =C2=A0					 tmp_buf, val_size1);
> =C2=A0		if (err < 0)
> =C2=A0			goto out_err;
> -		ceph_pagelist_encode_32(pagelist, val_size1);
> -		ceph_pagelist_append(pagelist, tmp_buf, val_size1);
> +		ceph_databuf_encode_32(dbuf, val_size1);
> +		ceph_databuf_append(dbuf, tmp_buf, val_size1);
> =C2=A0	}
> =C2=A0	if (default_acl) {
> =C2=A0		size_t len =3D strlen(XATTR_NAME_POSIX_ACL_DEFAULT);
> -		err =3D ceph_pagelist_reserve(pagelist, len +
> val_size2 + 8);
> +		err =3D ceph_databuf_reserve(dbuf, len + val_size2 +
> 8,
> +					=C2=A0=C2=A0 GFP_KERNEL);

Same question here. :) What this hardcoded 8 means? :)

> =C2=A0		if (err)
> =C2=A0			goto out_err;
> -		ceph_pagelist_encode_string(pagelist,
> -					=C2=A0
> XATTR_NAME_POSIX_ACL_DEFAULT, len);
> +		ceph_databuf_encode_string(dbuf,
> +					=C2=A0=C2=A0
> XATTR_NAME_POSIX_ACL_DEFAULT, len);
> =C2=A0		err =3D posix_acl_to_xattr(&init_user_ns, default_acl,
> =C2=A0					 tmp_buf, val_size2);
> =C2=A0		if (err < 0)
> =C2=A0			goto out_err;
> -		ceph_pagelist_encode_32(pagelist, val_size2);
> -		ceph_pagelist_append(pagelist, tmp_buf, val_size2);
> +		ceph_databuf_encode_32(dbuf, val_size2);
> +		ceph_databuf_append(dbuf, tmp_buf, val_size2);
> =C2=A0	}
> =C2=A0
> =C2=A0	kfree(tmp_buf);
> =C2=A0
> =C2=A0	as_ctx->acl =3D acl;
> =C2=A0	as_ctx->default_acl =3D default_acl;
> -	as_ctx->pagelist =3D pagelist;
> +	as_ctx->dbuf =3D dbuf;
> =C2=A0	return 0;
> =C2=A0
> =C2=A0out_err:
> =C2=A0	posix_acl_release(acl);
> =C2=A0	posix_acl_release(default_acl);
> =C2=A0	kfree(tmp_buf);
> -	if (pagelist)
> -		ceph_pagelist_release(pagelist);
> +	ceph_databuf_release(dbuf);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 851d70200c6b..9de2960748b9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -679,9 +679,9 @@ static int ceph_finish_async_create(struct inode
> *dir, struct inode *inode,
> =C2=A0	iinfo.change_attr =3D 1;
> =C2=A0	ceph_encode_timespec64(&iinfo.btime, &now);
> =C2=A0
> -	if (req->r_pagelist) {
> -		iinfo.xattr_len =3D req->r_pagelist->length;
> -		iinfo.xattr_data =3D req->r_pagelist->mapped_tail;
> +	if (req->r_dbuf) {
> +		iinfo.xattr_len =3D ceph_databuf_len(req->r_dbuf);
> +		iinfo.xattr_data =3D kmap_ceph_databuf_page(req-
> >r_dbuf, 0);

Possibly, it's in another patch. Have we removed req->r_pagelist from
the structure?

Do we always have memory pages in ceph_databuf? How
kmap_ceph_databuf_page() will behave if it's not memory page.

> =C2=A0	} else {
> =C2=A0		/* fake it */
> =C2=A0		iinfo.xattr_len =3D ARRAY_SIZE(xattr_buf);
> @@ -731,6 +731,8 @@ static int ceph_finish_async_create(struct inode
> *dir, struct inode *inode,
> =C2=A0	ret =3D ceph_fill_inode(inode, NULL, &iinfo, NULL, req-
> >r_session,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->r_fmode, NULL);
> =C2=A0	up_read(&mdsc->snap_rwsem);
> +	if (req->r_dbuf)
> +		kunmap_local(iinfo.xattr_data);

Maybe, we need to hide kunmap_local() into something like
kunmap_ceph_databuf_page()?

> =C2=A0	if (ret) {
> =C2=A0		doutc(cl, "failed to fill inode: %d\n", ret);
> =C2=A0		ceph_dir_clear_complete(dir);
> @@ -849,8 +851,8 @@ int ceph_atomic_open(struct inode *dir, struct
> dentry *dentry,
> =C2=A0			goto out_ctx;
> =C2=A0		}
> =C2=A0		/* Async create can't handle more than a page of
> xattrs */
> -		if (as_ctx.pagelist &&
> -		=C2=A0=C2=A0=C2=A0 !list_is_singular(&as_ctx.pagelist->head))
> +		if (as_ctx.dbuf &&
> +		=C2=A0=C2=A0=C2=A0 as_ctx.dbuf->nr_bvec > 1)

Maybe, it makes sense to call something like ceph_databuf_length()
instead of low level access to dbuf->nr_bvec?

> =C2=A0			try_async =3D false;
> =C2=A0	} else if (!d_in_lookup(dentry)) {
> =C2=A0		/* If it's not being looked up, it's negative */
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index b060f765ad20..ec9b80fec7be 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -112,9 +112,9 @@ struct inode *ceph_new_inode(struct inode *dir,
> struct dentry *dentry,
> =C2=A0void ceph_as_ctx_to_req(struct ceph_mds_request *req,
> =C2=A0			struct ceph_acl_sec_ctx *as_ctx)
> =C2=A0{
> -	if (as_ctx->pagelist) {
> -		req->r_pagelist =3D as_ctx->pagelist;
> -		as_ctx->pagelist =3D NULL;
> +	if (as_ctx->dbuf) {
> +		req->r_dbuf =3D as_ctx->dbuf;
> +		as_ctx->dbuf =3D NULL;

Maybe, we need something like swap() method? :)

> =C2=A0	}
> =C2=A0	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
> =C2=A0}
> @@ -2341,11 +2341,10 @@ static int fill_fscrypt_truncate(struct inode
> *inode,
> =C2=A0	loff_t pos, orig_pos =3D round_down(attr->ia_size,
> =C2=A0					=C2=A0 CEPH_FSCRYPT_BLOCK_SIZE);
> =C2=A0	u64 block =3D orig_pos >> CEPH_FSCRYPT_BLOCK_SHIFT;
> -	struct ceph_pagelist *pagelist =3D NULL;
> -	struct kvec iov =3D {0};
> +	struct ceph_databuf *dbuf =3D NULL;
> =C2=A0	struct iov_iter iter;
> -	struct page *page =3D NULL;
> -	struct ceph_fscrypt_truncate_size_header header;
> +	struct ceph_fscrypt_truncate_size_header *header;
> +	void *p;
> =C2=A0	int retry_op =3D 0;
> =C2=A0	int len =3D CEPH_FSCRYPT_BLOCK_SIZE;
> =C2=A0	loff_t i_size =3D i_size_read(inode);
> @@ -2372,37 +2371,35 @@ static int fill_fscrypt_truncate(struct inode
> *inode,
> =C2=A0			goto out;
> =C2=A0	}
> =C2=A0
> -	page =3D __page_cache_alloc(GFP_KERNEL);
> -	if (page =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> +	ret =3D -ENOMEM;
> +	dbuf =3D ceph_databuf_req_alloc(2, 0, GFP_KERNEL);

So, do we allocate 2 items of zero length here?

> +	if (!dbuf)
> =C2=A0		goto out;
> -	}
> =C2=A0
> -	pagelist =3D ceph_pagelist_alloc(GFP_KERNEL);
> -	if (!pagelist) {
> -		ret =3D -ENOMEM;
> +	if (ceph_databuf_insert_frag(dbuf, 0, sizeof(*header),
> GFP_KERNEL) < 0)
> +		goto out;
> +	if (ceph_databuf_insert_frag(dbuf, 1, PAGE_SIZE, GFP_KERNEL)
> < 0)
> =C2=A0		goto out;
> -	}
> =C2=A0
> -	iov.iov_base =3D kmap_local_page(page);
> -	iov.iov_len =3D len;
> -	iov_iter_kvec(&iter, READ, &iov, 1, len);
> +	iov_iter_bvec(&iter, ITER_DEST, &dbuf->bvec[1], 1, len);

Is it correct &dbuf->bvec[1]? Why do we work with item #1? I think it
looks confusing.

> =C2=A0
> =C2=A0	pos =3D orig_pos;
> =C2=A0	ret =3D __ceph_sync_read(inode, &pos, &iter, &retry_op,
> &objver);
> =C2=A0	if (ret < 0)
> =C2=A0		goto out;
> =C2=A0
> +	header =3D kmap_ceph_databuf_page(dbuf, 0);
> +
> =C2=A0	/* Insert the header first */
> -	header.ver =3D 1;
> -	header.compat =3D 1;
> -	header.change_attr =3D
> cpu_to_le64(inode_peek_iversion_raw(inode));
> +	header->ver =3D 1;
> +	header->compat =3D 1;
> +	header->change_attr =3D
> cpu_to_le64(inode_peek_iversion_raw(inode));
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Always set the block_size to CEPH_FSCRYPT_BLOCK_SIZE,
> =C2=A0	 * because in MDS it may need this to do the truncate.
> =C2=A0	 */
> -	header.block_size =3D cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
> +	header->block_size =3D cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * If we hit a hole here, we should just skip filling
> @@ -2417,51 +2414,41 @@ static int fill_fscrypt_truncate(struct inode
> *inode,
> =C2=A0	if (!objver) {
> =C2=A0		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos,
> i_size);
> =C2=A0
> -		header.data_len =3D cpu_to_le32(8 + 8 + 4);
> -		header.file_offset =3D 0;
> +		header->data_len =3D cpu_to_le32(8 + 8 + 4);

The same problem of understanding here for me. What this hardcoded 8 +
8 + 4 value means? :)

> +		header->file_offset =3D 0;
> =C2=A0		ret =3D 0;
> =C2=A0	} else {
> -		header.data_len =3D cpu_to_le32(8 + 8 + 4 +
> CEPH_FSCRYPT_BLOCK_SIZE);
> -		header.file_offset =3D cpu_to_le64(orig_pos);
> +		header->data_len =3D cpu_to_le32(8 + 8 + 4 +
> CEPH_FSCRYPT_BLOCK_SIZE);

Ditto.

> +		header->file_offset =3D cpu_to_le64(orig_pos);
> =C2=A0
> =C2=A0		doutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_FSCRYPT_BLOCK_SIZE);
> =C2=A0
> =C2=A0		/* truncate and zero out the extra contents for the
> last block */
> -		memset(iov.iov_base + boff, 0, PAGE_SIZE - boff);
> +		p =3D kmap_ceph_databuf_page(dbuf, 1);

Maybe, we need to introduce some constants to address #0 and #1 pages?
Because, #0 it's header and I assume #1 is some content.

> +		memset(p + boff, 0, PAGE_SIZE - boff);
> +		kunmap_local(p);
> =C2=A0
> =C2=A0		/* encrypt the last block */
> -		ret =3D ceph_fscrypt_encrypt_block_inplace(inode,
> page,
> -						=C2=A0=C2=A0=C2=A0
> CEPH_FSCRYPT_BLOCK_SIZE,
> -						=C2=A0=C2=A0=C2=A0 0, block,
> -						=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +		ret =3D ceph_fscrypt_encrypt_block_inplace(
> +			inode, ceph_databuf_page(dbuf, 1),
> +			CEPH_FSCRYPT_BLOCK_SIZE, 0, block,
> GFP_KERNEL);
> =C2=A0		if (ret)
> =C2=A0			goto out;
> =C2=A0	}
> =C2=A0
> -	/* Insert the header */
> -	ret =3D ceph_pagelist_append(pagelist, &header,
> sizeof(header));
> -	if (ret)
> -		goto out;
> +	ceph_databuf_added_data(dbuf, sizeof(*header));
> +	if (header->block_size)
> +		ceph_databuf_added_data(dbuf,
> CEPH_FSCRYPT_BLOCK_SIZE);
> =C2=A0
> -	if (header.block_size) {
> -		/* Append the last block contents to pagelist */
> -		ret =3D ceph_pagelist_append(pagelist, iov.iov_base,
> -					=C2=A0=C2=A0 CEPH_FSCRYPT_BLOCK_SIZE);
> -		if (ret)
> -			goto out;
> -	}
> -	req->r_pagelist =3D pagelist;
> +	req->r_dbuf =3D dbuf;
> =C2=A0out:
> =C2=A0	doutc(cl, "%p %llx.%llx size dropping cap refs on %s\n",
> inode,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), ceph_cap_string(=
got));
> =C2=A0	ceph_put_cap_refs(ci, got);
> -	if (iov.iov_base)
> -		kunmap_local(iov.iov_base);
> -	if (page)
> -		__free_pages(page, 0);
> -	if (ret && pagelist)
> -		ceph_pagelist_release(pagelist);
> +	kunmap_local(header);
> +	if (ret)
> +		ceph_databuf_release(dbuf);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 230e0c3f341f..09661a34f287 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1125,8 +1125,7 @@ void ceph_mdsc_release_request(struct kref
> *kref)
> =C2=A0	put_cred(req->r_cred);
> =C2=A0	if (req->r_mnt_idmap)
> =C2=A0		mnt_idmap_put(req->r_mnt_idmap);
> -	if (req->r_pagelist)
> -		ceph_pagelist_release(req->r_pagelist);
> +	ceph_databuf_release(req->r_dbuf);
> =C2=A0	kfree(req->r_fscrypt_auth);
> =C2=A0	kfree(req->r_altname);
> =C2=A0	put_request_session(req);
> @@ -3207,10 +3206,10 @@ static struct ceph_msg
> *create_request_message(struct ceph_mds_session *session,
> =C2=A0	msg->front.iov_len =3D p - msg->front.iov_base;
> =C2=A0	msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
> =C2=A0
> -	if (req->r_pagelist) {
> -		struct ceph_pagelist *pagelist =3D req->r_pagelist;
> -		ceph_msg_data_add_pagelist(msg, pagelist);
> -		msg->hdr.data_len =3D cpu_to_le32(pagelist->length);
> +	if (req->r_dbuf) {
> +		struct ceph_databuf *dbuf =3D req->r_dbuf;
> +		ceph_msg_data_add_databuf(msg, dbuf);
> +		msg->hdr.data_len =3D
> cpu_to_le32(ceph_databuf_len(dbuf));
> =C2=A0	} else {
> =C2=A0		msg->hdr.data_len =3D 0;
> =C2=A0	}
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 3e2a6fa7c19a..a7ee8da07ce7 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -333,7 +333,7 @@ struct ceph_mds_request {
> =C2=A0	u32 r_direct_hash;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* choose dir fra=
g based on this
> dentry hash */
> =C2=A0
> =C2=A0	/* data payload is used for xattr ops */
> -	struct ceph_pagelist *r_pagelist;
> +	struct ceph_databuf *r_dbuf;
> =C2=A0
> =C2=A0	/* what caps shall we drop? */
> =C2=A0	int r_inode_drop, r_inode_unless;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index bb0db0cc8003..984a6d2a5378 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1137,7 +1137,7 @@ struct ceph_acl_sec_ctx {
> =C2=A0#ifdef CONFIG_FS_ENCRYPTION
> =C2=A0	struct ceph_fscrypt_auth *fscrypt_auth;
> =C2=A0#endif
> -	struct ceph_pagelist *pagelist;
> +	struct ceph_databuf *dbuf;
> =C2=A0};
> =C2=A0
> =C2=A0#ifdef CONFIG_SECURITY
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 537165db4519..b083cd3b3974 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1114,17 +1114,17 @@ static int ceph_sync_setxattr(struct inode
> *inode, const char *name,
> =C2=A0	struct ceph_mds_request *req;
> =C2=A0	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> =C2=A0	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
> -	struct ceph_pagelist *pagelist =3D NULL;
> +	struct ceph_databuf *dbuf =3D NULL;
> =C2=A0	int op =3D CEPH_MDS_OP_SETXATTR;
> =C2=A0	int err;
> =C2=A0
> =C2=A0	if (size > 0) {
> -		/* copy value into pagelist */
> -		pagelist =3D ceph_pagelist_alloc(GFP_NOFS);
> -		if (!pagelist)
> +		/* copy value into dbuf */
> +		dbuf =3D ceph_databuf_req_alloc(1, size, GFP_NOFS);
> +		if (!dbuf)
> =C2=A0			return -ENOMEM;
> =C2=A0
> -		err =3D ceph_pagelist_append(pagelist, value, size);
> +		err =3D ceph_databuf_append(dbuf, value, size);
> =C2=A0		if (err)
> =C2=A0			goto out;
> =C2=A0	} else if (!value) {
> @@ -1154,8 +1154,8 @@ static int ceph_sync_setxattr(struct inode
> *inode, const char *name,
> =C2=A0		req->r_args.setxattr.flags =3D cpu_to_le32(flags);
> =C2=A0		req->r_args.setxattr.osdmap_epoch =3D
> =C2=A0			cpu_to_le32(osdc->osdmap->epoch);
> -		req->r_pagelist =3D pagelist;
> -		pagelist =3D NULL;
> +		req->r_dbuf =3D dbuf;
> +		dbuf =3D NULL;
> =C2=A0	}
> =C2=A0
> =C2=A0	req->r_inode =3D inode;
> @@ -1169,8 +1169,7 @@ static int ceph_sync_setxattr(struct inode
> *inode, const char *name,
> =C2=A0	doutc(cl, "xattr.ver (after): %lld\n", ci-
> >i_xattrs.version);
> =C2=A0
> =C2=A0out:
> -	if (pagelist)
> -		ceph_pagelist_release(pagelist);
> +	ceph_databuf_release(dbuf);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -1377,7 +1376,7 @@ bool ceph_security_xattr_deadlock(struct inode
> *in)
> =C2=A0int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
> =C2=A0			=C2=A0=C2=A0 struct ceph_acl_sec_ctx *as_ctx)
> =C2=A0{
> -	struct ceph_pagelist *pagelist =3D as_ctx->pagelist;
> +	struct ceph_databuf *dbuf =3D as_ctx->dbuf;
> =C2=A0	const char *name;
> =C2=A0	size_t name_len;
> =C2=A0	int err;
> @@ -1391,14 +1390,11 @@ int ceph_security_init_secctx(struct dentry
> *dentry, umode_t mode,
> =C2=A0	}
> =C2=A0
> =C2=A0	err =3D -ENOMEM;
> -	if (!pagelist) {
> -		pagelist =3D ceph_pagelist_alloc(GFP_KERNEL);
> -		if (!pagelist)
> +	if (!dbuf) {
> +		dbuf =3D ceph_databuf_req_alloc(0, PAGE_SIZE,
> GFP_KERNEL);
> +		if (!dbuf)
> =C2=A0			goto out;
> -		err =3D ceph_pagelist_reserve(pagelist, PAGE_SIZE);
> -		if (err)
> -			goto out;
> -		ceph_pagelist_encode_32(pagelist, 1);
> +		ceph_databuf_encode_32(dbuf, 1);
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> @@ -1407,38 +1403,31 @@ int ceph_security_init_secctx(struct dentry
> *dentry, umode_t mode,
> =C2=A0	 * dentry_init_security hook.
> =C2=A0	 */
> =C2=A0	name_len =3D strlen(name);
> -	err =3D ceph_pagelist_reserve(pagelist,
> -				=C2=A0=C2=A0=C2=A0 4 * 2 + name_len + as_ctx-
> >lsmctx.len);
> +	err =3D ceph_databuf_reserve(dbuf, 4 * 2 + name_len + as_ctx-
> >lsmctx.len,
> +				=C2=A0=C2=A0 GFP_KERNEL);

The 4 * 2 + name_len + as_ctx->lsmctx.len looks unclear to me. It wil
be good to have some well defined constants here.

> =C2=A0	if (err)
> =C2=A0		goto out;
> =C2=A0
> -	if (as_ctx->pagelist) {
> +	if (as_ctx->dbuf) {
> =C2=A0		/* update count of KV pairs */
> -		BUG_ON(pagelist->length <=3D sizeof(__le32));
> -		if (list_is_singular(&pagelist->head)) {
> -			le32_add_cpu((__le32*)pagelist->mapped_tail,
> 1);
> -		} else {
> -			struct page *page =3D
> list_first_entry(&pagelist->head,
> -							=C2=A0=C2=A0=C2=A0=C2=A0 struct
> page, lru);
> -			void *addr =3D kmap_atomic(page);
> -			le32_add_cpu((__le32*)addr, 1);
> -			kunmap_atomic(addr);
> -		}
> +		BUG_ON(ceph_databuf_len(dbuf) <=3D sizeof(__le32));
> +		__le32 *addr =3D kmap_ceph_databuf_page(dbuf, 0);
> +		le32_add_cpu(addr, 1);
> +		kunmap_local(addr);
> =C2=A0	} else {
> -		as_ctx->pagelist =3D pagelist;
> +		as_ctx->dbuf =3D dbuf;
> =C2=A0	}
> =C2=A0
> -	ceph_pagelist_encode_32(pagelist, name_len);
> -	ceph_pagelist_append(pagelist, name, name_len);
> +	ceph_databuf_encode_32(dbuf, name_len);
> +	ceph_databuf_append(dbuf, name, name_len);
> =C2=A0
> -	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
> -	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 as_ctx->lsmctx.len);
> +	ceph_databuf_encode_32(dbuf, as_ctx->lsmctx.len);
> +	ceph_databuf_append(dbuf, as_ctx->lsmctx.context, as_ctx-
> >lsmctx.len);
> =C2=A0
> =C2=A0	err =3D 0;
> =C2=A0out:
> -	if (pagelist && !as_ctx->pagelist)
> -		ceph_pagelist_release(pagelist);
> +	if (dbuf && !as_ctx->dbuf)
> +		ceph_databuf_release(dbuf);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0#endif /* CONFIG_CEPH_FS_SECURITY_LABEL */
> @@ -1456,8 +1445,7 @@ void ceph_release_acl_sec_ctx(struct
> ceph_acl_sec_ctx *as_ctx)
> =C2=A0#ifdef CONFIG_FS_ENCRYPTION
> =C2=A0	kfree(as_ctx->fscrypt_auth);
> =C2=A0#endif
> -	if (as_ctx->pagelist)
> -		ceph_pagelist_release(as_ctx->pagelist);
> +	ceph_databuf_release(as_ctx->dbuf);
> =C2=A0}
> =C2=A0
> =C2=A0/*
>=20

Thanks,
Slava.


