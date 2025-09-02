Return-Path: <linux-fsdevel+bounces-60009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465AB40D26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6552A7B0D20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BC345723;
	Tue,  2 Sep 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSFYMinh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC089241667
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837823; cv=none; b=LFcDJ3ND6DQ34bmVgDt9zN4kU1YzGIUaJQAdz+LJ+bAhBIXdoPbE+TAhFkvERieqAFNkCzreziJn5hOtpUub4ckyLPemJdxR7JcWbrxLXTWHHV075XYa43ScTZm/JfMD3c7Df9eYzN9jwZLoXsYbLzBxng9Q4fx15Us187uYNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837823; c=relaxed/simple;
	bh=+0tt49eVwvG3+vc1xqkrbIEGZjh+UC/EVvjV8R/C7mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrfoEEizzE5ogY/3vJoUZJyZyzazpaJI2ecegfsN4g6redf3GfLz2alfXWpLXZ/zpDrZh3YsOju8sOj8NN9LTfLWgN/4wEGFIzjbJlCgdqKbJFAHO9WO/zuggbT1emipQZH2iLHYpZxzKhCSPmDEpH2ZSZoEVdArfGxkipv+Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSFYMinh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASDF7zCsUE8NxaMptPS0zZPS3DJLq2joyWFZFJ6zTCo=;
	b=LSFYMinhOybACejW3PsUtQurasDc1jEYiYvEl7kKF+iHECLfjnAchnsyfhaGe4Jc0c5kNP
	o3eGlGIxoJW8Gjf9AYkB3frKfNz/deXO8r6VKL8hduJQs1hBdoY2/EGrn9rHxCo/W3w/2L
	ve53tSPsgfWQHDskEAzNmTOLz8lJ6wg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-gFSYNNtMP1uFB8GeSzpo7w-1; Tue, 02 Sep 2025 14:30:18 -0400
X-MC-Unique: gFSYNNtMP1uFB8GeSzpo7w-1
X-Mimecast-MFC-AGG-ID: gFSYNNtMP1uFB8GeSzpo7w_1756837817
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-722693d5a44so60149297b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 11:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837817; x=1757442617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASDF7zCsUE8NxaMptPS0zZPS3DJLq2joyWFZFJ6zTCo=;
        b=UeD7T+7K3JCvjvST1RWk/gfhi1HI5ge1YftXrpKJmgSoQicE8g+kVHbQqmMx2NZnGJ
         yHLM/ks8GLAKsOJaAC8Vjd0uSEQ4f2azd8fbcoilJfhU+QD7fGGC+Fx/zFt5nD2XjX0B
         RKSIy6UE+gtsamnhFQpJR9LjZGICmcJ9Iq1nHrhB060qZqfilSjm0bGWSBpi9WWGFxm6
         pJ63k+mk3f3J0RxUKfTOxVCUNBThxP9w2J2is+aFREHA1+PvcT3N0dvX/YYwBiR2y6yK
         hvyAz10/GUPgjQcNkRcz+0yTDjzssvN5B9dDy/9+L4v94dUo0R+H4Dq0h/YO/XlZ7uhr
         9hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDaXxoZxswK5skcZ6+6j+8S3qumMgWjkiALSfOkbZvz+65RuYIzXruoGR86KJtQ14IUA572l6iOXG+UM0K@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFqrXxg8DPOHceFLKtizWGfmKXOo19PofHGCCo8kUOPr1sig1
	ivTocwtLkhHgFOPHKDiZNR85YUDP8tHtlDFt8L24kEnj7ByuFZHRYVVR4omOpSs1CROQNOW6jLG
	T8TJ/ilP1rKUyMOKtam4PhXJOQIUzuAPc7nK4ugXin2mFzb+CZWIOJiY/0FtLjTInKV9CTV+znD
	Milw==
X-Gm-Gg: ASbGncvjJ8UgKikiNWzSadE63lW+Vxl0n5dlnDV9R93Nzkx987dQjE10XChbDjm8gqk
	9ylVLalk5pJxPWmredW9OqCwCg3lF/qFN4ibZfCRSCzdbqsW4DR4qup6U8lAGgJJ6V9QqMEnTeS
	q+uk6+7kzGXxrvpZs3o2qfFa6aASwWy4vF6rs4bMoQpp1Or9WSEPwKxJWWECGz8ZGqfaQ/37X4+
	21/XpF/BtOJphkh8Jk1T5g2FzxhBbN6y3IVmf7sxGhGIuAUFFHn9k8+p2gxrK7sjNxFPY8TOmB+
	fktuaWUthbpf5XJQdjyyXPioiWYvE3bPNLaJ9ACNQitr0sKGbgawFL6gWjBDhs9P5yX+
X-Received: by 2002:a05:690c:4b03:b0:71c:7eb:3556 with SMTP id 00721157ae682-722763b0ae9mr141069407b3.15.1756837816837;
        Tue, 02 Sep 2025 11:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE31gZtLpBFU/GPsABT/hXbcuHGun2+lZcXyD/fpbEthrTXT8BKSP2Z/St0jr6rloAmkCn1Ag==
X-Received: by 2002:a05:690c:4b03:b0:71c:7eb:3556 with SMTP id 00721157ae682-722763b0ae9mr141068547b3.15.1756837815863;
        Tue, 02 Sep 2025 11:30:15 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8502985sm7142207b3.40.2025.09.02.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:30:15 -0700 (PDT)
Message-ID: <375e4fa284edbe24ba0ea49c908b3cd780233410.camel@redhat.com>
Subject: Re: [PATCH] ceph: cleanup in ceph_alloc_readdir_reply_buffer()
From: vdubeyko@redhat.com
To: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com
Date: Tue, 02 Sep 2025 11:30:14 -0700
In-Reply-To: <CAO8a2ShN_=0dkgfWcRB3=q+C9o2hBONCQS1Os4ubG-NhsBhJ1w@mail.gmail.com>
References: <20250829212859.93312-2-slava@dubeyko.com>
	 <CAO8a2ShN_=0dkgfWcRB3=q+C9o2hBONCQS1Os4ubG-NhsBhJ1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 18:30 +0300, Alex Markuze wrote:
> Lets add unlikely to these checks.
>=20

Makes sense. Let me rework the patch.

Thanks,
Slava.

> On Sat, Aug 30, 2025 at 12:29=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyk=
o.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The Coverity Scan service has reported potential issue
> > in ceph_alloc_readdir_reply_buffer() [1]. If order could
> > be negative one, then it expects the issue in the logic:
> >=20
> > num_entries =3D (PAGE_SIZE << order) / size;
> >=20
> > Technically speaking, this logic [2] should prevent from
> > making the order variable negative:
> >=20
> > if (!rinfo->dir_entries)
> >     return -ENOMEM;
> >=20
> > However, the allocation logic requires some cleanup.
> > This patch makes sure that calculated bytes count
> > will never exceed ULONG_MAX before get_order()
> > calculation. And it adds the checking of order
> > variable on negative value to guarantee that second
> > half of the function's code will never operate by
> > negative value of order variable even if something
> > will be wrong or to be changed in the first half of
> > the function's logic.
> >=20
> > [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selected=
Issue=3D1198252
> > [2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/mds_clien=
t.c#L2553
> >=20
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 0f497c39ff82..d783326d6183 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2532,6 +2532,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_m=
ds_request *req,
> >         struct ceph_mount_options *opt =3D req->r_mdsc->fsc->mount_opti=
ons;
> >         size_t size =3D sizeof(struct ceph_mds_reply_dir_entry);
> >         unsigned int num_entries;
> > +       u64 bytes_count;
> >         int order;
> >=20
> >         spin_lock(&ci->i_ceph_lock);
> > @@ -2540,7 +2541,11 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_=
mds_request *req,
> >         num_entries =3D max(num_entries, 1U);
> >         num_entries =3D min(num_entries, opt->max_readdir);
> >=20
> > -       order =3D get_order(size * num_entries);
> > +       bytes_count =3D (u64)size * num_entries;
> > +       if (bytes_count > ULONG_MAX)
> > +               bytes_count =3D ULONG_MAX;
> > +
> > +       order =3D get_order((unsigned long)bytes_count);
> >         while (order >=3D 0) {
> >                 rinfo->dir_entries =3D (void*)__get_free_pages(GFP_KERN=
EL |
> >                                                              __GFP_NOWA=
RN |
> > @@ -2550,7 +2555,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_m=
ds_request *req,
> >                         break;
> >                 order--;
> >         }
> > -       if (!rinfo->dir_entries)
> > +       if (!rinfo->dir_entries || order < 0)
> >                 return -ENOMEM;
> >=20
> >         num_entries =3D (PAGE_SIZE << order) / size;
> > --
> > 2.51.0
> >=20


