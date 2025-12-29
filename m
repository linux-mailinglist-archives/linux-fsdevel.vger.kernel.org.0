Return-Path: <linux-fsdevel+bounces-72207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24370CE81A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC92301586A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FF253B59;
	Mon, 29 Dec 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkIoV+lR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pNGxw8Y7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30724E4C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038871; cv=none; b=u87vZCESJzEfUyljmv7e9RSPYd2oSReUudy6pVUyDYK8lAKKXBuUH0CIbYyW0uZfgAFqvBZtRSqP4kG5T7nq0cPdah3hRIessPob3FztkC+aAWELYsrD5+/Yg+ptjt53QJrPYrSRVBWLv7nm0ThZ7D4noyTRCHw67V8/drgBeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038871; c=relaxed/simple;
	bh=/eFe5X/MiPQzCVRsOQR87ZwcRxHL+Xocet7VA0Yu+1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lddA/npJLkzUr4kT6ii4mXlMOFy3ky75VoX0gJj0ptFqBClF+EOYD+FUiig/4ayBc7XLZd3V+s5bz/65S1aeQyO0aYB8wx8tRNqVzIp1+L8rT5UFirh4/QUgA1CApmawV4aCrK9d1FJlrm/aHfpjo0VkAKhgxYD+gagAHKVpegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkIoV+lR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pNGxw8Y7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767038868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FANPnRx+d1+Aac+1y7bxs/DQO9wHzLZ4cKfY4uoxLLw=;
	b=EkIoV+lRmva5EWi1JcCbeVTC8OZIaQsUFUyJOsoDYFYJOdOTiDfHo+tmqKw4wF/I9llU/C
	xz8h6+hP641YGRD4gf788ELlLzlqCtLhOhh0f1nONHMOrWL28Cnx2OZEDb2iheplUnA8Ug
	ScSBAwseW6Z7yJKZbUa6gJ8pkvYP6po=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-sWtGaMB4Mz-E4VUL5puNhQ-1; Mon, 29 Dec 2025 15:07:47 -0500
X-MC-Unique: sWtGaMB4Mz-E4VUL5puNhQ-1
X-Mimecast-MFC-AGG-ID: sWtGaMB4Mz-E4VUL5puNhQ_1767038866
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64680de9f05so9717914d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767038866; x=1767643666; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FANPnRx+d1+Aac+1y7bxs/DQO9wHzLZ4cKfY4uoxLLw=;
        b=pNGxw8Y7ReKRE4AfVu/tVnh5+Ra5dmxdDO+QHpJ5I2PJ1cBRoioo1uZ5SsTqYjyvsC
         77YaIjr7cN8NQ6oFbXKyH1EC5xKowfy8Lx+Mdvzf/3470fMZCagvHSkEz1EoSB3UN20g
         Omgm47tzhuzzEMU2+WD1VIRCY7XdoR5MG3cptE9HzpwrgTZEombgl2cAiY+jZALWRVkv
         8MbqsiK1p3bklaWSnd3N4JNfUqFbGqPoSAsVIZ5DnlnErazTAIVmAd3GL+CCk5bKqxb3
         72L6Q6JiM1EI9MEI56sJgIo0qMUbeyIrhNaJo7fG6bgyt5ROtes5uiKZMicgRy9pAyw8
         Zwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767038866; x=1767643666;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FANPnRx+d1+Aac+1y7bxs/DQO9wHzLZ4cKfY4uoxLLw=;
        b=uYy07+oNnXBAW7n0A4OGSiyVPB7gQqUVnbWNya9C74MpYhQ8YgV0LQbc+8nsFaY6Hv
         W9TQQtnOs/ar6pivIzVz3ptfKdu+qX9DqOBQW9hIdeZO0NpHYgqOMkT62vYC4JcLZ46D
         mIJvuCFM//P2U//SoBYhmrFWAe0pJZIW43pYNnm3vHbZsmLz5X2a2tsAPMoIYmhhhCFB
         zTz4nrEjvFZIDnk9+hWndDwhPOOW9dyRTl1DWi0hVKEpk8m+ecRNV+RG+ouN/AE17JK1
         fIscJ8GaJgvLYKMD9wxwiZ/NPDAjftDcut5cXhNShNa+ZuJEeGe/5L9N93WrD8uqvM3R
         vvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2odBoQYo8g2xgn3EQgjAOSFA1/hzfm1wGDIMOrvBtmxZy627v7yMU5dHy7GNUEtgD2UUy4/GnuNM5iElh@vger.kernel.org
X-Gm-Message-State: AOJu0YxAn5dR7NUVilnrWaDKKQbU/yOZAXT40cBsvzNi2lfdL5PE1PfU
	c/J8ri2C3k452lepMFNJkKdML4azD8o5uxTJ7YUgJrBL6O7nO3jgSpF15uZ6X5A88c7S2So7kBS
	8Vwbps/Z+wPAJXzNcXzIKfBn08Lhy/dT5MzTDCUNnnkI3QJLICKDLQcaJK5h+fry1Ot4=
X-Gm-Gg: AY/fxX60e01NMtjP9yLz0evsqKvliYGBdwcvvR/T2ow7exFKdP6k98foU7tJGCZ5yMJ
	TVe04eA9m+5OqE+nvtakLKRUVRNJtyYCMjSO4/na+RAAfG9rF+np+bdvbi2eKYisUy6dFKaOzwI
	uJy1JWzUQjR1Uc6sb2Ak1Zl1Mqz+qia2lM7YP34t/8H651u8d4z11rOvtSZLoNL8QZS7KUciZKf
	TQDSWVk+8yGNi711sWWHMdIsGeokwCIEKXJQQOlFkntsOl35+cyqFyyKjp7dB6HDprosG2fc4uC
	3aXG67k5YAo1cq/ryRiMTq+30ubOJFRKz4Im5pLxx150kKg/vF1x6XdtqwioNeA4L1AmEjOaRj3
	jX/OCXkF9AKdbQLRyNU2BpMY7/TKtMxvFv6czcN5Q
X-Received: by 2002:a05:690e:1248:b0:644:4259:9b64 with SMTP id 956f58d0204a3-6466a8a8827mr24430642d50.59.1767038866317;
        Mon, 29 Dec 2025 12:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcZmVkrs11EQ/RkKg5nsD4LQaHPLeWIPuDuOrOg8pt0bwiJ3+n1wbkbeIZhkYmKh2w4fmzXA==
X-Received: by 2002:a05:690e:1248:b0:644:4259:9b64 with SMTP id 956f58d0204a3-6466a8a8827mr24430616d50.59.1767038865784;
        Mon, 29 Dec 2025 12:07:45 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b1948sm15187905d50.5.2025.12.29.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 12:07:45 -0800 (PST)
Message-ID: <dbb256f3e770ea469fea2be7b42b6e5a43c2eccb.camel@redhat.com>
Subject: Re: [PATCH v4 2/3] ceph: parse subvolume_id from InodeStat v9 and
 store in inode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 29 Dec 2025 12:07:44 -0800
In-Reply-To: <20251223123510.796459-3-amarkuze@redhat.com>
References: <20251223123510.796459-1-amarkuze@redhat.com>
	 <20251223123510.796459-3-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 12:35 +0000, Alex Markuze wrote:
> Add support for parsing the subvolume_id field from InodeStat v9 and
> storing it in the inode for later use by subvolume metrics tracking.
>=20
> The subvolume_id identifies which CephFS subvolume an inode belongs to,
> enabling per-subvolume I/O metrics collection and reporting.
>=20
> This patch:
> - Adds subvolume_id field to struct ceph_mds_reply_info_in
> - Adds i_subvolume_id field to struct ceph_inode_info
> - Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
> - Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
> - Initializes i_subvolume_id in inode allocation and clears on destroy
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/inode.c      | 23 +++++++++++++++++++++++
>  fs/ceph/mds_client.c |  7 +++++++
>  fs/ceph/mds_client.h |  1 +
>  fs/ceph/super.h      |  2 ++
>  4 files changed, 33 insertions(+)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index a6e260d9e420..835049004047 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
> =20
>  	ci->i_max_bytes =3D 0;
>  	ci->i_max_files =3D 0;
> +	ci->i_subvolume_id =3D 0;

I still don't see the named constant here. It looks like the patch v3 4/4 w=
as
completely lost.

> =20
>  	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>  	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> @@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
> =20
>  	percpu_counter_dec(&mdsc->metric.total_inodes);
> =20
> +	ci->i_subvolume_id =3D 0;

Ditto.

> +
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	if (inode->i_state & I_PINNING_NETFS_WB)
> @@ -873,6 +876,22 @@ int ceph_fill_file_size(struct inode *inode, int iss=
ued,
>  	return queue_trunc;
>  }
> =20
> +/*
> + * Set the subvolume ID for an inode. Following the FUSE client conventi=
on,
> + * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume inod=
es).
> + */
> +void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
> +{
> +	struct ceph_inode_info *ci;
> +
> +	if (!inode || !subvolume_id)
> +		return;
> +
> +	ci =3D ceph_inode(inode);
> +	if (READ_ONCE(ci->i_subvolume_id) !=3D subvolume_id)
> +		WRITE_ONCE(ci->i_subvolume_id, subvolume_id);

The logic from patch v3 4/4 was completely lost.

> +}
> +
>  void ceph_fill_file_time(struct inode *inode, int issued,
>  			 u64 time_warp_seq, struct timespec64 *ctime,
>  			 struct timespec64 *mtime, struct timespec64 *atime)
> @@ -1087,6 +1106,7 @@ int ceph_fill_inode(struct inode *inode, struct pag=
e *locked_page,
>  	new_issued =3D ~issued & info_caps;
> =20
>  	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
> +	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
> =20
>  #ifdef CONFIG_FS_ENCRYPTION
>  	if (iinfo->fscrypt_auth_len &&
> @@ -1594,6 +1614,8 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  			goto done;
>  		}
>  		if (parent_dir) {
> +			ceph_inode_set_subvolume(parent_dir,
> +						 rinfo->diri.subvolume_id);
>  			err =3D ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
>  					      rinfo->dirfrag, session, -1,
>  					      &req->r_caps_reservation);
> @@ -1682,6 +1704,7 @@ int ceph_fill_trace(struct super_block *sb, struct =
ceph_mds_request *req)
>  		BUG_ON(!req->r_target_inode);
> =20
>  		in =3D req->r_target_inode;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  		err =3D ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
>  				NULL, session,
>  				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d7d8178e1f9a..099b8f22683b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -105,6 +105,8 @@ static int parse_reply_info_in(void **p, void *end,
>  	int err =3D 0;
>  	u8 struct_v =3D 0;
> =20
> +	info->subvolume_id =3D 0;

Ditto.

> +
>  	if (features =3D=3D (u64)-1) {
>  		u32 struct_len;
>  		u8 struct_compat;
> @@ -251,6 +253,10 @@ static int parse_reply_info_in(void **p, void *end,
>  			ceph_decode_skip_n(p, end, v8_struct_len, bad);
>  		}
> =20
> +		/* struct_v 9 added subvolume_id */
> +		if (struct_v >=3D 9)
> +			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */
> @@ -3970,6 +3976,7 @@ static void handle_reply(struct ceph_mds_session *s=
ession, struct ceph_msg *msg)
>  			goto out_err;
>  		}
>  		req->r_target_inode =3D in;
> +		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
>  	}
> =20
>  	mutex_lock(&session->s_mutex);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0428a5eaf28c..bd3690baa65c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
>  	u32 fscrypt_file_len;
>  	u64 rsnaps;
>  	u64 change_attr;
> +	u64 subvolume_id;
>  };
> =20
>  struct ceph_mds_reply_dir_entry {
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a1f781c46b41..c0372a725960 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -385,6 +385,7 @@ struct ceph_inode_info {
> =20
>  	/* quotas */
>  	u64 i_max_bytes, i_max_files;
> +	u64 i_subvolume_id;	/* 0 =3D unknown/unset, matches FUSE client */

Ditto.

Thanks,
Slava.

> =20
>  	s32 i_dir_pin;
> =20
> @@ -1057,6 +1058,7 @@ extern struct inode *ceph_get_inode(struct super_bl=
ock *sb,
>  extern struct inode *ceph_get_snapdir(struct inode *parent);
>  extern int ceph_fill_file_size(struct inode *inode, int issued,
>  			       u32 truncate_seq, u64 truncate_size, u64 size);
> +extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_=
id);
>  extern void ceph_fill_file_time(struct inode *inode, int issued,
>  				u64 time_warp_seq, struct timespec64 *ctime,
>  				struct timespec64 *mtime,


