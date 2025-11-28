Return-Path: <linux-fsdevel+bounces-70101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABBC90967
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60A874E18BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722926CE3F;
	Fri, 28 Nov 2025 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX1iF4O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B32512FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295739; cv=none; b=oP1Wnq3M99vDBycXj/4RdbC2PNkpyoDh1a8JXCBPNIdurVoJbHufC1AplpE+YkXAcoZ7KQ7stZsmeciCCtbLAotpm8HDILhZMrkRfsHa0oayM4vJU2ca0Yiw8fenIdUfPzQJ9A12oaPq/zRaLleUr/woR35uX7aKGDRPXx3RkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295739; c=relaxed/simple;
	bh=gp9oi+oPLK0MQhCfNyOguwBT84CRvL78Y9UFdTzam/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhbD9mq/LbzJ+RDrCs77sXOTxpXkv7R3DnwpwiiNFSm5WFLJX6zdVejeE72PeL6noLcodw+lBpBozTYJou1rng+5K9345CNnbw1f//fvsEydSTnhIDM9FazQLx/xJE3tHsITrYXX4kbf9e/nT8+LakuA756erewCQQdvotj6j0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HX1iF4O+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-595819064cdso1858856e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 18:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764295736; x=1764900536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvGsDzPKVnRrom5h09+zo4OXyNzeh+SyQlWvn+u0J34=;
        b=HX1iF4O+6z1wNXc4Bkc2E4Ce1vWvT+OeHb4cLEKPC7NT09udLPQLirscBngtZJyvag
         q8yQMOvx4b5CO9pzj64NMQmCOoqmrBWi41e2Sz6fYdH/Z1PsvQUuzamxaTRBF0f9cQuS
         NF+abupCUCBrK10tBs6BdvA7VPrfaa2D/jTNq21xodApT4vkROWH2I1V9CMAmZ0/sdfv
         /tg1lSYbDe56Fsd2neU9IC5CDgQgIT0xcvwfuNurCmpIGXo7d0X1957eAMbrriPHqxt0
         CsXyB4N5qw02CkzHb0m+eLiNnNK8L53HsjTSCcpN/xPmKDWzGZPVjajAKYP/uvRO8RTc
         7ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764295736; x=1764900536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvGsDzPKVnRrom5h09+zo4OXyNzeh+SyQlWvn+u0J34=;
        b=hr73qxQtkZ0Cdb2Fc7CRVMTSU/Jl4rWpkjh1KvYZ1TRbUEwh4T4Y1zz/pwQ1NkkjGK
         l9+t/jMv/Ba5yyWxnL2me2AWTvrCYKBlKRTYhbauuVOs8LGpKa5MijVRhNTeYC005uBc
         zaUqLFJ3GI+SA3s10ET/RjNroBwjB6tMBCtlYfhHfeqXfx3Zgwv3Iv9JqAUFhvbJ7xkW
         O0lzAA8yxobVwruVTUvdmoOOJY8qzxc/zCgXj+gyQgP/qjLnjnjYwugAvp8lnxKbBc5s
         apcRU+KoV+VHJ6bMFw40XB3IXqWXZMAQkzQ6eaeAouHT64XxwofofWcuAK8rBHGqUrMp
         pcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOv0etptSBIGxmVjIoWkOmnB0KBbV7QABdQZy2QChDvfA86N4dnMh5E9NRf1e7BD+KKsiWzcP4CFgulzTy@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUNphjUkPEVuZRoVxieFjsk4FiBuxwz0duYQHC8j1xCMvjnpH
	F09dcHOB13/qChtQUldrY6iTA3UWdtykPaze7j3HLBn+rJcH7llqRQpfvrIOhe/vYC50G8h+CEM
	KYDCP+GYLxIuMjvO6Qw94w/gfrfvfwGNbzqwbYEMx7Q==
X-Gm-Gg: ASbGncvtTTRTOQqC6owAyD1o1KznK+DNJSaB/YwbftfAKskoOE5MjiosWDUXTNTh/W6
	m+MmOljmZgcOOl4lStoDLOm58jdR+vMzUIVcxwdz1Gb3XPHy4p5qrvB4kmx1mJr265Cz+X578ff
	qGwY/Vr/sdTokkUVQfpWgN9AaY5D6Q26vbXotLh4dDGAE3izINnQ6otFam3Ezty1Xf1w7JKsp41
	6+Qb/8EdbJteiHXCXOTjPqI2nmCLqvHWWLz2zwCnjajp6cKk5HZSrT2buopGiwK6XRhv+6N
X-Google-Smtp-Source: AGHT+IHT0PqF2SNp+NTR5QOtPCH793NebrKRdLF/Yn7dRkFaurdSKyiXiWUe249pxK0gXJtOFcEbVK+sGJCuHWH3WdE=
X-Received: by 2002:a05:6512:31ca:b0:594:773e:7631 with SMTP id
 2adb3069b0e04-5969e9df185mr9096365e87.7.1764295735567; Thu, 27 Nov 2025
 18:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
 <20251126-untragbar-hanfanbau-164f0425c5e5@brauner> <CABQgh9GhoeCaoVpL7nErfzAQHHykY_Y83tqzSByx180kXno5aQ@mail.gmail.com>
In-Reply-To: <CABQgh9GhoeCaoVpL7nErfzAQHHykY_Y83tqzSByx180kXno5aQ@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 28 Nov 2025 10:08:44 +0800
X-Gm-Features: AWmQ_bm5BdY_33VdYK-Jj9cRFOzupYbQ7NUgdRY0hIo4QseBL2qhXaGy9XHeTb8
Message-ID: <CABQgh9HuOB9Zcv277Sstdubz7q-Be8+aGeoNE5xrTfkjdz0u+A@mail.gmail.com>
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Wenkai Lin <linwenkai6@hisilicon.com>, Chenghai Huang <huangchenghai2@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Christian

On Wed, 26 Nov 2025 at 19:01, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi=EF=BC=8CChristian
>
> On Wed, 26 Nov 2025 at 18:27, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > On Wed, Nov 19, 2025 at 10:15:40AM +0000, Zhangfei Gao wrote:
> > > Currently cdev_device_add has inconsistent error handling:
> > >
> > > - If device_add fails, it calls cdev_del(cdev)
> > > - If cdev_add fails, it only returns error without cleanup
> > >
> > > This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> > > establishes a parent-child relationship.
> > > When callers use cdev_del(cdev) to clean up after cdev_add failure,
> > > it also decrements the dev's refcount due to the parent relationship,
> > > causing refcount mismatch.
> > >
> > > To unify error handling:
> > > - Set cdev->kobj.parent =3D NULL first to break the parent relationsh=
ip
> > > - Then call cdev_del(cdev) for cleanup
> > >
> > > This ensures that in both error paths,
> > > the dev's refcount remains consistent and callers don't need
> > > special handling for different failure scenarios.
> > >
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > ---
> > >  fs/char_dev.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > > index c2ddb998f3c9..fef6ee1aba66 100644
> > > --- a/fs/char_dev.c
> > > +++ b/fs/char_dev.c
> > > @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct de=
vice *dev)
> > >               cdev_set_parent(cdev, &dev->kobj);
> > >
> > >               rc =3D cdev_add(cdev, dev->devt, 1);
> > > -             if (rc)
> > > +             if (rc) {
> > > +                     cdev->kobj.parent =3D NULL;
> > > +                     cdev_del(cdev);
> > >                       return rc;
> > > +             }
> >
> > There are callers that call cdev_del() on failure of cdev_add():
> >
> >         retval =3D cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
> >         if (retval !=3D 0) {
> >                 pr_err("dvb-core: unable register character device\n");
> >                 goto error;
> >         }
> >
> > <snip>
> >
> > error:
> >         cdev_del(&dvb_device_cdev);
> >         unregister_chrdev_region(dev, MAX_DVB_MINORS);
> >         return retval;
> >
> > and there are callers that don't. If you change the scheme here then al=
l
> > of these callers need to be adjusted as well - including the one that
> > does a kobject_put() directly...
>
> The situation with cdev_device_add() is different from the standalone
> cdev_add() callers.
>
> cdev_device_add() explicitly establishes a parent-child relationship via
> cdev_set_parent(cdev, &dev->kobj).
> If we simply call cdev_del() on failure here, it will drop the reference
> count of the parent (dev), causing a refcount mismatch.
>
> Direct callers of cdev_add() (like the DVB example) generally do not
> set this parent relationship beforehand,
> so they do not suffer from this specific refcount issue.
>
> This patch aims to fix the cleanup specifically
> within the cdev_device_add() helper.
>

More explanation

Now the code:
int cdev_device_add(struct cdev *cdev, struct device *dev)
{
        int rc =3D 0;

        if (dev->devt) {
                cdev_set_parent(cdev, &dev->kobj);  // here set parent

                rc =3D cdev_add(cdev, dev->devt, 1);
                if (rc)
                        return rc; // case 1
        }

        rc =3D device_add(dev);
        if (rc && dev->devt)
                cdev_del(cdev);  // case 2

        return rc;
}

Since the cdev_set_parent,
cdev_add will increase parent refcount,
and cdev_del will decrease parent refcount.
So case 2, no problem.

But case 1 has an issue,
if cdev_add fails, it does not increase parent refcount.
If the caller calls cdev_del to handle the error case, the parent
refcount will be decreased
since there is a parent relation, and finally got refcount_t:
underflow; use-after-free.

So for case 1, cdev_add fails, it does not increase parent refcount.
needs to break the parent relation first.
then cdev_del does not decrease parent (dev) refcount.

Finally, both case 1 and case 2, calls cdev_del for error handling,
and refcount is correct.
It is easy for the caller, otherwise it is difficult to distinguish
case 1 or case 2.

Thanks

