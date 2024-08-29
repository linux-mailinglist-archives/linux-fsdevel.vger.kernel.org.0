Return-Path: <linux-fsdevel+bounces-27866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4929648B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D04281593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB01B1402;
	Thu, 29 Aug 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LM3hr3H+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E11B012B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942385; cv=none; b=tGRh7DhxsJjhtp7mHt1xcK26vgmEcM9fXX3xTRs6GfYEW6fxYLna+wMS6QGCLGpMozPHUgXRFhtXQnlf7X4RIsFz39fGFUr4/L+uH3DEgCJy3sk39mHXy4Hqj22TbBbS5YnrFNUU9rMB44Luf4haVnXrM4+NnREiiOW009IEwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942385; c=relaxed/simple;
	bh=cp+zB7tKJc1mu7PWarcDKT9nIFFxk2Iar1il4LvBW60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj2k8lUzgFj4QxnqOsKLrxkoKn7UxWA+JdGs+uLpa/e+5iFnoo/2YcBF3xHPBpQ+te9kU7x3dUlhHP0mxr/nSRW4KkrDAWX/uYdI+TA2ghhK1UwzYW7evCZPBqhomt6c76kn/6/dRi2LjwUY9mtRwgdmzIvmk65FJITTOXi8oEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LM3hr3H+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6BE743F839
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724942381;
	bh=pkgEy8dNYJhtYxqa1erl6UdbvivyKkm8FEs1QuDoV2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LM3hr3H+jvjiIlW1B4Z7mKj85KtgRuzFrj48ZOD2EYMbDMfueIZD/u99rIbnujGjU
	 4ArHJacK3DGyidZl3pEF1RoKhN6G7r/n8ls6p4/+2UsRU0iR7MpWVvd/MNhuu+wH45
	 7wtNFXeBbw9OqDH60Ej4qj3lP+g7HFGh5rx44Ienjc4OMWZMeOPhlWMV3o9Zt4HgAC
	 rZJJlPjjUHdFSYJ1D4+gOEQyndbH68acmdLGX1aZnSt1EWUjzrnFMDgMxwt8vUUPTD
	 AOm9fEqERxfZydHoZOWrf8LsKpjIi2/xqGrpKpSA5TxEHL79wMarPt9j1vL/aaFN89
	 n/4Cz9Uhu3oYQ==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-709664a6285so819301a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 07:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942380; x=1725547180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkgEy8dNYJhtYxqa1erl6UdbvivyKkm8FEs1QuDoV2E=;
        b=Gnyzzi4BHHiwNVu+eGjn5y3u8mVxcGJSb7KDAGM1vxDTGvlMpsQ806sV+8YvC/nfpO
         EbKCiNmJB5upkElRro7p45uZzwW/KGkc7OiPo6Ho34Z2sOnm4DPZKWMWNGf5dqaLLoi0
         yGZy4yWAYmkT2aOy1QmeTH11hrCs0Z5uyWRoMWMxS/kVX6NKGInS1lqVPpQKYIgrx/gJ
         vHmMWrVXWLAz9unC/dba+3f2c7HxArc/7riIt8hCCOzC9kZfgNvIM+GdZk3Qh2D34KVJ
         OGQzbLvj+bKsKQgMjvODzhWhcYWyKfEnRDKbFKhWAuhVG58rikqRXo7SaW/gEMwTgFvh
         sseA==
X-Forwarded-Encrypted: i=1; AJvYcCXhOfgwKIb17lBXHiDI9Ekrx0l9sTAaLSsqU9BV2tR+JY+I3pqaORrOw8lGh+zMxqgXU85bII8XhG/0TcM0@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQp7y+eTWOGFbn4hFXVl65qfJ2MEw5J7gHSp00UitGpF3I56t
	veD8gvgDGKSWDgy9ss4gnUl2SdZXNOqx59dqHyYWTInx8nQiCMtq1uxw0vfHA+dNMP+CcNT3bqJ
	NAi+aSO6rEjLsQr85K19XE/gKBfADQI4g4owXhcR1fxx5b982i8HAYSsa4UTBMvd3XGoxgp8yI1
	uW471WlZH7F8EkViNNp0zbABTINuw5P+VgCwXari9TgHiv/pUhChDPkw==
X-Received: by 2002:a05:6359:4590:b0:1ac:f577:db25 with SMTP id e5c5f4694b2df-1b603be30afmr414526255d.6.1724942380274;
        Thu, 29 Aug 2024 07:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lTy/0SzqBHDrVLeVHxS/eYo35QPfix7ei9UvZx0OmEC+gCIjR8LYO4jLas5BaQdIa5J2xOT/6k3Kf7u/ABc=
X-Received: by 2002:a05:6359:4590:b0:1ac:f577:db25 with SMTP id
 e5c5f4694b2df-1b603be30afmr414523255d.6.1724942379980; Thu, 29 Aug 2024
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
In-Reply-To: <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 16:39:29 +0200
Message-ID: <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:30=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 29 Aug 2024 at 14:08, Christian Brauner <brauner@kernel.org> wrot=
e:
>
> > Fwiw, that's what the patchset is doing. It's only supported if the
> > server sets "default_permissions".
>
> My specific issue is with FUSE_EXT_OWNER_UID_GID, which I think is
> unnecessary.  Just fill the header with the mapped uid/gid values,
> which most servers already use for creating the file with the correct
> st_uid/st_gid and not for checking permission.  When the mapped values
> are unavailable, set the uid/gid in the header -1.  Should be better
> than sending nonsense values to userspace, no?

Hi Miklos,

yeah, we have a discussion like that while discussing cephfs idmapped mount=
s.
And yes, it's a really good question and it's not obvious at all which
solution is the best.
( I believe that I have replied on that question already there:
https://lore.kernel.org/all/CAEivzxeva5ipjihSrMa4u=3Duk9sDm9DNg9cLoYg0O6=3D=
eU2jLNQQ@mail.gmail.com/
)

A main argument against mapping uid/gid values in fuse header is
consistency. We can map these
values in symlink/mknod/mkdir/create/tmpfile. But we don't have access
to idmapping information in
lookup, read, write, etc. What should we do for these inode operations
then? Send an unmapped uid/gid?
But then it is an inconsistency - in one inode ops we have mapped
values, in another ones - we have unmapped ones.

>When the mapped values
> are unavailable, set the uid/gid in the header -1.  Should be better
> than sending nonsense values to userspace, no?

So, your point is to set uid/gid to -1 for FUSE_{READ,WRITE,LOOKUP,RELEASE,=
...}?

Kind regards,
Alex

>
> Thanks,
> Miklos

