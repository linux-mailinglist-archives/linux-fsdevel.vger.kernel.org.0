Return-Path: <linux-fsdevel+bounces-29804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61DA97E171
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3114F1F21390
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3919309C;
	Sun, 22 Sep 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EinX8U8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE213B28D
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727006709; cv=none; b=PS7RHkTDJtHK89xdjItTONSH1gk3zaOcGlotSnOMU47zIdiHZl6UYDHoan1UDLaMfDdgx0rsaEuuz6Y8qW1mSyVZWxZ/ILZLb5BlfXiAUAqE32R5nQVSCTLkC1i1v74YtcvdS1AVKKO1zsdF6mJ6y3IY7VLx0aiRlXdY/FZgmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727006709; c=relaxed/simple;
	bh=04qoBtAnuv/GzWRMkyTmksM8uYelKBjAXypAUGUEb+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ik/Z1Yabdb3a81HzYAAU4lbiuJ5maMLZjePSe+uABiER/q+VokrunJ0G79QTo91GnOaTU3iBV/4z/xgGLz+OcIjnrMt3yFOqtOgbqLCmqE51WnQo9Hcw6GCkig+Y10C3TjPM2wfuEERqS8aWO8Fwq69ziBCrzCFGHrdaJru24Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EinX8U8n; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99eee4a5bso313246985a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727006707; x=1727611507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGjOSuyLbdig1HW4Hu6+Wbzuzt5HatQbAFQB2ceqVwA=;
        b=EinX8U8nBfhg1EW+XIHDahxOsn0qxzAZAvb831CowdN8HH2FEx9BHfKvoI8QcihUUp
         GHquk6BtQLn/66MvoxB09Kz53pMF8kAed8LanaMvM/YgjhI3hFhn61YgabVSNIhElwLr
         s9mguqWeVEckVjNHjsI1bSCviFT7k9FdEzM3e3shmhWPhfem4wrHrYizjTE8EQ+fkpbY
         AWwmgG9hVjdjUFL0Hz9eQaeDKRAmMnTi6VRap1LSIzLpVMS9jXOLRLBKFkNK4c4GJYEB
         FbtzuEr2gfMXd4MOWL/UVtXSG1rz+C+c+nLcAdRtw6cbUP1CsNHJdKMNeBCZgt8jRX29
         G82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727006707; x=1727611507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGjOSuyLbdig1HW4Hu6+Wbzuzt5HatQbAFQB2ceqVwA=;
        b=L0NNnFQ2vL9M+X+BuGhx7UJ5/RA08D7mjP68rwJEn1aBqN2RF0tE3/aYV+fBac4OLt
         iMXFyYfDu+/TrOmBHlg70JaACF9k5XWSbm381+dzBWxC+LP6FiOpzT8Lk+PW1Qi9CD/v
         GCe9VUY2CUDs9ugf75R+Vh8uJp1cjiX9s+sBDTmKBmuLb8xbHcijrdm63JbC1SsJCQyN
         z34/stqr8BCeU7MWhUbFilRji55YcMfYrWjj4y95Vm8DOyjPpMl5o9TyS9PML7dWITPd
         vRndJiwNsiGKzPB9ztTxEDNvNkYzsh7zTXKkV6CL6thCBckXWvF+EgzVEfjGNQ526N8t
         8nAw==
X-Gm-Message-State: AOJu0Yxl1yMgFh4aWRyCPjZiRhjMLutojvysYt5V64AX6x3/4+x4G92B
	lWNy5jC4V/CaweRlYWO+BUTOV/FDkOc2t+xyw85NVUUEeOQYwq/X3v867MMfW17/wlcRue6dTxN
	LuOI4Ab2268nJ5GA2cYwDSVNbFD4=
X-Google-Smtp-Source: AGHT+IEs9j/cts4f/mLwHdMNKalocxe1fYaR3Amc80YDqEaJAmMOVx/aU6zxQS6I5TQQRIgEutf7ZxoSkOdDiJSL4ZU=
X-Received: by 2002:a05:6214:ca:b0:6c7:c75c:a734 with SMTP id
 6a1803df08f44-6c7c75ca865mr64437226d6.0.1727006707005; Sun, 22 Sep 2024
 05:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913083242.28055-1-laoar.shao@gmail.com>
In-Reply-To: <20240913083242.28055-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 22 Sep 2024 20:04:30 +0800
Message-ID: <CALOAHbBp691X-0XaMam2y6zAdkmmP0AvkP=3Yv_g4+f7j2T68Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add a sysctl for automated deletion of dentry
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:32=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
> file") introduced an unconditional deletion of the associated dentry when=
 a
> file is removed. However, this led to performance regressions in specific
> benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
> commit 4a4be1ad3a6e ("Revert "vfs: Delete the associated dentry when
> deleting a file"").
>
> This patch seeks to reintroduce the concept conditionally, where the
> associated dentry is deleted only when the user explicitly opts for it
> during file removal. A new sysctl fs.automated_deletion_of_dentry is
> added for this purpose. Its default value is set to 0.
>
> There are practical use cases for this proactive dentry reclamation.
> Besides the Elasticsearch use case mentioned in commit 681ce8623567,
> additional examples have surfaced in our production environment. For
> instance, in video rendering services that continuously generate temporar=
y
> files, upload them to persistent storage servers, and then delete them, a
> large number of negative dentries=E2=80=94serving no useful purpose=E2=80=
=94accumulate.
> Users in such cases would benefit from proactively reclaiming these
> negative dentries.
>
> Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.=
sang@intel.com [0]
> Link: https://lore.kernel.org/all/20240912-programm-umgibt-a1145fa73bb6@b=
rauner/
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/dcache.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 3d8daaecb6d1..ffd2cae2ba8d 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -130,6 +130,7 @@ struct dentry_stat_t {
>  static DEFINE_PER_CPU(long, nr_dentry);
>  static DEFINE_PER_CPU(long, nr_dentry_unused);
>  static DEFINE_PER_CPU(long, nr_dentry_negative);
> +static int automated_deletion_of_dentry;
>
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
>  /* Statistics gathering. */
> @@ -194,6 +195,15 @@ static struct ctl_table fs_dcache_sysctls[] =3D {
>                 .mode           =3D 0444,
>                 .proc_handler   =3D proc_nr_dentry,
>         },
> +       {
> +               .procname       =3D "automated_deletion_of_dentry",
> +               .data           =3D &automated_deletion_of_dentry,
> +               .maxlen         =3D sizeof(automated_deletion_of_dentry),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>  };
>
>  static int __init init_fs_dcache_sysctls(void)
> @@ -2394,6 +2404,8 @@ void d_delete(struct dentry * dentry)
>          * Are we the only user?
>          */
>         if (dentry->d_lockref.count =3D=3D 1) {
> +               if (automated_deletion_of_dentry)
> +                       __d_drop(dentry);
>                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
>                 dentry_unlink_inode(dentry);
>         } else {
> --
> 2.43.5
>

Gently ping.  Any feedback on this change?

--
Regards
Yafang

