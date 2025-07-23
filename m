Return-Path: <linux-fsdevel+bounces-55912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01BFB0FD42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3189681C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990926D4EF;
	Wed, 23 Jul 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl/B8NRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93305111BF;
	Wed, 23 Jul 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312802; cv=none; b=FvPD0tRVo+FVTAGBDZmhFGmOpOO4S8caT3bYpe60Pc7ytWsScKTWtHQO3rETtl2GJz557hAFy7Ti1uksHQ0RPnHEsbHK9GyG9Gh4a6WFbShgb0giaG0BMpTghkca4lwr2dlUHKw8ytDel7CsQ7XviROOemJjS+/QQ+ZAyTSMxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312802; c=relaxed/simple;
	bh=xz3SCdYArmCgq4jlaMS7xwpbTnpvdfXY4z3+utwpCWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0pTgRmiK4c8zSXvKESI0Qgh5wsYrz30LTnGlP4X/bgpAP/7Nh7ubdnQInv2MKlFH2wuHDYd4qmUZQeAXu4Wj0yAkhdAEEshYwLpvkjQWHqoHmZirLudZAjobUH/Y2K9X38c6wq1Uc8bo5D0ccHueFVsXSN+RhSDDP3YxpeTdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl/B8NRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D36C4CEEF;
	Wed, 23 Jul 2025 23:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312802;
	bh=xz3SCdYArmCgq4jlaMS7xwpbTnpvdfXY4z3+utwpCWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xl/B8NRWKQ2fwl4L51YHeNMG5t7GbHqkjYGm6I5z71rlfNwfEAqElnDTjwyTkX3xC
	 y/w4v0POkpQUw5ab2NaKSocdFnuhsf0f6gs7B18Pg273vLsjduHQz8H3jqDoj9MDoh
	 zvBQq3zbB1kFX7uz/2yoq7WNm25YdMnWqadbge5ax4aNRzbf4yUMptp9oph1u5h63b
	 yqV8nASq+H2xgpaLEM6/XCWJ/PzZhstgZewwHljUO29hCAJYnl827a04X9Y9d09YAz
	 mknXs7HvDH92ZrCPpDNQwXTi9HV33Jk01mQbKaKs2jxHBAPcu6VpVRR52mcb1ZDU8o
	 euduJ1/YZoQcg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so63866866b.3;
        Wed, 23 Jul 2025 16:20:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMB0wKCFqvw+Utkxjb0K8KdJwgw3/mlfuCOE2meEa49UB7UaVn/xqW51wYcOPQW6Y8KBtP3T+Nc6vJtTbdzw==@vger.kernel.org, AJvYcCVreHtLCxLxyPpxFUaCRHVG+GAC4OuQfWjg2ey7EJG/3Q4Ii7FKw5JI9Bd30ZtW6jcpGT6DRe9DEvdB@vger.kernel.org, AJvYcCWkTwq++cOCKJ59nmrRJo8NPZ2jk6AfflL8TWihH4L3fEIL0dZJtPho+PFgRNkgovAScRrIfox3SARJkpQ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4g7bkk9wKQ+uitDX7bvnWNSXlxJ8xIizG/WQl8q8wcGn7Abp7
	HChvygFsfQHNds1g8WVIoithANX3A3ktB6K2ErKg1y9ci+l5IQ+ZDGKhVCyrvGU2k+T7Z/0CA2M
	i5jPSb2BMhl5dwmxQkLHFXvK2Ue4RbqQ=
X-Google-Smtp-Source: AGHT+IFoA9riQGNTIBDVXbIV9GPqC5eg9LjgBJz/bsYhFEgKgA/j1vQGQFSok4b6j8j4HtNG497FHj1Ylrq6wCe++iI=
X-Received: by 2002:a17:907:9494:b0:ae3:e378:159e with SMTP id
 a640c23a62f3a-af2f7475defmr432412866b.26.1753312801072; Wed, 23 Jul 2025
 16:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8ae2444f-e33e-4d78-9349-429b32f129d5@samba.org> <175331183374.2234665.16356100340389738205@noble.neil.brown.name>
In-Reply-To: <175331183374.2234665.16356100340389738205@noble.neil.brown.name>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 24 Jul 2025 08:19:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0kqhD9mYNxO_m8NzN4N=s2ReMrMNJxys89DQ_1uo+fQ@mail.gmail.com>
X-Gm-Features: Ac12FXzCZTA9mUrC76URH0EdJ2hZg6tovlY3jXHYWDpnc2IlOJejnk4lFohG6pM
Message-ID: <CAKYAXd_0kqhD9mYNxO_m8NzN4N=s2ReMrMNJxys89DQ_1uo+fQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
To: NeilBrown <neil@brown.name>
Cc: Stefan Metzmacher <metze@samba.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:04=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Thu, 24 Jul 2025, Stefan Metzmacher wrote:
> > Hi Neil,
> >
> > for me this reliable generates the following problem, just doing a simp=
le:
> > mount -t cifs -ousername=3Droot,password=3Dtest,noperm,vers=3D3.1.1,mfs=
ymlinks,actimeo=3D0 //172.31.9.167/test /mnt/test/
> >
> > [ 2213.234061] [   T1972] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [ 2213.234607] [   T1972] BUG: KASAN: slab-use-after-free in lookup_nop=
erm_common+0x237/0x2b0
>
> Hi,
>  thanks for testing and reporting.  Sorry about this obvious bug...
>
> I called putname() too early.  The following should fix it.  Please test
> and support.
> Namjae: it would be good to squash this into the offending patch before
> submitting upstream.  Can you do that?  Do you want me to resend the
> whole patch?
You don't need to resend the patch. I will directly update and test it.
Thanks!

>
> Thanks,
> NeilBrown
>
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -53,7 +53,7 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_con=
fig *share_conf,
>                                  struct path *path, bool do_lock)
>  {
>         struct qstr last;
> -       struct filename *filename;
> +       struct filename *filename __free(putname) =3D NULL;
>         struct path *root_share_path =3D &share_conf->vfs_path;
>         int err, type;
>         struct dentry *d;
> @@ -72,7 +72,6 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_con=
fig *share_conf,
>         err =3D vfs_path_parent_lookup(filename, flags,
>                                      path, &last, &type,
>                                      root_share_path);
> -       putname(filename);
>         if (err)
>                 return err;
>
>

