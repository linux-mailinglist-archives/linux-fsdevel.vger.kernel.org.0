Return-Path: <linux-fsdevel+bounces-57846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B569B25E31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91470724728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625C271465;
	Thu, 14 Aug 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCOUCZn3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4222D78F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158098; cv=none; b=bUEemdm31XK0wgFXdD30fsRf/bWg2ofRhV5PoO9M4z2N/PzDgtj+/YnJeca/mh+jK77xsMJcT6V+7rGT2SUPT6wFmvQVHM9kfQ8MJqfNta5ouB6xP+gnLEO8SwHQPvwzazeWUIMYgIeTt7X5Z2GnCnxqF73noglvE46Gc02WGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158098; c=relaxed/simple;
	bh=NsuZp5KWpRD6tfQ9LDwn6rkD3e1y2HYyQYROQNn3EV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WirNNq+S9LidFSGgsSN3gVWTjBOERCl7Vcdm3WJbukrVvpm8ung2iG19+268PO6gJ3QqrPlBrvjT6TfcGpaT3GIulRzTbT61XEPIc3GFVGA2sbhqg3Vhd/f97Qi7iYLl3oZdIY75SZBpGVRheOQUqFi2u5w+QmZuGGExQj8mZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCOUCZn3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so1105556a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755158095; x=1755762895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLE0Jxvgwbqd3E/OZMrN/kd1pEOSiQcQc5zvkbNieXE=;
        b=YCOUCZn33Vd6jSLcs3mrQAK5wt1YX/sDkWbQOQBl3n+aBingR3Xtbb8KNROHcJDp/s
         yJw/X0xnJVpQtu4gpYiyITQ8H2JEyu6ybNEcCaiFOUWORM+2Cdkv9MslgPHzQiM7uTP4
         SEnXpmyumRJyPLD2olHPIWX2rjhCw5YjXUsKHtPugEf9keEN3mVt2xTpMK0lbKVp+vJz
         0/f81bf9IIBVK5CrWT77xQtGRFgQYkKkH3gtQvmh5QIau1PP0LOrnHIw6HJxx5EAwP8p
         mnC0wpVvW3QNMJctRo8cb9xFXyCd/iVOKOvXg94TMObNJ/+R4iZoMT75hnKH5krB5rny
         Owwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158095; x=1755762895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLE0Jxvgwbqd3E/OZMrN/kd1pEOSiQcQc5zvkbNieXE=;
        b=c5kf2MDmvDfC+mxvRJ6VHVdkPNVcXtn7nq7X2YjNVpIKzqsE6QJ2aBbMdQNRcnQ3yr
         o7PoHUuCSPPFfpMopk+51wUYf9cp81kFFpPx8JucibIii7PknpWJ1IyK6Wtk14KL1RXh
         l/QjVrciuAbn0yp2rv7OerzRCRVCp9xq6kZfLLHN3oAlAAhzbnf/vEu9XSDnAzPotgQC
         Yd03Gd3s1CoifMLK6yvSZFdVp3XL3zHtr7/sIWWuGkzxvM9PGnf5VkYZfjV/VOP0q166
         7YakRY04Jg/FDem4LM7WO+ppDftT5PbuYjJ33z5eG8LGSdJ/TdqTuCrbPwhjkk+qzp0a
         FB+A==
X-Gm-Message-State: AOJu0Ywy17D2sb2wKgdumFaG6cmy/euXcfHblY6hFrYzGoBNjE+TdHeE
	i8VuHZCK2vVcFWDMkNTY+x67pJBQ57axhenY9AkTtZqLF6grcVzrrMFAkbGW9iHOnODLSeiw9M4
	5Hl67beKxv5euT6tdEAMgfsxYPAJiplTjWql3+TQ=
X-Gm-Gg: ASbGncsseMFHtcB+FlggIE8JAghZIuHHzJlAYuvm9DUdI/sQZjuDZpmO3imTdyod9TS
	Nzzje8jArTNYTwPy0riVxxX4Sd1ac5GyndUe2bBjifEdpGi+w0KayftvwXJ6Edut2vWqWTb72VA
	3vYBWsO6yWl1kmbsJvax05nTJoocET/r+4fp0BkOssKcApLKP9alNvgOSh1s51YGcw8rqMGtldM
	8ZcIqg=
X-Google-Smtp-Source: AGHT+IEzbMF5ml/feXeot+QrTKwFXT2EZ7gCY6Rx0/YprKi3yasWCcrmTVZ7AAvHVddHvclAVxoKWEvKrXsX4qaYwKA=
X-Received: by 2002:a05:6402:1f81:b0:618:3a9d:53da with SMTP id
 4fb4d7f45d1cf-6188c201c82mr1747539a12.31.1755158094758; Thu, 14 Aug 2025
 00:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151107.99856-1-mszeredi@redhat.com>
In-Reply-To: <20250813151107.99856-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 09:54:43 +0200
X-Gm-Features: Ac12FXz1hBjfAJds2ceGWaMXpC8cW1eCu1vDk8qNXYHnx27k8dCPUzfJB_5QhYo
Message-ID: <CAOQ4uxjsYsNBXdzRr5hfC3gx1S7DOgg6buiktu=+Q4Jc8Jz1Ww@mail.gmail.com>
Subject: Re: [PATCH v2] copy_file_range: limit size if in compat mode
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
	Christian Brauner <brauner@kernel.org>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:11=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> If the process runs in 32-bit compat mode, copy_file_range results can be
> in the in-band error range.  In this case limit copy length to MAX_RW_COU=
NT
> to prevent a signed overflow.
>
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.=
com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> v2:
>  - simplified logic (Amir)
>
>  fs/read_write.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index c5b6265d984b..833bae068770 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1576,6 +1576,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, =
loff_t pos_in,
>         if (len =3D=3D 0)
>                 return 0;
>
> +       /*
> +        * Make sure return value doesn't overflow in 32bit compat mode. =
 Also
> +        * limit the size for all cases except when calling ->copy_file_r=
ange().
> +        */
> +       if (splice || !file_out->f_op->copy_file_range || in_compat_sysca=
ll())
> +               len =3D min_t(size_t, MAX_RW_COUNT, len);
> +
>         file_start_write(file_out);
>
>         /*
> @@ -1589,9 +1596,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>                                                       len, flags);
>         } else if (!splice && file_in->f_op->remap_file_range && samesb) =
{
>                 ret =3D file_in->f_op->remap_file_range(file_in, pos_in,
> -                               file_out, pos_out,
> -                               min_t(loff_t, MAX_RW_COUNT, len),
> -                               REMAP_FILE_CAN_SHORTEN);
> +                               file_out, pos_out, len, REMAP_FILE_CAN_SH=
ORTEN);
>                 /* fallback to splice */
>                 if (ret <=3D 0)
>                         splice =3D true;
> @@ -1624,8 +1629,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>          * to splicing from input file, while file_start_write() is held =
on
>          * the output file on a different sb.
>          */
> -       ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -                              min_t(size_t, len, MAX_RW_COUNT), 0);
> +       ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out, le=
n, 0);
>  done:
>         if (ret > 0) {
>                 fsnotify_access(file_in);
> --
> 2.49.0
>

