Return-Path: <linux-fsdevel+bounces-23636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5869306D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A4C1F21961
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AEE13D26B;
	Sat, 13 Jul 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcLZjHqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D81125B9;
	Sat, 13 Jul 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893778; cv=none; b=R/sCtdDOYuPYXDaw9f0QSZdpLQ7CvjBVWLryboxQfwaXBwgaha+cdjWhqFJcApCU4PNzEgwhtaWaL1Ugli+k32jmYV/toSU4ID4DE4ZE8UtLprjRKeI0PKVVI4sqL6g5siWnOGu5uZeAaQJ71ceJ5BL1O++IbPLWMVYjv0w4P8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893778; c=relaxed/simple;
	bh=FchtTNMk43f4aPozaY5rZ/GunSmLHYGfdKCWf1W1SHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4/G3aWD8eHHaX1XG8Baw32sJe+NGN0rsiSTXCtgbN/SA1gx5IMrthZ3u6Lncd2AeknDMEtBKPYawMawIx3zwTzbJDl+5FrPAIYVn3Qkfwhiz3zC34quU4v9H+eO4p1K+pDzDKtbSI3sS9B3u7C7BT2gFrCaUhtLoc8sWRE90BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcLZjHqd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d93df6b54dso1780103b6e.2;
        Sat, 13 Jul 2024 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720893776; x=1721498576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se+tToY6mdcDj/jUCUB7LpEmpUTqGapDeQqzl3mmIFs=;
        b=jcLZjHqdAUgmCayulpLX5sXgLN0db47j9d9MJGRIG2UAktu6pgiapgBMDUolz4EOYl
         PAxtVCNBDorw05PRDnwx00EUmgfoXXm7gJms6+sIH1u2uvT7a7nVN7N6OrVy2YbTeDDq
         490W8Ut7JRMprSXc5wXOsW0bYoyIz/Kt4e6TcUV0b5M/pdNWRFVqYk+duXzUQR/ywXtN
         LAxJC0swFpF3iqRkoqpBVhUs1g19wdXOCOI/OIaPbv/GE9R83nboyqBXuTXDgYcLRy4p
         0U3HudEmwhRrTfGSVDXaILavK+ss5TRa2UHjR6GmEngqPtCSPjh2Iwk2kieJ+CbAe1zb
         mDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720893776; x=1721498576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se+tToY6mdcDj/jUCUB7LpEmpUTqGapDeQqzl3mmIFs=;
        b=OE2PeR/7DCNrWEbDdl7N4ylyA3ApLY2Ieg6FudOIoeNq7gBRG0Etgh299MshBcjNsb
         URWlg7eApV1qsNESaDJCW6O7AXXiefzZSbgAKK2FJ4WwdMXMZDbnTsHE6AFAycnJQjgP
         JRMA92DapCElhTVvIOUiVfUQmxvNpf1L7nJ7wPddhd2YwKI5yXGws+jynz2Q1Pi84fgi
         DZhiPZMrm0GYhGBwQXbvWuLS3lx3h6swJd9LjFzx25V8Tk1ChSCT739TfUWeLJexF30w
         8cqqYFA6Rn1p99vIUxcPmUaJK04ieubwsXSuckYVGoE59lXpn7YXsH2G3Svf2TiR63dF
         85BA==
X-Forwarded-Encrypted: i=1; AJvYcCWGfnYiRZRpw0BicFo4D5j2J5g3QkpXegTL5lQ2bhXw9+95uAUkFeCnmAgSJT/lm6lX+jR44vknHgEk/rmdTizc3L75nN/h5hhHOlI1pKdFxJbsRkwvUhFGldRfDnSoXybj1jooRgiYsQ==
X-Gm-Message-State: AOJu0YyGPDrAywd8AZgZmJE/0Pv5FDDtqz/A/ce35HJOxuxGdqIgQJlF
	fudPg3CCK514+cIdkgGAzKRyoFRGreJ5+fFC+fvnowdd4HiuBh9GgeXl6uo77BSCca817wcpgSA
	zaabjUHk1b8X7m4r4tULc3gsJUL8=
X-Google-Smtp-Source: AGHT+IFzuv/pkf33uKV0dVMjWOoEWu9tissZfoR+wB6wKmMHlQMvVSzs5QCSQtjJcnfIGiHVeZgG7M8OkGuuahoohYI=
X-Received: by 2002:a05:6808:221a:b0:3d6:3106:52bb with SMTP id
 5614622812f47-3d93bc0c140mr19450414b6e.0.1720893776439; Sat, 13 Jul 2024
 11:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712175649.33057-1-cel@kernel.org> <20240712175649.33057-2-cel@kernel.org>
In-Reply-To: <20240712175649.33057-2-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Jul 2024 21:02:45 +0300
Message-ID: <CAOQ4uxhF9KdLoZRHjXZcWpA_AJn+nXE4DdMbHOvB7Oh9TDL-9g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fa_notify_init(2): Support for FA_ flags has been
 backported to LTS kernels
To: cel@kernel.org
Cc: alx@kernel.org, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:57=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Please fix typo in syscall name in title

> ---
>  man/man2/fanotify_init.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>       Since Linux 5.13, the following interfaces can be used to control t=
he amount of kernel resources consumed by fanotify:

> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index e5f9cbf298ee..51c7d61fd86d 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -295,7 +295,7 @@ for additional details.
>  This is a synonym for
>  .RB ( FAN_REPORT_DIR_FID | FAN_REPORT_NAME ).
>  .TP
> -.BR FAN_REPORT_TARGET_FID " (since Linux 5.17)"
> +.BR FAN_REPORT_TARGET_FID " (since Linux 5.17, 5.15.154, and 5.10.220)"
>  .\" commit d61fd650e9d206a71fda789f02a1ced4b19944c4
>  Events for fanotify groups initialized with this flag
>  will contain additional information about the child
> --

I think that is also needed for
       FAN_REPORT_PIDFD (since Linux 5.15)
that was backported to 5.10.y?

There's also:
VERSIONS
       Prior to Linux 5.13, calling fanotify_init() required the
CAP_SYS_ADMIN capability.
       Since Linux 5.13, users may call fanotify_init() without the
CAP_SYS_ADMIN capability
       to create  and  initialize an fanotify group with limited functional=
ity.

and in fanotify.7 there is:
       Since Linux 5.13, the following interfaces can be used to
control the amount
       of kernel resources consumed by fanotify...

Both these changes from 5.13 were backported to 5.10.y.

Thanks,
Amir.

