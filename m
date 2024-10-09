Return-Path: <linux-fsdevel+bounces-31497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A501A9977CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 23:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12721C21F81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B51E32D6;
	Wed,  9 Oct 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="R7UXM0jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B51E04BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510535; cv=none; b=NvvL2pq08NaPoOA5qJ4tMnlPe0FqgPaI+dMOJ+FtKpoFtK4a6hBEjlospySsmvfETC85rnWcbpSGOtkRMnydHm1BqXmFP4eeipNdohCFBqUmziHpOwDOP1FLeQJ5M4DERLLQfafxJ/CXbxgReZ+x9Yhhd8bm0xXyONeW+peMyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510535; c=relaxed/simple;
	bh=edJ4Ngh6nKMZUQDj7p8nv9TBFVoS35vEqKbJQdMwY64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVDDDz5NBpE3T7ITM9/rFN+iOBF4ZGknaX8q1y6O5oMCm11dd3LyTI6NYvPClMjg9jiYPrsp3ociQxpDM9B0UXtPjV4q9t1PTKHcGUeqg/tEC7p4ek7XT+38QhfYrsOOEC6E7bUYd0POHX41ta/VJTzQYNSoywPcEGOnlckP+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=R7UXM0jo reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9950d27234so38149666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728510532; x=1729115332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3kqt/YrEBXpzF22FqXng450iXUadO+44FmUUeQtHrk=;
        b=R7UXM0jozaGEWL5W2ISFBlilFQb3e6mlKMNiBiTyWqdkhQ/GhS41btoJfvh07cfAKs
         /P7MZwr3B9mqGLlVxKQ0l/2RyfsEiHAbot1IAxfF9j4BvJcja0pVKEuNnvRG9ePvpCQp
         lucjDhH/KOE//87ENNNvzCQs9IOmKxgZM1006ftTs+EmVfCeyvwIToNFMAn19cnDwSU6
         XAgrsCqAPldBqdVinMnmy5eVwKRCeKvhcZeSdT5tRuQXTHzEzXQebEU5VX8BYiTKU+Ao
         4f8qi72si0CC41bjmQBhGu3s1r774fMqG3mqEqNJ91+CI0A9xwnl3jynBPnCCIxuMYSb
         4+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510532; x=1729115332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3kqt/YrEBXpzF22FqXng450iXUadO+44FmUUeQtHrk=;
        b=YoZaxKPt+X4aiYLV/pCLBqKBpAXH14pke71h99ltNgVl3thCkHsGyGtW9/o686ajKW
         5qPegAf2tcF2wTwE/cdxKZKhVvb1ehBMApmc8XtrD7PXiUIGcmVdjylL9hp9MNqlCEvY
         aQP3tW3rdJa/J4wCVLw5KS5LteSTvO1JlHKGOdDKxAXGbJdi3ol8Muiv0Tb2PyKo2MiV
         D/Ukd9XkoN6RsJRg2DEH50cJjINTgCVXUq4FQl44f22kGlypqjVY4AwdsvbS8dCoO4W+
         3eiKxg97HLjTrWGfbA7MvDXDYt1AvxLnB2Ng/80Yujq1r1bi/EGFy/qMHcpf5OZ+h/3O
         rOIg==
X-Forwarded-Encrypted: i=1; AJvYcCVgJvxKOEfd7Skt+QEtXACHMcSZ9Me6DLy8FeqrM/fFkzc7CVgFUyH/hedI6tnFe6B1ywTjUJKGEFiuKCgI@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOeFIJhTtc7MKUy26AYKm43rQhpSO0F8TmsfN2xW0E7Xrgq7b
	eVf9kXGXCLwvKh+rWzsHtXrVouWdOMTGruiNNBEL1ugWjJ8i9NS2Zl9iQxNkiNcQ14BrsVPkK0t
	HO2cfh2Akf2irNpRTKhAkgAO3Jh/hllILSZuU9Q==
X-Google-Smtp-Source: AGHT+IF+o9hN3tl3XbFpu42cVZG80YygQjNFkPcISTjUO3DEVe8SRqj6y+iFAhnwkLoQDIpv8shkVuALVztjhdYdHhY=
X-Received: by 2002:a17:907:6eaa:b0:a99:68a2:1efd with SMTP id
 a640c23a62f3a-a998d32876emr306530966b.56.1728510532251; Wed, 09 Oct 2024
 14:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009200528.36343-1-everestkc@everestkc.com.np> <263ceb04-f909-45d8-b9b2-5de86617ea25@stanley.mountain>
In-Reply-To: <263ceb04-f909-45d8-b9b2-5de86617ea25@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 15:48:40 -0600
Message-ID: <CAEO-vhH29Xepao5sPvT1qAWfz-w6C-2ajLhhFzmiqLh7gvKMVw@mail.gmail.com>
Subject: Re: [PATCH][next] fs: Fix uninitialized scalar variable now
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:45=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Wed, Oct 09, 2024 at 02:05:25PM -0600, Everest K.C. wrote:
> > Variable `now` is declared without initialization. The variable
> > could be accessed inside the if-else statements following the
> > variable declaration, before it has been initialized.
> >
> > This patch initializes the variable to
> > `inode_set_ctime_current(inode)` by default.
> >
> > This issue was reported by Coverity Scan.
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>
> Fixes: d8d11298e8a1 ("fs: handle delegated timestamps in setattr_copy_mgt=
ime")
>
> Maybe the WARN_ON_ONCE() should be updated to check ATTR_ATIME as well?
I am not sure about that, but even if that is necessary. I think it
should be handled in a different patch.
> regards,
> dan carpenter
>
> > ---
> >  fs/attr.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index c614b954bda5..77523af2e62d 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
> >  static void setattr_copy_mgtime(struct inode *inode, const struct iatt=
r *attr)
> >  {
> >       unsigned int ia_valid =3D attr->ia_valid;
> > -     struct timespec64 now;
> > +     struct timespec64 now =3D inode_set_ctime_current(inode);
> >
> >       if (ia_valid & ATTR_CTIME) {
> >               /*
> > @@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *inode=
, const struct iattr *attr)
> >                */
> >               if (ia_valid & ATTR_DELEG)
> >                       now =3D inode_set_ctime_deleg(inode, attr->ia_cti=
me);
> > -             else
> > -                     now =3D inode_set_ctime_current(inode);
> >       } else {
> >               /* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be =
either. */
> >               WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> > --
> > 2.43.0
> >

