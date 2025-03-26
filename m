Return-Path: <linux-fsdevel+bounces-45068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94462A714C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D473BDD35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0991A5B9C;
	Wed, 26 Mar 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eRzmj+Ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583631A8405
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984660; cv=none; b=qDH1XVvR+HaTP0kGnPsSq5GMlbtWkCi5/OxPcVL4E+7pkgCoZNEbVy7u20d4j5jfUlXR3pXI4l50PWgwHxBu/IPfSs1Tu6jr7P2jwtQM4nTQtVS/PGumaEwLYnfYwHzWG/z2u3rwF8bJtqnrh4yoMi76akvPS/tMHN0YoeRfOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984660; c=relaxed/simple;
	bh=lZPIEtWGSE0y5u6EupvD4OT9j5kgccDjdrK1LWEGiM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpHHgsMANQtC/RfynCdF3JJbPE1qtdrqQdgB/8rdCzBhdbYZwFvxTHRwhrp3cqQc1jlOlL0cFxLLA5EEkiD7s1ClO1uGZkcZGLcbV+fg+1y1cPsJbja1W48HwbEHpoKTIxuR2mpq9FMkm/xpIBXxTNGxIo9biat4NGIrNJT278k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eRzmj+Ik; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476964b2c1dso124091581cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742984656; x=1743589456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rN9uHgr8U12WiQGTul08dzabhr16jXGifO29BZdVxVs=;
        b=eRzmj+IkF0YKPHSY42mZy1aH4OdhkTvaVmWO8FLoiCCaEAVBwx4uUxAYutCaoeMPRS
         fNZcSNqEcXt8UEjJ8Bt8sP+dVuwv2rHgaYGA8LQZVlPn8SMNVrJg4oh3t0UX4tEUQdhg
         zuRD5Pp1PSftzWwOwP18uIEzLEKXZ4nWH0js0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984656; x=1743589456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN9uHgr8U12WiQGTul08dzabhr16jXGifO29BZdVxVs=;
        b=PALPrp/PmR4JRnW+U9WcsJO5P1qAXbbblHLRMwblMd8biSqNHa+foSIHUfqorul70i
         2taLa575BOK2XAMmxg3mQa9RUxbPipucal/5AC3GmAq2sY4RrP6tCIL2QTOnCGcM9OJL
         rEMBCxP4BlTjr9Hn5OHYDW3xUI9EkMZ/rRtIxsK7/VAW1Hwk+b5hiE0vBL7QjNukmJkN
         FqmOAm5pzuMCpG0Hr5rh1UVo0TydE5AfFAxtsWqFnHpV2X1Dkxy+Qaeu1JS5Wy341vzv
         MAjB5JHyOW2cuBoVRu5DLDBlWfl68aWHvKmB8mL81JDfxcmAcOU1ujfNc0K2V1583lEI
         d0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcIGy5jXHsRPfdGo+tBlIl6M9z+3JDXdbRpCza8stKiGjqmhF0SYX9l7wm97e9ytcKoDqUp/XiJoi7CkYH@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTE/NoB6RNkNw1z7h39jLkz8JgT+5Xnxl4YsQaGOOljONhmKR
	r/HfnGTyCVoP9b1tn53Nj2gGo1krFXhLWOiHVrePl6tXdg/63B5VtVoNQBSpDDZshPp95JZbIvD
	WTzmCdkMagNT0XqxjE65trrldSV0zKHRMsYoYDg==
X-Gm-Gg: ASbGncvVXe4iKSa4kh1b7LW/lCI1Z+AgoElD8FrqZycxBd3GAHUAaQrn/828nXTPmF8
	H6NAxStLWzMeGgxxtrXHPH+UPvuJUa8yCzgXwESLTZF4OQnnUasT80+b2Dtww+5R8jCX3zdpuMC
	A2OgP202g6MKIwwWgoaVyPs/9FDb4V6DjqgBY=
X-Google-Smtp-Source: AGHT+IH0vLhqq3lg+yaWzhqlmKzVspPqQDKFlNiMEjqP6SKmduHR410XaWJXVXMEsHW7vnEmjWa8vn496rkqsY7iD4k=
X-Received: by 2002:a05:622a:5c16:b0:476:b489:8f9e with SMTP id
 d75a77b69052e-4771dd61582mr344077411cf.11.1742984655891; Wed, 26 Mar 2025
 03:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com> <20250325104634.162496-6-mszeredi@redhat.com>
 <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Mar 2025 11:24:05 +0100
X-Gm-Features: AQ5f1Jrs1ZlRc3qM97IRR2sB8E1k3KTYERXzDxx8JPpp_Wy0xPwgBuFeLw2pvJU
Message-ID: <CAJfpegvvRBgYHpuOUuunurwN0Nad+OUdjNOdLw6d1C0kEAg5PQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 12:35, Amir Goldstein <amir73il@gmail.com> wrote:

> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> >                 config->uuid = OVL_UUID_NULL;
> >         }
> >
> > -       /* Resolve verity -> metacopy dependency */
> > -       if (config->verity_mode && !config->metacopy) {
> > +       /* Resolve verity -> metacopy dependency (unless used with userxattr) */
> > +       if (config->verity_mode && !config->metacopy && !config->userxattr) {
>
> This is very un-intuitive to me.
>
> Why do we need to keep the dependency verity -> metacopy with trusted xattrs?

Yeah, now it's clear that metacopy has little to do with the data
redirect feature that verity was added for.

I don't really understand the copy-up logic around verity=require,
though.  Why does that not return EIO like open?

Thanks,
Miklos

