Return-Path: <linux-fsdevel+bounces-50444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DBACC447
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F583A3883
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2454223704;
	Tue,  3 Jun 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwovo1Yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E644A35
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946320; cv=none; b=OOzBohYCmkK2htPC8mZSMe+5lQEycHj9FTvRU6rRPBI9083KoZTHNi13d1CsBWSDKQK73ZvE9j9itsJPbCKEdYF/LlJLlgAqpBHTd8CwlgB8HO6odZFSHx58LUnuL2YR59lnx0dWFTNPYANWsVMDD2plMnrUSQFzTBqUYThTlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946320; c=relaxed/simple;
	bh=drpbWQc8/RPHHtUSS98p2acdiM3zdIzIfLg/W6cC+U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M52xBkGAPmHTNBCvaerOBQJO+vjBQNFKKLpuYty8jMBj4zFWpnIQlLr13Rs6cuZSY2cjULcb5okxQNrqrG2Wx0NelVJy/Vntvb36E6cXuWK1QTUAYVvG/agD/zTUaY89TBysXi4gjChVC5fwPUPai+DpJGQLNHV+nsLdemZ4ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zwovo1Yb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748946314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PoBry0tKpbA2i7zoepvlEvbKF+ynCdobMnd4RArtEk=;
	b=Zwovo1YbwKp7kKX6HXivd+GuNU+edhh1r6JLd4sr4s/Om1g8wcv6C+YLexidfuQHPy+4E2
	22GmNiHA05SNr4j3Vqx3Tdqd8h8vdyuJkcRNEVMFHzVt/+WNVatHcQ13i6rbMPMNwRhIiM
	FfEzn7xNjFwjGD9gFmcn6dpWVraLTMI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-5VHs1SnEOQWo7P_Vv8u4BQ-1; Tue, 03 Jun 2025 06:25:13 -0400
X-MC-Unique: 5VHs1SnEOQWo7P_Vv8u4BQ-1
X-Mimecast-MFC-AGG-ID: 5VHs1SnEOQWo7P_Vv8u4BQ_1748946312
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-52f3b7d4f38so4127881e0c.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 03:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946312; x=1749551112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PoBry0tKpbA2i7zoepvlEvbKF+ynCdobMnd4RArtEk=;
        b=dJmRLTOB3ZiJzP2SNYr28Pql5QQh0fp1O+IGDDRCwr1eI+LxHY+Xeo7LxmEm/TRKIS
         JnJ/U4bcP94/Lik623gm6Tp/HL+itAcDS68bpKT3PwbR0/jTNlP3d6VqtIrM9vUFfvcC
         ozaBGSd3fDG2aBJHioQhkbY9HivlzQYyLoC8iIwycupt44t/wS5LlMaOsor2iLAvXE3x
         va/WRG4cYmB3lOae9ROXV6LW8zAp+l/ubBLdkFguEyolrTLIQlhWzS9S6owvcGnKKdLt
         9Zv8hJIb4WJ5pgGKmQ4Md8l2Wg5sWqK1aslXO5uBNldJ9bKzoH9vQtbUgVwFViOAZnxK
         Lrsg==
X-Forwarded-Encrypted: i=1; AJvYcCXDN4f4fu6gevmeZjV8ozgrSisOQnhejrNUxFTP07P8eEpVKuw6D7nl58C8aHCY8yetiEKFeb3eMb7ccVu+@vger.kernel.org
X-Gm-Message-State: AOJu0YypthPXS+Epv9Xr86hrOFCYmDKqV+6g+Ed2rMASxFwLCj/LOEP6
	QqA4dnXaXcdpcNHfI0V9f/TnVkC9JwBJL2+ifsTH7ZvXR7gWMapyu6GSIMwBQRi3kNBBB4JXaVg
	aJ1mgirnQ4ixMl5Ui++ueZKof4pdHORRFbp6UZtGKHyCCo+udE7GvigCu5Yq36p0z/V3xAa6bnv
	LKSuicAY7awt3AJ86bfX81LC4QkgvyhQE9LJhcaOg6qA==
X-Gm-Gg: ASbGncsO6CHWIhBUknwxmzYmly3+m6TcD/2P7QJ3wCVGh5fTBWFQ6JGOHi4ozKbtN9R
	BIv+UEtrH6iDVy3CRbp/9+brDhEPmsr4/RIb1/LpmTvuCq80zYdURWWFhprDQdCC98d0R
X-Received: by 2002:a05:6122:4690:b0:530:6955:1889 with SMTP id 71dfb90a1353d-53080f5835dmr11925970e0c.1.1748946312470;
        Tue, 03 Jun 2025 03:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaLv0Rul5zPwMMYP003yCD4PaDa+gcYWoZJEoc4T6DEUUELWsEYqO3OHENHlzdNx3AqF9p1NXtCgJpkZbpTuY=
X-Received: by 2002:a05:6122:4690:b0:530:6955:1889 with SMTP id
 71dfb90a1353d-53080f5835dmr11925955e0c.1.1748946312191; Tue, 03 Jun 2025
 03:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602184956.58865-1-slava@dubeyko.com>
In-Reply-To: <20250602184956.58865-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 3 Jun 2025 13:25:01 +0300
X-Gm-Features: AX0GCFu6ADoH-z_8jt1npgvjofdMj1rp6enEYpkeg1J0sV8yE530VuLqHJR_oMw
Message-ID: <CAO8a2SgsAQzOGCtejSka0JnvuzoespHDvwa0WNpg4A9L5QJcVA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix variable dereferenced before check in ceph_umount_begin()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, dan.carpenter@linaro.org, 
	lkp@intel.com, dhowells@redhat.com, brauner@kernel.org, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed by: Alex Markuze <amarkuze@redhat.com>

On Mon, Jun 2, 2025 at 9:50=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> smatch warnings:
> fs/ceph/super.c:1042 ceph_umount_begin() warn: variable dereferenced befo=
re check 'fsc' (see line 1041)
>
> vim +/fsc +1042 fs/ceph/super.c
>
> void ceph_umount_begin(struct super_block *sb)
> {
>         struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
>
>         doutc(fsc->client, "starting forced umount\n");
>               ^^^^^^^^^^^
> Dereferenced
>
>         if (!fsc)
>             ^^^^
> Checked too late.
>
>                 return;
>         fsc->mount_state =3D CEPH_MOUNT_SHUTDOWN;
>         __ceph_umount_begin(fsc);
> }
>
> The VFS guarantees that the superblock is still
> alive when it calls into ceph via ->umount_begin().
> Finally, we don't need to check the fsc and
> it should be valid. This patch simply removes
> the fsc check.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kerne=
l.org_r_202503280852.YDB3pxUY-2Dlkp-40intel.com_&d=3DDwIBAg&c=3DBSDicqBQBDj=
DI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DUd7uNdqBY_Z=
7LJ_oI4fwdhvxOYt_5Q58tpkMQgDWhV3199_TCnINFU28Esc0BaAH&s=3DQOKWZ9HKLyd6XCxW-=
AUoKiFFg9roId6LOM01202zAk0&e=3D
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index f3951253e393..68a6d434093f 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1033,8 +1033,7 @@ void ceph_umount_begin(struct super_block *sb)
>         struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
>
>         doutc(fsc->client, "starting forced umount\n");
> -       if (!fsc)
> -               return;
> +
>         fsc->mount_state =3D CEPH_MOUNT_SHUTDOWN;
>         __ceph_umount_begin(fsc);
>  }
> --
> 2.49.0
>


