Return-Path: <linux-fsdevel+bounces-69874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C42C896DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F113AFE77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B22831C567;
	Wed, 26 Nov 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tguOnAVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2B148850
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154901; cv=none; b=bNWq4aix9iYz8Xpwvo1ZCQ+RBj1ONq9WQ9HRMHVQVSMn+emzpKTYO5YmalkpHQb+eM/HBnMG9+JfbjYp2zO/+moYmJWt9K8ZyzPARe9lVhm9BRs8NZIL9Ge6cTYQCkOsO0GFyd96YPt0Gmh6VGnp8uEJksyh8pK16XK3pxnj2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154901; c=relaxed/simple;
	bh=OZX/B0B4NvOV6sgPttMcUqAUSRoO0+n3slNCPGM/n3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me9wdaoeaFyOtY+6zRPb9Ihj/4/OzY5f/BbOogGBDOUfBzHJd9lzAjMHic2hUOdssCzwCZGY+LzzKsLLMYOdDaOinmJ5TPjr8KARDDe8yDnNlSKfU4exdS2tR4VKfwT4Kf2Lfn1pEILzv1XGPIZmCq7iSsOokLK9iZJb7d9ljHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tguOnAVh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37bbb36c990so6415691fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764154898; x=1764759698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4pv3oSvVx1v+N0D+r495UOPRyOGN5nzuY0/x0NLA/g=;
        b=tguOnAVhL0nZcphOSa8uOECLeWGIBkHxX8iGBZUXONuIKnQoEBTLKbky8ziLo4Oy/U
         kpodTIWQ7Wdi13fuoUiTb4bkA92KDU28d7/qlRB2m6Zcqp9RC3XUHSS/hRt6/C0ImSg0
         L/HWyuCmisGZbiWr6aDnAnx4Kv3IDmlBSUclMEjFi51XCHh101mSOjz8uLUpkhPF2K+F
         RfkFDOIPDyflGPi0wXh/kGjp8ZkYW8tReiFltvdCOKJIAUUATANPVCh5eFKurhVuT9U9
         po8gSklPUeK8XZnusUdEgLsYslZyA0Yk6PEyEXsOmr/2nyvPFvd3Ohj1wXhh/q38h3Ky
         OrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764154898; x=1764759698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4pv3oSvVx1v+N0D+r495UOPRyOGN5nzuY0/x0NLA/g=;
        b=GtASu6rmF4/KJ+9ulvfmc1Pb9PShmkOFMPf4ybU1yjRYmwZT+0lZAFqbGN/GsmT938
         WqAWb26b07zxvjFRBFoLY+eMIRpf9ibUejVwcct6FjymK6TXAq2tanCjcr7RHanenN7k
         tOpPgbo7RWG5yYGscT5lO8t7WIBrFDZrRKSYTwyQ1s1MnT2z63mhvSYbJmuPzsVIh01t
         jPmDS1Xgg5SPPKTfNDGsWLJr7YA9bR2r7MIKXWZZ0fepARSg3V4aNqfb8FL5fOiu6fP7
         AAxpskPn1KFN+2zYv/XP1W0A7IBnoGq/CRB2rHG5NkVdvCHn4gHZoA+C6zE8bt/HjNuK
         myWw==
X-Forwarded-Encrypted: i=1; AJvYcCV8yJtDkWGcD/0jWKojJCo5LHP+P6XOrnCldibWrLMvLQ3Xg/euXJUPLI1DHo/oq4t6u9ffcDa4VR7nvOs4@vger.kernel.org
X-Gm-Message-State: AOJu0YzangNMTI7jIZSluO8h5gE8JiTmgJE/UVvUnYOs5Uzosx+UKtun
	zaUMpLXr4z3s8BG1tug6DV6Yr6I5eHs/Q8qfSNcwtp6nq+m8sFDlRa+2PyKUQ4w1YiNEGMJjnBw
	wX/61FF1m8Uu+bFFmcId7V0YAOawRuJc+xA4X1pG2Bg==
X-Gm-Gg: ASbGncu+omT+Lf+5LtQNKuwkj9J0xr5KstKIhiwRHbTBSWUivjEHWmwmZsdGWxkmPRR
	PwtCOPrvnUK1meMja/oXwV+dKi70w5uHRnhunAsxCFQGa3dRYyj5NIMNqwjAcaOiWGdJA7jKgzb
	3OYHaZjricKJz0xCDaj9DVInfff/l9SpVgGSrfG/asu5kliXGrNy4w7IYTtcFrPsjQGdy5A3YpE
	npJG9TNjZr24fSZoKGIoQ1QlbUzT+7KLnGTwBYiSUAqS0fkaezK09HZW6CNhiIpk5/HXyo=
X-Google-Smtp-Source: AGHT+IGpE0bZuTq5thG45fL1oFhM9RHJfJ8m4o60VFkrJkadMrsv3MiRsL56Vze7x7Y7sTfhoV4f6tQq0JEZ67aFHrY=
X-Received: by 2002:a2e:bcc7:0:b0:37b:98d3:7bc8 with SMTP id
 38308e7fff4ca-37cc83957c0mr63533321fa.20.1764154897590; Wed, 26 Nov 2025
 03:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org> <20251126-untragbar-hanfanbau-164f0425c5e5@brauner>
In-Reply-To: <20251126-untragbar-hanfanbau-164f0425c5e5@brauner>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 26 Nov 2025 19:01:25 +0800
X-Gm-Features: AWmQ_blF8cLReSbgymmW-eZc3QqP9dP57WG4HQaD85L9BDdcxhBbxRV7JySbkXY
Message-ID: <CABQgh9GhoeCaoVpL7nErfzAQHHykY_Y83tqzSByx180kXno5aQ@mail.gmail.com>
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Wenkai Lin <linwenkai6@hisilicon.com>, Chenghai Huang <huangchenghai2@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8CChristian

On Wed, 26 Nov 2025 at 18:27, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Nov 19, 2025 at 10:15:40AM +0000, Zhangfei Gao wrote:
> > Currently cdev_device_add has inconsistent error handling:
> >
> > - If device_add fails, it calls cdev_del(cdev)
> > - If cdev_add fails, it only returns error without cleanup
> >
> > This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> > establishes a parent-child relationship.
> > When callers use cdev_del(cdev) to clean up after cdev_add failure,
> > it also decrements the dev's refcount due to the parent relationship,
> > causing refcount mismatch.
> >
> > To unify error handling:
> > - Set cdev->kobj.parent =3D NULL first to break the parent relationship
> > - Then call cdev_del(cdev) for cleanup
> >
> > This ensures that in both error paths,
> > the dev's refcount remains consistent and callers don't need
> > special handling for different failure scenarios.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  fs/char_dev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > index c2ddb998f3c9..fef6ee1aba66 100644
> > --- a/fs/char_dev.c
> > +++ b/fs/char_dev.c
> > @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct devi=
ce *dev)
> >               cdev_set_parent(cdev, &dev->kobj);
> >
> >               rc =3D cdev_add(cdev, dev->devt, 1);
> > -             if (rc)
> > +             if (rc) {
> > +                     cdev->kobj.parent =3D NULL;
> > +                     cdev_del(cdev);
> >                       return rc;
> > +             }
>
> There are callers that call cdev_del() on failure of cdev_add():
>
>         retval =3D cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
>         if (retval !=3D 0) {
>                 pr_err("dvb-core: unable register character device\n");
>                 goto error;
>         }
>
> <snip>
>
> error:
>         cdev_del(&dvb_device_cdev);
>         unregister_chrdev_region(dev, MAX_DVB_MINORS);
>         return retval;
>
> and there are callers that don't. If you change the scheme here then all
> of these callers need to be adjusted as well - including the one that
> does a kobject_put() directly...

The situation with cdev_device_add() is different from the standalone
cdev_add() callers.

cdev_device_add() explicitly establishes a parent-child relationship via
cdev_set_parent(cdev, &dev->kobj).
If we simply call cdev_del() on failure here, it will drop the reference
count of the parent (dev), causing a refcount mismatch.

Direct callers of cdev_add() (like the DVB example) generally do not
set this parent relationship beforehand,
so they do not suffer from this specific refcount issue.

This patch aims to fix the cleanup specifically
within the cdev_device_add() helper.

Thanks

