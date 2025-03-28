Return-Path: <linux-fsdevel+bounces-45189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B55A745EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0817917C149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3B21147B;
	Fri, 28 Mar 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPgpxP9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969481C84CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152692; cv=none; b=guvTKxkvv9Go9t6OC8SHTZgnzcec+Ji8EptgXNsebXcxpPfwDkhWPjNdxK/N7qZNXRaq/D0BCNytTw1r07v70fylPzbxMd8PZWVxgrVPNUM1A5Wp9K3EKlbDdCSEaIMnnxEKQE98z1JYYB7fbj7RdgFnjxsoGvWQFv0Ca1omGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152692; c=relaxed/simple;
	bh=ESusgfYdb+XZoSNlRLvcbZvlZG0iyY4YItOOJvPMPJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxThQMgbr4PQqel+4nY268k6doO/YqSpf5i6LaQhdlz8kJUL2d2dP+ymVbL1ojnaONvL54AL7nLzu5VFfDftuvmbqDaK+2kHPMqSylYuz1kbdyD//Ku4s6HY+32A9SmMiq0ueIDP3TNR4/x/ciPgEco/RMDl5KwzWt6pAy32cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPgpxP9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743152689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAjO5a37BNMOhRbA/22/2GhJ437ottI2RizwezpZEfk=;
	b=SPgpxP9wBPRkJaA4h3ghfdc4GVCCvmwZJXcK19MlX+0Byg42FgEBBC38Ag/3rK8KW75kVX
	YWWeerx0+QTHZo5g7bfxhLjAv5vScdrsf4UiIYvqlmLsMaMALsgPyImkWwict0BVq0R/jn
	IWoripIcAt3tsAS/8zH3MoS4QK2x7qI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-lIxQX5k1MyWmNhXkXW3xfg-1; Fri, 28 Mar 2025 05:04:46 -0400
X-MC-Unique: lIxQX5k1MyWmNhXkXW3xfg-1
X-Mimecast-MFC-AGG-ID: lIxQX5k1MyWmNhXkXW3xfg_1743152685
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c4fd96a7bso9176611fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 02:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743152685; x=1743757485;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAjO5a37BNMOhRbA/22/2GhJ437ottI2RizwezpZEfk=;
        b=OIWXMlSDe6F5DY0mJzgDuVTheW2BUSFX8hiEacHdu4mNdSrpfHWy7dncwswUc1b+mS
         rclpB23TOFUvwBqZYKWsSGC5sO69+O4UNCGVUJfaivVpC7CvmmC9nGnDeXav+SDGqWd5
         XpVi3JbS4xjwqbxyayb7fysiZ2iAuSvfy6RUcPZVHyM9takET60n4lupSdgFy6GwVQTu
         yjhBub+oMWbWqXVamHLS9ickDXiWHV+m2yK+6WCb1+DnRpCITkXrfg35r5d0EyhsKlE7
         QgAfYPp3u80k/0mDlS+8JiM6u233Dfao0gPA+ZvVhpZTNOlRkZ5JUERs5BHBlfqhXDb0
         nxEA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKGZhvO4F8uuznaW0B9QmI0VFX/uoOKisTgyJxrbsj8onoB6uPZpyi9OfNAuuFWB8oLKZ46J+T+Fq7DIe@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYYoUY6XNCnZhN1cwdwG4gZ1yxK+9rWhhhlqR8sUNxu5YFJQm
	3T8v4Obd6Y4jAP1caAyBWorv2hzVRCh6gyOIDgfucg7N9nI4G+WGXvPvtC8U0OyV3fLoxNdwRiZ
	r85FwtOOvapLnkldI+OeGHOiDSnMOpB8XJ9YWwwx+K6E2Oi+d75XZu7QrlaylC6o=
X-Gm-Gg: ASbGncud0+kxFChkN0AtPwwml97h2SuPzIuBQ+hxhx2bV5vLuKI7V7JJuB9kYSiKnr1
	hula7frvyyFX6mcIEgwnXKD1eJiUUIDW95ciGnGcoUnlgtDuVyuRSwyUHw56uAS3gx/x3zPrw/J
	HP7GUE8twX7DpM881jIyd8wLMUJG5IqO6/tloIEf1iEPr0qo6Rje9aF+DGQDx4H/fnofmf/KB7Y
	AkNvzN+pagoK/0UA0L+Mrt0PQzUWEwOcBfoz5d2HDwwdGsoS28EbZVPN/JhOp1rC79/X2x3qvO6
	UGawf/9THWim77ti7ZU99G/z5nWleUdpzdUeMujI7CUtmY3iIpRhfsk=
X-Received: by 2002:a05:6512:3da9:b0:545:6cf:6f3e with SMTP id 2adb3069b0e04-54b01265141mr3026021e87.49.1743152684918;
        Fri, 28 Mar 2025 02:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHezFgBQEAMOmDdy8UHLCNmIqvSSOOti8SfWyDewjH6ZMZdYx33W7942mcr+lgURUg3KmybAg==
X-Received: by 2002:a05:6512:3da9:b0:545:6cf:6f3e with SMTP id 2adb3069b0e04-54b01265141mr3026002e87.49.1743152684400;
        Fri, 28 Mar 2025 02:04:44 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09591a01sm228635e87.164.2025.03.28.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 02:04:42 -0700 (PDT)
Message-ID: <a206a3113e834a40740f12e078d1301cb9fc22dc.camel@redhat.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Miklos Szeredi
	 <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 28 Mar 2025 10:04:40 +0100
In-Reply-To: <CAJfpegv44p8MhCWCQ2R93+iUCCrTZbk0KowZxVmsf=0tsbGHLA@mail.gmail.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
	 <20250210194512.417339-3-mszeredi@redhat.com>
	 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
	 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
	 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
	 <87a5ahdjrd.fsf@redhat.com>
	 <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
	 <875xl4etgk.fsf@redhat.com>
	 <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
	 <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
	 <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com>
	 <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
	 <CAJfpegv44p8MhCWCQ2R93+iUCCrTZbk0KowZxVmsf=0tsbGHLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 20:23 +0100, Miklos Szeredi wrote:
> On Thu, 27 Mar 2025 at 18:14, Amir Goldstein <amir73il@gmail.com>
> wrote:
> > origin xattr only checks from upper to uppermost lower layer IIRC,
> > do definitely not all the way to lowerdata inode.
>=20
> Makes sense.
>=20
> > > so as long as the user is unable to change the origin integrity
> > > should
> > > be guaranteed.=C2=A0 IOW, what we need is just to always check origin
> > > on
> > > metacopy regardless of the index option.
> > >=20
> > > But I'm not even sure this is used at all, since the verity code
> > > was
> > > added for the composefs use case, which does not use this path
> > > AFAICS.
> > > Alex, can you clarify?
> >=20
> > I am not sure how composefs lowerdata layer is being deployed,
> > but but I am pretty sure that the composefs erofs layers are
> > designed to be migratable to any fs where the lowerdata repo
> > exists, so I think hard coding the lowerdata inode is undesired.
>=20
> Yeah, I understand the basic composefs architecture, and storing the
> digest in the metadata inode makes perfect sense.
>=20
> What I'm not sure is what is being used outside of that.
>=20
> Anyway, I don't see any issue with the current architecture, just
> trying to understand what this is useful for and possible
> simplifications based on that.
>=20
> For example the copy-up code is apparently unused, and could be
> removed.=C2=A0 OTOH it could be useful for the idmapping case from
> Guiseppe.

I think there are two basic composefs usecases, first a completely
read-only one with a data-only, an erofs lower and nothing more. The
traditional example here is a read-only rootfs. In this case, clearly
digest copy-up is not needed.

The second usecase is when you use composefs for a container image,
similar to use case 1, but on top of that you have the writable upper
layer that is for the running container itself. In this case, you want
to validate all accesses to the lower layer, but allow the container to
make changes. Obviously, once you create a new file, or modify a lower
one there will not be any validation of that file.=C2=A0

However, if you for example change just file ownership, then you may
trigger a meta-copy-up, and at this point it makes sense to also copy
up the digest to the metacopy file, because otherwise accesses to it
would read the datadir file without validating its digest.=C2=A0

Unfortunately this (as you say) weakens the security in the case the
raw upperdir is not trusted, as it would allow the digest xattr to be
changed. But I think this is acceptable, because the alternative
without meta-copy-up is a full copy up, but then you can change the
file data in the upper instead, which is even worse.

As for origin checks, they are really never interesting to any
composefs-style usecase, because those are fundamentally about
transporting images between different systems (with different
filesystems, inodes, etc).


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a superhumanly strong coffee-fuelled firefighter who hides his=20
scarred face behind a mask. She's a sarcastic mute opera singer who=20
inherited a spooky stately manor from her late maiden aunt. They fight=20
crime!=20


