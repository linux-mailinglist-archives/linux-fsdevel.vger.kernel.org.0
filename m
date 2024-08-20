Return-Path: <linux-fsdevel+bounces-26391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE0958DE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09592830DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633F1C37A4;
	Tue, 20 Aug 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0zqSmJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CC1BDA8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177996; cv=none; b=VfowERXciscNN++xQbWCe+qMhTh4lQ0gotfN7Tdt61KQe9/M+V+IP9cYt9FFDYr++EZJBZDRQdBUUaFiTqDEGu/gEnbUiuvDsyyV7pVkAuktK/P/pZL07AbxYMaKxuaTyf7Cs8dprjcI/LQO+vzLYHP7SNgDVbnN4c7VnFjFt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177996; c=relaxed/simple;
	bh=Z48K+XibslftzZa+2cejdG7u1Go9k9G5I6LFjRMSQg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxJw1DDkHeF9RYHtL36yMccp8pQpECjeqINYOWd10sLj5HbyNc07jPeFV/Ool3UQWbbEnJlUUZyCSoKnBBxW/WMVaDyH2aY20Z9IQEYx3IpH02Y1EKU93vU+J2VRzBo6kJ1QZKW+KHFHY0z1kWlnPKUue9g3xxGNX+jiLIRbDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0zqSmJJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44ff99fcd42so33999441cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724177994; x=1724782794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gt4plaeup3PoWZZfcR33PlFRbf9IOtcKRUvDQ0PJEk=;
        b=D0zqSmJJbRHj8u5lWeLlPPE8DZOyQO15OlnTGBhJ40jh/LIXsIcik00CC9mxwE7SwR
         5W/bLwBrNx3RwQYr+LACC7VN2GkJpcY3jo3ke/tKorZ8mbFR2G2mqE45/R1MboHJCX22
         lhIXeTlfDQ91MCp+ae/lH8oLt/YY7K52dM4F9QJPT3p+IttNjfrsFCh3IbRGCsxBMzWo
         XHugqbSMkFdG3Fvgy1XkT6gz7JUuVy0xotXrfCTqYyszzqnudyhY6lvCOZg7IWcxo34G
         jkhzqHRap7rbZQkUw+wl0bnUrUv8m6hWIOuSb2TmzoWmx34Fn2cE8HHEuwd9Qi2W9rWO
         i0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177994; x=1724782794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gt4plaeup3PoWZZfcR33PlFRbf9IOtcKRUvDQ0PJEk=;
        b=fGaVwsI5/r7CaIltk67HKLAlUaM0OaVYUVivYuROb6LqtxiR5YSnMMPTZRPi2FxumI
         xXF3yn2+Lc9envo4aGA6PHPacuNLtfR2zMU266VqNREISYmG4ZUzJD8FNj94QIXKcMpJ
         a6l3G7RR+OflDUnGmb/cz+AwO37jPM6NHcHJXQ6J3nwBkcCPOMsXY7oKfCAIMQej/Alt
         xtAqdiuoT9rrMHT2vAT5DNfPHZRf+wwpSRrJBwhrVUwcGo+/8YiDJ+9G4bhImopoGROv
         GWRHrVfRKUoIC1gAxX2fYkZFGsJ0rxSRrLCP6+0qwR0UyQqWW3TR4qioWV4sh6tN+eQc
         IlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVnOYMcf22oPbMGDi1sp7skPPOV6hP2Rh+Ai0M28nYUHJdX1Z2+qRog0u/W325H5TaK6iIEI6WVtnQpT7LB84Lqe+Fkzsrps5sZOcYt8w==
X-Gm-Message-State: AOJu0YyG62tentJ4QV3VCxcQ1FayfekHwdz3ZYWP794GN6kbiE2oIY+Z
	M6MP7D0Q5/qgJ1DiRfS07PiBh7d3AK4XCjPeHODuaOdyLEDGy3T2DkBB34jN2gWp8Anosktemkd
	4CK4sK7xEVoqEoqyUxkUXXJL1AYc=
X-Google-Smtp-Source: AGHT+IHdq/7qQhGG/UOwqxg5dtfSee0LCjZjJPaalALsHyI+Qi2MK5zfS0V1GhQik2LZOfMr1U1Q/y5VqgUT2XnJYfg=
X-Received: by 2002:a05:622a:1e8e:b0:447:f361:e2e0 with SMTP id
 d75a77b69052e-453743ae440mr189583091cf.59.1724177994025; Tue, 20 Aug 2024
 11:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182417.504672-1-joannelkoong@gmail.com> <f93cde51-d2f9-40c9-9ebb-fea1fbbf56d8@linux.alibaba.com>
In-Reply-To: <f93cde51-d2f9-40c9-9ebb-fea1fbbf56d8@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Aug 2024 11:19:42 -0700
Message-ID: <CAJnrk1ZT+-30vMSUEVof7RNmrewvft14XbJjknL+y2y45-NrZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: drop unused fuse_mount arg in fuse_writepage_finish
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:53=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
> On 8/20/24 2:24 AM, Joanne Koong wrote:
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f39456c65ed7..63fd5fc6872e 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1769,8 +1769,7 @@ static void fuse_writepage_free(struct fuse_write=
page_args *wpa)
> >       kfree(wpa);
> >  }
> >
> > -static void fuse_writepage_finish(struct fuse_mount *fm,
> > -                               struct fuse_writepage_args *wpa)
> > +static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
> >  {
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >       struct inode *inode =3D wpa->inode;
> > @@ -1829,7 +1828,7 @@ __acquires(fi->lock)
> >   out_free:
> >       fi->writectr--;
> >       rb_erase(&wpa->writepages_entry, &fi->writepages);
> > -     fuse_writepage_finish(fm, wpa);
> > +     fuse_writepage_finish(wpa);
> >       spin_unlock(&fi->lock);
> >
> >       /* After fuse_writepage_finish() aux request list is private */
> > @@ -1959,7 +1958,7 @@ static void fuse_writepage_end(struct fuse_mount =
*fm, struct fuse_args *args,
> >               fuse_send_writepage(fm, next, inarg->offset + inarg->size=
);
> >       }
> >       fi->writectr--;
> > -     fuse_writepage_finish(fm, wpa);
> > +     fuse_writepage_finish(wpa);
> >       spin_unlock(&fi->lock);
> >       fuse_writepage_free(wpa);
> >  }
>
> I'm afraid an empty commit message will trigger a warning when running
> checkpatch.  Otherwise LGTM.

Gotcha, I'll resubmit this with a commit message. Thanks for taking a look.

>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>
> --
> Thanks,
> Jingbo

