Return-Path: <linux-fsdevel+bounces-43092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B57CA4DDDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25A97ACC9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C271202C45;
	Tue,  4 Mar 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6EUwHyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA752010F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091173; cv=none; b=ugzi2v9pCZkiAebWwo4IKK7DkKDFf/4dwA9mGUudcth4V5WG6lRWayr92KuiSpsm61Jr5Yr7az11V6jxwjwL+/GOpNdTHzwLJaCnlG8iA47Alap11sytq9y/Q5K2c/K9gnhcymsCBH1Ye01yGxuwIDKVUBwgnGz4qX3ISlkNzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091173; c=relaxed/simple;
	bh=kYDNojtzVeBYeFX0FSbALMVfxUpg3XcCa74ud00h96U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op3vRkEJUXY/jOXxYCHbYiq5qvUYa8V5rzkM7y0WC86MtAKdPL2uEcglix+JEbGZGqp4c4c7n+pebkS2jKxAF2OxmP1TWigEpr4x7M1jG1mvGVeTK+vWvxhA6XMOz364YK7LiDspWBnSiKGxjNCqDmyamaO/VWIiE516g64GRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6EUwHyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741091170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpfTIYjR2fqGjFf5dQ50RUFTC3qMvYpGsNXcO8SeSqs=;
	b=c6EUwHyPShUU/1D+eUjx6l8i++J/wfUXIJfM/iHK1JbDpJgZlEo8Qg4jMPtoUCzQeKSe2s
	qkj9RDsn+IZvV6QmTfLx3F7HWgpDALNB9bujBWEsmSMK+u2zNs3U6uaBd8CAxcNpR3u0j5
	i1aGYJpaT7hihUuDHGAx2QNoJWd0yYs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-ahKCYah_Pt2ACEm7EhAYDw-1; Tue, 04 Mar 2025 07:26:04 -0500
X-MC-Unique: ahKCYah_Pt2ACEm7EhAYDw-1
X-Mimecast-MFC-AGG-ID: ahKCYah_Pt2ACEm7EhAYDw_1741091164
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-523942553f3so2406483e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 04:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741091164; x=1741695964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpfTIYjR2fqGjFf5dQ50RUFTC3qMvYpGsNXcO8SeSqs=;
        b=KWThtha9qBSwBDZdBJEDt1z5GfFiY6VM+sJTiMQmwUU2oUbfXv/FCVWby/FyK28ClQ
         3xsI79xe+APuC6nQLacj9K0MwlgCE5wYN0W2MDahxtqh1zQcvbG3az6QkEnKEAzToYOu
         IqAL1X8/4T4UnUlKuFxIk9DKvEAI5ODGMdbqBRknIYlAPWx2s6aSGHsVzRbFcI3DQk6E
         7qQQoGaj/T3CaPjMwBZs+E+84iWn8891loEgRZFA6H55WjCAC76FskLkTOkMzhGqzTAx
         0vfVBkiN9R7KzIXr6ZLhom2CfljwNg3GuDb3kqJpLUvlipXzNk3kGKs0U16GkYQTHmDR
         Hnfw==
X-Forwarded-Encrypted: i=1; AJvYcCXbJL1Dwd2jxpmd2SpWR1tN13MqMWfXOGp6GOfEHrmOU8hGs5/fVSgaFzZNzf3vgEGW/KFFjIFO6q9+3QdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZxNo4pnx5ploRuUkA7tdCRHuW+v+GRou4ybvBdFRljXY9ZsQ
	A18x6nhjWRZ4qL/9118YAdQv10EGlenynmS5WtcXRdWfTOyUzaUr1D5V2eSwbjMWmDQ46jyycbW
	N2fWQnoL0FEcgTqG0iXEVrlwi8fm0PYi9veFmdGO4oy7q2KNKkYsXpoYaxnTZkxqExHJav+M4Hb
	r1DkfnJ4+oMxFe07mcFVcVFbObWi884exYvyEwfZ2ceImt/Hmi
X-Gm-Gg: ASbGncvxkaPyu2BQvURmMEVRmvg4BVtdQphy2kpltpCJqfZPlqMhK9he6YacnSjhnfR
	a8ZAnRezvdQrc9tziml60KyQiL3JpmtToWZuIFnbcZFqSldw6yeUAjBi/db76sqOc1vAk/6wC
X-Received: by 2002:a05:6122:8cb:b0:520:61ee:c7f9 with SMTP id 71dfb90a1353d-5235b8bdff9mr11040219e0c.7.1741091163748;
        Tue, 04 Mar 2025 04:26:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDx6gb5PkgjLLCOLIzl90WqunTEE7EQsEwOsTsqYJiseyYhhjqfEqGPQUG/CKHdvbnbwPqBu6zfbyu6w6fgJ8=
X-Received: by 2002:a05:6122:8cb:b0:520:61ee:c7f9 with SMTP id
 71dfb90a1353d-5235b8bdff9mr11040213e0c.7.1741091163468; Tue, 04 Mar 2025
 04:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210230158.178252-1-slava@dubeyko.com>
In-Reply-To: <20250210230158.178252-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 4 Mar 2025 14:25:52 +0200
X-Gm-Features: AQ5f1JrKEQat7dUiIiUY01cOWoVYIvjvvDzSNqKlBBDzj9AmH1rjDWwazh-wGvQ
Message-ID: <CAO8a2SgEcLQyd0w3Rg3AOyZMN0nsFc7r78AWAxr9i9nvwZUnWw@mail.gmail.com>
Subject: Re: [PATCH] ceph: cleanup hardcoded constants of file handle size
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Tue, Feb 11, 2025 at 1:02=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The ceph/export.c contains very confusing logic of
> file handle size calculation based on hardcoded values.
> This patch makes the cleanup of this logic by means of
> introduction the named constants.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/export.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 150076ced937..b2f2af104679 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -33,12 +33,19 @@ struct ceph_nfs_snapfh {
>         u32 hash;
>  } __attribute__ ((packed));
>
> +#define BYTES_PER_U32          (sizeof(u32))
> +#define CEPH_FH_BASIC_SIZE \
> +       (sizeof(struct ceph_nfs_fh) / BYTES_PER_U32)
> +#define CEPH_FH_WITH_PARENT_SIZE \
> +       (sizeof(struct ceph_nfs_confh) / BYTES_PER_U32)
> +#define CEPH_FH_SNAPPED_INODE_SIZE \
> +       (sizeof(struct ceph_nfs_snapfh) / BYTES_PER_U32)
> +
>  static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_=
len,
>                               struct inode *parent_inode)
>  {
>         struct ceph_client *cl =3D ceph_inode_to_client(inode);
> -       static const int snap_handle_length =3D
> -               sizeof(struct ceph_nfs_snapfh) >> 2;
> +       static const int snap_handle_length =3D CEPH_FH_SNAPPED_INODE_SIZ=
E;
>         struct ceph_nfs_snapfh *sfh =3D (void *)rawfh;
>         u64 snapid =3D ceph_snap(inode);
>         int ret;
> @@ -88,10 +95,8 @@ static int ceph_encode_fh(struct inode *inode, u32 *ra=
wfh, int *max_len,
>                           struct inode *parent_inode)
>  {
>         struct ceph_client *cl =3D ceph_inode_to_client(inode);
> -       static const int handle_length =3D
> -               sizeof(struct ceph_nfs_fh) >> 2;
> -       static const int connected_handle_length =3D
> -               sizeof(struct ceph_nfs_confh) >> 2;
> +       static const int handle_length =3D CEPH_FH_BASIC_SIZE;
> +       static const int connected_handle_length =3D CEPH_FH_WITH_PARENT_=
SIZE;
>         int type;
>
>         if (ceph_snap(inode) !=3D CEPH_NOSNAP)
> @@ -308,7 +313,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_=
block *sb,
>         if (fh_type !=3D FILEID_INO32_GEN  &&
>             fh_type !=3D FILEID_INO32_GEN_PARENT)
>                 return NULL;
> -       if (fh_len < sizeof(*fh) / 4)
> +       if (fh_len < sizeof(*fh) / BYTES_PER_U32)
>                 return NULL;
>
>         doutc(fsc->client, "%llx\n", fh->ino);
> @@ -427,7 +432,7 @@ static struct dentry *ceph_fh_to_parent(struct super_=
block *sb,
>
>         if (fh_type !=3D FILEID_INO32_GEN_PARENT)
>                 return NULL;
> -       if (fh_len < sizeof(*cfh) / 4)
> +       if (fh_len < sizeof(*cfh) / BYTES_PER_U32)
>                 return NULL;
>
>         doutc(fsc->client, "%llx\n", cfh->parent_ino);
> --
> 2.48.0
>


