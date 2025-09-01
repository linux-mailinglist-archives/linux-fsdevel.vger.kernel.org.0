Return-Path: <linux-fsdevel+bounces-59886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02BAB3EB02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DAC486427
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F8320A1C;
	Mon,  1 Sep 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTMujD5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A932F74E
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740646; cv=none; b=r0TB4VUrhUZk9oFIXZ4iePhmxAfesNv9dzAKExdgpKWGFdRv6ndZa8H0v1nakomwosW+7s2SVUpclO/Qr+czMDdWZ99vudcT1oxxPyO/p1+kYW7oCxe9vGoRAkCMbAVYGCmedwubrGohhDOO3EjdVMtFoB+NtW0j1xdLojdEu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740646; c=relaxed/simple;
	bh=Re2eITSr7ZVkx0QHCPWi/VXYjH4F8wsmV4e9n/+XOIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TERqs4m0Mgenyj/PEajjbV/C3cjxGTrf8orUIDjN1DCRqfwoDBuKrDt23TMgSXDa0WQn7W7i2OhCbWHIs5zLpDmjNLuunkmZw5XqtlV1jhzZofCGSIJpY+uwwwZnrauFDYCLZUks5NCEjgrWvmUeIGIINsP+Auwa6eI0IVTyu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTMujD5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFVtiH5tJPj3x4omBecuNnUjGMgEywt57A5bHlfnCCc=;
	b=hTMujD5y7pc0Ihef9Jo+SfbfGDmA7VWt2gw11N90gfF89B0jHETb4pEQlhPuQH5Go2dTbX
	VEAGRUthvNsxk8wuKwyx0/al4NfjHEk6M8CQA6tmSzTFr9Y8x5k1KBtSjDrnOl9KVVMRaJ
	ocReBIlJ+ui2HegQcCbz2nGeSE04iF0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-L8yk4oMmMKqSg_DZl3XydQ-1; Mon, 01 Sep 2025 11:30:42 -0400
X-MC-Unique: L8yk4oMmMKqSg_DZl3XydQ-1
X-Mimecast-MFC-AGG-ID: L8yk4oMmMKqSg_DZl3XydQ_1756740642
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544a34689e7so703459e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740642; x=1757345442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFVtiH5tJPj3x4omBecuNnUjGMgEywt57A5bHlfnCCc=;
        b=W3MiwrRgikNzskJToMnv2gd2cXNolpp3xfY5RKEKxTEI6miXV8yP/LjJFDkH/Muqpe
         j2XWsmDUT8PLmwd2OvTgUBlJuSJAi3mzV3iFtoJfcbzDzGDc2ZdDY3g6FrcxYONjWuc2
         XEe+nBgsueOgIm0uxnAaWR19+q6iQ9cIbMbPzILLwlUfgsJIsDZDoRt1nQBpOobadwz9
         2o/E71cJoZuXHJ/h5PwTDIfU27gl/+pulUXnLYabVotoYpQiUza1Z4z1djxkURKL2uPi
         X/HLRvQ6Apwkjn17b/wrilQuStnIVAZYr1xkdEkwzEzRyfQH1OkY0DVl1M7Y5xHqqtwM
         FtCw==
X-Forwarded-Encrypted: i=1; AJvYcCVjS4wnDZSa4x7RNBxV1gaDhLlMEhV+Y3QPLvH9A+ARVg6XA9aONrTAPef4kZfwfD1v1XS2uLtYYkDgjhGb@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXOE6mdU+bBVbEBChKln6RYYsIzE6MCn6QAkGZIMzlbiFrcn/
	yY2ZBZsU8+U7jiMqpppJYyOnJa1l8u9qZ0J4IMRbL0uDjXvgki5hP/3fvObuhT6qbFfjKVpEQ02
	j6/Qrobr7iQID1yazic1Q6h0iOG81oCBYo8OQsNvNcACja0SkruAr314E2NM7Ib4/cga9nq9dcS
	31lBkwdM9ulBEeJOKzImvvrPXr2JocP9/GskdlyInqyH3TAg0CSBMdqPs=
X-Gm-Gg: ASbGncsMJlM5H7sOBD/Sc2nH3CMEbeQoZdc7+pbHOiL5wWO+LD1cvSiOAZO6OhF6a4/
	HMzkL2ndnyX7f4Jbu/ybITAXhtmYPccpuulQSIRyCr+Htrkmyy/WwQ08fjdYxeClkjmffbCWRk6
	1pkeRCAHbmIMsmCoVUi2uAlQ==
X-Received: by 2002:a05:6122:218d:b0:539:27eb:ca76 with SMTP id 71dfb90a1353d-544a01a030emr1953144e0c.5.1756740641834;
        Mon, 01 Sep 2025 08:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2obOmrFflqm4DjIkjGd3v1u5gJQ0yXbv+gIeZxPne66lD8cx7UQKZmQL0+dzVb84ZuEXfutjbQEC52niJcQE=
X-Received: by 2002:a05:6122:218d:b0:539:27eb:ca76 with SMTP id
 71dfb90a1353d-544a01a030emr1953133e0c.5.1756740641224; Mon, 01 Sep 2025
 08:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829212859.93312-2-slava@dubeyko.com>
In-Reply-To: <20250829212859.93312-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 1 Sep 2025 18:30:30 +0300
X-Gm-Features: Ac12FXzU7CJ6W_mQ5dHq10kMM003vyr--0dm2Rrx_KueJd3Zczk4CqNiInK04gs
Message-ID: <CAO8a2ShN_=0dkgfWcRB3=q+C9o2hBONCQS1Os4ubG-NhsBhJ1w@mail.gmail.com>
Subject: Re: [PATCH] ceph: cleanup in ceph_alloc_readdir_reply_buffer()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lets add unlikely to these checks.

On Sat, Aug 30, 2025 at 12:29=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has reported potential issue
> in ceph_alloc_readdir_reply_buffer() [1]. If order could
> be negative one, then it expects the issue in the logic:
>
> num_entries =3D (PAGE_SIZE << order) / size;
>
> Technically speaking, this logic [2] should prevent from
> making the order variable negative:
>
> if (!rinfo->dir_entries)
>     return -ENOMEM;
>
> However, the allocation logic requires some cleanup.
> This patch makes sure that calculated bytes count
> will never exceed ULONG_MAX before get_order()
> calculation. And it adds the checking of order
> variable on negative value to guarantee that second
> half of the function's code will never operate by
> negative value of order variable even if something
> will be wrong or to be changed in the first half of
> the function's logic.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1198252
> [2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/mds_client.=
c#L2553
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/mds_client.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 0f497c39ff82..d783326d6183 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2532,6 +2532,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds=
_request *req,
>         struct ceph_mount_options *opt =3D req->r_mdsc->fsc->mount_option=
s;
>         size_t size =3D sizeof(struct ceph_mds_reply_dir_entry);
>         unsigned int num_entries;
> +       u64 bytes_count;
>         int order;
>
>         spin_lock(&ci->i_ceph_lock);
> @@ -2540,7 +2541,11 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_md=
s_request *req,
>         num_entries =3D max(num_entries, 1U);
>         num_entries =3D min(num_entries, opt->max_readdir);
>
> -       order =3D get_order(size * num_entries);
> +       bytes_count =3D (u64)size * num_entries;
> +       if (bytes_count > ULONG_MAX)
> +               bytes_count =3D ULONG_MAX;
> +
> +       order =3D get_order((unsigned long)bytes_count);
>         while (order >=3D 0) {
>                 rinfo->dir_entries =3D (void*)__get_free_pages(GFP_KERNEL=
 |
>                                                              __GFP_NOWARN=
 |
> @@ -2550,7 +2555,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds=
_request *req,
>                         break;
>                 order--;
>         }
> -       if (!rinfo->dir_entries)
> +       if (!rinfo->dir_entries || order < 0)
>                 return -ENOMEM;
>
>         num_entries =3D (PAGE_SIZE << order) / size;
> --
> 2.51.0
>


