Return-Path: <linux-fsdevel+bounces-72233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F38CE90F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9575A301E9A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B02322B6F;
	Tue, 30 Dec 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCtebODr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37585320CB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083731; cv=none; b=guWmzyP2Pm6eHjZ3dfp+YKIclY9wTFngHTu9KNNsEGXO76/KJb1OLW1W79AsL4swC8+4Ke8MkitTcdLurijjhTD3iN9fnJNCLxtxK5cszyanSRxj8MLwhjaVe/tfqIxLklpnlcCyk5Fm/Cuxw9RwJB8aWlAEDr3TNpkKU/tAvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083731; c=relaxed/simple;
	bh=+26cqEoI6vyGjzaJJ/M3jME/9oDXMYsEoDhHULcqxs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6LohxKzUrjgmJtdiQpGIJsK/3KI7rettycJY9dUsBrpktIk5FRiX5I3xdceQIc671Q/qy52Djwp9QAn1hfp7XE8mfedYMyaw3gvsDi2tB4SgPAbLWsnN6Dbt/LKBkZJUWWZJpFefHwMirrZE7jgv0C2qlvCTi4WmWJgRhc9f5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCtebODr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957c929a5eso14084294e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767083727; x=1767688527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL/Wj6SCxGchjxYqWvSStvsH2z7rj7dLsJ0wzmxlUiw=;
        b=jCtebODrlOhhx8GdtIOfyPcaiOudYYg6rl1Ja98sXZEg+lJoF/iC2Fadj3Q5COIxZ+
         DJvZ/nk6Jim/MTx1A6r2ecaQWO1FUtiRD3/qrqIsdtzcZIErMwBiwYMbWXHbT/7+hQf2
         l9R6ocHVTqFZvGCVNGLPRifcARHaKCsx94D7k1/VE2VMUDqGAujXnA8++in3XDOPWKb+
         0pInKmDF/uPFgO/1KTz8eOODQuEFSf/1ywv4DHVOU087dk7pp8yFt6zvqZbT9ARxylLY
         ojTJ0UTuGTvk86hILiTVqZ0fcmm4QEMuje+olu6XqcVVZj/tbjRYjTqplQQgq1iVexRP
         GbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083727; x=1767688527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jL/Wj6SCxGchjxYqWvSStvsH2z7rj7dLsJ0wzmxlUiw=;
        b=ZahjQqWVHddxFLdDR2izk27Er9cAfahZOrBPhw21eZOrxKoQ4WGRO57jWwcjZzd/iC
         PupqOyjsfgWHG80Cxsr406T6L1WtOks4FvphDNfjBRqO3szovOZ5Eec4CjnjyIbglLn7
         zm84O5EfGn4RMA9IBOyFLhFmnRutYfj8ORM8ooY2RAeXV/KVvTWCu/Q960QW4uwLMp5X
         /cWqEy/oedvMHD1q0uTWwopRKYTYJw/g8BADTstEAThb1r5nPc2LWelLSc6bPInfwyun
         neotggBOiux47qNqL9yaGP8CmlidWGjPmoCmiPkNUnqVWFbyKMR36sB1upAK6bSvDdcK
         so/A==
X-Forwarded-Encrypted: i=1; AJvYcCXSAnLWgRD6CHUpsdoJFaMsF9Wjv3o4JpbOyEKqEbhOFfT80YrTHgwr6e8WnijJ2HUKnwpOe59fgdHgLrdn@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoh0OGJGvgWY6R6sqTwzMDNaCmldO36FGoG8nykUIXkveUi/P
	RAIr+eBdoYxexYvfJ3ps2451Vs6AP36Rc9LoaA+Yekxst6WLIqZr6/edDNvFVf9Lg9eKDzhLeIj
	p6Ypd5EtnH3QsZHffIGh/v/uPCoDfDpEeKT5eoUtq1w==
X-Gm-Gg: AY/fxX6lgQu86Z3ew/acsmiOprAv5APS8twm3JkmuFwOjkUuqjNMaCa1eEMCNet11mt
	izmvk6ZW11fgUVpTsYwFlf+wYHwY4Nyax8AwFmz4PXtTIwZJV3KrkG+ZI5/8pY/o2L/toZTzBIt
	2TreWR0gO1CpARjvjWOuSuyxdVyi8TBtC39BAgHiUX42M4sX61pD8N4KgTJoXYTspaREwjvsarK
	UL+z3oNMHTbGAIp9/rHnEVOwijuN15CIjAEyYHLEo52+ErNJp5bE0wh/aVEoWHx8NoD6w==
X-Google-Smtp-Source: AGHT+IEV6c8/2na+N9kv5rC1vKdjuflvoxKgRBZ3uupSA/0fubE6ndKtv2X1Yvp9alA/cMLRXsnCrJElgsvkbDuLx1c=
X-Received: by 2002:a05:6512:2388:b0:598:ee6c:12de with SMTP id
 2adb3069b0e04-59a17d6411amr11226419e87.47.1767083727243; Tue, 30 Dec 2025
 00:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
 <20251126-untragbar-hanfanbau-164f0425c5e5@brauner> <CABQgh9GhoeCaoVpL7nErfzAQHHykY_Y83tqzSByx180kXno5aQ@mail.gmail.com>
 <CABQgh9HuOB9Zcv277Sstdubz7q-Be8+aGeoNE5xrTfkjdz0u+A@mail.gmail.com> <CABQgh9GW+xfrGzESY_OT4A1x-QvpzWNuAZHh8otaydT5v6fWOg@mail.gmail.com>
In-Reply-To: <CABQgh9GW+xfrGzESY_OT4A1x-QvpzWNuAZHh8otaydT5v6fWOg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 30 Dec 2025 16:35:15 +0800
X-Gm-Features: AQt7F2q3no-g6gcktYMJ3dL8cqrRrsVXYmOHWS0eqMY5wDLwuv7FxbX0zeqlypw
Message-ID: <CABQgh9FTqyaDHD6pa-xoXxLtNBTe45x8WJrX=eJZVEwFYwRYzQ@mail.gmail.com>
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Wenkai Lin <linwenkai6@hisilicon.com>, Chenghai Huang <huangchenghai2@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Dec 2025 at 10:54, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Fri, 28 Nov 2025 at 10:08, Zhangfei Gao <zhangfei.gao@linaro.org> wrot=
e:
> >
> > Hi, Christian
> >
> > On Wed, 26 Nov 2025 at 19:01, Zhangfei Gao <zhangfei.gao@linaro.org> wr=
ote:
> > >
> > > Hi=EF=BC=8CChristian
> > >
> > > On Wed, 26 Nov 2025 at 18:27, Christian Brauner <brauner@kernel.org> =
wrote:
> > > >
> > > > On Wed, Nov 19, 2025 at 10:15:40AM +0000, Zhangfei Gao wrote:
> > > > > Currently cdev_device_add has inconsistent error handling:
> > > > >
> > > > > - If device_add fails, it calls cdev_del(cdev)
> > > > > - If cdev_add fails, it only returns error without cleanup
> > > > >
> > > > > This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> > > > > establishes a parent-child relationship.
> > > > > When callers use cdev_del(cdev) to clean up after cdev_add failur=
e,
> > > > > it also decrements the dev's refcount due to the parent relations=
hip,
> > > > > causing refcount mismatch.
> > > > >
> > > > > To unify error handling:
> > > > > - Set cdev->kobj.parent =3D NULL first to break the parent relati=
onship
> > > > > - Then call cdev_del(cdev) for cleanup
> > > > >
> > > > > This ensures that in both error paths,
> > > > > the dev's refcount remains consistent and callers don't need
> > > > > special handling for different failure scenarios.
> > > > >
> > > > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > > > ---
> > > > >  fs/char_dev.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > > > > index c2ddb998f3c9..fef6ee1aba66 100644
> > > > > --- a/fs/char_dev.c
> > > > > +++ b/fs/char_dev.c
> > > > > @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struc=
t device *dev)
> > > > >               cdev_set_parent(cdev, &dev->kobj);
> > > > >
> > > > >               rc =3D cdev_add(cdev, dev->devt, 1);
> > > > > -             if (rc)
> > > > > +             if (rc) {
> > > > > +                     cdev->kobj.parent =3D NULL;
> > > > > +                     cdev_del(cdev);
> > > > >                       return rc;
> > > > > +             }
> > > >
> > > > There are callers that call cdev_del() on failure of cdev_add():
> > > >
> > > >         retval =3D cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
> > > >         if (retval !=3D 0) {
> > > >                 pr_err("dvb-core: unable register character device\=
n");
> > > >                 goto error;
> > > >         }
> > > >
> > > > <snip>
> > > >
> > > > error:
> > > >         cdev_del(&dvb_device_cdev);
> > > >         unregister_chrdev_region(dev, MAX_DVB_MINORS);
> > > >         return retval;
> > > >
> > > > and there are callers that don't. If you change the scheme here the=
n all
> > > > of these callers need to be adjusted as well - including the one th=
at
> > > > does a kobject_put() directly...
> > >
> > > The situation with cdev_device_add() is different from the standalone
> > > cdev_add() callers.
> > >
> > > cdev_device_add() explicitly establishes a parent-child relationship =
via
> > > cdev_set_parent(cdev, &dev->kobj).
> > > If we simply call cdev_del() on failure here, it will drop the refere=
nce
> > > count of the parent (dev), causing a refcount mismatch.
> > >
> > > Direct callers of cdev_add() (like the DVB example) generally do not
> > > set this parent relationship beforehand,
> > > so they do not suffer from this specific refcount issue.
> > >
> > > This patch aims to fix the cleanup specifically
> > > within the cdev_device_add() helper.
> > >
> >
> > More explanation
> >
> > Now the code:
> > int cdev_device_add(struct cdev *cdev, struct device *dev)
> > {
> >         int rc =3D 0;
> >
> >         if (dev->devt) {
> >                 cdev_set_parent(cdev, &dev->kobj);  // here set parent
> >
> >                 rc =3D cdev_add(cdev, dev->devt, 1);
> >                 if (rc)
> >                         return rc; // case 1
> >         }
> >
> >         rc =3D device_add(dev);
> >         if (rc && dev->devt)
> >                 cdev_del(cdev);  // case 2
> >
> >         return rc;
> > }
> >
> > Since the cdev_set_parent,
> > cdev_add will increase parent refcount,
> > and cdev_del will decrease parent refcount.
> > So case 2, no problem.
> >
> > But case 1 has an issue,
> > if cdev_add fails, it does not increase parent refcount.
> > If the caller calls cdev_del to handle the error case, the parent
> > refcount will be decreased
> > since there is a parent relation, and finally got refcount_t:
> > underflow; use-after-free.
> >
> > So for case 1, cdev_add fails, it does not increase parent refcount.
> > needs to break the parent relation first.
> > then cdev_del does not decrease parent (dev) refcount.
> >
> > Finally, both case 1 and case 2, calls cdev_del for error handling,
> > and refcount is correct.
> > It is easy for the caller, otherwise it is difficult to distinguish
> > case 1 or case 2.
> >
> > Thanks
>
> Any comments?

Ping,

Thanks

