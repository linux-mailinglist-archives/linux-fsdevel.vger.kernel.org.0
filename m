Return-Path: <linux-fsdevel+bounces-49573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C7ABF1C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6897A4CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65825F962;
	Wed, 21 May 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHC4igIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CA2367D4;
	Wed, 21 May 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823773; cv=none; b=siKkfYL1UKqfZjcqZW3EXxCIfEapuK+bBlde0mbY4dxXEYOEns8KglLl/ztLMUOPotU6u1wJSUPb82CR5bl84+2h1YHX5es3FLzkVVSLe46kl4oGLGlHOGk0dnotBUSpMOZnDu5fa6F90HJF/mPmREZs8YBFXbsZ706pemINU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823773; c=relaxed/simple;
	bh=jaHDgJmILJuG+Pf3sJLP9RGWHh9WdqjMsaqcFjHPDTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIY1mbpMuTHBdNuZfWVNXsz2q76BKuVp0dXZyYbgYy6e10n4U7RftvXKgHflRm2eaPDjhHjrc+9ZRXLgUqj4RtQd59TEfbLWiqFxJR0NxF0miDdQ848mr0UtcFw4yxJdJfO726cn9VZu/bxfb/hiOHvSRC7+oEQcuNhlzrAyXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHC4igIB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601aa0cb92eso5065401a12.0;
        Wed, 21 May 2025 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747823769; x=1748428569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zgXc6wASgYobl6ZoqSP5/L4jin8cfV9FbA1sERsoBQ=;
        b=aHC4igIB8P6v/NefHpWFbeu6UU7EWu/3Li4p1KiUspgggFFwXrcAEjWfG7D9we33UH
         AX0v6WP8n6OR4O/sBAn7M+dZHz5ZTmb5CN2MzTjRF404KFiEcQslirku9iAaXNQitZ8t
         lsjdYu6mTYn9RExUGzh0dEEgpC9IZeWB4hwGD8X4WEa31tEbrCvOXJleiqDtU/OouOS0
         9CzYZ9FUa5jvQBCsyooVl5pmhaF0sLA8AALL7s+OqPrHcP8E+9dVucEoh8TvSLWkNh7k
         VUyncuqem5fKmWnTUpV2NDVEUNMmiVM14uZ7yYWW7YeHRrr5OTGbAngCpOJsciCvmyYI
         XDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747823769; x=1748428569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zgXc6wASgYobl6ZoqSP5/L4jin8cfV9FbA1sERsoBQ=;
        b=mO7wuNfn5MmhtdrTqQvXDfrzwHG21yJB/ks/cYxsJvo+rUsxahu2My6zLJlmsaud+k
         vRUaZtdXN1B2FRcn1QeDLC4aieKtnEUHACcsMePjYuQKs5//+WSjcMraubfc/uyZE/uy
         vtAQpC2KaGVBqi7ivE1x0nKqPOFpHXI/crwQIwwKnkV52ow+m8HU+9p02CtGUWtW2zmp
         sT2uVyfuISxgtqYroNDNGc7X6aGQ1iF9TJaAwUR7Vt2deJNz4AhnnK7Zx5Yz819kOBv3
         1UbEjJr/Jau4fQx1bN3AemfEtA2xjfi9csrw5PcpGqLj+MeWSusnmLOkgIxFusPtLYhs
         XfNw==
X-Forwarded-Encrypted: i=1; AJvYcCUSa4q7HC2ys0iLo8xAFTDpHZQmZzQeFdM0MsrHxEQv+aQe8SQSszzI2qL7ZHwlJgKuxxiiqL9w5ByBRloB@vger.kernel.org, AJvYcCWbzzw657+zBbxlsL0oU6uuAazLKtbke96jsyzCk/9QRupCP84YRGb05dvLEmgliMyORg3Qv5CEYFtrIMDi@vger.kernel.org, AJvYcCXo+/B9X/54ebiwtpWw59mn+4KT1q82bzSiLvE/3N8kEtSGpwQj2EdVYp9pDsQKhpXCU3CPRmEAj14N/KKBGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIpVn1fs7xo+tlog0qFDauMxj16/6qz5N89aIY6yNqHYVg1m9
	VonIlUCkaO7Exj2nVoM+cqnbZHBOIWosWNafjyF7R6R+5VT4dSoqVDAQRi8jBIew8gprdxV1cvQ
	YzoGSfXrQF+beYtng+QrN2XWkWFHfGWs=
X-Gm-Gg: ASbGncuxY7lQ3VkBiEvvn4MWRLzMBeeuYEkIFihQEWQCFzoPazGxFQgKZXRevDr+M0q
	+quNmP1LpDo4YYRSkvrUxpsCV3kCYS1dkDmhPig7OYJF5Y8xNo0/81hPUCNSbAVA9+KuyUOYJz0
	b8jVbn3auf60r+qPZwbFOalx9R5uEiuTJ3
X-Google-Smtp-Source: AGHT+IFwe1NHoe6RpoNzGj5yF8UoZtXY1oenfF30QD/04DM+NIgSerwL4sx8Bn0TPf8jkNGPio46scbLLegs0kgsNGQ=
X-Received: by 2002:a17:906:c14d:b0:ad2:4fa0:88d1 with SMTP id
 a640c23a62f3a-ad536b5731amr1645827466b.9.1747823768649; Wed, 21 May 2025
 03:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
In-Reply-To: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 May 2025 12:35:57 +0200
X-Gm-Features: AX0GCFsp8gIxaeGVp_TI6VZ9CUo85mJmg9MpuNDq_Ao3xGMrKbOErTCd9jOCAFc
Message-ID: <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:45=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Allow mount options to be parsed on remount when using the new mount(8)
> API. This allows to give a precise error code to userspace when the
> remount is using wrong arguments instead of a generic -EINVAL error.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Hi folks,
>
> I was playing with xfstest with overlayfs and I got those fails:
>
> $ sudo TEST_DIR=3D/tmp/dir1 TEST_DEV=3D/dev/vdb SCRATCH_DEV=3D/dev/vdc SC=
RATCH_MNT=3D/tmp/dir2 ./check -overlay

I advise you to set the base FSTYP as README.overlay suggests
Some tests may require it to run properly or to run at all.
Probably related to failures you are seeing though...

> ...
> Failures: generic/294 generic/306 generic/452 generic/599 generic/623 ove=
rlay/035
> Failed 6 of 859 tests
>
> 5 of those 6 fails were related to the same issue, where fsconfig
> syscall returns EINVAL instead of EROFS:
>

I see the test generic/623 failure - this test needs to be fixed for overla=
y
or not run on overlayfs.

I do not see those other 5 failures although before running the test I did:
export LIBMOUNT_FORCE_MOUNT2=3Dalways

Not sure what I am doing differently.

> -mount: cannot remount device read-write, is write-protected
> +mount: /tmp/dir2/ovl-mnt: fsconfig() failed: overlay: No changes allowed=
 in reconfigure
>
> I tracked down the origin of this issue being commit ceecc2d87f00 ("ovl:
> reserve ability to reconfigure mount options with new mount api"), where
> ovl_parse_param() was modified to reject any reconfiguration when using
> the new mount API, returning -EINVAL. This was done to avoid non-sense
> parameters being accepted by the new API, as exemplified in the commit
> message:
>
>         mount -t overlay overlay -o lowerdir=3D/mnt/a:/mnt/b,upperdir=3D/=
mnt/upper,workdir=3D/mnt/work /mnt/merged
>
>     and then issue a remount via:
>
>             # force mount(8) to use mount(2)
>             export LIBMOUNT_FORCE_MOUNT2=3Dalways
>             mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=3D/DOES=
NT-EXIST /mnt/merged
>
>     with completely nonsensical mount options whatsoever it will succeed
>     nonetheless.
>
> However, after manually reverting such commit, I found out that
> currently those nonsensical mount options are being reject by the
> kernel:
>
> $ mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=3D/DOESNT-EXIST /=
mnt/merged
> mount: /mnt/merged: fsconfig() failed: overlay: Unknown parameter 'WOOTWO=
OT'.
>
> $ mount -t overlay overlay -o remount,lowerdir=3D/DOESNT-EXIST /mnt/merge=
d
> mount: /mnt/merged: special device overlay does not exist.
>        dmesg(1) may have more information after failed mount system call
>
> And now 5 tests are passing because the code can now returns EROFS:
> Failures: generic/623
> Failed 1 of 1 tests
>
> So this patch basically allows for the parameters to be parsed and to
> return an appropriated error message instead of a generic EINVAL one.
>
> Please let me know if this looks like going in the right direction.

The purpose of the code that you reverted was not to disallow
nonsensical arguments.
The purpose was to not allow using mount arguments that
overlayfs cannot reconfigure.

Changing rw->ro should be allowed if no other arguments are
changed, but I cannot tell you for sure if and how this was implemented.
Christian?

>
> Thanks!
> ---
>  fs/overlayfs/params.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f42488c019572479d8fdcfc1efd62b21d2995875..f6b7acc0fee6174c48fcc8b87=
481fbcb60e6d421 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -600,15 +600,6 @@ static int ovl_parse_param(struct fs_context *fc, st=
ruct fs_parameter *param)
>                  */
>                 if (fc->oldapi)
>                         return 0;
> -
> -               /*
> -                * Give us the freedom to allow changing mount options
> -                * with the new mount api in the future. So instead of
> -                * silently ignoring everything we report a proper
> -                * error. This is only visible for users of the new
> -                * mount api.
> -                */
> -               return invalfc(fc, "No changes allowed in reconfigure");
>         }
>
>         opt =3D fs_parse(fc, ovl_parameter_spec, param, &result);
>

NACK on this as it is.

Possibly, we need to identify the "only change RDONLY" case
and allow only that.

Thanks,
Amir.

