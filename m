Return-Path: <linux-fsdevel+bounces-48536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E45AB0ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F109E0FBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32426B08B;
	Fri,  9 May 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WDrcJGZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DB26AAB8;
	Fri,  9 May 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772846; cv=none; b=ZVs0Exj1aEcPEoYCuukdV85jxxo55PjuPM+8GHENvZhXtR9yD5VbXIRsIYqevOt5qAItqvV4OBT69cwtbJxo/3UnJqP1QTyp24OQxvVVGLbtyphkvVq+LJ9+dLGQh9yZnQ37t9Uzunv39QyEzzKvRT7JH8/e5Flob+On6WXMSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772846; c=relaxed/simple;
	bh=fxFHM0v/ka3OQUBI82UzTNhBtodXGXXGvy6pJYC+zm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZWtOWMMNYa78s7qaT3ITfvZEgdxnlCDkkQyulWbJIoDVcnxTIhk2sXBmRnr4VE2pyI40IfIQxHIQVMOrn9HwOYzCSuWiZjcKz+7VAVcEQkKGHXwE1/LbnvpDa9WUVrZUAh3NegvO4/ERWJJHB+UtomgXa+xcXBYsmFdCO07ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WDrcJGZo; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746772830;
	bh=ihh5ov5KNpxuRkZgVS2WL0voYFPXwHmFK1A25R6l4s8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=WDrcJGZoqfFu4BM0j0HqkiUNcfToAXs91ynhU/Rez7iz1gkgvtNjiSrUQPC5hIV/n
	 3Rlxl6FjQw2RciCFXmwyHPo+g7CdmxV2THVmd/jjtDQSinNh8nEZWTMh9Ubw5jLuRr
	 IGa51LFdhWOwLqTfbGZpvxsQeRU6IMSOVojnAjlo=
X-QQ-mid: esmtpsz16t1746772827te5f6ae54
X-QQ-Originating-IP: xj3l6DJxrjkt4qTlt77TClYLZub6HSSXCznRsEI96bA=
Received: from mail-yw1-f178.google.com ( [209.85.128.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 14:40:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8370490462894577466
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7091d7244e8so17856677b3.3;
        Thu, 08 May 2025 23:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUFHpWh6X22vLYxJwFgU/drslJu6behU+H/h3BhjtiOPBczK/gUqzgPydcnJ2Nw+KH8NBHp+XpeD1UD7k4@vger.kernel.org, AJvYcCVBpor63sNamTkUeKz6BsxJ931/+Fx7vjPKKQeZSVu/jUfe1n6/sFppiGV3NxggGLeU9bqinBbp+6g6s863@vger.kernel.org
X-Gm-Message-State: AOJu0YyciT3g6/zNh3BmLTWi7QyzXwoSK4iadhlxCZzeC39ooaRTbWnt
	F9VLKfNWXVH+idWDg38/CwxlOdEDkiIccfNanVya72hf138uEpbQ425DPlcV1pOUabvr+ZqAUWl
	b90LtE/Kfo8VSmLUGIkP4I6lQR74=
X-Google-Smtp-Source: AGHT+IFDWb8362FrDmkSJcfKLIT9BCU/J1FTe+b0rRaNN0UQUsLyveoFtB5VWAftvXNt2sd2zZ+lmxNaUm68KNiQXLI=
X-Received: by 2002:a05:690c:74c5:b0:708:ca91:d583 with SMTP id
 00721157ae682-70a3fb1461emr30415607b3.25.1746772825216; Thu, 08 May 2025
 23:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-3-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-3-393761f9b683@uniontech.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 14:40:14 +0800
X-Gmail-Original-Message-ID: <07F6D6C67DF1D1A0+CAC1kPDOdDdPQVKs0C-LmgT1_MGBWbFqy4F+5TeunYBkA=xq7+Q@mail.gmail.com>
X-Gm-Features: ATxdqUE25ZeQ5xIHSbFb-ApRFoPgWAHDZSxksRoyReXXX_uje8AZxeHlMjW1Ym8
Message-ID: <CAC1kPDOdDdPQVKs0C-LmgT1_MGBWbFqy4F+5TeunYBkA=xq7+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: fuse: add more information to fdinfo
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Np4vjJaFyq9jHr2M3gGr6lOltbJQO+TaSWN8jIZnpdslFFeoOYjHIOcA
	V8oOtFPrc2XWEmYxmY92t6Xpp7RY9y/lmnN6q4AD/bsYMK32ykR5NBQ+9TSbc09FN6Uu3pt
	Jx6BfS9mHyqW0rzLf/Rc7ekVvhuLAdpkYkCbMkdC1Kbt1X3LfcWSCfsPeVqa+MWI50BObru
	N2Z3xyc3O+XbxVjwp7f5GjtoSutBvUBaTApbCJDv6jdWWFiRFmLDTbQeboHNjYIRVufIuIT
	dFMpL2PUEQEnPM+XtKluR/q8EN55a+x8QrtLJayoRyp0lBSZNn4LXaAiK42mOZ4QrLst9Z4
	frk50+F9IwFgicFdukgcyECeo+yPJkNRjA2G+rfEMjmD7aQpv/rad6UOaRfnlwCM+ZnRGD5
	Prii5jl5Qne1jtVCh5lpQDaY9076mYNQKf2ThaRRW4x/thF54vfhgshhWDMQzLmd8t1QKoI
	+uKAGsl3PoyUB6evvl6kVmxx91c0JddV0O8PdJFmi8su4CmjVgyzUoiY+RZ64PjiQBIMOs2
	SJA/msakcMtuEk5wcf3YlPLq/xUQKOw/qMzi7Uy/xAQf5Tb7iYq92R36/JpRfj96FJ+pdQ+
	HCX4mBtV/nwrOzck4xEeDZsotLzCaxjykrt0vBtwhUeDLzl0iOOBVnxGVkiDLeqF2N9GXwX
	RGUwoZkQh44ugM7UpMMe2Kj2uwmuJREzp9t3hrfYX/DGheDuf9TDq3p2gydEqSvtdUxH7oO
	U1wqdaRgje2V50TwuOerRV6FH2FG8Xq3QMgzRg07o6+0hfQBS5vxaPFIKw7fQZPilaF2yZL
	orMxNUrl3W/CGr8T+uMdjaxTV8u0WS+ShZ829heTU1m4mP5D8s5gblm89GWyJZJXlrQI1cv
	cD0P6A0qo4+qI5xWg7CoMfEQdogYUClAWuS9Jjvy5m1SExOyCqzK5K0Ll6Xxsb/jNFSr5cd
	Osgft/IH80h+5ZyS7c4tmnRIk8Hxp0QK6VEo5lRUqd9hHtKfnGE6LMQYIo2XongA3wplNcz
	aVBbQyRyfss0SjWIGTVsCBc3kj4C5ZmRc/8Yn5WxEC1LgGjHDo
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 2:34=E2=80=AFPM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> This commit add fuse connection device id, open_flags and backing
> files, to fdinfo of opened fuse files.
>
> Related discussions can be found at links below.
>
> Link: https://lore.kernel.org/all/CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_=
KvP6ZOe2KVBw@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAOQ4uxgkg0uOuAWO2wOPNkMmD9wqd5wMX+gTfC=
T-zVHBC8CkZg@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  fs/fuse/file.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 754378dd9f7159f20fde6376962d45c4c706b868..1e54965780e9d625918c22a3d=
ea48ba5a9a5ed1b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -8,6 +8,8 @@
>
>  #include "fuse_i.h"
>
> +#include "linux/idr.h"
> +#include "linux/rcupdate.h"
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -3392,6 +3394,21 @@ static ssize_t fuse_copy_file_range(struct file *s=
rc_file, loff_t src_off,
>         return ret;
>  }
>
> +static void fuse_file_show_fdinfo(struct seq_file *seq, struct file *f)
> +{
> +       struct fuse_file *ff =3D f->private_data;
> +       struct fuse_conn *fc =3D ff->fm->fc;
> +       struct file *backing_file =3D fuse_file_passthrough(ff);
> +
> +       seq_printf(seq, "fuse conn:%u open_flags:%u\n", fc->dev, ff->open=
_flags);

Note: The fc->dev is already accessible to userspace.
The mnt_id field in /proc/PID/fdinfo/FD references a mount,
which can be found in /proc/PID/mountinfo.

And this file includes the device ID.

> +
> +       if (backing_file) {
> +               seq_puts(seq, "fuse backing_file: ");
> +               seq_file_path(seq, backing_file, " \t\n\\");
> +               seq_puts(seq, "\n");
> +       }
> +}
> +
>  static const struct file_operations fuse_file_operations =3D {
>         .llseek         =3D fuse_file_llseek,
>         .read_iter      =3D fuse_file_read_iter,
> @@ -3411,6 +3428,9 @@ static const struct file_operations fuse_file_opera=
tions =3D {
>         .poll           =3D fuse_file_poll,
>         .fallocate      =3D fuse_file_fallocate,
>         .copy_file_range =3D fuse_copy_file_range,
> +#ifdef CONFIG_PROC_FS
> +       .show_fdinfo    =3D fuse_file_show_fdinfo,
> +#endif
>  };
>
>  static const struct address_space_operations fuse_file_aops  =3D {
>
> --
> 2.43.0
>
>
>
>

