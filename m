Return-Path: <linux-fsdevel+bounces-13257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B886DE9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 10:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416C9282EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B546A8C4;
	Fri,  1 Mar 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnffSj1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB426995C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286750; cv=none; b=Y4uLN9aTsw3uBsBLOghFmnAaoaWI1SoxLE9tCZWe2WQCbgLdJB/fwayYs8GlQhLJiSYw/IMkQ9xda47x1Lbw7ekdzctONl2noLYdH2BmaoIQ7NqMBg/9aegO+Yvs6mR2A88zIESGrWJkFg9GWj0tL0xZGb/A3looEInD/Eyv7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286750; c=relaxed/simple;
	bh=70YbMc0tPPivVPoU5OCuiFVI/rhyopnVhRsOoZL7ejo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkR7OFq8HjqAhmuRHkQNb6cYeD34ngUjl5LA6b8o4+nA4kJIqX7W+MJ/AZoViI1Bd8RIc9dRIBACR7SSeKCVLELvAR5oNFMy3PrsUegJ8RIutXJxRHIp+4Axx9O8F8R0CPUh0jdY2Xk2xjobPQS5asteFhc9h2vTt4oPOZohx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnffSj1r; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a029c8e76so12961881cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709286748; x=1709891548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XwZ4goGECdt4sHwCK0DrAmVReil2KaqmKBfOUYvHlU=;
        b=ZnffSj1r+A5C0/01rC7rvU3OTh/i3W6E8MzzI6b5Fen2RLNER4UX/IEJPkOUd1MByQ
         PUfo4VhX0sJGFGrZ3be4Mi90mHBti2MmDlLwJrEXRofc93Ll+fMqQd7Jk50fInzJ4ocl
         PYK2C235igx8K06pxGAo/khLvTY4LibvTWDoUId0E3dgi3KC/hCrb7kJjxRagJGwPuS6
         rFirqQP7oKfT3nk/1dBK4tJXf8sC9W1/N9+sRrZwGalxqM0J3DTPynUfoSjKEr49g/sg
         dhj24gOt7CULduBDLEs/kYTRMi6g2YUfqsBhHT97an8vaMzAgYeKkQQQR9lMFKNOpE+s
         jQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286748; x=1709891548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XwZ4goGECdt4sHwCK0DrAmVReil2KaqmKBfOUYvHlU=;
        b=rYg4VQaa8i14NxlvFt+1P/b4Y+OEjkvAab2MjeGcMlm1eXvaCie4WtQsJZYuwT7Y6n
         cH5cXWd+5bz8a+1f0hd9jDFp7qOmX5TZc2M/SomZdKsE4cT/0Gp2g96Y7HcfmelYL9Qs
         K3BohOUGaUt2CScwq9yRSjToRSwqI8ZWKSmlR3gxzne8RtWIMgYNbvzP3WqgvxWamzWF
         VAURGViExyys0D0x0H0u591xsp0A/rUiQf3Ts2QaezQ/3np1WWd6KA7SyEp/X/ik/Qa3
         520mllMZLcvUsOHUPEpy+Lcpv52/JZChmitakAbMiEEe+MQfSV5blLjeadOXpEtjszv9
         /S3g==
X-Forwarded-Encrypted: i=1; AJvYcCVQxihSxGG3dNsBTXa6MTfNO4gSwbGkTH3/0dVRjPzomA2NPI9fT7pWfiHs8RfsjUDaUeFG/TT2rjSHA4XCG8aXkGivQ6NCXIIgeMsYaA==
X-Gm-Message-State: AOJu0YyoMVT2BQm3xKzwOvW9FiToU4fo5+ELGO0H3WLhZeBzmyhzTw2j
	jCnBxNzAOM3ICpyvUfd8I2DLC6GB+KJBJ4zvIEADGyc6HCjmuTECS9KJILyqc7OiBGTKRTY6eMW
	LH6h5Wctgy7r1maUFAQEisPQefYQ=
X-Google-Smtp-Source: AGHT+IE+PABUaMZGTzO1Ic2R4/Zf79nkvHkPE67cDM+Eo69lD3b4k0IW7tPqYJ+2g7o3G1C3bPAPVF4I5kd1+J0bCSk=
X-Received: by 2002:a05:622a:1d5:b0:42e:bb8d:c297 with SMTP id
 t21-20020a05622a01d500b0042ebb8dc297mr1044349qtw.31.1709286747871; Fri, 01
 Mar 2024 01:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229174145.3405638-1-meted@linux.ibm.com>
In-Reply-To: <20240229174145.3405638-1-meted@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 1 Mar 2024 11:52:16 +0200
Message-ID: <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: move path permission and security check
To: Mete Durlu <meted@linux.ibm.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:53=E2=80=AFPM Mete Durlu <meted@linux.ibm.com> wr=
ote:
>
> In current state do_fanotify_mark() does path permission and security
> checking before doing the event configuration checks. In the case
> where user configures mount and sb marks with kernel internal pseudo
> fs, security_path_notify() yields an EACESS and causes an earlier
> exit. Instead, this particular case should have been handled by
> fanotify_events_supported() and exited with an EINVAL.

What makes you say that this is the expected outcome?
I'd say that the expected outcome is undefined and we have no reason
to commit to either  EACCESS or EINVAL outcome.

I don't really mind the change of outcome, but to me it seems
nicer that those tests are inside fanotify_find_path(), so I will
want to get a good reason for moving them out.


> Move path perm and security checks under the event validation to
> prevent this from happening.
> Simple reproducer;
>
>         fan_d =3D fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
>         pipe2(pipes, O_CLOEXEC);
>         fanotify_mark(fan_d,
>                       FAN_MARK_ADD |
>                       FAN_MARK_MOUNT,
>                       FAN_ACCESS,
>                       pipes[0],
>                       NULL);
>         // expected: EINVAL (22), produces: EACCES (13)
>         printf("mark errno: %d\n", errno);
>
> Another reproducer;
> ltp/testcases/kernel/syscalls/fanotify/fanotify14
>
> Fixes: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel interna=
l pseudo fs")
>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index fbdc63cc10d9..14121ad0e10d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1015,7 +1015,7 @@ static int fanotify_find_path(int dfd, const char _=
_user *filename,
>                         fdput(f);
>                         goto out;
>                 }
> -
> +               ret =3D 0;

Better convert all gotos in this helper to return.
There is nothing in the out label.

>                 *path =3D f.file->f_path;
>                 path_get(path);
>                 fdput(f);
> @@ -1028,21 +1028,7 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
>                         lookup_flags |=3D LOOKUP_DIRECTORY;
>
>                 ret =3D user_path_at(dfd, filename, lookup_flags, path);
> -               if (ret)
> -                       goto out;
>         }
> -
> -       /* you can only watch an inode if you have read permissions on it=
 */
> -       ret =3D path_permission(path, MAY_READ);
> -       if (ret) {
> -               path_put(path);
> -               goto out;
> -       }
> -
> -       ret =3D security_path_notify(path, mask, obj_type);
> -       if (ret)
> -               path_put(path);
> -
>  out:
>         return ret;
>  }
> @@ -1894,6 +1880,14 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                 if (ret)
>                         goto path_put_and_out;
>         }
> +       /* you can only watch an inode if you have read permissions on it=
 */
> +       ret =3D path_permission(&path, MAY_READ);
> +       if (ret)
> +               goto path_put_and_out;
> +
> +       ret =3D security_path_notify(&path, mask, obj_type);
> +       if (ret)
> +               goto path_put_and_out;
>
>         if (fid_mode) {
>                 ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid);

If we do accept your argument that security_path_notify() should be
after fanotify_events_supported(). Why not also after fanotify_test_fsid()
and fanotify_test_fid()?

The suggested change of behavior seems arbitrary to me.

Thanks,
Amir.

