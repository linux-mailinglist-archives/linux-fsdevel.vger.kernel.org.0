Return-Path: <linux-fsdevel+bounces-70597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704BCA1AB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 22:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7522B3002FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795BC2C1581;
	Wed,  3 Dec 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMe+nnuz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKlyBPHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B07DA66
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796995; cv=none; b=QpPgPLx3o+T4gKIyze6uS3EElVf5dbP0ZkCPvQrHIKpHua38wEdhE13Mv/xlf1IRweMSbGtbMub3wI7paZRj/gxHUjlgLNsCIgwnVlnvf8M4R4CnaeSXq4Z8ZRdSyo0OaRv1MsF8zkSyZJRguZe8vkhrLH1e5lYKEGJD7aEpzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796995; c=relaxed/simple;
	bh=PG/WNrudOdrF8wwMeRpn6H2LRLkwhzZDwEfVAg32SwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKtvWnuSjwKOruXazn6ZX8Rg9Gg9APQBUdN3bh+mEDDbx0g0VkZh6fnZxXxBsVAxKFFO65o5CyPid0bVBPIKKpKLdKXba4ZHdX5pWA8Cw1rot+HHGjmqcL3vuK2sr47fgZMVwV0QkvWaqJkGeDxv+CpAsJ/IMdizwjeAwD9UUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMe+nnuz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKlyBPHO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764796992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/l/KTu/HnV7nNudrLpofZvlkgentj2/IKmTB3+sXvY=;
	b=NMe+nnuzaLIaPY0qXBEy5+kAVIq8BvVQs1U9JhG0SrgH0juvWhet1JMFl+NYDzLp8y4gIx
	qGooy2+/MKX0wXsCEXHLQHa38FPhQrVz+XU/aIZJNQW5Tq5ODjDf3+Q2T4FczOb/3N3qPu
	ZkouCEh8k0LMMrddMnrcO1Kpkn5u8gU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-nxwN75CONW-jRK18JqnrvA-1; Wed, 03 Dec 2025 16:23:11 -0500
X-MC-Unique: nxwN75CONW-jRK18JqnrvA-1
X-Mimecast-MFC-AGG-ID: nxwN75CONW-jRK18JqnrvA_1764796991
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5dfaa434109so373776137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764796991; x=1765401791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/l/KTu/HnV7nNudrLpofZvlkgentj2/IKmTB3+sXvY=;
        b=cKlyBPHOvjCgJUwvMp6zOl9dxoJPEkA5CaYQURWw3RVKggPFVqw8GCmYh81NgqPef/
         8iNAJBEyU6k+vMbzComA9VdLqIdjVE65Quukr6V0iG/Jqstui/jet8G4P9j9kUGWElht
         0ZhSA1eYRJgVPQN5+B0IXGfT0p1WFNUytnG2KtP4WvWdyUlTiAfu99t2VpG48wRtT4su
         pIj2yC00Ni7UiwSTeBX7W9WSbqFm9n9/jxKG/FfsWA8jadMzepXJJp60oTIWkYp8HkuR
         Tg77CfgVmOphuZj/ajMYT63PDyN+f4o/676aHOQjkiObSTc5PZcAVi13f190KHZBZq5I
         ACEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796991; x=1765401791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/l/KTu/HnV7nNudrLpofZvlkgentj2/IKmTB3+sXvY=;
        b=mtgNTYOHviRU2631k8/ksqOOqfEbcct/Dwf6i4bytUT2Aip0C71HxAftkji91ft3+K
         VWaCBvxlWbtzZ1D08uq09wDJZufMLiBKECGXWfdXc7uduKJJXZARgwuZffT/JOu3iqlB
         CB32ezVE7Ar/pN81W2cRluLDOtSCz5o7qjwVbPhwTX1GTJakXCWqGPEKx8z/wuEfh0YZ
         O2zX73ZwgHyyRlLd9ZeTyTOzG75o4Eqr/OaUvN+QKUwo5uafbECjYywJp2SB5Mp549gE
         B40D1k+k6QksGxD9YC7KcrX4zdSMCBSsLz253wKd9QVHgWRMTbeFmQJpxRS7sLIr6ZKi
         QLWA==
X-Forwarded-Encrypted: i=1; AJvYcCXEPS/Wwixu8kFFSm+VQYW6anYoVDsbOoW3mzOsMr+1kSlLCOVh5QU938/W8PJJD2S17WZaZOVZiqdNLd/7@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7vsLVCvKvDYtOIYuAoR4Sq0oiZ6mPJey6tgSn9Y2Jha8jSO3
	IXCXY5hhmw0IVtvFF1XiOZ+puaUC30PcAp4jhlSw1/OqB6G6BsWuh/rPedDYOuT66xAZSRKv1lF
	xXm7GzKsaTMqqprhj8afiagZHEqae8DBwuacxYNHz5H2itcYA2UKvi++YA9BuiNXjU/ZgZUW3JG
	g9c2DDQiZzJwQpYsUHrjmXG8e/sF9PP/kNTc92kksxEQ==
X-Gm-Gg: ASbGncsIYLPoGC0k3dOMjV3SUUYrm2697qP/kcnyDmG3m8qo4GEitd7gjP62rrHocg6
	nxqg3aWhRE/zAh9PqRToKPt4ewY9dE1Y3tJh1IgvDwSPIQ0Mdq2H0oeS/BuNQjA6Qsbw/61P5Sg
	Bb+bDFlACL+ZwFVfq3R076RBfwvTdjGayRK2gvgr6QqRQzfrAoGoxO2p3HjDLximmlbRMMZ/AvL
	3GioSKPj6Fw
X-Received: by 2002:a05:6102:4a8b:b0:5dd:8953:4c39 with SMTP id ada2fe7eead31-5e4f63d5fd7mr637574137.4.1764796991057;
        Wed, 03 Dec 2025 13:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeBH452075dZUyazl8eYT/UzyJ9yFkDbi8VNlxJEcSHSUk7OAj+mWrx0XSlN/lf/ntUkq2fmdnoyADdV50/oQ=
X-Received: by 2002:a05:6102:4a8b:b0:5dd:8953:4c39 with SMTP id
 ada2fe7eead31-5e4f63d5fd7mr637567137.4.1764796990653; Wed, 03 Dec 2025
 13:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203154625.2779153-1-amarkuze@redhat.com> <20251203154625.2779153-5-amarkuze@redhat.com>
 <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com>
In-Reply-To: <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 3 Dec 2025 23:22:59 +0200
X-Gm-Features: AWmQ_bntUST6lQV6ekOD5FmQyjPGwyiG3cHq-BuY0wG_aLL8kU_f90L9smxQwbg
Message-ID: <CAO8a2SjQDC2qaVV6_jsQbzOtUUdxStx2jEMYkG3VVkSCPbiH_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The latest ceph code supports subvolume metrics.
The test is simple:
1. Deploy a ceph cluster
2. Create and mount a subvolume
3. run some I/O
4. I used debugfs to see that subvolume metrics were collected on the
client side and checked for subvolume metrics being reported on the
mds.

Nothing more to it.

On Wed, Dec 3, 2025 at 10:15=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-12-03 at 15:46 +0000, Alex Markuze wrote:
> > 1. Introduce CEPH_SUBVOLUME_ID_NONE constant (value 0) to make the
> >    unknown/unset state explicit and self-documenting.
> >
> > 2. Add WARN_ON_ONCE if attempting to change an already-set subvolume_id=
.
> >    An inode's subvolume membership is immutable - once created in a
> >    subvolume, it stays there. Attempting to change it indicates a bug.
> > ---
> >  fs/ceph/inode.c             | 32 +++++++++++++++++++++++++-------
> >  fs/ceph/mds_client.c        |  5 +----
> >  fs/ceph/subvolume_metrics.c |  7 ++++---
> >  fs/ceph/super.h             | 10 +++++++++-
> >  4 files changed, 39 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 835049004047..257b3e27b741 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -638,7 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *=
sb)
> >
> >       ci->i_max_bytes =3D 0;
> >       ci->i_max_files =3D 0;
> > -     ci->i_subvolume_id =3D 0;
> > +     ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
>
> I was expected to see the code of this patch in the second and third ones=
. And
> it looks really confusing. Why have you introduced another one patch?
>
> So, how I can test this patchset? I assume that xfstests run will be not =
enough.
> Do we have special test environment or test-cases for this?
>
> Thanks,
> Slava.
>
> >
> >       memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
> >       memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> > @@ -743,7 +743,7 @@ void ceph_evict_inode(struct inode *inode)
> >
> >       percpu_counter_dec(&mdsc->metric.total_inodes);
> >
> > -     ci->i_subvolume_id =3D 0;
> > +     ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> >
> >       netfs_wait_for_outstanding_io(inode);
> >       truncate_inode_pages_final(&inode->i_data);
> > @@ -877,19 +877,37 @@ int ceph_fill_file_size(struct inode *inode, int =
issued,
> >  }
> >
> >  /*
> > - * Set the subvolume ID for an inode. Following the FUSE client conven=
tion,
> > - * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume in=
odes).
> > + * Set the subvolume ID for an inode.
> > + *
> > + * The subvolume_id identifies which CephFS subvolume this inode belon=
gs to.
> > + * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
> > + * non-zero IDs for inodes within subvolumes.
> > + *
> > + * An inode's subvolume membership is immutable - once an inode is cre=
ated
> > + * in a subvolume, it stays there. Therefore, if we already have a val=
id
> > + * (non-zero) subvolume_id and receive a different one, that indicates=
 a bug.
> >   */
> >  void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
> >  {
> >       struct ceph_inode_info *ci;
> > +     u64 old;
> >
> > -     if (!inode || !subvolume_id)
> > +     if (!inode || subvolume_id =3D=3D CEPH_SUBVOLUME_ID_NONE)
> >               return;
> >
> >       ci =3D ceph_inode(inode);
> > -     if (READ_ONCE(ci->i_subvolume_id) !=3D subvolume_id)
> > -             WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> > +     old =3D READ_ONCE(ci->i_subvolume_id);
> > +
> > +     if (old =3D=3D subvolume_id)
> > +             return;
> > +
> > +     if (old !=3D CEPH_SUBVOLUME_ID_NONE) {
> > +             /* subvolume_id should not change once set */
> > +             WARN_ON_ONCE(1);
> > +             return;
> > +     }
> > +
> > +     WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> >  }
> >
> >  void ceph_fill_file_time(struct inode *inode, int issued,
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 2b831f48c844..f2a17e11fcef 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -122,10 +122,7 @@ static int parse_reply_info_in(void **p, void *end=
,
> >       u32 struct_len =3D 0;
> >       struct ceph_client *cl =3D mdsc ? mdsc->fsc->client : NULL;
> >
> > -     info->subvolume_id =3D 0;
> > -     doutc(cl, "subv_metric parse start features=3D0x%llx\n", features=
);
> > -
> > -     info->subvolume_id =3D 0;
> > +     info->subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;
> >
> >       if (features =3D=3D (u64)-1) {
> >               ceph_decode_8_safe(p, end, struct_v, bad);
> > diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
> > index 111f6754e609..37cbed5b52c3 100644
> > --- a/fs/ceph/subvolume_metrics.c
> > +++ b/fs/ceph/subvolume_metrics.c
> > @@ -136,8 +136,9 @@ void ceph_subvolume_metrics_record(struct ceph_subv=
olume_metrics_tracker *tracke
> >       struct ceph_subvol_metric_rb_entry *entry, *new_entry =3D NULL;
> >       bool retry =3D false;
> >
> > -     /* 0 means unknown/unset subvolume (matches FUSE client conventio=
n) */
> > -     if (!READ_ONCE(tracker->enabled) || !subvol_id || !size || !laten=
cy_us)
> > +     /* CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset subvolume */
> > +     if (!READ_ONCE(tracker->enabled) ||
> > +         subvol_id =3D=3D CEPH_SUBVOLUME_ID_NONE || !size || !latency_=
us)
> >               return;
> >
> >       do {
> > @@ -403,7 +404,7 @@ void ceph_subvolume_metrics_record_io(struct ceph_m=
ds_client *mdsc,
> >       }
> >
> >       subvol_id =3D READ_ONCE(ci->i_subvolume_id);
> > -     if (!subvol_id) {
> > +     if (subvol_id =3D=3D CEPH_SUBVOLUME_ID_NONE) {
> >               atomic64_inc(&tracker->record_no_subvol);
> >               return;
> >       }
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a03c373efd52..731df0fcbcc8 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -386,7 +386,15 @@ struct ceph_inode_info {
> >
> >       /* quotas */
> >       u64 i_max_bytes, i_max_files;
> > -     u64 i_subvolume_id;     /* 0 =3D unknown/unset, matches FUSE clie=
nt */
> > +
> > +     /*
> > +      * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
> > +      * means unknown/unset, matching the FUSE client convention.
> > +      * Once set to a valid (non-zero) value, it should not change
> > +      * during the inode's lifetime.
> > +      */
> > +#define CEPH_SUBVOLUME_ID_NONE 0
> > +     u64 i_subvolume_id;
> >
> >       s32 i_dir_pin;
> >


