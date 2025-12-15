Return-Path: <linux-fsdevel+bounces-71276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E3CBC472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595A0300975A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD33161B0;
	Mon, 15 Dec 2025 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0J9VyDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAEE316196
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767302; cv=none; b=eHNiX44HXhZCMhW5YpGARkAANS+3pOUc5iIMN4yFAUr++sctVbs2isGkdXHa+oqH/bKjr7eMNMYcjPpbFSN9LT+o+mCCOBBRcJ+JsM6MJdeZ3kH90O+mDtiH2FwWoMMmWuLQxM8rRGIlmf8N+anKvgxcfkpQzd10Vb9OcGx2kmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767302; c=relaxed/simple;
	bh=Kp9zbVF4kFemBwseINT4mJFwcUPIDbrZ/5Txfnym/6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNPRtmhV7/vZmHS2GX+nw5Pamd4P+ZqGzEz396bUybNuX8x5go/0FWUFhZ53urdaMzjOuolWZHymlk9nW0ljy/pUJfGqXLSIY8FGVj+6foHgwR/NxVuywg6I7j+/t9U2Qy0wPfeKEF4DzLMrAV365S9nhpb7MuhG6viNetL93ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0J9VyDA; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598eaafa587so3525734e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 18:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765767299; x=1766372099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yINQVmSvPcE7yFXEzBYc4Tr5qH2QgH+cSaWoGbSwl/s=;
        b=d0J9VyDAeYy6Agsl0Kt6CbW5oU6vj9QcBk9dGuK1VsW2SZJH7ovJ1NPlzlT7I124rW
         BoyPTogZsFNyjhce40RJm/kXTRFd8Vzu6tIFC2H1HjsMPB7n1Dyrrpu2y9lkan7iIcQh
         L+VFCs78USYPVFq+kw6NWIXEQBGBnAd+Fhk2Id+P04IxGiiEypcbeCyJr6nqpAHVW6BZ
         0E5EiJgygzvDkAboOiE5S9dFGZdUd8kzzlS/jSOLClzYhRCNqdy7z5qD/GgAxFJ3vUMU
         O9ErN1JXbFmdiB03NVuAkmzSqlflbr0+nuneOierlW1v2BMCz6Q41NlrCrDwfjl5G091
         Pm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767299; x=1766372099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yINQVmSvPcE7yFXEzBYc4Tr5qH2QgH+cSaWoGbSwl/s=;
        b=sfQ7FkbIBKHa1wZHBKZ8FAzmOy1xrsugJ+0SMTzNIPvK7SeJ4i1pQ2y/+x3PciEsju
         WgUIfMbCyQBPJ366U/YuWslni6n2P4nPtyjGdRvDVxdEpoIddY5oYZtqR0dFW+ENMES1
         l5I3TO9FmuGVL6tyAKuWKg2otdfb03zOd1Fw+pjOyv53UVWBC9PN1V3hZoE9ybwSsOwi
         Qx4WQPV1fal9fD2T9QabBo4vKE4riPKA+DXfqYKw4O/aNX0EMglt273fEbWw9Plbgy0A
         Emw6LAFpnH03hxFLPPTKV9Kx2KLDQr50YsBvfLsa28bk9+XPnYKlvkRol0a1ysdi0m6t
         VLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0BAdR0GnsKMUrqxUcygrk8WiwY90JSjcIyOqvDk3hppB92TrjI2E/6VCYAWkun6612jeKuXLGujDvy7L+@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdakUME30QR+kAxS6VihdHE26IvincPPqj5zAp08mtFA11xUa
	5FaHsrLxrz/8ygXSSk8hzJhuxWPXKPSahC69az4TU9yiqLeGxSgUAou/RjZPw6pcWfiqznlfQXM
	BdZcolN2+vPWRhNZzwRuIafJ9taF1yAW+FkMqb6mE7g==
X-Gm-Gg: AY/fxX4n4EAjNWKjTcX7kMi4cK29zUYi8e+/mmziXjpdcUER46hWNwHTw+QqTHTu/G4
	hEMl58ZnGttW5AYvx1UscbEs2gE8Yc75Tr6h0AgauJ2BMutj4L59dDIn7yzlSGIrWyN+IhhYp5m
	b78DwEmCbbLz7/4pHsqr+ugmTLDT6T1QQ386yT7xkh2y7aSnroEkDs11tfcZ9IJf/pK/7UNogFV
	jn3GqfwR9tImKL9SqqTbxt8NmCwn7N4lU2OuO0NofQ/6gKrL9GdB1NGojjXUgrDQUx8/UxLY5R5
	Q9st
X-Google-Smtp-Source: AGHT+IGpusUmZh8HbtrvVQVJ/17Buz28JxGMInxTkhQelBVMThpH2/jWIs+qOJ/K+yFj8ZkVPREYbFSnL6U6iouCl6M=
X-Received: by 2002:a05:6512:244:b0:598:fb04:246 with SMTP id
 2adb3069b0e04-598fb040261mr2165045e87.32.1765767298651; Sun, 14 Dec 2025
 18:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
 <20251126-untragbar-hanfanbau-164f0425c5e5@brauner> <CABQgh9GhoeCaoVpL7nErfzAQHHykY_Y83tqzSByx180kXno5aQ@mail.gmail.com>
 <CABQgh9HuOB9Zcv277Sstdubz7q-Be8+aGeoNE5xrTfkjdz0u+A@mail.gmail.com>
In-Reply-To: <CABQgh9HuOB9Zcv277Sstdubz7q-Be8+aGeoNE5xrTfkjdz0u+A@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 15 Dec 2025 10:54:47 +0800
X-Gm-Features: AQt7F2r6ejJeJS6jt9q9MY1naFvP_ksUUU961WUJnFfmJ85Q5Fc2WKfr1tnYTw8
Message-ID: <CABQgh9GW+xfrGzESY_OT4A1x-QvpzWNuAZHh8otaydT5v6fWOg@mail.gmail.com>
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Wenkai Lin <linwenkai6@hisilicon.com>, Chenghai Huang <huangchenghai2@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2025 at 10:08, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Christian
>
> On Wed, 26 Nov 2025 at 19:01, Zhangfei Gao <zhangfei.gao@linaro.org> wrot=
e:
> >
> > Hi=EF=BC=8CChristian
> >
> > On Wed, 26 Nov 2025 at 18:27, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > On Wed, Nov 19, 2025 at 10:15:40AM +0000, Zhangfei Gao wrote:
> > > > Currently cdev_device_add has inconsistent error handling:
> > > >
> > > > - If device_add fails, it calls cdev_del(cdev)
> > > > - If cdev_add fails, it only returns error without cleanup
> > > >
> > > > This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> > > > establishes a parent-child relationship.
> > > > When callers use cdev_del(cdev) to clean up after cdev_add failure,
> > > > it also decrements the dev's refcount due to the parent relationshi=
p,
> > > > causing refcount mismatch.
> > > >
> > > > To unify error handling:
> > > > - Set cdev->kobj.parent =3D NULL first to break the parent relation=
ship
> > > > - Then call cdev_del(cdev) for cleanup
> > > >
> > > > This ensures that in both error paths,
> > > > the dev's refcount remains consistent and callers don't need
> > > > special handling for different failure scenarios.
> > > >
> > > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > > ---
> > > >  fs/char_dev.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > > > index c2ddb998f3c9..fef6ee1aba66 100644
> > > > --- a/fs/char_dev.c
> > > > +++ b/fs/char_dev.c
> > > > @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct =
device *dev)
> > > >               cdev_set_parent(cdev, &dev->kobj);
> > > >
> > > >               rc =3D cdev_add(cdev, dev->devt, 1);
> > > > -             if (rc)
> > > > +             if (rc) {
> > > > +                     cdev->kobj.parent =3D NULL;
> > > > +                     cdev_del(cdev);
> > > >                       return rc;
> > > > +             }
> > >
> > > There are callers that call cdev_del() on failure of cdev_add():
> > >
> > >         retval =3D cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
> > >         if (retval !=3D 0) {
> > >                 pr_err("dvb-core: unable register character device\n"=
);
> > >                 goto error;
> > >         }
> > >
> > > <snip>
> > >
> > > error:
> > >         cdev_del(&dvb_device_cdev);
> > >         unregister_chrdev_region(dev, MAX_DVB_MINORS);
> > >         return retval;
> > >
> > > and there are callers that don't. If you change the scheme here then =
all
> > > of these callers need to be adjusted as well - including the one that
> > > does a kobject_put() directly...
> >
> > The situation with cdev_device_add() is different from the standalone
> > cdev_add() callers.
> >
> > cdev_device_add() explicitly establishes a parent-child relationship vi=
a
> > cdev_set_parent(cdev, &dev->kobj).
> > If we simply call cdev_del() on failure here, it will drop the referenc=
e
> > count of the parent (dev), causing a refcount mismatch.
> >
> > Direct callers of cdev_add() (like the DVB example) generally do not
> > set this parent relationship beforehand,
> > so they do not suffer from this specific refcount issue.
> >
> > This patch aims to fix the cleanup specifically
> > within the cdev_device_add() helper.
> >
>
> More explanation
>
> Now the code:
> int cdev_device_add(struct cdev *cdev, struct device *dev)
> {
>         int rc =3D 0;
>
>         if (dev->devt) {
>                 cdev_set_parent(cdev, &dev->kobj);  // here set parent
>
>                 rc =3D cdev_add(cdev, dev->devt, 1);
>                 if (rc)
>                         return rc; // case 1
>         }
>
>         rc =3D device_add(dev);
>         if (rc && dev->devt)
>                 cdev_del(cdev);  // case 2
>
>         return rc;
> }
>
> Since the cdev_set_parent,
> cdev_add will increase parent refcount,
> and cdev_del will decrease parent refcount.
> So case 2, no problem.
>
> But case 1 has an issue,
> if cdev_add fails, it does not increase parent refcount.
> If the caller calls cdev_del to handle the error case, the parent
> refcount will be decreased
> since there is a parent relation, and finally got refcount_t:
> underflow; use-after-free.
>
> So for case 1, cdev_add fails, it does not increase parent refcount.
> needs to break the parent relation first.
> then cdev_del does not decrease parent (dev) refcount.
>
> Finally, both case 1 and case 2, calls cdev_del for error handling,
> and refcount is correct.
> It is easy for the caller, otherwise it is difficult to distinguish
> case 1 or case 2.
>
> Thanks

Any comments?

Thanks

