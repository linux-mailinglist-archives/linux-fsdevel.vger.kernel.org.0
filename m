Return-Path: <linux-fsdevel+bounces-72687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6DCFFE77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19C133006726
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499832B996;
	Wed,  7 Jan 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx7DRgq0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRF5tVBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F463328FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816179; cv=none; b=j0RXOgLPdfMoDzOZ6HbG1wVxHQruY29hoBdbJbhX+tVCQdOt4T8yvvxZN3eHy4kS2c8sX+OPqYE6f/D1e6sZXA2nNy1cDJ5EL3GYwJKB+P3i2uFwvNRPBy1e1g6ItgnIELYyXMk7LkkMYGDj+SHFNR5JN2ZniUwkC+CAYQmCIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816179; c=relaxed/simple;
	bh=C56IoC/7pKu7IOe+bmIo3KG0TqDEmn/tNomGMdAluCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWtWUzsSk1ZBF2qVlnEg9/+mkNuhN4EkRjdm0HrqNuEjZYWIhuiVhwmh9WQJWkCw/uL8WtcpfoKThzDbiDRRP7toAsW6BGo/qypPLkDxgeVFo4KaHPkFwtnGFrvgMNvAgOGnt1OYE+0xdwBdePi6dyYgyDWkChzZjp6OaL/eH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx7DRgq0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRF5tVBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767816174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+APFi4DB1BEixYf1NERY7bmC13ljDpUozQin2rblQ=;
	b=fx7DRgq0aRftvVxmFO7vKuj1KsVZde4v1libfEZMdoD9L+gYzFLiODi1qbQTOWca2LTDbF
	Kd3yqWncnDze4xMKsAFm7ySOOKwdFQtoeCO3OV/8TJD/o1uom1QmR/FpINyok/ymYVQKx0
	lXpmn7fdSXgRtBgtFowNbGBfbwJ6K/Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-tFlDYg2PMkOvLxlizP2Yxg-1; Wed, 07 Jan 2026 15:02:53 -0500
X-MC-Unique: tFlDYg2PMkOvLxlizP2Yxg-1
X-Mimecast-MFC-AGG-ID: tFlDYg2PMkOvLxlizP2Yxg_1767816172
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78e602d09a7so27831457b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 12:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767816172; x=1768420972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iu+APFi4DB1BEixYf1NERY7bmC13ljDpUozQin2rblQ=;
        b=YRF5tVBf9i7M3G5iQCY/sPLkSHWaxqfgtZHG8OxXCLDNiRf2uHMROuL5CqDEiVHU2w
         c5WLUpgAZQtP/0Aft0cnGSHfWsTEJ5NADIgYAPMwYDio7aQR+iSwtQXOzzQXmIKlHu2C
         qmll2rAppmwYq6Smi+BjH91cYp7fYx/w28rRO1ESkHG04jCpbZUqaC0WxJgFjTUqAKga
         QzG81ANGW42MdRv9UUNnDSTbJeFU/06DUzysqWRbCz+R2NjgAH0UFQEp2MF6am+xAaQp
         0t8phTolrASVZMQx2X8tczyqD6LmGTzrW8zHsyeGqnbUMLMoWPhTDWMtQx1voGAyKkdJ
         +09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767816172; x=1768420972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu+APFi4DB1BEixYf1NERY7bmC13ljDpUozQin2rblQ=;
        b=w04wc6N9luhBtue8kSUFYaPd6gKDRXysSyn/w2DzzpfaLD2xyymo2xSHpJ+3OzhXzq
         rHZ3veI9boi9JMyZDEVj0J4d7CaeVkWJdMbaLOAhWygvtYnvPv+NVCQPid1/WWBA+AQr
         OpuZQp/dra4JP7FwjQxwIn1y4s9tbFdf7UFo9b/+GWiFbKix5dXM9e6gnGB41BWKN2cD
         gUdWetHzSoYW+UWtke2vTxBLoXspAkW671JAQ1Dw14Etq9/BDvJeH4ypr4BNFowlBlWu
         MCbx5NA5baxQgRAcqXA8IpaxgjLVUDgIFupPgHXhqt4zCJAmTkEIFoEZPK64PoRJkBFa
         El/g==
X-Forwarded-Encrypted: i=1; AJvYcCXh/jLZ76VtiXdidHpQzBYGeVA/cuf7n/CEfuLThul7Gt7bjLG9h5AflVc0KERgPiL4CGaHANCGQ+doPxyj@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC+U1QYN6zM+LiwGYd8eJHp8OAvpQCiW1f3VSd7SDXGJdlOCi
	nqYN4PtxG+UMwRhiGWAJAL27xctQ1J/BeE+ZWQun5fNoFPuYrj93Zay4OhGEFjMk2s8gk+ihZTZ
	ZhJxOFM4XUG8R5G9Sv+/cXnjrzcbHOM1xGaIq3LRHYrbTybfX5MUgT+5l5uV3aeffwo8=
X-Gm-Gg: AY/fxX43Ugp5eeUKOCcGCS59zfq6HPUYLLslUtavefC79P8HHvdhVJ+YJ1drbVVtCxy
	fsI7rH/ujadKGdYMLR4iGR1XHC8Y66Q7RoEtW/PsaWuPlzMvVu1JhhPq1x0bu62MUSNTucJ2As+
	DwZHSzEzm7NUuWEJnUd+6S/TiRmWq285dzzKOotpzi/rpFKVJz6lDVqOJIgRZAwJ+d9mNhWPIGb
	ozyHOJTRwjqk+iAVO+Dtgb24sHMieToKH5HcxbjU0xe8qvCvIjZ1M2L25kV5xvfXHB9zhoVn+oh
	X59JU4dj2wDWaLfymPBLyCN3TwNoJCl0+DBUWisJQogeBY+H653kR1zftKDOmfvjCf+wZQleZZ2
	M29nsalFetGwpfeChk8DRrWeGacbAIqyTs+mJz7lb
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186697b3.41.1767816172488;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFtanv8xfnFTTRT6tEbrRIY8LovgzhbuRiJibqFx8Wg+Ad59na27viUk0nz6iFz80kLE3f9Q==
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186317b3.41.1767816172118;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa5534f2sm22153297b3.10.2026.01.07.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:02:51 -0800 (PST)
Message-ID: <591f69efdf89ba02c36b042faa3486eca0cec76d.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH 5/6] ceph: don't allow delegations to be set
 on directories
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Steve French <sfrench@samba.org>,  Paulo Alcantara	
 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov	 <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li	 <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede	 <hansg@kernel.org>,
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed, 07 Jan 2026 12:02:49 -0800
In-Reply-To: <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
	 <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 09:20 -0500, Jeff Layton wrote:
> With the advent of directory leases, it's necessary to set the
> ->setlease() handler in directory file_operations to properly deny them.
>=20
> Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease=
 handlers")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..804588524cd570078ba59bf38=
d2460950ca67daf 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -2214,6 +2214,7 @@ const struct file_operations ceph_dir_fops =3D {
>  	.fsync =3D ceph_fsync,
>  	.lock =3D ceph_lock,
>  	.flock =3D ceph_flock,
> +	.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct file_operations ceph_snapdir_fops =3D {
> @@ -2221,6 +2222,7 @@ const struct file_operations ceph_snapdir_fops =3D =
{
>  	.llseek =3D ceph_dir_llseek,
>  	.open =3D ceph_open,
>  	.release =3D ceph_release,
> +	.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct inode_operations ceph_dir_iops =3D {

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


