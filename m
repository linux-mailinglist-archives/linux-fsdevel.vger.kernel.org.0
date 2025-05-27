Return-Path: <linux-fsdevel+bounces-49899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6DCAC4ADD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09A17A82A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61D24C669;
	Tue, 27 May 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/oYDITs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF41F8723;
	Tue, 27 May 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336240; cv=none; b=P8OHj5ppXgf7qNLEDwmTh/LulDFuVp0uUp/N43ycJ7PjipQelUCg8EUbCYp6gR7+9AG//Xxuko1hmpiaIpYXxDOIMBVspvRxiHODgiOSggWTKKu5EPfR2JlKStNyBjDNglO9F9vLms/mMjK5ZbVdJEnTXgcIlv5Cexbu2PJQ04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336240; c=relaxed/simple;
	bh=uACMKfkzBA2kB+oxSgbbiLUgc8byLiQKI99tX5icx28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2GY6PEJ+yk65jHSajGsvi4Wj64+0DnAUZNm/qgv6P7KbW157rGRq3Yhk5nN86OZQ58699tq/OGwfg4n91h6BN0ovF1InN4z0b+DZ4iL4mKdpE0a2K4KtBmhAUVVToRsbfBGW07cE+ZN+4/owGkgeF4v3hc5E6oGm2eD7N/3UNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/oYDITs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad545e74f60so411551966b.2;
        Tue, 27 May 2025 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748336237; x=1748941037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKxVaFzF6+KJF+8fa1OyFFkqNNjJrhK2jwwjyfkpkVI=;
        b=B/oYDITsR6j2HR82D3tuSvLeGgFHCqh8yclIfEA7gAbRvDcViZCZmaJApHvWiWobhN
         aL8J0sFgOs3lgInLwkXuGjLNriI8cF3fB5dnoGVgH8sAj6CVbd3TTkqjuCMCEmAREkPS
         dch3Mg6lDQyRTVZgOEN+ZrrvNSZc2yBsz1h95YmkfJAPXHI20fv4rdllRs7SZcRsTzOn
         0Z2bzsq6dlN4g7PKuYd9zsWss67TKJVLwGYY1E66XcXVgVB6cgW3bYRaDQ4PzmMkfJlf
         noiMEK6VG6BrNIPBoPvWygczGAsnrG46FzZrZevEI50cjBB+7rlabG6pP/DZnzz+ch+C
         ip5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748336237; x=1748941037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKxVaFzF6+KJF+8fa1OyFFkqNNjJrhK2jwwjyfkpkVI=;
        b=PpUpGh5yna75qeApDRpsuf4tZielkZEjMUu5R5azT8DsQ1cWeVCkLsC4V854ll2b1b
         PMo2TG1griTc9wGywdJ4RYhzj5rFFRoo8xkhtg1M6pm0HY5u9W7x6EZRFslnDmZBTljl
         fuNL7Nu3jb+Y5/xsax1x0Q4bCu9MuUrFOtZuq/QJ3MdlKT9BVr13//tkxcKB+yu0MZs1
         UHjBRI0hDEpd6rprmKHyyWDMGHR6e9rE5jwOYNW4UWy4ZckThTjZtyjlOno13idN821l
         rD4kRDOQ2DwnRgIusAJp1Ufo5LtlH68pssQcX4NgaNUFqa31CDbCVSKMn61zt3THDsdy
         eStA==
X-Forwarded-Encrypted: i=1; AJvYcCW54IZpfW69HcgEH0nIj2jHnKGruWjU9YkXpoBA5Nrn9V7xbYrun0/DeRBMb8Lcwdb4MtOoCxzX0YvJCZsBHg==@vger.kernel.org, AJvYcCWXIF1/g8/b5yekJmBbJKwVpjVqGyy2nu2nvkHBKvjlA4jOC8TrGuK2ttsMLrD71oqq6wfC8F43m0gs0rMh@vger.kernel.org, AJvYcCWcKh0FS9CY6sD9fB62S0mOwkuPxwbVfpN5SsE4LbmesOGmoK3cmgRQNd3lCDAzkHLOXRr/odJNaicaeCay+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmMWtb/Hvz23RB+9P1jsjbqzphGUbzvincgr2ycXyIG8dgZn6
	uxH7vic0U48Obeh2H2b46SFiVj+w17vQQ3IKrqu0G139fPTR3SlpmGFJQDNy76oiwk8/M6gg6AZ
	mz8t52y4S37xmtvDATbe9ed2udvHgxqMCR+KzeNLHYA==
X-Gm-Gg: ASbGnctTgk2xtnEmK4qIenSbhNT48SjAns8kmBvjLdmDrsQ/ZI6GYuNLsO4rHxzBr1s
	Lj58gSPpfBmYF8fTm32fm4Sx7TF6ZEzKGmRaTw/S9MaMArt29XWDbXopqutA5ZNz03sUC9a5fUJ
	Ik75QHCvGdTKNcnvZOZlw/ONPr3fkSEC0dbglemeaLBRY=
X-Google-Smtp-Source: AGHT+IHVs8njt2KBEJX/07e/Ryda/NWidOm3vNXx5ZDQnPBMIvUeZunmpT8hnfMHyEoM8GGL97wXAj2nkpg+QTBQui0=
X-Received: by 2002:a17:907:9619:b0:ad8:8efe:31fa with SMTP id
 a640c23a62f3a-ad88efe3d04mr147231666b.58.1748336236763; Tue, 27 May 2025
 01:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
 <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
 <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
 <CAOQ4uxjHb4B1YL2hSMHxd2Y0mMmfpHMzgbHO5wLF3=rMVxsHyQ@mail.gmail.com> <yp4whk37id7s4za6fv3ifvqjupo6ikylu34wvgd3ytbyu3uz2c@t7h3ncg6pwtz>
In-Reply-To: <yp4whk37id7s4za6fv3ifvqjupo6ikylu34wvgd3ytbyu3uz2c@t7h3ncg6pwtz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 May 2025 10:57:05 +0200
X-Gm-Features: AX0GCFsJMz5hiqOFQRMJJ-fNnByWxkejNxR6qjLwPk8WOwYA1z-N6BdDtbHn2B8
Message-ID: <CAOQ4uxg0-ZJYDMfMLNVm=YfA9CdjY2WaaXYdv+i8nWNgqPgpuw@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 8:27=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sat, May 24, 2025 at 03:01:44PM +0200, Amir Goldstein wrote:
> > On Fri, May 23, 2025 at 11:10=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Fri, May 23, 2025 at 10:30:16PM +0200, Amir Goldstein wrote:
> > >
> > > That makes fstests generic/631 pass.
> >
> > Yes, that is not very surprising.
> > I meant if you could help test that:
> >
> > 1. mounting case folder upperdir/lowerdir fails
> > 2. lookup a case folder subdir fails
> > 3. lookup in a dir that was empty and became case folder while ovl was
> > mounted fails
> >
> > For me, I do not have any setup with case folding subtrees
> > so testing those use cases would take me time and
> > I think that you must have tested all those scenarios with your patch s=
et?
> > and maybe already have some fstests for them?
>
> Unmount fauls after I test an overlayfs with a casefold subdir:
>
> Testing an overlayfs on a casefold fs with non-casefolded dirs
> Test using casefolded dir - should fail
> overlayfs: failed to resolve '/mnt/casefold': -2
> mount: /mnt/merged: special device overlay does not exist.
>        dmesg(1) may have more information after failed mount system call.

Test is using the wrong path:


+    echo "Test using casefolded dir - should fail"
+    ! mount -t overlay -o
lowerdir=3D/mnt/lower,upperdir=3D/mnt/upper,workdir=3D/mnt/work overlay
/mnt/merged
+    ! mount -t overlay -o
lowerdir=3D/mnt/casefold,upperdir=3D/mnt/casefold,workdir=3D/mnt/work
overlay /mnt/merged

There is no "/mnt/casefold"

> Test using a dir with a casefold subdir - should mount
> overlayfs: upperdir is in-use as upperdir/workdir of another mount, acces=
sing files from both mounts will result in undefined behavior.
> overlayfs: workdir is in-use as upperdir/workdir of another mount, access=
ing files from both mounts will result in undefined behavior.

Those warnings are because you have a stray mount command above:
+    echo "Test using casefolded dir - should fail"
+    ! mount -t overlay -o
lowerdir=3D/mnt/lower,upperdir=3D/mnt/upper,workdir=3D/mnt/work overlay
/mnt/merged

So a mount already exists. leftover?

> ls: cannot access '/mnt/merged/dir/casefold': No such file or directory
> umount: /mnt: target is busy.

Not sure about that, but could be due to the aforementioned stay mount.

>
> https://evilpiepirate.org/git/ktest.git/commit/?id=3D47d1f2a04d79bc4cbc84=
3f81e71eb7d821fb8384

Please fix the test and report Tested-by if all works as expected.
Please include dmesg so we can see the new warnings.

Thanks,
Amir.

