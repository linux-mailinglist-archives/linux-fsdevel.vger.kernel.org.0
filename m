Return-Path: <linux-fsdevel+bounces-34778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437739C89D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D42B27B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82021F890E;
	Thu, 14 Nov 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcC6/88C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE191F6E;
	Thu, 14 Nov 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586778; cv=none; b=US3yVdxHSQvzJy6SeWH4Wm+PeI7t+CM6+g/6W27EhTSssnjS096uIy3/2TzLs+dAq5QkhvttFBhGWcuWXaVYrSpuR9hd/XMvRhf3u5gmeErZk3Tpxd5VhkOlLDWwOcQCHonVq+UM/lElQQtbQBZSeTjxVqsNPyxJ/qjKndrcFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586778; c=relaxed/simple;
	bh=yjO4KU2YPKbHm+umvpF+m/c2XxSbaeuQB9id8D+HJKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkjWgnOlIgEGhj0nDQMnn1ZokLU5pu4bFYVrnQb9ZfEBPtxBiDGHr6vSdQGDvjmfS4aoxLo1sMBeud1s8msmzmRn7FO/w1tm6GB3odQKnqmJosRe06lD+ztSLzmCqbnZ+Ex+fe3EZhkkiOSMw3iAet7u5Q+xvDPG6Z5L+vVLNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcC6/88C; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbceb321b3so3506706d6.3;
        Thu, 14 Nov 2024 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731586776; x=1732191576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjO4KU2YPKbHm+umvpF+m/c2XxSbaeuQB9id8D+HJKc=;
        b=kcC6/88CLCd3a4vcvO6us50FKkZKcR+2BAZ1OsW914WwRFm67x9c9QlKrKe45JzXf0
         cnB2TvWniBAJ9WQaFwkYm+YuSS1J2hxmH3WZaIXGE/kid3hdCVIWQikvYpqjSbraWj3N
         Wi8q+7ctzOD1N+K9C/6aE7Vq09ieafUzv/kGl0do7v818tTABeCVzsswN2bLhxWimykX
         Lv0g8aBUUxCFqiJt7afJjs9iuVL0hpoJS4KHLn8v2iO4Y6o5YASumcs4QB2eDhMOFHgk
         7iwBQnjq/PTfnj2BMPZSv24DIROm7PN6qa1gYPvdDdhlK44cip7Kj5ILZ/5U/Dxxeo5o
         XlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586776; x=1732191576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjO4KU2YPKbHm+umvpF+m/c2XxSbaeuQB9id8D+HJKc=;
        b=GF2eScTOoR8xdtY7me+DHnZeHTr2QS6M1bG9zIVLGDyet0kCZRE9b4Mrzbba7Rrltv
         rPUg1kiMAZT1qzumsn3WHI9ZnxnHLf93wQCOIRP+8Wnd2ABYaEW7V76Qdyiv6uPSjRw6
         dTkcEpv5kwAJZITy8diQCbY1WF0g2feTrQIlkU1mLtsKk5K00fa2XmpqaDdlI+Qdv103
         HNA+3LIJ0CSYFCoReeHZBpwSkCSi6w321UuXNq5z91YiOGxwg/nV0czQsiZ1qsfv9Bvb
         ZB7VKPWokxowxwp4D/mOkj3bEFG70QyDmFeUQTKYSy9gJK/mdc10K3JP5qLGnXUn3jbW
         bFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwmjIfZp3ey5bXiDBuBk0tZXXl99/POS9aNjyShfZJV+DgNVuxBqhbG3HgUZl2F2GQTQwqTGQSFllbW+k@vger.kernel.org, AJvYcCWS8RLjuYytvpHokDThNJNwZ2HiWA0b9NaWZzrw+MIhNf1bfzeHEQvxCqj3j39c5vLqyRAdxNguNvU2EeyIUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkPfqavOCQEhR91Cz2tDO0j6fmOTSigw4XKbzpICtZjFiLMjex
	LKViUeO5FJYZW5rGkhkmexix8KPOXZCqS+tHoln4IBFIPGDUWLECyvm4f9H/rQJATdJhXTQhmAg
	gXTb2X0YSZR6tokE+ay3jYRcI3U0=
X-Google-Smtp-Source: AGHT+IEY+AGU0N7m9g4OLxEX/VyHqnM0PYtAljr+SzAXzL8z4R2ApDgx0oWdC708tKUQ/OldPqQ2oCMKXRkv1Dzr+VY=
X-Received: by 2002:a05:6214:2b98:b0:6ce:26f0:ea41 with SMTP id
 6a1803df08f44-6d39e1b16d1mr300167036d6.31.1731586775648; Thu, 14 Nov 2024
 04:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114100536.628162-1-amir73il@gmail.com> <20241114-unsitte-betrachen-5b19d4faffdd@brauner>
In-Reply-To: <20241114-unsitte-betrachen-5b19d4faffdd@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 13:19:24 +0100
Message-ID: <CAOQ4uxgOaH=iaszUiVRe3k7quWjdJoVkKREJkG1z4SEgEEHvbg@mail.gmail.com>
Subject: Re: [PATCH] ovl: pass an explicit reference of creators creds to callers
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:52=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Nov 14, 2024 at 11:05:36AM +0100, Amir Goldstein wrote:
> > ovl_setup_cred_for_create() decrements one refcount of new creds and
> > ovl_revert_creds() in callers decrements the last refcount.
> >
> > In preparation to revert_creds_light() back to caller creds, pass an
> > explicit reference of the creators creds to the callers and drop the
> > refcount explicitly in the callers after ovl_revert_creds().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos, Christian,
> >
> > I was chasing a suspect memleak in revert_creds_light() patches.
> > This fix is unrelated to memleak but I think it is needed for
> > correctness anyway.
> >
> > This applies in the middle of the series after adding the
> > ovl_revert_creds() helper.
>
> Ok, so you're moving the put_cred() on the cred_for_create creds into
> the callers. Tbh, that patch alone here is very confusing because with
> the last patch in your tree at 07532f7f8450 you're calling
>
> old_cred =3D override_creds(override_cred);
>
> which made it buggy. But I see in 3756f22061c2 this is fixed and
> correctly uses
>
> old_cred =3D override_creds_light(override_cred);
>
> as expected. And together with that change your patch here makes perfect
> sense. I don't want to complain too much but it would've been nice if
> that was spelled out in the commit message. Would've spared me 30
> minutes of staring at the code until I refreshed your branch. :)

No, do feel free to complain :)
At the time of writing the commit message I still did not understand the bu=
g.
It just made sense to me that the reference should be passed explicitly,
because I *thought* that ovl_setup_cred_for_create() was dropping the
last reference after the last commit, but that wasn't going to explain a
memleak (quite the opposite).

My point with *this* patch is that it was more clear to code readers
who is responsible to drop the reference and after a while, this
clarity also helped me to see the bug.

>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!
Amir.

