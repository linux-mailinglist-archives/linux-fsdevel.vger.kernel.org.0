Return-Path: <linux-fsdevel+bounces-28702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E196D1ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421C6286ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6C193422;
	Thu,  5 Sep 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwu9wWq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159338F66;
	Thu,  5 Sep 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524636; cv=none; b=Ag3P/BYUcOy2PYgjwUWg5MWVwYRjkRWx05N3IDovhZNriJhL3zcSaCf14QcKPjFd4xJHTBD+5+gxu/DeG6XfvyWANpnsFhimaiovRp/n6FAK5wZn4uU4mZnLw2CCpYzg+MXJdlK1le1nGNr/k/h/kwWILFp9q/iC4673Djsq3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524636; c=relaxed/simple;
	bh=TwKwteQ9GQakcBA9WOXf4pXII2GxlwD14AaG4Apu1qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVNOTblPSQqEgkHfSY4h8OOc/esL570UwhBA2fYeEzhDWWafAOihPlCsRBq2AFjnEtw4tJWKezhBYk2cWDrBsLIvNA54U0LGgRjVe98Bm+gDJpvD3dcUEO1Xk8CYFy2++hDQdfxyBSjPQOkze3nPKi0tSadFr2QGRVFj+zGLCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwu9wWq0; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f6a7c4dcdso350164a34.1;
        Thu, 05 Sep 2024 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725524634; x=1726129434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chdOXpxl19grJ0lyYlh2nBdFQ3cbblx2XVMM1r+6Sk0=;
        b=lwu9wWq0aJ2UPjSKmpRbRbrLaswasJVCK7vAg0qUHECkgLJr/DJHwm6mMHzzCE1c1X
         QVFiM8+m2QI+E5lsVMnQ/MqDbFNX0b9h6vE3b1TkpS9cz6R5FlVC+nnGavo5EETxyNy+
         AreFyON2YSn2mwz6Ob295QZGvj0j8TPR+vpg2jxmSbt40MNMPH1MLeq0ygq5OXNv2rP1
         WVpytv6o4WT4VndDB4RAzmX1LtDOEsrJJhjVtw/G6yOjIgwC/u21I/P8lA1G1WBS+fGt
         HCRndgm0KaEG0WP8FJvyNqkDVblZgJI6nuB2war4k1+TuzB6D2k4ObuRcCn1VRPZFr6n
         ZHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524634; x=1726129434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chdOXpxl19grJ0lyYlh2nBdFQ3cbblx2XVMM1r+6Sk0=;
        b=mC8ePawcEfqP0casCM7liDj3AWnM08ZHhdwHgkmaL59o7U3/tzECaDqaXF2McJXubv
         M99ERKvqr3NHlxzP39TiBGUv603cjkH20KrWoCRjHm1wS4fcyq8tA9JWwWAwy+9Z3KVD
         CC6LOgk+n3MQyHwdmWseJzykyUcPgHqSS1qeKTdBRKKjC8IRG8ewX2OOBny7NXUXFADK
         kz0hp0lShE9KvDVJ/nDcq3uOB6CT9LnqpZdVLl+jUATzrAE7HbJGswbzkqazOgngS4y/
         Q4xooDR/xNVcp0/Tm4i8StDS7WmjpLG+vMl08kR/N9K/XTx+UQpKpPncI1gehd5AwZxV
         /rew==
X-Forwarded-Encrypted: i=1; AJvYcCVrKe6iqbkiWzIXRmQV+xzruAe+ljrePSVKPSUjsivpU8yZU/KBh7OGxACU3KS5Y0SGuXPYLXO3pb56NYnV4Q==@vger.kernel.org, AJvYcCVwrjo+pEmZZUd3pEY/yHnSsxZPkUPTcc7mz/ETvXLyE6XKSCpzN1YmlXDAX0OwFLS4/RrDyG+rZ87eb4M=@vger.kernel.org, AJvYcCWD1swA//Fht3X7P1h+uHaeqLkJU1Lfk1/fLKLkWqBORza3sAe85Fx5qTzqaF1NfEsYiWONH/tC2aVHVum4+Q==@vger.kernel.org, AJvYcCXlmYpPsTjUy3Holan15xs8HOfJORUkHu6npTtoWIEPyxu53r1vdfTicNDliV3AuleH1TP8VZjXQy0g@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJC6apvWMKREGy20rDZBkdnuYI1zeVLblHtKILrJZXDV0MShr
	88s5UXrCCo2R27ZPhSldQi75JJfVHp6XTY243Hw9/ceXtqQSfwhQdfgSU8rl3iUIjKD64bw9dP1
	Bp69NRIkKJQzoyj9MQH7JIcgBR0Q=
X-Google-Smtp-Source: AGHT+IE6p7wq/aGZc71KmWg1q+RkZP/2KfOy+tFjCt8EugCjNDM0MIPDzBeTnbCvcWLRpy4UVsXFGx3EjMXkydC/8RI=
X-Received: by 2002:a05:6830:90e:b0:710:adbb:ff33 with SMTP id
 46e09a7af769-710af69eae6mr7229761a34.10.1725524633873; Thu, 05 Sep 2024
 01:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <367fe83ae53839b1e88dc00b5b420035496d28ff.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <367fe83ae53839b1e88dc00b5b420035496d28ff.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:23:41 +0200
Message-ID: <CAOQ4uxjteVH2kX2zORBaudu-EVLQRWxVjHvdgoXhR=ji8yZwDg@mail.gmail.com>
Subject: Re: [PATCH v5 17/18] btrfs: disable defrag on pre-content watched files
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We queue up inodes to be defrag'ed asynchronously, which means we do not
> have their original file for readahead.  This means that the code to
> skip readahead on pre-content watched files will not run, and we could
> potentially read in empty pages.
>
> Handle this corner case by disabling defrag on files that are currently
> being watched for pre-content events.

IIUC, you are disabling the *start* of async defrag.
What happens if defrag has already started and then a pre-content
watch is set up?

Do we care about this corner of a corner case?

Thanks,
Amir.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e0a664b8a46a..529f7416814f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2640,6 +2640,15 @@ static int btrfs_ioctl_defrag(struct file *file, v=
oid __user *argp)
>                         goto out;
>                 }
>
> +               /*
> +                * Don't allow defrag on pre-content watched files, as it=
 could
> +                * populate the page cache with 0's via readahead.
> +                */
> +               if (fsnotify_file_has_pre_content_watches(file)) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +
>                 if (argp) {
>                         if (copy_from_user(&range, argp, sizeof(range))) =
{
>                                 ret =3D -EFAULT;
> --
> 2.43.0
>

