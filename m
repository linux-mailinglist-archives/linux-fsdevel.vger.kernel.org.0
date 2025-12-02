Return-Path: <linux-fsdevel+bounces-70447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA165C9B30E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8576C3468B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53730F547;
	Tue,  2 Dec 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DieBnMW2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwdUxgiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E530215D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671966; cv=none; b=FNoCY/FwPBrBL7qbRCkkOHN16UAko9iWzrfQnSQkCtB5UMTjpWcTYN66QfZtWKmxF8Vyj0mAfw4+czkmbKBEZF5wvydzJ5pYBTvbwqbCKvOCGSQNUVRmCZTUhmsG//nS32NVpf6Ze2rs3We4c9lr4pIQxhCho861mu67iZIhb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671966; c=relaxed/simple;
	bh=5PnwP6P9YOsWdrSpcZUxzDIx4rIJLBQPjFt49pWe6OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piy34aqaMAeCPUErj0XZU6tDlxBVu9SiM/sim/bfUhiEe4AXQM54eIhXdKAHJfYFG75TCxRCVqaVR0WhOWu/6bdf4Dl7dr5OP95TYaRqKZZEoetdHjJr03FIOwokcLzlsswFQF5A1+kUzUV46KT4xH58rgHm7FmlNOSushlaKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DieBnMW2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwdUxgiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764671963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiJGdCG0PC+FCsZFqhjWfcf48WR6KzvCnHiDcd4IGfI=;
	b=DieBnMW2CrNnPZf+tyFzMr4JajT9exxAplTitRyzUQOodPUihx32HR6QGvdnnbxMjQ6kyo
	YN9Stmxthg1GOuDxJdbqQ1pyc8NMu4lUBePR+MeCdarX3jHloC7O5Wu1RtinUwKZyuwpEJ
	OGDPpLCu1hauyNpVmAoAtjh0P/JBQOU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Xpd-QB2RN3Oku2WNL0j50A-1; Tue, 02 Dec 2025 05:39:22 -0500
X-MC-Unique: Xpd-QB2RN3Oku2WNL0j50A-1
X-Mimecast-MFC-AGG-ID: Xpd-QB2RN3Oku2WNL0j50A_1764671961
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-935298312cfso6231737241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 02:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764671961; x=1765276761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJGdCG0PC+FCsZFqhjWfcf48WR6KzvCnHiDcd4IGfI=;
        b=PwdUxgiG4gFxOb4l9q3ESNVqwsHBPKvBbAPMGWzsToxsZ7Tn0wLEXlW2nhpp5Bt2Pl
         Lfys5R7f4hTZ07Z1tjZus12SXuJGvv6oJST/GCsg9G/JsTXuX3W5mNhjYboOxUlfLZRG
         wxwFtdznxNL/4SuJyigneHRULJtsESvLajRALK1BPCXbh2slMr0sdULH5HwiQXENbPxl
         DBdsJby0JVN2G0QapcP+SHCXxoFjVt965+JFbpPDw3UJu2x9fOUKzCatC/ID2qedb03f
         qsmXy29XWfIQ4amX3z0RtEahPJEeG3qkT5zopQ1GP2g7O3PQXRDtpd2K0zlaKGzdQcyo
         hd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764671961; x=1765276761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiJGdCG0PC+FCsZFqhjWfcf48WR6KzvCnHiDcd4IGfI=;
        b=QX23ldpk1XwsYCT3wT062YrL4zXdX7GYkoieT4zxwqj1LK1k+CjibQJvQh8G323dJY
         YxjcrLiQAICu7cgciXrZG1+iBQ2tR2Mw8iy1ipqsBUXekTk5NPJXtpV6DqEJpjwwfzb1
         eFg+YVyRrJoIxysfw79cQkadaQTlfmvwG/4icZGA+j1lbXm65vpRehQ2dIlr8KyaYzg7
         uZbaw02O3mb6S2t3SM6YidYTdwvEhtbK6lOWDC+suBlqHT4/0jyPA7hAYvBq47cU0MEg
         oE4SynhoBjTFUDIGigPCNfMzGB6orWzJo/5MflY8zZMt+K1+o+Z1ul7FVqT9cUz5J3B3
         Nhtw==
X-Forwarded-Encrypted: i=1; AJvYcCVzuXDOJp64BX3SW5mZ6IJ+XbexAJN/NpxoQ9Sy10L48E+xx5BIj4zkxKrzeI/USpknZQ8fYzMSV09CQntd@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcovpCrKMduFImDFe+5PO9RBzBMLmRqnN9SSxJwQcVnf20IFm
	yqRxbG8FqKecbUnzm530J5D6MvfGn/0N/A0T2qahlzXduGdfbGtaEOsc8tqqRapQB+ApVXk/K0R
	c1e+fmVLV3zuEG2KOTN2BYQQ0V6+cYZT2pJxrkuRkslk5bzaUxzB2yie7IY+oIILbt6lEhPQn4U
	chqeMd7di4PVcIoL5vq+TA0VU50aTAUn1lxJ0QBgRTow==
X-Gm-Gg: ASbGncuC3vi49Nc5Xnb8wUKn+W71hI5sY2ZzW83mkFcgwEEQKV7uDSDSsPGDmRMX126
	oT9tpZp1yAXqJHNrqcmf5X8d9ykHc8zld9Mw8rD615YauTxZDahFOq9l0tqxQWfY1UlMJWcwhFw
	AWXeI7ATkp9JNBQdag5hRuRwGcsfCteZcAwNmPkE5UUw3LelBOVkjjpFEFxfDXiXEc+VbPTZxAC
	j3OAm6aag==
X-Received: by 2002:a05:6102:3a10:b0:5d5:f6ae:3914 with SMTP id ada2fe7eead31-5e40c7cb8d0mr836354137.22.1764671961508;
        Tue, 02 Dec 2025 02:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAMGx5cfztqeLoNBnJ/UEcyA8RGEsBmIpTD5RsW452OYnkA6k6u8LDJj4i/NlZIhmlNjDEh5f8ikVmIOC8PAc=
X-Received: by 2002:a05:6102:3a10:b0:5d5:f6ae:3914 with SMTP id
 ada2fe7eead31-5e40c7cb8d0mr836346137.22.1764671961145; Tue, 02 Dec 2025
 02:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127134620.2035796-1-amarkuze@redhat.com> <20251127134620.2035796-2-amarkuze@redhat.com>
 <06142f77a8091d5ed7c1523495f6e0ebb33ad83d.camel@ibm.com>
In-Reply-To: <06142f77a8091d5ed7c1523495f6e0ebb33ad83d.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 2 Dec 2025 12:39:09 +0200
X-Gm-Features: AWmQ_bmzcuX7F6VSqGLZw7uMWzaR6h6Lr_rKYwXcM4z4j4En4w7OXI6g2qxMJyY
Message-ID: <CAO8a2Sge5iS7ZezQ09PoKZBGdScJ3nQe0i-+FeCMgYA+16K5ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v8 was added for case insensitive file systems, not relevant to Linux,
I can add a comment saying that.

On Mon, Dec 1, 2025 at 10:20=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Thu, 2025-11-27 at 13:46 +0000, Alex Markuze wrote:
> > Add forward-compatible handling for the new versioned field introduced
> > in InodeStat v8. This patch only skips the field without using it,
> > preparing for future protocol extensions.
> >
> > The v8 encoding adds a versioned sub-structure that needs to be properl=
y
> > decoded and skipped to maintain compatibility with newer MDS versions.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/mds_client.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 1740047aef0f..32561fc701e5 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -231,6 +231,18 @@ static int parse_reply_info_in(void **p, void *end=
,
> >                                                     info->fscrypt_file_=
len, bad);
> >                       }
> >               }
> > +
> > +             /* struct_v 8 added a versioned field - skip it */
> > +             if (struct_v >=3D 8) {
> > +                     u8 v8_struct_v, v8_struct_compat;
> > +                     u32 v8_struct_len;
> > +
>
> Probably, we need to have warning here that, currently, this protocol is =
not
> supported yet.
>
> Thanks,
> Slava.
>
> > +                     ceph_decode_8_safe(p, end, v8_struct_v, bad);
> > +                     ceph_decode_8_safe(p, end, v8_struct_compat, bad)=
;
> > +                     ceph_decode_32_safe(p, end, v8_struct_len, bad);
> > +                     ceph_decode_skip_n(p, end, v8_struct_len, bad);
> > +             }
> > +
> >               *p =3D end;
> >       } else {
> >               /* legacy (unversioned) struct */


