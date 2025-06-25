Return-Path: <linux-fsdevel+bounces-52886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56268AE7FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9577A882A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB582BEFFB;
	Wed, 25 Jun 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1qHsj8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BB29E0EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847843; cv=none; b=ElYmA+8fHwgHiV2Y5XomjtFnqz7gywfeq5k4OYU99CfKHMLHDf4egOZ6dvc/Dy+E6ITJIhApBqfh9xmK8yqPdCUC+M/ZXO5KaPGoc2MErUTtLuPGWymAzi/DemxNODRgBoksJmIuBYUgm+zIUQi86PG2OcFo5MeQ1RlYH5DarjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847843; c=relaxed/simple;
	bh=RFjd235L7/G9kW2qDRezkDrJvYAmAVxhzg6JrL2fuBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4ERI0LafzWszJ+DOx+3BevRhoqiUMvAqwTA5XwQPZPArQ5FtR3n5KTERdZ09kKQ1iruafqn3tItITumZph2A8KEQrCvVycpvztgn6IQa4EcFT5ferORMxA1vsxNZ0Zp2lhLCC+8hkZNJ49Akfl81pYoX+B0z9Fn3YeWUBuATDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1qHsj8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750847840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/i6X5rNkwtkA0z3dVR9ep6Ga20RqSlPFLO6q4Jo+/c=;
	b=S1qHsj8BCH32mkssaISwTeQ2X+P9b0PcSL+9AghsO2v16RHc+PAo/oTl6NsNrfFsU8WGXe
	IPxg2hKFZ2Ivl7d0Ak7u5+Aqv3OlwVtVdQqMTvZwHDTkV0GM//G3EQKSK8GtSgAnrcEvXr
	MeyvKAp6htypQ2LHcOd/VXfTFvzL2WM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-cBoiV-v7MXyxHpSC04HX2Q-1; Wed, 25 Jun 2025 06:37:17 -0400
X-MC-Unique: cBoiV-v7MXyxHpSC04HX2Q-1
X-Mimecast-MFC-AGG-ID: cBoiV-v7MXyxHpSC04HX2Q_1750847837
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e98c14da9bso324804137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750847837; x=1751452637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/i6X5rNkwtkA0z3dVR9ep6Ga20RqSlPFLO6q4Jo+/c=;
        b=WIzzY9Vrn5p056l3MyfIuTst6za1/tlo7J5E9A610EitHkUyXztLjCCp/+gb+9X54u
         GyhsMHllhmGqb8BMrk1ZKfLDsBf6RqkMJMHEMbN045FOJT1piNuZntRC1FMPmADN6q/7
         MhpB8HaRhXfUXTQB9IRn+FCP0y9OgagiWnuIRnQgBchDUDlSFPqj2dT5z/aYrj8jZy1y
         hvfnrcCruiHdAVjPHDE1+ibt59zvq5bhMxqbPnbKyGQ9JYqq4MPdlF792TzJ6yzKmapP
         fWQl6Mqlj6noGRrFHv/o6piGsoFZZPEtazdZBAR3qzbQuFlJH0Co5JT/CDqx79MmRSOt
         A56Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1NmB5xZxKPT4AMDncotSLPDiZHFKgsPrjrrrrCGtu4SpztYZua4w6jJQ5ZZ2Ojjg/uoxM+FsvP3gF1khB@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoxVeqis2yFjOZKiWZHWEsSjLVJKN9yrymdaOmHXR6oc1Yfpc
	D0nhhkHm/Ss24utmg94MOXOf3qdvIjjdA4YJrDsrn2+Xoi6SWGg7IQD49pXLJhllNTJRHfJZGHX
	jpqVevfePB8Bu6kzWFGdP0KGbnNOXNfw83BgxGArFxjln9mljyXODKMA3xpEXdOty+fK9ImN3Ss
	R5GZpNjFFMitcwz07FZYzjHH/es7tOxWb6QUEhz5Z77Q==
X-Gm-Gg: ASbGncvSb0hx++ZHfXZI5x4inWrv6jUXdqq9jy4fEUQWFSMGJjhxXN4KSXhFMN8ybOA
	kDLNhw1uuOtP2R/BZgVdfA7d+a2CJKhKfwmSmsdg4f8Eh2/nUgLOQOPzh98+QKKaZCrC70F0YA0
	d3
X-Received: by 2002:a05:6102:c0a:b0:4e9:968b:4414 with SMTP id ada2fe7eead31-4ecc76b5e32mr1155764137.22.1750847836972;
        Wed, 25 Jun 2025 03:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjmoE/3Y+PAxOwo1N9Ubp8LCBIElRgF9CCRTyuKPdkdQMhC0WeUYbbn48B3y/Vk6EqzEU2KbbXj4tvlr3EqvQ=
X-Received: by 2002:a05:6102:c0a:b0:4e9:968b:4414 with SMTP id
 ada2fe7eead31-4ecc76b5e32mr1155756137.22.1750847836631; Wed, 25 Jun 2025
 03:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613183453.596900-1-slava@dubeyko.com>
In-Reply-To: <20250613183453.596900-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:37:06 +0300
X-Gm-Features: Ac12FXw8zPCUBCoR_LcSrwIyPH209rQ9V46iiLqHrxIn7kQRVzE_ZjitLYeAsrA
Message-ID: <CAO8a2SjLCq1ztLfYe7bPjhyDqAqX0AGBRdQ-cAuX7gzTrmm70g@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix potential race condition in ceph_ioctl_lazyio()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good work addressing the Coverity finding. The fix properly eliminates
the race condition by moving the check inside the lock.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Fri, Jun 13, 2025 at 9:35=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected potential
> race condition in ceph_ioctl_lazyio() [1].
>
> The CID 1591046 contains explanation: "Check of thread-shared
> field evades lock acquisition (LOCK_EVASION). Thread1 sets
> fmode to a new value. Now the two threads have an inconsistent
> view of fmode and updates to fields correlated with fmode
> may be lost. The data guarded by this critical section may
> be read while in an inconsistent state or modified by multiple
> racing threads. In ceph_ioctl_lazyio: Checking the value of
> a thread-shared field outside of a locked region to determine
> if a locked operation involving that thread shared field
> has completed. (CWE-543)".
>
> The patch places fi->fmode field access under ci->i_ceph_lock
> protection. Also, it introduces the is_file_already_lazy
> variable that is set under the lock and it is checked later
> out of scope of critical section.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1591046
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/ioctl.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index e861de3c79b9..60410cf27a34 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -246,21 +246,27 @@ static long ceph_ioctl_lazyio(struct file *file)
>         struct ceph_inode_info *ci =3D ceph_inode(inode);
>         struct ceph_mds_client *mdsc =3D ceph_inode_to_fs_client(inode)->=
mdsc;
>         struct ceph_client *cl =3D mdsc->fsc->client;
> +       bool is_file_already_lazy =3D false;
>
> +       spin_lock(&ci->i_ceph_lock);
>         if ((fi->fmode & CEPH_FILE_MODE_LAZY) =3D=3D 0) {
> -               spin_lock(&ci->i_ceph_lock);
>                 fi->fmode |=3D CEPH_FILE_MODE_LAZY;
>                 ci->i_nr_by_mode[ffs(CEPH_FILE_MODE_LAZY)]++;
>                 __ceph_touch_fmode(ci, mdsc, fi->fmode);
> -               spin_unlock(&ci->i_ceph_lock);
> +       } else
> +               is_file_already_lazy =3D true;
> +       spin_unlock(&ci->i_ceph_lock);
> +
> +       if (is_file_already_lazy) {
> +               doutc(cl, "file %p %p %llx.%llx already lazy\n", file, in=
ode,
> +                     ceph_vinop(inode));
> +       } else {
>                 doutc(cl, "file %p %p %llx.%llx marked lazy\n", file, ino=
de,
>                       ceph_vinop(inode));
>
>                 ceph_check_caps(ci, 0);
> -       } else {
> -               doutc(cl, "file %p %p %llx.%llx already lazy\n", file, in=
ode,
> -                     ceph_vinop(inode));
>         }
> +
>         return 0;
>  }
>
> --
> 2.49.0
>


