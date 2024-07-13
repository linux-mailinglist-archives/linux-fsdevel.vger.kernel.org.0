Return-Path: <linux-fsdevel+bounces-23643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4693070E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E741C21335
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340CD13DDC2;
	Sat, 13 Jul 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXtnSy2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37113959B;
	Sat, 13 Jul 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720896113; cv=none; b=go4Q716vTLaVCnwMHybSE6arRTUi7irNHi3vza4PTY2EZ6bmGfbdwRIbm8BwY5Va6qB1CnFq7IjkbvGRaRx6txgio/6iIQeaTagUz48wSyOMPC+6AAlLzd6CB9dr2gu0R62+TeNohCZsQtc+dMYmE6nuAYSwTc/DENF9P/IxUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720896113; c=relaxed/simple;
	bh=VxeF9r+i/A1MmYXGnnGmTrPHucjUB0D8a6b9GyDw1tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOaXsdgxBUQbUR+gQ9oqsWyvSBvlcBZVaKN75mLrGzHbpWiOsEEysdtcezswK0SwXTmOICpDHA8MAuSuZX5Tje5ZQqWgIy9/VBjKxIHZuzy4YVIE4x4osz6c39udZMJ9Mdr5DvJjona4YirWYUx5lvuqxS0kkYRiRzETQDc4zaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXtnSy2V; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f0c08aa45so218949085a.0;
        Sat, 13 Jul 2024 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720896111; x=1721500911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SHKpyuTe51trZ26MAMppaDnAntLJZmse84+tZRaU38=;
        b=VXtnSy2Vb7pk4I8UAA1ekLM/HJ1bZZE1RVSoPMAk4u3+mpA+tszeZ2L/ALcSQ/zyqH
         4w7eyeGJX6iar1Y6Q5mu0w045RaO9vwYX994zfzt7a99Af9zY0o/QaVYye7q+e98rkyk
         Rv6ei2ppzl9+e3PQEy45+1M09glpuwhWnxsBDkwW5eGdDC+YkqT9VnbGPg5dNh5+yJtg
         p4CQKuLXnvj6Fn75z5StyZBCB1LK/yzmc+SnaGWcpwoneTZQoLrpfx7uiDMPcthLVGWY
         WEWoEAzEtdXKAxHiJ0IonZC/Fx4xoDPAlgh164K8ATQ/TFplhgDSo+qDhodEw2Urq788
         uBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720896111; x=1721500911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SHKpyuTe51trZ26MAMppaDnAntLJZmse84+tZRaU38=;
        b=LZwiVX1c5NHODcXpuGt3IfNNdMx9GcFEGvNO6SSv4kfwE/JMfA6SKbRGLhkwdKD4DE
         dKZ+LBhcfmof32xG9A6V7epdmJtI5DA26xF7vJkeshHJR9LHh6a/TUacVGw1HMj6iz1l
         2GSapGJZir+Saagm3iqW1He7YMezIprFFR43kKxjMn7vnjThQ/IkNhDi43LyDUtybMAc
         YxbNE4ybREwk240OgEFH/n/LJ4lzbCyNtUqsQTbgxBhLQdrusgXUVLWkv7FpWIL5UPuV
         pdvOIQUPFD445fVYki+8B1VhXSoGDti/z32JPNs+6CO7r0aXtPaOFMSQc00D9nVQ0TGA
         n34A==
X-Forwarded-Encrypted: i=1; AJvYcCUu/H0Q2f+BruCc1IswMy7Z4yywnXwVBKdDm5IdlCzqpiGnGULG9vr0iDmg604LJXw7YnZUyOZg0OnwkRcoY2oHqY2FxpemEsH+/npV3vka6qh4IpbOdU4gx8ZX3/mrw7auxfkFGX8v5g==
X-Gm-Message-State: AOJu0YwovynLLX6+G6cs6VLaWvBpR5waalNEfbIdhFsvwgoh0uRU+909
	iZ/Es2oiDtKNtAAVW45I7ihZz9u2S/yAmhOCFyZOSCUayrzXnu+nOd01tkJ6hCr1qq7EgzhWDSk
	8quVK2I+0PK9pN8U9xViG8FvGmsErze3FYAc=
X-Google-Smtp-Source: AGHT+IGx2CO85FyQF6juBhmUgfhglCEOhKQX5GQScEVvk9gAtJAHUvJmAxVt1thHoibOU3b+hhFWm4I7ZXsbRe+WTyI=
X-Received: by 2002:a05:620a:a4a:b0:79f:7a0:fa9e with SMTP id
 af79cd13be357-79f19befb2cmr1500362885a.63.1720896110954; Sat, 13 Jul 2024
 11:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713181548.38002-1-cel@kernel.org> <20240713181548.38002-3-cel@kernel.org>
In-Reply-To: <20240713181548.38002-3-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Jul 2024 21:41:40 +0300
Message-ID: <CAOQ4uxjvtJR+jW7Ob_dW8+fJHBu03ND_oVkAVhTE211CAuTJBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fanotify_init(2): Support for FA_ flags has been
 backported to LTS kernels
To: cel@kernel.org
Cc: alx@kernel.org, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 9:16=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  man/man2/fanotify_init.2 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index e5f9cbf298ee..12378ac05255 100644
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
> @@ -330,7 +330,7 @@ that the directory entry is referring to.
>  This is a synonym for
>  .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).
>  .TP
> -.BR FAN_REPORT_PIDFD " (since Linux 5.15)"
> +.BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
>  .\" commit af579beb666aefb17e9a335c12c788c92932baf1
>  Events for fanotify groups initialized with this flag will contain
>  an additional information record alongside the generic
> @@ -460,14 +460,14 @@ The fanotify API is available only if the kernel wa=
s configured with
>  .B EPERM
>  The operation is not permitted because the caller lacks a required capab=
ility.
>  .SH VERSIONS
> -Prior to Linux 5.13,
> +Prior to Linux 5.13 (and 5.10.220),
>  .\" commit 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7
>  calling
>  .BR fanotify_init ()
>  required the
>  .B CAP_SYS_ADMIN
>  capability.
> -Since Linux 5.13,
> +Since Linux 5.13 (and 5.10.220),
>  .\" commit 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7
>  users may call
>  .BR fanotify_init ()
> --
> 2.45.1
>

