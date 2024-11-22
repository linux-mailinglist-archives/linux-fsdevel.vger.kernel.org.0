Return-Path: <linux-fsdevel+bounces-35550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DC9D5B46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A62B1F22D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5918BC22;
	Fri, 22 Nov 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDux6kBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E01304BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265378; cv=none; b=URci7b48lzgtuZ9P8O3dF6D3cOh4M7zBVnCT/r5bTqYV7c4C9q6/ee+TQ1/EU9EpNoFVwGT+sPVW3PlXCpE/EjAau8g9Qn7QiZc7xB0yI4w5lS0C3nziOpowgeZm6wpFzdrr+23Dxrt21hJiyVRzs669tqdBDEuh/DU5LbYcCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265378; c=relaxed/simple;
	bh=DeP0muBo8/ei79yy7wFHcXL7CXCMW0UtBwOhn6Dwcxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx3HV3Jj7UH2YJjKX15qjL8j+YOMDkIC12DIwHZjLzmsZTja9VrRIW3g6nw3u8kxgBdliB0JWyiKqdWahiVj/nUaaFKDb1w0AP+1mKsIWtubt3urc28qCaub34LJeVJc0RSe7kRFy+G46Yjlmwx88fMwwqDcGnLrQiDN4foG87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDux6kBt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so5634895a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732265374; x=1732870174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kO/z/IdbIn2zdD3nJFBvE5a6HQLfpizTI0u8jsOVaE=;
        b=GDux6kBtwb5KBhy5IKvVBZGYubQVSXI+Xz9raN2bCq3J2G4u/+2p3I274mS26izPZd
         VRBQPRQVCTNv0ZIb2kPnIMCSaFYMNHUzmqJlpeAHeeWw1BlovuLOxjFiysodpIGWDGTH
         DRSWnubo6QSKVaE2bHeGwrql85uxTWsQYxTkuMOJIhEPRLdpWXj8jj7m47LieU6jGq3g
         ps8dEGAMMWfB15b4V1/myTOGyE15kG5vQ0QFrSbz3vIlDrzcW4RX9LARWfhDiNVXAH7b
         BcgrWAqXrwxvgj3USAbM4lG7MeKXnFb2/0wbb4L1hhpfFRawQ7byg8XORWaMXtVWnsBa
         OASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732265374; x=1732870174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kO/z/IdbIn2zdD3nJFBvE5a6HQLfpizTI0u8jsOVaE=;
        b=BGiVY+DD0u60R1PmWRcRX5oqbRo2c6h/et2g1LE8KFufFKsJg1GYU76bG0ITjwd9Uk
         gE6YX20hsX1soy3PJ/7SkYmpBjQ6HCNLibkjxA7UbO3KlWaYp/4r/Uy1WabZCyQr4IJf
         D9sSfGC1EH6KyHtWsRhAq7PGBZAFJ3H0kJkJfigRVBbxTuzLBn8ngupUXaaEzGhOC31c
         XHNTIyTILfMVIluE+Yfk+IzCUgKwt00DB75tjnM1SmF+R/RhTY3xXeVYm0XESRLZY6Ni
         eahTag0TzPp7kG46zcFXctgu19e3O3TCxqfoiVSHskgAGTTSGv4AlYzoLLhBGtOir1/v
         I/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU6yS3XZ2tEWBU8nguZD5mxajPBZGEZIUTboTko++cAS2TQOmPMkHrsV8u3ugDpgZaZwd6W4qxOKf3QdHFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YydlA/kpcTzjOi5i/4gsNrklM8p7xrjyb9KSiavznR14UXgf+qu
	gRffXpVqPo2xk+PJ9zuhLzd49kJ2ieUcB/vtP0MDGidTIvQzHcMrD2zPREGeF5FpT7I9rtrl3nZ
	0yTZ7ibajQ0fMny3rPt2ck42Z/GI=
X-Gm-Gg: ASbGncsbsg9o+tN3ofSYo4m0gtWPb063aUwMsO1IokvS0CAcnUblHuYRGL5DwvaRwm1
	QtRc1tTE5W6vFTPPnQoS4hCDW90gZ9TY=
X-Google-Smtp-Source: AGHT+IF6mlfSfDTj7T/pa7Q4laprDC0jPLXBLVl4ET5q3YYVua/l7ROLiOsRYA+M+xMr1JiFtEvwqqZitz6MKeM02xI=
X-Received: by 2002:a17:907:60ce:b0:aa4:e53f:5fbe with SMTP id
 a640c23a62f3a-aa509a1c2f9mr263083266b.19.1732265374191; Fri, 22 Nov 2024
 00:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117213206.1636438-1-cel@kernel.org> <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net> <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net> <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com> <63377879-1b25-605e-43c6-1d1512f81526@google.com>
 <Zz+mUNsraFF8B0bw@tissot.1015granger.net>
In-Reply-To: <Zz+mUNsraFF8B0bw@tissot.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Nov 2024 09:49:23 +0100
Message-ID: <CAOQ4uxhFdY3Z_jS_Z8EpziHAQuQEZgi+Y1ZLyhu-OXfprjszgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
	"yukuai (C)" <yukuai3@huawei.com>, 
	"yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:30=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Thu, Nov 21, 2024 at 01:18:05PM -0800, Hugh Dickins wrote:
> > On Thu, 21 Nov 2024, Chuck Lever III wrote:
> > >
> > > I will note that tmpfs hangs during generic/449 for me 100%
> > > of the time; the failure appears unrelated to renames. Do you
> > > know if there is regular CI being done for tmpfs? I'm planning
> > > to add it to my nightly test rig once I'm done here.
> >
> > For me generic/449 did not hang, just took a long time to discover
> > something uninteresting and eventually declare "not run".  Took
> > 14 minutes six years ago, when I gave up on it and short-circuited
> > the "not run" with the patch below.
> >
> > (I carry about twenty patches for my own tmpfs fstests testing; but
> > many of those are just for ancient 32-bit environment, or to suit the
> > "huge=3Dalways" option. I never have enough time/priority to review and
> > post them, but can send you a tarball if they might of use to you.)
> >
> > generic/449 is one of those tests which expects metadata to occupy
> > space inside the "disk", in a way which it does not on tmpfs (and a
> > quick glance at its history suggests btrfs also had issues with it).
> >
> > [PATCH] generic/449: not run on tmpfs earlier
> >
> > Do not waste 14 minutes to discover that tmpfs succeeds in
> > setting acls despite running out of space for user attrs.
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  tests/generic/449 | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tests/generic/449 b/tests/generic/449
> > index 9cf814ad..a52a992b 100755
> > --- a/tests/generic/449
> > +++ b/tests/generic/449
> > @@ -22,6 +22,11 @@ _require_test
> >  _require_acls
> >  _require_attrs trusted
> >
> > +if [ "$FSTYP" =3D "tmpfs" ]; then
> > +     # Do not waste 14 minutes to discover this:
> > +     _notrun "$FSTYP succeeds in setting acls despite running out of s=
pace for user attrs"
> > +fi
> > +
> >  _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> >  _scratch_mount || _fail "mount failed"
> >
> > --
> > 2.35.3
>
> My approach (until I could look into the failure more) has been
> similar:
>
> diff --git a/tests/generic/449 b/tests/generic/449
> index 9cf814ad326c..8307a43ce87f 100755
> --- a/tests/generic/449
> +++ b/tests/generic/449
> @@ -21,6 +21,7 @@ _require_scratch
>  _require_test
>  _require_acls
>  _require_attrs trusted
> +_supported_fs ^nfs ^overlay ^tmpfs
>

nfs and overlay are _notrun because they do not support _scratch_mkfs_sized

>  _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount || _fail "mount failed"
>
>
> I stole it from somewhere else, so it's not tmpfs-specific.

I think opt-out for a certain fs makes sense in some tests, but it is
prefered to describe the requirement that is behind the opt-out.

For example, you thought that nfs,overlay,tmpfs should all opt-out
from this test. Why? Which property do they share in common and
how can it be described in a generic way?

I am not talking about a property that can be checked.
Sometimes we need to make groups of filesystems that share a common
property that cannot be tested, to better express the requirements.

_fstyp_has_non_default_seek_data_hole() is the only example that
comes to mind but there could be others.

Thanks,
Amir.

