Return-Path: <linux-fsdevel+bounces-44483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE29A69AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E8483A46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24C215175;
	Wed, 19 Mar 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTGJpFnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C67190470
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418925; cv=none; b=EzqJeZhLgn/0PuY8+VH/YE3mhhUtr3o8jRCT+TgF1QzFqzpKemxbwOdxkeY6NnPjTMvVoXTUUwfqe28Lqmc3MHEQ4X4TAht65DTTF7fk6M8XbBM1GLH9XrUCQXSU3GVN4MAmEbFdkPItqrQ7qeeJnf5STUxbzBDgxsbhkb2RNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418925; c=relaxed/simple;
	bh=wSzEf/d7Dvo85Fcblp4n9x2e9LIXFT0J3DK2gwMaBUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKdhrB45MKAZowq0nLOPZc3rEZfSW9pGbylnIjaJVvJx+27Z0H1KJo2h0fZ59EZD6GO+AvUrTwreUjFoIhF+OsimAXNZpH2rzW+n3GlQK9m3eD7YJTsd53bFDqTfRNK2+YQHHFEF2m/hijSTPyDiEhQwDOt6wjSAFiGlZzYnHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTGJpFnE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fcbb96ba9so2479941cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418923; x=1743023723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jQJ8SvXWmCdoqZuWRADaUXdNjNJMGihWtLho75XL6A=;
        b=JTGJpFnE8wgGTXQfVqu57IAddocxYSpantgfXw2cEdJ2kVYALoHjYa7LoVpnpFQOy6
         2Mk/NXiZ7Uu6DnEANOiJmFqUSyn5DXrvMWVs1JkW8uHjKRN3l88XF32vsvwk7os+7TuF
         G0cwL3e8CIAJxSI9edsk9hBTKSihrTe+M2doEEMGfps06tvNVOorkGAV4f8VagW6sGvN
         4CUbV7B2h3S/ew3ypa+CyFcmQ0bJ0w27UM5kgpiLWi5QetzKDADGGAg9bvOTkXLSxheE
         cxkI+aZr12DTnL+SJsGqNRdIYIoRLdchL6A1ZDLWcFxBHIt5a0hvyXDwhjqwvNKCvFBE
         M24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418923; x=1743023723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jQJ8SvXWmCdoqZuWRADaUXdNjNJMGihWtLho75XL6A=;
        b=o1WwcP86SWJlhm7T0f9TBMF2bS3dPfkgwfRfLJz5xbgVlwTFL/YHwHIy62HEPG+3Rj
         yrNSB5RdtEF1g1GcZ30Il5tPQv195wSnj6Cgbs6bl480/9lKefd+f+7Hr4TTLyXSmgsY
         m5rwBWJCEGucfeKwGtsPW68w+G12XMgYrdS3fFz+FNSQaIfblKL3F0tjY9923zIqRDeq
         8G4hDwWWQWaVV7cMLD7q4jkocENl21t07AXy6PTfdYFup2nZS/jjqphfaj8MCdJkTuGl
         LN6sFpmFEZjuxHa/nOanXyOR3j/nP032TMT/Q9njEY6o1oL4+T0/CtQqsO5zJlv2946F
         E+4w==
X-Forwarded-Encrypted: i=1; AJvYcCWx4118RUt3mIUsVXsXvr1jEVO6vwXXW4io4NLe/XHxK+HuibAT5v1/THKGI1GgHz6Hnkh++XM1vH6Sr1Wn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lU2+L7BBSqSjGZuvF+obkoneLg/vFQ0aIDO9f6JeLZeZxivr
	yYXR3qxhwLhATUDOyX80mFrahW4MuhNO6xHfQLNptU62i6eXedkFtoRlcDmkn2Ec2UqTo9VyWq2
	oJdwdm4+3SzoxTb9OIX9L27bh5yg=
X-Gm-Gg: ASbGncsI3XQQ88JbLZMh1LBE7cnTKgKEgeL00y716wbjW52vBpqP704kyMJ+ZBAXK0y
	JwF15wk1aNPEofzj2Dg5lD2QdROqfRTPT49F01iLf1TYRXuw5SfslXfsfaq5i0hCs4TGiu0uQUN
	Lqeh9pKtM2bX30T0Z0IFIFmpGO2Sk=
X-Google-Smtp-Source: AGHT+IGI4nP6xZlM1ve8aW+gsQsq5N0R0QvKNEZPGnGOweaBKxbFCSLm3lVxA2y/rL/yQ2n/QXQp8CVZ2i0iMHEjzvc=
X-Received: by 2002:a05:622a:4d0e:b0:476:8db0:8cae with SMTP id
 d75a77b69052e-477082e2555mr59273461cf.10.1742418923002; Wed, 19 Mar 2025
 14:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com> <20250319-fr_pending-race-v1-1-1f832af2f51e@ddn.com>
In-Reply-To: <20250319-fr_pending-race-v1-1-1f832af2f51e@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 19 Mar 2025 14:15:11 -0700
X-Gm-Features: AQ5f1JpwFe9LPlsEkkiZ5Qt5bSz_wCgxGUGP4YgXRXSWKH2OLaJfqkmwI9wS4dM
Message-ID: <CAJnrk1aqS__AK0=hUkDYUPd6_BP8Wx_y2j1q-H06amA203t5Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Clear FR_PENDING in request_wait_answer
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:37=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> The request is removed from the list of pending requests,
> directly after follows a __fuse_put_request() which is
> likely going to destruct the request, but that is not
> guaranteed, better if FR_PENDING gets cleared.

I think it is guaranteed that the request will be freed. there's only
one call path for request_wait_answer():
__fuse_simple_request()
    fuse_get_req() -> request is allocated (req refcount is 1)
    __fuse_request_send()
        __fuse_get_request() -> req refcount is 2
        fuse_send_one()
        request_wait_answer()
   fuse_put_request() -> req refcount is dropped

if we hit that "if (test_bit(FR_PENDING, &req->flags))" case and
request_wait_answer() drops the ref, then the request will be freed
(or else it's leaked). imo we don't need this patch.


Thanks,
Joanne

>
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c3a4d09e500f98232d5d9412a012235af6bec2e..124a6744e8088474efa014a48=
3dc6d297cf321b7 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -438,6 +438,7 @@ static void request_wait_answer(struct fuse_req *req)
>                 /* Request is not yet in userspace, bail out */
>                 if (test_bit(FR_PENDING, &req->flags)) {
>                         list_del(&req->list);
> +                       clear_bit(FR_PENDING, &req->flags);
>                         spin_unlock(&fiq->lock);
>                         __fuse_put_request(req);
>                         req->out.h.error =3D -EINTR;
>
> --
> 2.43.0
>

