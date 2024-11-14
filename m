Return-Path: <linux-fsdevel+bounces-34736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEFD9C8360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD11F2239E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984101EB9E9;
	Thu, 14 Nov 2024 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLvYPVOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7A1632D9;
	Thu, 14 Nov 2024 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567352; cv=none; b=bljjlfkqfwqjmG26BPJf2860iNBlyMNIblWRgx0f0tF4FFbKMsl6U8Qch+N23RirT9YDovPRU5GLi1wUrOlRJpC/onGZReCSW6JnOVZcT6Gw0Q6YYAuFQYECQpLcl160836h04k00WsHjTv9cCghu+u9jDt6rntg7CXI45JJTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567352; c=relaxed/simple;
	bh=8puQHt8A8Re6ERATjHVjWxjUXpJEcinENsomlkWo22A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7m83egUJC0oK82k5zZM5aSth8DGXMBDMmBKxHbECFfpcZxPHLqrtkO0ds++dchu1QNgysqY9haZ0BMehH/PM4CANiy8AVG3YYuL17TBYP+wV29cVec3v30aU9Jao4LgOmtQ1aIDampy45bJ4G+uYPZEE2RTADbAtSdCVD4F1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLvYPVOx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so1414706d6.2;
        Wed, 13 Nov 2024 22:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731567349; x=1732172149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hjiE/slo1Tn8rXUjiQqwI4+VhdtNv2wIB0sg01zPxk=;
        b=iLvYPVOxZrKSIyzNX9arL0FVpwyXfe47sx0M0MdKZYiI8qcErWKQC0YKHMIq3/wVz7
         MjVu/71Aa02Wxw68h+bsbLvYBgoWbOiIxteqTrPdQwoqOIHaf60x9Tc9FvGPLJCsaDlR
         z/YYuxJL7UWQmcbexa3x+RHIs8/muyCRNoY+nOm/+idFMARa/Ut/xiqmY524o3aMQCjz
         T3F5W2i3627Fe3Gc56FztBp4Au6yM47VtYxVRBjhIHCAOhraDREBLFBrFsoIdHTWbWkL
         qYJAmB2hOcg9jHFkLlirWc2AIp20WCPLx1anvCMdiUC9FPC23whb4JJvx1mdd6OxrPqr
         G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567349; x=1732172149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hjiE/slo1Tn8rXUjiQqwI4+VhdtNv2wIB0sg01zPxk=;
        b=DN+pj/jum5vSuzMWMRsCeUGih0qUIvg2VQ9bIS16NoS+W1xGbUiaKFTrmMXa5U3HNm
         vWd07fnXrReGh4sGSXTBJos77U2pmkIsRkNhvwHVDERErHcnHAAItJ2d234Bod2qT9DU
         wadueByx8CPFQrJ4MovzN2T1ti9xUIHIq6de0Kxe4KIHyW7i68MqY6zeYJyYTDJeWxiY
         2q2/sv2gS6tqz1CX35I+mgArubYg3R9nBb7zn3QX7/MLh28UrGCvG4t/YwsSmsj1EGvG
         3pi45Gs6eZJJPYIvmuNopJTtXTAJfnZxBBk7F5/O99/xgmwgL+xP4nXjTAvhaqc9Pk7H
         OtaA==
X-Forwarded-Encrypted: i=1; AJvYcCVk2FyZO1li2Lcu+3zCr4HOLbXG9tJkQcIwvNPnla4pYlnFX0pz+OP50edE7tPuKm0plCT2qMxTMbpK41N+@vger.kernel.org, AJvYcCW4oV0L6Vq0fGhV8qW3ouA9WUsrb1rMKRiUunbY1BDv1om6KUktzuOmKiBcmxF6uQbblZ7/kZ9RYMAYwKYj@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlpxudLdpno/Ru4XB/DJKeJs6RRMfSjzfnp/Rk2VUJ3rTJoWc
	Yp6zylIMU7Cu8DoBEdyGTT6jP4Xih0AAUt2pnsww4Akrceu4z9YBx6G6VZ9TloSnLyc5vnHvrxt
	9gO8Mu25ctQAOBBkpTq8VxYhlZi0=
X-Google-Smtp-Source: AGHT+IFXyxq0HdSzJxoV/0O0sr6nl4Sxo0DZfVQYBM8oWKj/pzMccRj1tbbs5Xy1nlpXIPweMSqDemmaJH7TjSaSVNU=
X-Received: by 2002:a05:6214:5bc3:b0:6d1:8c91:99f0 with SMTP id
 6a1803df08f44-6d39e1e6e15mr323997766d6.40.1731567349371; Wed, 13 Nov 2024
 22:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu> <20241113004011.GG9421@frogsfrogsfrogs>
 <e280163e-357e-400c-81e1-0149fa5bfc89@e43.eu> <0f267de72403a3d6fb84a5d41ebf574128eb334d.camel@kernel.org>
In-Reply-To: <0f267de72403a3d6fb84a5d41ebf574128eb334d.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 07:55:37 +0100
Message-ID: <CAOQ4uxgAkethXQgfU9jOWvd6PooaOY-kKc0nF12NvERGp5yX+Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
To: Jeff Layton <jlayton@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, christian@brauner.io, paul@paul-moore.com, 
	bluca@debian.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2024-11-13 at 11:17 +0100, Erin Shepherd wrote:
> > On 13/11/2024 01:40, Darrick J. Wong wrote:
> > > > Hmm, I guess I might have made that possible, though I'm certainly =
not
> > > > familiar enough with the internals of nfsd to be able to test if I'=
ve done
> > > > so.
> > > AFAIK check_export() in fs/nfsd/export.c spells this it out:
> > >
> > >     /* There are two requirements on a filesystem to be exportable.
> > >      * 1:  We must be able to identify the filesystem from a number.
> > >      *       either a device number (so FS_REQUIRES_DEV needed)
> > >      *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> > >      * 2:  We must be able to find an inode from a filehandle.
> > >      *       This means that s_export_op must be set.
> > >      * 3: We must not currently be on an idmapped mount.
> > >      */
> > >
> > > Granted I've been wrong on account of stale docs before. :$
> > >
> > > Though it would be kinda funny if you *could* mess with another
> > > machine's processes over NFS.
> > >
> > > --D
> >
> > To be clear I'm not familiar enough with the workings of nfsd to tell i=
f
> > pidfs fails those requirements and therefore wouldn't become exportable=
 as
> > a result of this patch, though I gather from you're message that we're =
in the
> > clear?
> >
> > Regardless I think my question is: do we think either those requirement=
s could
> > change in the future, or the properties of pidfs could change in the fu=
ture,
> > in ways that could accidentally make the filesystem exportable?
> >
> > I guess though that the same concern would apply to cgroupfs and it has=
n't posed
> > an issue so far.
>
> We have other filesystems that do this sort of thing (like cgroupfs),
> and we don't allow them to be exportable. We'll need to make sure that
> that's the case before we merge this, of course, as I forget the
> details of how that works.

TBH, I cannot find how export of cgroups with NFSEXP_FSID
is prevented.

We should probably block nfs export of SB_NOUSER and anyway,
this should be tied to the flag for relaxing CAP_DAC_READ_SEARCH,
because this is a strong indication that it's not a traditional nfs file ha=
ndle.

Thanks,
Amir.

