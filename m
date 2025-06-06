Return-Path: <linux-fsdevel+bounces-50821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDEACFF12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72E16CEB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267E286427;
	Fri,  6 Jun 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmRQaE09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCE2853FD;
	Fri,  6 Jun 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201527; cv=none; b=FtI3bcAToFFanwrjzaEdI/yGbhN6wVCRcIkDNFSEzuhjfY1hSOG+eXh6D2b5gbqHLtVwbadDV373tujCEhvOoK74Xg/wy62Iq4ZD71V2HDhlDitXGsWVPMwNm8HU6cXFxVNACHzeo1KtxNh5IPHzzgtXv+gKblAG8iqSHZMjRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201527; c=relaxed/simple;
	bh=1HGk21Eiq3Ornoie3mRnUcMbuUSV/KVnZXIdTW4A3hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlXRz0Lbgsda5h8t7xnrJxTlzUd6KDrD/ytK3tKXODxJxqssLzMGbOPUOxnM0YWlYQg+AlBYXUfXvo69c7NTpMY/9AxsQqn3BrQSMmk9Y6NpxU3cREzAVqzfJcuNbfOmFuE5Da4yb+5m4Ffjc9iRpsUsZJe6fIEuKl2UdXp1L7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmRQaE09; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so1729857a91.1;
        Fri, 06 Jun 2025 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749201525; x=1749806325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IgJlEGMMW0E+kGR6e7y8QkMFTFJ1CqPMoRJ4HFJZyM=;
        b=MmRQaE09y7PE+5Ku7VKWbdU/8SV/6UElJLi0D1vh7rXOmOjQ7hjWczCOp6UAuiejnS
         u1rAsDimsUaOTpb3hB6AC2HXB/7TDnnayUUSK7hEitYpOXyfB/mcpxYTbsf9BuLAGmgS
         XqGxywS9gj1ft5/b+WPzpBmcLDCGQfvSUvL5ERkKhnxdnN8sWea33oykHzXQOJ49rBbQ
         3J5ptPVytvNKAzrzExt8cwQ8Z2n8Gq4MuMeewG3hs1PMYAzWSUrcEUE8uRYXGY1aFXlF
         uEgCth0he/b7Z0TNyYFpIB0LOI1xh3OgBMgghBatjuc03zEcDdw0tyBBqnhsQI2NErBf
         3AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749201525; x=1749806325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IgJlEGMMW0E+kGR6e7y8QkMFTFJ1CqPMoRJ4HFJZyM=;
        b=sFGFKrYUHCpL9I4iDqr+gEpNZLTE6DJGvNnMu0iJfvySASNmoax/9C8Q+ium81i2zM
         o/Lyf2xSbFuHbil+jaSC5mcn1288bV2fvx1kC8X+bUaMu1HHXkpp0XFR/yo4JF0QipQe
         uhfFiKsWZ39MfkHFu33Jt6hhxwAKENhKCzfP7ndt8wH5kp/VjTjjAew/QSD9BopaKPVD
         gPpfc4aUdCtnUj50n0/EMHmPxyCY9/wPJGCRWFRn1itgxSn9cXysMFhyawXYNSeCgehS
         tb3Xhs3jOra+GeqcfL7VER5o2qSLlO0szr7vVw90vvdUYvCQiShNoADyEo4MplOnRlDM
         2rRA==
X-Forwarded-Encrypted: i=1; AJvYcCUnQNcLkh7spBOeGBICVE4YQjcQEBp1QxPtRMq+iYvo6LZQPJO0gEvTTwL3OpqJoPde1uFqxh+xeYo0@vger.kernel.org, AJvYcCVs667DeskcJRd69PsHIULNsnOi6EV+Edt5cxzd33sD/H4TrKMwP7npMDCydZOWEx4WSA05UZBrd2A5jUEpkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyhn5g5AgJI3GiC6zQd3EQwyxh2UVANT9swAsCQgf1m1U7alAq
	rSx8z7OtHieIYjDOOHhK/NGls7bBN40VlLpW1Gh3Txq7enbPAG2XU6Qpm6+gXWheVtvpIUgRRTR
	mqxO5BmhLrB7MgbOFzAw9lD5BNegaxIk=
X-Gm-Gg: ASbGncuL3xYiC7mRj4DkwRSF39GzgqyIRRdplyg9/fe3J20KIdT1JDfDyFrcW6hlUQX
	eBBaoK0AEuOjANUWgM/812BdhApqEBG6fI8VzWQEg0Z3egeSFgpwz0nM2Q1NpvoTXw+bll9iVL2
	KISBH5d92rH69FS7ubc+KgVuVUzutrh30t
X-Google-Smtp-Source: AGHT+IFtHsXb/wEKlMdKDeBBsR6ve28PtDlk2x+acryGeG4OycoTx65wSY4OMXRPsKs09oPm/G9HBG24JbS2Wkgg+5s=
X-Received: by 2002:a17:90b:540f:b0:311:a314:c2d1 with SMTP id
 98e67ed59e1d1-313472d64a9mr4013077a91.6.1749201525151; Fri, 06 Jun 2025
 02:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602184956.58865-1-slava@dubeyko.com> <CAO8a2SgsAQzOGCtejSka0JnvuzoespHDvwa0WNpg4A9L5QJcVA@mail.gmail.com>
In-Reply-To: <CAO8a2SgsAQzOGCtejSka0JnvuzoespHDvwa0WNpg4A9L5QJcVA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 6 Jun 2025 11:18:32 +0200
X-Gm-Features: AX0GCFsj9mCnQ7HWKOPCGObzZhsx_cB1gxbgieJN1bK0Zjd3oAMXWBuNR-PnGbw
Message-ID: <CAOi1vP_g8S_JZOqgoAViEnEAEHeLYF1th6zjpsQD3eXApc9A7Q@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix variable dereferenced before check in ceph_umount_begin()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, dan.carpenter@linaro.org, 
	lkp@intel.com, dhowells@redhat.com, brauner@kernel.org, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:25=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Reviewed by: Alex Markuze <amarkuze@redhat.com>
>
> On Mon, Jun 2, 2025 at 9:50=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > smatch warnings:
> > fs/ceph/super.c:1042 ceph_umount_begin() warn: variable dereferenced be=
fore check 'fsc' (see line 1041)
> >
> > vim +/fsc +1042 fs/ceph/super.c
> >
> > void ceph_umount_begin(struct super_block *sb)
> > {
> >         struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> >
> >         doutc(fsc->client, "starting forced umount\n");
> >               ^^^^^^^^^^^
> > Dereferenced
> >
> >         if (!fsc)
> >             ^^^^
> > Checked too late.
> >
> >                 return;
> >         fsc->mount_state =3D CEPH_MOUNT_SHUTDOWN;
> >         __ceph_umount_begin(fsc);
> > }
> >
> > The VFS guarantees that the superblock is still
> > alive when it calls into ceph via ->umount_begin().
> > Finally, we don't need to check the fsc and
> > it should be valid. This patch simply removes
> > the fsc check.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.org_r_202503280852.YDB3pxUY-2Dlkp-40intel.com_&d=3DDwIBAg&c=3DBSDicqBQB=
DjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DUd7uNdqBY=
_Z7LJ_oI4fwdhvxOYt_5Q58tpkMQgDWhV3199_TCnINFU28Esc0BaAH&s=3DQOKWZ9HKLyd6XCx=
W-AUoKiFFg9roId6LOM01202zAk0&e=3D
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> >  fs/ceph/super.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index f3951253e393..68a6d434093f 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -1033,8 +1033,7 @@ void ceph_umount_begin(struct super_block *sb)
> >         struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> >
> >         doutc(fsc->client, "starting forced umount\n");
> > -       if (!fsc)
> > -               return;
> > +
> >         fsc->mount_state =3D CEPH_MOUNT_SHUTDOWN;
> >         __ceph_umount_begin(fsc);
> >  }
> > --
> > 2.49.0
> >
>

Applied with the Closes tag amended (Proofpoint URL).

Thanks,

                Ilya

