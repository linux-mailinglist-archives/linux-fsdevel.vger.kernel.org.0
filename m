Return-Path: <linux-fsdevel+bounces-52013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF4ADE34E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949E8177F23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE981FF5E3;
	Wed, 18 Jun 2025 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJDM6eZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9A522F;
	Wed, 18 Jun 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226258; cv=none; b=avPL1pqswuZoZ2Cfaxawx737qxWSZWH/+/0bmeDXHEw77p1nDMe8GD08X1y4tDvVAqeoU1gGDU3ygtF4DdFIgNyHXKvkHkd54yvB0Ye01VwY0/6hmPqLm32CvdRxXxIqF5k/VFY30jsleCmam8yCAHdS++PHJrqdCNhp+Z3UcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226258; c=relaxed/simple;
	bh=ZnYL99bXoNewCT10OfyVgaJPz9Lm465lrY52yWRHNOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K28cJf24e/uzAq5TDz26fDR0dtZPy+F9g94vPBz3XGe1L4u3MuEzWsicscsjHO6wzu8dUiK5Cu6114VF5uWomjA0RGJge8qNc9RwedzDDKEH+v+mrNbK5ybqTRGj3QCtr3q2jcejIXHGLKUeiuR0Tb4lajPOj4kCmDAJKF5QIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJDM6eZa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so786355a12.0;
        Tue, 17 Jun 2025 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750226255; x=1750831055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc+ErnKOJ231laZc6TDP0EBrheoh8TUtV1LEQn5EjgM=;
        b=eJDM6eZahy0Vc4LTsJm4k2fLXJsHmIkkY3aQlB+sshjAR/dgyun2o4Pi2hdBNJmhcW
         xYzOiLvEsHwMWb5JBuRzauCxx/KOzq29BnbH/CTWvvQL6yy81+3U5qvC9K3B0V9fm2LV
         i8IUTwNSPrq3mKvgV0ELLJ01l10NJC31k9o1MPSSzuhsMqs37rcZ/BCrnyqO3nFMmcDd
         a3B/EJhgYxFlz7zMrNzx7/w/9r/MJ9znFmLv0MmQVnBa/uJGCG9DPxQ2oLnxLoSf/ZmX
         u01YFqW31A+4EWgU+c82Y5dglrZkXetG4mWuRf/yWV08/Yhd1nIE01qhznEL5IKwrQHi
         0eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750226255; x=1750831055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc+ErnKOJ231laZc6TDP0EBrheoh8TUtV1LEQn5EjgM=;
        b=erjFJAo0uGZ3irIlhPqOb1fZQqTdnZgMzrYP/gGqk18JdEIsmkzhV+S2W3dFG9n3uZ
         IaGGv+SyuOzDG75Kfqog1CQ/pQeL7bafXdEfV+oz5ZUa/WpM4iOko2E2Zi1Sl2IB4YLj
         koRJXGsSoYGEHCkBnbTbrhCfzHYmRJDop9PkPpR27y3tkrRj9rn8JtBWGzvEo8cnWWEf
         Pz5MO3OpPiePF++hzXcc7s6sKI48sxWs7f/e6IK/vCkSMV0KmWM4pmn5ldV2awC8dgVK
         sskFJCkzK5SRzSJp2awm/KiAzZ8PAW7gxMDeHfN9nPQG4qheBiP+ZUqsVL+qX7vC//It
         YlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnMqiyLGUTWznTLiB0eXgx7mx91mXP4IYlghvtg2heQHVzduQuNXeLbUKINQYW10JENlWCLt9rDyeLUQ==@vger.kernel.org, AJvYcCXHpvZ8gkW52mwNFo5o1OCJR/EDVXRqXQFAwzymzS8FSNm5kFKEvtI9C6bt5p71wHGVNZ6YUx3rhADjegxWGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3SEqH2bIT1744B/4ylC9qBwMG9WCRaGL2I+wENFkxokdV5Z0
	GUJaDtmiuKoqX9Kxk0j3TP3QeCYdkpQ1PQOx7HzMcZNKdNfccpbLU092G/QXI8REMi4SDncM3UK
	W5mvWRpT373ANy+UVrhSkCwK9HTKrMw==
X-Gm-Gg: ASbGncso152r5Zj+CJJfZe0p0cAEcaJyI7rNVOmYVYdWoyBXgNB3/TN/AFJkI+M7NWf
	LvM/v9VWDRa3x7TzpxHoetIxzqLZhS8+jae1M8HbXTHCkXUkm51d5Qutj5V2M65QkN+B6k42R0q
	6OE3cq1W6SZXUgNO3LGvmzKEeZLoLx8l+l8lOl+WKgu5BADUvKdldypb+qdTczJmAMVOe+vrIl0
	a32WLqpURM=
X-Google-Smtp-Source: AGHT+IFoV/eGulbcbjRmiPG5NUq8dU4aRQiFaCZemJBnjeMxct1lWN84Nr6xgfseoijcHq3hPbpbNTAoct4nnDSaHks=
X-Received: by 2002:a17:907:d15:b0:ad8:942b:1d53 with SMTP id
 a640c23a62f3a-ae01f869b06mr94698766b.27.1750226255148; Tue, 17 Jun 2025
 22:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610132254.6152-1-anuj20.g@samsung.com> <CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>
 <20250610132254.6152-3-anuj20.g@samsung.com> <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
In-Reply-To: <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 18 Jun 2025 11:26:59 +0530
X-Gm-Features: AX0GCFtxrH8tnfrbMXmImLdHz46u4RB2qOus_QZ6oX8blRvuXoel21PBq156ey0
Message-ID: <CACzX3AtOVQokJmp9hOo_BZrF=kqkrJLeh3nLeY3bkWNgKL_m+A@mail.gmail.com>
Subject: Re: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
To: Christian Brauner <brauner@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, jack@suse.cz, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, hch@infradead.org, 
	martin.petersen@oracle.com, ebiggers@kernel.org, adilger@dilger.ca, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Don't do this hard-coded form of extensiblity. ioctl()s are inherently
> extensible because they encode the size. Instead of switching on the
> full ioctl, switch on the ioctl number. See for example fs/pidfs:
>
>         /* Extensible IOCTL. */
>         if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
>                 return pidfd_info(file, cmd, arg);
>
> static long pidfd_info(struct file *file, unsigned int cmd, unsigned long=
 arg)
> {
>         struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)a=
rg;
> <snip>
>         size_t usize =3D _IOC_SIZE(cmd);
>         struct pidfd_info kinfo =3D {};
>
>         if (!uinfo)
>                 return -EINVAL;
>         if (usize < PIDFD_INFO_SIZE_VER0)
>                 return -EINVAL; /* First version, no smaller struct possi=
ble */
>
> pidfs uses a mask field to allow request-response modification:

Thanks for the detailed feedback =E2=80=94 very helpful.
For now, I'll keep it simple and skip adding a mask field since all
fields in the struct are always returned.

> (Only requirement is that a zero value means "no info", i.e., can't be a
> valid value. If you want zero to be a valid value then a mask member
> might be helpful where the info that was available is raised.)

To clarify on the zero values: the fields in this struct are
capability fields, where a zero value indicates that the hardware
doesn=E2=80=99t support the corresponding feature. None of the fields have =
zero
as a valid value when the feature is supported, so a mask isn=E2=80=99t
necessary.

I sent another version [1] with your feedback applied. Please see if it
aligns with what you had in mind.

[1] https://lore.kernel.org/linux-block/20250618055153.48823-1-anuj20.g@sam=
sung.com/

--
Anuj Gupta

