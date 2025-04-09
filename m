Return-Path: <linux-fsdevel+bounces-46072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB185A8235B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83B817D8BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB925A2D7;
	Wed,  9 Apr 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKGWj5MO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D62B9CD;
	Wed,  9 Apr 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197561; cv=none; b=fHwGK8SaFRDI/8TAKrJF/gs++5UgwPSR3qZLpzCSEZBbODns1gmqOz9UkvESODuiC1no9GwQQl0fc31q1qeinZdIEH++bH3T+Sj1a2I9xgxBVL6oCfiVQ/dl0vq4E5LxuXDlv6QOhJJgsqve/cSanDUA+AhhEJ5Perlhks9FntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197561; c=relaxed/simple;
	bh=fnUtI4M2UuKiZ5tGKBCJqmTYwI9bfTwmMyBYyAxnFb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo8oJiSwDpFJdEK652wfw1SotsgpHok5Slo5Uoj2xPKeqOxiDjthBtvvzEogpjlxEcPpLIiv7c14H5eOYv6b9r/vKGYZTKkBkqxJCoa6dA0fKcr5Dl+M/zDxe7bLmS+l0Mvi24sjgik4wYYK2TqwY7f9qLWz5NnwEqAr91LEBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKGWj5MO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso1189940a12.1;
        Wed, 09 Apr 2025 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744197558; x=1744802358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BliV3ONkZPrxAVESBbkfdX31xILwT9ii+PtUDbaW9E=;
        b=CKGWj5MO+QUYp4OyVeUOsQb6ZhN+nqF0EbE34c60YjBq+vRIVvp3J4MXQgONFbzauL
         1eU+GMCYv0JTluKdgbp/7iNFd1xoYl7/MZ3FYXhYDgKlXXkVzwwbMoKf4fQLTEa5VmHy
         x9g9qiAR8Yl0KnJsaA/v3JsCqtEnXQGKnHKVti+An/6vThx4Wlm8DiLhLzu18e+1YoLR
         JCAlclCNvzq4XRvy4F6O1KQfKCcOR++qSsVBwhigospZERnQIDjTXzEiDdjF+X6tFdOB
         gkEBCE/awlmRmKB/Ja+rmoLCGOJ+AWgwbvxsCM4fV8tzvQVilvi9Nk4BTVoczLJ/a1Ze
         AYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197558; x=1744802358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BliV3ONkZPrxAVESBbkfdX31xILwT9ii+PtUDbaW9E=;
        b=ResYs1XDl3AWBRphVxGkEH3M0TfTAYpXQx8oaxde1pYqUyWkarjLx9QRGq255pYVj2
         CNx4tFsNEN7+wNeS17ACCZvGd1W/aw/q8z3QAXgHpW2Rooy5hEHhqiiJhHaKqTzR4JrS
         wUYCWzNfbPdMl12Xl1xYEJBj293eSPat19wXjSIczAvqsuKFzDtkPF+EenJ5q3QzfqN6
         rE9qSD2mWaYWDTW1QC6gHqAptUFyGJVHQheL/CoEXUCssoKDzrA8iZDI51ACZsPkcnNc
         lnEIsJjxZSUM4fGQ5ts8uuoPVJ0Wq6qOKDDYcLLFfB9P62aVmFugDx4K5tkjSe7NgajC
         ZpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6LiqW7iWkj4uOkD4LbJChcSULozVYY4mn5l7jDeI0asA3pAuPm/lqdvNwMzkTIriJycTdgTRG2fNZlmkzpQ==@vger.kernel.org, AJvYcCWa82yDryVmpK3RV4W1vWZaJLsejoAt614ShZ8xtP0WUygaIQt2eALD2d+iRV8CfyzO98GYpMlW+Np7YCoC@vger.kernel.org
X-Gm-Message-State: AOJu0YykY5KNqz+oZJTNbHlbsz7wX30oduHmFrqneV+QOqU3yy4ZZgPI
	yAwJmZHv1/sSWOOSk1eR8TGHqaG653rQp7v9kHM6l7G1nTjYvTM/TqsCvGsb/yeaIyPihZMi87D
	BTJ4yBmJSagMjy9Nkj/vs7/xuO/4=
X-Gm-Gg: ASbGncsOTVdhGbM6yTxpWsIwwZ2N7eWhyjxz+A7hV4ZHIybKsWhUEdOgOsZdDDoJDql
	PMlpJV4L5MyQg8mCx5eglB0zW+cEXbv7SMoelZJ8qifGXmv0/k9Xn0CPAhJiPrZXkUsFxPLGTJ3
	nO8TWpNDe2bUtNckBjyNm5mw==
X-Google-Smtp-Source: AGHT+IEnuPkOK3suV0H+5l6qqetuyru3+tZz6/JLB8O6nvdGgZ6yn9PWEUGqMvgq7Ovl+s7VkWRTmeM+KODrz62NxGs=
X-Received: by 2002:a17:907:7f0b:b0:ac7:b8d3:df9c with SMTP id
 a640c23a62f3a-aca9bfb1039mr256115366b.1.1744197557941; Wed, 09 Apr 2025
 04:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-2-mszeredi@redhat.com>
 <CAOQ4uxjOT=m7ZsdLod3KEYe+69K--fGTUegSNwQg0fU7TeVbsQ@mail.gmail.com>
 <CAOQ4uxhXAxRBxRh9FT0prURdbRTGmmb4FWSs9zz2Rnk6U+0ZTA@mail.gmail.com> <CAJfpegsKAsNFgJMK4oS+gjD_XmhscjdTtmx0uW2GkCPC+kf6ug@mail.gmail.com>
In-Reply-To: <CAJfpegsKAsNFgJMK4oS+gjD_XmhscjdTtmx0uW2GkCPC+kf6ug@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 13:19:06 +0200
X-Gm-Features: ATxdqUHAVUa4edzsICyni5ahmXGpqfKJPcdbFIGOBnA6EYtVqMwsK3f3vTZzUBM
Message-ID: <CAOQ4uxiwjzL+6=hoF44Dr58W75EKE_tLQkQGhQ=5t9Kf_1ymwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 1:12=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 9 Apr 2025 at 10:25, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On second thought, if unpriv user suppresses ovl_set_redirect()
> > by setting some mock redirect value on index maybe that lead to some
> > risk. Not worth overthinking about it.
> >
> > Attached patch removed next* variables without this compromise.
> >
> > Tested it squashed to patch 1 and minor rebase conflicts fixes in patch=
 2.
> > It passed your tests.
>
> Thanks.
>
> One more change:  in this patch we just want the consistency fix, not
> the behavior change introduced in 2/3.  So move the
> ovl_check_follow_redirect() to before the lazy-data check here and
> restore the order in the next patch.

Right.

>
> Pushed to overlayfs/vfs.git#overlayfs-next

Looks good.

Thanks,
Amir.

FYI, I am going to be on vacation 6.15-rc3..6.15-rc5.

