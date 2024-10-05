Return-Path: <linux-fsdevel+bounces-31057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E809916CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E6284493
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2E14AD19;
	Sat,  5 Oct 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZkNRFmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19432231C81;
	Sat,  5 Oct 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131866; cv=none; b=lBxWoMW0HnzKH3GorxrstCwED1cRjnWBDrrmpB5wZ571Ol97KevE90q05pNP+VAEbVfVOpyxl8aVaM1oYuNYTOLImgtwZL5oOxMCK+dWgaWVrj4i9cAPA+jNn8BGQe7ogqkvpgQ/IkG+n3BmnknuKo27Xhxgz8AdDSM2dBQfoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131866; c=relaxed/simple;
	bh=DdH/9gsVIPkzeKKhSXiZMTjh5aWjDgeaP9nuwKM6B0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfjtTjIfrSmrWuEjru5ig+hlY78DjoIxMUV45jS4MEqj6yXbMxLF5IgkVTnHseZviofSeRTPbBbpxlbsPdQF5XMjc9Vg1zTWCJG6ZfVMfIJlwC9HCwVgwaL1JI5rbO4moqICIK3PLKMijT32Wp9RoDArNNO+6kYXeeTbtgYcu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZkNRFmm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99e8d5df1so299036585a.2;
        Sat, 05 Oct 2024 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131859; x=1728736659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oedNx2JEWYoenACq4QBgxY9clB8bBuK49x1vd3Sjkk=;
        b=aZkNRFmmo4QQPDzQTct5QkdOIg1326YgsQt6+QPs6p8ZEn+zoQppNovHO8efZPFknK
         B3NkWuNrRdFZaCsny27AvtXEGQmGT2uUbrm1fe2OgFRacodNnQw6FJFlLjKVMtQCRqX4
         1L7+q5e8ZWspNIRm8pdYeAGQYCS/k38TRPT5ZPKF0p83QXBWrxoKNy5jvkE+1qgzNueg
         9x7tkh2ZRUWCqYIxCkJZJfqO5ME4YF2a0tkDYFAyCX+tNo3ROtsQnyoCHUgQXVpVEUlJ
         91fK50d92debZ+7nxC12T7cgtQ4RqAsErGFucAkAKNKd8Nq5eoTjjdZKfu66aHoYnzKb
         nvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131859; x=1728736659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oedNx2JEWYoenACq4QBgxY9clB8bBuK49x1vd3Sjkk=;
        b=bTiIHL6a8KNPI+bcUKe3kfUSt0sz4V1BMWjaSfPxF4Avs6XJaRPHoujwsJjSqodyW8
         8kGIrczKBZj5nHjUQHcekg7BxhxNOqj3Y3q2f0PxRX5w7FvHWwECiqYcvmOj3lUGm6JG
         LJQeN0kAnGUD+oE+igT8U6HPQbps3nhRqZRFTFDwkn+lm/9QbtAY5DHz0KeK9vH9IvN5
         3IjiyOnmn/wnWLu2uOOt7Zt5Z01fSPglsswCi8dkEgbXVOkZ6pxYMmDr+OEIksMEc3p9
         J05Nmn4qhXqSipT75OvCjJq1aJ2zbiekXmG8wMdbMbgTjgiJ/y4OBE9sidawyQM+byeS
         +ppg==
X-Forwarded-Encrypted: i=1; AJvYcCU6dcN1T+yfgKL6dDTR6VOACPwSX9JocOrdwX9oL+GDD2QXSVh2Mtv+te4vCgkAsiwbeD3w4gNKI1VWySmi/g==@vger.kernel.org, AJvYcCW/xBwpFUEsaAdR/Xm0umW4uFIWLd3ooD3f4Nbgd1YuOV1MChdz+gIrFEVrpXcGcPPC14QYqHD4i9jmiVLf@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRAxLf2TN1eZd1NHmrmGCI66DlLfAqmevLzoEMaSsmYBU+DwS
	GISfTRMe88/uladVlyrKfC1rCcCReuPBGqpmU3dn16Su1VuDP/FnwJNOJVsJmw/YLgNKEbES+8i
	RQ77RZ0uEiHi31mUiqeLLCk9GDy4=
X-Google-Smtp-Source: AGHT+IExRW9JSMn8URNChlDGtgL2trbbqxgOpYx3w8YC6fpPWCQVCxXZdMHV3DY3worWDWlSbFOSag9Xb3hN5o3CegM=
X-Received: by 2002:a05:620a:c4a:b0:7a9:c203:7c10 with SMTP id
 af79cd13be357-7ae6f421dd8mr957821785a.7.1728131858627; Sat, 05 Oct 2024
 05:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004102342.179434-1-amir73il@gmail.com> <20241004102342.179434-4-amir73il@gmail.com>
 <20241004222323.GS4017910@ZenIV>
In-Reply-To: <20241004222323.GS4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Oct 2024 14:37:27 +0200
Message-ID: <CAOQ4uxi5vPmzcuL0YvPzWoqrNd9ARb09pJrmrcGF4YtE6NbM0Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: convert ovl_real_fdget_meta() callers to ovl_real_file_meta()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:23=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Oct 04, 2024 at 12:23:41PM +0200, Amir Goldstein wrote:
>
> >       if (upper_meta) {
> >               ovl_path_upper(dentry, &realpath);
> >               if (!realpath.dentry)
> > -                     return 0;
> > +                     return NULL;
> >       } else {
> >               /* lazy lookup and verify of lowerdata */
> >               err =3D ovl_verify_lowerdata(dentry);
> >               if (err)
> > -                     return err;
> > +                     return ERR_PTR(err);
>
> Ugh...  That kind of calling conventions is generally a bad idea.
>
> > +     return realfile;
>
> ... especially since it's NULL/ERR_PTR()/pointer to object.
>
>
> > +     realfile =3D ovl_real_file_meta(file, !datasync);
> > +     if (IS_ERR_OR_NULL(realfile))
> > +             return PTR_ERR(realfile);
>
> Please, don't.  IS_ERR_OR_NULL is bogus 9 times out of 10 (at least).

IDK, we have quite a few of these constants in ovl code and it's pretty
clear and useful to my taste, but I am open to being corrected.

Anyway, I pushed a new version to
https://github.com/amir73il/linux/commits/ovl_real_file-v2/

Where we have:
- ovl_dir_real_file() and ovl_upper_file() can return NULL and their
  few callers check for IS_ERR_OR_NULL()

> And you still have breakage in llseek et.al.

- ovl_real_file() and ovl_real_file_path() cannot return NULL and all
  their callers (llseek et.al.) check only for IS_ERR()

Let me know if you think this is still problematic.

Thanks,
Amir.

