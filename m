Return-Path: <linux-fsdevel+bounces-31822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1999B9CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AB01C20E78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBCD1465BE;
	Sun, 13 Oct 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxXhzosr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE6146000;
	Sun, 13 Oct 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831109; cv=none; b=d1IRx6P6OY/0GLu40BsHtM/JsQPQ1hl7tR/s/j5Q0FHKCpG+/ZIxQJqj0obhCJ0jREPoIbxN75wBrQSW2InePcUko94PvMa4bgDgRfhhGykc0NZA8rOVCzwRmz601wtmOoejpeKy9YN53NevFcuMVG0eNAx+8ySij3vFljNg9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831109; c=relaxed/simple;
	bh=qROzxo0q2NDaeazkSHIfSsf+Ej5htZbBZ/p81a5pkNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSb1YCxQKd+veW+u7OwfEubFx7kFgPqGl8gUJgX+p7cX/8YspUB5hVrdYRt/uHxaUQqFJJrzG7wCq4ribmspJwqip7W+cejaK8ChwOMEQJbchAHeeGJQtGtEqJaMYkx8xa9OiRSOg9Clb7rYcP9Bf1yYwcIEBtsWDhB/l5MqXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxXhzosr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1141a3a2aso338503785a.2;
        Sun, 13 Oct 2024 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728831107; x=1729435907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qROzxo0q2NDaeazkSHIfSsf+Ej5htZbBZ/p81a5pkNw=;
        b=MxXhzosrY6IQZaGz2HFEKk42QL2Xnj6HGNDNN7CEFeomgEzfVbdNbIiYV6Nse+dMNH
         rEY54tWqjT5WTI5TQsYe155QBdOOmEenNV1MPS4vnCRjOE6DhTyk5Ww4c2rZRgEEqvy7
         IK6vDuAH2wYrBf7Ne+4uFrIyVn4tpqe5kTNnt/fmpduELUrnX5F7jhUbYYGuskBEQkfY
         yvGMeblDEoEk3lp2JILdqDRGcrU7RlLvpoa36zxSbJiShDIhFVT1hlSbfxq0hMJBGuwq
         EuLBDt7e5q2DqmweuejBqYD5eeHi4xLPWRWllvlz5vZnXWcD6fviw5DaTEm2xgsl325L
         0VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728831107; x=1729435907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qROzxo0q2NDaeazkSHIfSsf+Ej5htZbBZ/p81a5pkNw=;
        b=iUwsUI5F70xTSubOFlEaxmx6r+H6OASth9u1RA5V5da9tQBqLi6v9h+bGQJI7bMzCN
         zu5Wz/hv1+Xr+oRPXg8gto83hF6QG4VGO4fyUmivmVpmxum59h1rOHpm8sMqq2CypCxh
         dTg9Y6JrrtkEE2NHlWeKlJIZDFrfTT0TuHf6CIZ4oTFiJjjGjfjBPDaokYE3b6E907O0
         yL00UkH92gi0QGCwbz0IRntIC7JjRym8rae5z3mEz1KQxzLbgjlW6VqgRPVd6W8W52Hi
         dQk7BGItIVT2J+Vr6Fx2B8PR6Tnbys2TeYEkDP7/xv+sL9b3E675ZnhirYmH2jhHNqzA
         ZuIA==
X-Forwarded-Encrypted: i=1; AJvYcCW6xbRXqJnWN+sO8oUE0cvCr+HVE7jBWbwzS44J5yzfyf73Rcyd9pSe4D1oCNN7GplXK2xvnF9ietl+t5Vy@vger.kernel.org, AJvYcCX3dvylxtraXYo7J6F2Wdkh1vv2ij6+esOxmHLxR2t/zbvbWZ/tu/S1ie4rEajNfv7rfAzp553j7dayjxnl0L5RHjBmDwNN@vger.kernel.org, AJvYcCXo6xCNZI6pejpKIr7LKQ7+VPJ9A3P19/Jukn9uLSgng+NZH9Y0kwopGxxsI/8BLJe0sRyeIwBZWbgf4qjt@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvcq/ImtOxhT2whFiu/jbZynzQPXQJVs24jrUsPaxiW4m/fYQ
	uK7XIpp0ZSZ67BF2ANo4rPKILV3pLlkGtzISv79uluaBOtM/6uC42zaOQtLkGLU7h3znwt/LYY8
	eYTcW7f5ejrv3QuKHkvdaB/SIOwU=
X-Google-Smtp-Source: AGHT+IHE7sTPQk3c9bgh7P2M2yKr2CnpjrV4S25hoOK6gYCHQ4Iyip8S8u16Sz11w305vQZQTOj8xE+opu9x0QKAf8U=
X-Received: by 2002:a05:620a:17a4:b0:7a9:c129:5da7 with SMTP id
 af79cd13be357-7b120fc587fmr845549485a.29.1728831106632; Sun, 13 Oct 2024
 07:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013002248.3984442-1-song@kernel.org> <CAOQ4uxjQ--cBoNNHQYz+AFz2z8g=pCZ0CFDHujuCELOJBg8wzw@mail.gmail.com>
 <AE7ECD50-A7DC-4D7D-8BC7-2A555A327483@fb.com>
In-Reply-To: <AE7ECD50-A7DC-4D7D-8BC7-2A555A327483@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 Oct 2024 16:51:35 +0200
Message-ID: <CAOQ4uxgL7OKf6U9UUsaapcMpKVeF4meo_7_hA1QovMf_TBf6Jw@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
To: Song Liu <songliubraving@meta.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Song Liu <song@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 4:46=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Amir,
>
> > On Oct 13, 2024, at 2:38=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Sun, Oct 13, 2024 at 2:23=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> >>
> >> Currently, fsnotify_open_perm() is called from security_file_open(). T=
his
> >> is not right for CONFIG_SECURITY=3Dn and CONFIG_FSNOTIFY=3Dy case, as
> >> security_file_open() in this combination will be a no-op and not call
> >> fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directl=
y.
> >
> > Maybe I am missing something.
> > I like cleaner interfaces, but if it is a report of a problem then
> > I do not understand what the problem is.
> > IOW, what does "This is not right" mean?
>
> With existing code, CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on
> CONFIG_SECURITY, but CONFIG_FSNOTIFY does not depend on
> CONFIG_SECURITY. So CONFIG_SECURITY=3Dn and CONFIG_FSNOTIFY=3Dy is a
> valid combination. fsnotify_open_perm() is an fsnotify API, so I
> think it is not right to skip the API call for this config.
>
> >
> >>
> >> After this, CONFIG_FANOTIFY_ACCESS_PERMISSIONS does not require
> >> CONFIG_SECURITY any more. Remove the dependency in the config.
> >>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >>
> >> ---
> >>
> >> v1: https://lore.kernel.org/linux-fsdevel/20241011203722.3749850-1-son=
g@kernel.org/
> >>
> >> As far as I can tell, it is necessary to back port this to stable. Bec=
ause
> >> CONFIG_FANOTIFY_ACCESS_PERMISSIONS is the only user of fsnotify_open_p=
erm,
> >> and CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on CONFIG_SECURITY.
> >> Therefore, the following tags are not necessary. But I include here as
> >> these are discussed in v1.
> >
> > I did not understand why you claim that the tags are or not necessary.
> > The dependency is due to removal of the fsnotify.h include.
>
> I think the Fixes tag is also not necessary, not just the two
> Depends-on tags. This is because while fsnotify_open_perm() is a
> fsnotify API, only CONFIG_FANOTIFY_ACCESS_PERMISSIONS really uses
> (if I understand correctly).
>

That is correct.

> >
> > Anyway, I don't think it is critical to backport this fix.
> > The dependencies would probably fail to apply cleanly to older kernels,
> > so unless somebody cares, it would stay this way.
>
> I agree it is not critical to back port this fix. I put the
> Fixes tag below "---" for this reason.
>
> Does this answer your question?
>

Yes, I agree with not including any of the tags and not targeting stable.

Jan, Christian,

do you agree with the wording of the commit message, or think
that it needs to be clarified?

Would you prefer this to go via the fsnotify tree or vfs tree?

Thanks,
Amir.

