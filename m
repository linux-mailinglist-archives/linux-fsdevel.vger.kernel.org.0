Return-Path: <linux-fsdevel+bounces-43089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D4A4DD3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CD3A5B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196EA201004;
	Tue,  4 Mar 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYZ0d05B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B93D561;
	Tue,  4 Mar 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089472; cv=none; b=H9LmrjhykNwZVlhn9wsy3/Ncxr2wZiXBJ4r5rOdau2x2hc7uiFoy4SYzmOzjkuPJsS8BJ3N4DkYUt7l9WoFtD7iHWQpH4R+Ylwd83Xzub0sJMcJlLZik/2PTGxaoiEv59alnRqjk25S8d5O0AlaEHT287gHvpZb8dQnkpSw6fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089472; c=relaxed/simple;
	bh=7ypZWnjPrV7w6TeeTckAB6eHJ6/xsg2qkTe/LybKhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcTxkiiS3kUsuCCTOqAK2UZOLK2WyZ27apyPE2Za+XEjVZW2eWLNMnYStNEovkaGcuRANxaufqjeWyhsUioYFkihUFJltrPvjv/7nop44x7G7+3f7zJcmXpqDrIVZztunfDSZmuKDrjeB2AEe5JqcZp4ktSuR1apwReFk/PrRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYZ0d05B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e538388dd1so3094210a12.1;
        Tue, 04 Mar 2025 03:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089469; x=1741694269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFfYVSo4B+UXub+GZI2qGn4jwqa9bMIxNlJj7fXOijE=;
        b=GYZ0d05BQ7Rbm6godUG0RiCglK0lqr2pH6CgfQB7n+pPKa44BD3SUo6pDDt/aLqdfE
         BPkMqQfTOT2cqoyfMwBP4eelEEqhKX3LMQRL7oTR1ipjZrtJ2sY/m3dR1/qjoB8h+Eqv
         hsqnZZ6VFLRw+SzbL/kDuAN/dIy+xeSjZ+R/4QPssPWU/5CcJeDJKk3N1p5/ygPFdCh+
         5FgnVyY0z7zLuXxLRWNtXh8k03DT0R/C7o8VvZrCLnLB59hCYDBp69I871VWFzi2tpTj
         AT214sOk005Tq+Zl0luOqOTnbrLUcy75m8k3EzwKVCLFNuBR43g3NPUureJ1fiH1q7pZ
         5YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089469; x=1741694269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFfYVSo4B+UXub+GZI2qGn4jwqa9bMIxNlJj7fXOijE=;
        b=FDM6rszPoNsk95OQwtu6moaWDehM3s+pvEkakuRimy4OmpB+9f4Kky3vfOCQlLhgKa
         Rx222q/kCPM7J3aD0/yBZ9h524JfSh0eRtkVWEjkDGaXMEYYX30cbVuTt92ceIE+y5Gp
         tAFekGefj3pvFTqckC998yYHiAWj2SCOOqJWhQ1Kuba6rHRPBkCLivvwavwUXCYNImWK
         EHyuy9nB8DqfcEKKt9VwUowUy2e5B/TWZhOGFkTlGMwW1D0izW1BuQzLqZDnxZxoGWbN
         PIKoDAt03z6/TEb+SfhTkq8bf2lNvnQ7L30QgeJ5k11PJA2Ggqijhtklk/0nPMnIObd1
         /eGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBldQktjgO8kLyCIjolGrazeeof9aCyoJUR1viBMYw5CLP2siAd54g5KfTBIhCfXS15uacg/dsQ3CpcFYh@vger.kernel.org, AJvYcCXXIZ44Un0U0+rSDvJenAW4qlq0qb5CC1odQXiefUzDF5cMs80IE+SrK6kt33P57iecOT0wBeLs8qH76+KU@vger.kernel.org
X-Gm-Message-State: AOJu0YygcgT0bMUi4t17hu3zkG7mG93O8lKm25BFFGULI34dzUzFDcpF
	ryc3q4zzL47dAW0yZidoRtQS3cXSu78OFVtRw3RjIN9acS/XFqNIZpDzpP76T4HThuppKyz/XUN
	Se7I1N+Npqf1j0QhH7yjhh8BTJp8=
X-Gm-Gg: ASbGncsLZNdQgy0bvXnAixFGwLEXQvAz8yQenIiA+UUQyHrQauOXrniQ311TlSQir0K
	419lGL9B339iBI2axJY8h1q8L+UJPp8UV1/FqeMWXRzGXaHYvj1wQtGKVCKjca06KliU6KAX0cO
	OJU5iIyXIzysR2eki6t84TnvpMsg==
X-Google-Smtp-Source: AGHT+IG/gH8xF2QSpMAqKv1eZxLbdC2fhOMhNMkCv6JUkbQ36wboE4Ypr1n30rVoJmN+b7m089jSauZwbUd5xsRhN3g=
X-Received: by 2002:a17:907:7fa6:b0:abf:615d:58c2 with SMTP id
 a640c23a62f3a-abf615d6016mr1192362066b.34.1741089468592; Tue, 04 Mar 2025
 03:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304080044.7623-1-ImanDevel@gmail.com>
In-Reply-To: <20250304080044.7623-1-ImanDevel@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Mar 2025 12:57:36 +0100
X-Gm-Features: AQ5f1JoU6Vvq5Hm7n116SaG8VrOOy_nKyTWmNXwcxfBElDzY3PzC1Sz2EnC7Mxc
Message-ID: <CAOQ4uxiaY9cZFpj4m65SrAVXm7MqB2OFSfyH5D03hEwmdtiBVQ@mail.gmail.com>
Subject: Re: [PATCH] inotify: disallow watches on unsupported filesystems
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:59=E2=80=AFAM Seyediman Seyedarab <imandevel@gmail=
.com> wrote:
>
> currently, inotify_add_watch() allows adding watches on filesystems
> where inotify does not work correctly, without returning an explicit
> error. This behavior is misleading and can cause confusion for users
> expecting inotify to work on a certain filesystem.

That maybe so, but it's not that inotify does not work at all,
in fact it probably works most of the time for those fs,
so there may be users setting inotify watches on those fs,
so it is not right to regress those users.

>
> This patch explicitly rejects inotify usage on filesystems where it
> is known to be unreliable, such as sysfs, procfs, overlayfs, 9p, fuse,
> and others.

Where did you get this list of fs from?
Why do you claim that inotify does not work on overlayfs?
Specifically, there are two LTP tests inotify07 and inotify08
that test inotify over overlayfs.

This makes me question other fs on your list.

>
> By returning -EOPNOTSUPP, the limitation is made explicit, preventing
> users from making incorrect assumptions about inotify behavior.
>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
>  fs/notify/inotify/inotify_user.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify=
_user.c
> index b372fb2c56bd..9b96438f4d46 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -87,6 +87,13 @@ static const struct ctl_table inotify_table[] =3D {
>         },
>  };
>
> +static const unsigned long unwatchable_fs[] =3D {
> +       PROC_SUPER_MAGIC,      SYSFS_MAGIC,       TRACEFS_MAGIC,
> +       DEBUGFS_MAGIC,        CGROUP_SUPER_MAGIC, SECURITYFS_MAGIC,
> +       RAMFS_MAGIC,          DEVPTS_SUPER_MAGIC, BPF_FS_MAGIC,
> +       OVERLAYFS_SUPER_MAGIC, FUSE_SUPER_MAGIC,   NFS_SUPER_MAGIC
> +};
> +
>  static void __init inotify_sysctls_init(void)
>  {
>         register_sysctl("fs/inotify", inotify_table);
> @@ -690,6 +697,14 @@ static struct fsnotify_group *inotify_new_group(unsi=
gned int max_events)
>  }
>
>
> +static inline bool is_unwatchable_fs(struct inode *inode)
> +{
> +       for (int i =3D 0; i < ARRAY_SIZE(unwatchable_fs); i++)
> +               if (inode->i_sb->s_magic =3D=3D unwatchable_fs[i])
> +                       return true;
> +       return false;
> +}

This is not a good practice for black listing fs.

See commit 0b3b094ac9a7b ("fanotify: Disallow permission events
for proc filesystem") for a better practice, but again, we cannot just
stop supporting inotify on fs where it was supported.

The assumption with the commit above was that setting permission
events on procfs is possible, but nobody (except for fuzzers) really does t=
hat
and if we have found out that there were actual users that do it, we
would have needed to revert that commit.

Thanks,
Amir.

