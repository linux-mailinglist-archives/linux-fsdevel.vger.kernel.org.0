Return-Path: <linux-fsdevel+bounces-60029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A6B40F99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4921B61E67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047435AAC5;
	Tue,  2 Sep 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjsDNG46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE531E51D;
	Tue,  2 Sep 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849709; cv=none; b=k0bjkEPPidtFkz7rn/HiJ2JRGv7fSLviAlIFOLjwzpPXBn41Wi8BAIzbUGSqrVphK/6jP6QxsvOHGtlUf2k1ZJvuzgcyZPbMtF23mHx2nfO56mtHMEwmAPwB9my0LwpbN8UurliZm88dZ0eiD9goIrH9zjACDJwug5KN2oI7Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849709; c=relaxed/simple;
	bh=JDMaeQIZXgcvGxNJoe0QMs3oBaj5uOPO2pvFJL619ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtOmpqa7WZmXxlQf4a9yCBocjECRLJvkomUyU3i4ywm2oBqTndDPbZTl/eB/Hik79nblrlo3IzT8izAHGgGjNr6ox8Qy/1KmPGW8caTo7hEI85bs2Gx4C5mbpgDruzVNbACFqmmN4qs0j6m8W07YvYvHkXOMC7MQD1am1eNrCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjsDNG46; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b3289ed834so32532661cf.1;
        Tue, 02 Sep 2025 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756849706; x=1757454506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xujNdyGho9qZzVEzUCmbnFV/ShXcIfwfowfy/WsMA=;
        b=EjsDNG46d2bW5Pw4b6kAaYUjjTznNjVole3mLoTCsRgkKKDbvXRCZXG8zHJA0nOldM
         THxS8UmCdgERsLtQ+oPjtDc2LwtEjfvwexA/G/+VHLnqgxRfvolCiDFBcmlk4hJgowyd
         ALWW4PsH8plFLdTvJAikgKM2UUJphEbcDujjxSyUrJzr0P9XHfT5aczVCZg2LX1UgnRt
         kJBlEzOFjPl4BT3T9+Q6vE0dov96+JVrW0wNR8crBEUyp/T44LKgaUHBbDIAW3w7yU4k
         Ywdh105NtVzkd4P9lHk4GoowLyyxWfiLlzo4Gih5t/nwQ8Qgb4UJmaRZ4Xb0GoDnh31A
         SGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849706; x=1757454506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xujNdyGho9qZzVEzUCmbnFV/ShXcIfwfowfy/WsMA=;
        b=wO13or4viBJzFEXl09yfz4kHHlqu6zejMXzfydXJ32yTIAHct9CJDZQy01iGGIFo1f
         q6tCLSGa98RO214tvc+j6X31rxqcVPXs8PeeWF+bBW1mDUWSCUvZz9lG82Mbh0sWz+nH
         CXhMESGBxZRX8nOFmzVVEOd3fCA4cOcSbFOdKUE02/1mN6ryVjxe0q83W3i55xoaW/+Z
         naT3A/seiJCA3s50lIiejPRx/FH0GUovL5Y1CDN/Gil+WEf2FzHwxm4W7U6zO0yyyo0X
         4ivTHqnw/ys+n7yNJBlL0lx/6yfyJn8ll1ikbfxCAARTLx+dAIFaUcp9SnB2Zwvokg3v
         f5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeHHPAPcfMGDVcVjdtmGRsngF1vyz395e6/lIRL1olJXX8EJxwofimxAUQHseehERfrHjpXPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtT9HLzeqHhAcR9hoRhHB6dl9Yd2phPlVA+ZMT9iQygVkjshnK
	u7hJANfvgzEn1uOkAnyh31OswEpyfv4YkoihvAchndMucOYvjbjGDBNZb5CF7WVSUO5UX3B7xXV
	61S50JzJV5y5MICdjqtiBCRI4Iikl7TA=
X-Gm-Gg: ASbGncs0oKH9WWw5mEYgN+roWREX1exs1AcmXTVxs8HCIVMuDsnBLfubp0vudbYD71V
	3O1K4fkKQCBHgLyYMD57Jza7Ff1qoUf5ye2ahJnRGUYs8Z6+vhxMT7QDqzISgBpTHITx3w+twfT
	2doOjnB24Fi7NFEYoYmanYF0sWSn8lfM5gXmZWHGkTkzyaXNX1rD/jwa1mpf8E9slv2yux6pg4o
	FV1xmwUyKDMpA5k+6Q=
X-Google-Smtp-Source: AGHT+IGetVkoNVJ59eQDmcgeZPkeu+KWFX6Me8sdMtyOFnWpXJkWdZbBrFeGMRsaeiTyPcX8fi/b23ko4mSNl3jrweo=
X-Received: by 2002:ac8:7f4c:0:b0:4b3:2dc:8b84 with SMTP id
 d75a77b69052e-4b31da2384cmr198559611cf.47.1756849706180; Tue, 02 Sep 2025
 14:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com> <20250902144148.716383-2-mszeredi@redhat.com>
In-Reply-To: <20250902144148.716383-2-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:48:15 -0700
X-Gm-Features: Ac12FXyfIDwZFyd6e2Kak-EdAF3eiqGjq04wirdxi6vLh3R7AHkhN5IsKswHPXA
Message-ID: <CAJnrk1YHvViDGis_BY5UGi+jU-Y2fSuDaXXKh41NSQXiCBtngw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: fix possibly missing fuse_copy_finish() call in fuse_notify()
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jim Harris <jiharris@nvidia.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:44=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> In case of FUSE_NOTIFY_RESEND and FUSE_NOTIFY_INC_EPOCH fuse_copy_finish(=
)
> isn't called.
>
> Fix by always calling fuse_copy_finish() after fuse_notify().  It's a no-=
op
> if called a second time.
>
> Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend =
pending requests")
> Fixes: 2396356a945b ("fuse: add more control over cache invalidation beha=
viour")
> Cc: <stable@vger.kernel.org> # v6.9
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index df793003eb0c..85d05a5e40e9 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2178,7 +2178,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *f=
ud,
>          */
>         if (!oh.unique) {
>                 err =3D fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs=
);
> -               goto out;
> +               goto copy_finish;
>         }
>
>         err =3D -EINVAL;
> --
> 2.49.0
>
>

