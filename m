Return-Path: <linux-fsdevel+bounces-34894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A288F9CDD79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587CA1F218BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420811B86F7;
	Fri, 15 Nov 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+WseG+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D71B6D15;
	Fri, 15 Nov 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670097; cv=none; b=RoDmW/naP4BUVlvOHj57CbPWeU8bTELIA67UEUmdnYGCOaanSta84bySs/3SXmF1soSUi1Be2swzSPuwNGK8kMthAqDJHau+qowF0X4Sws9qu9FqRmiekYWUipvRESIrHXzmtEtBkdsXYewKbcYj5IRsx1bL3WV5zldUB6wSAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670097; c=relaxed/simple;
	bh=6xRXlMoqZaEk27UKmAB8/FPa+NVahU2FIfrFAXjUs5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIAnO+cgXmaeWbOfoMin0sFs+CZ0N5RwxW18m0UQ5Q9ML3ar3K1enhFIl1P+JDblWPkICPej6tdzrM12p8N9zz/LTwv8nBVHJ2KULQzzLtN6FRGPbmyJGHK6OmRXjCMijUogmxp71UWFC3pLn7KhqSDzUoiisGyTYRmuyVkB35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+WseG+8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso222329366b.3;
        Fri, 15 Nov 2024 03:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731670094; x=1732274894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AN2iU5YfWRjM+o8SXWibldu6ebg17KH2JFxv44/XqA=;
        b=g+WseG+8r+rxf6tW9pc4abi6Iyk1ty1SX4rcAGcFKfAFKMXq7iAhuOBI+w0x4tQdzw
         VzKy+BsS3b96QcVvSp42sUsrDOeu4ZhSLCNeY6eV73c648ZoUmKfzmKuxZA8NUxgLmex
         miJKpp/GanzM1hDHVASpJ4JmNI+BxtJiFgpEsGRiIDA30L422r5B054ex629D8MM2FA9
         x6n6gdehkKHQZ91kQjN27ZdJstSL1az7bnmg+F6L1FwwQHGgNiAY67zJNlrfpSa643g/
         aJE3pYw0p+oExt+BMktsIblmGaOAfFkXSNsMhs6fq1EGmtk5Qyok8lmA73ve5ywxQfIn
         a1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670094; x=1732274894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AN2iU5YfWRjM+o8SXWibldu6ebg17KH2JFxv44/XqA=;
        b=EWIULi1m0zfxh4G6HOivNpA3ToFcruq1t2u2vSttOzW1wsIgSA/P/BKxWZGrVwMJ8N
         ACZ7MGvBybgPO5wXrUGusZ+Gs2oIsmxc4DFgfSWBbdwHc4icbIvY0J3L+Ezp7zltmVLh
         PA6CKmakmeF5C6FmJzAr0mXKItiW1mTE8h0uKvM4tlil0FFNuTuPhQIM/Amb2eMAYJHb
         6xoYx0G2mcel9o3jyGxvUhfLnqbSGG4xKSrxuAXuvEBhqBFIjH8TSoHwI/zugUPOZZow
         3KoxIj3IkXxl+NkEnI/bGzxbToPXl/V+0LL9JZ+CmWmHD70k0lJ/Zxb8hFlhZUdEBrmf
         OWOA==
X-Forwarded-Encrypted: i=1; AJvYcCU18QOuQ12ecFv+kfk4sQ7r1vuOIlsVlZWaLbkIw5zp16/zuWrgsQDUxgdqwzNWFyNZdztYT8z7ZVsN@vger.kernel.org, AJvYcCVMlsrI3bMWjq6gsRcYQDXhx+/Ba2YJ8o+TmEVXhOQNBjYWS91SclZIEqY45mZolwmWRSZXd4rlOfYFb0EEVw==@vger.kernel.org, AJvYcCX/LYxaIDk8txagYlis9QrBpANdL91ApNBbuA1hT/2480RcWwq8vk2jXJcdkYu9AFwDV+z+LWaF/Pk+EQ==@vger.kernel.org, AJvYcCXDSeg5nQEXT7RjbcTEk621NgaVnZTX/+y4GXhYXt2Wx7HLsVgTJXiOkCyFIsKD9HiY4cAC/d36ONTMAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyEuNIW6ZA27pj+iamWzsJhC2EpHAUcvOOXLiwahyw/dNC4wg
	zxKyZoGGElJfeoMnX7kthLgA/2tY4XJaPaS2UoDXEjt2CGrpDcWMH8drnLfiGTDd0yh0HktvwiP
	HPOzbQkgTgGbSo5zlS6KBmRQhoYc=
X-Google-Smtp-Source: AGHT+IGYypC0GVLasX8uBhhPmCl/H0ZB0+SeUSSAkPY0iN71VwzuX38UCdXokyIF4LPVD0+930tknm4D4ZOv3FQr9fI=
X-Received: by 2002:a17:907:6ea4:b0:a99:ed0c:1d6 with SMTP id
 a640c23a62f3a-aa48355271emr183894066b.49.1731670092423; Fri, 15 Nov 2024
 03:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <8de8e335e07502f31011a18ec91583467dff51eb.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <8de8e335e07502f31011a18ec91583467dff51eb.1731433903.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 12:28:01 +0100
Message-ID: <CAOQ4uxhkPJ=atVPeQ3PsOKps3w8qxJgpvMR1wwT=-onc4KLV5Q@mail.gmail.com>
Subject: Re: [PATCH v7 09/18] fanotify: introduce FAN_PRE_ACCESS permission event
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:56=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
>
> Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> in the context of the event handler.
>
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first read access.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  3 ++-
>  fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
>  include/linux/fanotify.h           | 14 ++++++++++----
>  include/uapi/linux/fanotify.h      |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 2e6ba94ec405..da6c3c1c7edf 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -916,8 +916,9 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM !=3D FS_OPEN_EXEC_PERM);
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
> +       BUILD_BUG_ON(FAN_PRE_ACCESS !=3D FS_PRE_ACCESS);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 22);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9cc4a9ac1515..2ec0cc9c85cf 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1633,11 +1633,23 @@ static int fanotify_events_supported(struct fsnot=
ify_group *group,
>                                      unsigned int flags)
>  {
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> +       bool is_dir =3D d_is_dir(path->dentry);
>         /* Strict validation of events in non-dir inode mask with v5.17+ =
APIs */
>         bool strict_dir_events =3D FAN_GROUP_FLAG(group, FAN_REPORT_TARGE=
T_FID) ||
>                                  (mask & FAN_RENAME) ||
>                                  (flags & FAN_MARK_IGNORE);
>
> +       /*
> +        * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> +        * and they are only supported on regular files and directories.
> +        */
> +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +               if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> +                       return -EINVAL;

Should we make this return -EOPNOTSUPP?

This way the LTP test could report the accurate message
"FAN_PRE_ACCESS not supported in kernel" vs.
"FAN_PRE_ACCESS not supported on XXX filesystem"

Thanks,
Amir.

