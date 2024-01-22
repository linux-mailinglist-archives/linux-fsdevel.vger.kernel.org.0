Return-Path: <linux-fsdevel+bounces-8409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB1835FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAC21F253E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92073A1C9;
	Mon, 22 Jan 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYGojwrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDA3B298
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920259; cv=none; b=dN+qUUfuVkB+MGmguya8Kv1jhwM01fsAK5hJjxsiCa94JCULuO76sUfs3aYZZiPCqKcZzbgEQHohnh/kOsIFZBBZvoZUubNDjy28A+Q5eBRcbFnO5sdGV73hkx7fAMrR+XlgnvWxsmReRUKU6tbstc5eqHjvpWr6lzBxbR/Gb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920259; c=relaxed/simple;
	bh=75RNHEd3QE7gIzvGvWHo+Tndj79A20I47U4jnEJC/Uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6hA+ylox6J++h8zBsE3HLDxz7Q7tji1BvhiD/Sa5FsiqiVWE6ONbuVEpEvI5/whpjNhWKkU7DP/iGDEMtaz2E4WAARpIfLPGYcc5VHe/XStO7S2d/FFIXJtId/4+KtQIt7mp0PE9mhA571JpyCbLDpdn9GaYvauIM1d8Fy15uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYGojwrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705920256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9MSfqqZBv9iIzLzMb9UtcrF62L0l0jyngmzyv+1aP34=;
	b=eYGojwrZeN2VWNjzKK9dVgIuIOilloXk3DdRI0jY8eh+jL74WCNJUYFs6CsPaBPW2+7LZv
	LAeFbbYoC8OIdBaDDqufsDhq2TPFcW/KcNJZMes7dhHE6Zv9B3uRggZ14vKwdY1wPUifif
	M4JMx5goFYlpJbvCsT/4zLb6FP3GaCQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-TUmfKGPdPXCZY4h2KkhsHQ-1; Mon, 22 Jan 2024 05:44:14 -0500
X-MC-Unique: TUmfKGPdPXCZY4h2KkhsHQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e7b7c85easo1988167e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 02:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920252; x=1706525052;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MSfqqZBv9iIzLzMb9UtcrF62L0l0jyngmzyv+1aP34=;
        b=lZlYqr4sohC09Swz+RE4YnoYgjF/vepy7gRVCXZZwgCBNSIx8C02tfYy9V+/9G8QK4
         HtOlIAFMkVbsJhNWHo16nXjt9ZOz6qUOaTXsaYxox86NC35OD3vPfuWkLxTdo96eeoUN
         Ik9sPQORHDlht7RXqJhNZ6+VxVI+X8/3ZZScWlPYD5FvOUMZVkzdxaNnF2GPFPqI/AWn
         7EuYJhm4ETuMskeE8jtKY1Oz6GbOkNpHeh/VSY/Y726NJJYE1CcJFZECXxHmsW75oIjo
         jC9ob0EG78nU1LeBi9iBdcs2jmMjlme8j8K9nUaf23uVQ8sGYxy6tNQ6u6M7f436Cg5K
         KOYQ==
X-Gm-Message-State: AOJu0Yz8azIVgOGgAMkKwE8Ixca6Dw4Kp1fMgFb0YcuKH+yqhQq4C5Eu
	FrWTucrVgNAaZzLpFF9ntcU/GOqauBjo8PIk9sRrX7iaxAHmgvWP8AVe5psI50XzB14L6K8xvWJ
	Weg12ysum4Of4jdGVnRCMwp15+bdzgQUdyDINY2+cIA5m4LSq/aPmsXX5f5KXidA=
X-Received: by 2002:a05:6512:280b:b0:50e:93fa:336 with SMTP id cf11-20020a056512280b00b0050e93fa0336mr1660138lfb.95.1705920252715;
        Mon, 22 Jan 2024 02:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSyafjAvUrgBL812daMCiTvLXqGtcRPNXO7YMx11noQHfb8e1ePlfoM+yVc11NAd2Z5DkLxQ==
X-Received: by 2002:a05:6512:280b:b0:50e:93fa:336 with SMTP id cf11-20020a056512280b00b0050e93fa0336mr1660127lfb.95.1705920252231;
        Mon, 22 Jan 2024 02:44:12 -0800 (PST)
Received: from [172.31.0.10] (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id b5-20020a056512060500b0050e6bf65b2asm1966347lfe.288.2024.01.22.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:44:11 -0800 (PST)
Message-ID: <0473f5389dd1ada08c73479612a4e054c8023d94.camel@redhat.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
From: Alexander Larsson <alexl@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 22 Jan 2024 11:44:11 +0100
In-Reply-To: <CAOQ4uxj_EWqa716+9xxu0zEd-ziEFpoGsv2OggUrb8_eGGkDDw@mail.gmail.com>
References: <20240119101454.532809-1-mszeredi@redhat.com>
	 <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
	 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
	 <CAOQ4uxj_EWqa716+9xxu0zEd-ziEFpoGsv2OggUrb8_eGGkDDw@mail.gmail.com>
Autocrypt: addr=alexl@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 10:38 +0200, Amir Goldstein wrote:
> On Fri, Jan 19, 2024 at 6:35=E2=80=AFPM Alexander Larsson <alexl@redhat.c=
om>
> wrote:
> >=20
> > On Fri, 2024-01-19 at 13:08 +0200, Amir Goldstein wrote:
> > > On Fri, Jan 19, 2024 at 12:14=E2=80=AFPM Miklos Szeredi
> > > <mszeredi@redhat.com>
> > > wrote:
> > >=20
> > >=20
> > > Do you want me to fix/test and send this to Linus?
> > >=20
> > > Alex, can we add your RVB to v2?
> >=20
> > I ran into an issue converting composefs to use this.
> >=20
> > Suppose we have a chroot of files containing some upper dirs and we
> > want to make a composefs of this. For example, say
> > /foo/lower/dir/whiteout is a traditional whiteout.
> >=20
> > Previously, what happened is that I marked the whiteout file with
> > trusted.overlay.overlay.whiteout, and the /foo/lower/dir with
> > trusted.overlay.overlay.whiteouts.
> >=20
> > Them when I mounted then entire chroot with overlayfs these xattrs
> > would get unescaped and I would get a $mnt/foo/lower/dir/whiteout
> > with
> > a trusted.overlay.whiteout xattr, and a $mnt/foo/lower/dir with a
> > trusted.overlay.whiteout. When I then mounted another overlayfs
> > with a
> > lowerdir of $mnt/foo/lower it would treat the whiteout as a
> > xwhiteout.
> >=20
> > However, now I need the lowerdir toplevel dir to also have a
> > trusted.overlay.whiteouts xattr. But when I'm converting the entire
> > chroot I do not know which of the directories is going to be used
> > as
> > the toplevel lower dir, so I don't know where to put this marker.
> >=20
> > The only solution I see is to put it on *all* parent directories.
> > Is
> > there a better approach here?
> >=20
>=20
> Alex,
>=20
> As you can see, I posted v3 with an alternative approach that would
> not
> require marking all possible lower layer roots.
>=20
> However, I cannot help wondering if it wouldn't be better practice,
> when
> composing layers, to always be explicit, per-directory about whether
> the
> composed directory is a "base" or a "diff" layer.
>=20
> Isn't this information always known at composing time?

Currently, composefs images are not layered as such. They normally only
have one or more lowerdata layers, and then the actual image as a
single lowerdir, and on top of that an optional upper if you want some
kind of writability.=20

But, when composing the composefs the content of the image is opaque to
us. We're just given a directory with some files in it for the image.
It might contain some other lowerdirs, but the details are not know to
us at compose time.

That said, I can see that in some cases it may make sense to use
multiple lower dirs, for example when using composefs for multi-layer
container images. When generating such layers we typically have the
lower levels available, so we could probably extract the base/dir
status for each directory.

> In legacy overlayfs, there is an explicit mark for "this is a base
> dir" -
> namely, the opaque xattr, but there is no such explicit mark on
> directories without an entry with the same name in layers below them.
>=20
> The lack of explicit mark "merge" vs. "opaque" in all directories in
> all
> the layers had led to problems in the past, for example, this is the
> reason that this fix was needed:
>=20
> =C2=A0 b79e05aaa166 ovl: no direct iteration for dir with origin xattr
>=20
> In conclusion, since composefs is the first tool, that I know of, to
> compose "non-legacy" overlayfs layers (i.e. with overlay xattrs),
> I think the correct design decision would mark every directory in
> every layer explicitly as at exactly one of "merge"/"opaque".
>=20
> Note that non-dir are always marked explicitly as "metacopy",
> so there is no ambiguity with non-dirs and we also error out
> if a non-dir stack does not end with an "opaque" entry.
>=20
> Additionally, when composing layers, since all the children of
> a directory should be explicitly marked as "merge" vs. "opaque"
> then the parent's "impure" (meaning contains "merge" children)
> can also be set at composing time.
>=20
> Failing to set "impure" correctly when composing layers could
> result in wrong readdir d_ino results.
>=20
> My proposition in v3 for an explicit mark was to
> "reinterpret the opaque xattr from boolean to enum".
> My proposal included only the states 'y' (opaque) and 'x' (contains
> xwhiteouts), but for composefs, I would extend this to also mark
> a merge dir explicitly with opaque=3D'n' and explicitly mark all the
> directories in a "base layer" with opaque=3D'y'.
>=20
> Implementation-wise, composefs could start by marking each directory
> with either 'y'/'n' state based on the lowerstack, and if xwhiteout
> entries
> are added, 'n' state could be changed to 'x' state.

We never add xwhiteout entries to the composefs, all directories in the
base layer would be overlay=3Dn or y, and any directory containing an
escaped xwhiteout would have an escaped opaque xattr with 'x'.

> What do you think?

I feel it may be overkill, as most composefs images would be a one-
layer thing, and adding opaque=3Dn to every directory in the lowermost
layer would just waste space and makes little sense (being in the
lowest layer means we already know if the directory is merged or not).
However, I think it may make sense to be able to mark non-lowest-layer
directories with either n or y.

> Does it make sense from composefs POV?
> Am I correct to assume that at composing time, every directory
> state is known (base 'y' vs. diff 'n')?
>=20
> Thanks,
> Amir.
>=20

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a globe-trotting crooked cyborg in drag. She's an elegant=20
streetsmart socialite prone to fits of savage, blood-crazed rage. They=20
fight crime!=20


